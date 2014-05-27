{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            <h4 class="bar_style">Hypermailer Events</h4>
            {{ flashSession.output() }}
            <table class="table table-condensed">
                <tr>
                    <th>Event Description</th>
                    <th class="right" style="width: 240px;">Event Date</th>
                </tr>
                {% for event in events %}
                    {% if event.type == constant('Events::SUCCESS') %}
                        {% set class = 'success' %}
                    {% elseif event.type == constant('Events::NOTICE') %}
                        {% set class = 'warning' %}
                    {% elseif event.type == constant('Events::ERROR') %}
                        {% set class = 'danger' %}
                    {% else %}
                        {% set class = '' %}
                    {% endif %}
                    <tr class="{{ class }}">
                        <td>{{ event.description }}</td>
                        <td class="right">{{ event.date }}</td>
                    </tr>
                {% endfor %}
            </table>
        </div>
    </div>
{% endblock %}