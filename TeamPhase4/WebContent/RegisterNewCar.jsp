<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Register New Car</title>
</head>
<body>
	<h3>Information on a new vehicle</h3>
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
		String NewModel = request.getParameter("NewModel");
		String NewDetailed = request.getParameter("NewDetailed");
		String NewColor1 = request.getParameter("NewColor1");
		String NewColor2 = request.getParameter("NewColor2");
		String Newengine = request.getParameter("Newengine");
		String Newfuel1 = request.getParameter("Newfuel1");
		String Newfuel2 = request.getParameter("Newfuel2");
		String NewCate = request.getParameter("NewCate");
		String NewTrans = request.getParameter("NewTrans");

		////SearchModelnum////
		String Newmodel_code = null;
		
		String query = "SELECT Mnumber FROM MODEL WHERE Mname = '" + NewModel + "'";
		System.out.println(query);
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();

		while (rs.next())
			Newmodel_code = rs.getString(1);
		
		////SearchDBnum/////
		String NewDBnum = null;
		
		query = "SELECT Dmnumber FROM DETAILED_MODEL WHERE Dmname = '"+NewDetailed+"'";
		System.out.println(query);
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();

		while (rs.next())
			NewDBnum = rs.getString(1);
		
		////////////////////////
		String sql = null;
		if (NewColor2.equals("null")) { // ���������� �� ������ ��
				if (Newfuel2.equals("null")) {// ���� �Ѱ���
					sql = "INSERT INTO VEHICLE VALUES(TO_DATE('" + NewModelYear + "', 'yyyy-mm-dd'), " + NewMileage
							+ ", " + NewPrice + ", '" + NewVnumber + "', '" + NewMake + "', '" + Newmodel_code
							+ "', '" + NewDBnum + "', '" + NewColor1 + "', NULL, " + Newengine + ", '" + Newfuel1
							+ "', NULL, " + NewCate + ", " + NewTrans + ", NULL, 1)";
					//System.out.println("����1, ����1: "+sql);
				}else {// ���� �ΰ���
					sql = "INSERT INTO VEHICLE VALUES(TO_DATE('" + NewModelYear + "', 'yyyy-mm-dd'), " + NewMileage
							+ ", " + NewPrice + ", '" + NewVnumber + "', '" + NewMake + "', '" + Newmodel_code
							+ "', '" + NewDBnum + "', '" + NewColor1 + "', NULL, " + Newengine + ", '" + Newfuel1
							+ "', '" + Newfuel2 + "', " + NewCate + ", " + NewTrans + ", NULL, 1)";
					//System.out.println("����1, ����2: "+sql);
				}
			} else { // ���� ������ �� ������ ��
				if (Newfuel2.equals("null")) { // ���� �Ѱ���
					sql = "INSERT INTO VEHICLE VALUES(TO_DATE('" + NewModelYear + "', 'yyyy-mm-dd'), " + NewMileage
							+ ", " + NewPrice + ", '" + NewVnumber + "', '" + NewMake + "', '" + Newmodel_code
							+ "', '" + NewDBnum + "', '" + NewColor1 + "', '" + NewColor2 + "', " + Newengine + ", '"
							+ Newfuel1 + "', NULL, " + NewCate + ", " + NewTrans + ", NULL, 1)";
					//System.out.println("����2, ����1: "+sql);
				}else {// ���� �ΰ���
					sql = "INSERT INTO VEHICLE VALUES(TO_DATE('" + NewModelYear + "', 'yyyy-mm-dd'), " + NewMileage
							+ ", " + NewPrice + ", '" + NewVnumber + "', '" + NewMake + "', '" + Newmodel_code
							+ "', '" + NewDBnum + "', '" + NewColor1 + "', '" + NewColor2 + "', " + Newengine + ", '"
							+ Newfuel1 + "', '" + Newfuel2 + "', " + NewCate + ", " + NewTrans + ", NULL, 1)";
					//System.out.println("����2, ����2: "+sql);
				}
			}
			pstmt = conn.prepareStatement(sql); 
			int a = pstmt.executeUpdate();
			conn.commit();
			
			System.out.println(a+"���� ����Ǿ����ϴ�.");
			
		
		
		rs.close();
		pstmt.close();
		
		/*
		query = NewModelYear + " " + NewMileage + " " + NewPrice + " " + NewVnumber + " " + NewMake + " "
				+ " " + NewModel + " " + NewDetailed + " " + NewColor1 + " " + NewColor2 + " " + Newengine + " "
				+ Newfuel1 + " " + Newfuel2 + " " + NewCate + " " + NewTrans;
		System.out.println(query);
		*/
	%>
	<script>
	alert("���ο� ������ ��ϵǾ����ϴ�.");
	</script>
</body>
</html>