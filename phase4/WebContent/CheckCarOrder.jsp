<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html> 
<head> 
<meta charset="EUC-KR">
<title>Check Car Order</title>
</head>
<body>
	<div style="text-align:center">
	<br />
	<font size=6><b>Order Details</b></font>
	<br />
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<input type="button" value="BACK" onClick="history.go(-1)" style="color:white;background:#0040FF;font-size:0.8em; border-radius:0.5em; padding:12px 17px;"> 
	</div>
	<br />
	<center>
	<%
		String serverIP = "localhost";
		String strSID = "orcl";
		String portNum = "1521";
		String user = "project";
		String pass = "project";
		String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
		
		
		String sql = "SELECT  ordernumber as order_number, vehi_number as Vehicle_Number, orderdate as order_date, accountid as account_id FROM carorder";
		System.out.println(sql);
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		out.println("<table border=\"1\" bordercolor= \"gray\" >");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for(int i=1; i<=cnt;i++){
			out.println("<th  bgcolor=\"#E6E6E6\" span style=\"color:#2E2E2E\">"+rsmd.getColumnName(i)+"</th>");
		}
		while(rs.next()){
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getString(2)+"</td>");
			
			Date orderdate= rs.getDate(3);
			String test = orderdate.toString();
			out.println("<td>"+test + "</td>");
			//out.println("<td>"+rs.getString(3)+"</td>");
			out.println("<td>"+rs.getString(4)+"</td>");
			
			out.println("</tr>");
		}
		out.println("</table>");
		rs.close();
		pstmt.close();
	%>
	</center>
</body>
</html>