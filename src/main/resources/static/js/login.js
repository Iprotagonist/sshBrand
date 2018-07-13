jQuery(document).ready(function () {
    /*
        Form validation
    */
    $('.login-form input[type="text"], .login-form input[type="password"]').on('focus', function () {
        $(this).removeClass('input-error');
    });

    $('.login-form').on('submit', function (e) {

        $(this).find('input[type="text"], input[type="password"]').each(function () {
            if ($(this).val() == "") {
                e.preventDefault();
                $(this).addClass('input-error');
            }
            else {
                $(this).removeClass('input-error');

                var json = {
                    username: $('#form-username').val(),
                    password: $('#form-password').val()
                }

                $.post('/emp/login', json, function (data) {
                    if(data.success){
                        window.location.href="/brand/toMain";
                    }else{
                        window.location.href="/emp/toLogin";
                    }
                });
            }
        });

    });
});
