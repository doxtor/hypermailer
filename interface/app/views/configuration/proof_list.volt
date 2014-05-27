{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">
                Proof List
                <a href="/configuration/create_proofer" class="btn btn-xs btn-primary pull-right">Create New Proofer</a>
            </h4>
            <table class="table table-condensed table-striped">
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th class="center" style="width: 60px;">Edit</th>
                    <th class="center" style="width: 80px;">Remove</th>
                </tr>
                {% for proofer in proofers %}
                    <tr>
                        <td>{{ proofer.name }}</td>
                        <td>{{ proofer.email }}</td>
                        <td class="center"><a href="/configuration/update_proofer/{{ proofer.proof_list_id }}">Edit</a></td>
                        <td class="center"><a href="/configuration/delete_proofer/{{ proofer.proof_list_id }}" onclick="bconfirm(this, 'Are you sure you want to delete this proofer?'); return false;">Remove</a></td>
                    </tr>
                {% endfor %}
            </table>
        </div>
    </div>
{% endblock %}