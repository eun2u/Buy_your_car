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

		String outpw = request.getParameter("password");
		String loginId = (String) session.getAttribute("loginid");

		try {

			sql = "select manager from account where id= '" + loginId + "'";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			int mgr=0;
			if(rs.next()){
				mgr = rs.getInt(1);
			}
			if (mgr == 1) //manager
			{

				sql = "SELECT * from ACCOUNT WHERE Id ='" + loginId + "' AND Password='" + outpw + "'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				if (!rs.next()) {
	%>
	<script>
		alert("Password�� �߸��Ǿ����ϴ�. �ٽ� �Է��ϼ���");
		document.location.href = "index_manager.html";
	</script>
	<%
		}

				sql = "select count(*) " + "from account " + "where manager=1 ";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				int mgrcount = 0;
				mgrcount = rs.getInt(1);

				if (mgrcount == 1) {
	%>
	<script>
		alert("�����ڰ����� �ּ� 1�� �̻� �־�� �մϴ�.");
		document.location.href = "index_manager.html";
	</script>
	<%
		}
				sql = "DELETE FROM ACCOUNT WHERE Id = '" + loginId + "' ";
				//System.out.println(sql);

				pstmt = conn.prepareStatement(sql);
				int res = pstmt.executeUpdate(sql);
				
				System.out.println(sql);
				if (res == 1) {
	%>
	<script>
		alert("Ż�� �Ǿ����ϴ�.");
		document.location.href = "login.html";
	</script>
	<%
		}
			} 
			else if (mgr == 0)//��
			{

				sql = "SELECT * from ACCOUNT WHERE Id ='" + loginId + "' AND Password='" + outpw + "'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				System.out.println("�� query");
				System.out.println(sql);
				
				if (!rs.next()) {
	%>
	<script>
		alert("Password�� �߸��Ǿ����ϴ�. �ٽ� �Է��ϼ���");
		document.location.href = "index_customer.html";
	</script>
	<%
		}

				
				sql = "DELETE FROM ACCOUNT WHERE Id = '" + loginId + "' ";
				System.out.println(sql);

				pstmt = conn.prepareStatement(sql);
				int res = pstmt.executeUpdate(sql);
				System.out.println(sql);
				if (res == 1) {
	%>
	<script>
		alert("Ż�� �Ǿ����ϴ�.");
		document.location.href = "login.html";
	</script>
	<%
				}

			}
			
			conn.commit();

			pstmt.close();
			conn.close();
			rs.close();
			
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	%>


</body>
</html>