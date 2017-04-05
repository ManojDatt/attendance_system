//=  require 'jquery'
//=  require 'jquery_ujs'
//=  require 'jquery.remotipart'
//=  require 'jquery-ui/effect'
//=  require 'jquery-ui/sortable'
//=  require 'jquery-ui/autocomplete'
//=  require 'rails_admin/moment-with-locales'
//=  require 'rails_admin/bootstrap-datetimepicker'
//=  require 'rails_admin/jquery.colorpicker'
//=  require 'rails_admin/ra.filter-box'
//=  require 'rails_admin/ra.filtering-multiselect'
//=  require 'rails_admin/ra.filtering-select'
//=  require 'rails_admin/ra.remote-form'
//=  require 'rails_admin/jquery.pjax'
//=  require 'jquery_nested_form'
//=  require 'rails_admin/ra.nested-form-hooks'
//=  require 'rails_admin/ra.i18n'
//=  require 'rails_admin/bootstrap/bootstrap'
//=  require 'rails_admin/ra.widgets'
//=  require 'rails_admin/ui'
//=  require 'rails_admin/custom/ui'
//=  require 'cable'
//=  require 'rails_admin/channels/dsr'


$(document).ready(function(){
	$(".dropdown-header").text("Admin Resources");

// $("#bulk_ids_").addEventListener('click', function(e){
// 	e.preventDefault();
	if(! window.Notification){
		alert('Sorry notification not support');
	}
	else{
		Notification.requestPermission(function(p){
			if(p==='denied'){
				alert('denied');
			}
			else{
				// alert('allowed');
			}
		});
	}
// });
// setTimeout(function(){
// var notify;
// 	console.log(Notification.permission);
// 	if(Notification.permission === 'default'){
// 		alert('Please allow notification');
// 	}
// 	else{
// 		notify = new Notification("New notification from manoj",
// 		{
// 			body:"how are you today !",
// 			icon:"https://yt3.ggpht.com/-RgjHlrXsIjU/AAAAAAAAAAI/AAAAAAAAAAA/1QbP-sHSI1M/s88-c-k-no-mo-rj-c0xffffff/photo.jpg",
// 			tag:"1213"// uniq number for message
// 		});
// 		notify.onclick = function(){
// 			window.location.href = "http://stackoverflow.com";
// 		}
// 	}
// },3000);
	


})	



