<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a course</title>
</head>
<body>
<form action="addcourse" method="post">
      <input type="hidden" value="${id}" />
    Title :<input name="title" type="text" value="${title}" /><br />
    Instructor :<input name="instructor" type="text" value="${instructor}" /><br />
    Description :<textarea name="description" rows="3">${description}</textarea><br />
    Credits :<input name="credit" type="text" value="${credit}" /><br />
             <input type="submit" value="Submit" />
</form>
</body>
</html>