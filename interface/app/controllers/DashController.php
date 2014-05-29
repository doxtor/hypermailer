<?php

class DashController extends BaseController {

    public function beforeExecuteRoute() {
        // return to login if user is logged out
        Authenticator::enforce_login();
    }


    public function indexAction() {
        $events = Events::find([
            'order' => 'event_id desc',
            'limit' => 1000,
        ]);

        $this->view->setVars([
            'events' => $events
        ]);
    }

}