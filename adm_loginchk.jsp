<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    Class.forName("com.mysql.cj.jdbc.Driver");

    String url = "jdbc:mysql://localhost:3306/pkh?serverTimezone=UTC";
    conn = DriverManager.getConnection(url, "root", "1234");
%>

<%
    String sid = request.getParameter("adm_id");
    String spwd = request.getParameter("adm_pwd");

    String sql = "select adm_pwd, adm_name from sv_admin where adm_id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, sid);
    rs = pstmt.executeQuery();

    if (rs.next())
    {
        if (rs.getString("adm_pwd").equals(spwd))
        {
            out.println("{\"user_type\":\"admin\", \"login_result\":\"success\"}");
            session.setAttribute("adm_id", sid);
            session.setAttribute("adm_name", rs.getString("adm_name"));
        }
        else
        {
            out.println("{\"user_type\":\"admin\", \"login_result\":\"diffrent password\"}");
        }
    }
    else
    {
        out.println("{\"user_type\":\"admin\", \"login_result\":\"notfound id\"}");
    }
%>


<%
	if (conn != null) { conn.close(); }
	if (pstmt != null) { pstmt.close(); }
	if (rs != null) { rs.close(); }
%>