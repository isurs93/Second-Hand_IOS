<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    
    
<%
	String seqno = request.getParameter("seqno");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	
	String url_mysql = "jdbc:mysql://localhost/final_Project?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";
	
	PreparedStatement ps = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		

		String query = "update m_userInfo set user_Password = ?, user_Name = ?, user_Telno = ?, user_Email = ? where user_Seqno = ?";
		ps = conn_mysql.prepareStatement(query);
		
		
		ps.setString(1, pw);
		ps.setString(2, name);
		ps.setString(3, tel);
		ps.setString(4, email);
		ps.setString(5, seqno);
		ps.executeUpdate();
		
		conn_mysql.close();	
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>