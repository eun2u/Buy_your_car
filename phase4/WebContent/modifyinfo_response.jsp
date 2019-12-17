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

		String loginId = (String) session.getAttribute("loginid");

		String update_column = request.getParameter("info");
		String update_value = request.getParameter("modifiedvalue");

		try {

			sql = "select manager from account where id= '" + loginId + "'";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int mgr = 0;
			if (rs.next()) {
				mgr = rs.getInt(1);
			}
			if (mgr == 1) {//manager

				sql = "UPDATE ACCOUNT SET " + update_column + " = '" + update_value + "' WHERE Id = '" + loginId
						+ "'";

				System.out.println(sql);
				pstmt = conn.prepareStatement(sql);
				int res = pstmt.executeUpdate(sql);
				if (res == 1) {
	%>
	<script>
		alert("회원정보가 변경되었습니다.");
		document.location.href = "index_manager.jsp";
	</script>
	<%
				}
			} else if (mgr == 0) {//customer

				sql = "UPDATE ACCOUNT SET " + update_column + " = '" + update_value + "' WHERE Id = '" + loginId
						+ "'";

				System.out.println(sql);
				pstmt = conn.prepareStatement(sql);
				int res = pstmt.executeUpdate(sql);
				if (res == 1) {
	%>
	<script>
		alert("회원정보가 변경되었습니다.");
		document.location.href = "index_customer.jsp";
	</script>
	<%
		}
			}

			conn.commit();

			pstmt.close();
			conn.close();

		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	%>


</body>
</html>