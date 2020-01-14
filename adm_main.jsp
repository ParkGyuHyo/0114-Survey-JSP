<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script type="text/javascript" src="./js/script.js?v=201912261319"></script>
        <link rel="stylesheet" type="text/css" href="./css/admin.css?v=201912161432" />
        <link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script|Sunflower:300&display=swap" rel="stylesheet">
        <title>SURVEY :: 관리자 페이지</title>
        <%
            String adm_id = (String)session.getAttribute("adm_id");
            String adm_name = (String)session.getAttribute("adm_name");
        %>
    </head>
    <body>
        <div class="header">
            <div class="logo">
                <p>APPBUTTON</p>
            </div>
            <div class="adm_info">
                <p>
                    <%= adm_name %>님
                    <input type="button" value="logout" />
                </p>
            </div>
        </div>
        <div class="lmenu_btn">
            <h2>▼</h2>
        </div>
        <div class="lmenu">
            <ul>
                <li>
                    <h3><a href="./adm_main.jsp">대시보드</a></h3>
                </li>
                <li>
                    <h3>설문조사 관리 ▼</h3>
                    <ul>
                        <li><a href="./sv_list.jsp">설문조사 목록</a></li>
                        <li>설문조사 상세 목록</li>
                    </ul>
                </li>
                <li>
                    <h3>유저 관리 ▼</h3>
                    <ul>
                        <li>관리자 관리</li>
                        <li>회원 관리</li>
                    </ul>
                </li>
                <li>
                    <h3>통계 ▼</h3>
                    <ul>
                        <li>설문조사 목록</li>
                        <li>설문조사 상세 목록</li>
                    </ul>
                </li>
            </ul>
            <h2>▲</h2>
        </div>

        <div class="dashboard">
            <h3>목록 이름</h3>
            <hr />
            <div class="wrapper">
                <div id="sv_list">

                </div>
                <div id="user_list">
                    
                </div>
                <div id="sv_chart">
                
                </div>
                <div id="sv_report">
            
                </div>
            </div>
        </div>

    </body>
</html>