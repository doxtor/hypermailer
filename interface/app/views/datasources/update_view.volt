{% extends 'layouts/master.volt' %}
{% block content %}
    <script>
        $(function() {
            $('#query').keypress(function() {
                // disable view data set button
                $('.view_data_set').prop('disabled', true);
            });

            $('.view_data_set').click(function() {
                $('.data_set').show();
                $('.data_set').load('/datasources/ajax_view_data_set/{{ formatted_view.formatted_view_id }}');
            });
        });
    </script>
    <div class="row">
        <div class="col-xs-12">
            <h4 class="bar_style">Update View - {{ formatted_view.name }}</h4>
            {{ flashSession.output() }}
            <form action="" method="post">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label>MySQL Query</label>
                            {{ text_area('query', 'rows' : '20', 'class' : 'form-control', 'style' : 'font-family: courier;') }}
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Update View</button>
                        <button type="button" class="btn btn-success view_data_set"><i class="fa fa-search"></i> View Data Set</button>
                        <a href="/datasources/delete_view/{{ formatted_view.formatted_view_id }}" class="btn btn-danger pull-right" onclick="return confirm('Are you sure you want to delete this view?')"><i class="fa fa-times"></i> Delete View</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <hr />

    <div style="height: 300px;"></div>
    <div class="data_set" style="display: none; position: fixed; width: 100%; bottom: 0; left: 0; overflow: auto; height: 300px; background: #fff; border-top: #000 3px solid;"></div>
{% endblock %}