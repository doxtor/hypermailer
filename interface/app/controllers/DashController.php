<?php

class DashController extends BaseController {

    public function beforeExecuteRoute() {
        // return to login if user is logged out
        Authenticator::enforce_login();
    }


    public function indexAction() {
        $this->view->setVars([
            'events' => Events::find(['order' => 'event_id desc'])
        ]);
    }

}