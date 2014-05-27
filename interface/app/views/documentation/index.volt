{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row" style="margin-bottom: 50px;">
        <div class="col-xs-3">
            <style>.affix { top: 0px; }</style>
            <div class="configuration_menu" data-spy="affix" data-offset-top="92">
                <h3 class="bar_style center">Documentation</h3>
                <a href="#">Introduction<i class="fa fa-chevron-right"></i></a>
                <a href="#license">License<i class="fa fa-chevron-right"></i></a>
                <a href="#installation">Installation<i class="fa fa-chevron-right"></i></a>
                <a href="#mailgunsetup">Mailgun Setup<i class="fa fa-chevron-right"></i></a>
                <a href="#dashboard">Dashboard<i class="fa fa-chevron-right"></i></a>
                <a href="#datasources">Datasources<i class="fa fa-chevron-right"></i></a>
                <a href="#campaigns">Campaigns<i class="fa fa-chevron-right"></i></a>
                <a href="#renewals">Renewals<i class="fa fa-chevron-right"></i></a>
                <a href="#domains">Domains<i class="fa fa-chevron-right"></i></a>
                <a href="#templates">Templates<i class="fa fa-chevron-right"></i></a>
                <a href="#prooflist">Proof List<i class="fa fa-chevron-right"></i></a>
                <a href="#users">Users<i class="fa fa-chevron-right"></i></a>
                <div style="display: block; text-align: center;">
                    <i class="fa fa-arrow-circle-up fa-4x" style="color: #999; margin-top: 35px; " onclick="$('html, body').animate({ scrollTop: 0 }, 700)"></i>
                </div>
            </div>
        </div>
        <div class="col-xs-9">
            <h3 class="bar_style">Hypermailer Documentation</h3>
            <h3 id="introduction">Introduction</h3><br />
            Hypermailer is an open source project aimed at leveraging Mailgun APIs to provide a free platform that
            operates on the usage only billing of Mailgun. This project will continuously evolve and is currently the
            only open source email platform leveraging Mailgun's APIs. All project files and source code are available on
            GitHub.

            <br /><br />

            <a href="https://github.com/ebrian/hypermailer" target="_blank" class="btn btn-lg btn-default"><i class="fa fa-github"></i> GitHub Project Page</a>

            <hr />

            <h3 id="license">License</h3><br />
            Hypermailer is released under the <a href="http://opensource.org/licenses/GPL-3.0" target="_blank">GNU General Public License, version 3 (GPL-3.0)</a>.

            <hr />
            
            <h3 id="installation">Installation</h3><br />
            Hypermailer has the following dependencies:
            
            <br /><br />
            
            <ul>
                <li>PHP 5.4 +</li>
                <li>MySQL 5 +</li>
                <li><a href="http://phalconphp.com" target="_blank">Phalcon Framework 1.2.6</a></li>
                <li>Root access to your server (to install Phalcon Framework 1.2.6)</li>
            </ul>

            <br />

            Hypermailer ships with an install script for RHEL based systems. This script will, at your discretion,
            install Phalcon Framework 1.2.6, create a new database and install all base tables, and create the
            Hypermailer configuration file. To take advantage of this script, run the following command and follow the
            instructions on the screen:

            <br /><br />

            <div class="well well-sm">
                sudo python /path/to/hypermailer/scripts/install.py
            </div>

            <hr />

            <h3 id="mailgunsetup">Mailgun Setup</h3><br />
            There are a few things you'll need to do on your own to get Mailgun setup:

            <br /><br />

            <ul>
                <li>Create a Mailgun account and generate an API key if not already accomplished for you</li>
                <li>Go to Config > System and add that API key in there</li>
                <li>
                    Add each domain that you intend to send email from. There are API references for domain creation,
                    but, none that verify the domain in the DNS. It was determined that this is easier handled directly
                    in the Mailgun control panel.

                    <br /><br />

                    <div class="alert alert-info well-sm">
                        <strong>Note:</strong> After you create the domains, Hypermailer can import those into your system.
                        To take advantage of this feature, click the "Import From Mailgun" button from the Config > Domains
                        section. This will not replace any domains that you've already created.
                    </div>
                </li>
            </ul>

            <hr />

            <h3 id="dashboard">Dashboard</h3><br />
            The dashboard is a place that has an event log which will log key events in the system. Events that it will
            log include:

            <br /><br />

            <ul>
                <li>Renewal script invocation and statuses</li>
                <li>Campaign invocation and statuses</li>
                <li>System health</li>
            </ul>

            <hr />

            <h3 id="datasources">Datasources</h3><br />
            Datasources are created to give you the ability to pull mailing lists views from them. To
            create a datasource, you must provide a friendly name, server ip, username/password combo, and the database
            to connect to. Once a database link is established, you can add views that contain a list of email recipients
            to send to. Each datasource is broken up into two parts:

            <br /><br />

            <ul>
                <li>
                    <strong>Connection Details</strong><br />
                    Credentials are inputted here and the link to the datasource must be verified before it can be saved.
                    Because datasources contain special user information and configuration that wouldn't be present on a
                    foreign system, datasources cannot be edited. Instead, they should either be re-created or a new
                    datasource that represents a new system created in parallel.
                    <br /><br />
                    <div class="alert alert-info well-sm">
                        <strong>Note:</strong> Hypermailer automatically creates serialized users of different
                        permission sets automatically when you create a new datasource. These users include a super
                        user as well as a regular user. Regular users are granted only SELECT permissions and are used
                        when creating views to prevent accidental database destruction by users of Hypermailer or
                        hackers who compromised the system. Hypermailer generated users can be identified as users that have
                        a prefix of "hm".
                    </div>
                    <div class="alert alert-warning well-sm">
                        <strong>Warning:</strong> If you manually delete a Hypermailer generated user from your database then
                        that particular datasource will not be able to be used anymore.
                    </div>
                </li>
                <li>
                    <strong>Views</strong><br />
                    At present, views are standard MySQL views that represent a particular data set which are created
                    using standard MySQL until such time a view builder is created. Views can contain any standard SQL
                    that you would expect from a mysql terminal.

                    <br /><br />

                    Each dataset <strong>must</strong>
                    contain a field called "email_address." If there is no field called "email_address," then an alias
                    should be created in the view.<br /><br />

                    <strong>Example:</strong>
                    <div class="well well-sm">
                        select main_email as email_address from people;
                    </div>

                    <div class="alert alert-warning well-sm">
                        <strong>Warning:</strong> If an "email_address" field is not present, the campaign email will be skipped and an event logged
                    </div>
                </li>
            </ul>

            <hr />

            <h3 id="campaigns">Campaigns</h3><br />
            Campaigns

            <hr />

            <h3 id="renewals">Renewals (fixed and recurring)</h3><br />
            Renewals are optional but are executed via a cron job set to run at a specified time. The entry you should
            make into the crontab if you desire is:

            <br /><br />

            <div class="well well-sm">
                * 8 0 0 0 /path/to/hypermailer/micro_cron/hm.sh --send-renewals # send at 8am daily
            </div>

            Inside of the Renewals section, you will be able to create, update, and delete renewal emails. Each
            renewal email will require, at a minimum:

            <br /><br />
            <ul>
                <li>Name</li>
                <li>View Name</li>
                <li>MailGun Campaign ID</li>
                <li>From Email</li>
                <li>From Name</li>
                <li>Email Subject</li>
                <li>Email Content</li>
            </ul>

            <hr />

            <h3 id="domains">Domains</h3><br />
            The domain list is a list of domains that are in Mailgun that you intend to use with Hypermailer. Domains
            must be set up manually in Mailgun which generally involves the following 3 steps:

            <br /><br />

            <ul>
                <li><a href="https://mailgun.com/cp/domains" target="_blank">Create the domain in Mailgun</a></li>
                <li>Set the appropriate DNS records on your DNS server for the domain you just created</li>
                <li>Verify the DNS settings with Mailgun and confirm that everything is good</li>
            </ul>

            <br />

            Once you have set up the domains in Mailgun, go to <a href="/configuration/domains">domains</a> and click
            on "Import From Mailgun" to import the domains you just set up into Hypermailer.

            <br /><br />

            <div class="alert alert-info well-sm">
                <strong>Note:</strong> The "Import From Mailgun" function will not delete, overwrite, or replace any
                existing domains; only add new ones.
            </div>

            <div class="alert alert-warning well-sm">
                <strong>Warning:</strong> If you set up a domain in Hypermailer <strong>but not</strong> Mailgun, that
                domain will not function.
            </div>

            <hr />

            <h3 id="templates">Templates</h3><br />
            Templates are used for email campaigns that go out that normally contain a common header and footer in
            the email. Newsletters are a perfect example of this. Generally, with a newsletter, the header and footer
            always stay the same but the content changes. During campaign creation, you can select a template and paste
            in the content and preview what the email will look like with the content inserted into the template.

            <hr />

            <h3 id="prooflist">Proof List</h3><br />
            The Proof List is used to list a set of recipients that normally get the preview of an email campaign
            before it actually goes out. These users will receive a proof email when the preview button on the campaign
            summary page is pressed.

            <hr />

            <h3 id="users">Users</h3><br />
            Users are used simply for the purpose of logging into the system. They currently have no other use besides
            that.

            <br /><br />

            <div class="alert alert-info well-sm">
                <strong>Note:</strong> There is not currently any logging capabilities with Hypermailer, so, users
                can be deleted and re-added without a loss of referrential integrity.
            </div>
        </div>
    </div>
{% endblock %}