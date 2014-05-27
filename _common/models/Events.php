<?php

class Events extends BaseModel {

    public $event_id;
    public $type;
    public $description;
    public $date;

    const SUCCESS = 's';
    const NOTICE  = 'n';
    const ERROR   = 'e';

    public function initialize() {
        parent::initialize();

        $this->setSource('events');
    }

    static public function log($description, $type = Events::NOTICE) {
        $events = new Events();

        $events->type        = $type;
        $events->description = $description;
        $events->date        = date('Y-m-d H:i:s');

        $events->create();
    }

}