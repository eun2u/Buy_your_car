<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>login_response</title>
</head>
<body>
	<%
		String serverIP = "localhost";
		String strSID = "orcl";
		String portNum = "1521";
		String user = "project";
		String pass = "project";
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);

		String sql = " "; 

		String loginId = request.getParameter("login-id");
		String loginpw  = request.getParameter("login-password");

		System.out.println(loginId + " " + loginpw);

		//sql = "SELECT * from ACCOUNT WHERE Id ='" + loginId + "' AND Password='" + loginpw + "'";

		sql="select * from account where id='"+ loginId + "' and password='"+ loginpw +"'";
		System.out.println(sql);
		
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		if (!rs.next()) {
			System.out.println("Id나 Password가 잘못되었습니다. 다시 입력하세요");
		}
		else{
			rs.close();
			pstmt.close();
			conn.commit();

			System.out.println("로그인이 완료되었습니다.");
		}
	%>	

</body>
</html>