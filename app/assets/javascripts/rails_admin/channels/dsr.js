App.dsr = App.cable.subscriptions.create("DsrChannel", {
  connected: function() {
    return setTimeout((function(_this) {
      console.log("connected");
    })(this), 2000);
  },
  disconnected: function() {
    return setTimeout((function(_this) {
      console.log("disconnected");
    })(this), 2000);
  },
  received: function(data) {
      console.log(data);
      return data;
    
  },
  
  notify: function(data) {
    console.log(data);
            var notify;
            console.log(Notification.permission);
            if(Notification.permission === 'default'){
              alert('Please allow notification');
            }
            else{
              notify = new Notification("New notification from manoj",
              {
                body: data,
                icon:"https://yt3.ggpht.com/-RgjHlrXsIjU/AAAAAAAAAAI/AAAAAAAAAAA/1QbP-sHSI1M/s88-c-k-no-mo-rj-c0xffffff/photo.jpg",
                tag:"1213"// uniq number for message
              });
              notify.onclick = function(){
                window.location.href = "http://stackoverflow.com";
              }
            }
     return data;
    }
});