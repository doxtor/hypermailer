<?php

/**
 * Hypermailer | Email Simplified
 * Copyright (C) 2014 Simmons Venture Group
 * Original Authors: Brian Seymour & Kirk Taylor
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// specific application assets
(new \Phalcon\Loader())
    ->registerDirs([
        '../app/controllers/',
        '../app/views/'])
    ->register();

// common application assets
require '../../_common/config/components/common.php';

// composer assets
require '../../vendor/autoload.php';

try {
    // create a di
    $di = new \Phalcon\DI\FactoryDefault();

    // load configuration based on environment
    require '../../_common/config/config_loader.php';

    // database component
    require '../../_common/config/components/database.php';

    // session component
    require '../../_common/config/components/session.php';

    // volt component
    require '../../_common/config/components/volt.php';

    // flash component
    require '../../_common/config/components/flash.php';

    // specifc route definition
    require '../app/config/routes.php';
    
    // dispatch
    echo (new \Phalcon\Mvc\Application($di))->handle()->getContent();

    // clean up cache after each call
    if ($config->state->development) {
        // volt cache
        array_map('unlink', glob('../app/views/compiled_templates/*.php'));
    }

} catch(\Phalcon\Exception $e) {
     echo 'I iz broke :( ', $e->getMessage();
}