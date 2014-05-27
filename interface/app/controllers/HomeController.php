<?php

class HomeController extends BaseController {

    public function unauthorizedAction() {
        return $this->response->redirect('login');
    }
    
    public function loginAction() {
        // check if already logged in
        if ($this->session->get('user_id')) {
            return $this->response->redirect('dash');
        }

        if ($this->request->isPost()) {
            // check the login
            $email    = $this->request->getPost('email');
            $password = $this->request->getPost('password');

            $user = Users::findFirstByEmail($email);

            // handle the result
            if ($user) {
                if ($this->security->checkHash($password, $user->password)) {
                    // add the id to the session
                    $this->session->set('user_id', $user->user_id);

                    // send user to the admin landing page
                    return $this->response->redirect('dash');
                } else {
                    $this->flashSession->error('Password incorrect');
                }

            } else {
                // credentials wrong, flash the message
                $this->flashSession->error('Credentials incorrect');
            }
        }
    }
    
    public function logoutAction() {
        // destroy the session
        $this->session->destroy();
        
        // send back to login page
        return $this->response->redirect();
    }
    
}