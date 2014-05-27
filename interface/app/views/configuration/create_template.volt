{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Create Template</h4>
            <form action="" method="post">
                <div class="form-group">
                    <label>Template Name</label>
                    {{ text_field('name', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <label>Template Header</label>
                    {{ text_area('header', 'rows' : '10', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <label>Template Footer</label>
                    {{ text_area('footer', 'rows' : '10', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Create Template</button>
                    {{ link_to('configuration/templates', 'Back', 'class' : 'btn btn-default') }}
                </div>
            </form>
        </div>
    </div>
{% endblock %}