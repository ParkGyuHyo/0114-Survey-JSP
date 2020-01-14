<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;

    String svno, scno, sctcnt, subject, sctype, sctval_1, sctval_2, sctval_3, sctval_4, sctval_5 = null;

    Class.forName("com.mysql.cj.jdbc.Driver");

    String url = "jdbc:mysql://localhost:3306/pkh?serverTimezone=UTC";
    conn = DriverManager.getConnection(url, "root", "1234");
%>

<%

    svno = request.getParameter("sv_no");
    scno = request.getParameter("sc_no");
    subject = request.getParameter("sc_subject");
    sctype = request.getParameter("sc_type");
    sctcnt = request.getParameter("sc_tcnt");
    sctval_1 = request.getParameter("sc_tval_1");
    sctval_2 = request.getParameter("sc_tval_2");
    sctval_3 = request.getParameter("sc_tval_3");
    sctval_4 = request.getParameter("sc_tval_4");
    sctval_5 = request.getParameter("sc_tval_5");
    

	/* subject, wdate, sdate, edate, rname, ing, writer, sysdate */
   
    

    String sql = "insert into sv_child (sv_no, sc_no, sc_subject, sc_type, sc_tcnt, sc_t1, sc_t2, sc_t3, sc_t4, sc_t5) values(?,?,?,?,?,?,?,?,?,?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, svno);
    pstmt.setString(2, scno);
    pstmt.setString(3, subject);
    pstmt.setString(4, sctype);
    pstmt.setString(5, sctcnt);
    pstmt.setString(6, sctval_1);
    pstmt.setString(7, sctval_2);
    pstmt.setString(8, sctval_3);
    pstmt.setString(9, sctval_4);
    pstmt.setString(10, sctval_5);
    
    int n = pstmt.executeUpdate();
   
    if(n==1){
        out.println("success");
   }
   else
   {
        out.println("fail");
   }
%>

<%
	if (conn != null) { conn.close(); }
	if (pstmt != null) { pstmt.close(); }
%>