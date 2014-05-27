{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Create Renewal</h4>
            <form action="" method="post">
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>Renewal Name</label>
                            {{ text_field('name', 'class' : 'form-control') }}
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>Domain</label>
                            {{ select('domain', static('Domains::find()'),
                                'useEmpty' : true,
                                'emptyText' : 'Please pick a domain',
                                'using' : ['domain','domain'],
                                'class' : 'form-control') }}
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>View Name</label>
                            {{ select('formatted_view_id', formatted_views,
                                'useEmpty' : true,
                                'emptyText' : 'Please pick a view',
                                'class' : 'form-control') }}
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>From Name</label>
                            {{ text_field('from_name', 'class' : 'form-control') }}
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>From Email</label>
                            {{ text_field('from_email', 'class' : 'form-control') }}
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>Subject Line</label>
                            {{ text_field('subject', 'class' : 'form-control') }}
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>Renewal Content</label>
                    {{ text_area('content', 'rows' : '20', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Create Renewal</button>
                    <button type="button" class="btn btn-success" onclick="$('.preview').html($('#content').val())"><i class="fa fa-search"></i> Preview</button>
                </div>
            </form>
        </div>
    </div>

    <hr />

    <div class="preview" style="display: block;"></div>
{% endblock %}