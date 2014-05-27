<h3>Records found: {{ data_count }}</h3>
{% if data[0] %}
    <table class="table">
        <tr>
            {% for field, value in data[0] %}
                <th>{{ field }}</th>
            {% endfor %}
        </tr>
        {% for row in data %}
            <tr>
                {% for value in row %}
                    <td>{{ value }}</td>
                {% endfor %}
            </tr>
        {% endfor %}
    </table>
{% else %}
    Data Set appears to be empty
{% endif %}