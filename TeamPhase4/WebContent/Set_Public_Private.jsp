<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html> 
<html>
<head>
<meta charset="EUC-KR">
<title>Set the car Public or Private</title>
</head>
<body>
	<h3>Public or Private</h3>
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

		
		String option = request.getParameter("option");
		String vnum = request.getParameter("vnum");
		String sql = null;
		//System.out.println(Option +" "+Vnum);
		
		if(option.equals("public")){//����ó��
			sql = "UPDATE VEHICLE SET Notopen = 1 WHERE Vnumber = '"+vnum+"'";
			
			pstmt = conn.prepareStatement(sql); 
			int a = pstmt.executeUpdate();
			conn.commit();
			
			System.out.println(a+"���� ����Ǿ����ϴ�.");
			%>
			<script>
			alert("������ ����ó���Ǿ����ϴ�.");
			document.location.href="index_manager.html";
			</script>
			<%
			
		} else if(option.equals("private")){//�����ó��
			sql = "UPDATE VEHICLE SET Notopen = 0 WHERE Vnumber = '"+vnum+"'";
		
			pstmt = conn.prepareStatement(sql); 
			int a = pstmt.executeUpdate();
			conn.commit();
			
			System.out.println(a+"���� ����Ǿ����ϴ�.");
			%>
			<script>
			alert("������ �����ó���Ǿ����ϴ�.");
			document.location.href="index_manager.html";
			</script>
			<%
		}
		

	%>
</body>
</html>