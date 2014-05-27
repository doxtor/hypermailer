{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Update System Settings</h4>
            <form action="" method="post">
                <div class="form-group">
                    <label>MailGun API Key</label>
                    {{ text_field('apikey', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Update System Settings</button>
                    {{ link_to('dash', 'Back', 'class' : 'btn btn-default') }}
                </div>
            </form>
        </div>
    </div>
{% endblock %}