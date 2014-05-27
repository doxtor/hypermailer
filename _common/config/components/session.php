<?php

$di->set('session', function() {
    $session = new \Phalcon\Session\Adapter\Files();
    $session->start();

    return $session;
});