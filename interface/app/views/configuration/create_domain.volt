{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Create Domain</h4>
            <form action="" method="post">
                <div class="form-group">
                    <label>Name</label>
                    {{ text_field('name', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <label>Domain</label>
                    {{ text_field('domain', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Create Domain</button>
                    {{ link_to('configuration/domains', 'Back', 'class' : 'btn btn-default') }}
                </div>
            </form>
        </div>
    </div>
{% endblock %}