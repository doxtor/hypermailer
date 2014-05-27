<?php

define('VERSION', '1.0.0');

// app path
defined('APPLICATION_PATH') || define('APPLICATION_PATH', realpath(dirname(__FILE__)));

// autoloader
$loader = new \Phalcon\Loader();
$loader
    ->registerDirs([
        APPLICATION_PATH . '/../../_common/models',
        APPLICATION_PATH . '/../../_common/utilities',
        APPLICATION_PATH . '/../../_common/library',

        // routines directory
        APPLICATION_PATH . '/../routines'])
    ->register();

require APPLICATION_PATH . '/../../vendor/autoload.php';

// cli di
$di = new \Phalcon\DI\FactoryDefault\CLI();

// load common config
require APPLICATION_PATH . '/../../_common/config/config_loader.php';

// databases
require APPLICATION_PATH . '/../../_common/config/components/database.php';

// new console app
$console = new \Phalcon\CLI\Console();
$console->setDI($di);

// add console to the di for console forwarding
$di->setShared('console', $console);

// arguments
$arguments = $params = [];

foreach($argv as $k => $arg) {
    if ($k >= 1) {
       $params[] = $arg;
    }
}
if(count($params) > 0) {
    $arguments['params'] = $params;
}

// define global constants for the current task and action
define('CURRENT_TASK', 'main');
define('CURRENT_ACTION', 'main');

try {
    // handle incoming arguments
    $console->handle($arguments);
} catch (\Phalcon\Exception $e) {
    echo $e->getMessage();
    exit(255);
}