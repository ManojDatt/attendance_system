#= require active_admin/base
#= require cable
$(document).on('ready', function() {
  	
  $('#export_csv').click(function(e) {

    e.stopPropagation();  // prevent Rails UJS click event
    e.preventDefault();
    
    ActiveAdmin.modal_dialog("ATTENDANCE EXPORT", {"EMAIL": 'text', "FROMDATE": 'datepicker', "TODATE":'datepicker'},  function(inputs) {
    	$("#dialog_confirm").submit();
    });
    setInterval(function(){
    	 $("#dialog_confirm").attr("action", "/admin/attendances/export_attenadance");
    	}, 1000);
   
  });

})


