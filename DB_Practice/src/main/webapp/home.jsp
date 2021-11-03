<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� �˻�</title>
<script>

</script>
</head>
<body>
<form action = "home.jsp">
	<table border="1">
	<%
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/class?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "root");
		
		stmt = conn.createStatement();
		
		%>
		<h3>�˻� ����</h3>
		<input type='radio' name='search' value='sDefault' checked/>��ü
		<input type='radio' name='search' value='sDepartment' />�μ�
		<input type='radio' name='search' value='sSex' />����
		<input type='radio' name='search' value='sSalary' />����
		<input type='radio' name='search' value='sBirthday' />����
		<input type='radio' name='search' value='sUnderling' />��������
		<button type='submit' name='searchRange' value='ss'>����</button>
		<%
		
		if(request.getParameter("searchRange") != null){
			String param = request.getParameter("search");
			if(param.equals("sDepartment")){
				%>
					<h3>�μ� ����</h3>
					<input type='radio' name='ssDepartment' value='H' checked/>Headquarters
					<input type='radio' name='ssDepartment' value='A'/>Administration
					<input type='radio' name='ssDepartment' value='R'/>Research
				<%
			}
			else if(param.equals("sSex")){
				%>
					<h3>���� ����</h3>
					<input type='radio' name='ssSex' value='M' checked/>M
					<input type='radio' name='ssSex' value='F'/>F
				<%
			}
			else if(param.equals("sSalary")){
				%>
					<h3>���� �Է�</h3>
					<input type='text' size='15' name='ssSalary'>
				<%
			}
			else if(param.equals("sBirthday")){
				%>
					<h3>��¥ ����</h3>
					<input type='radio' name="ssMonth" value='sJan' checked/>1��
					<input type='radio' name="ssMonth" value='sFeb'/>2��
					<input type='radio' name="ssMonth" value='sMar'/>3��
					<input type='radio' name="ssMonth" value='sApr'/>4��
					<input type='radio' name="ssMonth" value='sMay'/>5��
					<input type='radio' name="ssMonth" value='sJun'/>6��
					<input type='radio' name="ssMonth" value='sJul'/>7��
					<input type='radio' name="ssMonth" value='sAug'/>8��
					<input type='radio' name="ssMonth" value='sSep'/>9��
					<input type='radio' name="ssMonth" value='sOct'/>10��
					<input type='radio' name="ssMonth" value='sNov'/>11��
					<input type='radio' name="ssMonth" value='sDec'/>12��
				<%
			}
			else if(param.equals("sUnderling")){
				%>
					<h3>����� Ssn �Է�</h3>
					<input type='text' size='10' name='ssUnderling'/>
				<%
			}
		}
		
		%>
			<h3>���� �˻� ����</h3>
			<input type='checkbox' name='sName' value='1' checked/> Name
			<input type='checkbox' name='sSsn' value='1' checked/> Ssn
			<input type='checkbox' name='sBdate' value='1' checked/> Bdate
			<input type='checkbox' name='sAddress' value='1' checked/> Address
			<input type='checkbox' name='sSex' value='1' checked/> Sex
			<input type='checkbox' name='sSalary' value='1' checked/> Salary
			<input type='checkbox' name='sSupervisor' value='1' checked/> Supervisor
			<input type='checkbox' name='sDepartment' value='1' checked/> Department
			<br><br>
			<button type='submit' name='choice' value='search'>�˻�</button>
		<%
		
		%>
		<h3>�߰� �۾�</h3>
		<label><input type='radio' name='work' value="insert">���� �߰�</label>
		<label><input type='radio' name='work' value='update'>���� �޿� ����</label>
		<label><input type='radio' name='work' value='delete'>���� ����</label>
		<button type='submit' name='work'>����</button>
		<br><br>
		<%
		
		// insert, update, delete ���� 
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
					<button type='submit' name='choice' value='insert'>���� �߰�</button>
				<%
			}
			else if(request.getParameter("work").equals("update")){
				%>
					<label>�޿��� �߰��� ����� ssn &nbsp;<input type='text' size='15' name='uSsn'></label><br><br>
					<label>���� �� �޿� &nbsp;<input type='text' size='15' name='uSalary'></label><br><br>
					<button type='submit' name='choice' value='update'>�޿� ����</button>
				<%
			}
			else if(request.getParameter("work").equals("delete")){
				%>
					<label>������ ����� ssn &nbsp;<input type='text' size='15' name='dSsn'></label><br><br>
					<button type='submit' name='choice' value='delete'>���� ����</button>
				<%
			}
		}
		
		
		if(request.getParameter("choice") != null){
			if(request.getParameter("choice").equals("insert")){
				String[] arr = {"iFname", "iMinit", "iLname", "iSsn", "iBdate", "iAddress", "iSex", "iSalary", "iSuper_ssn", "iDno"};
				boolean flag = true;
				for(int i = 0; i < arr.length; i++){
					if(request.getParameter(arr[i]).equals("")) flag = false;
				}
				
				if(flag){
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
		
		// ǥ �����ִ� ���� ��� ���������
		if(request.getParameter("choice") != null){
			String query = "SELECT concat(a.Fname, ' ', a.Minit, ' ', a.Lname) as Name, a.Ssn, ";
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("Name", "1");
			map.put("Ssn", "1");
			if(request.getParameter("sBdate") != null){
				query += "a.Bdate, ";
				map.put("Bdate", "1");
			}
			if(request.getParameter("sAddress") != null){
				query += "a.Address, ";
				map.put("Address", "1");
			}
			if(request.getParameter("sSex") != null){
				query += "a.Sex, ";
				map.put("Sex", "1");
			}
			if(request.getParameter("sSalary") != null){
				query += "a.Salary, ";
				map.put("Salary", "1");
			}
			if(request.getParameter("sSupervisor") != null){
				query += "concat(b.Fname, ' ', b.Minit, ' ', b.Lname) as Supervisor, ";
				map.put("Supervisor", "1");
			}
			if(request.getParameter("sDepartment") != null){
				query += "Dname, ";
				map.put("Dname", "1");
			}
			query = query.substring(0, query.length() - 2);
			query += " FROM employee a LEFT JOIN employee b ON a.super_ssn=b.ssn JOIN department ON a.Dno=Dnumber";
			
			if(request.getParameter("ssDepartment") != null){
				query += " where Dname = ";
				if(request.getParameter("ssDepartment").equals("H")) query += "'Headquarters'";
				else if(request.getParameter("ssDepartment").equals("A")) query += "'Administration'";
				else query += "'Research'";
			}
			else if(request.getParameter("ssSex") != null){
				query += " where a.Sex = ";
				if(request.getParameter("ssSex").equals("M")) query += "'M'";
				else query += "'F'";
			}
			else if(request.getParameter("ssSalary") != null && !request.getParameter("ssSalary").equals("")){
				query += " where a.Salary > " + request.getParameter("ssSalary");
			}
			else if(request.getParameter("ssMonth") != null){
				String[] ans = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
				String[] arr = {"sJan", "sFeb", "sMar", "sApr", "sMay", "sJun", "sJul", "sAug", "sSep", "sOct", "sDec", "sNov"};
				query += " where MONTH(a.Bdate) = ";
				
				for(int i = 0; i < 12; i++){
					if(request.getParameter("ssMonth").equals(arr[i])){
						query += ans[i];
					}
				}
			}
			else if(request.getParameter("ssUnderling") != null && !request.getParameter("ssUnderling").equals("")){
				query += " where a.Super_ssn = " + request.getParameter("ssUnderling");
			}
			query += ";";
			
			rs = stmt.executeQuery(query);
			
			// �˻� ���̺� ����
			%>
			<th>����</th>
			<th>NAME</th>
			<th>SSN</th>
			<%
			if(map.containsKey("Bdate")){
				%> <th>BDATE</th> <%
			}
			if(map.containsKey("Address")){
				%> <th>ADDRESS</th> <%
			}
			if(map.containsKey("Sex")){
				%> <th>SEX</th> <%
			}
			if(map.containsKey("Salary")){
				%> <th>SALARY</th> <%
			}
			if(map.containsKey("Supervisor")){
				%> <th>SUPERVISOR</th> <%
			}
			if(map.containsKey("Dname")){
				%> <th>DEPARTMENT</th> <%
			}
			
			while(rs.next()){
				String Name = rs.getString(1);
				String Ssn = rs.getString(2);
				%>
				<tr>
					<td> <input type="checkbox" value<%=Ssn %>> </td>
					<td size="25"><%=Name%></td>
					<td><%=Ssn%></td>
				<%
				int val = 3;
				if(map.containsKey("Bdate")){
					String Bdate = rs.getString(val);
					val += 1;
					%><td><%=Bdate%></td><%
				}
				if(map.containsKey("Address")){
					String Address = rs.getString(val);
					val += 1;
					%><td><%=Address%></td><%
				}
				if(map.containsKey("Sex")){
					String Sex = rs.getString(val);
					val += 1;
					%><td><%=Sex%></td><%
				}
				if(map.containsKey("Salary")){
					String Salary = rs.getString(val);
					val += 1;
					%><td><%=Salary%></td><%
				}
				if(map.containsKey("Supervisor")){
					String Super_ssn = rs.getString(val);
					val += 1;
					%><td><%=Super_ssn%></td><%
				}
				if(map.containsKey("Dname")){
					String Dname = rs.getString(val);
					val += 1;
					%><td><%=Dname%></td><%
				}
				%> </tr> <%
			}
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