<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>Lesson 6</title>
</head>
<body>
<h1>You entered the following values:</h1>
<p>Email: <c:out value="${email}"></c:out></p>
<p>Password: <c:out value="${password}"></c:out></p>
</body>
</html>