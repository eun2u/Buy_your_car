<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java"
	import="java.text.*, java.sql.*, java.util.Calendar, java.util.Random "%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Customer Window</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/simple-sidebar.css" rel="stylesheet">

   <!--  dropdown -->
   <link rel="stylesheet" href="css/dropdown_styles.css">
	
</head>

<body>

  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="bg-light border-right" id="sidebar-wrapper">
      <div class="sidebar-heading">Customer Menu </div>
      <div class="list-group list-group-flush">
		<div class="menubar">
		<ul>
			 <li><a href="#"  class="list-group-item list-group-item-action bg-light">Carorder</a>
				<ul>
			     <li><a href="search_totalvehicle.jsp">Search Total</a></li>  
			     <li><a href="#tab11" onClick="$('#tab11').show(); $('#tab12').hide(); $('#tab13').hide(); $('#tab3').hide(); $('#tab4').hide(); ">
			     		Search By Make</a></li>
			     <li><a href="#tab12" onClick="$('#tab11').hide(); $('#tab12').show(); $('#tab13').hide();  $('#tab3').hide(); $('#tab4').hide();">
			     		Search By Condition</a></li>
			     <li><a href="#tab13" onClick="$('#tab11').hide(); $('#tab12').hide(); $('#tab13').show();  $('#tab3').hide(); $('#tab4').hide(); ">
			     		Search By Name</a></li>
			    </ul>
			 </li>
		</ul>
        </div>
        
        <a href="myorder.jsp" class="list-group-item list-group-item-action bg-light">MyOrder</a>    
            
        <a href="#tab3" onClick="$('#tab11').hide();  $('#tab12').hide(); $('#tab13').hide();  $('#tab3').show(); $('#tab4').hide(); " 
        class="list-group-item list-group-item-action bg-light">ModifyMyInfo</a>
        <a href="#tab4" onClick="$('#tab11').hide();  $('#tab12').hide();$('#tab13').hide();   $('#tab3').hide(); $('#tab4').show(); "
        class="list-group-item list-group-item-action bg-light">DropAccount</a>        
        <a href="login.html" 
        class="list-group-item list-group-item-astion bg-light">Logout</a>
      </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">

      <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
        <button class="btn btn-primary" id="menu-toggle">Menu</button>  
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
            <li class="nav-item">
              <a class="nav-link" >
             <%
             	String loginid=(String)session.getAttribute("loginid");
				 out.println("Welcome " + loginid+ " !");
			 %>
            </a>
            </li>

          </ul>
        </div>
      </nav>  

      <div class="container-fluid" id="tab11" style="display:none;">
        <h1 class="mt-7">Search By Make</h1>
		  <form action="search_make.jsp" method = "POST">
		   	Make name: 
				<select name="mname">
					<option value="Hyundai" selected>Hyundai</option>
					<option value="Renault_Samsung">Renault_Samsung</option>
					<option value="Kia">Kia</option>	
					<option value="Chevrolet">Chevrolet</option>	
					<option value="BMW">BMW</option>	
					<option value="Lexus">Lexus</option>
					<option value="Benz">Benz</option>
					<option value="Volkswagen">Volkswagen</option>
				</select>		
				<input type="submit" value="enter" />
				
			</form>  		
      </div>
      
       <div class="container-fluid" id="tab12" style="display:none;">
        <h1 class="mt-7">Search By Condition</h1>
			
			<form action = "search_condition.jsp" method = "POST">
				<br/>
				
				<b>Options to Search</b> 
				<b>&emsp; &emsp;&emsp;&emsp; &emsp; &nbsp;&nbsp; Search Value</b>
				<hr/>
				Model Year &emsp;&emsp;&emsp;&emsp;&emsp;&emsp; &emsp; 
				Year <input type="text" name="modiYear" style="width:40px;height:15px;">
				Month <select name="modiMonth">
					<option value="null" selected>-----</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select>
				Day <input type="text" name="Day" style="width:30px;height:20px;">
				<br />
				Mileage &emsp; &nbsp;&nbsp;&emsp;&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; 
				<input type="text" name="modiMile" style="width:100px;height:15px;"> km
				
				<br />
				 Price  &emsp;&nbsp;&nbsp;&emsp;&emsp;&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; 
				<input type="text" name="modiPrice" style="width:100px;height:15px;"> 
				<br />
				
				Color1 / Color2  &nbsp; &nbsp; &emsp; &emsp; &emsp; &emsp;
				<select name="modiColor1">
					<option value="null" selected>--------</option>
					<option value="Red">Red</option>
					<option value="Blue">Blue</option>
					<option value="Yellow">Yellow</option>
					<option value="Gray">Gray</option>
					<option value="White">White</option>
					<option value="Black">Black</option>
					<option value="Pink">Pink</option>
				</select>
			
				 &emsp;
				<select name="modiColor2">
					<option value="null" selected>--------</option>
					<option value="Red">Red</option>
					<option value="Blue">Blue</option>
					<option value="Yellow">Yellow</option>
					<option value="Gray">Gray</option>
					<option value="White">White</option>
					<option value="Black">Black</option>
					<option value="Pink">Pink</option>
				</select>
				
				<br /> 
				Engine&emsp;&emsp; &emsp; &emsp; &emsp; &emsp;	&emsp; &emsp;
				<select name="modiEngine">
					<option value="null" selected>--------</option>
					<option value="1500">1500</option>
					<option value="2000">2000</option>
					<option value="3000">3000</option>
					<option value="2500">2500</option>
					<option value="1000">1000</option>
				</select> cc
				
				<br /> 
				Fuel1 / Fuel2  &nbsp;&nbsp; &emsp;&emsp; &emsp; &emsp; &emsp; &emsp; 
				<select name="modiFuel1">
					<option value="null" selected>--------</option>
					<option value="001">Gasoline</option>
					<option value="002">Diesel</option>
					<option value="003">Electric</option>
					<option value="004">LPG</option>
					<option value="005">CNG</option>
				</select> &emsp; <select name="modiFuel2">
					<option value="null" selected>--------</option>
					<option value="003">Electric</option>
				</select> 
				
				<br />
				Category&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp;
				<select name="modiCate">
					<option value="null" selected>--------</option>
					<option value="1">Compact</option>
					<option value="2">RV</option>
					<option value="3">Light-Weight</option>
					<option value="4">Midsize</option>
					<option value="5">Full-size</option>
					<option value="6">SUV</option>
				</select> 
				
				<br />
				Transmission &nbsp;&emsp; &emsp; &emsp; &emsp; &emsp;&emsp;&emsp;
				<select name="modiTrans">
					<option value="null" selected>--------</option>
					<option value="1">Automatic</option>
					<option value="2">Semi-Auto</option>
					<option value="3">Manual</option>
					<option value="4">CVT</option>
				</select>
				<br /> <br />
				
				<input type="reset" value="Reset" 
						style="color:white;background:black;font-size:1em; border-radius:0.5em; padding:5px 20px;">
				<input type="submit" value="Submit" 
						style="color:white;background:black;font-size:1em; border-radius:0.5em; padding:5px 20px;"/>
			
			</form>
      </div>

      <div class="container-fluid" id="tab13" style="display:none;">
        <h1 class="mt-7">Search By Name</h1>
		<form action="search_vehiclename.jsp" method="POST" >
			Vehicle name: <input type="text" name = "vname"/>
			<input type="submit" value="enter" />
		
		 </form> 		
      </div>


      
      <div class="container-fluid" id="tab3" style="display:none;">
        <h1 class="mt-7">Modify My Info</h1>
        <p>  
	        <form action="modifyinfo_response.jsp" method = "POST">
	  		<hr>
			info: 
			<select name="info">
				<option value="fname" selected >Fname</option>
				<option value="lname">Lname</option>
				<option value="manager">Manager(1) or Customer(0)</option>
				<option value="password">Password</option>	
				<option value="address">Address</option>	
				<option value="phonenumber">Phonenumber(010-xxxx-xxxx)</option>	
				<option value="birthday">Birthday(yy/mm/dd)</option>	
				<option value="sex">Sex(F or M)</option>	
				<option value="job">Job</option>	
			</select>
			<br/>
			<br/>
			
			Value: <input type="text" name = "modifiedvalue"/> 		
			<input type="submit" value="Submit" />
	    	</form>  
		</p>
      </div>
      
      </br>
      
      <div class="container-fluid" id="tab4" style="display:none;">
        <h1 class="mt-7">Drop Account</h1>
        <p>  <b>Are you sure to drop Account?</b>
			<form action="dropaccount.jsp" method = "POST">
		    <hr>
		    Password: <input type="password" name = "password"/> 		
			<input type="submit" value="enter" /> 
		  </form>  
		</p>
      </div>
      

      
      
      
    </div>
    <!-- /#page-content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Menu Toggle Script -->
  <script>
    $("#menu-toggle").click(function(e) {
      e.preventDefault();
      $("#wrapper").toggleClass("toggled");
    });
  </script>

</body>

</html>
