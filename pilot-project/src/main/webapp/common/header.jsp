<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<header>
	<div class="container">
	<nav class="navbar navbar-expand-md navbar-light bg-light">
		<a href="#" class="navbar-brand">
			<img class="imageLogo" src="<c:url value='/images/icons8-spring-logo-48.png'/>" width="40" height="40" alt="image"><label class="label-header">PILOT PROJECT</label>
		</a>
		<button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
		
		<div class="collapse navbar-collapse" id="navbarCollapse">
       		<div class="navbar-nav">
			<a class="nav-item nav-link" href="/product">Product</a>
			<a class="nav-item nav-link active" href="/brand">Brand</a>
		</div>
		<div class="navbar-nav ml-auto">
			<a id="logout" class="nav-item nav-link" href="/logout" >Logout</a>
		</div>
		</div>
	</nav>
	</div>
</header>