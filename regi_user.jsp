<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    Class.forName("com.mysql.cj.jdbc.Driver");

    String url = "jdbc:mysql://localhost:3306/pkh?serverTimezone=UTC";
    conn = DriverManager.getConnection(url, "root", "1234");

    String userid = request.getParameter("user_id");
    String userpwd = request.getParameter("user_pwd");
    String username = request.getParameter("user_name");
    String userbirth = request.getParameter("user_birth");
    String usergender = request.getParameter("user_gender");

    String Check_user = "select * from sv_user where user_id = ?";
    if (rs!=null) rs.close();
    pstmt = conn.prepareStatement(Check_user);
    pstmt.setString(1, userid);
    rs = pstmt.executeQuery();

    if (rs.next())
    {
        out.println("{\"result\":\"overlap id\"}");
    }
    else
    {
        String sql = "insert into sv_user (user_id, user_pwd, user_name, user_birth, user_gender) values(?,?,?,?,?)";
        if (pstmt != null) { pstmt.close(); }
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        pstmt.setString(2, userpwd);
        pstmt.setString(3, username);
        pstmt.setString(4, userbirth);
        pstmt.setString(5, usergender);

        pstmt.executeUpdate();

        out.println("{\"result\":\"success\"}");
    }
%>