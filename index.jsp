<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="./js/script.js?v=201912261430"></script>
        <link rel="stylesheet" type="text/css" href="./css/style.css?v=201912261428" />
        <link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
        
        <%
            String user_id = (String)session.getAttribute("user_id");
            session.setMaxInactiveInterval(60*30) ;

            if (user_id == "" || user_id == null) {
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
                    $(".f_cover").fadeIn(400);
                    $(".lnbox").slideDown(700);
                    //location.href='./user/sv_list.jsp';        
                });
            </script>
        <% } %>
    
    </head>
    <body class="wrapper">
        <div class="f_cover">
            <div class="lnbox">
                <p>유저 로그인</p>
                <hr />
                <div class="lfrm">
                    <input type="text" id="user_id" placeholder="유저 아이디" />
                    <hr />
                    <input type="password" id="user_pwd" placeholder="유저 비밀번호" />
                </div>
                <input type="button" id="rg_btn" class="cn_btn" value="회원가입" />
                <input type="button" id="login_btn" class="ln_btn" value="로그인" />
            </div>
        </div>
        <div class="f_cover2">
            <div class="rgbox">
                <p>유저 회원가입</p>
                <hr />
                <div class="rfrm">
                    <input type="text" name="user_id" placeholder="사용하실 아이디" />
                    <hr />
                    <input type="password" name="user_pwd" placeholder="비밀번호" />
                    <hr />
                    <input type="text" name="user_name" placeholder="성명" />
                    <hr />
                    <input type="date" name="user_birth" placeholder="생년월일" />
                    <hr />
                    <input type="radio" id="genderm" name="user_gender" value="M" checked/><label for="genderm"> 남자</label>
                    &nbsp;&nbsp;
                    <input type="radio" id="genderw" name="user_gender" value="W" /><label for="genderw"> 여자</label>
                </div>
                <input type="button" id="rg_cancel" class="cn_btn" value="취소" />
                <input type="button" id="rg_submit" class="ln_btn" value="가입" />
            </div>
        </div>
    </body>
</html>