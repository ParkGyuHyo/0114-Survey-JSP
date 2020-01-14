<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
	int ContCnt = 0;
	String sv_no, sv_subject, sv_writer, sv_sdate, sv_edate, sv_ing = "";

    Class.forName("com.mysql.cj.jdbc.Driver");

    String url = "jdbc:mysql://localhost:3306/pkh?serverTimezone=UTC";
    conn = DriverManager.getConnection(url, "root", "1234");
%>

<%
	String csql = "select count(*) as cnt from sv_top";
    pstmt = conn.prepareStatement(csql);
    rs = pstmt.executeQuery();

	if (rs.next()){
		ContCnt = rs.getInt("cnt");
	}
	
    String sql = "select * from sv_top";
	if (pstmt != null) { pstmt.close(); }
	if (rs != null) { rs.close(); }
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();
%>    
    
<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="./js/script.js?v=2019622341"></script>
        <!--<script type="text/javascript" src="./js/sv_config.js?v=7"></script>-->
        <script type="text/javascript" src="./js/test.js?v=7"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel="stylesheet" type="text/css" href="./css/test_admin.css?v=20191222636" />
        <link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script|Sunflower:300&display=swap" rel="stylesheet" />
        <script type="text/javascript" src="https://kit.fontawesome.com/24c1a5db21.js"></script>
        <title>SURVEY :: 관리자 페이지</title>
        <%
            String adm_id = (String)session.getAttribute("adm_id");
            String adm_name = (String)session.getAttribute("adm_name");

            session.setMaxInactiveInterval(60*60) ;
        %>
    </head>
    <body>
        <div class="header">
            <div class="logo">
                <p>APPBUTTON</p>
            </div>
            <div class="adm_info">
                <p>
                    <%
                     if (adm_id == "" || adm_id == null)
                     {
                         response.sendRedirect("./index.jsp");
                     }
                     else
                     {
                         out.println(adm_name + "님 (<span id=\"time_out\">30:00</span>)");
                     }
                    %>
                    <input type="button" value="logout" />
                </p>
            </div>
        </div>
        <div class="lmenu_btn">
            <h2>▼</h2>
        </div>
        <div class="lmenu">
            <ul>
                <li>
                    <h3><a href="./adm_main.jsp">대시보드</a></h3>
                </li>
                <li>
                    <h3>설문조사 관리 ▼</h3>
                    <ul>
                        <li><a href="./sv_list.jsp">설문조사 목록</a></li>
                        <li>설문조사 상세 목록</li>
                    </ul>
                </li>
                <li>
                    <h3>유저 관리 ▼</h3>
                    <ul>
                        <li>관리자 관리</li>
                        <li>회원 관리</li>
                    </ul>
                </li>
                <li>
                    <h3>통계 ▼</h3>
                    <ul>
                        <li>설문조사 목록</li>
                        <li>설문조사 상세 목록</li>
                    </ul>
                </li>
            </ul>
            <h2>▲</h2>
        </div>
        <div class="headline">
                <p>설문조사 관리</p> 
        </div>
        <div class="dashboard">
            
            <div class="sv_list">
                <p id="sch_open">
                    <i class="fas fa-search" id="sch_open_btn"></i>
                </p>
                <div id="schfrm">
                    <table width="100%" cellspacing="10">
                        <tr>
                            <th>제목</th>
                            <td colspan="3"><input type="text" name="sv_lst_ch" placeholder="검색어" /></td>
                        </tr>
                        <tr>
                            <th>게시자</th>
                            <td><input type="text" name="sv_lst_ch" size="5" placeholder="검색어" /></td>
                            <th>진행</th>
                            <td>
                                <select name="sv_ing">
                                    <option value="a">전체</option>
                                    <option value="y">진행중</option>
                                    <option value="n">종료</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>시작일</th>
                            <td colspan="3">
                                    <input type="date" id="start-date"
                                    name="start_date" />
                            </td>
                        </tr>
                        <tr>
                            <th>종료일</th>
                            <td colspan="3">
                                    <input type="date" id="end-date" 
                                    name="end_date" />
                            </td>
                        </tr>
                    </table>
                </div>
                <p id="lstcnt">전체 <%= ContCnt %>건</p>
                <div class="slfrm">
                    <table width="100%" cellspacing="0">
                        <tr>
                            <th>삭제</th>
                            <th>no</th>
                            <th>설문 제목</th>
                            <th>문항 갯수</th>
                            <th>게시자</th>
                            <th>설문 시작</th>
                            <th>설문 종료</th>
                            <th>진행</th>
                        </tr>
                        <% 
						   int i = 1;
                           while(rs.next()) { 


                           sv_no = rs.getString("sv_no");
                           sv_subject = rs.getString("sv_subject");
                           sv_writer = rs.getString("sv_writer");
                           sv_sdate = rs.getString("sv_sdate");
                           sv_edate = rs.getString("sv_edate");
                           sv_ing = rs.getString("sv_ing");	
                        %>
                        <tr>
                            <td><input type="checkbox" name="sv_lst_chk" value="<%= sv_no %>"/></td>
                            <td><%= i %></td>
                            <td><%= sv_subject %></td>
                            <td>null</td>
                            <td><%= sv_writer %></td>
                            <td><%= sv_sdate %></td>
                            <td><%= sv_edate %></td>
                            <td>
                                <% if(sv_ing.equals("Y")) { %>Y<% }else{ %>N<% } %>
							</td>
                        </tr>
                        <% i++;} %>
                    </table>
                </div>
                <p id="c_btn">
                    <input type="button" id="ins_btn" value="추 가" title="새로운 설문을 생성합니다."/>
                    <input type="button" id="upd_btn" value="수 정" title="선택된 설문(1개)을 수정합니다."/>
                    <input type="button" id="del_btn" value="삭 제" title="선택된 설문(다중)을 삭제합니다."/>
                </p>
            </div>
            <div class="sv_report">
                <h3>설문조사 현황판</h3>
                <hr />

            </div>
        <!--대시보드 종료구간-->    
        </div>
        <div id="sv_cover">
            <div id="sv_ins_frm">
                <i class="fas fa-times-circle" id="pop_close_btn" title="설문지 상세 정보 팝업을 닫습니다."></i>
                <h2>설문조사 관리</h2>
                <hr />
                <div id="sub_section" title="항목 추가시 설문이 자동으로 등록됩니다.">
                    <form id="sv_top_frm">
                        <table width="100%" cellspacing="10">
                            <tr>
                                <th>제목</th>
                                <td colspan="9">
                                    <input type="text" name="sv_top_subject"/>
                                </td>
                            </tr>
                            <tr>
                                <th>시작일</th>
                                <td>
                                    <input type="date" name="sv_top_start_date" />
                                </td>

                                <th>종료일</th>
                                <td>
                                    <input type="date" name="sv_top_end_date" />
                                </td>

                                <th>실명</th>
                                <td>
                                    <input type="radio" name="sv_top_realname" value="Y" />실명제
                                    <input type="radio" name="sv_top_realname" value="N" checked/>무기명
                                </td>

                                <th>진행</th>
                                <td>
                                    <input type="radio" name="sv_top_ing" value="Y" checked/>진행
                                    <input type="radio" name="sv_top_ing" value="N" />종료
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div id="con_section">
                        <div class="sv_content">
                            <table width="100%" id="sv_table">
								<colgroup>
									<col width="10%" />
									<col width="10%" />
									<col width="50%" />
									<col width="15%" />
									<col width="5%" />
									<col width="10%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><input type="checkbox" id="all_chk" /></th>
										<th scope="col">no</th>
										<th scope="col">항목</th>
										<th scope="col">타입</th>
										<th scope="col">이동</th>
										<th scope="col">저장</th>
									</tr>
								</thead>
							</table>
                        </div>
                    <i class="fas fa-plus-circle" id="add_row" title="본 설문에 항목을 추가합니다."></i>
                    <input type="button" value="리스트 생성" id="add_list" />
                </div>
            </div>
        </div>
        <script type="text/template" id="radio_sel" src="./js/radio_sel.js"></script>
        <script type="text/template" id="sel_type">
            <div class="type_sel_frm">
                <input id="tab1" type="radio" name="tabs" checked>
                <label for="tab1">단답형</label>
                <input id="tab2" type="radio" name="tabs">
                <label for="tab2">장문형</label>
                <input id="tab3" type="radio" name="tabs">
                <label for="tab3">라디오박스</label>
                <input id="tab4" type="radio" name="tabs">
                <label for="tab4">체크박스</label>
            
                <section id="contents_1">
                    <h3>단답형은 설정 없이 바로 사용 가능합니다.</h3>
                    <input type="submit" id="text_submit" value="저 장" />
                </section>
                <section id="contents_2">
                    <h3>장문형은 설정 없이 바로 사용 가능합니다.</h3>
                    <input type="submit" id="textarea_submit" value="저 장" />
                </section>
                <section id="contents_3">
                    <p>
                        <span id="radi_no">1</span>.
                        <input type="text" name="radi_val_1" size="30" />
                    </p>
                    <p>
                        <span id="radi_no">2</span>.
                        <input type="text"  name="radi_val_2" size="30" />
                    </p>
                    <p class="add_radi">+ 라디오박스를 추가합니다. (최대 5개)</p>
                    <input type="submit" id="radi_submit" value="저 장" />
                </section>
                <section id="contents_4">
                    <p>
                        <span id="check_no">1</span>.
                        <input type="text" name="check_val_1" size="30" />
                    </p>
                    <p>
                        <span id="check_no">2</span>.
                        <input type="text"  name="check_val_2" size="30" />
                    </p>
                    <p class="add_check">+ 체크박스를 추가합니다. (최대 5개)</p>
                    <input type="submit" id="check_submit" value="저 장" />
                </section>
            </div>
        </script>

    </body>
</html>

<%
	if (conn != null) { conn.close(); }
	if (pstmt != null) { pstmt.close(); }
	if (rs != null) { rs.close(); }
%>