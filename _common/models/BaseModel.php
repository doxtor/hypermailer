<?php

class BaseModel extends \Phalcon\Mvc\Model {

    public function initialize() {
        $this->useDynamicUpdate(true);
    }

    // messages from custom validators
    public function getMessages() {
        $this->_errorMessages = [];
        $this->validation();
        
        return $this->_errorMessages;
    }
    
    // messages from phalcon auto validation
    public function getMessagesAuto() {
        return $this->_errorMessages;
    }
    
    // formatted version of getMessages
    public function get_val_errors() {
        $model_errors = $this->getMessages();
        
        $errors = '<strong>Something went wrong:</strong><br />';
        
        foreach ($model_errors as $error) {
            $errors .= $error . '<br />';
        }
        
        return $errors;
    }
    
    // formatted version of getMessagesAuto
    public function get_val_errors_auto() {
        $model_errors = $this->_errorMessages;
        
        $errors = '';

        foreach ($model_errors as $error) {
            $errors .= $error . '<br />';
        }
        
        return $errors;
    }

    static public function format_val_errors($model_errors) {
        $errors = '<strong>Something went wrong:</strong><br />';

        foreach ($model_errors as $error) {
            $errors .= $error . '<br />';
        }

        return $errors;
    }
    
}