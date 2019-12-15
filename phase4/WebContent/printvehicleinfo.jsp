<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java"
	import="java.text.*, java.sql.*, java.util.Calendar, java.util.Random "%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>login_response</title>
</head>
<body>
<div class="tab-pane text-style">
		


	<%
		String serverIP = "localhost";
		String strSID = "orcl";
		String portNum = "1521";
		String user = "project";
		String pass = "project";
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs = null;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);

		String sql = " ";

		String SearchVenum = request.getParameter("vnum");
 
		try {

			conn.setAutoCommit(false);
			sql=request.getParameter("sql");
			System.out.println(sql);
		//	sql = "SELECT * FROM VEHICLE WHERE Vnumber = '" + SearchVenum + "'";

			//print vehicle info

			String Make_name = null;
			String Model_name = null;
			String DM_name = null;
			String Fuel1 = null;
			String Fuel2 = null;
			String Catename = null;
			String Transname = null;
			int i = 0;

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			out.println("<table border=\"1\">");
			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			//System.out.println(cnt);
			for (i = 1; i <= cnt - 2; i++) {
				out.println("<th>" + rsmd.getColumnName(i) + "</th>");
			}

			while (rs.next()) {
				Date Model_year = rs.getDate(1);
				int Mileage = rs.getInt(2);
				int Price = rs.getInt(3);
				String Vnumber = rs.getString(4);
				String Make_code = rs.getString(5);
				String Model_num = rs.getString(6);
				String Dm_num = rs.getString(7);
				String Color1 = rs.getString(8);
				String Color2 = rs.getString(9);
				int Engine_amount = rs.getInt(10);
				String Fcode1 = rs.getString(11);
				String Fcode2 = rs.getString(12);
				int Category_code = rs.getInt(13);
				int Tcode = rs.getInt(14);

				// Transmission
				if (Tcode == 1)
					Transname = "Automatic";
				else if (Tcode == 2)
					Transname = "Semi-Auto";
				else if (Tcode == 3)
					Transname = "Manual";
				else if (Tcode == 4)
					Transname = "CVT";

				// Category 분류
				if (Category_code == 1)
					Catename = "Compact";
				else if (Category_code == 2)
					Catename = "RV";
				else if (Category_code == 3)
					Catename = "Light-Weight";
				else if (Category_code == 4)
					Catename = "Midsize";
				else if (Category_code == 5)
					Catename = "Full-size";
				else if (Category_code == 6)
					Catename = "SUV";

				// Fuel1, Fuel2 분류
				if (Fcode1.equals("001"))
					Fuel1 = "Gasoline";
				else if (Fcode1.equals("002"))
					Fuel1 = "Diesel";
				else if (Fcode1.equals("003"))
					Fuel1 = "Electric";
				else if (Fcode1.equals("004"))
					Fuel1 = "LPG";
				else if (Fcode1.equals("005"))
					Fuel1 = "CNG";

				if (Fcode2 != null) {
					if (Fcode2.equals("001"))
						Fuel2 = "Gasoline";
					else if (Fcode2.equals("002"))
						Fuel2 = "Diesel";
					else if (Fcode2.equals("003"))
						Fuel2 = "Electric";
					else if (Fcode2.equals("004"))
						Fuel2 = "LPG";
					else if (Fcode2.equals("005"))
						Fuel2 = "CNG";
				}

				// Make, Model, Detailed_Model 분류
				if (Make_code.equals("001")) {
					Make_name = "Hyundai";

					if (Model_num.equals("H1")) {
						Model_name = "Grandeur";

						if (Dm_num.equals("GR_001"))
							DM_name = "Grandeur IG";
						else if (Dm_num.equals("GR_002"))
							DM_name = "Grandeur HG";
						else if (Dm_num.equals("GR_003"))
							DM_name = "Grandeur New Luxury";
						else if (Dm_num.equals("GR_004"))
							DM_name = "Grandeur TG";

					} else if (Model_num.equals("H2")) {
						Model_name = "Sonata";

						if (Dm_num.equals("SN_001"))
							DM_name = "Sonata(DN8)";
						else if (Dm_num.equals("SN_002"))
							DM_name = "Sonata New Rise";
						else if (Dm_num.equals("SN_003"))
							DM_name = "LF Sonata";
						else if (Dm_num.equals("SN_004"))
							DM_name = "Sonata The Brilliant";
					} else if (Model_num.equals("H3")) {
						Model_name = "Avante";

						if (Dm_num.equals("AV_001"))
							DM_name = "The New Avante AD";
						else if (Dm_num.equals("AV_002"))
							DM_name = "Avante AD";
						else if (Dm_num.equals("AV_003"))
							DM_name = "Avante Coupe";
						else if (Dm_num.equals("AV_004"))
							DM_name = "Avante MD";
					} else if (Model_num.equals("H4")) {
						Model_name = "Starex";

						if (Dm_num.equals("ST_001"))
							DM_name = "The New Grand Starex";
						else if (Dm_num.equals("ST_002"))
							DM_name = "Grand Starex";
						else if (Dm_num.equals("ST_003"))
							DM_name = "Starex Jumbo";
						else if (Dm_num.equals("ST_004"))
							DM_name = "Starex";
					}

				} else if (Make_code.equals("002")) {
					Make_name = "Renault_Samsung";

					if (Model_num.equals("LS1")) {
						Model_name = "SM5";

						if (Dm_num.equals("SM5_001"))
							DM_name = "SM5 Nova";
						else if (Dm_num.equals("SM5_002"))
							DM_name = "New SM5 Platinum";
						else if (Dm_num.equals("SM5_003"))
							DM_name = "New SM5";
						else if (Dm_num.equals("SM5_004"))
							DM_name = "SM5 New Impression";
					} else if (Model_num.equals("LS2")) {
						Model_name = "SM3";

						if (Dm_num.equals("SM3_001"))
							DM_name = "SM3 Neo";
						else if (Dm_num.equals("SM3_002"))
							DM_name = "SM3 Z.E";
						else if (Dm_num.equals("SM3_003"))
							DM_name = "New SM3";
						else if (Dm_num.equals("SM3_004"))
							DM_name = "SM3 New Generation";
					} else if (Model_num.equals("LS3")) {
						Model_name = "SM7";

						if (Dm_num.equals("SM7_001"))
							DM_name = "SM7 Nova";
						else if (Dm_num.equals("SM7_002"))
							DM_name = "All new SM7";
						else if (Dm_num.equals("SM7_003"))
							DM_name = "SM7 New Art";
						else if (Dm_num.equals("SM7_004"))
							DM_name = "SM7";
					} else if (Model_num.equals("LS4")) {
						Model_name = "QM5";

						if (Dm_num.equals("QM5_001"))
							DM_name = "QM5 Neo";
						else if (Dm_num.equals("QM5_002"))
							DM_name = "New QM5";
						else if (Dm_num.equals("QM5_003"))
							DM_name = "QM5";
					}

				} else if (Make_code.equals("003")) {
					Make_name = "Kia";

					if (Model_num.equals("G1")) {
						Model_name = "Morning";

						if (Dm_num.equals("MOR_001"))
							DM_name = "All New Mornig";
						else if (Dm_num.equals("MOR_002"))
							DM_name = "The New Morning";
						else if (Dm_num.equals("MOR_003"))
							DM_name = "New Morning";
					} else if (Model_num.equals("G2")) {
						Model_name = "Carnival";

						if (Dm_num.equals("CAR_001"))
							DM_name = "The New Carnival";
						else if (Dm_num.equals("CAR_002"))
							DM_name = "All New Carnival";
						else if (Dm_num.equals("CAR_003"))
							DM_name = "Carnival R";
					} else if (Model_num.equals("G3")) {
						Model_name = "K5";

						if (Dm_num.equals("K5_001"))
							DM_name = "The New K5 2th";
						else if (Dm_num.equals("K5_002"))
							DM_name = "k5 Hybrid 2th";
						else if (Dm_num.equals("K5_003"))
							DM_name = "The New K5";
					} else if (Model_num.equals("G4")) {
						Model_name = "Sportage";

						if (Dm_num.equals("SP_001"))
							DM_name = "Sportage The Bold";
						else if (Dm_num.equals("SP_002"))
							DM_name = "The New Sportage";
						else if (Dm_num.equals("SP_003"))
							DM_name = "Sportage R";
					}

				} else if (Make_code.equals("004")) {
					Make_name = "Chevrolet";

					if (Model_num.equals("S1")) {
						Model_name = "Spark";

						if (Dm_num.equals("SPK_001"))
							DM_name = "The New Spark";
						else if (Dm_num.equals("SPK_002"))
							DM_name = "The Next Spark";
						else if (Dm_num.equals("SPK_003"))
							DM_name = "Spark EV";

					} else if (Model_num.equals("S2")) {
						Model_name = "Malibu";

						if (Dm_num.equals("M_001"))
							DM_name = "The New Malibu";
						else if (Dm_num.equals("M_002"))
							DM_name = "All New Malibu";
						else if (Dm_num.equals("M_003"))
							DM_name = "Malibu";
					} else if (Model_num.equals("S3")) {
						Model_name = "Matiz";

						if (Dm_num.equals("MTZ_001"))
							DM_name = "Matiz Creative";
						else if (Dm_num.equals("MTZ_002"))
							DM_name = "Matiz Classic";
						else if (Dm_num.equals("MTZ_003"))
							DM_name = "All New Matiz";

					} else if (Model_num.equals("S4")) {
						Model_name = "Cruze";

						if (Dm_num.equals("CR_001"))
							DM_name = "All New Cruze";
						else if (Dm_num.equals("CR_002"))
							DM_name = "Amazing New Cruze";
						else if (Dm_num.equals("CR_003"))
							DM_name = "Cruze5";
					}

				} else if (Make_code.equals("005")) {
					Make_name = "BMW";

					if (Model_num.equals("B1")) {
						Model_name = "X5";

						if (Dm_num.equals("X5_001"))
							DM_name = "X5(G05)";
						else if (Dm_num.equals("X5_002"))
							DM_name = "X5(F15)";
						else if (Dm_num.equals("X5_003"))
							DM_name = "X5(E70)";
					} else if (Model_num.equals("B2")) {
						Model_name = "M5";

						if (Dm_num.equals("M5_001"))
							DM_name = "M5(F90)";
						else if (Dm_num.equals("M5_002"))
							DM_name = "M5(F10)";
						else if (Dm_num.equals("M5_003"))
							DM_name = "M5(E60)";
					} else if (Model_num.equals("B3")) {
						Model_name = "Z4";

						if (Dm_num.equals("Z4_001"))
							DM_name = "Z4(G29)";
						else if (Dm_num.equals("Z4_002"))
							DM_name = "Z4(E89)";
						else if (Dm_num.equals("Z4_003"))
							DM_name = "Z4(E85)";
					} else if (Model_num.equals("B4")) {
						Model_name = "GT";

						if (Dm_num.equals("GT_001"))
							DM_name = "6series GT(G32)";
						else if (Dm_num.equals("GT_002"))
							DM_name = "3series GT(F34)";
						else if (Dm_num.equals("GT_003"))
							DM_name = "5series GT(F07)";
					}

				} else if (Make_code.equals("006")) {
					Make_name = "Lexus";

					if (Model_num.equals("L1")) {
						Model_name = "ES";

						if (Dm_num.equals("ES_001"))
							DM_name = "ES300h 7th";
						else if (Dm_num.equals("ES_002"))
							DM_name = "New ES350";
						else if (Dm_num.equals("ES_003"))
							DM_name = "New ES300h";
					} else if (Model_num.equals("L2")) {
						Model_name = "GS";

						if (Dm_num.equals("GS_001"))
							DM_name = "New GS300";
						else if (Dm_num.equals("GS_002"))
							DM_name = "New GS200t";
						else if (Dm_num.equals("GS_003"))
							DM_name = "New GS F";
					} else if (Model_num.equals("L3")) {
						Model_name = "IS";

						if (Dm_num.equals("IS_001"))
							DM_name = "New IS300";
						else if (Dm_num.equals("IS_002"))
							DM_name = "New IS200t";
						else if (Dm_num.equals("IS_003"))
							DM_name = "IS F";
					} else if (Model_num.equals("L4")) {
						Model_name = "LS";

						if (Dm_num.equals("LS_001"))
							DM_name = "LS500 5th";
						else if (Dm_num.equals("LS_002"))
							DM_name = "LS600hL 5th";
						else if (Dm_num.equals("LS_003"))
							DM_name = "LS460";
					}

				} else if (Make_code.equals("007")) {
					Make_name = "Benz";

					if (Model_num.equals("Bz1")) {
						Model_name = "E-class";

						if (Dm_num.equals("Ec_001"))
							DM_name = "E-class W213";
						else if (Dm_num.equals("Ec_002"))
							DM_name = "E-class W212";
						else if (Dm_num.equals("Ec_003"))
							DM_name = "E-class W211";
					} else if (Model_num.equals("Bz2")) {
						Model_name = "C-class";

						if (Dm_num.equals("Cc_001"))
							DM_name = "C-class W205";
						else if (Dm_num.equals("Cc_002"))
							DM_name = "C-class W204";
						else if (Dm_num.equals("Cc_003"))
							DM_name = "C-class";
					} else if (Model_num.equals("Bz3")) {
						Model_name = "S-class";

						if (Dm_num.equals("Sc_001"))
							DM_name = "S-class W222";
						else if (Dm_num.equals("Sc_002"))
							DM_name = "S-class W221";
						else if (Dm_num.equals("Sc_003"))
							DM_name = "S-class";
					} else if (Model_num.equals("Bz4")) {
						Model_name = "CLS-class";

						if (Dm_num.equals("CLSc_001"))
							DM_name = "CLS-class C257";
						else if (Dm_num.equals("CLSc_002"))
							DM_name = "CLS-class W218";
						else if (Dm_num.equals("CLSc_003"))
							DM_name = "CLS-class W219";
					}

				} else if (Make_code.equals("008")) {
					Make_name = "Volkswagen";

					if (Model_num.equals("V1")) {
						Model_name = "Golf";

						if (Dm_num.equals("G_001"))
							DM_name = "Golf 7th";
						else if (Dm_num.equals("G_002"))
							DM_name = "Golf 6th";
						else if (Dm_num.equals("G_003"))
							DM_name = "Golf 5th";
					} else if (Model_num.equals("V2")) {
						Model_name = "Tiguan";

						if (Dm_num.equals("T_001"))
							DM_name = "Tiguan Allspace";
						else if (Dm_num.equals("T_002"))
							DM_name = "Tiguan 2th";
						else if (Dm_num.equals("T_003"))
							DM_name = "New Tiguan";
					} else if (Model_num.equals("V3")) {
						Model_name = "Passat";

						if (Dm_num.equals("Ps_001"))
							DM_name = "Passat GT(B8)";
						else if (Dm_num.equals("Ps_002"))
							DM_name = "The New Passat";
						else if (Dm_num.equals("Ps_003"))
							DM_name = "New Passat";
					} else if (Model_num.equals("V4")) {
						Model_name = "Beetle";

						if (Dm_num.equals("Bt_001"))
							DM_name = "The Beetle";
						else if (Dm_num.equals("Bt_002"))
							DM_name = "New Beetle";
						else if (Dm_num.equals("Bt_003"))
							DM_name = "Beetle";
					}

				}

				//i++;

				out.println("<tr>");
				out.println("<td>" + Model_year + "</td>");
				out.println("<td>" + Mileage + "</td>");
				out.println("<td>" + Price + "</td>");
				out.println("<td>" + Vnumber + "</td>");
				out.println("<td>" + Make_name + "</td>");
				out.println("<td>" + Model_name + "</td>");
				out.println("<td>" + DM_name + "</td>");

				if (Color2 == null) {
					out.println("<td>" + Color1 + "</td>");
					out.println("<td>" + "-" + "</td>");
					out.println("<td>" + Engine_amount + "</td>");

				} else {
					out.println("<td>" + Color1 + "</td>");
					out.println("<td>" + Color2 + "</td>");
					out.println("<td>" + Engine_amount + "</td>");

				}
				if (Fcode2 == null) {
					out.println("<td>" + Fuel1 + "</td>");
					out.println("<td>" + "-" + "</td>");
					out.println("<td>" + Catename + "</td>");
					out.println("<td>" + Transname + "</td>");

				} else {
					out.println("<td>" + Fuel1 + "</td>");
					out.println("<td>" + Fuel2 + "</td>");
					out.println("<td>" + Catename + "</td>");
					out.println("<td>" + Transname + "</td>");

				}

			}
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}

		//차량 구매할지 물어봄
	%>
<h2>Order Confirmation</h2>
		<form action="ordering.jsp" method="POST">
			loginid:<input type="text" name="loginid" /> 
			<hr>
			"Are you sure to buy this car?"
			<input type="radio" name="yes_no" value="y">Yes</input>
			 <input	type="radio" name="yes_no" value="n">No</input>
			 <br/>
			<input type="submit" value="enter" />
			<br/>
			<input type="hidden" value="<%out.print(SearchVenum); %>" id="make" name="vnum">
		</form>
	</div>
	
</body>

</html>