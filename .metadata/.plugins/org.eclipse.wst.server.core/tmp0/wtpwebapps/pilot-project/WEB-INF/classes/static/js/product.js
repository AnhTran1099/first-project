$(document).ready(function() {
	
	// Show products list when opening page
	findAllProducts(1);

	$('.pagination').on('click', '.page-link', function() {
		var pageNumber = $(this).attr("data-index");
		var keyword = $('#keyword').val();
		if ( keyword != "" ) {
			searchProduct(pageNumber);
		} else {
			findAllProducts(pageNumber);
		}
	});	
	

	var listbrand = [];
		$('.brandClass').on('click',function() {
			listbrand=[];
			$('.checkbox').find('input[name="brand.logo"]:checked').each(
					function() {
						listbrand.push($(this).val());
					});
			console.log(listbrand);
		})
	var $productInfoForm = $('#productInfoForm');
	var $productInfoModal = $('#productInfoModal');

	$('#searchByPrice').on('click', function() {
		searchProduct(1, true,listbrand);
	});
	// Show add product modal
	$('#addProductInfoModal').on('click', function() {
		resetFormModal($productInfoForm);
		showModalWithCustomizedTitle($productInfoModal, "Add Product");
		$('#productImg img').attr('src', '/images/download.png');
		$('#productId').closest(".form-group").addClass("d-none");
		$("#productImage .required-mask").removeClass("d-none");
	});

	// Show update product modal
	$("#productInfoTable").on('click', '.edit-btn', function() {

		$("#productImage .required-mask").addClass("d-none");

		// Get product info by product ID
		$.ajax({
			url : "/product/api/find?id=" + $(this).data("id"),
			type : 'GET',
			dataType : 'json',
			contentType : 'application/json',
			success : function(responseData) {
				if (responseData.responseCode == 100) {
					var productInfo = responseData.data;
					resetFormModal($productInfoForm);
					showModalWithCustomizedTitle($productInfoModal, "Edit Product");

					$('#productId').val(productInfo.productId);
					$('#productName').val(productInfo.productName);
					$('#quantity').val(productInfo.quantity);
					$('#price').val(productInfo.price);
					$('#brandName').val(productInfo.brandEntity.brandName);
					$('#saleDate').val(productInfo.saleDate);
					var productImage = productInfo.image;
					if (productImage == null || productImage == "") {
						productImage = "/images/download.png";
					}
					$("#productImg img").attr("src", productImage);
					$("#image").val(productImage);
					$('#productId').closest(".form-group").removeClass("d-none");
				}
			}
		});
	});

	// Show delete product confirmation modal
	$("#productInfoTable").on('click', '.delete-btn', function() {
		$("#deletedProductName").text($(this).data("name"));
		$("#deleteSubmitBtn").attr("data-id", $(this).data("id"));
		$('#confirmDeleteModal').modal('show');
	});
 
	$("#deleteSubmitBtn").on('click' , function() {
		$.ajax({
			url : "/product/api/delete/" + $(this).attr("data-id"),
			type : 'DELETE',
			dataType : 'json',
			contentType : 'application/json',
			success : function(responseData) {
				$('#confirmDeleteModal').modal('hide');
				showNotification(responseData.responseCode == 100, responseData.responseMsg);
				findAllProducts(1);
			}
		});
	});

	// Submit add and update product
	$('#saveProductBtn').on('click', function (event) {

		event.preventDefault();
		var formData = new FormData($productInfoForm[0]);
		var productId = formData.get("productId");
		var isAddAction = productId == undefined || productId == "";
	
		$productInfoForm.validate({
			ignore: [],
			rules: {
				productName: {
					required: true,
					maxlength: 100
				},
				quantity: {
					required: true,
					number: true,
				},
				price: {
					required: true,
					number: true,
				},
				brandName: {
					required: true
				},
				saleDate: {
					required: true,
				},
				imageFiles: {
					required: isAddAction,
				}
			},
			messages: {
				productName: {
					required: "Please input Product Name",
					maxlength: "The Product Name must be less than 100 characters",
				},
				quantity: {
					required: "Please input Quantity",
					maxlength: "Quantity is number"
				},
				price: {
					required: "Please input Price",
					maxlength: "Price is number"
				},
				brandName: {
					required: "Brand Name is required",
				},
				saleDate: {
					required: "Please input Opening For Sale",
				},
				imageFiles: {
					required: "Please upload Product Image",
				}
			},
			errorElement: "div",
			errorClass: "error-message-invalid"
		});

		if ($productInfoForm.valid()) {

			// POST data to server-side by AJAX
			$.ajax({
				url: "/product/api/" + (isAddAction ? "add" : "update"),
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
						$productInfoModal.modal('hide');
						findAllProducts(1);
						showNotification(true, responseData.responseMsg);
					} else {
						showMsgOnField($productInfoForm.find("#productName"), responseData.responseMsg);
					}
				}
			});
		}
	});
});

function findAllProducts(pagerNumber) {
	$.ajax({
		url : "/product/api/findAll/" + pagerNumber,
		type : 'GET',
		dataType : 'json',
		contentType : 'application/json',
		success : function(responseData) {
			if (responseData.responseCode == 100) {
				renderProductsTable(responseData.data.productsList);
				renderPagination(responseData.data.paginationInfo);
			}
		}
	});
}

function renderProductsTable(productsList) {

	var rowHtml = "";
	$("#productInfoTable tbody").empty();
	$.each(productsList, function(key, value) {
		rowHtml = "<tr>"
				+		"<td>" + value.productId + "</td>"
				+		"<td>" + value.productName + "</td>"
				+		"<td>" + value.quantity + "</td>"
				+		"<td>" + value.price + "</td>"
				+		"<td>" + value.brandEntity.brandName + "</td>"
				+		"<td>" + value.saleDate + "</td>"
				+		"<td class='text-center'><a href='" + value.image + "' data-toggle='lightbox' data-max-width='1000'><img class='img-fluid' src='" + value.image + "'></td>"
				+		"<td class='action-btns'>"
				+			"<a class='edit-btn' data-id='" + value.productId + "'><i class='fas fa-edit'></i></a> | <a class='delete-btn' data-name='" + value.productName + "' data-id='" + value.productId + "'><i class='fas fa-trash-alt'></i></a>"
				+		"</td>"
				+	"</tr>";
		$("#productInfoTable tbody").append(rowHtml);
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

function searchProduct(pageNumber, isClickedSearchBtn,listbrand) {
	var searchConditions = {
			keyword: $("#keyword").val(),
			priceFrom:$("#priceFrom").val(),
			priceTo:$("#priceTo").val(),
			list : listbrand
			
		}
		$.ajax({
			url: '/product/api/searchProduct/' + pageNumber,
			type: 'POST',
			dataType: 'json',
			contentType: 'application/json',
			success: function (responseData) {
				if(responseData.responseCode == 100) {
					renderProductsTable(responseData.data.productsList);
					renderPagination(responseData.data.paginationInfo);
//					if (isClickedSearchBtn) {
//						showNotification(true, responseData.responseMsg);
//					}					
					if (responseData.data.paginationInfo.pageNumberList.length <2) {
						$('.pagination').addClass("d-none");
					}else {
						$('.pagination').removeClass("d-none")
					}
					showMessageSearch(responseData.responseMsg);
				}
			},
			data: JSON.stringify(searchConditions)
		});
}

function showMessageSearch(responseMsg) {
	$("#showMessage p").empty();
		$("#showMessage p").append(responseMsg);
}
