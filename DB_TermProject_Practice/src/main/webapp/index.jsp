<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>직원 정보 검색</title>
</head>
<body>
<form action = "index.jsp">
<h3>검색 범위</h3>
<input type='checkbox' name='Name' value='flag_Name' checked="checked"/> Name
<input type='checkbox' name='Ssn' value='flag_Ssn' checked="checked" /> Ssn
<input type='checkbox' name='Bdate' value='flag_Bdate' checked="checked" /> Bdate
<input type='checkbox' name='Address' value='flag_Address' checked="checked" /> Address
<input type='checkbox' name='Sex' value='flag_Sex' checked="checked" /> Sex
<input type='checkbox' name='Salary' value='flag_Salary' checked="checked" /> Salary
<input type='checkbox' name='Supervisor' value='flag_Supervisor' checked="checked" /> Supervisor
<input type='checkbox' name='Department' value='flag_Department' checked="checked" /> Department
<button name = 'choice' value='search'>search</button>
</form>

<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/practice?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "root");
		System.out.println("연결 성공");
		
		stmt = conn.createStatement();
		
		String sql = "SELECT * FROM EMPLOYEE";
		rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			String Fname = rs.getString(1);
			String Minit = rs.getString(2);
			String Lname = rs.getString(3);
			String Ssn = rs.getString(4);
			String Bdate = rs.getString(5);
			String Address = rs.getString(6);
			String Sex = rs.getString(7);
			String Salary = rs.getString(8);
			String Super_ssn = rs.getString(9);
			String Dno = rs.getString(10);
			
			System.out.println(Fname + "." + Minit + " " + Lname + "  " + Ssn);
		}
		
		
	} catch(ClassNotFoundException e) {
		System.out.println("드라이버 로딩 실패");
	} catch(SQLException e) {
		System.out.println("에러: " + e);
	}
	
	
	
	
	finally {
		try {
			if(conn != null && !conn.isClosed()) {
				conn.close();
			}
			if(stmt != null && !stmt.isClosed()) {
				stmt.close();
			}
			if(rs != null && !rs.isClosed()) {
				rs.close();
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>