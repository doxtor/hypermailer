<?php

class DocumentationController extends BaseController {

    public function beforeExecuteRoute() {
        // return to login if user is logged out
        Authenticator::enforce_login();
    }


    public function indexAction() {
        $this->view->setVars([
            'document_root' => $_SERVER['DOCUMENT_ROOT']
        ]);
    }

}