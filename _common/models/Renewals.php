<?php

use Phalcon\Mvc\Model\Validator\Email;
use Phalcon\Mvc\Model\Validator\Regex;

class Renewals extends BaseModel {

    public $renewal_id;
    public $domain_id;
    public $mg_campaign_id;
    public $formatted_view_id;
    public $name;
    public $from_email;
    public $from_name;
    public $subject;
    public $content;

    public function initialize() {
        parent::initialize();

        $this->setSource('renewals');

        $this->hasOne('domain_id', 'Domains', 'domain_id', [
            'alias' => 'domain'
        ]);

        $this->hasOne('formatted_view_id', 'FormattedViews', 'formatted_view_id', [
            'alias' => 'formatted_view'
        ]);
    }

    public function validation() {
        $this->validate(new Regex([
            'field'   => 'name',
            'pattern' => '/^.+$/',
            'message' => 'Name must be provided'
        ]));

        $this->validate(new Regex([
            'field'   => 'domain',
            'pattern' => '/^.+$/',
            'message' => 'Domain must be picked'
        ]));

        $this->validate(new Regex([
            'field'   => 'formatted_view_id',
            'pattern' => '/^.+$/',
            'message' => 'View Name must be picked'
        ]));

        $this->validate(new Regex([
            'field'   => 'from_name',
            'pattern' => '/^.+$/',
            'message' => 'From Name must be provided'
        ]));

        $this->validate(new Email([
            'field'   => 'from_email',
            'message' => 'From Email must be provided'
        ]));

        $this->validate(new Regex([
            'field'   => 'subject',
            'pattern' => '/^.+$/',
            'message' => 'Subject must be provided'
        ]));

        $this->validate(new Regex([
            'field'   => 'content',
            'pattern' => '/^.+$/',
            'message' => 'Content must be provided'
        ]));

        if ($this->validationHasFailed()) return false;
    }

}