<?php

use Phalcon\Mvc\Model\Validator\Email;
use Phalcon\Mvc\Model\Validator\Regex;

class ProofList extends BaseModel {

    public $proof_list_id;
    public $name;
    public $email;

    public function initialize() {
        parent::initialize();

        $this->setSource('proof_list');
    }

    public function validation() {
        $this->validate(new Regex([
            'field'   => 'name',
            'pattern' => '/^.+$/',
            'message' => 'Name must be provided'
        ]));

        $this->validate(new Email([
            'field'   => 'email',
            'message' => 'Email must be provided'
        ]));

        if ($this->validationHasFailed()) return false;
    }

    static public function batch_formatted_list() {
        // get the full proof list
        $proof_list = ProofList::find();

        // prepare a place for the formatted list
        $batch_formatted_list = [];

        // loop through each recipient in the proof list and make a batch formatted list
        foreach ($proof_list as $recipient) {
            $batch_formatted_list[] = [
                'email_address' => $recipient->email,
                'first_name'    => $recipient->name,
            ];
        }

        return $batch_formatted_list;
    }

}