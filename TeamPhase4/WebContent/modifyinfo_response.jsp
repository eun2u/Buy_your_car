<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>modify_info</title>
</head>
<body>
	<%
		String serverIP = "localhost";
		String strSID = "xe";
		String portNum = "1600";
		String user = "project";
		String pass = "pro";
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);

		String sql = " ";

		
		String loginId = request.getParameter("login-id1");
		
		  
		String update_column = request.getParameter("info");
		String update_value = request.getParameter("modifiedvalue");

	
		try {
			sql = "UPDATE ACCOUNT SET "+update_column+" = '"+
					update_value+"' WHERE Id = '"+loginId+ "'";

			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			int res = pstmt.executeUpdate(sql);
			if(res==1)
				System.out.println("ȸ�������� ����Ǿ����ϴ�.");

			conn.commit();
			
			pstmt.close();
			conn.close();
			
		}catch(SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
		

		
	%>
	<script>
	alert("ȸ�������� ����Ǿ����ϴ�.");
	document.location.href="index_manager.html";
	</script>

</body>
</html>