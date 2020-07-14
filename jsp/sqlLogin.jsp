<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*"%>
<%
    String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
    String url_mysql = "jdbc:mysql://localhost/final_Project?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";
	
	PreparedStatement ps = null;
	
	int cnt = 0;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		Statement stmt_mysql = conn_mysql.createStatement();
		
		String query = "select user_Seqno from m_userInfo where user_Id = '"+id+"' and user_Password = '"+pw+"'";
		ResultSet rs = stmt_mysql.executeQuery(query);

	
%>
[

<% 		
		while(rs.next()){
	
%>
		{
		"user_Seqno"	: "<%=rs.getInt(1) %>"
	
		}
	
<% 
		}
%>
		]
<%
		conn_mysql.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	

%>