<?php

use \Phalcon\Mvc\Model\Validator\Regex;
use \Phalcon\Mvc\Model\Validator\Email;

class Users extends BaseModel {

    public $user_id;
    public $name;
    public $email;
    public $password;

    public function initialize() {
        parent::initialize();

        $this->setSource('users');
    }

    public function validation() {
        $this->validate(new Regex([
            'field'   => 'name',
            'pattern' => '/^[a-zA-Z.\' ]+$/',
            'message' => 'Name is in the wrong format (letters, period, and apostrophe)'
        ]));

        $this->validate(new Email([
            'field'   => 'email',
            'message' => 'Email is in the wrong format (xxx@xxx.xxx)'
        ]));

        $this->validate(new Regex([
            'field'   => 'password',
            'pattern' => '/^.{6,64}$/',
            'message' => 'Password is in the wrong format (6-64 characters)'
        ]));

        if ($this->validationHasFailed()) return false;
    }

    public function beforeCreate() {
        // hash password
        $this->password = Injector::security()->hash($this->password);

        // make name nicer
        $this->name = ucwords(strtolower($this->name));
    }

    public function beforeUpdate() {
        // hash password if field has changed
        if ($this->hasChanged('password')) $this->password = Injector::security()->hash($this->password);
    }

}