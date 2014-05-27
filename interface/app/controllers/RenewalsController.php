<?php

class RenewalsController extends BaseController {

    public function beforeExecuteRoute() {
        // return to login if user is logged out
        Authenticator::enforce_login();
    }


    public function indexAction() {
        $renewals = Renewals::find(['order' => 'name']);

        $this->view->setVars([
            'renewals' => $renewals
        ]);
    }

    public function createAction(){
        if ($this->request->isPost()) {
            try {
                $manager = new \Phalcon\Mvc\Model\Transaction\Manager();
                $transaction = $manager->get();

                $renewal = new Renewals();
                $renewal->setTransaction($transaction);

                $renewal->domain_id         = $this->request->getPost('domain_id');
                $renewal->formatted_view_id = $this->request->getPost('formatted_view_id');
                $renewal->name              = $this->request->getPost('name');
                $renewal->from_email        = $this->request->getPost('from_email');
                $renewal->from_name         = $this->request->getPost('from_name');
                $renewal->subject           = $this->request->getPost('subject');
                $renewal->content           = $this->request->getPost('content');

                if (!$renewal->create()) {
                    $this->flashSession->error($renewal->get_val_errors());
                    $transaction->rollback();
                }

                try {
                    // create a new mailgun instance
                    $mg = new MailGunAPI($renewal->domain->domain);

                    // attempt to create the campaign
                    $result = $mg->create_campaign($renewal->name);
                } catch (Exception $e) {
                    // domain doesn't exist, maybe
                    $this->flashSession->error('Mailgun error occurred, usual cause: Domain not added to Mailgun');

                    $transaction->rollback();
                }

                // commit the changes up to this point
                $transaction->commit();

                // add the mg_campaign_id to the record
                $renewal->mg_campaign_id = $result->http_response_body->campaign->id;
                $renewal->update();

                // success
                $this->flashSession->success('Renewal Email was created successfully');
                $this->response->redirect('renewals');
            } catch (Exception $e) { }
        }

        $this->view->setVars([
            'formatted_views' => FormattedViews::views_with_datasources()
        ]);
    }

    public function updateAction($renewal_id) {
        $renewal = Renewals::findFirst($renewal_id);

        if (!$renewal) {
            // invalid template sent
            $this->flashSession->error('Renewal Email was not found');

            return $this->response->redirect('renewals');
        }

        if ($this->request->isPost()) {
            try {
                $manager = new \Phalcon\Mvc\Model\Transaction\Manager();
                $transaction = $manager->get();

                $renewal->setTransaction($transaction);

                $renewal->domain_id         = $this->request->getPost('domain_id');
                $renewal->formatted_view_id = $this->request->getPost('formatted_view_id');
                $renewal->name              = $this->request->getPost('name');
                $renewal->from_email        = $this->request->getPost('from_email');
                $renewal->from_name         = $this->request->getPost('from_name');
                $renewal->subject           = $this->request->getPost('subject');
                $renewal->content           = $this->request->getPost('content');

                if (!$renewal->update()) {
                    $this->flashSession->error($renewal->get_val_errors());
                    $transaction->rollback();
                }

                // check if name changed
                if ($renewal->hasChanged('name')) {
                    try {
                        // create a new mailgun instance
                        $mg = new MailGunAPI($renewal->domain->domain);

                        // attempt to update the campaign
                        $mg->update_campaign($renewal->mg_campaign_id, $renewal->name);
                    } catch (Exception $e) {
                        // domain doesn't exist, maybe
                        $this->flashSession->error(
                            'Mailgun error occurred, usual cause: Domain not added to Mailgun or invalid Campaign ID');

                        $transaction->rollback();
                    }
                }

                // commit the changes up to this point
                $transaction->commit();

                // success
                $this->flashSession->success('Renewal Email was updated successfully');
                $this->response->redirect('renewals');
            } catch (Exception $e) { }
        }

        // set the template info to the post superglobal
        $_POST = $renewal->toArray();

        // create a more descriptive version of the formatted views
        foreach (FormattedViews::find(['order' => 'datasource_id']) as $view) {
            $views[$view->formatted_view_id] = $view->datasource->name . ' - ' . $view->name;
        }

        $this->view->setVars([
            'renewal' => $renewal,
            'formatted_views' => $views
        ]);
    }

    public function deleteAction($renewal_id){
        $renewal = Renewals::findFirst($renewal_id);

        if (!$renewal) {
            // invalid template sent
            $this->flashSession->error('Renewal Email was not found');

            return $this->response->redirect('renewals');
        }

        try {
            $manager = new \Phalcon\Mvc\Model\Transaction\Manager();
            $transaction = $manager->get();

            $renewal->setTransaction($transaction);

            if (!$renewal->delete()) {
                $this->flashSession->error('Could not delete this renewal at this time');
                $transaction->rollback();
            }

            try {
                // create a new mailgun instance
                $mg = new MailGunAPI($renewal->domain->domain);

                // attempt to create the campaign
                $mg->delete_campaign($renewal->mg_campaign_id);
            } catch (Exception $e) {
                // domain doesn't exist, maybe
                $this->flashSession->error(
                    'Mailgun error occurred, usual cause: Domain not added to Mailgun or invalid Campaign ID');

                $transaction->rollback();
            }

            // commit the changes up to this point
            $transaction->commit();

            // success
            $this->flashSession->success('Renewal Email was deleted successfully');
            $this->response->redirect('renewals');
        } catch (Exception $e) { }

        return $this->response->redirect('renewals');
    }

}