<?php

class Active_Test extends PHPUnit_Framework_TestCase {

    public function test_that_phpunit_is_active() {
        $test = true;
        $this->assertEquals($test, true);
    }

}