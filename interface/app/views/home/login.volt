{% extends 'layouts/master_login.volt' %}
{% block content %}
    <div class="shadowy" style="padding: 30px;">
        <div class="row">
            <div class="col-xs-12">
                <div class="row">
                    <div class="col-xs-12 center">
                        <img src="/img/logo.png" />
                        {{ flashSession.output() }}
                    </div>
                </div>
                <form action="" method="post">
                    <div class="row">
                        <div class="col-xs-5">
                            <div class="form-group">
                                {{ text_field('email',
                                    'class'       : 'form-control',
                                    'placeholder' : 'Email Address') }}
                            </div>
                        </div>
                        <div class="col-xs-4">
                            <div class="form-group">
                                {{ password_field('password',
                                    'class'       : 'form-control',
                                    'placeholder' : 'Password') }}
                            </div>
                        </div>
                        <div class="col-xs-3">
                            <button type="submit" class="btn btn-warning btn-block"><i class="fa fa-sign-out"></i> Login</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
{% endblock %}