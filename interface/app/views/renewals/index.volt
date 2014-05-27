{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">
                Renewal Emails
                <a href="/renewals/create" class="btn btn-xs btn-primary pull-right">Create New Renewal</a>
            </h4>
            <table class="table table-condensed table-striped">
                <tr>
                    <th>Renewal Name</th>
                    <th>View Name</th>
                    <th class="center" style="width: 60px;">Edit</th>
                    <th class="center" style="width: 80px;">Remove</th>
                </tr>
                {% for renewal in renewals %}
                    <tr>
                        <td>{{ renewal.name }}</td>
                        <td>{{ renewal.formatted_view.datasource.name }} - {{ renewal.formatted_view.name }}</td>
                        <td class="center"><a href="/renewals/update/{{ renewal.renewal_id }}">Edit</a></td>
                        <td class="center"><a href="/renewals/delete/{{ renewal.renewal_id }}" onclick="bconfirm(this, 'Are you sure you want to delete this renewal?'); return false;">Remove</a></td>
                    </tr>
                {% endfor %}
            </table>
        </div>
    </div>
{% endblock %}
