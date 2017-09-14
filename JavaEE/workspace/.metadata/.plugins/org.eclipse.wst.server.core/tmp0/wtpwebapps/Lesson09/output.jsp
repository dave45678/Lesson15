<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>       
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List of Customers</title>
</head>
<body>
<h1>List of Customers</h1>

  <table>
  <tr><th>Name</th><th>Address</th><th>City</th><th>State</th><th>ZIP</th></tr>
  <c:forEach var="customer" items="${customers}">
        <tr><td><c:out value="${customer.name}"/></td>
        <td><c:out value="${customer.address}"/></td>
        <td><c:out value="${customer.city}"/></td>
        <td><c:out value="${customer.state}"/></td>
        <td><c:out value="${customer.zipcode}"/></td>
        </tr>
    </c:forEach>
    </table>
</body>
</html>