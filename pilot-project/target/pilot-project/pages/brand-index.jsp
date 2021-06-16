<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<title>Brand Management</title>
<jsp:include page="../common/head.jsp" />
<link rel="stylesheet" href="<c:url value='/css/brand.css'/>">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<h3 class="text-center">Brand Management</h3>
		<hr>
		<div class="add-brand form-group">
				<button type="submit" class="btn  add-btn float-right"
					id="addBrandInfoModal"><i class="fas fa-plus-square"></i> Add Brand</button>
			</div>
		<div class="search-brand form-group">
				<div class="search-brand__name">
					<input type="text" class="form-control search-brand" placeholder="Search by brand name..." id="keyword">
				</div>
				<button type="submit" id="btnSearch" class="btn btn-success search-btn">Search</button>
				<button type="submit" class="reset-page btn btn-secondary" id="resetPage">Reset</button>
		</div>
		<div id="showMessage">
			<span class="messageSearch"></span>
		</div>
		<table class="table table-bordered" id="brandInfoTable">
			<thead>
				<tr class="text-center">
					<th scope="col">ID</th>
					<th scope="col">Name</th>
					<th scope="col">Logo</th>
					<th scope="col">Description</th>
					<th scope="col">Actions</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div class="d-flex justify-content-center">
			<ul class="pagination">
			</ul>
		</div>
	</div>
	<!-- Modal Add and Edit Brand -->
	<div class="modal fade" id="brandInfoModal">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<form id="brandInfoForm" role="form" enctype="multipart/form-data">
					<div class="modal-header">
						<h5 class="modal-title">Add Brand</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group d-none">
							<label>Brand ID</label> <input type="text" class="form-control"
								name="brandId" id="brandId" placeholder="Brand ID" readonly>
						</div>
						<div class="form-group">
							<label for="brandName">Brand Name <span
								class="required-mask">(*)</span></label> <input type="text"
								class="form-control" id="brandName" name="brandName"
								placeholder="Brand Name">
						</div>
						<div class="form-group" id="brandLogo">
							<label for="logo">Logo <span class="required-mask">(*)</span></label>
							<div class="preview-image-upload" id="logoImg">
								<img src="<c:url value='/images/download.png'/>" alt="image">
							</div>
							<input type="file" class="form-control upload-image"
								name="logoFiles" accept="image/*" /> 
								<input type="hidden"
								class="old-img" id="logo" name="logo">
						</div>
						<div class="form-group">
							<label for="description">Description</label>
							<textarea name="description" id="description" cols="30" rows="3"
								class="form-control" placeholder="Description"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-primary" id="saveBrandBtn">Save</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Modal Confirm Deleting Brand -->
	<div class="modal fade" id="confirmDeleteModal">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Delete Brand</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>
						Do you want to delete <b id="deletedBrandName"></b>?
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary" id="deleteSubmitBtn">Save</button>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
	<script src="<c:url value='/js/brand.js'/>"></script>
</body>
</html>