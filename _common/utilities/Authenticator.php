<?php

class Authenticator {
    
    static public function enforce_login() {
        // read the user_id from the session
        $user_id = Injector::session()->get('user_id');
        
        // back to login screen if no user
        if (!$user_id) {
            Injector::dispatcher()->forward([
                'controller' => 'home',
                'action'     => 'unauthorized'
            ]);
        }
    }
    
}