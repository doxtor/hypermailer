<?php

\Phalcon\Mvc\Model::setup([ 'notNullValidations' => false ]);

$di->set('db', function() use ($config) {
    $eventsManager = new \Phalcon\Events\Manager();

    $logger = new \Phalcon\Logger\Adapter\File($config->logs->sql);

    // listen all the database events
    $eventsManager->attach('db', function($event, $connection) use ($logger) {
        if ($event->getType() == 'afterQuery') {
            
        } 
        if ($event->getType() == 'beforeQuery') {
            $variables = $connection->getSqlVariables();
            if (count($variables)) {
                $logger->log($connection->getSQLStatement() . ' ' . join(', ', $variables), \Phalcon\Logger::INFO);
            } else {
                $logger->log($connection->getSQLStatement(), \Phalcon\Logger::INFO);
            }
        }
    });

    $connection = new \Phalcon\Db\Adapter\Pdo\Mysql([
        'host'     => $config->database->host,
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname'   => $config->database->name
    ]);

    $connection->setEventsManager($eventsManager);

    return $connection;
});