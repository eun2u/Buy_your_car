<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>login_response</title>
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


		System.out.println("*Fname: ");				
		String Fname=request.getParameter("firstname");	
		String SFname="'" + Fname + "'";


		System.out.println("*Lname: ");
		String Lname=request.getParameter("lastname");	
		String SLname="'" + Lname + "'";

		
		System.out.println("Manager(Manager면 1, 아니면 0): ");
		String Manager = request.getParameter("manager");
		String SManager;
		if(Manager.equals("")) 
			SManager = "'0'";
		else SManager="'"+ Manager +"'";


		System.out.println("*ID: ");
		String ID = request.getParameter("id");
		String SID="'" + ID + "'";

		System.out.println("*Password: ");
		String Password = request.getParameter("passwd");
		String SPassword="'" + Password + "'";

		System.out.println("Address: ");
		String Address = request.getParameter("address");
		String SAddress;
		if(Address.equals("")) 
			SAddress = "NULL";
		else SAddress="'"+Address +"'";

		System.out.println("*Phonenumber(010-xxxx-xxxx): ");
		String Phonenumber =request.getParameter("phonenumber");
		String SPhonenumber="'" + Phonenumber + "'";

		System.out.println("Birthday(yy/mm/dd): ");
		String Birthday = request.getParameter("birthday");
		String SBirthday;
		if(Birthday.equals("")) 
			SBirthday = "NULL";
		else SBirthday="'"+Birthday +"'";

		System.out.println("Sex('F' or 'M'): ");
		String Sex = request.getParameter("sex");
		String SSex;
		if(Sex.equals("")) 
			SSex = "NULL";
		else SSex="'"+Sex +"'";

		System.out.println("Job: ");
		String Job = request.getParameter("job");
		String SJob;
		if(Job.equals("")) 
			SJob = "NULL";
		else SJob="'"+Job +"'";

		try {
			// Let's execute an SQL statement.

			conn.setAutoCommit(false);
		
			sql = "INSERT INTO ACCOUNT VALUES ("
					+SFname +","+SLname+","+ SManager+","+ SID+"," +SPassword+","+SAddress+","+
					SPhonenumber+","+ SBirthday+"," + SSex+"," +SJob+")";

		//	System.out.println(sql);  
			pstmt=conn.prepareStatement(sql);
			int res = pstmt.executeUpdate(sql);
			if(res==1)
				System.out.println("회원가입이 완료되었습니다.");

			conn.commit();		
			
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