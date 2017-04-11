App.leave = App.cable.subscriptions.create("LeaveChannel", {
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
              notify = new Notification(("New notification ").concat(data['user']),
              {
                title: "Arka Softwares",
                body: data['message'],
                icon:"https://yt3.ggpht.com/-RgjHlrXsIjU/AAAAAAAAAAI/AAAAAAAAAAA/1QbP-sHSI1M/s88-c-k-no-mo-rj-c0xffffff/photo.jpg",
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