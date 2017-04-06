$(document).ready(function(){

	$("#todo_form").validate({
		rules: {
            "todo[task_project]": {
                required: true,
               
            },
            "todo[task_name][]": {
                required: true,
                minlength: 5
            },

             "todo[task_time][]": {
                required: true,
                minlength: 2
            }
        },
        messages:{
        	"todo[task_project]": {
                required: "Please select project",
               
            },
            "todo[task_name][]": {
                required: "Please enter task name",
                minlength: "Please enter atleast 5 characters"
            },

             "todo[task_time][]": {
                required: "Please enter task duration",
                minlength: "Please enter minimum 2 characters"
            }
        },
        submitHandler: function(form) {
            form.submit();
        }

	});
$("#rnd_form").validate({
        rules: {
            
            "todo[task_name][]": {
                required: true,
                minlength: 5
            },

             "todo[task_time][]": {
                required: true,
                minlength: 2
            }
        },
        messages:{
          
            "todo[task_name][]": {
                required: "Please enter topic name",
                minlength: "Please enter atleast 5 characters"
            },

             "todo[task_time][]": {
                required: "Please enter duration",
                minlength: "Please enter minimum 2 characters"
            }
        },
        submitHandler: function(form) {
            form.submit();
        }

    });




});