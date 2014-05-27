{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">
                Users
                <a href="/configuration/create_user" class="btn btn-xs btn-primary pull-right">Create New User</a>
            </h4>
            <table class="table table-condensed table-striped">
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th class="center" style="width: 60px;">Edit</th>
                    <th class="center" style="width: 80px;">Remove</th>
                </tr>
                {% for user in users %}
                    <tr>
                        <td>{{ user.name }}</td>
                        <td>{{ user.email }}</td>
                        <td class="center"><a href="/configuration/update_user/{{ user.user_id }}">Edit</a></td>
                        <td class="center"><a href="/configuration/delete_user/{{ user.user_id }}" onclick="bconfirm(this, 'Are you sure you want to delete this user?'); return false;">Remove</a></td>
                    </tr>
                {% endfor %}
            </table>
        </div>
    </div>
{% endblock %}