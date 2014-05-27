<?php

class System extends BaseModel {

    public $system_id;
    public $key;
    public $value;

    const APIKEY = 'apikey';

    public function initialize() {
        parent::initialize();

        $this->setSource('system');
    }

}