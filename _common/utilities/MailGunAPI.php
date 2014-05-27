<?php

/**
 * usage:
 * $obj = new MailGunAPI($domain);
 *
 * @param $domain
 */
class MailGunAPI {

    private $domain;
    private $mg;

    const EVENT_EVENTS       = 'events';
    const EVENT_STATS        = 'stats';
    const EVENT_CLICKS       = 'clicks';
    const EVENT_OPENS        = 'opens';
    const EVENT_UNSUBSCRIBES = 'unsubscribes';
    const EVENT_COMPLAINTS   = 'complaints';

    public function __construct($domain = null) {
        // set the domain to the object
        $this->domain = $domain;

        // set a new instance of the mailgun client to the object
        $this->mg = new \Mailgun\Mailgun(System::findFirstByKey(System::APIKEY)->value);
    }

    public function get_domains($domain = null) {
        // check if domain name was provided
        if ($domain) {
            // it was, get the one provided
            $result = $this->mg->get("domains/$domain");
        } else {
            // it wasn't, get them all
            $result = $this->mg->get("domains");
        }

        return $result;
    }

    /**
     * usage:
     * $obj->create_campaign('campaign name');
     *
     * @param $campaign
     * @return stdClass
     */
    public function create_campaign($campaign) {
        // send the request to create the campaign
        $result = $this->mg->post("$this->domain/campaigns", ['name' => $campaign]);

        return $result;
    }

    /**
     * usage:
     * $obj->update_campaign('mg_campaign_id', 'new campaign name');
     *
     * @param $mg_campaign_id
     * @param $new_name
     * @return stdClass
     */
    public function update_campaign($mg_campaign_id, $new_name) {
        // send request to update a campaign
        $result = $this->mg->put("$this->domain/campaigns/$mg_campaign_id", ['name' => $new_name]);

        return $result;
    }

    /**
     * usage:
     * $obj->delete_campaign('mg_campaign_id');
     *
     * @param $mg_campaign_id
     * @return stdClass[message,id]
     */
    public function delete_campaign($mg_campaign_id) {
        // send the request to delete a campaign
        $result = $this->mg->delete("$this->domain/campaigns/$mg_campaign_id") ;

        return $result;
    }

    /**
     * usage:
     * $obj->get_campaigns();                 // will return everything
     * $obj->get_campaigns('mg_campaign_id'); // will return single campaign
     *
     * @param null $mg_campaign_id
     * @return stdClass
     */
    public function get_campaigns($mg_campaign_id = null) {
        // check if campaign id was provided
        if ($mg_campaign_id) {
            // it was, get the one provided
            $result = $this->mg->get("$this->domain/campaigns/$mg_campaign_id");
        } else {
            // it wasn't, get them all
            $result = $this->mg->get("$this->domain/campaigns");
        }

        return $result;
    }

    /**
     * usage:
     * $obj->get_campaign_stats('mg_campaign_id', MailGunAPI::EVENT_EVENTS);
     *
     * @param $mg_campaign_id
     * @param string $event
     * @return stdClass
     */
    public function get_campaign_stats($mg_campaign_id, $event = self::EVENT_EVENTS) {
        // send the request for campaign stats
        $result = $this->mg->get("$this->domain/campaigns/$mg_campaign_id/$event");

        return $result;
    }

    public function send_single_email($from_name, $from_email, $to, $subject, $body) {
        // send the message
        $this->mg->sendMessage($this->domain, [
            'from'    => $from_name . ' <' . $from_email . '>',
            'to'      => $to,
            'subject' => $subject,
            'html'    => $body
        ]);
    }

    /**
     * usage:
     * $options = new stdClass();
     * $options->campaign_id = 'abc123';
     * $options->from_email  = 'Brian Seymour <demo@progolfsystems.com>';
     * $options->subject     = 'Get better golf software';
     * $options->body        = 'whatever goes here';
     * $options->recipients  = [
     *     [
     *             'email_address' => 'brian@progolfsystems.com',
     *             'first_name' => 'Brian',
     *             'last_name'  => 'Seymour',
     *     ],
     *     [
     *             'email_address' => 'kirk@progolfsystems.com',
     *             'first_name'    => 'Kirk',
     *             'last_name'     => 'Taylor',
     *     ],
     * ];
     *
     * $obj->send_batch_email($options);
     *
     * @param stdClass $options
     * @throws Exception
     */
    public function send_batch_email(stdClass $options) {
        // make sure options is an instance of stdClass
        if (!$options instanceof stdClass) throw new Exception('$options must be an instance of stdClass');

        // create the batch message object
        $batch = $this->mg->BatchMessage($this->domain);

        // set the incoming options
        $batch->setFromAddress($options->from_email);
        $batch->setSubject($options->subject);
        $batch->setHtmlBody($options->body);
        $batch->addCampaignId($options->campaign_id);
        $batch->addCustomHeader('X-Mailgun-Native-Send', 'true');
        $batch->setClickTracking(true);
        //$batch->setTestMode(true);

        // loop through and add each recipient
        foreach ($options->recipients as $recipient) {
            // add an email and a set of recipient variables
            $batch->addToRecipient($recipient['email_address'], $recipient);
        }

        // finish the operation
        $batch->finalize();
    }

    /**
     * usage:
     * $obj->get_unsubscribes();
     *
     * @return stdClass
     */
    public function get_unsubscribes() {
        // send request to get the domain unsubscribes
        $result = $this->mg->get("$this->domain/unsubscribes");

        return $result;
    }

    /**
     * usage:
     * $obj->add_email_unsubscribe('email_to_unsubscribe');
     *
     * @param $email
     * @return stdClass
     */
    public function add_email_unsubscribe($email){
        $result = $this->mg->post("$this->domain/unsubscribes", ['address' => $email, 'tag' => '*']);

        return $result;
    }

}