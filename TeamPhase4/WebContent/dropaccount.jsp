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
			System.out.println("�����ڰ����� �ּ� 1�� �̻� �־�� �մϴ�. ");
			System.exit(0);
		}
	 

		 
		sql = "DELETE FROM ACCOUNT WHERE Id = '" + loginId + "' ";
		System.out.println(sql);
		
		pstmt=conn.prepareStatement(sql);
		int res = pstmt.executeUpdate(sql);
		System.out.println(sql);
		if(res==1){
			System.out.println("ȸ�� Ż�� �Ͽ����ϴ�.");
			System.out.println("application�� �����մϴ�");
			//System.exit(0);
		}

		conn.commit();
		
		pstmt.close();
		conn.close();
		rs.close();

	%>
	<script>
	alert("ȸ�� Ż�� �Ͽ����ϴ�.");
	document.location.href="firstview.html";
	</script>
	
</body>
</html>