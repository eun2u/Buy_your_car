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
			if (yesorno.equals("y")) // ��ڴ�!!
			{
				// VEHICLE���̺��� �� ������ Ac_id�� �α����� ������ ���̵�� update
				sql = "UPDATE VEHICLE SET Ac_id = '" + AccountID + "' WHERE Vnumber = '" + SearchVenum + "'";

				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				conn.commit();

				// ���� ��¥ "yyyy-mm-dd"�������� ������

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar c1 = Calendar.getInstance();
				String strToday = sdf.format(c1.getTime());

				// �ֹ���ȣ �������� ����빮��2+����4 (6����)
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
					if (!rs.next()) // �������� ������� �ֹ���ȣ�� ���� �������� �ʴ� ��ȣ��� ����!
						break;

				}

				// CARORDER���̺� �����ֹ���ȣ, �����Ϸ��� ������ȣ, ���ó�¥, ����������̵�� insert����
				sql = "INSERT INTO CARORDER VALUES('" + ordernum + "', '" + SearchVenum + "', TO_DATE('" + strToday
						+ "', 'yyyy-mm-dd'), '" + AccountID + "')";
				pstmt = conn.prepareStatement(sql);
				int res = pstmt.executeUpdate(sql);

				conn.commit();
				System.out.println("\n�ֹ���ȣ-" + ordernum + ": '" + SearchVenum + "'�� �������Ű� �Ϸ�Ǿ����ϴ�.");
			}
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	%>

</body>
</html>