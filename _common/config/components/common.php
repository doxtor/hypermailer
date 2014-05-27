<?php

(new \Phalcon\Loader())
    ->registerDirs([
        '../../_common/models/',
        '../../_common/library/',
        '../../_common/utilities/',
        '../../_common/validators/'])
    ->register();