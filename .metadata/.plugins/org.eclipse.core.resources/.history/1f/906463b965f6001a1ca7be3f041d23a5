$(document).ready(function() {
	
	// Add "active" class for link in Header
	var pathName = window.location.pathname;
	$("header .nav-link").each(function() {
		$this = $(this);
		if (pathName.includes($this.attr("href"))) {
			$this.parent().addClass("active");
		}
	});

	// Upload image preview
	$('input.upload-image').on('change', function() {
		var url = window.URL || window.webkitURL;
		var file = this.files[0];
		var fileUrl;
		var $parent = $(this).parent();
		if (file) {
			fileUrl = url.createObjectURL(file);
			$parent.find(".error-message-invalid").removeClass("error-message-invalid");
		} else {
			var oldImagePath = $parent.find(".old-img").val();
			if (oldImagePath) {
				fileUrl = oldImagePath;
			} else {
				fileUrl = "/images/image-demo.png";
			}
		}
		$parent.find('.preview-image-upload img').attr('src', fileUrl);
	});

	//Open image in full size
	$(document).on('click', '[data-toggle="lightbox"]', function (event) {
		event.preventDefault();
		$(this).ekkoLightbox({
			alwaysShowClose: true
		});
	});
});

function showModalWithCustomizedTitle($selectedModal, title) {
	$selectedModal.find(".modal-title").text(title);
	$selectedModal.modal('show');
}

function resetFormModal($formElement) {

	$formElement[0].reset();
	$formElement.find("input[type*='file']").val("");
	$formElement.validate().destroy();
	$formElement.find(".error-message-invalid").remove();
	$formElement.find("img").attr('src', '');
}

function showNotification(isSuccess, message) {

	if (isSuccess) {
		$.notify({
			icon: 'glyphicon glyphicon-ok',
			message: message
		}, {
			type: 'info',
			delay: 3000
		});
	} else {
		$.notify({
			icon: 'glyphicon glyphicon-warning-sign',
			message: message
		}, {
			type: 'danger',
			delay: 6000
		});
	}
}

function showMsgOnForm($element, message, isSuccessMsg) {

	var className = isSuccessMsg ? "alert-info" : "error-message-invalid";
	$element.find(".form-msg").remove();
	$element.prepend("<div class='" + className + " form-msg'>" + message + "</div>");
}

function showMsgOnField($element, message, isSuccessMsg) {

	var className = isSuccessMsg ? "alert-info" : "error-message-invalid";
	$element.find(".form-msg").remove();
	$element.parent().append("<div class='" + className + " form-msg'>" + message + "</div>");
}