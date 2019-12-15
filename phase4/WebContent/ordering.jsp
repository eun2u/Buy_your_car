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
		String AccountID = request.getParameter("loginid");
		String yesorno = request.getParameter("yes_no");

		System.out.println(yesorno);

		try {
			if (yesorno.equals("y")) // 사겠다!!
			{
				// VEHICLE테이블에서 그 차량의 Ac_id를 로그인한 계정의 아이디로 update
				sql = "UPDATE VEHICLE SET Ac_id = '" + AccountID + "' WHERE Vnumber = '" + SearchVenum + "'";

				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				conn.commit();

				// 오늘 날짜 "yyyy-mm-dd"형식으로 얻어오기

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar c1 = Calendar.getInstance();
				String strToday = sdf.format(c1.getTime());

				// 주문번호 랜덤으로 영어대문자2+숫자4 (6글자)
				StringBuffer buf = new StringBuffer();
				String ordernum;

				while (true) {
					Random rnd = new Random();
					for (int i = 0; i < 6; i++) {
						if (i < 2) {
							buf.append((char) ((int) (rnd.nextInt(26)) + 65));
						} else {
							buf.append((rnd.nextInt(10)));
						}
					}

					ordernum = buf.toString();
					sql = "SELECT * FROM CARORDER WHERE Ordernumber = '" + ordernum + "'";

					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if (!rs.next()) // 랜덤으로 만들어진 주문번호가 지금 존재하지 않는 번호라면 선택!
						break;

				}

				// CARORDER테이블도 랜덤주문번호, 구매하려는 차량번호, 오늘날짜, 현재계정아이디로 insert해줌
				sql = "INSERT INTO CARORDER VALUES('" + ordernum + "', '" + SearchVenum + "', TO_DATE('" + strToday
						+ "', 'yyyy-mm-dd'), '" + AccountID + "')";
				pstmt = conn.prepareStatement(sql);
				int res = pstmt.executeUpdate(sql);

				conn.commit();
				System.out.println("\n주문번호-" + ordernum + ": '" + SearchVenum + "'번 차량구매가 완료되었습니다.");
			}
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	%>

</body>
</html>