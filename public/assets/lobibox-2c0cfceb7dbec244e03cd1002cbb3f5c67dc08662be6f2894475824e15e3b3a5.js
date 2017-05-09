var Lobibox=Lobibox||{};!function(){function o(o,t){this.$input=null,this.$type="prompt",this.$promptType=o,t=$.extend({},Lobibox.prompt.DEFAULT_OPTIONS,t),this.$options=this._processInput(t),this._init(),this.debug(this)}function t(o){this.$type="confirm",this.$options=this._processInput(o),this._init(),this.debug(this)}function i(o,t){this.$type=o,this.$options=this._processInput(t),this._init(),this.debug(this)}function n(o){this.$type="progress",this.$progressBarElement=null,this.$options=this._processInput(o),this.$progress=0,this._init(),this.debug(this)}function s(o,t){this.$type=o,this.$options=this._processInput(t),this._init(),this.debug(this)}Lobibox.counter=0,Lobibox.prompt=function(t,i){return new o(t,i)},Lobibox.confirm=function(o){return new t(o)},Lobibox.progress=function(o){return new n(o)},Lobibox.error={},Lobibox.success={},Lobibox.warning={},Lobibox.info={},Lobibox.alert=function(o,t){if(["success","error","warning","info"].indexOf(o)>-1)return new i(o,t)},Lobibox.window=function(o){return new s("window",o)};var e={$type:null,$el:null,$options:null,debug:function(){this.$options.debug&&window.console.debug.apply(window.console,arguments)},_processInput:function(o){if($.isArray(o.buttons)){for(var t={},i=0;i<o.buttons.length;i++)t[o.buttons[i]]=Lobibox.base.OPTIONS.buttons[o.buttons[i]];o.buttons=t}o.customBtnClass=o.customBtnClass?o.customBtnClass:Lobibox.base.DEFAULTS.customBtnClass;for(var i in o.buttons)if(o.buttons.hasOwnProperty(i)){var n=o.buttons[i];n=$.extend({},Lobibox.base.OPTIONS.buttons[i],n),n["class"]||(n["class"]=o.customBtnClass),o.buttons[i]=n}return o=$.extend({},Lobibox.base.DEFAULTS,o),o.showClass===undefined&&(o.showClass=Lobibox.base.OPTIONS.showClass),o.hideClass===undefined&&(o.hideClass=Lobibox.base.OPTIONS.hideClass),o.baseClass===undefined&&(o.baseClass=Lobibox.base.OPTIONS.baseClass),o.delayToRemove===undefined&&(o.delayToRemove=Lobibox.base.OPTIONS.delayToRemove),o.iconClass||(o.iconClass=Lobibox.base.OPTIONS.icons[o.iconSource][this.$type]),o},_init:function(){var o=this;o._createMarkup(),o.setTitle(o.$options.title),o.$options.draggable&&!o._isMobileScreen()&&(o.$el.addClass("draggable"),o._enableDrag()),o.$options.closeButton&&o._addCloseButton(),o.$options.closeOnEsc&&$(document).on("keyup.lobibox",function(t){27===t.which&&o.destroy()}),o.$options.baseClass&&o.$el.addClass(o.$options.baseClass),o.$options.showClass&&(o.$el.removeClass(o.$options.hideClass),o.$el.addClass(o.$options.showClass)),o.$el.data("lobibox",o)},_calculatePosition:function(o){var t,i=this;return t="top"===o?30:"bottom"===o?$(window).outerHeight()-i.$el.outerHeight()-30:($(window).outerHeight()-i.$el.outerHeight())/2,{left:($(window).outerWidth()-i.$el.outerWidth())/2,top:t}},_createButton:function(o,t){var i=this,n=$("<button></button>").addClass(t["class"]).attr("data-type",o).html(t.text);return i.$options.callback&&"function"==typeof i.$options.callback&&n.on("click.lobibox",function(t){var n=$(this);i._onButtonClick(i.$options.buttons[o],o),i.$options.callback(i,n.data("type"),t)}),n.click(function(){i._onButtonClick(i.$options.buttons[o],o)}),n},_onButtonClick:function(o,t){var i=this;("ok"===t&&"prompt"===i.$type&&i.isValid()||"prompt"!==i.$type||"ok"!==t)&&o&&o.closeOnClick&&i.destroy()},_generateButtons:function(){var o=this,t=[];for(var i in o.$options.buttons)if(o.$options.buttons.hasOwnProperty(i)){var n=o.$options.buttons[i],s=o._createButton(i,n);t.push(s)}return t},_createMarkup:function(){var o=this,t=$('<div class="lobibox"></div>');t.attr("data-is-modal",o.$options.modal);var i=$('<div class="lobibox-header"></div>').append('<span class="lobibox-title"></span>'),n=$('<div class="lobibox-body"></div>');if(t.append(i),t.append(n),o.$options.buttons&&!$.isEmptyObject(o.$options.buttons)){var s=$('<div class="lobibox-footer"></div>');s.append(o._generateButtons()),t.append(s),Lobibox.base.OPTIONS.buttonsAlign.indexOf(o.$options.buttonsAlign)>-1&&s.addClass("text-"+o.$options.buttonsAlign)}o.$el=t.addClass(Lobibox.base.OPTIONS.modalClasses[o.$type])},_setSize:function(){var o=this;o.setWidth(o.$options.width),"auto"===o.$options.height?o.setHeight(o.$el.outerHeight()):o.setHeight(o.$options.height)},_calculateBodyHeight:function(o){var t=this,i=t.$el.find(".lobibox-header").outerHeight(),n=t.$el.find(".lobibox-footer").outerHeight();return o-(i||0)-(n||0)},_addBackdrop:function(){0===$(".lobibox-backdrop").length&&$("body").append('<div class="lobibox-backdrop"></div>')},_triggerEvent:function(o){var t=this;t.$options[o]&&"function"==typeof t.$options[o]&&t.$options[o](t)},_calculateWidth:function(o){var t=this;return o=Math.min(Math.max(o,t.$options.width),$(window).outerWidth()),o===$(window).outerWidth()&&(o-=2*t.$options.horizontalOffset),o},_calculateHeight:function(o){var t=this;return console.log(t.$options.height),o=Math.min(Math.max(o,t.$options.height),$(window).outerHeight()),o===$(window).outerHeight()&&(o-=2*t.$options.verticalOffset),o},_addCloseButton:function(){var o=this,t=$('<span class="btn-close">&times;</span>');o.$el.find(".lobibox-header").append(t),t.on("mousedown",function(o){o.stopPropagation()}),t.on("click.lobibox",function(){o.destroy()})},_position:function(){var o=this;o._setSize();var t=o._calculatePosition();o.setPosition(t.left,t.top)},_isMobileScreen:function(){return $(window).outerWidth()<768},_enableDrag:function(){var o=this.$el;o.find(".lobibox-header").on("mousedown.lobibox",function(t){o.attr("offset-left",t.offsetX),o.attr("offset-top",t.offsetY),o.attr("allow-drag","true")}),$(document).on("mouseup.lobibox",function(){o.attr("allow-drag","false")}),$(document).on("mousemove.lobibox",function(t){if("true"===o.attr("allow-drag")){var i=t.clientX-parseInt(o.attr("offset-left"),10)-parseInt(o.css("border-left-width"),10),n=t.clientY-parseInt(o.attr("offset-top"),10)-parseInt(o.css("border-top-width"),10);o.css({left:i,top:n})}})},_setContent:function(o){var t=this;return t.$el.find(".lobibox-body").html(o),t},_beforeShow:function(){this._triggerEvent("onShow")},_afterShow:function(){var o=this;Lobibox.counter++,o.$el.attr("data-nth",Lobibox.counter),o.$options.draggable||$(window).on("resize.lobibox-"+o.$el.attr("data-nth"),function(){o.refreshWidth(),o.refreshHeight(),o.$el.css("left","50%").css("margin-left","-"+o.$el.width()/2+"px"),o.$el.css("top","50%").css("margin-top","-"+o.$el.height()/2+"px")}),o._triggerEvent("shown")},_beforeClose:function(){this._triggerEvent("beforeClose")},_afterClose:function(){var o=this;o.$options.draggable||$(window).off("resize.lobibox-"+o.$el.attr("data-nth")),o._triggerEvent("closed")},hide:function(){function o(){t.$el.addClass("lobibox-hidden"),0===$(".lobibox[data-is-modal=true]:not(.lobibox-hidden)").length&&($(".lobibox-backdrop").remove(),$("body").removeClass(Lobibox.base.OPTIONS.bodyClass))}var t=this;return t.$options.hideClass?(t.$el.removeClass(t.$options.showClass),t.$el.addClass(t.$options.hideClass),setTimeout(function(){o()},t.$options.delayToRemove)):o(),this},destroy:function(){function o(){t.$el.remove(),0===$(".lobibox[data-is-modal=true]").length&&($(".lobibox-backdrop").remove(),$("body").removeClass(Lobibox.base.OPTIONS.bodyClass)),t._afterClose()}var t=this;return t._beforeClose(),t.$options.hideClass?(t.$el.removeClass(t.$options.showClass).addClass(t.$options.hideClass),setTimeout(function(){o()},t.$options.delayToRemove)):o(),this},setWidth:function(o){var t=this;return t.$el.css("width",t._calculateWidth(o)),t},refreshWidth:function(){this.setWidth(this.$el.width())},refreshHeight:function(){this.setHeight(this.$el.height())},setHeight:function(o){var t=this;return t.$el.css("height",t._calculateHeight(o)).find(".lobibox-body").css("height",t._calculateBodyHeight(t.$el.innerHeight())),t},setSize:function(o,t){var i=this;return i.setWidth(o),i.setHeight(t),i},setPosition:function(o,t){var i;return"number"==typeof o&&"number"==typeof t?i={left:o,top:t}:"string"==typeof o&&(i=this._calculatePosition(o)),this.$el.css(i),this},setTitle:function(o){return this.$el.find(".lobibox-title").html(o)},getTitle:function(){return this.$el.find(".lobibox-title").html()},show:function(){var o=this,t=$("body");if(o._beforeShow(),o.$el.removeClass("lobibox-hidden"),t.append(o.$el),o.$options.buttons){o.$el.find(".lobibox-footer").children()[0].focus()}return o.$options.modal&&(t.addClass(Lobibox.base.OPTIONS.bodyClass),o._addBackdrop()),!1!==o.$options.delay&&setTimeout(function(){o.destroy()},o.$options.delay),o._afterShow(),o}};Lobibox.base={},Lobibox.base.OPTIONS={bodyClass:"lobibox-open",modalClasses:{error:"lobibox-error",success:"lobibox-success",info:"lobibox-info",warning:"lobibox-warning",confirm:"lobibox-confirm",progress:"lobibox-progress",prompt:"lobibox-prompt","default":"lobibox-default",window:"lobibox-window"},buttonsAlign:["left","center","right"],buttons:{ok:{"class":"lobibox-btn lobibox-btn-default",text:"OK",closeOnClick:!0},cancel:{"class":"lobibox-btn lobibox-btn-cancel",text:"Cancel",closeOnClick:!0},yes:{"class":"lobibox-btn lobibox-btn-yes",text:"Yes",closeOnClick:!0},no:{"class":"lobibox-btn lobibox-btn-no",text:"No",closeOnClick:!0}},icons:{bootstrap:{confirm:"glyphicon glyphicon-question-sign",success:"glyphicon glyphicon-ok-sign",error:"glyphicon glyphicon-remove-sign",warning:"glyphicon glyphicon-exclamation-sign",info:"glyphicon glyphicon-info-sign"},fontAwesome:{confirm:"fa fa-question-circle",success:"fa fa-check-circle",error:"fa fa-times-circle",warning:"fa fa-exclamation-circle",info:"fa fa-info-circle"}}},Lobibox.base.DEFAULTS={horizontalOffset:5,verticalOffset:5,width:600,height:"auto",closeButton:!0,draggable:!1,customBtnClass:"lobibox-btn lobibox-btn-default",modal:!0,debug:!1,buttonsAlign:"center",closeOnEsc:!0,delayToRemove:200,delay:!1,baseClass:"animated-super-fast",showClass:"zoomIn",hideClass:"zoomOut",iconSource:"bootstrap",onShow:null,shown:null,beforeClose:null,closed:null},o.prototype=$.extend({},e,{constructor:o,_processInput:function(t){var i=this,n=e._processInput.call(i,t);return n.buttons={ok:Lobibox.base.OPTIONS.buttons.ok,cancel:Lobibox.base.OPTIONS.buttons.cancel},t=$.extend({},n,o.DEFAULT_OPTIONS,t)},_init:function(){var o=this;e._init.call(o),o.show()},_afterShow:function(){var o=this;o._setContent(o._createInput())._position(),o.$input.focus(),e._afterShow.call(o)},_createInput:function(){var o,t=this;return t.$options.multiline?t.$input=$("<textarea></textarea>").attr("rows",t.$options.lines):t.$input=$('<input type="'+t.$promptType+'"/>'),t.$input.addClass("lobibox-input").attr(t.$options.attrs),t.$options.value&&t.setValue(t.$options.value),t.$options.label&&(o=$("<label>"+t.$options.label+"</label>")),$("<div></div>").append(o,t.$input)},setValue:function(o){return this.$input.val(o),this},getValue:function(){return this.$input.val()},isValid:function(){var o=this,t=o.$el.find(".lobibox-input-error-message");return o.$options.required&&!o.getValue()?(o.$input.addClass("invalid"),0===t.length&&(o.$el.find(".lobibox-body").append('<p class="lobibox-input-error-message">'+o.$options.errorMessage+"</p>"),o._position(),o.$input.focus()),!1):(o.$input.removeClass("invalid"),t.remove(),o._position(),o.$input.focus(),!0)}}),o.DEFAULT_OPTIONS={width:400,attrs:{},value:"",multiline:!1,lines:3,type:"text",label:"",required:!0,errorMessage:"The field is required"},t.prototype=$.extend({},e,{constructor:t,_processInput:function(o){var t=this,i=e._processInput.call(t,o);return i.buttons={yes:Lobibox.base.OPTIONS.buttons.yes,no:Lobibox.base.OPTIONS.buttons.no},o=$.extend({},i,Lobibox.confirm.DEFAULTS,o)},_init:function(){var o=this;e._init.call(o),o.show()},_afterShow:function(){var o=this,t=$("<div></div>");o.$options.iconClass&&t.append($('<div class="lobibox-icon-wrapper"></div>').append('<i class="lobibox-icon '+o.$options.iconClass+'"></i>')),t.append('<div class="lobibox-body-text-wrapper"><span class="lobibox-body-text">'+o.$options.msg+"</span></div>"),o._setContent(t.html()),o._position(),e._afterShow.call(o)}}),Lobibox.confirm.DEFAULTS={title:"Question",width:500},i.prototype=$.extend({},e,{constructor:i,_processInput:function(o){var t=this,i=e._processInput.call(t,o);return i.buttons={ok:Lobibox.base.OPTIONS.buttons.ok},o=$.extend({},i,Lobibox.alert.OPTIONS[t.$type],Lobibox.alert.DEFAULTS,o)},_init:function(){var o=this;e._init.call(o),o.show()},_afterShow:function(){var o=this,t=$("<div></div>");o.$options.iconClass&&t.append($('<div class="lobibox-icon-wrapper"></div>').append('<i class="lobibox-icon '+o.$options.iconClass+'"></i>')),t.append('<div class="lobibox-body-text-wrapper"><span class="lobibox-body-text">'+o.$options.msg+"</span></div>"),o._setContent(t.html()),o._position(),e._afterShow.call(o)}}),Lobibox.alert.OPTIONS={warning:{title:"Warning"},info:{title:"Information"},success:{title:"Success"},error:{title:"Error"}},Lobibox.alert.DEFAULTS={},n.prototype=$.extend({},e,{constructor:n,_processInput:function(o){var t=this,i=e._processInput.call(t,o);return o=$.extend({},i,Lobibox.progress.DEFAULTS,o)},_init:function(){var o=this;e._init.call(o),o.show()},_afterShow:function(){var o=this;o.$options.progressTpl?o.$progressBarElement=$(o.$options.progressTpl):o.$progressBarElement=o._createProgressbar();var t;o.$options.label&&(t=$("<label>"+o.$options.label+"</label>"));var i=$("<div></div>").append(t,o.$progressBarElement);o._setContent(i),o._position(),e._afterShow.call(o)},_createProgressbar:function(){var o=this,t=$('<div class="lobibox-progress-bar-wrapper lobibox-progress-outer"></div>').append('<div class="lobibox-progress-bar lobibox-progress-element"></div>');return o.$options.showProgressLabel&&t.append('<span class="lobibox-progress-text" data-role="progress-text"></span>'),t},setProgress:function(o){var t=this;if(100!==t.$progress)return o=Math.min(100,Math.max(0,o)),t.$progress=o,t._triggerEvent("progressUpdated"),100===t.$progress&&t._triggerEvent("progressCompleted"),t.$el.find(".lobibox-progress-element").css("width",o.toFixed(1)+"%"),t.$el.find('[data-role="progress-text"]').html(o.toFixed(1)+"%"),t},getProgress:function(){return this.$progress}}),Lobibox.progress.DEFAULTS={width:500,showProgressLabel:!0,label:"",progressTpl:!1,progressUpdated:null,progressCompleted:null},s.prototype=$.extend({},e,{constructor:s,_processInput:function(o){var t=this,i=e._processInput.call(t,o);return o.content&&"function"==typeof o.content&&(o.content=o.content()),o.content instanceof jQuery&&(o.content=o.content.clone()),o=$.extend({},i,Lobibox.window.DEFAULTS,o)},_init:function(){var o=this;e._init.call(o),o.setContent(o.$options.content),o.$options.url&&o.$options.autoload?(o.$options.showAfterLoad||o.show(),o.load(function(){o.$options.showAfterLoad&&o.show()})):o.show()},_afterShow:function(){var o=this;o._position(),e._afterShow.call(o)},setParams:function(o){var t=this;return t.$options.params=o,t},getParams:function(){return this.$options.params},setLoadMethod:function(o){var t=this;return t.$options.loadMethod=o,t},getLoadMethod:function(){return this.$options.loadMethod},setContent:function(o){var t=this;return t.$options.content=o,t.$el.find(".lobibox-body").html("").append(o),t},getContent:function(){return this.$options.content},setUrl:function(o){return this.$options.url=o,this},getUrl:function(){return this.$options.url},load:function(o){var t=this;return t.$options.url?($.ajax(t.$options.url,{method:t.$options.loadMethod,data:t.$options.params}).done(function(i){t.setContent(i),o&&"function"==typeof o&&o(i)}),t):t}}),Lobibox.window.DEFAULTS={width:480,height:600,content:"",url:"",draggable:!0,autoload:!0,loadMethod:"GET",showAfterLoad:!0,params:{}}}(),Math.randomString=function(o){for(var t="",i="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",n=0;n<o;n++)t+=i.charAt(Math.floor(Math.random()*i.length));return t};var Lobibox=Lobibox||{};!function(){var o=function(o,t){this.$type=null,this.$options=null,this.$el=null;var i=this,n=function(o){return"mini"!==o.size&&"large"!==o.size||(o=$.extend({},Lobibox.notify.OPTIONS[o.size],o)),o=$.extend({},Lobibox.notify.OPTIONS[i.$type],Lobibox.notify.DEFAULTS,o),"mini"!==o.size&&!0===o.title?o.title=Lobibox.notify.OPTIONS[i.$type].title:"mini"===o.size&&!0===o.title&&(o.title=!1),!0===o.icon&&(o.icon=Lobibox.notify.OPTIONS.icons[o.iconSource][i.$type]),!0===o.sound&&(o.sound=Lobibox.notify.OPTIONS[i.$type].sound),o.sound&&(o.sound=o.soundPath+o.sound+o.soundExt),o},s=function(o,t){if("normal"===i.$options.size)t.hasClass("bottom")?t.prepend(o):t.append(o);else if("mini"===i.$options.size)t.hasClass("bottom")?t.prepend(o):t.append(o);else if("large"===i.$options.size){var n=l().append(o),s=a(n.attr("id"));t.find(".lb-notify-wrapper").append(n),t.find(".lb-notify-tabs").append(s),e(s),s.find(">a").click(function(){e(s)})}},e=function(o){o.closest(".lb-notify-tabs").find(">li").removeClass("active"),o.addClass("active");var t=$(o.find(">a").attr("href"));t.closest(".lb-notify-wrapper").find(">.lb-tab-pane").removeClass("active"),t.addClass("active")},a=function(o){var t=$("<li></li>",{"class":Lobibox.notify.OPTIONS[i.$type]["class"]});return $("<a></a>",{href:"#"+o}).append('<i class="tab-control-icon '+i.$options.icon+'"></i>').appendTo(t),t},l=function(){return $("<div></div>",{"class":"lb-tab-pane",id:Math.randomString(10)})},r=function(){var o,t=("large"===i.$options.size?".lobibox-notify-wrapper-large":".lobibox-notify-wrapper")+"."+i.$options.position.replace(/\s/gi,".");return o=$(t),0===o.length&&(o=$("<div></div>").addClass(t.replace(/\./g," ").trim()).appendTo($("body")),"large"===i.$options.size&&o.append($('<ul class="lb-notify-tabs"></ul>')).append($('<div class="lb-notify-wrapper"></div>'))),o},c=function(){var o,t,n,s,e,a=Lobibox.notify.OPTIONS,l=$("<div></div>",{"class":"lobibox-notify "+a[i.$type]["class"]+" "+a["class"]+" "+i.$options.showClass});return n=$('<div class="lobibox-notify-icon-wrapper"></div>').appendTo(l),o=$('<div class="lobibox-notify-icon"></div>').appendTo(n),t=$("<div></div>").appendTo(o),i.$options.img?t.append('<img src="'+i.$options.img+'"/>'):i.$options.icon?t.append('<div class="icon-el"><i class="'+i.$options.icon+'"></i></div>'):l.addClass("without-icon"),e=$('<div class="lobibox-notify-msg">'+i.$options.msg+"</div>"),!1!==i.$options.messageHeight&&e.css("max-height",i.$options.messageHeight),s=$("<div></div>",{"class":"lobibox-notify-body"}).append(e).appendTo(l),i.$options.title&&s.prepend('<div class="lobibox-notify-title">'+i.$options.title+"<div>"),p(l),"normal"!==i.$options.size&&"mini"!==i.$options.size||(b(l),d(l)),i.$options.width&&l.css("width",f(i.$options.width)),l},p=function(o){i.$options.closable&&$('<span class="lobibox-close">&times;</span>').click(function(){i.remove()}).appendTo(o)},b=function(o){i.$options.closeOnClick&&o.click(function(){i.remove()})},d=function(o){if(i.$options.delay){if(i.$options.delayIndicator){var t=$('<div class="lobibox-delay-indicator"><div></div></div>');o.append(t)}var n=0,s=1e3/30,e=(new Date).getTime(),a=setInterval(function(){i.$options.continueDelayOnInactiveTab?n=(new Date).getTime()-e:n+=s;var o=100*n/i.$options.delay;o>=100&&(o=100,i.remove(),a=clearInterval(a)),i.$options.delayIndicator&&t.find("div").css("width",o+"%")},s);i.$options.pauseDelayOnHover&&o.on("mouseenter.lobibox",function(){s=0}).on("mouseleave.lobibox",function(){s=1e3/30})}},u=function(o){var t=o.prev();return 0===t.length&&(t=o.next()),0===t.length?null:t},f=function(o){return o=Math.min($(window).outerWidth(),o)};this.remove=function(){i.$el.removeClass(i.$options.showClass).addClass(i.$options.hideClass);var o=i.$el.parent(),t=o.closest(".lobibox-notify-wrapper-large"),n="#"+o.attr("id"),s=t.find('>.lb-notify-tabs>li:has(a[href="'+n+'"])');return s.addClass(Lobibox.notify.OPTIONS["class"]).addClass(i.$options.hideClass),setTimeout(function(){if("normal"===i.$options.size||"mini"===i.$options.size)i.$el.remove();else if("large"===i.$options.size){var t=u(s);t&&e(t),s.remove(),o.remove()}var n=Lobibox.notify.list,a=n.indexOf(i);n.splice(a,1);var l=n[a];l&&l.$options.showAfterPrevious&&l._init()},500),i},i._init=function(){var o=c();if("mini"===i.$options.size&&o.addClass("notify-mini"),"string"==typeof i.$options.position){var t=r();s(o,t),t.hasClass("center")&&t.css("margin-left","-"+t.width()/2+"px")}else $("body").append(o),o.css({position:"fixed",left:i.$options.position.left,top:i.$options.position.top});if(i.$el=o,i.$options.sound){new Audio(i.$options.sound).play()}i.$options.rounded&&i.$el.addClass("rounded"),i.$el.on("click.lobibox",function(o){i.$options.onClickUrl&&(window.location.href=i.$options.onClickUrl),i.$options.onClick&&"function"==typeof i.$options.onClick&&i.$options.onClick.call(i,o)}),i.$el.data("lobibox",i)},this.$type=o,this.$options=n(t),i.$options.showAfterPrevious&&0!==Lobibox.notify.list.length||this._init()};Lobibox.notify=function(t,i){if(["default","info","warning","error","success"].indexOf(t)>-1){var n=new o(t,i);return Lobibox.notify.list.push(n),n}},Lobibox.notify.list=[],Lobibox.notify.closeAll=function(){var o=Lobibox.notify.list;for(var t in o)o[t].remove()},Lobibox.notify.DEFAULTS={title:!0,size:"normal",soundPath:"sounds/",soundExt:".ogg",showClass:"fadeInDown",hideClass:"zoomOut",icon:!0,msg:"",img:null,closable:!0,hideCloseButton:!1,delay:5e3,delayIndicator:!0,closeOnClick:!0,width:400,sound:!0,position:"bottom right",iconSource:"bootstrap",rounded:!1,messageHeight:60,pauseDelayOnHover:!0,onClickUrl:null,showAfterPrevious:!1,continueDelayOnInactiveTab:!0,onClick:null},Lobibox.notify.OPTIONS={"class":"animated-fast",large:{width:500,messageHeight:96},mini:{"class":"notify-mini",messageHeight:32},"default":{"class":"lobibox-notify-default",title:"Default",sound:!1},success:{"class":"lobibox-notify-success",title:"Success",sound:"sound2"},error:{"class":"lobibox-notify-error",title:"Error",sound:"sound4"},warning:{"class":"lobibox-notify-warning",title:"Warning",sound:"sound5"},info:{"class":"lobibox-notify-info",title:"Information",sound:"sound6"},icons:{bootstrap:{success:"glyphicon glyphicon-ok-sign",error:"glyphicon glyphicon-remove-sign",warning:"glyphicon glyphicon-exclamation-sign",info:"glyphicon glyphicon-info-sign"},fontAwesome:{success:"fa fa-check-circle",error:"fa fa-times-circle",warning:"fa fa-exclamation-circle",info:"fa fa-info-circle"}}}}();