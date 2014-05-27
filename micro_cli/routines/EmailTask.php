<?php

class emailTask extends \Phalcon\CLI\Task {
    
    /**
     * @param array $params // cli passed params
     */
    public function renewalsAction(array $params = null) {
        // get list of renewal emails
        $renewals = Renewals::find();

        Events::log('Renewals routine status: started', Events::SUCCESS);

        Events::log('Preparing ' . count($renewals) . ' sets of renewals');

        // error counter
        $errors  = 0;

        // loop through each renewal email
        foreach ($renewals as $renewal) {
            // instantiate a gateway for this particular dataset
            $gateway = (new Gateway())->gen_datasource(
                $renewal->formatted_view->datasource_id,
                $renewal->formatted_view->name,
                Gateway::SUPER);

            // get list of people to send the email to
            $recipients = $gateway->find()->toArray();

            // check to make sure email_address is in the recipients array
            if (!array_key_exists('email_address', $recipients[0])) {
                Events::log($renewal->name . ' failed: email_address field not present');
                ++$errors;
                continue;
            }

            Events::log('Preparing ' . count($recipients) . ' recipients for ' . $renewal->name);

            // create the standard class of batch email options
            $options = new stdClass();
            $options->campaign_id = $renewal->mg_campaign_id;
            $options->from_email  = $renewal->from_name . ' <' . $renewal->from_email . '>';
            $options->subject     = $renewal->subject;
            $options->body        = $renewal->content;

            foreach ($recipients as $recipient) {
                $options->recipients[] = $recipient;
            }

            // create the mailgun instance
            $mg = new MailGunAPI($renewal->domain->domain);

            // send the emails
            try {
                //$mg->send_batch_email($options);

                Events::log('Sent ' . count($recipients) . ' emails for ' . $renewal->name);
            } catch (Exception $e) {
                Events::log($renewal->name . ' failed: ' . $e->getMessage(), Events::ERROR);

                ++$errors;
            }
        }

        if ($errors) {
            Events::log('Renewals routine status: ended in error', Events::ERROR);
        } else {
            Events::log('Renewals routine status: succeeded', Events::SUCCESS);
        }
    }

    public function campaignAction(array $params = null) {

        // get list of renewal emails
        $campaign = Campaigns::findFirst($params[1]);

        Events::log('Campaign '.$campaign->name.' routine status: started', Events::SUCCESS);

        // error counter
        $errors  = 0;


        // instantiate a gateway for this particular dataset
        $gateway = (new Gateway())->gen_datasource(
            $campaign->formatted_view->datasource_id,
            $campaign->formatted_view->name,
            Gateway::SUPER);

        // get list of people to send the email to
        $recipients = $gateway->find()->toArray();

        // check to make sure email_address is in the recipients array

        Events::log('Preparing ' . count($recipients) . ' recipients for ' . $campaign->name);

        // create the standard class of batch email options
        $options = new stdClass();
        $options->campaign_id = $campaign->mg_campaign_id;
        $options->from_email  = $campaign->from_name . ' <' . $campaign->from_email . '>';
        $options->subject     = $campaign->subject;
        $options->body        = $campaign->content;

        foreach ($recipients as $recipient) {
            $options->recipients[] = $recipient;
        }

        // create the mailgun instance
        $mg = new MailGunAPI($campaign->domain->domain);

        // send the emails
        try {
            //$mg->send_batch_email($options);

            Events::log('Sent ' . count($recipients) . ' emails for ' . $campaign->name);
        } catch (Exception $e) {
            Events::log($campaign->name . ' failed: ' . $e->getMessage(), Events::ERROR);

            ++$errors;
        }

        if ($errors) {
            Events::log('Campaign routine status: ended in error', Events::ERROR);
        } else {
            Events::log('Campaign routine status: succeeded', Events::SUCCESS);
            $campaign->update(array(
                'date_started' => date('Y-m-d H:i:s')
            ));
        }

    }

}