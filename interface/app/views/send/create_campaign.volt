{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Create Campaign</h4>
            <form action="" method="post">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label>Domain Name</label>
                            {{ select('domain_id', static('Domains::find()'),
                                'useEmpty'  : true,
                                'emptyText' : 'Select a domain',
                                'using'     : ['domain_id','domain'],
                                'class'     : 'form-control') }}
                        </div>
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
                <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Create Campaign</button>
                {{ link_to('send/campaigns', 'Back', 'class' : 'btn btn-default') }}
            </form>
        </div>
    </div>
{% endblock %}