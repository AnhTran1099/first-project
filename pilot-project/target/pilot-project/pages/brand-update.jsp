<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<title>Update Brand</title>
<jsp:include page="../common/head.jsp" />
<link rel="stylesheet" href="<c:url value='/css/brand.css'/>">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<div class="sub-header">
			<div class="float-left sub-title">Update Brand</div>
		</div>
		<div class="w-50 mx-auto">
			<c:if test="${not empty errorMessage}">
				<div class="message-area">
					<div class="error-message-invalid">${errorMessage}</div>
				</div>
			</c:if>
			<c:choose>
				<c:when test="${not empty brandEntity}">
					<form id="brandInfoForm" role="form" action="/brand/update" method="POST" enctype="multipart/form-data">
						<div class="modal-body">
							<div class="form-group">
								<label>Brand ID</label>
								<input type="text" class="form-control" name="brandId" id="brandId" placeholder="Brand ID" value="${brandEntity.brandId}" readonly>
							</div>
							<div class="form-group">
								<label for="brandName">Brand Name</label>
								<input type="text" class="form-control" id="brandName" name="brandName" placeholder="Brand Name" value="${brandEntity.brandName}">
							</div>
							<div class="form-group">
								<label for="logo">Logo</label>
								<div class="preview-image-upload" id="logoImg">
									<img src="<c:url value='/${brandEntity.logo}'/>" alt="${brandEntity.brandName}">
								</div>
								<input type="file" class="form-control upload-image" name="logoFiles" accept="image/*" />
								<input type="hidden" class="old-img" id="logo" name="logo" value="${brandEntity.logo}">
							</div>
							<div class="form-group">
								<label for="description">Description</label>
								<textarea name="description" id="description" cols="30" rows="3" class="form-control" placeholder="Description">${brandEntity.description}</textarea>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-primary" id="saveBtn">Save</button>
						</div>
					</form>
				</c:when>
				<c:otherwise>
					<h3>Brand Not Found</h3>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>