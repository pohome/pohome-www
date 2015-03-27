<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta charset="utf-8">
        <title>管理员登录 - 汪汪喵呜孤儿院</title>
        
        <link href="/css/semantic.min.css" rel="stylesheet">
        <script src="/js/jquery-2.1.1.min.js"></script>
        <script src="/js/semantic.min.js"></script>
        
        <style type="text/css">
            body {
                background: rgb(76,174,200);
            }
            .main {
                width: 440px;
                margin: 200px auto;
                background: white;
                height: auto;
                -webkit-border-radius: 10px;
                overflow: hidden;
            }
            
            h1 {
                margin: 20px;
            }
            
            form {
                width: 400px;
                margin: 20px;
            }
        </style>
    </head>
    <body>
        <div class="main">
            <form method="post" class="ui form">
                <div class="field">
                    <label for="username">用户名</label>
                    <input name="username" type="text" />
                </div>
                <div class="field">
                    <label for="password">密码</label>
                    <input name="password" type="password" />
                </div>
                <div><input class="ui orange button" type="submit" /></div>
            </form>
        </div>
    </body>
</html>