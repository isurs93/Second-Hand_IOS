<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    
    
<%
	int bSeqno = Integer.parseInt(request.getParameter("bSeqno"));
	String imgString = request.getParameter("imgString");
	
	
	String url_mysql = "jdbc:mysql://localhost/final_Project?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";
	
	PreparedStatement ps = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		

		String query = "insert into m_image (image_bSeqno, image_String) values (?, ?)";
		ps = conn_mysql.prepareStatement(query);
		ps.setInt(1, bSeqno);
		ps.setString(2, imgString);
		ps.executeUpdate();
		
		conn_mysql.close();	
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>


