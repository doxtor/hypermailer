<?php

return new \Phalcon\Config([
    'state' => [
        'development' => false
    ],
    'database' => [
        'adapter'  => 'Mysql',
        'host'     => '[your_db_host_here]',
        'username' => '[your_db_username_here]',
        'password' => '[your_db_password_here]',
        'name'     => 'hyper_mailer',
    ],
    'logs' => [
        'error' => '',
        'sql'   => '/var/log/hyper_mailer.sql.log'
    ]
]);