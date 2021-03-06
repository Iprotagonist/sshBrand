<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>login</title>
    <link href="res/css/login.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">
        $("#login-button").click(function(event){
            event.preventDefault();
            $('form').fadeOut(500);
            $('.wrapper').addClass('form-success');
        });
        function check() {
            {
                if (form.username.value == "")//如果用户名为空
                {
                    alert("您还没有填写用户名！");
                    form.username.focus();
                    return false;
                }
                if (form.pass.value == "")//如果密码为空
                {
                    alert("您还没有填写密码！");
                    myform.pass.focus();
                    return false;
                }
            }
        }
    </script>
</head>
<body>
<div class="wrapper">
    <div class="container">
        <h1>Welcome</h1>

        <form name='form' class="form" method='post' action='login.php' onSubmit="return check()">
            <input type="text" placeholder="Username" name='username'>
            <input type="password" placeholder="Password" name='pass'>
            <button type="submit" id="login-button" name='submit' value='submit'>Login</button>
            <button type="submit" id="register-button"><a href="register.html" class="cc">register</a></button>
        </form>
    </div>

    <ul class="bg-bubbles">
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
    </ul>
</div>
</body>
</html>