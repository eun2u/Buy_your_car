<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head> 
<meta charset="EUC-KR">
<title>ModifyVehicleInfo</title>
</head>
<body>
	<h3>Modified vehicle information</h3>
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
		
		String modifyVnum = request.getParameter("modifyVnum");
		
		String modiYear = null;
		modiYear = request.getParameter("modiYear");
		String modiMonth = null;
		modiMonth = request.getParameter("modiMonth");
		String modiDay = null;
		modiDay = request.getParameter("Day");
		String modiDate = null;
		
		if((modiYear != null) && (!modiMonth.equals("null")) && (modiDay != null))
			modiDate = modiYear + "-" + modiMonth + "-" + modiDay;
		
		//String modiMile = "null";
		String modiMile = request.getParameter("modiMile");
		//String modiPrice = "null";
		String modiPrice = request.getParameter("modiPrice");
		String modiMake = request.getParameter("modiMake");
		String modiModel = "null";
		modiModel = request.getParameter("modiModel");
		String modiDM = "null";
		modiDM = request.getParameter("modiDM");
		String modiColor1 = request.getParameter("modiColor1");
		String modiColor2 = request.getParameter("modiColor2");
		String modiEngine = request.getParameter("modiEngine");
		String modifuel1 = request.getParameter("modiFuel1");
		String modifuel2 = request.getParameter("modiFuel2");
		String modiCate = request.getParameter("modiCate");
		String modiTrans = request.getParameter("modiTrans");
		
		String sql = null;

		if(modiDate != null){
			sql = "UPDATE VEHICLE SET Model_year = TO_DATE('"+modiDate+"', 'yyyy-mm-dd') WHERE Vnumber = '"+modifyVnum+"'";
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"행이 변경되었습니다.");
		}
		//System.out.println("modyMile" + modiMile);
		if(!modiMile.equals("")){
			sql = "UPDATE VEHICLE SET Mileage = "+modiMile+" WHERE Vnumber = '"+modifyVnum+"'";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"행이 변경되었습니다.");
		}
		
		if(!modiPrice.equals("")){
			sql = "UPDATE VEHICLE SET Price = "+modiPrice+" WHERE Vnumber = '"+modifyVnum+"'";
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"행이 변경되었습니다.");
		}
		
		if(!modiMake.equals("null") && !modiModel.equals("null") && !modiDM.equals("null")) //세가지 다 바꾼다면
		{
			String modiMnumber = null;
			String query = null;
			
			query = "SELECT Mnumber FROM MODEL WHERE Mname = '"+modiModel+"'";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next())
				modiMnumber = rs.getString(1);
			
			String modiDMnum = null;
			query = "SELECT Dmnumber FROM DETAILED_MODEL WHERE Dmname = '"+modiDM+"'";
			System.out.println(query);
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next())
				modiDMnum = rs.getString(1);
			
			sql = "UPDATE VEHICLE SET Make_code = '"+modiMake+"', Model_num = '"+modiMnumber+"' , Dm_num ='"+modiDMnum+"' WHERE Vnumber = '"+modifyVnum+"'";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			
			System.out.println(a+"행이 변경되었습니다.");
			
		}
		
		if(!modiColor1.equals("null")){
			sql = "UPDATE VEHICLE SET Cname1 = '"+modiColor1+"' WHERE Vnumber = '"+modifyVnum+"'";
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"행이 변경되었습니다.");
		}
		
		if(!modiColor2.equals("null")){
			sql = "UPDATE VEHICLE SET Cname2 = '"+modiColor2+"' WHERE Vnumber = '"+modifyVnum+"'";
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"행이 변경되었습니다.");
		}
		
		if(!modiEngine.equals("null")){
			sql = "UPDATE VEHICLE SET Engine_amount = "+modiEngine+" WHERE Vnumber = '"+modifyVnum+"'";
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"행이 변경되었습니다.");
		}
		
		if(!modifuel1.equals("null")){
			sql = "UPDATE VEHICLE SET Fcode1 = '"+modifuel1+"' WHERE Vnumber = '"+modifyVnum+"'";
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"행이 변경되었습니다.");
		}
		
		if(!modifuel2.equals("null")){
			sql = "UPDATE VEHICLE SET Fcode2 = '"+modifuel2+"' WHERE Vnumber = '"+modifyVnum+"'";
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"행이 변경되었습니다.");
		}
		
		if(!modiCate.equals("null")){
			sql = "UPDATE VEHICLE SET Category_code = "+modiCate+" WHERE Vnumber = '"+modifyVnum+"'";
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"행이 변경되었습니다.");
		} 
		
		if(!modiTrans.equals("null")){
			sql = "UPDATE VEHICLE SET Tcode = "+modiTrans+" WHERE Vnumber = '"+modifyVnum+"'";
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"행이 변경되었습니다.");
		}
		/*
		String query = modiDate + " " + modiMile + " " + modiPrice + " " + modifyVnum + " " + modiMake + " "
				+ modiModel + " " + modiDM + " " + modiColor1 + " " + modiColor2 + " " + modiEngine + " "
				+ modifuel1 + " " + modifuel2 + " " + modiCate + " " + modiTrans;
		System.out.println(query);
	*/
	%>
	<script>
	alert("차량정보가 변경되었습니다.");
	document.location.href="index_manager.html";
	</script>
</body>
</html>