{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">{{ flashSession.output() }}</div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <h1 class="center">{{ campaign.name }}</h1>
            <h4 class="center">{{ campaign.description }}</h4>

            <hr />

            <div class="row">
                <div class="col-xs-12 center">
                    <form action="/send/execute_campaign/{{ campaign.campaign_id }}" method="post">
                        <button type="submit" class="btn btn-danger" onclick="bconfirm(this, 'Are you sure you want to send this campaign out?'); return false;">
                            <i class="fa fa-paper-plane-o"></i> Start Campaign
                        </button>

                        <div style="display: inline-block; height: 60px; width: 8px; background: #000; vertical-align: middle;"></div>
                        <a href="send/send_preview/{{ campaign.campaign_id }}" class="btn btn-success" onclick="bconfirm(this, 'Are you sure you want to send a proof email out?'); return false;">
                            <i class="fa fa-search"></i> Send Preview
                        </a>
                        <button type="button" class="btn btn-success"><i class="fa fa-search"></i> View Recipients</button>
                        <a href="/send/campaign_info/{{ campaign.campaign_id }}" class="btn btn-primary"><i class="fa fa-bars"></i> Modify Basic Info</a>
                        <a href="/send/campaign_datasource/{{ campaign.campaign_id }}" class="btn btn-primary"><i class="fa fa-database"></i> Modify Datasource</a>
                        <a href="/send/campaign_content/{{ campaign.campaign_id }}" class="btn btn-primary"><i class="fa fa-paragraph"></i> Modify Content</a>
                    </form>
                </div>
            </div>

            <hr />
            <h3 class="center">
                Using Dataset <strong>{{ campaign.formatted_view.name }}</strong> which has a recipient count of <strong>{{ data_count }}</strong>
            </h3>
            <hr />

            <div class="row">
                <div class="col-xs-2 center">
                    <i class="fa fa-database" style="color: #666; font-size: 100px;"></i>
                </div>
                <div class="col-xs-4">
                    <h3 style="margin-top: 0;">Datasource Information</h3>
                    <h4>
                        <strong>Name:</strong> {{ campaign.formatted_view.datasource.name }}
                    </h4>
                    <h4>
                        <strong>Host:</strong> {{ campaign.formatted_view.datasource.ip }}
                    </h4>

                    <br />
                </div>
                <div class="col-xs-2 center">
                    <i class="fa fa-gear" style="color: #666; font-size: 100px;"></i>
                </div>
                <div class="col-xs-4">
                    <h3 style="margin-top: 0;">Mailgun Information</h3>
                    <h4>
                        <strong>Domain:</strong> {{ campaign.domain.domain }}
                    </h4>
                    <h4>
                        <strong>Mailgun ID:</strong> {{ campaign.mg_campaign_id }}
                    </h4>
                </div>
            </div>

            <hr />

            {% if stats %}
                <script type="text/javascript" src="https://www.google.com/jsapi"></script>
                <script type="text/javascript">
                    google.load('visualization', '1', { packages:['corechart'] });
                    google.setOnLoadCallback(drawChart);
                    function drawChart() {
                        var data = google.visualization.arrayToDataTable([
                            ['Task',          'Count',                              { role: 'style' }],
                            ['Delivered',     {{ stats.total.delivered }},          '#5CB85C'],
                            ['Dropped',       {{ stats.total.dropped }},            '#FF9829'],
                            ['Bounced',       {{ stats.total.bounced }},            '#D9534F'],
                            ['Unique Clicks', {{ stats.unique.clicked.recipient }}, '#5CB85C'],
                            ['Unique Opens',  {{ stats.unique.opened.recipient }},  '#428BCA' ],
                            ['Unsubscribes',  {{ stats.total.unsubscribed }},       '#FF9829' ],
                            ['Complaints',    {{ stats.total.complained }},         '#D9534F' ]
                        ]);

                        var options = {
                            title: 'Campaign Stats',
                            legend: { position: 'none' }
                        };

                        var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
                        chart.draw(data, options);
                    }
                    $(window).resize(function(){
                        drawChart();
                    });
                </script>
                <div id="chart_div" style="width: 100%; height: 350px;"></div>
            {% endif %}

            <hr />

            <div class="row">
                <div class="col-xs-12">
                    <div style="border-top: #666 8px solid; border-bottom: #666 8px solid;">
                        {{ campaign.template.header }}
                        {{ campaign.content }}
                        {{ campaign.template.footer }}
                    </div>
                </div>
            </div>
        </div>
    </div>
{% endblock %}