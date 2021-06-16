<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<title>Add Brand</title>
<jsp:include page="../common/head.jsp" />
<link rel="stylesheet" href="<c:url value='/css/brand.css'/>">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<div class="sub-header">
			<div class="float-left sub-title">Add Brand</div>
		</div>
		<div class="w-50 mx-auto">
			<c:if test="${not empty errorMessage}">
				<div class="message-area">
					<div class="error-message-invalid">${errorMessage}</div>
				</div>
			</c:if>
			<form id="brandInfoForm" role="form" enctype="multipart/form-data" action="/brand/add" method="POST">
				<div class="modal-body">
					<div class="form-group">
						<label for="brandName">Brand Name</label>
						<input type="text" class="form-control" id="brandName" name="brandName" placeholder="Brand Name">
					</div>
					<div class="form-group">
						<label for="logo">Logo</label>
						<div class="preview-image-upload" id="logoImg">
							<img src="<c:url value='/images/image-demo.png'/>" alt="image">
						</div>
						<input type="file" class="form-control upload-image" name="logoFiles" accept="image/*" />
						<input type="hidden" class="old-img" id="logo" name="logo">
					</div>
					<div class="form-group">
						<label for="description">Description</label>
						<textarea name="description" id="description" cols="30" rows="3" class="form-control" placeholder="Description"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
					<button type="submit" class="btn btn-primary" id="saveBtn">Save</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>