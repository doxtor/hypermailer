<?php

class VoltExtend {
    
    static public function datesubstr($args) {
        return substr($args, 0, 10);
    }

    static public function count($args) {
        return count($args);
    }
    
}