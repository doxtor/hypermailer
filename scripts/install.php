<?php

echo '****************************************************' . PHP_EOL;
echo 'This interative script will help install Hypermailer' . PHP_EOL;
echo '              Be sure to run as root                ' . PHP_EOL;
echo '****************************************************' . PHP_EOL;

while (true) {
    $step1 = readline('Install configuration file? [y/n]: ');

    if ($step1 == 'n') break;
    if ($step1 != 'y') continue;

    while (true) {
        $host = readline('MySQL Host: ');
        $user = readline('MySQL Username: ');
        $pass = readline('MySQL Password: ');

        $conn = new mysqli($host, $user, $pass);

        if ($conn->connect_error) {
            $restart = readline('Connection to MySQL failed, retry? [y/n]: ');

            if ($restart == 'y') continue;
        }

        break;
    }

    $result = $conn->query('show databases like \'hyper_mailer2\'');

    if ($result->num_rows == 0) {
        echo PHP_EOL;
        echo 'Creating Database';
        echo PHP_EOL;

        $conn->query('create database hyper_mailer2');
        var_dump($conn->error);

        echo PHP_EOL;
        echo 'Writing Base Schema to Database';
        echo PHP_EOL;

        //$conn->query('use hyper_mailer2');
        //$conn->multi_query(file_get_contents('assets/base.sql'));
        //var_dump($conn->error);

        //$conn->commit();
        //$conn->close();
        exec("mysql -u$user -p$pass hyper_mailer2 < assets/base.sql");

        $email = 'admin' . rand(1000,9999) . '@svgflorida.com';

        echo PHP_EOL;
        echo 'Writing First User' . PHP_EOL;
        echo '  Email: ' . $email . PHP_EOL;
        echo '  Password: changemenow123';
        echo PHP_EOL;

        $conn = new mysqli($host, $user, $pass, 'hyper_mailer2');
        $conn->multi_query("insert into users values ('','Admin','$email','$2a$08$5vB00Y0jELzohl42jqfhIu2wK6MuHLFTmkLNuCnTop.VK92vngiLG');");
        var_dump($conn->error);
        $conn->close();
    } else {
        echo PHP_EOL;
        echo 'Database already exists, skipping schema load';
        echo PHP_EOL;
    }

    echo PHP_EOL;
    echo 'Writing credentials to _common/config/config_prod.php';
    echo PHP_EOL;

    $config = [
        '[your_db_host_here]'     => $host,
        '[your_db_username_here]' => $user,
        '[your_db_password_here]' => $pass
    ];

    $file = file_get_contents('../_common/config/config_prod.php');

    foreach ($config as $k => $v) {
        $file = str_replace($k, $v, $file);
    }

    file_put_contents('../_common/config/config_prod.php', $file);

    break;
}

echo PHP_EOL;
echo 'Resetting caches and setting proper permissions';
echo PHP_EOL;

chmod('../interface/app/views/compiled_templates', 0777);

@$conn->close();

echo PHP_EOL . PHP_EOL;