<?php

class SendController extends BaseController {

    public function beforeExecuteRoute() {
        // return to login if user is logged out
        Authenticator::enforce_login();
    }

    public function campaignsAction() {
        $campaigns = Campaigns::find([
            'order' =>
                'campaign_id desc'
        ]);

        $this->view->setVars([
            'campaigns' => $campaigns
        ]);
    }

    public function delete_campaignAction($campaign_id) {
        // get the campaign information
        $campaign = Campaigns::findFirst($campaign_id);

        if (!$campaign) {
            // invalid campaign sent
            $this->flashSession->error('Campaign was not found');

            return $this->response->redirect('send/campaigns');
        }

        try {
            $manager = new \Phalcon\Mvc\Model\Transaction\Manager();
            $transaction = $manager->get();

            $campaign->setTransaction($transaction);

            if (!$campaign->delete()) {
                $this->flashSession->error('Could not delete this campaign at this time');
                $transaction->rollback();
            }

            try {
                // create a new mailgun instance
                $mg = new MailGunAPI($campaign->domain->domain);

                // attempt to create the campaign
                $mg->delete_campaign($campaign->mg_campaign_id);
            } catch (Exception $e) {
                // domain doesn't exist, maybe
                $this->flashSession->error(
                    'Mailgun error occurred, usual cause: Domain not added to Mailgun or invalid Campaign ID');

                $transaction->rollback();
            }

            // commit the changes up to this point
            $transaction->commit();

            // success
            $this->flashSession->success('Campaign was deleted successfully');
        } catch (Exception $e) { }

        return $this->response->redirect('send/campaigns');
    }

    public function create_campaignAction() {
        if ($this->request->isPost()) {
            try {
                $manager = new \Phalcon\Mvc\Model\Transaction\Manager();
                $transaction = $manager->get();

                $campaign = new Campaigns();
                $campaign->setTransaction($transaction);
                $campaign->domain_id    = $this->request->getPost('domain_id');
                $campaign->name         = $this->request->getPost('name');
                $campaign->description  = $this->request->getPost('description');

                if (!$campaign->create()) {
                    $this->flashSession->error($campaign->get_val_errors());
                    $transaction->rollback();
                }

                try {
                    // create a new mailgun instance
                    $mg = new MailGunAPI($campaign->domain->domain);

                    // attempt to create the campaign
                    $result = $mg->create_campaign($campaign->name);
                } catch (Exception $e) {
                    // domain doesn't exist, maybe
                    $this->flashSession->error('Mailgun error occurred, usual cause: Domain not added to Mailgun');

                    $transaction->rollback();
                }

                // commit all changes up to this point
                $transaction->commit();

                // update the newly created campaign with the mg campaign id
                $campaign->mg_campaign_id = $result->http_response_body->campaign->id;
                $campaign->update();

                // success
                $this->flashSession->success('Campaign was created successfully');
                return $this->response->redirect('send/campaign_datasource/' . $campaign->campaign_id);
            } catch (Exception $e) { }
        }

        $this->view->setVars([
            'templates' => Templates::find()
        ]);
    }

    public function campaign_datasourceAction($campaign_id) {
        // make sure a campaign id was provided
        if (!$campaign_id) return $this->response->redirect('send');

        $this->view->setVars([
            'formatted_views' => FormattedViews::views_with_datasources()
        ]);

        $campaign = Campaigns::findFirst($campaign_id);

        if ($this->request->isPost()) {
            // check if they picked a datasource
            if (!$this->request->getPost('formatted_view_id')) {
                $this->flashSession->error('Please pick a datasource and view');
                return null;
            }

            // update the campaign with the formatted view id
            $campaign->formatted_view_id = $this->request->getPost('formatted_view_id');
            $campaign->update();

            // success
            return $this->response->redirect('send/campaign_content/' . $campaign_id);
        }

        $_POST = $campaign->toArray();
    }

    public function campaign_contentAction($campaign_id) {
        // make sure a campaign id was provided
        if (!$campaign_id) return $this->response->redirect('send');

        // get the campaign information
        $campaign = Campaigns::findFirst($campaign_id);

        $this->view->setVars([
            'templates'   => Templates::find(),
            'campaign_id' => $campaign_id
        ]);

        if ($this->request->isPost()) {
            if (!$this->request->getPost('template_id')) {
                $this->flashSession->error('Template must be picked');
                return null;
            }

            if (!$this->request->getPost('subject')) {
                $this->flashSession->error('Subject must be provided');
                return null;
            }

            if (!$this->request->getPost('content')) {
                $this->flashSession->error('Content must be provided');
                return null;
            }

            $campaign->template_id  = $this->request->getPost('template_id');
            $campaign->subject      = $this->request->getPost('subject');
            $campaign->content      = $this->request->getPost('content');

            $campaign->update();

            // success
            return $this->response->redirect('send/campaign_summary/' . $campaign_id);
        }

        $_POST = $campaign->toArray();
    }

    public function campaign_summaryAction($campaign_id, $send_preview = null) {
        // make sure a campaign id was provided
        if (!$campaign_id) return $this->response->redirect('send');

        // get the campaign information
        $campaign = Campaigns::findFirst($campaign_id);

        // check their status and see if they should be here yet
        if (!$campaign->formatted_view_id) {
            return $this->response->redirect('send/campaign_datasource/' . $campaign_id);
        } elseif (!$campaign->content) {
            return $this->response->redirect('send/campaign_content/' . $campaign_id);
        }

        // create a datasource from the information available
        $datasource = (new Gateway())->gen_datasource(
            $campaign->formatted_view->datasource_id,
            $campaign->formatted_view->name,
            Gateway::SUPER);

        // get a count of the number of records
        $data_count = $datasource->count();

        $this->view->setVars([
            'campaign'   => $campaign,
            'template'   => $campaign->template->name,
            'view'       => $campaign->formatted_view->name,
            'data_count' => $data_count
        ]);
    }

    public function send_previewAction($campaign_id){
        // get the campaign
        $campaign = Campaigns::findFirst($campaign_id);

        // prepare the batch set of options
        $options = new stdClass();
        $options->campaign_id = $campaign->campaign_id;
        $options->from_email  = 'Postmaster <postmaster@' . $campaign->domain->domain . '>';
        $options->subject     = $campaign->subject;
        $options->body        = $campaign->template->header . $campaign->content . $campaign->template->footer;
        $options->recipients  = ProofList::batch_formatted_list();

        // create a new mailgun instance
        $mg = new MailGunAPI($campaign->domain->domain);

        try {
            // attempt to start the batch email
            $mg->send_batch_email($options);

            Events::log('Sent ' . count($options->recipients) . ' proof emails for ' . $campaign->name);

            // success
            $this->flashSession->success('Preview was successfully sent');
            return $this->response->redirect('send/campaign_summary/' . $campaign_id);
        } catch (Exception $e) {
            Events::log($campaign->name . ' failed: ' . $e->getMessage(), Events::ERROR);
        }
    }

    public function execute_campaignAction() {
        if ($this->request->isPost()) {
            $campaign_id = $this->request->getPost('campaign_id');

            $cmd = ' cd ../../micro_cli/ && ./hm.sh --send-campaign 33';
            //exec ./hm.sh --send-campaign id &
             exec($cmd . " > /dev/null &");
        }
    }

    /**
     * used in:
     * /send/campaign_content.volt
     */
    public function ajax_preview_campaignAction(){
        // get the template information
        $template = Templates::findFirst($this->request->getPost('template_id'));

        // get the posted content
        $content  = $this->request->getPost('content');

        // send the result
        echo $template->header . $content . $template->footer;
        exit;
    }

}