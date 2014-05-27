{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">
                Domains
                <a href="/configuration/create_domain" class="btn btn-xs btn-primary pull-right">Create New Domain</a>
                <a href="/configuration/mailgun_domain_import" class="btn btn-xs btn-danger pull-right" onclick="bconfirm(this, 'This will load all domains from Mailgun to Hypermailer that aren\'t already present in your domain list. Continue?'); return false;">Import From Mailgun</a>
            </h4>
            <table class="table table-condensed table-striped">
                <tr>
                    <th>Name</th>
                    <th>Domain</th>
                    <th class="center" style="width: 80px;">Edit</th>
                    <th class="center" style="width: 80px;">Remove</th>
                </tr>
                {% for domain in domains %}
                    <tr>
                        <td>{{ domain.name }}</td>
                        <td>{{ domain.domain }}</td>
                        <td class="center"><a href="/configuration/update_domain/{{ domain.domain_id }}">Edit</a></td>
                        <td class="center"><a href="/configuration/delete_domain/{{ domain.domain_id }}" onclick="bconfirm(this, 'Are you sure you want to delete this domain?'); return false;">Remove</a></td>
                    </tr>
                {% endfor %}
            </table>
        </div>
    </div>
{% endblock %}