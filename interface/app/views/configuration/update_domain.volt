{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Update Domain</h4>
            <form action="" method="post">
                <div class="form-group">
                    <label>Name</label>
                    {{ text_field('name', 'class' : 'form-control') }}
                </div>
                <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Update Domain</button>
                {{ link_to('configuration/domains', 'Back', 'class' : 'btn btn-default') }}
            </form>
        </div>
    </div>
{% endblock %}