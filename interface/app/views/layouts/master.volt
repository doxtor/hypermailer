<!DOCTYPE html>
<html>
    <head>
        <title>Hypermailer | Email Simplified</title>

        <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="/css/main.css" rel="stylesheet">

        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/bootbox.js/4.2.0/bootbox.min.js"></script>
        <script type="text/javascript" src="/js/main.js"></script>

        <link rel="SHORTCUT ICON" href="/img/fav.png">
    </head>
    <body>
        <div class="container">
            <div class="row" style="border-bottom: #eaeaea 1px solid;">
                <div class="col-xs-3">
                    <img src="/img/logo.png" />
                </div>
                <div class="col-xs-9 right">
                    <div class="menu">
                        <a href="/dash"><i class="fa fa-tachometer"></i> Dash</a>
                        <a href="/datasources"><i class="fa fa-bolt"></i> Datasources</a>
                        <a href="/send/campaigns"><i class="fa fa-envelope"></i> Campaigns</a>
                        <a href="/renewals"><i class="fa fa-refresh"></i> Renewals</a>
                        <div class="dropdown left" style="display: inline-block;">
                            <a href="#" data-toggle="dropdown"><i class="fa fa-cogs"></i> Config<span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="/configuration/domains">Domains</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="/configuration/proof_list">Proof List</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="/configuration/system">System</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="/configuration/templates">Templates</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="/configuration/users">Users</a></li>
                            </ul>
                        </div>
                        <a href="/documentation"><i class="fa fa-book"></i> Docs</a>
                        <a href="/home/logout"><i class="fa fa-sign-out"></i> Logout</a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    {% block content %}{% endblock %}
                </div>
            </div>
        </div>
    </body>
</html>