{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">
                Templates
                <a href="/configuration/create_template" class="btn btn-xs btn-primary pull-right">Create New Template</a>
            </h4>
            <table class="table table-condensed table-striped">
                <tr>
                    <th>Name</th>
                    <th class="center" style="width: 60px;">Edit</th>
                    <th class="center" style="width: 80px;">Remove</th>
                </tr>
                {% for template in templates %}
                    <tr>
                        <td>{{ template.name }}</td>
                        <td class="center"><a href="/configuration/update_template/{{ template.template_id }}">Edit</a></td>
                        <td class="center"><a href="/configuration/delete_template/{{ template.template_id }}" onclick="bconfirm(this, 'Are you sure you want to delete this template ?'); return false;">Remove</a></td>
                    </tr>
                {% endfor %}
            </table>
        </div>
    </div>
{% endblock %}