<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*"%>
<%
    String chatterSeqno = request.getParameter("chatterSeqno");
    String mySeqno = request.getParameter("mySeqno");
	
    String url_mysql = "jdbc:mysql://localhost/final_Project?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";
	
	PreparedStatement ps = null;
	
	int cnt = 0;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		Statement stmt_mysql = conn_mysql.createStatement();
		
		String query = "select dm_Seqno, dm_bSend, dm_bReceive, dm_Content, dm_InsertDate, dm_SendDelete, dm_ReceiveDelete, dm_Title from m_dm where (dm_bSend = " + mySeqno + " or dm_bReceive = " + mySeqno + ") and ( dm_bSend = " + chatterSeqno + " or dm_bReceive = " + chatterSeqno + ")";
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
		"dm_Seqno"	: "<%=rs.getInt(1) %>",
		"dm_bSend"       : "<%=rs.getInt(2) %>",
		"dm_bReceive"     : "<%=rs.getInt(3) %>",
		"dm_Content" :  "<%=rs.getString(4) %>",
		"dm_InsertDate"     : "<%=rs.getString(5) %>",
		"dm_SendDelete"    : "<%=rs.getInt(6) %>",
		"dm_ReceiveDelete"    : "<%=rs.getInt(7) %>",
		"dm_Title"    : "<%=rs.getString(8) %>"
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