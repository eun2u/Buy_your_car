<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>login_response</title>
</head>
<body>
<%
	String serverIP="localhost";
	String strSID="orcl";
	String portNum="1521";
	String user="project";
	String pass="project";
	String url="jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	
	Connection conn=null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn=DriverManager.getConnection(url,user,pass);

	System.out.println("Connection success");
	
	
	
	
	String loginid=request.getParameter("login-id");
	String loginpw=request.getParameter("login-password");

	System.out.println(loginid +" "+ loginpw);
	
	String fname=request.getParameter("firstname");
	String lname=request.getParameter("lastname");	
	String signupid=request.getParameter("id");
	String signuppw=request.getParameter("passwd");
	String address=request.getParameter("address");
	String pnum=request.getParameter("phonenumber");
	String bday=request.getParameter("Birthday");
	String sex=request.getParameter("sex");
	String job=request.getParameter("job");
	
	
	System.out.println(fname +" "+ lname+ " "+ signupid + " " + signuppw + " " +
			address + " "+ pnum+ " " +bday + " "+ sex + " "+ job);
	
%>


</body>
</html>