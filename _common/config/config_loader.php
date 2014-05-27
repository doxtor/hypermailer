<?php

/**
 * Config Loader
 * 
 * Principle of operation:
 * 
 * On dev boxes, a file located at /var/d will contain the word "dev".
 * On prod boxes, no file will exist at /var/d.
 * 
 * If the file is not found or it is found without the word dev in it, the application
 * will assume it is on a production box. This is done as a fail safe to make sure that
 * debug output doesn't happen in a prod environment.
 */

// check for the file
$state = trim(@file_get_contents('/var/d'));

if ($state == 'dev') {
    // the current machine is a development machine
    $config = require realpath(__DIR__) . '/config_dev.php';
} else {
    // the current machine is a production machine
    $config = require realpath(__DIR__) . '/config_prod.php';
}

// set config as a service
$di->set('config', $config);