<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� �˻�</title>
<script>
</script>
</head>
<body>
<form action = "index.jsp">
	<h3>�˻��� �μ� ����</h3>
	<input type='checkbox' id='Research' value='H' checked/>Headquarters
	<input type='checkbox' id='Administraion' value='A' checked/>Administration
	<input type='checkbox' id='Research' value='R' checked/>Research
	
	<h3>���� �˻� ����</h3>
	<input type='checkbox' name='Name' value='1' checked/> Name
	<input type='checkbox' name='Ssn' value='1' checked/> Ssn
	<input type='checkbox' name='Bdate' value='1' checked/> Bdate
	<input type='checkbox' name='Address' value='1' checked/> Address
	<input type='checkbox' name='Sex' value='1' checked/> Sex
	<input type='checkbox' name='Salary' value='1' checked/> Salary
	<input type='checkbox' name='Supervisor' value='1' checked/> Supervisor
	<input type='checkbox' name='Department' value='1' checked/> Department
	<br><br>
	<button type='submit' name='choice' value='search'>�˻�</button>
	
	<h3>�߰� �۾�</h3>
	<label><input type='radio' name='work' value="insert">insert</label>
	<label><input type='radio' name='work' value='update'>update</label>
	<label><input type='radio' name='work' value='delete'>delete</label>
	<button>����</button>
	
	<table border="1">
	<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/practice?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "root");
		
		stmt = conn.createStatement();
		
		System.out.println(request.getParameter("work"));
		if(request.getParameter("choice") != null){
			
		}
		
	} catch(ClassNotFoundException e) {
		System.out.println("����̹� �ε� ����");
	} catch(SQLException e) {
		System.out.println("����: " + e);
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
</table>
</form>
</body>
</html>