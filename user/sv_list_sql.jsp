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
    String user_id = (String)session.getAttribute("user_id");
    String user_name = (String)session.getAttribute("user_name");

    session.setMaxInactiveInterval(60*60) ;
%>

<%
	String csql = "select sv_no, sv_subject, sv_sdate, sv_edate from sv_top where sv_sdate <= curdate() and sv_edate >= curdate()";
    pstmt = conn.prepareStatement(csql);
    rs = pstmt.executeQuery();

    rs.last();

    int row_cnt = rs.getRow();
    String sv_no[] = new String[row_cnt];
    String sv_subject[] = new String[row_cnt];
    String sv_sdate[] = new String[row_cnt];
    String sv_edate[] = new String[row_cnt];

    rs.beforeFirst();
    
    for(int i=0; rs.next(); i++)
    {
        sv_no[i] = rs.getString("sv_no");
        sv_subject[i] = rs.getString("sv_subject");
        sv_sdate[i] = rs.getString("sv_sdate");
        sv_edate[i] = rs.getString("sv_edate");
    }
%>