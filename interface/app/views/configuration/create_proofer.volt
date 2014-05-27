{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Create Proofer</h4>
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
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Create Proofer</button>
                    {{ link_to('configuration/proof_list', 'Back', 'class' : 'btn btn-default') }}
                </div>
            </form>
        </div>
    </div>
{% endblock %}