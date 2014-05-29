<?php

class DatasourcesController extends BaseController {

    public function beforeExecuteRoute() {
        // return to login if user is logged out
        Authenticator::enforce_login();
    }


    public function indexAction() {
        $this->view->setVars([
            'datasources' => Datasources::find()
        ]);
    }

    public function create_datasourceAction() {
        if ($this->request->isPost()) {
            // add a record for the database
            $datasource = new Datasources();
            $datasource->name             = ($this->request->getPost('name')) ? $this->request->getPost('name') : 'Unnamed';
            $datasource->ip               = $this->request->getPost('ip');
            $datasource->database_name    = $this->request->getPost('database_name');
            $datasource->regular_username = 'hm' . time();
            $datasource->regular_password = md5(substr(md5(time()), 0, -16));
            $datasource->super_username   = 'hm' . time() . 's';
            $datasource->super_password   = md5(substr(md5(time()), -16));

            $datasource->create();

            $creds = [
                'username' => $this->request->getPost('username'),
                'password' => $this->request->getPost('password'),
            ];

            Datasources::create_users($datasource, $creds);

            // go back to list of databases
            $this->flashSession->success('Datasource has been created successfully');
            return $this->response->redirect('datasources');
        }
    }

    public function update_datasourceAction($datasource_id) {
        if ($this->request->isPost()) {
            // add a record for the database
            $datasource = Datasources::findFirst($datasource_id);
            $datasource->name          = ($this->request->getPost('name')) ? $this->request->getPost('name') : 'Unnamed';
            $datasource->ip            = $this->request->getPost('ip');
            $datasource->username      = $this->request->getPost('username');
            $datasource->password      = $this->request->getPost('password');
            $datasource->database_name = $this->request->getPost('database_name');

            $datasource->update();

            // go back to list of databases
            $this->flashSession->success('Datasource has been updated successfully');
            return $this->response->redirect('datasources');
        } else {
            // read the view information for the datasource
            $datasource = Datasources::findFirst($datasource_id);

            // attach all information to post superglobal
            $_POST = $datasource->toArray();

            // password will be provided and changed if not blank
            unset($_POST['password']);
        }

        // read the view information for the datasource views
        $datasource_views = Datasources::read_views($datasource_id);

        $this->view->setVars([
            'datasource'       => $datasource,
            'datasource_views' => $datasource_views
        ]);
    }

    public function delete_datasourceAction($datasource_id) {
        // retrieve the datasource
        $datasource = Datasources::findFirst($datasource_id);

        if (!$datasource) {
            // no datasource found
            $this->flashSession->error('Could not find a datasource with this id');
            return $this->response->redirect('datasources');
        }

        try {
            // delete the users
            Datasources::delete_users($datasource);

            // delete the datasource
            $datasource->delete();
        } catch (Exception $e) {
            //var_dump($e->getMessage());exit;
            switch ($e->getCode()) {
                case 23000:
                    $this->flashSession->error('This datasource cannot be removed because it is being used or has views');
                    break;

                default:
                    $this->flashSession->error('Datasource cannot be removed right now');
            }

            return $this->response->redirect('datasources');
        }

        // success
        $this->flashSession->success('Datasource deleted successfully');
        return $this->response->redirect('datasources');
    }

    public function test_connectionAction() {
        $ip            = $this->request->getPost('ip');
        $username      = $this->request->getPost('username');
        $password      = $this->request->getPost('password');
        $database_name = $this->request->getPost('database_name');

        // check if a datasource id was provided and password is blank
        if ($this->request->getPost('datasource_id') && !$password) {
            // it was
            $datasource = Datasources::findFirst($this->request->getPost('datasource_id'));

            // over
            $password = $datasource->password;
        }

        $database_name = ($database_name) ?: 'blank';

        $conn = @mysqli_connect($ip, $username, $password, $database_name);

        $response = [
            'status'  => ($conn) ? 0 : 1,
            'payload' => mysqli_connect_error()
        ];

        echo json_encode($response);
        exit;
    }

    public function create_viewAction($datasource_id) {
        // check if datasource_id was provided
        if (!$datasource_id) {
            return $this->response->redirect('datasources');
        }

        // check if this is a real datasource
        if (!Datasources::findFirst($datasource_id)) {
            return $this->response->redirect('datasources');
        }

        if ($this->request->isPost()) {
            // form values
            $name  = $this->request->getPost('name');

            // check if view name is blank
            if (!$name) {
                $this->flashSession->error('View name cannot be blank');
                return null;
            }

            // check if the view name already exists
            if (Datasources::view_exists($datasource_id, $name)) {
                $this->flashSession->error('This view name already exists, please pick a different name');
                return null;
            }

            // create the view
            Datasources::create_view($datasource_id, $name, 'select null as x');

            // get formatted view information
            $formatted_view = FormattedViews::findFirstByName($name);

            $this->flashSession->success('View was successfully created');
            return $this->response->redirect('datasources/update_view/' . $formatted_view->formatted_view_id);
        }
    }

    public function update_viewAction($formatted_view_id) {
        if ($this->request->isPost()) {
            // get the formatted view information
            $formatted_view = FormattedViews::findFirst($formatted_view_id);

            // form values
            $query = $this->request->getPost('query');

            // verify the syntax of the query
            if (!Datasources::query_valid($formatted_view->datasource_id, $query, $message)) {
                $this->flashSession->error('<strong>Syntax invalid</strong><br />' . $message);
                return null;
            }

            // attempt to update the view
            Datasources::update_view($formatted_view->datasource_id, $formatted_view_id, $formatted_view->name, $query);

            // go back to list of databases
            $this->flashSession->success('View has been updated successfully');
            return $this->response->redirect('datasources/update_view/' . $formatted_view_id);
        } else {
            // read the view information for the datasource
            $formatted_view = FormattedViews::findFirst($formatted_view_id);

            // attach all information to post superglobal
            $_POST = $formatted_view->toArray();
        }

        $this->view->setVars([
            'formatted_view' => $formatted_view,
        ]);
    }

    public function delete_viewAction($formatted_view_id) {
        // make sure both a datasource id and view name were provided
        if (!$formatted_view_id) {
            return $this->response->redirect('datasources');
        }

        // get the formatted view information
        $formatted_view = FormattedViews::findFirst($formatted_view_id);

        // save the information to delete the view prior to the formatted view being deleted
        $datasource_id = $formatted_view->datasource_id;
        $formatted_view_name = $formatted_view->name;

        try {
            // attempt delete
            $formatted_view->delete();
        } catch (Exception $e) {
            switch ($e->getCode()) {
                case 23000:
                    $this->flashSession->error('This view cannot be removed because it is being used');
                    break;

                default:
                    $this->flashSession->error('View cannot be removed right now');
            }

            return $this->response->redirect('datasources/update_view/' . $formatted_view_id);
        }

        Datasources::delete_view($datasource_id, $formatted_view_name);

        $this->flashSession->success('View was successfully deleted');
        return $this->response->redirect('datasources');
    }

    public function ajax_view_data_setAction($formatted_view_id) {
        // get the formatted view information
        $formatted_view = FormattedViews::findFirst($formatted_view_id);

        // open the gateway
        $datasource =
            (new Gateway())->gen_datasource(
                $formatted_view->datasource_id,
                $formatted_view->name,
                Gateway::REGULAR);

        $data = $datasource->find();

        $this->view->setVars([
            'data'       => $data->toArray(),
            'data_count' => count($data)
        ]);
    }

}