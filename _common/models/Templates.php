<?php

use Phalcon\Mvc\Model\Validator\Regex;

class Templates extends BaseModel {

    public $template_id;
    public $header;
    public $footer;
    public $name;
     
    public function initialize() {
        parent::initialize();

        $this->setSource('templates');

        $this->hasMany('template_id', 'Emails', 'template_id', [
            'alias' => 'emails'
        ]);
    }

    public function validation() {
        $this->validate(new Regex([
            'field'   => 'name',
            'pattern' => '/^.+$/',
            'message' => 'Name must be provided'
        ]));

        $this->validate(new Regex([
            'field'   => 'header',
            'pattern' => '/^.+$/',
            'message' => 'Header must be provided'
        ]));

        $this->validate(new Regex([
            'field'   => 'footer',
            'pattern' => '/^.+$/',
            'message' => 'Footer must be provided'
        ]));

        if ($this->validationHasFailed()) return false;
    }

}