Util = {

    params : function(name) {
        // convert full querystring array
        name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");

        // retrieve querystring value based on the name
        var regexS = "[\\?&]" + name + "=([^&#]*)";
        var regex = new RegExp(regexS);
        var results = regex.exec(window.location.search);

        if(results == null)
            return "";
        else
            return decodeURIComponent(results[1].replace(/\+/g, " "));
    },

    open_tabs : function() {
        var q = Util.params('t');

        if (q !== undefined) {
            $('#the_tabs a[href="#' + q + '"]').tab('show');
        }
    }

};

// bootbox confirm integration
function bconfirm(siht, message) {
    bootbox.confirm(message, function(result) {
        if (result) {
            if ($(siht).is('a')) {
                location.href = $(siht).attr('href');
            } else {
                $(siht).closest('form').submit();
            }
        }
    });
}