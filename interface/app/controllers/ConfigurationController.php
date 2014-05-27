<?php

class ConfigurationController extends BaseController {

    public function beforeExecuteRoute() {
        // return to login if user is logged out
        Authenticator::enforce_login();
    }

    public function create_templateAction() {
        if ($this->request->isPost()) {
            $template = new Templates();

            if ($template->create($_POST)) {
                // success
                $this->flashSession->success('Template was created successfully');

                return $this->response->redirect('configuration/templates');
            } else {
                // failed validation
                $this->flashSession->error($template->get_val_errors());
            }
        }
    }

    public function templatesAction() {
        $this->view->setVars([
            'templates' => Templates::find()
        ]);
    }

    public function update_templateAction($template_id) {
        $template = Templates::findFirst($template_id);

        if (!$template) {
            // invalid template sent
            $this->flashSession->error('Template was not found');

            return $this->response->redirect('configuration/templates');
        }

        if ($this->request->isPost()) {
            if ($template->update($_POST)) {
                // success
                $this->flashSession->success('Template was updated successfully');

                return $this->response->redirect('configuration/templates');
            } else {
                // failed validation
                $this->flashSession->error($template->get_val_errors());
            }
        } else {
            // set the template info to the post superglobal
            $_POST = $template->toArray();
        }
    }

    public function delete_templateAction($template_id) {
        $template = Templates::findFirst($template_id);

        if (!$template) {
            // invalid template sent
            $this->flashSession->error('Template was not found');

            return $this->response->redirect('configuration/templates');
        }

        try {
            // attempt delete
            $template->delete();
        } catch (Exception $e) {
            switch ($e->getCode()) {
                case 23000:
                    $this->flashSession->error('This template cannot be removed because it is being used');
                    break;

                default:
                    $this->flashSession->error('Template cannot be removed right now');
            }

            return $this->response->redirect('configuration/templates');
        }

        // success
        $this->flashSession->success('Template was deleted successfully');
        return $this->response->redirect('configuration/templates');
    }

    public function create_domainAction() {
        if ($this->request->isPost()) {
            $domain = new Domains();

            if ($domain->create($_POST)) {
                // success
                $this->flashSession->success('Domain was created successfully');

                return $this->response->redirect('configuration/domains');
            } else {
                // failed validation
                $this->flashSession->error($domain->get_val_errors());
            }
        }
    }

    public function domainsAction() {
        $domains = Domains::find();

        $this->view->setVars([
            'domains' => $domains
        ]);
    }

    public function update_domainAction($domain_id) {
        $domain = Domains::findFirst($domain_id);

        if (!$domain) {
            // invalid domain sent
            $this->flashSession->error('Domain was not found');

            return $this->response->redirect('configuration/domains');
        }

        if ($this->request->isPost()) {
            if ($domain->update($_POST)) {
                // success
                $this->flashSession->success('Domain was updated successfully');

                return $this->response->redirect('configuration/domains');
            } else {
                // failed validation
                $this->flashSession->error($domain->get_val_errors());
            }
        } else {
            // set the domain info to the post superglobal
            $_POST = $domain->toArray();
        }
    }

    public function delete_domainAction($domain_id) {
        $domain = Domains::findFirst($domain_id);

        if (!$domain) {
            // invalid domain sent
            $this->flashSession->error('Domain was not found');

            return $this->response->redirect('configuration/domains');
        }

        try {
            // attempt delete
            $domain->delete();
        } catch (Exception $e) {
            switch ($e->getCode()) {
                case 23000:
                    $this->flashSession->error('This domain cannot be removed because it is referenced in a campaign');
                    break;

                default:
                    $this->flashSession->error('Domain cannot be removed right now');
            }

            return $this->response->redirect('configuration/domains');
        }

        // success
        $this->flashSession->success('Domain was deleted successfully');
        return $this->response->redirect('configuration/domains');
    }

    public function create_prooferAction() {
        if ($this->request->isPost()) {
            $proofer = new ProofList();

            if ($proofer->create($_POST)) {
                // success
                $this->flashSession->success('Proofer was created successfully');

                return $this->response->redirect('configuration/proof_list');
            } else {
                // failed validation
                $this->flashSession->error($proofer->get_val_errors());
            }
        }
    }

    public function proof_listAction() {
        $proofers = ProofList::find();

        $this->view->setVars([
            'proofers' => $proofers
        ]);
    }

    public function update_prooferAction($proof_list_id) {
        $proofer = ProofList::findFirst($proof_list_id);

        if (!$proofer) {
            // invalid proofer sent
            $this->flashSession->error('Proofer was not found');

            return $this->response->redirect('configuration/proof_list');
        }

        if ($this->request->isPost()) {
            if ($proofer->update($_POST)) {
                // success
                $this->flashSession->success('Proofer was updated successfully');

                return $this->response->redirect('configuration/proof_list');
            } else {
                // failed validation
                $this->flashSession->error($proofer->get_val_errors());
            }
        } else {
            // set the proofer info to the post superglobal
            $_POST = $proofer->toArray();
        }
    }

    public function delete_prooferAction($proof_list_id) {
        $proofer = ProofList::findFirst($proof_list_id);

        if (!$proofer) {
            // invalid proofer sent
            $this->flashSession->error('Proofer was not found');

            return $this->response->redirect('configuration/proof_list');
        }

        if (!$proofer->delete()) {
            // constraint error
            $this->flashSession->error('Proofer cannot be deleted right now.');

            return $this->response->redirect('configuration/proof_list');
        }

        // success
        $this->flashSession->success('Proofer was deleted successfully');

        return $this->response->redirect('configuration/proof_list');
    }

    public function systemAction() {
        if ($this->request->isPost()) {
            // loop through each post value
            foreach ($this->request->getPost() as $key => $value) {
                // get a record based on the key
                $system = System::findFirstByKey($key);

                // check if there was a record
                if ($system) {
                    // there was, update
                    $system->value = $value;
                    $system->update();

                } else {
                    $newsystem = new System();
                    $newsystem->key = $key;
                    $newsystem->value = $value;
                    $newsystem->create();

                }
                $this->flashSession->success('System Settings have been updated successfully');
            }
        }

        // get the system information
        $system = System::find();

        // create the array for the system variables
        $system_variables = [];

        // loop through each system setting to form a single array of those settings
        foreach ($system as $value) {
            $system_variables[$value->key] = $value->value;
        }

        $_POST = $system_variables;
    }

    public function create_userAction() {
        if ($this->request->isPost()) {
            // check if the email is already taken
            $user = Users::findFirstByEmail($this->request->getPost('email'));

            // is the host name taken?
            if ($user) {
                $this->flashSession->error('Email is already being used, please choose a different one');
                return null;
            }

            // create the user
            $user = new Users();
            $user->name  = $this->request->getPost('name');
            $user->email = $this->request->getPost('email');

            // add the password only if it has changed
            if ($this->request->getPost('password')) {
                $user->password  = $this->request->getPost('password');
            }

            if (!$user->create()) {
                $this->flashSession->error($user->get_val_errors());
                return null;
            }

            // success
            $this->flashSession->success('User created successfully');

            // redirect to course list
            return $this->response->redirect('configuration/users');
        }
    }

    public function usersAction() {
        $users = Users::find();

        $this->view->setVars([
            'users' => $users
        ]);
    }

    public function update_userAction($user_id) {
        if ($this->request->isPost()) {
            // get the user information
            $user = Users::findFirst($user_id);

            if (!$user) {
                $this->flashSession->error('This user does not exist');
                return $this->response->redirect('configuration/users');
            }

            // check if a new password was supplied
            if ($this->request->getPost('password')) {
                // does password meet min length of 8
                if (preg_match('/^.{6,64}$/', $this->request->getPost('password'))) {
                    // it does, hash the new password
                    $user->password = $this->request->getPost('password');
                } else {
                    // failed (validation)
                    $this->flashSession->error('Password must be at least 8 characters');
                    return null;
                }
            }

            // update the user information
            $user->name  = $this->request->getPost('name');
            $user->email = $this->request->getPost('email');

            if (!$user->update()) {
                // failed (validation)
                $this->flashSession->error($user->get_val_errors());
                return null;
            }

            // success
            $this->flashSession->success('User updated successfully');

            // redirect to course list
            return $this->response->redirect('configuration/users');
        } else {
            $_POST = Users::findFirst($user_id)->toArray();
            unset($_POST['password']);
        }
    }

    public function delete_userAction($user_id) {
        // retrieve the datasource
        $user = Users::findFirst($user_id);

        if (!$user) {
            // no datasource found
            $this->flashSession->error('Could not find a user with this id');
            return $this->response->redirect('configuration/users');
        }

        if ($user->delete()) {
            // success
            $this->flashSession->success('User deleted successfully');
            return $this->response->redirect('configuration/users');
        } else {
            // failed (constraint or unknown)
            $this->flashSession->error('Could not delete this user right now');
            return $this->response->redirect('configuration/users');
        }
    }

    public function mailgun_domain_importAction() {
        try {
            // create a new mailgun instance
            $mg = new MailGunAPI();

            // attempt to retrieve a list of domains
            $domains = $mg->get_domains()->http_response_body->items;

            // place to hold the number of domains that were created via this script
            $domain_counter = 0;

            foreach ($domains as $domain) {
                // check to see if the domain is already in the database
                $test_domain = Domains::findFirstByDomain($domain->name);

                // check if there was a result
                if ($test_domain) {
                    // there was, domain exists, restart iteration
                    continue;
                }

                // increment the domain counter
                ++$domain_counter;

                // strip off tld
                $formatted_name = preg_replace('/\.[a-z]+$/', '', $domain->name);

                // explode the remainder on periods
                $formatted_name_pieces = explode('.', $formatted_name);

                // place to hold the final formatted name
                $final_formatted_name = '';

                // string together ucwords on each piece and a space
                foreach ($formatted_name_pieces as $piece) {
                    $final_formatted_name .= ucwords($piece) . ' ';
                }

                // trim the final result
                $final_formatted_name = trim($final_formatted_name);

                // create a new domain
                $new_domain = new Domains();

                $new_domain->name   = $final_formatted_name;
                $new_domain->domain = $domain->name;

                if (!$new_domain->create()) {
                    // failed
                    $this->flashSession->error('One or more domains could not be imported');
                    return null;
                }
            }

            // success
            if ($domain_counter) {
                // at least one domain imported
                $this->flashSession->success($domain_counter . ' domains have been imported successfully');
            } else {
                // no domains imported
                $this->flashSession->success('Operation was successful, but no domains were imported');
            }
        } catch (Exception $e) {
            $this->flashSession->error('Mailgun error occurred');
        }

        return $this->response->redirect('configuration/domains');
    }

}