App.dsr = App.cable.subscriptions.create("DsrChannel", {
  connected: function() {
   
  },
  disconnected: function() {
    
  },
  received: function(data) {
      console.log(data);
      var notify;
            console.log(Notification.permission);
            if(Notification.permission === 'default'){
              alert('Please allow notification');
            }
            else{
              notify = new Notification("New notification",
              {
                title: "Arka Softwares",
                body: data['message'],
                icon:"/assets/logo.png",
                tag:"punching",
                dir: 'ltr',
                // sound: '/assets/sounds/sound6.ogg'
              });
              notify.onclick = function(){
                window.location.href = "http://stackoverflow.com";
              }
            }
      return data;
    
  },
  
});