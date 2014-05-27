<!DOCTYPE html>
<html>
    <head>
        <title>Hypermailer | Email Simplified</title>

        <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="/css/main.css" rel="stylesheet">

        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/js/main.js"></script>

        <link rel="SHORTCUT ICON" href="/img/fav.png">
    </head>
    <body>
        <div class="container login">
            <div class="row">
                <div class="col-xs-12">
                    {% block content %}{% endblock %}
                </div>
            </div>
        </div>
    </body>
</html>