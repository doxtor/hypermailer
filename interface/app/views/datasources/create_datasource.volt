{% extends 'layouts/master.volt' %}
{% block content %}
    <script>
        $(function() {
            $('.execute_verification').click(function() {
                $.post('/datasources/test_connection',
                {
                    'ip'            : $('#ip').val(),
                    'username'      : $('#username').val(),
                    'password'      : $('#password').val(),
                    'database_name' : $('#database_name').val()
                },
                function(data) {
                    // zero the messages
                    $('.verify_message').css('color','#00d');
                    $('.verify_message').html('Verifying...');
                    $('.verify_details').html('');

                    if (data.status === 0) {
                        // link established
                        $('.verify_message').css('color','#0a0');
                        $('.verify_message').html('Verification Succeeded');
                        $('.verify_details').html('Please add a friendly name and click create');

                        // disable verify button and text boxes
                        $('.execute_verification').prop('disabled', true);
                        $('#ip').prop('readonly', true);
                        $('#username').prop('readonly', true);
                        $('#password').prop('readonly', true);
                        $('#database_name').prop('readonly', true);

                        // enable create button
                        $('.execute_creation').prop('disabled', false);
                    } else {
                        $('.verify_message').css('color','#d00');
                        $('.verify_message').html('Verification Failed');
                        $('.verify_details').html(data.payload);
                    }
                },
                'json');
            });
        });
    </script>
    <div class="row">
        <div class="col-xs-12">
            <h4 class="bar_style">Create Datasource Link</h4>
            <form action="" method="post">
                <div class="row">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label>Friendly Name</label>
                            {{ text_field('name', 'class' : 'form-control') }}
                        </div>
                        <div class="form-group">
                            <label>Host IP</label>
                            {{ text_field('ip', 'class' : 'form-control') }}
                        </div>
                        <div class="form-group">
                            <label>Username</label>
                            {{ text_field('username', 'class' : 'form-control') }}
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            {{ text_field('password', 'class' : 'form-control') }}
                        </div>
                        <div class="form-group">
                            <label>Database Name</label>
                            {{ text_field('database_name', 'class' : 'form-control') }}
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-success btn-block execute_verification"><i class="fa fa-check"></i> Verify Link</button>
                            </div>
                            <div class="col-xs-6">
                                <button type="submit" class="btn btn-primary btn-block execute_creation" disabled><i class="fa fa-check"></i> Create Datasource</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6 center">
                        <div class="well well-sm center">
                            Messages
                        </div>
                        <h3 class="verify_message">Awaiting Verification</h3>
                        <h5 class="verify_details"></h5>
                    </div>
                </div>
            </form>
        </div>
    </div>
{% endblock %}