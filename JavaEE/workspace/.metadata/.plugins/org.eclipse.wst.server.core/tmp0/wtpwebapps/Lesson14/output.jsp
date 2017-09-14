<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Lesson 14 - Using Database Relationships - one to many</h1>
<h3>One director directs many movies</h3>

<h2>List of directors and movies</h2>
<c:forEach var="director" items="${directors}">
    <h3><c:out value="${director.name}"></c:out></h3>   

    <c:forEach var="movie" items="${director.movies}">
    <li><c:out value="${movie.title}"></c:out></li>
    </c:forEach>
    
    
</c:forEach>
</body>
</html>