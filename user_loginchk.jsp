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
    String sid = request.getParameter("user_id");
    String spwd = request.getParameter("user_pwd");

    String sql = "select user_pwd, user_name from sv_user where user_id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, sid);
    rs = pstmt.executeQuery();

    if (rs.next())
    {
        if (rs.getString("user_pwd").equals(spwd))
        {
            out.println("{\"user_type\":\"user\", \"login_result\":\"success\"}");
            session.setAttribute("user_id", sid);
            session.setAttribute("user_name", rs.getString("user_name"));
        }
        else
        {
            out.println("{\"user_type\":\"user\", \"login_result\":\"diffrent password\"}");
        }
    }
    else
    {
        out.println("{\"user_type\":\"user\", \"login_result\":\"notfound id\"}");
    }
%>


<%
	if (conn != null) { conn.close(); }
	if (pstmt != null) { pstmt.close(); }
	if (rs != null) { rs.close(); }
%>