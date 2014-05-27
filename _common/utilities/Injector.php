<?php

class Injector {
    
    static public function config() {
        return \Phalcon\DI::getDefault()->getConfig();
    }
    
    static public function crypt() {
        return \Phalcon\DI::getDefault()->getCrypt();
    }

    static public function dispatcher() {
        return \Phalcon\DI::getDefault()->getDispatcher();
    }

    static public function response() {
        return \Phalcon\DI::getDefault()->getResponse();
    }
    
    static public function security() {
        return \Phalcon\DI::getDefault()->getSecurity();
    }
    
    static public function session() {
        return \Phalcon\DI::getDefault()->getSession();
    }
    
    static public function flash() {
        return \Phalcon\DI::getDefault()->getFlashSession();
    }
    
}