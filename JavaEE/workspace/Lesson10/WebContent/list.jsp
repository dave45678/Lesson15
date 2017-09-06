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

<a href="/add">Add a Course</a><br />
<table>
    <tr>
        <th>Title</th>
        <th>Instructor</th>
        <th>Credits</th>
        <td>Actions</td>
    </tr>
    <c:forEach var="course" items="${courses}">
    <tr>
        <td> <c:out value="${course.title}"></c:out></td>
        <td> <c:out value="${course.instructor}"></c:out></td>
        <td> <c:out value="${course.credit}"></c:out></td>
        <td>
            <a href="/update?id=<c:out value="${course.id}"></c:out>">Update</a> -
            <a href="/detail?id=<c:out value="${course.id}"></c:out>">Details</a> -
            <a href="/delete?id=<c:out value="${course.id}"></c:out>">Delete</a>
        </td>
    </tr>
    </c:forEach>
</table>

</body>
</html>