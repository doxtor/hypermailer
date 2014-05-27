<?php

class Gateway extends BaseModel {

    const ROOT    = 'x';
    const SUPER   = 's';
    const REGULAR = 'r';

    public function initialize() {
        parent::initialize();
    }

    public function register_connection($datasource_id, $type, $root_creds = null) {
        // get database information
        $datasource = Datasources::findFirst($datasource_id);

        // set up new gateway db service
        $this->getDI()->set($type . '_gateway', function() use ($datasource, $type, $root_creds) {
            switch ($type) {
                case Gateway::ROOT:
                    $connection = new \Phalcon\Db\Adapter\Pdo\Mysql([
                        'host'     => $datasource->ip,
                        'username' => $root_creds['username'],
                        'password' => $root_creds['password'],
                        'dbname'   => $datasource->database_name
                    ]);
                    break;

                case Gateway::SUPER:
                    $connection = new \Phalcon\Db\Adapter\Pdo\Mysql([
                        'host'     => $datasource->ip,
                        'username' => $datasource->super_username,
                        'password' => $datasource->super_password,
                        'dbname'   => $datasource->database_name
                    ]);
                    break;

                case Gateway::REGULAR:
                    $connection = new \Phalcon\Db\Adapter\Pdo\Mysql([
                        'host'     => $datasource->ip,
                        'username' => $datasource->regular_username,
                        'password' => $datasource->regular_password,
                        'dbname'   => $datasource->database_name
                    ]);
                    break;
            }

            return $connection;
        });

        // use the newly created db service
        $this->setConnectionService($type . '_gateway');

        return $this;
    }

    public function gen_datasource($datasource_id, $view_name, $type) {
        // register the connect with the di
        $this->register_connection($datasource_id, $type);

        // set the table (view) to use
        $this->setSource($view_name);

        return $this;
    }

}