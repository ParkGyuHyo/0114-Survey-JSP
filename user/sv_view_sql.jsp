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

    session.setMaxInactiveInterval(60*60);
%>

<%
    String sv_no = request.getParameter("sv_no");
    String csql = "select sv_top.sv_no, sv_top.sv_subject, sv_child.* from (select * from sv_top where sv_no = ?) sv_top";
           csql += " inner join sv_child on sv_top.sv_no = sv_child.sv_no";
    pstmt = conn.prepareStatement(csql);
    pstmt.setString(1, sv_no);
    rs = pstmt.executeQuery();

    String sv_subject = null;

    if (rs.next())
    {
        sv_subject = rs.getString("sv_top.sv_subject");
    }

    rs.last();

    int row_cnt = rs.getRow();
    int sc_no[] = new int[row_cnt];
    String sc_subject[] = new String[row_cnt];
    String sc_type[] = new String[row_cnt];
    int sc_tcnt[] = new int[row_cnt];
    String sc_tval1[] = new String[row_cnt];
    String sc_tval2[] = new String[row_cnt];
    String sc_tval3[] = new String[row_cnt];
    String sc_tval4[] = new String[row_cnt];
    String sc_tval5[] = new String[row_cnt];

    rs.beforeFirst();
    
    for(int i=0; rs.next(); i++)
    {
        sc_no[i] = rs.getInt("sv_child.sc_no");
        sc_subject[i] = rs.getString("sv_child.sc_subject");
        sc_type[i] = rs.getString("sv_child.sc_type");
        sc_tcnt[i] = rs.getInt("sv_child.sc_tcnt");
        sc_tval1[i] = rs.getString("sv_child.sc_tval1");
        sc_tval2[i] = rs.getString("sv_child.sc_tval2");
        sc_tval3[i] = rs.getString("sv_child.sc_tval3");
        sc_tval4[i] = rs.getString("sv_child.sc_tval4");
        sc_tval5[i] = rs.getString("sv_child.sc_tval5");
    }
%>