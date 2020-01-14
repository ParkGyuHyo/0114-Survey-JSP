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

    String user_id = (String)session.getAttribute("user_id");
    String user_name = (String)session.getAttribute("user_name");
    session.setMaxInactiveInterval(60*60);

    Enumeration enu = request.getParameterNames();
    String strName;

    if (enu.hasMoreElements()){
        strName = (String)enu .nextElement();

        String Check_overlap = "select * from sv_result where sv_no = ? and sr_user = ?";
        pstmt = conn.prepareStatement(Check_overlap);
        pstmt.setString(1, request.getParameter(strName));
        pstmt.setString(2, user_id);
        rs = pstmt.executeQuery();

        if (rs.next())
        {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('이미 참여한 이력이 있습니다.');");
            out.println("location.href='./sv_list.jsp';");
            out.println("</script>");
        }
        else
        {
            while (enu.hasMoreElements()) {
                strName = (String)enu .nextElement();
                String stype[] = strName.split("_");
        
                String sql = "insert into sv_result (sr_user, sv_no, sc_no, sr_result) values(?,?,?,?)";
                if (pstmt != null) { pstmt.close(); }
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, user_id);
                pstmt.setString(2, stype[1]);
                pstmt.setString(3, stype[2]);
        
                if (stype[0].equals("Check"))
                {
                    String Checkk[] = request.getParameterValues(strName);
                    for (int i=0; i<Checkk.length; i++)
                    {
                        out.print(strName + ":");
                        pstmt.setString(4, Checkk[i]);
                        pstmt.executeUpdate();
                    }
                }else{
                    pstmt.setString(4, request.getParameter(strName));
                    pstmt.executeUpdate();
                }
            }

            %>

            <script type="text/javascript">
                alert("설문에 참여해주셔서 감사합니다.");
                location.href="./sv_list.jsp";
            </script>
            <%

        }
    }
%>