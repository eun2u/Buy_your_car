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

		String Year = request.getParameter("Year");
		String Month = request.getParameter("Month");
		String Day = request.getParameter("Day");
		String NewModelYear = null;
		NewModelYear = Year + "-" + Month + "-" + Day;

		String NewMileage = request.getParameter("NewMileage");
		String NewPrice = request.getParameter("NewPrice");
		String NewVnumber = request.getParameter("NewVnumber");
		String NewMake = request.getParameter("NewMake");
		String NewModel = request.getParameter("NewsModel");
		String NewDetailed = request.getParameter("NewDetailed");
		String NewColor1 = request.getParameter("NewColor1");
		String NewColor2 = request.getParameter("NewColor2");
		String Newengine = request.getParameter("Newengine");
		String Newfuel1 = request.getParameter("Newfuel1");
		String Newfuel2 = request.getParameter("Newfuel2");
		String NewCate = request.getParameter("NewCate");
		String NewTrans = request.getParameter("NewTrans");

		String option = request.getParameter("option");
		String vnum = request.getParameter("vnum");
		String sql = null;
		//System.out.println(Option +" "+Vnum);
		
		if(option.equals("public")){//공개처리
			sql = "UPDATE VEHICLE SET Notopen = 1 WHERE Vnumber = '"+vnum+"'";
			
			pstmt = conn.prepareStatement(sql); 
			int a = pstmt.executeUpdate();
			conn.commit();
			
			System.out.println(a+"행이 변경되었습니다.");
			%>
			<script>
			alert("차량이 공개처리되었습니다.");
			document.location.href="index_manager.html";
			</script>
			<%
			
		} else if(option.equals("private")){//비공개처리
			sql = "UPDATE VEHICLE SET Notopen = 0 WHERE Vnumber = '"+vnum+"'";
		
			pstmt = conn.prepareStatement(sql); 
			int a = pstmt.executeUpdate();
			conn.commit();
			
			System.out.println(a+"행이 변경되었습니다.");
			%>
			<script>
			alert("차량이 비공개처리되었습니다.");
			document.location.href="index_manager.html";
			</script>
			<%
		}
		

	%>
</body>
</html>