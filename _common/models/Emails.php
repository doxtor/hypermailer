<?php

class Emails extends BaseModel {

    public $email_id;
    public $datasource_view_id;
    public $template_id;
    public $content;
    public $date_created;
    public $date_started;
    public $date_finished;
     
    public function initialize() {
        parent::initialize();

        $this->setSource('emails');

        $this->hasOne('datasource_id', 'Datasources', 'datasource_id', [
            'alias' => 'datasource'
        ]);

        $this->hasOne('template_id', 'Templates', 'template_id', [
            'alias' => 'template'
        ]);
    }

}