<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    Class.forName("com.mysql.cj.jdbc.Driver");

    String url = "jdbc:mysql://localhost:3306/pkh?serverTimezone=UTC";
    conn = DriverManager.getConnection(url, "root", "1234");

	/*
	ALTER TABLE sv_top AUTO_INCREMENT=1;
	SET @COUNT = 0;
	UPDATE sv_top SET sv_no = @COUNT:=@COUNT+1;
	*/
%>

<%   
    String subject = request.getParameter("sv_top_subject");
    String sdate = request.getParameter("sv_top_start_date");
    String edate = request.getParameter("sv_top_end_date");
    String rname = request.getParameter("sv_top_realname");
    String sving = request.getParameter("sv_top_ing");
    String writer = (String)session.getAttribute("adm_id");

	/* subject, wdate, sdate, edate, rname, ing, writer, sysdate */
   
    

    String sql = "insert into sv_top (sv_subject, sv_sdate, sv_edate, sv_writer, sv_realname, sv_ing) values(?,?,?,?,?,?)";
	if (pstmt != null) { pstmt.close(); }
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, subject);
    pstmt.setString(2, sdate);
    pstmt.setString(3, edate);
    pstmt.setString(4, writer);
    pstmt.setString(5, rname);
    pstmt.setString(6, sving);
    
    int n = pstmt.executeUpdate();
   
    if(n==1){

        String sql2 = "select sv_no from sv_top where sv_subject = ? and sv_sdate = ? and sv_edate = ? and sv_writer = ?";
        if (pstmt != null) { pstmt.close(); }
        pstmt = conn.prepareStatement(sql2);
        pstmt.setString(1, subject);
        pstmt.setString(2, sdate);
        pstmt.setString(3, edate);
        pstmt.setString(4, writer);
        rs = pstmt.executeQuery();
        if (rs.next())
        {
            int idx = rs.getInt("sv_no");
            out.println("{\"result\":\"success\", \"idx\":\""+idx+"\"}");
        }
   }
   else
   {
    out.println("{\"result\":\"fail\"}");
   }
%>

<%
	if (conn != null) { conn.close(); }
	if (pstmt != null) { pstmt.close(); }
%>