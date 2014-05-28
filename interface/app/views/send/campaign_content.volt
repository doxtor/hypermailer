{% extends 'layouts/master.volt' %}
{% block content %}
    <div class="row">
        <div class="col-xs-12">
            {{ flashSession.output() }}
            <h4 class="bar_style">Create Email Content</h4>
            <form action="" method="post">
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label>From Name</label>
                            {{ text_field('from_name', 'class' : 'form-control') }}
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label>From Email</label>
                            {{ text_field('from_email', 'class' : 'form-control') }}
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>Subject</label>
                    {{ text_field('subject', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <label for="templates">Template</label>
                    {{ select('template_id', templates,
                        'useEmpty'  : true,
                        'emptyText' : 'No Template',
                        'using'     : ['template_id','name'],
                        'class'     : 'form-control') }}
                </div>
                <div class="form-group">
                    <label>Content</label>
                    {{ text_area('content','rows':'12', 'class' : 'form-control') }}
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Update Email Contents</button>
                    <button type="button" class="btn btn-success preview"><i class="fa fa-search"></i> Preview</button>
                </div>
            </form>
        </div>
    </div>

    <hr />

    <script>
        $(function() {
            $('.preview').click(function() {
                $('.preview_content').load('/send/ajax_preview_campaign/',
                    {
                        'template_id' : $('#template_id').val(),
                        'content'     : $('#content').val()
                    });
            });
        });
    </script>
    <div class="preview_content" style="display: block;"></div>
{% endblock %}