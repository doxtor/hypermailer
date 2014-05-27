{% extends 'layouts/master.volt' %}
{% block content %}
    <script>
        $(function() {
            $('#name').blur(function(){
                var view_name = $(this).val();

                view_name = view_name.toLowerCase().replace(/[^a-z0-9_]/g, '');

                if (!view_name.match(/^hm_/)) {
                    view_name = 'hm_' + view_name;

                    $(this).val(view_name);
                }
            });
        });
    </script>
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Create View</h4>
            <form action="" method="post">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label>View Name (letters, numbers, and underscores)</label>
                            {{ text_field('name', 'class' : 'form-control') }}
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Create View</button>
                            {{ link_to('datasources', 'Back', 'class' : 'btn btn-default') }}
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
{% endblock %}