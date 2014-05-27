<?php

use Phalcon\Mvc\Model\Validator\Regex;

class Campaigns extends BaseModel {

    public $campaign_id;
    public $domain_id;
    public $formatted_view_id;
    public $mg_campaign_id;
    public $name;
    public $description;
    public $date_created;
    public $date_started;
    public $template_id;
    public $content;
     
    public function initialize() {
        parent::initialize();

        $this->setSource('campaigns');

        $this->hasOne('domain_id', 'Domains', 'domain_id', [
            'alias' => 'domain'
        ]);

        $this->hasOne('formatted_view_id', 'FormattedViews', 'formatted_view_id', [
            'alias' => 'formatted_view'
        ]);

        $this->hasOne('template_id', 'Templates', 'template_id', [
            'alias' => 'template'
        ]);
    }

    public function validation() {
        $this->validate(new Regex([
            'field'   => 'domain_id',
            'pattern' => '/^.+$/',
            'message' => 'Domain must be picked'
        ]));

        $this->validate(new Regex([
            'field'   => 'name',
            'pattern' => '/^.+$/',
            'message' => 'Name must be provided'
        ]));

        $this->validate(new Regex([
            'field'   => 'description',
            'pattern' => '/^.+$/',
            'message' => 'Description must be provided'
        ]));

        if ($this->validationHasFailed()) return false;
    }

    public function beforeCreate() {
        $this->date_created = date('Y-m-d H:i:s');
        if(!$this->template_id){
            $this->template_id = NULL;
        }
    }

}