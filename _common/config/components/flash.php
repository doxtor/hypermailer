<?php

$di->set('flashSession', function() {
    return new Phalcon\Flash\Session([
        'error'   => 'alert alert-danger well-sm',
        'success' => 'alert alert-success well-sm',
        'notice'  => 'alert alert-info well-sm',
    ]);
});