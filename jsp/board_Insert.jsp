<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    
    
<%
	int user_Seqno = Integer.parseInt(request.getParameter("user_Seqno"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	String latitude = request.getParameter("latitude");
	String longitude = request.getParameter("longitude");
	
	String sido = request.getParameter("sido");
	
	int price = Integer.parseInt(request.getParameter("price"));
	
	
	String url_mysql = "jdbc:mysql://localhost/final_Project?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";
	
	PreparedStatement ps = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
		

		String query = "insert into m_Board (board_uSeqno, board_Title, board_Content, board_Hit, board_Sido, board_Latitude, board_Longitude,board_InsertDate, board_Price) values (?, ?, ?,0, ?, ?, ?,now(),?)";
		ps = conn_mysql.prepareStatement(query);
		ps.setInt(1, user_Seqno);
		ps.setString(2, title);
		ps.setString(3, content);
		
		ps.setString(4, sido);
		ps.setString(5, latitude);
		ps.setString(6, longitude);
		
		ps.setInt(7, price);
		ps.executeUpdate();
		
		conn_mysql.close();	
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>


