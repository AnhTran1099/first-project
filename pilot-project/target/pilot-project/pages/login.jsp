<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<title>Pilot Project</title>
<link rel="stylesheet" href="<c:url value='/plugins/bootstrap/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/plugins/ekko-lightbox/ekko-lightbox.min.css'/>">
<link rel="stylesheet" href="<c:url value='/plugins/font-awesome/css/all.min.css'/>">
<link rel="stylesheet" href="<c:url value='/css/base.css'/>">
<link rel="stylesheet" href="<c:url value='/css/login.css'/>">
<link rel="icon" href="<c:url value='/images/icons8-spring-logo-48.png'/>" type="image/gif" sizes="16x16">
</head>
<body>
    <div id="login">
        <h3 class="text-center text-white pt-5">PILOT PROJECT</h3>
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        <form id="login-form" class="form" action="/loginAction" method="POST">
                            <h3 class="text-center text-info">Login</h3>
                            <div class="form-group">
                                <label for="username" class="text-info">Username:</label><br>
                                <input name="username" class="form-control" placeholder="Enter Username" type="text" required="required">
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-info">Password:</label><br>
                                <input class="form-control" name="password" placeholder="Enter Password" type="password" required="required">
                            </div>
                            <div class="form-group">                   
                                <input type="submit" name="submit" class="btn btn-info btn-md" value="Sign in">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script src="<c:url value='/plugins/jquery/jquery-3.5.1.min.js'/>"></script>
<script src="<c:url value='/plugins/jquery/jquery.validate.min.js'/>"></script>
<script src="<c:url value='/plugins/bootstrap/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/plugins/bootstrap/js/bootstrap-notify.min.js'/>"></script>
</body>
</html>