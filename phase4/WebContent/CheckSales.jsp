<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Check Sales</title>
</head> 
<body>
<center>
	<h3>Check Sales</h3>
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<button type="button"  style="color: white; background: #0040FF; font-size: 0.8em; border-radius: 0.5em; padding: 10px 20px;"
			onclick="location.href='index_manager.html'">Done</button>
	<br />
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
		
		if(option.equals("Yearly")){ //연도별
			sql = "select to_char(ORDERDATE,'yyyy') as Year,sum(price) as sales " + 
					"from carorder join vehicle on vehi_number = vnumber " + 
					"group by  to_char(ORDERDATE,'yyyy') "
					+ "order by to_char(ORDERDATE,'yyyy') ";
		}else if(option.equals("Monthly")){//월별
			sql = "select to_char(ORDERDATE,'mm') as Month,sum(price) as sales "+
					"from carorder join vehicle on vehi_number = vnumber " +
					"group by  to_char(ORDERDATE,'mm') "+
					"order by to_char(ORDERDATE,'mm') ";
		}else if(option.equals("MAKE")){//제조사 별
			sql = "select Mname as MAKE, sum(price) as sales " + 
					"from carorder join vehicle on vehi_number = vnumber join Make on make_code=mcode " + 
					"group by  Mname ";
		} 
		System.out.println(sql);
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
	
		out.println("<table border=\"1\" bordercolor= \"gray\" >");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for(int i=1; i<=cnt;i++){
			out.println("<th  bgcolor=\"#E6E6E6\" span style=\"color:#2E2E2E;font-size: 1.5em;\">"+rsmd.getColumnName(i)+"</th>");
		}
		while(rs.next()){
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getString(2)+"</td>");
			
			out.println("</tr>");
		}
		out.println("</table>");
		rs.close();
		pstmt.close();
	%>
	</center>
</body>
</html>