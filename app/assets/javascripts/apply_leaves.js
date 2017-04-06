$(document).ready(function(){

	$("#leave_application_form").validate({
		rules: {            
             "apply_leave[start_date]": {
                required: true
            },

             "apply_leave[end_date]": {
                required: true
            },

             "apply_leave[reason]": {
                required: true,
                minlength: 10,
                maxlength:50
            }
        },
        messages:{

             "apply_leave[start_date]": {
                 required: "Please select date"
            },

             "apply_leave[end_date]": {
                 required: "Please select date"
            },

             "apply_leave[reason]": {
                required: "Please enter reason",
                minlength: "Please enter minimum 10 characters",
                maxlength:"Please enter no more than 50 characters"
            }
        },
        submitHandler: function(form) {
            form.submit();
        }

	});

});