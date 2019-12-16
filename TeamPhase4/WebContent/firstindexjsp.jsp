<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>

<html lang="en">
  <head>
    <title>First view</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    
    <!-- <link rel="stylesheet" href="css/bootstrap.min.css"> -->
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/flexslider.css">
    <link rel="stylesheet" href="fonts/icomoon/style.css">

    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">

    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,700" rel="stylesheet">

    
  </head>
  <body data-spy="scroll" data-target="#pb-navbar" data-offset="200">
  

   
    <nav class="navbar navbar-expand-lg site-navbar navbar-light bg-light" id="pb-navbar">

      <div class="container">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <a class="navbar-brand" href="firstindex.html">HScar</a>
        <div class="collapse navbar-collapse justify-content-md-center" id="navbarsExample09">
          <ul class="navbar-nav">
           
          </ul>
        </div>
      </div>
    </nav>
    
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
		
		String sql =null;
		sql = "select d.dmname from(SELECT COUNT(v.dm_num) as cnt, dm_num FROM CARORDER C, VEHICLE V WHERE  C.Vehi_number = V.Vnumber GROUP BY V.DM_num order by cnt desc) join detailed_model d on dm_num = d.dmnumber where rownum <=3";
		System.out.println(sql);
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		String dm_name = null;
		%>
		
   
    
    <section class="site-hero" style="background-image: url(images/car_2.jpg);" id="section-home" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row intro-text align-items-center justify-content-center">
          <div class="col-md-10 text-center">
            <h1 style=" color:#F2F2F2; font: italic 4em/1em arial, serif ;">Today's <strong>Top 3</strong> Vehicles</h1>
            <img src="images/beige_2.png"> &emsp;&emsp;<img src="images/white_2.png"> &emsp;&emsp;<img src="images/gray_2.png"> <br />
            <%
            	int a=0;
            	out.print("<center>	<span style=\" color:#F2F2F2; font: italic bold 1em/1em arial, serif ;\">");
				while (rs.next()){
					a++;
					dm_name = rs.getString(1); 
					out.print(dm_name);
					if(a!=3)
						out.print("&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; &emsp;&emsp;&emsp;&emsp; ");
				}
				out.print("</span> </center>");
			%>
			
            <p><button class="btn btn-info btn-lg" type="button" style="fontsize:2em" onclick="location.href='login.html'">Login</button></p>
          </div> 
        </div>
      </div>
    </section> <!-- section -->


   

    
    

    <script src="js/vendor/jquery.min.js"></script>
    <script src="js/vendor/popper.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    
    <script src="js/vendor/jquery.easing.1.3.js"></script>
    <script src="js/vendor/jquery.stellar.min.js"></script>
    <script src="js/vendor/jquery.waypoints.min.js"></script>

    <script src="https://unpkg.com/isotope-layout@3/dist/isotope.pkgd.min.js"></script>
    <script src="https://unpkg.com/imagesloaded@4/imagesloaded.pkgd.min.js"></script>
    <script src="js/custom.js"></script>

    <!-- Google Map -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
    <script src="js/google-map.js"></script>

  </body>
</html>