{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">
                Datasources
                <a href="/datasources/create_datasource" class="btn btn-xs btn-primary pull-right">Create New Datasource</a>
            </h4>
            <table class="table table-condensed table-striped">
                <tr>
                    <th>Name</th>
                    <th class="center" style="width: 150px;">Host IP</th>
                    <th class="center" style="width: 80px;">Remove</th>
                </tr>
                {% for datasource in datasources %}
                    <tr>
                        <td>
                            {{ datasource.name }} ({{ datasource.database_name }})<br />
                            <ul>
                                {% for formatted_view in datasource.formatted_views %}
                                    <li><a href="/datasources/update_view/{{ formatted_view.formatted_view_id }}">{{ formatted_view.name }}</a></li>
                                {% endfor %}
                                <li><a href="/datasources/create_view/{{ datasource.datasource_id }}">Create View</a></li>
                            </ul>
                        </td>
                        <td class="center">{{ datasource.ip }}</td>
                        <td class="center"><a href="/datasources/delete_datasource/{{ datasource.datasource_id }}" onclick="bconfirm(this, 'Are you sure you want to delete this datasource?'); return false;">Remove</a></td>
                    </tr>
                {% endfor %}
            </table>
        </div>
    </div>
{% endblock %}