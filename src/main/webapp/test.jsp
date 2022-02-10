<%@page import="java.sql.DriverManager" %> //JSP에서 자바 코드를 사용하기 위해 <% %> 사용
<%@page import="java.sql.ResultSet" %> //필요한 라이브러리 import
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신상명세서 출력 현황</title>
</head>
<body>
<center><h2>신상명세서 출력 현황</h2></center>
<table width="800" border="1" align="center">
<tr>
<th>사 번</th>
<th>학 과</th>
<th>국 어</th>
<th>영 어</th>
<th>전 산</th>
</tr>
<%
try{
	Class.forName("oracle.jdbc.driver.OracleDriver"); //driver
	conn = DriverManager.getConnection("jdbc:oracle:thin:@121.126.160.69:1521:ysytest", "test", "tiger"); //username, password는 개인 Oracle 계정의 것으로 하면 됨
	String sql = "select * from sinsang"; //DB를 조회할 select문
	pstmt = conn.prepareStatement(sql); //sql문으로 conn
	rs = pstmt.executeQuery(); //pstmt 실행 후 결과를 rs에 할당
	
	while(rs.next()){ //조회되는 로우(행) 반복
		out.print("<tr>");
		out.print("<td>" + rs.getString("sabun") + "</td>"); //DB에서 sabun 컬럼에 해당하는 레코드 값을 불러옴
		out.print("<td>" + rs.getString("hakkwa") + "</td>");
		out.print("<td>" + rs.getInt("kor") + "</td>");
		out.print("<td>" + rs.getInt("eng") + "</td>");
		out.print("<td>" + rs.getInt("com") + "</td>");
		out.print("</tr>");
	}
	
	rs.close();
	pstmt.close();
	conn.close();
}catch(Exception e){
	e.printStackTrace();
}finally{
	try{
		if(rs!=null) rs.close();
		if(pstmt!=null) pstmt.close();
		if(conn!=null) conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>
</table>
</body>
</html>