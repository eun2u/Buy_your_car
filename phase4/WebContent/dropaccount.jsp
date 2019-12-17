<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>drop account</title>
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
      String outpw = request.getParameter("password");
      String loginId = (String) session.getAttribute("loginid");
      try {
         sql = "select manager from account where id= '" + loginId + "'";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         int mgr=0;
         if(rs.next()){
            mgr = rs.getInt(1);
         }
         
         if (mgr == 1) //manager
         {
        	 System.out.println("manager drop");
            sql = "SELECT * from ACCOUNT WHERE Id ='" + loginId + "' AND Password='" + outpw + "'";
            System.out.println(sql);
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (!rs.next()) {
   %>
   <script>
      alert("Password가 잘못되었습니다. 다시 입력하세요");
      document.location.href = "index_manager.jsp";
   </script>
   <%
      }
            sql = "select count(*) " + "from account " + "where manager=1 ";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            System.out.println(sql);

            int mgrcount = 0;
            if(rs.next())
       	   		mgrcount = rs.getInt(1);
            if (mgrcount == 1) {
   %>
   <script>
      alert("관리자계정은 최소 1개 이상 있어야 합니다.");
      document.location.href = "index_manager.jsp";
   </script>
   <%
      }
            sql = "DELETE FROM ACCOUNT WHERE Id = '" + loginId + "' ";
            System.out.println(sql);
            pstmt = conn.prepareStatement(sql);
            int res = pstmt.executeUpdate(sql);
            
            System.out.println(sql);
            if (res == 1) {
   %>
   <script>
      alert("탈퇴 되었습니다.");
      document.location.href = "firstindexjsp.jsp";
   </script>
   <%
      }
         } 
         else if (mgr == 0)//고객
         {
        	 System.out.println("customer drop");
             
            sql = "SELECT * from ACCOUNT WHERE Id ='" + loginId + "' AND Password='" + outpw + "'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            System.out.println("고객 query");
            System.out.println(sql);
            
            if (!rs.next()) {
   %>
   <script>
      alert("Password가 잘못되었습니다. 다시 입력하세요");
      document.location.href = "index_customer.jsp";
   </script>
   <%
      }
            //carorder에 이 고객이 산 주문내역이 있는지 확인->있으면 주문내역지우고 회원계정지우기
            sql ="SELECT * FROM CARORDER WHERE AccountID = '"+loginId+"'";
            System.out.println(sql);
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            if(rs.next()){ //주문내역있으면 주문내역 삭제
               sql= "DELETE FROM CARORDER WHERE AccountID = '"+loginId+"'";
            
               pstmt = conn.prepareStatement(sql); 
               int a = pstmt.executeUpdate();
               conn.commit();
               
               System.out.println(a+"행이 변경되었습니다.(carorder행 삭제)");
               
               sql = "DELETE FROM VEHICLE WHERE Ac_ID = '"+loginId+"'";
               pstmt = conn.prepareStatement(sql); 
               a = pstmt.executeUpdate();
               conn.commit();
               
               System.out.println(a+"행이 변경되었습니다.(vehicle행 삭제)");
               
            }
            
            sql = "DELETE FROM ACCOUNT WHERE Id = '" + loginId + "' ";
            System.out.println(sql);
            pstmt = conn.prepareStatement(sql);
            int res = pstmt.executeUpdate(sql);
            System.out.println(sql);
            if (res == 1) {
   %>
   <script>
      alert("탈퇴 되었습니다.");
      document.location.href = "firstindexjsp.jsp";
   </script>
   <%
            }
         }
         
         conn.commit();
         pstmt.close();
         conn.close();
         rs.close();
         
      } catch (SQLException ex2) {
         System.err.println("sql error = " + ex2.getMessage());
         System.exit(1);
      }
   %>


</body>
</html>