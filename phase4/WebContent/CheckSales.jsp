<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Sales</title>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<link rel="stylesheet" type="text/css"
	href="vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css"
	href="vendor/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" type="text/css" href="css/util.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<body>
	<div style="text-align: center">
		<br /> <font size=6><b>Check Sales</b></font> <br />
	</div>
	
	<div class="limiter">
		<div class="container-table100">
			<div class="wrap-table100">
				<div class="table100 ver1 m-b-110">
					<div class="table100-head">
						<table>
							<thead>

								<tr class="row100 head">

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

										String option = request.getParameter("option");
										String sql = null;

										if (option.equals("Yearly")) { //연도별
											sql = "select to_char(ORDERDATE,'yyyy') as Year,sum(price) as sales "
													+ "from carorder join vehicle on vehi_number = vnumber "
													+ "group by  to_char(ORDERDATE,'yyyy') " + "order by to_char(ORDERDATE,'yyyy') ";
										} else if (option.equals("Monthly")) {//월별
											sql = "select to_char(ORDERDATE,'mm') as Month,sum(price) as sales "
													+ "from carorder join vehicle on vehi_number = vnumber " + "group by  to_char(ORDERDATE,'mm') "
													+ "order by to_char(ORDERDATE,'mm') ";
										} else if (option.equals("MAKE")) {//제조사 별
											sql = "select Mname as MAKE, sum(price) as sales "
													+ "from carorder join vehicle on vehi_number = vnumber join Make on make_code=mcode "
													+ "group by  Mname ";
										}
										System.out.println(sql);

										pstmt = conn.prepareStatement(sql);
										rs = pstmt.executeQuery();

										ResultSetMetaData rsmd = rs.getMetaData();
										int cnt = rsmd.getColumnCount();
										for (int i = 1; i <= cnt; i++) {
											out.println("<th class=\"cell100 column" + i + "\">" + rsmd.getColumnName(i) + "</th>");
										}
									%>
								</tr>
							</thead>
						</table>
					</div>

					<div class="table100-body js-pscroll">
						<table>
							<tbody>

								<%
									while (rs.next()) {
										out.println("<tr class=\"row100 body\">");
										out.println("<td class=\"cell100 column1\">" + rs.getString(1) + "</td>");
										out.println("<td class=\"cell100 column2\">" + rs.getString(2) + "</td>");
										out.println("</tr>");

									}
									out.println("</table>");
									rs.close();
									pstmt.close();
								%>
							
</body>
</html>