<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*"%>
<%
    String mySeqno = request.getParameter("mySeqno");
    String id =  request.getParameter("id");
	
    String url_mysql = "jdbc:mysql://localhost/final_Project?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";
	
	PreparedStatement ps = null;
	
	int cnt = 0;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		Statement stmt_mysql = conn_mysql.createStatement();
		
		String query = "select like_bSeqno,count(*)  from m_likes group by like_bSeqno order by like_bSeqno";
		
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
		"bSeqno"	: "<%=rs.getInt(1) %>",
		"cnt" :  "<%=rs.getInt(2) %>"
		
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