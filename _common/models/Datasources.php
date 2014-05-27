<?php

class Datasources extends BaseModel {

    public $datasource_id;
    public $name;
    public $ip;
    public $database_name;
    public $super_username;
    public $super_password;
    public $regular_username;
    public $regular_password;

    public function initialize() {
        parent::initialize();

        $this->setSource('datasources');

        $this->hasMany('datasource_id', 'FormattedViews', 'datasource_id', [
            'alias' => 'formatted_views'
        ]);
    }

    static public function create_users(Datasources $ds, $creds) {
        // create the connection
        $db = (new Gateway())->register_connection($ds->datasource_id, Gateway::ROOT, $creds)->getWriteConnection();

        // create the regular user
        $db->query("CREATE USER '$ds->regular_username'@'%' IDENTIFIED BY '$ds->regular_password'");
        $db->query("GRANT SELECT ON $ds->database_name.* TO '$ds->regular_username'@'%'");
        $db->query("CREATE USER '$ds->regular_username'@'localhost' IDENTIFIED BY '$ds->regular_password'");
        $db->query("GRANT SELECT ON $ds->database_name.* TO '$ds->regular_username'@'localhost'");

        // create the super user
        $db->query("CREATE USER '$ds->super_username'@'%' IDENTIFIED BY '$ds->super_password'");
        $db->query("GRANT CREATE USER ON *.* TO '$ds->super_username'@'%'");
        $db->query("GRANT CREATE VIEW ON *.* TO '$ds->super_username'@'%'");
        $db->query("GRANT INSERT      ON *.* TO '$ds->super_username'@'%'");
        $db->query("GRANT SELECT      ON $ds->database_name.* TO '$ds->super_username'@'%'");
        $db->query("GRANT UPDATE      ON $ds->database_name.* TO '$ds->super_username'@'%'");
        $db->query("GRANT DELETE      ON $ds->database_name.* TO '$ds->super_username'@'%'");
        $db->query("GRANT DROP        ON $ds->database_name.* TO '$ds->super_username'@'%'");
        $db->query("CREATE USER '$ds->super_username'@'localhost' IDENTIFIED BY '$ds->super_password'");
        $db->query("GRANT CREATE USER ON *.* TO '$ds->super_username'@'localhost'");
        $db->query("GRANT CREATE VIEW ON *.* TO '$ds->super_username'@'localhost'");
        $db->query("GRANT INSERT      ON *.* TO '$ds->super_username'@'localhost'");
        $db->query("GRANT SELECT      ON $ds->database_name.* TO '$ds->super_username'@'localhost'");
        $db->query("GRANT UPDATE      ON $ds->database_name.* TO '$ds->super_username'@'localhost'");
        $db->query("GRANT DELETE      ON $ds->database_name.* TO '$ds->super_username'@'localhost'");
        $db->query("GRANT DROP        ON $ds->database_name.* TO '$ds->super_username'@'localhost'");

        // reload the privileges
        $db->query("FLUSH PRIVILEGES");
    }

    static public function delete_users(Datasources $ds) {
        $creds = [
            'username' => $ds->super_username,
            'password' => $ds->super_password,
        ];

        // open the gateway to the appropriate database
        $db = (new Gateway())->register_connection($ds->datasource_id, Gateway::ROOT, $creds)->getWriteConnection();

        // drop the two hypermailer users
        $db->query("DROP USER '$ds->regular_username'@'%'");
        $db->query("DROP USER '$ds->regular_username'@'localhost'");
        $db->query("DROP USER '$ds->super_username'@'%'");
        $db->query("DROP USER '$ds->super_username'@'localhost'");
    }

    static public function create_view($datasource_id, $view_name, $view_query) {
        try {
            // open the gateway to the appropriate database
            $db = (new Gateway())->register_connection($datasource_id, Gateway::SUPER)->getWriteConnection();

            // start transaction
            $db->begin();

            // save the formatted view record
            $database = Injector::config()->database->name;
            $table    = (new FormattedViews())->getSource();

            $db->query(
                "INSERT INTO " . $database  . "." . $table . " ".
                "VALUES (''," . $datasource_id . ",'" . $view_name . "','" . addslashes($view_query) . "')");

            $db->query("CREATE OR REPLACE VIEW $view_name AS $view_query");

            $db->commit();

            return true;
        } catch (Exception $e) {
            $db->rollback();

            return false;
        }
    }

    static public function read_views($datasource_id, $get_all = false) {
        // get the information about the datasource
        $datasource = Datasources::findFirst($datasource_id);

        // open the gateway to the appropriate database
        $gateway = new Gateway();
        $gateway->register_connection($datasource_id, Gateway::SUPER);

        // get a resultset of the records for the datasource views
        $views = new Phalcon\Mvc\Model\Resultset\Simple(null, $gateway,
            $gateway
                ->getReadConnection()
                ->query("SHOW FULL TABLES IN " . $datasource->database_name . " WHERE TABLE_TYPE LIKE 'VIEW'"));

        // establish final list for the views
        $final_view_list = [];

        // loop through each view to add to the final list
        foreach ($views->toArray() as $view) {
            $view_name = $view['Tables_in_' . $datasource->database_name];

            // check if all views should be returned
            if ($get_all) {
                // they should, add the view regardless of the name
                $final_view_list[] = [
                    'formatted_view_id' => FormattedViews::findFirstByName($view_name)->formatted_view_id,
                    'name'              => $view_name
                ];
            } else {
                // they shouldn't, add the view only if prefixed with hm_
                if (preg_match('/^hm_/', $view_name)) {
                    $final_view_list[] = [
                        'formatted_view_id' => FormattedViews::findFirstByName($view_name)->formatted_view_id,
                        'name'              => $view_name
                    ];
                }
            }
        }

        return $final_view_list;
    }

    static public function update_view($datasource_id, $formatted_view_id, $view_name, $view_query) {
        // open the gateway to the appropriate database
        $gateway = new Gateway();
        $gateway->register_connection($datasource_id, Gateway::SUPER);

        try {
            $manager = new \Phalcon\Mvc\Model\Transaction\Manager();
            $transaction = $manager->get();

            // add the view to the database
            $gateway
                ->setTransaction($transaction)
                ->getReadConnection()
                ->query("CREATE OR REPLACE VIEW $view_name AS $view_query");

            // save the formatted view record
            $formatted_view = new FormattedViews();

            $formatted_view
                ->setTransaction($transaction)
                ->getWriteConnection()
                ->query(
                    "UPDATE " . $formatted_view->getSource() . " " .
                    "SET " .
                    "name  = '" . $view_name              . "', ".
                    "query = '" . addslashes($view_query) . "'  ".
                    "WHERE formatted_view_id = " . $formatted_view_id);

            $transaction->commit();

            return true;
        } catch (Exception $e) { var_dump($e->getMessage());exit;}
    }

    static public function delete_view($datasource_id, $formatted_view_name) {
        // check to make sure the view is prefixed with hm_
        if (!preg_match('/^hm_/', $formatted_view_name)) {
            // it's not, end here
            return false;
        }

        // open the gateway to the appropriate database
        $gateway = new Gateway();
        $gateway->register_connection($datasource_id, Gateway::SUPER);

        // delete the view in the database
        $gateway
            ->getReadConnection()
            ->query("DROP VIEW " . $formatted_view_name);

        return true;
    }

    static public function view_exists($datasource_id, $view_name) {
        $view_list = Datasources::read_views($datasource_id, true);

        return (in_array($view_name, $view_list)) ? true : false;
    }

    static public function query_valid($datasource_id, $query, &$message = null) {
        // open the gateway to the appropriate database
        $gateway = new Gateway();
        $gateway->register_connection($datasource_id, Gateway::REGULAR);

        // looking for PDO errors, or it's valid
        try {
            // test the query
            $gateway = new Phalcon\Mvc\Model\Resultset\Simple(null, $gateway,
                $gateway
                    ->getReadConnection()
                    ->query($query));

            return true;
        } catch (Exception $e) {
            $message = $e->getMessage();
            return false;
        }
    }

}