# require 'screenshot'
# Screenshot.capture('screenshot1.png')

require 'tray_application'; 
require 'screenshot';
app = TrayApplication.new("Deskshot")
app.icon_filename = 'screenshot.png'
app.item('Take Screenshot') {Screenshot.capture}
app.item('Exit') {java.lang.System::exit(0)}
app.run