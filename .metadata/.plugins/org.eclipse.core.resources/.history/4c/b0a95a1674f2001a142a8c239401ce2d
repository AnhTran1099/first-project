$(document).ready(function() {

	// Show brands list when opening page
	findAllBrands(1);
	
	// Search
	$('#btnSearch').on('click', function() {
		var keyword = $('#keyword').val();
		searchBrand(keyword,1);
	})
	
	$('.pagination').on('click', '.page-link', function() {
		var pageNumber = $(this).attr("data-index");
		var keyword = $('#keyword').val();
		if(keyword != ""){
			searchBrand(keyword,pageNumber);
		}else{
			findAllBrands(pageNumber);
		}
	})

	var $brandInfoForm = $('#brandInfoForm');
	var $brandInfoModal = $('#brandInfoModal');

	// Show add brand modal
	$('#addBrandInfoModal').on('click', function() {
		resetFormModal($brandInfoForm);
		showModalWithCustomizedTitle($brandInfoModal, "Add Brand");
		$('#logoImg img').attr('src', '/images/image-demo.png');
		$('#brandId').closest(".form-group").addClass("d-none");
		$("#brandLogo .required-mask").removeClass("d-none");
	});

	// Show update brand modal
	$("#brandInfoTable").on('click', '.edit-btn', function() {

		$("#brandLogo .required-mask").addClass("d-none");

		// Get brand info by brand ID
		$.ajax({
			url : "/brand/api/find?id=" + $(this).data("id"),
			type : 'GET',
			dataType : 'json',
			contentType : 'application/json',
			success : function(responseData) {
				if (responseData.responseCode == 100) {
					var brandInfo = responseData.data;
					resetFormModal($brandInfoForm);
					showModalWithCustomizedTitle($brandInfoModal, "Edit Brand");

					$('#brandId').val(brandInfo.brandId);
					$('#brandName').val(brandInfo.brandName);
					$('#description').val(brandInfo.description);

					var brandLogo = brandInfo.logo;
					if (brandLogo == null || brandLogo == "") {
						brandLogo = "/images/image-demo.png";
					}
					$("#logoImg img").attr("src", brandLogo);
					$("#logo").val(brandLogo);
					$('#brandId').closest(".form-group").removeClass("d-none");
				}
			}
		});
	});

	// Show delete brand confirmation modal
	$("#brandInfoTable").on('click', '.delete-btn', function() {
		$("#deletedBrandName").text($(this).data("name"));
		$("#deleteSubmitBtn").attr("data-id", $(this).data("id"));
		$('#confirmDeleteModal').modal('show');
	});

	// Submit delete brand
	$("#deleteSubmitBtn").on('click' , function() {
		$.ajax({
			url : "/brand/api/delete/" + $(this).attr("data-id"),
			type : 'DELETE',
			dataType : 'json',
			contentType : 'application/json',
			success : function(responseData) {
				$('#confirmDeleteModal').modal('hide');
				showNotification(responseData.responseCode == 100, responseData.responseMsg);
				findAllBrands(1);
			}
		});
	});
	

	// Submit add and update brand
	$('#saveBrandBtn').on('click', function (event) {

		event.preventDefault();
		var formData = new FormData($brandInfoForm[0]);
		var brandId = formData.get("brandId");
		var isAddAction = brandId == undefined || brandId == "";
	
		$brandInfoForm.validate({
			ignore: [],
			rules: {
				brandName: {
					required: true,
					maxlength: 100
				},
				logoFiles: {
					required: isAddAction,
				}
			},
			messages: {
				brandName: {
					required: "Please input Brand Name",
					maxlength: "The Brand Name must be less than 100 characters",
				},
				logoFiles: {
					required: "Please upload Brand Logo",
				}
			},
			errorElement: "div",
			errorClass: "error-message-invalid"
		});

		if ($brandInfoForm.valid()) {

			// POST data to server-side by AJAX
			$.ajax({
				url: "/brand/api/" + (isAddAction ? "add" : "update"),
				type: 'POST',
				enctype: 'multipart/form-data',
				processData: false,
				contentType: false,
				cache: false,
				timeout: 10000,
				data: formData,
				success: function(responseData) {

					// Hide modal and show success message when save successfully
					// Else show error message in modal
					if (responseData.responseCode == 100) {
						$brandInfoModal.modal('hide');
						findAllBrands(1);
						showNotification(true, responseData.responseMsg);
					} else {
						showMsgOnField($brandInfoForm.find("#brandName"), responseData.responseMsg);
					}
				}
			});
		}
	});
});

function searchBrand(keyword,pageNumber) {
	$.ajax({
		url : "/brand/api/search/" + keyword +"/" + pageNumber,
		type : 'GET',
		dataType : 'json',
		contentType : 'application/json',
		success : function(responseData) {
			if (responseData.responseCode == 100) {
				renderBrandsTable(responseData.data.brandsList);
				console.log(responseData.data.brandsList);
				renderPagination(responseData.data.paginationInfo);
				if(pageNumber==1){
					showNotification(true, responseData.responseMsg);
				}
			}
		}
	})
}
 
function findAllBrands(pagerNumber) {
	$.ajax({
		url : "/brand/api/findAll/" + pagerNumber,
		type : 'GET',
		dataType : 'json',
		contentType : 'application/json',
		success : function(responseData) {
			if (responseData.responseCode == 100) {
				renderBrandsTable(responseData.data.brandsList);
				renderPagination(responseData.data.paginationInfo);
			}
		}
	});
}

function renderBrandsTable(brandsList) {

	var rowHtml = "";
	$("#brandInfoTable tbody").empty();
	$.each(brandsList, function(key, value) {
		rowHtml = "<tr>"
				+		"<td>" + value.brandId + "</td>"
				+		"<td>" + value.brandName + "</td>"
				+		"<td class='text-center'><a href='" + value.logo + "' data-toggle='lightbox' data-max-width='1000'><img class='img-fluid' src='" + value.logo + "'></td>"
				+		"<td>" + value.description + "</td>"
				+		"<td class='action-btns'>"
				+			"<a class='edit-btn' data-id='" + value.brandId + "'><i class='fas fa-edit'></i></a> | <a class='delete-btn' data-name='" + value.brandName + "' data-id='" + value.brandId + "'><i class='fas fa-trash-alt'></i></a>"
				+		"</td>"
				+	"</tr>";
		$("#brandInfoTable tbody").append(rowHtml);
	});
}

function renderPagination(paginationInfo) {

	var paginationInnerHtml = "";
	if (paginationInfo.pageNumberList.length > 0) {
		$("ul.pagination").empty();
		paginationInnerHtml += '<li class="page-item"><a class="page-link ' + (paginationInfo.firstPage == 0 ? 'disabled' : '') + '" href="javascript:void(0)" data-index="'+ paginationInfo.firstPage + '">First</a></li>'
		paginationInnerHtml += '<li class="page-item"><a class="page-link ' + (paginationInfo.previousPage == 0 ? 'disabled' : '') + '" href="javascript:void(0)" data-index="'+ paginationInfo.previousPage + '"> < </a></li>'
		$.each(paginationInfo.pageNumberList, function(key, value) {
			paginationInnerHtml += '<li class="page-item"><a class="page-link '+ (value == paginationInfo.currentPage ? 'active' : '') +'" href="javascript:void(0)" data-index="' + value +'">' + value + '</a></li>';
		});
		paginationInnerHtml += '<li class="page-item"><a class="page-link ' + (paginationInfo.nextPage == 0 ? 'disabled' : '') + '" href="javascript:void(0)" data-index="'+ paginationInfo.nextPage + '"> > </a></li>'
		paginationInnerHtml += '<li class="page-item"><a class="page-link ' + (paginationInfo.lastPage == 0 ? 'disabled' : '') + '" href="javascript:void(0)" data-index="'+ paginationInfo.lastPage + '">Last</a></li>'
		$("ul.pagination").append(paginationInnerHtml);
	}
}