<?php

$di->set('router', function(){
    $router = new \Phalcon\Mvc\Router();

    $router->add('/',      ['controller' => 'dash', 'action' => 'index']);
    $router->add('/login', ['controller' => 'home', 'action' => 'login']);

    return $router;
}, true);