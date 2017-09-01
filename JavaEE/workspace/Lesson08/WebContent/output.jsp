<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Customer List</h1>
<table class="table table-bordered">
    <thead>
        <tr><th>User</th><th>Post</th><th>Date</th></tr>
    </thead>
    <tbody>
    <c:forEach var="customer" items="${customers}">
        <tr><td><c:out value="${customer.name}"/></td>
        <td><c:out value="${customer.address}"/></td>
				<td><c:out value="${customer.city}"/></td>
				<td><c:out value="${customer.state}"/></td>
				<td><c:out value="${customer.zip}"/></td>
        </tr>
    </c:forEach>
    </tbody>
    </table>
</body>
</html>