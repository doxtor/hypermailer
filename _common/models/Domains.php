<?php

use Phalcon\Mvc\Model\Validator\Regex;

class Domains extends BaseModel {

    public $domain_id;
    public $name;
    public $domain;

    public function initialize() {
        parent::initialize();

        $this->setSource('domains');

        $this->hasMany('domain_id', 'Campaigns', 'domain_id', [
            'alias' => 'campaigns'
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
            'message' => 'Domain must be provided'
        ]));

        if ($this->validationHasFailed()) return false;
    }

}