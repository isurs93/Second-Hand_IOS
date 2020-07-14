<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    
    
<%
	int sender = Integer.parseInt(request.getParameter("sender"));
	int receiver = Integer.parseInt(request.getParameter("receiver"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	
	String url_mysql = "jdbc:mysql://localhost/final_Project?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";
	
	PreparedStatement ps = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		

		String query = "insert into m_dm (dm_bSend, dm_bReceive, dm_Title, dm_Content, dm_InsertDate) values (?, ?, ?, ?,now())";
		ps = conn_mysql.prepareStatement(query);
		ps.setInt(1, sender);
		ps.setInt(2, receiver);
		ps.setString(3, title);
		ps.setString(4, content);
		ps.executeUpdate();
		
		conn_mysql.close();	
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>


