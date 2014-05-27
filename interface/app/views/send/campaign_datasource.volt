{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Create Campaign</h4>
            <form action="" method="post">
                <div class="form-group">
                    <label for="datasource">Datasource - View</label>
                    {{ select('formatted_view_id', formatted_views,
                        'useEmpty' : true,
                        'emptyText' : 'Please pick a datasource/view',
                        'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Update Datasource</button>
                    <button type="button" class="btn btn-success view_data_set"><i class="fa fa-search"></i> View Data Set</button>
                </div>
            </form>
        </div>
    </div>

    <hr />

    <script>
        $(function() {
            $('.view_data_set').click(function() {
                if ($('#formatted_view_id').val() !== '') {
                    $('.data_set').show();
                    $('.data_set').load('/datasources/ajax_view_data_set/' + $("#formatted_view_id").val());
                } else {
                    bootbox.alert('You must select a datasource/view to view the data set');
                }
            });
        });
    </script>
    <div style="height: 300px;"></div>
    <div class="data_set" style="display: none; position: fixed; width: 100%; bottom: 0; left: 0; overflow: auto; height: 300px; background: #fff; border-top: #000 3px solid;"></div>
{% endblock %}