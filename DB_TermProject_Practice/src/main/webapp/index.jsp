<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%
// 구현 순서
// 1. search 선택 기능
// 2. insert, update, delete html 구현
// 3. 2번 내용 sql에 접근
// 4. search 내용 sql에 접근하여 html에 보이게 함
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>직원 정보 검색</title>
<script>
</script>
</head>
<body>
<form action = "index.jsp">
	<h3>검색할 부서 선택</h3>
	<input type='checkbox' name='sResearch' value='H' checked/>Headquarters
	<input type='checkbox' name='sAdministraion' value='A' checked/>Administration
	<input type='checkbox' name='sResearch' value='R' checked/>Research
	
	<h3>세부 검색 설정</h3>
	<input type='checkbox' name='sName' value='1' checked/> Name
	<input type='checkbox' name='sSsn' value='1' checked/> Ssn
	<input type='checkbox' name='sBdate' value='1' checked/> Bdate
	<input type='checkbox' name='sAddress' value='1' checked/> Address
	<input type='checkbox' name='sSex' value='1' checked/> Sex
	<input type='checkbox' name='sSalary' value='1' checked/> Salary
	<input type='checkbox' name='sSupervisor' value='1' checked/> Supervisor
	<input type='checkbox' name='sDepartment' value='1' checked/> Department
	<br><br>
	<button type='submit' name='choice' value='search'>검색</button>
	
	<h3>추가 작업</h3>
	<label><input type='radio' name='work' value="insert">직원 추가</label>
	<label><input type='radio' name='work' value='update'>직원 급여 변경</label>
	<label><input type='radio' name='work' value='delete'>직원 삭제</label>
	<button type='submit' name='work'>선택</button>
	<br><br>
	
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
		
		// insert, update, delete html 구현 
		if(request.getParameter("work") != null){
			if(request.getParameter("work").equals("insert")){
				%>
					<table border="1">
						<th>Fname</th>
						<th>Minit</th>
						<th>Lname</th>
						<th>Ssn</th>
						<th>Bdate</th>
						<th>Address</th>
						<th>Sex</th>
						<th>Salary</th>
						<th>Super_ssn</th>
						<th>Dno</th>
						<tr>
							<td><input type="text" size="8" name="iFname"></td>
							<td><input type="text" size="2" name="iMinit"></td>
							<td><input type="text" size="8" name="iLname"></td>
							<td><input type="text" size="10" name="iSsn"></td>
							<td><input type="text" size="15" name="iBdate"></td>
							<td><input type="text" size="30" name="iAddress"></td>
							<td><input type="text" size="2" name="iSex"></td>
							<td><input type="text" size="9" name="iSalary"></td>
							<td><input type="text" size="10" name="iSuper_ssn"></td>
							<td><input type="text" size="3" name="iDno"></td>
						</tr>
					</table>
					<button type='submit' name='choice' value='insert'>직원 추가</button>
				<%
			}
			else if(request.getParameter("work").equals("update")){
				%>
					<label>급여를 추가할 사원의 ssn &nbsp;<input type='text' size='15' name='uSsn'></label><br><br>
					<label>변경 후 급여 &nbsp;<input type='text' size='15' name='uSalary'></label><br><br>
					<button type='submit' name='choice' value='update'>급여 변경</button>
				<%
			}
			else if(request.getParameter("work").equals("delete")){
				%>
					<label>삭제할 사원의 ssn &nbsp;<input type='text' size='15' name='dSsn'></label><br><br>
					<button type='submit' name='choice' value='delete'>직원 삭제</button>
				<%
			}
		}
		
		
		if(request.getParameter("choice") != null){
			if(request.getParameter("choice").equals("insert")){
				String query = "INSERT INTO EMPLOYEE VALUES ("
						+ "'" + request.getParameter("iFname") + "'" + ", "
						+ "'" + request.getParameter("iMinit") + "'" + ", "
						+ "'" + request.getParameter("iLname") + "'" + ", "
						+ "'" + request.getParameter("iSsn") + "'" + ", "
						+ "'" + request.getParameter("iBdate") + "'" + ", "
						+ "'" + request.getParameter("iAddress") + "'" + ", "
						+ "'" + request.getParameter("iSex") + "'" + ", "
						+ "'" + request.getParameter("iSalary") + "'" + ", "
						+ "'" + request.getParameter("iSuper_ssn") + "'" + ", "
						+ "'" + request.getParameter("iDno") + "'" + ");";
				conn.prepareStatement(query).executeUpdate();
			}
			else if(request.getParameter("choice").equals("update")){
				String query = "UPDATE EMPLOYEE SET Salary='"
								+ request.getParameter("uSalary") + "' "
								+ "WHERE Ssn='" + request.getParameter("uSsn") +
								"';";
				conn.prepareStatement(query).executeUpdate();
			}
			else if(request.getParameter("choice").equals("delete")){
				String query = "DELETE FROM EMPLOYEE WHERE Ssn=" + request.getParameter("dSsn") +";";
				conn.prepareStatement(query).executeUpdate();
			}
		}
		
		// 표 보여주는 것은 계속 보여줘야함
		if(request.getParameter("choice") != null){
			
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
</table>
</form>
</body>
</html>