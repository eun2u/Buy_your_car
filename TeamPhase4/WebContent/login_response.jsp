<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>login_response</title>
</head>
<body>
<%
	String serverIP="localhost";
	String strSID="xe";
	String portNum="1600";
	String user="project";
	String pass="pro";
	String url="jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	
	Connection conn=null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn=DriverManager.getConnection(url,user,pass);
	//System.out.println("Connection success");
	
	
	
	
	String loginid=request.getParameter("login-id");
	String loginpw=request.getParameter("login-password");
	System.out.println(loginid +" "+ loginpw);
	
	String Fname=request.getParameter("firstname");
	String Lname=request.getParameter("lastname");	
	String Manager=request.getParameter("manager");
	String signupid=request.getParameter("id");
	String signuppw=request.getParameter("passwd");
	String address=request.getParameter("address");
	String pnum=request.getParameter("phonenumber");
	String bday=request.getParameter("Birthday");
	String sex=request.getParameter("sex");
	String job=request.getParameter("job");
	
	
	System.out.println("manager" + Manager);
	System.out.println("fname"+ Fname +" Lname"+ Lname+ " signupid"+ signupid + " signuppw" + signuppw + " address" +
			address + " pnum"+ pnum+ " bday" +bday + " sex"+ sex + " job"+ job);
	
	String sql = null;
	
	if(loginid != null) //�α����ϴ� ��
	{
		sql = "SELECT * from ACCOUNT WHERE Id ='"+ loginid+"' AND Password='"+ loginpw +"'";
		
		System.out.println(sql);
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(!rs.next()){
			%>
			<script>
			alert("Id�� Password�� �߸��Ǿ����ϴ�. �ٽ� �Է��ϼ���");
			document.location.href="login.html";
			</script>
			<%
		}
		else{ //�α���, ����� ��ġ�� ���
			sql ="SELECT * FROM ACCOUNT WHERE ID = '"+loginid+"' AND Manager = '1'";
		
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ //�������� ��
				%>
				<script>
				location.href="index_manager.html";
				</script>
				<%
			}
			else{ //�����ڰ� �ƴ� ��(���� ��)
				%>
				<script>
				location.href="index_customer.html";
				</script>
				<%
			}
			
			
		}
	}else //ȸ�������ϴ� ��
	{
		if(Fname==null || Lname==null || signupid==null || signuppw==null || pnum==null ||
				Fname.equals("") || Lname.equals("") || signupid.equals("") || signuppw.equals("") || pnum.equals("")
				 ||Fname.equals("null") || Lname.equals("null") || signupid.equals("null") || signuppw.equals("null") || pnum.equals("null"))
		{
			
			%>
			<script>
			alert("(*)�� �ʼ������Դϴ�. �ٽ� �Է����ּ���.");
			</script>
			<%
			Fname = "null";
			Lname = "null";
			signupid = "null";
			signuppw = "null";
			pnum = "null";
			%>
			<script>
			location.href="login.html#";
			
			</script>
			<%
			
		}
		else
		{
			String SFname="'" + Fname + "'";
			String SLname="'" + Lname + "'";
			
			String SManager = null;
			if(Manager == null)
				SManager = "'0'";
			else if(Manager.equals("manager"))
				SManager = "'1'";
			
			String SID="'" + signupid + "'";
			String SPassword="'" + signuppw + "'";
			
			String SAddress;
			if(address.equals("")) 
				SAddress = "NULL";
			else SAddress="'"+address +"'";
			
			String SPhonenumber="'" + pnum + "'";
			
			String SBirthday;
			if(bday == null) 
				SBirthday = "NULL";
			else SBirthday="'"+bday +"'";
			
			String SSex;
			if(sex.equals("")) 
				SSex = "NULL";
			else SSex="'"+sex +"'";
			
			String SJob;
			if(job.equals("")) 
				SJob = "NULL";
			else SJob="'"+job +"'";
			
			
			sql = "INSERT INTO ACCOUNT VALUES ("
					+SFname +","+SLname+","+ SManager+","+ SID+"," +SPassword+","+SAddress+","+
					SPhonenumber+","+ SBirthday+"," + SSex+"," +SJob+")";
			
			pstmt = conn.prepareStatement(sql);
			int a = pstmt.executeUpdate();
			conn.commit();
			System.out.println(sql);
			System.out.println(a+"���� ����Ǿ����ϴ�.");
			%>
			<script>
			alert("ȸ�������� �Ϸ�Ǿ����ϴ�.");
			document.location.href="login.html";
			</script>
			<%
			
		}
	}
	
%>


</body>
</html>