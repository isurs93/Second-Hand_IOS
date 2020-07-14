<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*"%>
<%
    String id = request.getParameter("user_Id");
	String pw = request.getParameter("user_Pw");
	
    String url_mysql = "jdbc:mysql://localhost/final_Project?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";
	
	PreparedStatement ps = null;
	
	int cnt = 0;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		Statement stmt_mysql = conn_mysql.createStatement();
		
		String query = "select board_Seqno,board_Title,board_Content,board_hit,board_Sido,board_Latitude,board_Longitude,board_InsertDate,board_isDone,board_Price,user_Id,board_uSeqno,image_String  from m_board, m_userInfo ,m_image where m_board.board_uSeqno = m_userInfo.user_Seqno and board_DeleteDate is null and m_image.image_bSeqno = board_Seqno order by board_Seqno desc";
		ResultSet rs = stmt_mysql.executeQuery(query);

	
%>
[

<% 		
		while(rs.next()){
	
	if(cnt!=0){%>
	    ,
<%	}
	
%>
		{
		"board_Seqno"	: "<%=rs.getInt(1) %>",
		"board_Title"       : "<%=rs.getString(2) %>",
		"board_Content"     : "<%=rs.getString(3) %>",
		"board_hit" :  "<%=rs.getInt(4) %>",
		"board_Sido"     : "<%=rs.getString(5) %>",
		"board_Latitude"    : "<%=rs.getString(6) %>",
		"board_Longitude"    : "<%=rs.getString(7) %>",
		
		"board_InsertDate"    : "<%=rs.getDate(8) %>",
		"board_isDone"    : "<%=rs.getInt(9) %>",
		"board_Price"    : "<%=rs.getInt(10) %>",
		"user_Id"    : "<%=rs.getString(11) %>",
		"board_uSeqno"    : "<%=rs.getInt(12) %>",
		"board_StrImage"  : "<%=rs.getString(13) %>"
		
		}
	
<% 
        cnt++;
		}
%>
]
<%
		conn_mysql.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	

%>