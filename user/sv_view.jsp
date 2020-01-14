<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file="sv_view_sql.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="./js/script.js?v=4"></script>
        <link rel="stylesheet" type="text/css" href="./css/style.css?v=201912261432" />
        <link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet"> 
    </head>
    <body>
        <header>
            <h1 class="list_subject">
                <%
                if(sv_subject != null) { out.println(sv_subject); }
                else { out.println("제목 없음"); }
                %>
            </h1>
            <p>[<%=user_id%>] 님 반갑습니다.</p>
        </header>
        <section>
            <article class="ctr_warp" id="sv_slist">
                <form id="check_frm" name="survey_frm" action="./sv_insert.jsp" method="post">
                    <input type="hidden" value="<%= sv_no %>" name="sv_no" />
                    <%
                        for(int i=0; i<row_cnt; i++){
                            out.println("<div class=\"sv_row\">");
                            out.println("<p class=\"sc_subject\">" + (i+1) + ". " + sc_subject[i] + "</p>");
                            if (sc_type[i].equals("단답형")){ out.println("<input type=\"text\" name=\"Text_" + sv_no + "_" + sc_no[i] + "\" autocomplete=\"false\" />"); }
                            else if (sc_type[i].equals("장문형")){ out.println("<textarea name=\"Textarea_" + sv_no + "_" + sc_no[i] + "\"></textarea>"); }
                            else if (sc_type[i].equals("라디오박스") || sc_type[i].equals("체크박스"))
                            {
                                for (int j=0; j<sc_tcnt[i]; j++)
                                {
                                    out.println("<p>");
                                    if (sc_type[i].equals("라디오박스")){
                                        out.println("<input type=\"radio\" id=\"radio_" + (j+1) + "\" name=\"Radio_" + sv_no + "_" + sc_no[i] + "\" value=\"" + (j+1) + "\" />");
                                        out.println("<label for=\"radio_" + (j+1) + "\">");
                                    }
                                    else
                                    {
                                        out.println("<input type=\"checkbox\" id=\"check_" + (j+1) + "\" name=\"Check_" + sv_no + "_" + sc_no[i] + "\" value=\"" + (j+1) + "\" />");
                                        out.println("<label for=\"check_" + (j+1) + "\">");
                                    }
                                    switch(j)
                                    {
                                        case 0 : out.println(sc_tval1[i]); break;
                                        case 1 : out.println(sc_tval2[i]); break;
                                        case 2 : out.println(sc_tval3[i]); break;
                                        case 3 : out.println(sc_tval4[i]); break;
                                        case 4 : out.println(sc_tval5[i]); break;
                                        default : break;
                                    }
                                    out.println("</label>");
                                    out.println("</p>");
                                }
                            }
                            out.println("</div>");
                        }
                    %>
                    <p>
                        <input type="submit" value="완 료" />&nbsp;&nbsp;&nbsp;<input type="button" value="취 소" />
                    </p>
                </form>
            </article>
        </section>
    </body>
</html>