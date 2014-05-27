<?php

class mainTask extends \Phalcon\CLI\Task {
    
    public function mainAction(array $params = null) {
        switch ($params[0]) {
            case '--send-renewals':
                $this->console->handle([
                    'task'   => 'Email',
                    'action' => 'renewals'
                ]);
                break;
            case '--send-campaign':
                $this->console->handle([
                    'task'   => 'Email',
                    'action' => 'campaign',
                    $params
                ]);
                break;

            case null:
            case '':
                $this->menu();
                break;
        }
    }
    
    private function menu() {
        echo '************************************************************' . PHP_EOL;
        echo 'Hypermailer CLI | Copyright (C) 2014 Simmons Venture Group' . PHP_EOL;
        echo 'This program comes with ABSOLUTELY NO WARRANTY' . PHP_EOL;
        echo 'This is free software, and you are welcome to redistribute it' . PHP_EOL;
        echo 'under certain conditions.' . PHP_EOL . PHP_EOL;
        echo 'Usage: hm command [params]';
        
        echo PHP_EOL . PHP_EOL;
        
        $commands = [
            '--send-renewals               // send out daily renewals as specified',
            '--send-campaign [campaign_id] // send out campaign as specified'
        ];
        
        echo 'Commands:' . PHP_EOL;
        
        foreach ($commands as $c) {
            echo $c . PHP_EOL;
        }
        
        echo PHP_EOL;
    }
    
}
