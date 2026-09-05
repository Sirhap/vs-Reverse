package com.green.method
{
   import flash.external.ExternalInterface;
   
   public class Ǻ
   {
      
      private static var ɮ:Boolean = false;
      
      public function Ǻ()
      {
         super();
      }
      
      public static function get ɩ() : String
      {
         return uts(100,111,99,117,109,101,110,116,46,97,108,108);
      }
      
      public static function get ɪ() : String
      {
         return uts(100,111,99,117,109,101,110,116,46,103,101,116,69,108,101,109,101,110,116,115,66,121,84,97,103,78,97,109,101,40,39,42,39,41);
      }
      
      public static function get ɫ() : String
      {
         return "(" + ɩ + " || " + ɪ + ")";
      }
      
      public static function get ɬ() : String
      {
         return uts(69,77,66,69,68);
      }
      
      public static function get ɭ() : String
      {
         return uts(79,66,74,69,67,84);
      }
      
      public static function get objectID() : String
      {
         return ExternalInterface.objectID;
      }
      
      public static function get ɯ() : Boolean
      {
         if(!ɮ)
         {
            ɮ = eval("true") == true;
         }
         return ɮ;
      }
      
      public static function get flash() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = ʗ(new Function());
         if(_loc3_)
         {
            _loc2_ = objectID;
            if(_loc2_)
            {
               _loc1_ = ʋ("object[id=" + _loc2_ + "],embed[name=" + _loc2_ + "]");
               if(!ɲ(_loc1_,_loc3_))
               {
                  _loc1_ = ʊ(_loc2_);
                  if(!ɲ(_loc1_,_loc3_))
                  {
                     _loc1_ = ɴ(ʉ(_loc2_),_loc3_);
                  }
               }
            }
            _loc1_ = _loc1_ || ɴ(ɩ,_loc3_) || ɴ(ɪ,_loc3_);
            if(_loc1_)
            {
               ɱ(_loc1_,_loc3_);
               return _loc1_;
            }
         }
         return null;
      }
      
      public static function get ɰ() : String
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = index;
         if(_loc3_ > -1)
         {
            return ʨ(ɫ,_loc3_);
         }
         if(objectID)
         {
            _loc1_ = objectID;
            if(ʆ(_loc1_))
            {
               return ʊ(_loc1_);
            }
            _loc2_ = ʇ(ʷ);
            if(_loc2_ > 0)
            {
               return ʈ(ʷ,0);
            }
         }
         return "({})";
      }
      
      public static function ɱ(param1:String, param2:String) : Boolean
      {
         return eval("delete " + param1 + "[\'" + param2 + "\']");
      }
      
      private static function ɲ(param1:String, param2:String) : Boolean
      {
         return call("function(ele, f) {if(typeof ele == \'string\'){ele = eval(ele);}return !!(ele && (f in ele) && (ele[f] instanceof Function)); }",param1,param2);
      }
      
      private static function ɳ(param1:String, param2:String) : int
      {
         var _loc4_:* = call("function(a, f) {if (a) {if(typeof a == \'string\'){a = eval(a);}for (var i = 0; i < a.length; i++) {var ele = a[i]; if (ele && (f in ele) && (ele[f] instanceof Function)) {return i; } } } return -1; }",param1,param2);
         return _loc4_ > -1 ? _loc4_ : -1;
      }
      
      public static function ɴ(param1:String, param2:String) : String
      {
         var _loc3_:int = ɳ(param1,param2);
         if(_loc3_ > -1)
         {
            return ʨ(param1,_loc3_);
         }
         return null;
      }
      
      public static function get index() : int
      {
         var _loc4_:String = null;
         var _loc3_:String = null;
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc6_:int = -1;
         var _loc5_:String = "f_" + Math.random();
         if(addCallback(_loc5_,new Function()) == true)
         {
            _loc4_ = ɫ;
            _loc3_ = "(function (key){var all = " + _loc4_ + ";var len = all.length;for (var i = 0; i < len; i++){var el = all[i];if (el && (key in el) && (el[key] instanceof Function)){return i;}}return -1;})(\'" + _loc5_ + "\')";
            _loc6_ = eval(_loc3_);
            if(_loc6_ > -1)
            {
               _loc1_ = _loc4_ + "[" + _loc6_ + "][\'" + _loc5_ + "\']";
               if(eval(_loc1_ + " instanceof Function"))
               {
                  _loc2_ = "try{delete " + _loc1_ + ";}catch(err){}";
                  eval(_loc2_);
               }
               else
               {
                  _loc6_ = -1;
               }
            }
         }
         return _loc6_;
      }
      
      public static function get ɵ() : Boolean
      {
         return eval("(function() {if (window.navigator.mimeTypes && window.navigator.mimeTypes.length) {for (var i = 0; i < window.navigator.mimeTypes.length; i++) {var mt = window.navigator.mimeTypes[i]; if (mt.suffixes == \'swf\' && mt.enabledPlugin.filename.indexOf(\'.ocx\') > -1) {return true; } } } return Boolean(window.ActiveXObject); })();");
      }
      
      public static function log(... rest) : *
      {
         return ʑ("console.log",rest);
      }
      
      public static function warn(... rest) : *
      {
         return ʑ("console.warn",rest);
      }
      
      public static function info(... rest) : *
      {
         return ʑ("console.info",rest);
      }
      
      public static function alert(... rest) : void
      {
         call("alert",rest.join(", "));
      }
      
      public static function eval(param1:String) : *
      {
         return call("eval",param1);
      }
      
      public static function ɶ(param1:String, param2:String = null) : String
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         _loc5_ = 0;
         _loc4_ = param1.length;
         while(_loc5_ < _loc4_)
         {
            _loc3_[_loc5_] = param1.charCodeAt(_loc5_);
            _loc5_++;
         }
         return Ǻ.eval("(function(){var script_element = document.createElement(\'script\');script_element.src = URL.createObjectURL(new Blob([new Uint8Array([" + _loc3_.join(",") + "])],{type:\'text/javascript\'}));" + "script_element.onload = function(e){" + param2 + "};" + "(document.head || document.body || document.documentElement).appendChild(script_element);" + "})()");
      }
      
      public static function ɷ(param1:String, param2:Boolean = false) : void
      {
         call("function(src,async){var s = document.createElement(\'script\');s.src = src;s.async = async;(document.head || document.body || document.documentElement).appendChild(s);}",param1,param2);
      }
      
      public static function get ɸ() : Boolean
      {
         return Ǻ.eval("window.undefined=\'ES5\',undefined!=\'ES5\'") == true;
      }
      
      public static function ɹ(param1:String, param2:String) : Boolean
      {
         return eval(ʂ("function (e1,e2) {var r1 = e1.getBoundingClientRect(); var r2 = e2.getBoundingClientRect() return r1.left == r2.left && r1.right == r2.right && r1.top == r2.top && r1.bottom == r2.bottom; }",[param1,param2])) == true;
      }
      
      public static function ɺ(param1:Boolean = false, param2:Boolean = true) : String
      {
         return ʃ("function() {function getInfo(element) {return {element: element, width: element.style.width, height: element.style.height, toString: function() {return this.element + \'(\' + this.width + \',\' + this.height + \')\'; } }; } function resumeInfos(infos) {for (var i = 0; i < infos.length; i++) {resumeInfo(infos[i]); } } function resumeInfo(info) {info.element.style.width = info.width; info.element.style.height = info.height; } function setAutoSize(element, parent) {var infos = []; infos.push(getInfo(parent)); var w = element.offsetWidth; var h = element.offsetHeight; parent.style.width = w + \'px\'; parent.style.height = h + \'px\'; for (var p = element; p && p != parent; p = p.parentElement) {infos.push(getInfo(p)); p.style.width = \'100%\'; p.style.height = \'100%\'; } return infos; } var flash = arguments[0]; var listen = !!arguments[1]; var auto = arguments[2] == undefined ? true : !!arguments[2]; var element; var key_fullscreenEnabled; var key_fullscreenElement; var key_requestFullscreen; var key_exitFullscreen; var FULLSCREEN_CHANGE; var logs = []; var infos; var core; function log() {logs.push([].slice.call(arguments).join(\' \')); } function resizeToClient() {var tw = element.ownerDocument.documentElement.clientWidth; var th = element.ownerDocument.documentElement.clientHeight; setSize(tw, th); } function onResize(e) {if (elementInFullscreen()) {resizeToClient(); log(\'update size to\', element.style.width, element.style.height); } } function getFullscreenElement() {while (element.nodeName == \'EMBED\' || element.nodeName == \'OBJECT\') {element = element.parentNode; } if (!getFullscreenEnabled(element) && getFullscreenEnabled(element.ownerDocument.defaultView.frameElement)) {return element.ownerDocument.defaultView.frameElement; } return element; } function onFullscreenChange(e) {log(\'on event\', e.type, e.__sizeChanged__); if ((element == e.target || element.ownerDocument == e.target) && !e.__sizeChanged__) {var w = element.ownerDocument.defaultView; if (elementInFullscreen()) {infos = setAutoSize(flash, element); resizeToClient(); log(\'save infos:\', infos.join(\',\')); log(\'enter fullscreen, set size to :\', element.style.width, element.style.height); w.addEventListener(\'resize\', onResize); } else if (infos) {w.removeEventListener(\'resize\', onResize); resumeInfos(infos); infos = null; log(\'exit fullscreen, set size to :\', element.style.width, element.style.height); } e.__sizeChanged__ = true; } } function init() {if (!flash) {return; } if (element) {element.ownerDocument.removeEventListener(FULLSCREEN_CHANGE, onFullscreenChange); element.removeEventListener(FULLSCREEN_CHANGE, onFullscreenChange); } element = flash; log(\'get element:\', flash); key_fullscreenElement = function(key) {var keys = []; for (var i in document) {if (new RegExp(\'[a-z0-9]*\' + key, \'gi\').test(i)) {keys.push(i); } } keys.sort(function(e1, e2) {return e1.length - e2.length; }); return keys.shift(); }(\'fullscreenElement\'); if (key_fullscreenElement) {core = key_fullscreenElement.replace(/fullscreenElement/gi, \'\'); FULLSCREEN_CHANGE = core == \'ms\' ? \'MSFullscreenChange\' : core + \'fullscreenchange\'; key_requestFullscreen = getExisted(element, core, [\'requestFullscreen\', \'requestFullScreen\']); key_exitFullscreen = getExisted(document, core, [\'exitFullscreen\', \'cancelFullScreen\']); key_fullscreenEnabled = getExisted(document, core, [\'fullscreenEnabled\', \'fullScreenEnabled\']); log(\'get core:\', core, \'listen:\', listen, \'event:\', FULLSCREEN_CHANGE, \'keys:\', key_requestFullscreen, key_exitFullscreen, key_fullscreenEnabled, key_fullscreenElement); element = auto ? getFullscreenElement() : element; if (listen) {element.ownerDocument.addEventListener(FULLSCREEN_CHANGE, onFullscreenChange); element.addEventListener(FULLSCREEN_CHANGE, onFullscreenChange); } } else {log(\'core get fail\'); } } function getExisted(target, core, ns) {if (typeof ns == \'string\') {ns = [ns]; } for (var i = 0; i < ns.length; i++) {var n = ns[i]; if (n in target) {return n; } else if (core) {n = core + n[0].toUpperCase() + n.slice(1); if (n in target) {return n; } } } return null; } function elementInFullscreen() {return element.ownerDocument[key_fullscreenElement] ? element == element.ownerDocument[key_fullscreenElement] : false; } function getFullscreenEnabled(element) {return element && element.ownerDocument && element.ownerDocument[key_fullscreenEnabled] || false; } function enter() {if (getFullscreenEnabled(element)) {element[key_requestFullscreen](); } } function exit() {if (getFullscreenEnabled(element)) {element.ownerDocument[key_exitFullscreen](); } } function change() {if (elementInFullscreen()) {exit(); } else {enter(); } } function setSize(w, h) {element.style.width = w + \'px\'; element.style.height = h + \'px\'; } function on(target, event) {if (typeof target == \'string\') {var e = document.getElementById(target); if (!e) {try {e = document.querySelector(target); } catch (err) {} } target = e; } try {target && target.addEventListener(event, enter); } catch (err) {log(\'error on\', target, event); } } Object.defineProperties(this, {element: {get: function() {return element; }, set: function(e) {flash = e; init(); } }, logs: {get: function() {return logs.concat(); } }, enter: {get: function() {return enter; } }, exit: {get: function() {return exit; } }, change: {get: function() {return change; } }, enabled: {get: function() {return getFullscreenEnabled(element); } }, fullscreen: {get: elementInFullscreen }, core: {get: function() {return core; } }, infos: {get: function() {return infos; } }, on: {get: function() {return on; } } }); init(); }"
         ,[flash,param1,param2]);
      }
      
      public static function get ɻ() : String
      {
         return "(function(){function e(){}return Object.defineProperty(e,\'FULLSCREEN_CHANGE\',{get:function(){return\'ms\'==this.m_brower_core?\'MSFullscreenChange\':this.m_brower_core+\'fullscreenchange\'},enumerable:!0,configurable:!0}),e.m_get_brower_core=function(){var e=\'fullscreenElement\';if(e in document)return\'\';var t=[];for(var n in document)new RegExp(e+\'$\',\'i\').test(n)&&t.push(n.slice(0,n.length-e.length));return t.length?t.sort(function(e,t){return e.length-t.length}).shift():\'\'},Object.defineProperty(e,\'isFullscreen\',{get:function(){return!!this.fullscreenElement},enumerable:!0,configurable:!0}),Object.defineProperty(e,\'fullscreenElement\',{get:function(){return this.getFullscreenElement(document)},enumerable:!0,configurable:!0}),e.getFullscreenElement=function(t){return t[e.m_get_core_key(t,\'fullscreenElement\',\'fullScreenElement\')]},Object.defineProperty(e,\'fullscreenEnabled\',{get:function(){return this.getFullscreenEnabled(document)},enumerable:!0,configurable:!0}),e.getFullscreenEnabled=function(t){return t[e.m_get_core_key(t,\'fullscreenEnabled\',\'fullScreenEnabled\')]},e.exitFullscreen=function(){this.exitFullscreenBy(document)},e.exitFullscreenBy=function(t){t[e.m_get_core_key(t,\'exitFullscreen\',\'cancelFullScreen\')]()},e.requestFullscreen=function(t){t[e.m_get_core_key(t,\'requestFullscreen\',\'requestFullScreen\')]()},e.m_get_core_key=function(e){for(var t=[],n=1;n<arguments.length;n++)t[n-1]=arguments[n];\'string\'==typeof t&&(t=[t]);for(var r=0;r<t.length;r++){var l=t[r];if(l in e)return l;if(this.m_brower_core&&(l=this.m_brower_core+l[0].toUpperCase()+l.slice(1))in e)return l}return null},e.m_brower_core=e.m_get_brower_core(),e})()";
      }
      
      public static function ɼ(param1:String) : void
      {
         call("function(){" + ɻ + ".requestFullscreen(" + param1 + ")" + "}");
      }
      
      public static function ɽ() : void
      {
         call(ɻ + ".exitFullscreen");
      }
      
      public static function get ɾ() : Boolean
      {
         return eval(ɻ + ".isFullscreen");
      }
      
      public static function get ɿ() : Boolean
      {
         return eval(ɻ + ".fullscreenEnabled");
      }
      
      public static function get ʀ() : Boolean
      {
         return Ǻ.eval(Ǻ.ɻ + ".fullscreenElement" + "==" + flash);
      }
      
      public static function get ʁ() : String
      {
         var _loc1_:String = ʩ(flash,"parentNode",true);
         if(ʬ(_loc1_,"nodeName") == ɭ)
         {
            return ʩ(_loc1_,"parentNode",true);
         }
         return _loc1_;
      }
      
      public static function ʂ(param1:String, param2:Array) : String
      {
         return "(" + param1 + ")(" + param2.join(",") + ")";
      }
      
      public static function ʃ(param1:String, param2:Array) : String
      {
         return "new " + param1 + "(" + param2.join(",") + ")";
      }
      
      public static function ʄ(param1:String) : *
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc5_ = 0;
         _loc3_ = param1.length;
         while(_loc5_ < _loc3_)
         {
            _loc2_[_loc5_] = param1.charCodeAt(_loc5_);
            _loc5_++;
         }
         var _loc4_:String = "eval(String.fromCharCode(" + _loc2_.join(",") + "))";
         return eval(_loc4_);
      }
      
      public static function ʅ(param1:String) : void
      {
         eval("!!(" + param1 + ")");
      }
      
      public static function ʆ(param1:String) : Boolean
      {
         return eval("!!" + ʊ(param1));
      }
      
      public static function ʇ(param1:String) : int
      {
         return eval(ʉ(param1) + ".length");
      }
      
      public static function ʈ(param1:String, param2:int) : String
      {
         return ʉ(param1) + "[" + param2 + "]";
      }
      
      public static function ʉ(param1:String) : String
      {
         return "document.getElementsByName(\'" + param1 + "\')";
      }
      
      public static function ʊ(param1:String) : String
      {
         return "document.getElementById(\'" + param1 + "\')";
      }
      
      public static function ʋ(param1:String) : String
      {
         return "document.querySelector(\'" + param1 + "\')";
      }
      
      public static function ʌ(param1:String) : void
      {
         var _loc2_:String = ʊ(param1);
         call(_loc2_ + ".parentNode.removeChild",_loc2_);
      }
      
      public static function ʍ(param1:String) : Boolean
      {
         return eval(param1 + " instanceof Function");
      }
      
      public static function ʎ(param1:String, param2:int) : *
      {
         return call("setTimeout",param1,param2);
      }
      
      public static function ʏ(param1:String) : Boolean
      {
         return ʓ("eval",param1);
      }
      
      public static function ʐ(param1:String) : String
      {
         return ʄ("navigator.userAgent.match(/ " + param1 + "\\/(\\d+(\\.\\d+)*)/)[1]");
      }
      
      public static function exec(param1:String) : *
      {
         return ʔ("eval",param1);
      }
      
      public static function ʑ(param1:String, param2:Array = null) : *
      {
         param2 = param2 ? param2.concat() : [];
         param2.unshift(param1);
         try
         {
            return ExternalInterface.call.apply(null,param2);
         }
         catch(e:*)
         {
         }
         return null;
      }
      
      public static function ʒ(param1:String, param2:Array) : *
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            param2[_loc3_] = JSON.stringify(param2[_loc3_]);
            _loc3_++;
         }
         return Ǻ.ʄ("(" + param1 + ")(" + param2.join(",") + ")");
      }
      
      public static function ʓ(param1:String, ... rest) : Boolean
      {
         rest.unshift(param1);
         try
         {
            ExternalInterface.call.apply(null,rest);
            return true;
         }
         catch(e:*)
         {
         }
         return false;
      }
      
      public static function ʔ(param1:String, ... rest) : *
      {
         rest.unshift(param1);
         try
         {
            return ExternalInterface.call.apply(null,rest);
         }
         catch(e:*)
         {
            var _loc5_:§--UNKNOWN--§ = e;
         }
         return _loc5_;
      }
      
      public static function call(param1:String, ... rest) : *
      {
         return ʑ(param1,rest);
      }
      
      public static function ʕ(param1:String, ... rest) : *
      {
         return ʒ(param1,rest);
      }
      
      public static function ʖ(param1:String, param2:String = null) : Boolean
      {
         param2 = param2 || param1.split("/").pop().split(/#|\?/).shift() || param1;
         return call("function(url, name) {var a = document.createElement(\'a\'); if (\'download\' in a) {a.href = url; a.target = \'_blank\'; a.download = name; a.click(); return true; } return false; }",param1,param2);
      }
      
      public static function ʗ(param1:Function, param2:String = null) : String
      {
         param2 ||= "f_" + Math.random();
         if(addCallback(param2,param1) == true)
         {
            return param2;
         }
         return null;
      }
      
      public static function addCallback(param1:String, param2:Function) : *
      {
         try
         {
            ExternalInterface.addCallback(param1,param2);
            return true;
         }
         catch(e:*)
         {
            var _loc5_:§--UNKNOWN--§ = e;
         }
         return _loc5_;
      }
      
      public static function ʘ(param1:String) : Boolean
      {
         return ɱ(flash,param1);
      }
      
      public static function ʙ(param1:String, ... rest) : *
      {
         return ʑ(flash + "[\'" + param1 + "\']",rest);
      }
      
      public static function ʚ(param1:String) : Boolean
      {
         return ʍ(ʩ(flash,param1));
      }
      
      public static function get protocol() : String
      {
         return ʛ("location.protocol");
      }
      
      private static function ʛ(param1:String) : String
      {
         return eval("(" + param1 + ")+\'\'");
      }
      
      public static function get href() : String
      {
         return ʛ("location.href");
      }
      
      public static function get ʜ() : String
      {
         return ʛ("parent.location.href");
      }
      
      public static function get ʝ() : String
      {
         return ʛ("top.location.href");
      }
      
      public static function get ʞ() : String
      {
         return ʛ("document.referrer.href");
      }
      
      public static function get ʟ() : String
      {
         return ʛ("parent.document.referrer");
      }
      
      public static function get ʠ() : String
      {
         return ʛ("top.document.referrer");
      }
      
      public static function get ʡ() : String
      {
         return ʛ("document.URL");
      }
      
      public static function get ʢ() : String
      {
         return ʛ("document.lastModified");
      }
      
      public static function get ʣ() : Boolean
      {
         return call(String.fromCharCode(102,117,110,99,116,105,111,110,40,41,32,123,118,97,114,32,108,109,32,61,32,100,111,99,117,109,101,110,116,46,108,97,115,116,77,111,100,105,102,105,101,100,46,115,112,108,105,116,40,47,91,94,92,100,93,47,41,59,32,118,97,114,32,100,97,116,101,32,61,32,110,101,119,32,68,97,116,101,40,108,109,91,50,93,44,32,112,97,114,115,101,73,110,116,40,108,109,91,48,93,41,32,45,32,49,44,32,108,109,91,49,93,44,32,108,109,91,51,93,44,32,108,109,91,52,93,44,32,108,109,91,53,93,41,59,32,114,101,116,117,114,110,32,100,97,116,101,46,116,111,76,111,99,97,108,101,83,116,114,105,110,103,40,41,32,61,61,32,110,101,119,32,68,97,116,101,40,41,46,116,111,76,111,99,97,108,101,83,116,114,105,110,103,40,41,32,125));
      }
      
      private static function uts(... rest) : String
      {
         return "".constructor.fromCharCode.apply(null,rest);
      }
      
      public static function get domain() : String
      {
         return ʤ || hostname;
      }
      
      public static function get ʤ() : String
      {
         return ʛ("document.domain");
      }
      
      public static function get hostname() : String
      {
         return ʛ("location.hostname");
      }
      
      public static function get ʥ() : String
      {
         return ʛ("parent.location.hostname");
      }
      
      public static function get ʦ() : String
      {
         return ʛ("top.location.hostname");
      }
      
      public static function get ʧ() : String
      {
         return call("function() {var w = window; var aw = function(w) {if (w.parent != w) {try {w.document; return true; } catch (err) {} } return false; }; while (aw(w.parent)) {w = w.parent; } return w == top ? w.location.href : (w.document.referrer || w.location.href); }");
      }
      
      public static function ʨ(param1:String, param2:int) : String
      {
         return param1 + "[" + param2 + "]";
      }
      
      public static function ʩ(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : String
      {
         param1 = "(" + param1 + ")";
         param4 && param1;
         return param3 ? param1 + "." + param2 : param1 + "[\'" + param2 + "\']";
      }
      
      public static function ʪ(param1:String, param2:String, param3:*) : void
      {
         call("function(name,value){(" + param1 + ")[name] = value}",param2,param3);
      }
      
      public static function ʫ(param1:String, param2:String, param3:*) : void
      {
         call(ʩ(param1,"setAttribute",true),param2,param3);
      }
      
      public static function getAttribute(param1:String) : String
      {
         return ʩ(param1,"getAttribute",true);
      }
      
      public static function ʬ(param1:String, param2:String) : *
      {
         return eval(ʩ(param1,param2));
      }
      
      public static function ʭ(param1:String, param2:String) : *
      {
         return call(getAttribute(param1),param2);
      }
      
      public static function ʮ(param1:String, param2:String) : *
      {
         return ʭ(ʊ(param1),param2);
      }
      
      public static function ʯ(param1:String) : *
      {
         return ʭ(flash,param1);
      }
      
      public static function ʰ(param1:int, param2:int) : void
      {
         var _loc3_:String = flash;
         Ǻ.eval(_loc3_ + ".style.width = \'" + param1 + "px\';" + _loc3_ + ".style.height = \'" + param2 + "px\';");
      }
      
      public static function ʱ(param1:String, param2:*) : void
      {
         ʫ(flash,param1,param2);
      }
      
      public static function ʲ(param1:String, param2:*) : void
      {
         ʪ(flash,param1,param2);
      }
      
      public static function ʳ(param1:String) : *
      {
         return ʬ(flash,param1);
      }
      
      public static function ʴ(param1:String, param2:String) : String
      {
         var _loc3_:String = "(function(target, key, ignore) {ignore = arguments.length < 3 ? true : ignore; if (target && target.hasChildNodes()) {key = ignore ? key.toLowerCase() : key; for (var i = 0; i < target.childNodes.length; i++) {var node = target.childNodes[i]; if (!node.name) {continue; } var name = ignore ? node.name.toLowerCase() : node.name; if (name == key) {return node.value; } } } return undefined; })(" + param1 + "," + "\'" + param2 + "\'" + "," + true + ")";
         return eval(_loc3_);
      }
      
      public static function get ʵ() : String
      {
         return ʳ("nodeName");
      }
      
      public static function get ʶ() : String
      {
         return ʳ("id");
      }
      
      public static function get ʷ() : String
      {
         return ʳ("name");
      }
      
      public static function get ʸ() : String
      {
         switch(ʵ)
         {
            case ɬ:
               return ʳ("src") || ʯ("src");
            case ɭ:
               return ʴ(flash,"movie") || ʯ("data");
            default:
               return null;
         }
      }
      
      public static function ʹ(param1:String) : Boolean
      {
         return call("function(element, defaultVlaue) {if (typeof element == \'string\') {try {element = eval(element); } catch (err) {} } if (!element || !(window.getComputedStyle instanceof Function) || !(element.getBoundingClientRect instanceof Function)) {return !!defaultVlaue; } var element_rect = element.getBoundingClientRect(); while (element != document) {var style = getComputedStyle(element); if (style.display == \'none\' || style.visibility == \'hidden\') {return false; } var hiddenX = style.overflowX == \'hidden\'; var hiddenY = style.overflowY == \'hidden\'; if (hiddenX || hiddenY) {var rect = element.getBoundingClientRect(); if (hiddenX) {if (element_rect.left >= rect.right || element_rect.right <= rect.left) {return false; } } if (hiddenY) {if (element_rect.top >= rect.bottom || element_rect.bottom <= rect.top) {return false; } } } element = element.parentNode; } return true; }",param1,true) != false;
      }
      
      public static function ʺ() : Boolean
      {
         return ʻ(Ǻ.flash);
      }
      
      public static function ʻ(param1:String) : Boolean
      {
         return call("function(){var element = " + param1 + ";" + "if (document.elementFromPoint)" + "{" + "var rect = element.getBoundingClientRect();" + "var cx = rect.left + rect.width / 2;" + "var cy = rect.top + rect.height / 2;" + "var top_element = document.elementFromPoint(cx, cy);" + "return element.contains(top_element);" + "}" + "return true;}");
      }
      
      public static function ʼ() : Boolean
      {
         return ʹ(flash);
      }
      
      public static function ʽ(param1:String, param2:String = null) : String
      {
         switch(ʵ)
         {
            case ɬ:
               return ʯ(param1) || param2;
            case ɭ:
               return ʴ(flash,param1) || param2;
            default:
               return null;
         }
      }
      
      public static function get wmode() : String
      {
         return ʽ("wmode","window");
      }
      
      public static function get allowNetworking() : String
      {
         return ʽ("allowNetworking","all");
      }
      
      public static function get allowScriptAccess() : String
      {
         return ʽ("allowScriptAccess","sameDomain");
      }
      
      public static function get allowFullScreen() : String
      {
         return ʽ("allowFullScreen","false");
      }
      
      public static function get allowFullScreenInteractive() : String
      {
         return ʽ("allowFullScreenInteractive","false");
      }
      
      public static function ʾ() : Object
      {
         return {
            "wmode":"window",
            "allowNetworking":"all",
            "allowScriptAccess":"samedomain",
            "allowFullScreen":"false",
            "allowFullScreenInteractive":"false",
            "quality":"high",
            "play":"true",
            "loop":"true",
            "menu":"true",
            "scale":"showall"
         };
      }
      
      public static function ʿ() : Boolean
      {
         return eval("(function() {var access = function(w) {try {return w.document ? true : false; } catch (e) {return false; } }; var getDomainSuffix = function(domain) {var ip = String.fromCharCode(94, 40, 92, 100, 43, 92, 46, 41, 123, 51, 125, 92, 100, 43, 36); if (new RegExp(ip).test(domain)) {return domain; } var ds = domain.split(\'.\'); if (ds.length < 3 || ([\'com\', \'gov\', \'net\', \'org\']).indexOf(ds[ds.length - 2]) > -1) {return domain; } ds.shift(); return ds.join(\'.\'); }; var domain = document.domain; var cache = domain; while (!access(window.top)) {var suffix = getDomainSuffix(domain); if (suffix == domain) {break; } domain = suffix; document.domain = domain; } if (access(window.top)) {return true; } document.domain = cache; return false; })()");
      }
      
      public static function reload(param1:int = 100, param2:String = null, param3:Object = null) : void
      {
         if(!ɯ)
         {
            return;
         }
         ʎ(ˀ(param2,param3),param1);
      }
      
      public static function ˀ(param1:String = null, param2:Object = null) : String
      {
         var _loc4_:String = param1 || flash;
         var _loc6_:Object = {
            "allowNetworking":"all",
            "allowFullScreen":"true",
            "allowScriptAccess":"always"
         };
         if(param2)
         {
            for(var _loc8_ in param2)
            {
               _loc6_[_loc8_] = param2[_loc8_];
            }
         }
         var _loc5_:Array = [];
         for(var _loc7_ in _loc6_)
         {
            _loc5_.push("\'" + _loc7_ + "\'" + ":" + "\'" + _loc6_[_loc7_] + "\'");
         }
         var _loc3_:String = "{" + _loc5_.join(", ") + "}";
         return "(function() {var fl_obj = " + _loc4_ + "; var target = " + _loc3_ + "; var getParam = function(name, value) {var p = document.createElement(\'PARAM\'); p.setAttribute(\'name\', name); p.setAttribute(\'value\', value); return p; }; var getChildByName = function(element, name) {var cs = element.childNodes || element.children; for (var i = 0; i < cs.length; i++) {var node = cs[i]; if (node.name && node.name.toLowerCase() == name.toLowerCase()) {return node; } } return null; }; var new_obj = fl_obj.cloneNode(true); var change_child = fl_obj.nodeName != \'EMBED\'; var name; for (name in target) {var value = target[name]; if (change_child) {var node = getChildByName(new_obj, name); if (node) {node.value = value; } else {new_obj.appendChild(getParam(name, value)); } } else {new_obj.setAttribute(name, value); } } fl_obj.parentElement && fl_obj.parentElement.replaceChild(new_obj, fl_obj); })()";
      }
   }
}

