<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>drop account</title>
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

		String loginId = request.getParameter("login-id3");

		
		sql = "select count(*) " + "from account " + "where manager=1 ";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
	
		int mgrcount = 1;
		if (rs.next())
			mgrcount = rs.getInt(1);

		if (mgrcount == 0) {
			System.out.println("관리자계정은 최소 1개 이상 있어야 합니다. ");
			System.exit(0);
		}
	 

		 
		sql = "DELETE FROM ACCOUNT WHERE Id = '" + loginId + "' ";
		System.out.println(sql);
		
		pstmt=conn.prepareStatement(sql);
		int res = pstmt.executeUpdate(sql);
		System.out.println(sql);
		if(res==1){
			System.out.println("회원 탈퇴를 하였습니다.");
			System.out.println("application을 종료합니다");
			//System.exit(0);
		}

		conn.commit();
		
		pstmt.close();
		conn.close();
		rs.close();

	%>
	<script>
	alert("회원 탈퇴를 하였습니다.");
	document.location.href="firstview.html";
	</script>
	
</body>
</html>