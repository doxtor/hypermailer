{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Campaign Information</h4>
            <form action="" method="post">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label>Campaign Name</label>
                            {{ text_field('name', 'class' : 'form-control') }}
                        </div>
                        <div class="form-group">
                            <label>Campaign Description</label>
                            {{ text_field('description', 'class' : 'form-control') }}
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Update Information</button>
            </form>
        </div>
    </div>
{% endblock %}