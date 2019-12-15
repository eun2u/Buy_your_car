<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>My order</title>
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

		try {
			
			String loginId = request.getParameter("login-id2");

			sql = "SELECT  ordernumber, vehi_number, orderdate " + "FROM carorder join account on id=accountid " + 
					"WHERE id = '"+ loginId+"'";
			System.out.println(sql);
			
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
%>
		<h4>----A list of your car order----</h4>	
<%	
			out.println("<table border=\"1\">");
			ResultSetMetaData rsmd=rs.getMetaData();
			int cnt=rsmd.getColumnCount();
			for(int i=1;i<=cnt;i++){
				out.println("<th>"+ rsmd.getColumnName(i)+"</th>");
			}
			
			int flag = 0;
			while(rs.next()) {
				out.println("<tr>");
				out.println("<td>"+ rs.getString(1)+"</td>");
				out.println("<td>"+ rs.getString(2)+"</td>");
				
				Date orderdate= rs.getDate(3);
				String test = orderdate.toString();
				out.println("<td>"+test + "</td>");


				flag = 1;	

			}
			if(flag == 0){
				System.out.println(loginId+ "의 거래내역이 없습니다.");
			}

			out.println("</table>");
				
			pstmt.close();
			conn.close();

			rs.close();

		}catch(SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
  

		%>

</body>
</html>