<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="sv_list_sql.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="./js/script.js?v=1"></script>
        <link rel="stylesheet" type="text/css" href="./css/style.css?v=201912261432" />
        <link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet"> 
    </head>
    <body>
        <header>
            <h1 class="list_subject">설문조사 목록</h1>
            <p>[<%=user_id%>] 님 반갑습니다.</p>
        </header>
        <section>
            <article class="ctr_warp" id="sv_tlist">
                <table width="100%" cellspacing="50">
                    <colgroup>
                        <col width="70%" />
                        <col width="15%" />
                        <col width="15%" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th>no</th>
                        <th scope="col">제목</th>
                        <th scope="col">시작일</th>
                        <th scope="col">종료일</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%
                            for(int i=0; i<row_cnt; i++)
                            {
                                out.println("<tr>");
                                out.println("<td>" + sv_no[i] + "</td>");
                                out.println("<td>" + sv_subject[i] + "</td>");
                                out.println("<td>" + sv_sdate[i] + "</td>");
                                out.println("<td>" + sv_edate[i] + "</td>");
                                out.println("</tr>");
                            }
                        %>
                    </tbody>
                </table>
            </article>
        </section>
    </body>
</html>