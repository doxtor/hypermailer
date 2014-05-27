{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Campaigns<a href="/send/create_campaign" class="btn btn-xs btn-primary pull-right">Create New Campaign</a></h4>
            <table class="table table-condensed table-striped">
                <tr>
                    <th>Name</th>
                    <th>Domain</th>
                    <th class="center" style="width: 150px;">Date Created</th>
                    <th class="center" style="width: 150px;">Date Started</th>
                    <th class="center" style="width:100px;">Status</th>
                    <th class="center" style="width: 80px;">Remove</th>
                </tr>
                {% for campaign in campaigns %}
                    <tr>
                        <td><a href="/send/campaign_summary/{{ campaign.campaign_id }}">{{ campaign.name }}</a></td>
                        <td>{{ campaign.domain.domain }}</td>
                        <td class="center">{{ campaign.date_created }}</td>
                        <td class="center">{{ campaign.date_started }}</td>
                        {% if campaign.date_started %}
                            <td class="center success">Started</td>
                        {% else %}
                            <td class="center warning">Pending</td>
                        {% endif %}
                        {% if campaign.date_started %}
                            <td></td>
                        {% else %}
                            <td class="center"><a href="/send/delete_campaign/{{ campaign.campaign_id }}" onclick="bconfirm(this, 'Are you sure you want to delete this campaign ?'); return false;">Remove</a></td>
                        {% endif %}
                    </tr>
                {% endfor %}
            </table>
        </div>
    </div>
{% endblock %}