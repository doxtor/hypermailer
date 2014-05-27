{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Campaign Summary</h4>
            <div class="row">
                <div class="col-xs-12">
                    <dl class="dl-horizontal">
                        <dt>Domain:</dt>
                        <dd>{{ campaign.domain.domain }}</dd>
                        <dt>Name:</dt>
                        <dd>{{ campaign.name }}</dd>
                        <dt>Description:</dt>
                        <dd>{{ campaign.description }}</dd>
                        <dt>View:</dt>
                        <dd>{{ view }}</dd>
                        <dt>Email Count:</dt>
                        <dd>{{ data_count }}</dd>
                        <dt>Template:</dt>
                        <dd>{{ template }}</dd>
                    </dl>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <form action="/send/execute_campaign" method="post">
                        <button type="submit" class="btn btn-primary" onclick="bconfirm(this, 'Are you sure you want to send this campaign out?');return false;"><i class="fa fa-paper-plane-o"></i> Start Campaign</button>
                        {{ link_to('send/send_preview/' ~ campaign.campaign_id, '<i class="fa fa-search"></i> Send Preview', 'class' : 'btn btn-success') }}
                    </form>
                </div>
            </div>
        </div>
    </div>
{% endblock %}