<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Car Order</title>
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
</head>
<body>
	<div style="text-align: center">
		<br /> <font size=6><b>Order Details</b></font> <br />
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

										String sql = "SELECT  ordernumber as order_number, vehi_number as Vehicle_Number, orderdate as order_date, accountid as account_id FROM carorder";
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

										Date orderdate = rs.getDate(3);
										String test = orderdate.toString();
										out.println("<td class=\"cell100 column3\">" + test + "</td>");

										out.println("<td class=\"cell100 column4\">" + rs.getString(4) + "</td>");

										out.println("</tr>");
									}
									rs.close();
									pstmt.close();
								%>

							</tbody>
						</table>
					</div>
				</div>


			</div>
		</div>
	</div>


	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="vendor/select2/select2.min.js"></script>
	<script src="vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script>
		$('.js-pscroll').each(function() {
			var ps = new PerfectScrollbar(this);

			$(window).on('resize', function() {
				ps.update();
			})
		});
	</script>
	<script src="js/main.js"></script>


</body>
</html>