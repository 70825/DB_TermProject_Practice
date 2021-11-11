<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.regex.Pattern" %>
<!DOCTYPE html>
<html>
<head>
	<title>직원 정보 검색</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
   
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/customize.css">	
</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.6/umd/popper.min.js"></script>    
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function onChanged(radio) {

			$('.' + radio.value).show();
			$('.' + radio.value).attr("disabled", false);
			
			if(radio.value !== "sDepartment") {
				$(".sDepartment").hide();
				$(".sDepartment").attr("disabled",true);
			}
			if(radio.value !== "sSex"){
				$(".sSex").hide();
				$(".sSex").attr("disabled",true);
			}
			if(radio.value !== "sSalary"){
				$(".sSalary").hide();
				$(".sSalary").attr("disabled",true);
			}
			if(radio.value !== "sBirthday"){
				$(".sBirthday").hide();
				$(".sBirthday").attr("disabled",true);
			}
			if(radio.value !== "sUnderling"){
				$(".sUnderling").hide();
				$(".sUnderling").attr("disabled",true);
			}
			if(radio.value !== "sAddress"){
				$(".sAddress").hide();
				$(".sAddress").attr("disabled",true);
			}
			if(radio.value !== "sRelationship"){
				$(".sRelationship").hide();
				$(".sRelationship").attr("disabled",true);
			}
		}
		
		function onChangedAddWork(radio) {
			$('.' + radio.value).show();
			$('.' + radio.value).attr("disabled", false);
			
			if(radio.value !== "insert") {
				$(".insert").hide();
				$(".insert").attr("disabled", true);
			}
			if(radio.value !== "update") {
				$(".update").hide();
				$(".update").attr("disabled", true);
				$(".uAddress").hide();
				$(".uAddress").attr("disabled", true);
				$(".uSex").hide();
				$(".uSex").attr("disabled", true);
				$(".uSalary").hide();
				$(".uSalary").attr("disabled", true);
			}
			if(radio.value !== "delete") {
				$(".delete").hide();
				$(".delete").attr("disabled", true);
			}
		}
	
		function onChangedUpdate(radio) {
			$('.' + radio.value).show();
			$('.' + radio.value).attr("disabled", false);
			lastUpdate=radio.value;
			
			if(radio.value !== "uAddress") {
				$(".uAddress").hide();
				$(".uAddress").attr("disabled", true);
			}
			if(radio.value !== "uSex") {
				$(".uSex").hide();
				$(".uSex").attr("disabled", true);
			}
			if(radio.value !== "uSalary") {
				$(".uSalary").hide();
				$(".uSalary").attr("disabled", true);
			}
		}
	</script>
	<form action = "home.jsp">
		<table border="1">
		<%
		Connection conn = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost/company?serverTimezone=UTC";
			conn = DriverManager.getConnection(url, "root", "root");
			
			stmt = conn.createStatement();
			
			%>
			<h3>검색 범위</h3>
			<div class="btn-group" data-toggle="buttons">
				<label class="btn btn-primary active">
					<input type='radio' name='search' value='sDefault' onchange="onChanged(this);" checked/>전체
				</label>
				<label class="btn btn-primary">
					<input type='radio' name='search' value='sDepartment' onchange="onChanged(this);"/>부서
				</label>
				<label class="btn btn-primary">
					<input type='radio' name='search' value='sSex' onchange="onChanged(this);"/>성별
				</label>
				<label class="btn btn-primary">
					<input type='radio' name='search' value='sSalary' onchange="onChanged(this);"/>연봉
				</label>
				<label class="btn btn-primary">
					<input type='radio' name='search' value='sBirthday' onchange="onChanged(this);"/>생일
				</label>
				<label class="btn btn-primary">
					<input type='radio' name='search' value='sUnderling' onchange="onChanged(this);"/>부하직원
				</label>
				<label class="btn btn-primary">
					<input type='radio' name='search' value='sAddress' onchange="onChanged(this);"/>거주지
				</label>
				<label class="btn btn-primary">
					<input type='radio' name='search' value='sRelationship' onchange="onChanged(this);"/>가족 관계
				</label>
			</div>
			<div class="sDepartment" style="display: none;" disabled>
				<h3>부서 선택</h3>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-success">
						<input type='radio' name='ssDepartment' value='H'/>Headquarters
					</label>
					<label class="btn btn-success">
						<input type='radio' name='ssDepartment' value='A'/>Administration
					</label>
					<label class="btn btn-success">
						<input type='radio' name='ssDepartment' value='R'/>Research
					</label>
				</div>
			</div>
			<div class="sSex" style="display: none;" disabled>
				<h3>성별 선택</h3>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-success">
						<input type='radio' name='ssSex' value='M'/>M
					</label>
					<label class="btn btn-success">
						<input type='radio' name='ssSex' value='F'/>F
					</label>					
				</div>
			</div>
			<div class="sSalary" style="display: none;" disabled>
				<h3>연봉 입력</h3>
				<input type='text' size='15' name='ssSalary'>
			</div>
			<div class="sBirthday" style="display: none;" disabled>
				<h3>날짜 선택</h3>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sJan'/>1월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sFeb'/>2월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sMar'/>3월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sApr'/>4월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sMay'/>5월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sJun'/>6월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sJul'/>7월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sAug'/>8월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sSep'/>9월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sOct'/>10월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sNov'/>11월
					</label>
					<label class="btn btn-success">
						<input type='radio' name="ssMonth" value='sDec'/>12월
					</label>
				</div>
			</div>
			<div class="sUnderling" style="display: none;" disabled>
				<h3>상사의 Ssn 입력</h3>
				<input type='text' size='10' name='ssUnderling'/>
			</div>
			<div class="sAddress" style="display: none;" disabled>
				<h3>거주지 입력</h3>
				<input type='text' size='10' name='ssAddress'/>
			</div>
			<div class="sRelationship" style="display: none;" disabled>
				<h3>관계 선택</h3>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-success">
						<input type='radio' name='ssRelationship' value='S'/>아들
					</label>
					<label class="btn btn-success">
						<input type='radio' name='ssRelationship' value='D'/>딸
					</label>
					<label class="btn btn-success">
						<input type='radio' name='ssRelationship' value='W'/>아내
					</label>
					<label class="btn btn-success">
						<input type='radio' name='ssRelationship' value='N'/>없음
					</label>
				</div>
			</div>
			
			<h3>세부 검색 설정</h3>
			<div class="btn-group" data-toggle="buttons">
				<label class="btn btn-primary active">
					<input type='checkbox' name='sName' value='1' checked/> Name
				</label>
				<label class="btn btn-primary active">
					<input type='checkbox' name='sSsn' value='1' checked/> Ssn
				</label>
				<label class="btn btn-primary active">
					<input type='checkbox' name='sBdate' value='1' checked/> Bdate
				</label>
				<label class="btn btn-primary active">
					<input type='checkbox' name='sAddress' value='1' checked/> Address
				</label>
				<label class="btn btn-primary active">
					<input type='checkbox' name='sSex' value='1' checked/> Sex
				</label>
				<label class="btn btn-primary active">
					<input type='checkbox' name='sSalary' value='1' checked/> Salary
				</label>
				<label class="btn btn-primary active">
					<input type='checkbox' name='sSupervisor' value='1' checked/> Supervisor
				</label>
				<label class="btn btn-primary active">
					<input type='checkbox' name='sDepartment' value='1' checked/> Department
				</label>
			</div>
			<br><br>
			<button class="btn btn-info" type='submit' name='choice' value='search'>검색</button>
			<%
			
			%>
			<br><br>
			<h3>추가 작업</h3>
			<div class="btn-group" data-toggle="buttons">
				<label class="btn btn-warning">
					<input type='radio' name='work' value="insert" onchange="onChangedAddWork(this);">직원 추가
				</label>
				<label class="btn btn-warning">
					<input type='radio' name='work' value='update' onchange="onChangedAddWork(this);">직원 정보 변경
				</label>
				<label class="btn btn-warning">
					<input type='radio' name='work' value='delete' onchange="onChangedAddWork(this);">직원 삭제
				</label>
			</div>
			<div class="insert" style="display:none;">
				<div style="margin-left:3%">
						<form id="insertForm">
						  <div class="form-row">
						    <div class="col-md-2">
						      <div class="md-form form-group">
    						    <label for="iFname">First Name</label>
						        <input type="text" size="8" name="iFname" class="form-control" placeholder="Fname">
						      </div>
						    </div>
						
						    <div class="col-md-2">
						      <div class="md-form form-group">
						        <label for="iMinit">Middle Initial</label>
						        <input type="text" size="2" name="iMinit" class="form-control" placeholder="Minit">
						      </div>
						    </div>
						    
   						    <div class="col-md-2">
						      <div class="md-form form-group">
						        <label for="iLname">Last Name</label>
						        <input type="text" size="8" name="iLname" class="form-control" placeholder="Lname">
						      </div>
						    </div>
						  </div>
						  
						  <div class="form-row">
						    <div class="col-md-3">
						      <div class="md-form form-group">
 						        <label for="iSsn">SSN</label>
						        <input type="text" size="10" name="iSsn" class="form-control" placeholder="SSN" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'');">
						      </div>
						    </div>
						    
						    <div class="col-md-3">
						    	<label for="iSex">Sex</label>
						    	<br>
							    <div class="btn-group" data-toggle="buttons">
							      <label class="btn btn-success">
								    <input type="radio" name="iSex" value="M">남자
							      </label>
								  <label class="btn btn-success">
								    <input type="radio" name="iSex" value="F">여자
								  </label>
							  </div>
						    </div>
						  </div>

						  <div class="form-row">
						    <div class="col-md-6">
						      <div class="md-form form-group">
						        <label for="iAddress">Address</label>
						        <input type="text" size="30" name="iAddress" class="form-control" placeholder="Address">
						      </div>
						    </div>
					      </div>
					      
						  <div class="form-row">
						    <div class="col-md-3">
						      <div class="md-form form-group">
						        <label for="iBdate">Date of Birth</label>
						        <input type="text" size="15" name="iBdate" class="form-control" placeholder="YYYY-MM-DD">
						      </div>
						    </div>

						    <div class="col-md-3">
						      <div class="md-form form-group">
						        <label for="iSalary">Salary</label>
						        <input type="text" size="9" name="iSalary" class="form-control" placeholder="Salary">
						      </div>
						    </div>
						  </div>
						  
						  <div class="form-row">
						    <div class="col-md-3">
						      <div class="md-form form-group">
						        <label for="iSuper_ssn">Super SSN</label>
						        <input type="text" size="10" name="iSuper_ssn" class="form-control" placeholder="Super SSN">
						      </div>
						    </div>

						    <div class="col-md-3">
						      <div class="md-form form-group">
						        <label for="iDno">Dno</label>
						        <input type="text" size="3" name="iDno" class="form-control" placeholder="Dno">
						      </div>
						    </div>
						  </div>
						  
						  <button type='submit' name='choice' value='insert' class="btn btn-info btn-md">직원 추가</button>
						</form>
					</div>
			</div>
				
			<div class="update" style="display: none;" disabled>
				<div class="btn-group"" data-toggle="buttons">
					<label class="btn btn-success">
						<input type="radio" name="uSelect" value="uAddress" onchange="onChangedUpdate(this);">주소 변경
					</label>
					<label class="btn btn-success">
						<input type="radio" name="uSelect" value="uSex" onchange="onChangedUpdate(this);">성별 변경
					</label>
					<label class="btn btn-success">
						<input type="radio" name="uSelect" value="uSalary" onchange="onChangedUpdate(this);">급여 변경
					</label>
				</div>
			</div>
			<div class="delete" style="display: none;" disabled>
				<button class="btn btn-danger" type='submit' name='choice' value='delete'>직원 삭제</button>
			</div>
			
			<div class="uAddress" style="display:none;">
				<label><h4>주소 입력창 &nbsp;</h4><input type='text' size='30' name='uuAddress'></label> <br>
				<button class="btn btn-info" type='submit' name='updateChoice' value='uuAddress'>주소 변경 적용</button>
			</div>
			<div class="uSex" style="display:none;">
				<p>성별 변경</p>
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-success">
						<input type='radio' name='uuSex' value='M'/>  M  
					</label>
					<label class="btn btn-success">
						<input type='radio' name='uuSex' value='F'/>  F  
					</label>					
				</div> 
				<br>
				<button class="btn btn-info" type='submit' name='updateChoice' value='uuSex'>성별 변경</button>
			</div>
			<div class="uSalary" style="display:none;">
				<label>급여 수정 &nbsp;<input type='text' size='15' name='uuSalary'></label><br>
				<button class="btn btn-info" type='submit' name='updateChoice' value='uuSalary'>급여 변경</button>
			</div>
			
			<%
			
			// insert, update, delete 구현
			try{
				if(request.getParameter("choice") != null){ // insert와 delete 쿼리
					if(request.getParameter("choice").equals("insert")){
						String[] arr = {"iFname", "iMinit", "iLname", "iSsn", "iBdate", "iAddress", "iSex", "iSalary", "iSuper_ssn", "iDno"};
						String[] sql_arr = {"Fname", "Minit", "Lname", "Ssn", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno"};
						String[] vaild = { "^[a-zA-Z]*$", "^[a-zA-Z]*$", "^[a-zA-Z]*$", "^\\d{9}$", "^(\\d{4})-(\\d{1,2})-(\\d{1,2})$", "^[a-zA-Z0-9]*$", "^(M|F)$", "^[0-9]*$", "^\\d{9}$", "^(?:1|4|5)$"};  
						boolean validFlag = true;

						String query = "INSERT INTO EMPLOYEE(";
						for(int i = 0; i < sql_arr.length; i++){
							if(request.getParameter(arr[i]) != null && !request.getParameter(arr[i]).equals("")){
								if(!Pattern.matches(vaild[i], request.getParameter(arr[i]))) validFlag = false;
								query += sql_arr[i] + ", ";
							}
						}
						query = query.substring(0, query.length() - 2) + ") VALUES(";
								
						for(int i = 0; i < arr.length; i++){
							if(request.getParameter(arr[i]) != null && !request.getParameter(arr[i]).equals("")){
								query += "'" + request.getParameter(arr[i]) + "', ";
							}
						}
						query = query.substring(0, query.length() - 2) + ");";
								
						if(validFlag) conn.prepareStatement(query).executeUpdate();
					}
					else if(request.getParameter("choice").equals("delete")){
						String[] deleteEmployeeSsn = request.getParameterValues("updateCheckBox");
						if(deleteEmployeeSsn != null && deleteEmployeeSsn.length != 0){
							for(int i = 0; i < deleteEmployeeSsn.length; i++){
								String query = "DELETE FROM EMPLOYEE WHERE Ssn=" + deleteEmployeeSsn[i];
								conn.prepareStatement(query).executeUpdate();
							}
						}
					}
				}
						
				if(request.getParameter("updateChoice") != null){ // update 쿼리
					String[] updateEmployeeSsn = request.getParameterValues("updateCheckBox");
					if(updateEmployeeSsn != null && updateEmployeeSsn.length != 0){
						if(request.getParameter("updateChoice").equals("uuAddress") && request.getParameter("uuAddress") != null){
							for(int i = 0; i < updateEmployeeSsn.length; i++){
								String query = "UPDATE EMPLOYEE SET Address = ? WHERE Ssn = ?";
								pstmt = conn.prepareStatement(query);
								pstmt.setString(1, request.getParameter("uuAddress"));
								pstmt.setString(2, updateEmployeeSsn[i]);
								pstmt.executeUpdate();
							}
						}
						else if(request.getParameter("updateChoice").equals("uuSex") && request.getParameter("uuSex") != null){
							for(int i = 0; i < updateEmployeeSsn.length; i++){
								String query = "UPDATE EMPLOYEE SET Sex = ? WHERE Ssn = ?";
								pstmt = conn.prepareStatement(query);
								pstmt.setString(1, request.getParameter("uuSex"));
								pstmt.setString(2, updateEmployeeSsn[i]);
								pstmt.executeUpdate();
							}
						}
						else if(request.getParameter("updateChoice").equals("uuSalary") && request.getParameter("uuSalary") != null){
							for (int i = 0; i < updateEmployeeSsn.length; i++){
								String query = "UPDATE EMPLOYEE SET Salary = ? WHERE Ssn = ?";
								pstmt = conn.prepareStatement(query);
								pstmt.setString(1, request.getParameter("uuSalary"));
								pstmt.setString(2, updateEmployeeSsn[i]);
								pstmt.executeUpdate();
							}
						}
					}
				}
			} catch(SQLException e){
					System.out.println("에러: " + e);
			}
			%>
			<br><br>
			<h3>검색 결과</h3>
			<table class="table table-hover">
			<%
			//request.getParameter("choice") != null
			if(true){
				String query = "SELECT distinct a.Ssn, ";
				HashMap<String, String> map = new HashMap<String, String>();
				boolean flag = false; // a.Ssn만 있으면 표를 보여주지 않아야함
				if(request.getParameter("sName") != null){
					query += "IF(a.Minit IS NULL, concat(a.Fname, ' ', a.Lname), concat(a.Fname, ' ', a.Minit, ' ', a.Lname)), ";
					map.put("Name", "1");
					flag = true;
				}
				if(request.getParameter("sSsn") != null){
					query += "a.Ssn, ";
					map.put("Ssn", "1");
					flag = true;
				}
				if(request.getParameter("sBdate") != null){
					query += "a.Bdate, ";
					map.put("Bdate", "1");
					flag = true;
				}
				if(request.getParameter("sAddress") != null){
					query += "a.Address, ";
					map.put("Address", "1");
					flag = true;
				}
				if(request.getParameter("sSex") != null){
					query += "a.Sex, ";
					map.put("Sex", "1");
					flag = true;
				}
				if(request.getParameter("sSalary") != null){
					query += "a.Salary, ";
					map.put("Salary", "1");
					flag = true;
				}
				if(request.getParameter("sSupervisor") != null){
					query += "concat(b.Fname, ' ', b.Minit, ' ', b.Lname) as Supervisor, ";
					map.put("Supervisor", "1");
					flag = true;
				}
				if(request.getParameter("sDepartment") != null){
					query += "Dname, ";
					map.put("Dname", "1");
					flag = true;
				}
				if(request.getParameter("sRelaionship") != null){
					query += "Relationship, ";
					map.put("Relationship", "1");
					flag = true;
				}
				query = query.substring(0, query.length() - 2);
				query += " FROM employee a LEFT JOIN employee b ON a.super_ssn=b.ssn JOIN department ON a.Dno=Dnumber LEFT JOIN dependent ON a.Ssn=Essn";
				
				if(request.getParameter("search") != null && !request.getParameter("search").equals("sDefault")){
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
					else if(request.getParameter("ssAddress") != null && !request.getParameter("ssAddress").equals("")){
						query += " where a.Address like \'%" + request.getParameter("ssAddress") + "%\';";
					}
					else if(request.getParameter("ssRelationship") != null){
						query += " where ";
						if (request.getParameter("ssRelationship").equals("N")) query += " NOT ";
						
						query += " EXISTS (SELECT * From Dependent where a.Ssn=Essn ";
						if (!request.getParameter("ssRelationship").equals("N")){
							query += " and Relationship = ";
							if(request.getParameter("ssRelationship").equals("S")) query += "'Son'";
							else if(request.getParameter("ssRelationship").equals("D")) query += "'Daughter'";
							else if(request.getParameter("ssRelationship").equals("W")) query += "'Spouse'";
						}
						
						query += ")";
					}
				}
				query += ";";

				rs = stmt.executeQuery(query);
				
				// 검색 결과 테이블 구현
				if(flag){
					%>
					<th>선택</th>
					<%
				}
				if(map.containsKey("Name")){
					%> <th>NAME</th><%
				}
				if(map.containsKey("Ssn")){
					%> <th>SSN</th><%
				}
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
				if(map.containsKey("Relationship")){
					%> <th>RELATIONSHIP</th> <%
				}
				
				while(rs.next()){
					String checkBoxSsn = rs.getString(1);
					%><tr><%
					if(flag){
						%>
						<td> <input type="checkbox" name="updateCheckBox" value=<%=checkBoxSsn%>> </td>
						<%
					}
					int val = 2;
					if(map.containsKey("Name")){
						String Name = rs.getString(val);
						if(Name == null) Name = "";
						val += 1;
						%><td><%=Name%></td><%
					}
					if(map.containsKey("Ssn")){
						String Ssn = rs.getString(val);
						val += 1;
						%><td><%=Ssn%></td><%
					}
					if(map.containsKey("Bdate")){
						String Bdate = rs.getString(val);
						if(Bdate == null) Bdate = "";
						val += 1;
						%><td><%=Bdate%></td><%
					}
					if(map.containsKey("Address")){
						String Address = rs.getString(val);
						if(Address == null) Address = "";
						val += 1;
						%><td><%=Address%></td><%
					}
					if(map.containsKey("Sex")){
						String Sex = rs.getString(val);
						if(Sex == null) Sex = "";
						val += 1;
						%><td><%=Sex%></td><%
					}
					if(map.containsKey("Salary")){
						String Salary = rs.getString(val);
						if(Salary == null) Salary = "";
						val += 1;
						%><td><%=Salary%></td><%
					}
					if(map.containsKey("Supervisor")){
						String Supervisor = rs.getString(val);
						if(Supervisor == null) Supervisor = "";
						val += 1;
						%><td><%=Supervisor%></td><%
					}
					if(map.containsKey("Dname")){
						String Dname = rs.getString(val);
						val += 1;
						%><td><%=Dname%></td><%
					}
					if(map.containsKey("Relationship")){
						String Relationship = rs.getString(val);
						val += 1;
						%><td><%=Relationship%></td><%
					}
					%> </tr> <%
				}
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
				if(pstmt != null && !pstmt.isClosed()){
					pstmt.close();
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