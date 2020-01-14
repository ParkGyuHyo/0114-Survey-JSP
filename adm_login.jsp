<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="./js/script.js?v=201912261437"></script>
        <link rel="stylesheet" type="text/css" href="./css/style.css?v=201912261427" />
        <link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
        
        <%
            String adm_id = (String)session.getAttribute("adm_id");
            session.setMaxInactiveInterval(60*30) ;

            if (adm_id == "" || adm_id == null) {
        %>
            <script type="text/javascript">
            $(function(){
                $(".f_cover").fadeIn(400);
                $(".lnbox").slideDown(700);
            });
            </script>
        <% }else{ %>
            <script type="text/javascript">
                $(function(){
                    location.href='./adm_main.jsp';
                });
            </script>
        <% } %>
    
    </head>
    <body class="wrapper">
        <div class="f_cover">
            <div class="lnbox">
                <p>관리자 로그인</p>
                <hr />
                <div class="lfrm">
                    <input type="text" id="adm_id" placeholder="관리자 아이디" />
                    <hr />
                    <input type="password" id="adm_pwd" placeholder="관리자 비밀번호" />
                </div>
                <input type="button" id="login_btn" class="ln_btn" value="로그인" />
            </div>
        </div>
    </body>
</html>