<?php

return new \Phalcon\Config([
    'state' => [
        'development' => true
    ],
    'database' => [
        'adapter'  => 'Mysql',
        'host'     => 'localhost',
        'username' => 'root',
        'password' => 'root',
        'name'     => 'hyper_mailer',
    ],
    'logs' => [
        'error' => '',
        'sql'   => '/var/log/hyper_mailer.sql.log'
    ]
]);