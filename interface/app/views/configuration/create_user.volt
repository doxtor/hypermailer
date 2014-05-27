{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Create User</h4>
            <form action="" method="post">
                <div class="form-group">
                    <label>Name</label>
                    {{ text_field('name', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <label>Email</label>
                    {{ text_field('email', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <label>Password</label>
                    {{ password_field('password', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Create User</button>
                    {{ link_to('configuration/users', 'Back', 'class' : 'btn btn-default') }}
                </div>
            </form>
        </div>
    </div>
{% endblock %}