package ɕ
{
   import com.green.method.ǻ;
   import com.green.net.Ǿ;
   import flash.display.AVM1Movie;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.media.SoundTransform;
   import flash.net.LocalConnection;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import ƃ.FB;
   import ƒ.ŋ;
   import ƒ.Ǵ;
   import ƒ.ǵ;
   import ǹ.ȃ;
   import ȁ.Ȅ;
   import Ȑ.ȏ;
   
   use namespace ŋ;
   
   public class ȑ
   {
      
      private static var §͚§:int;
      
      private static var §͛§:uint;
      
      private static var §͜§:uint;
      
      private static var §͝§:DisplayObject;
      
      private static var §͞§:* = null;
      
      private static var §͟§:String;
      
      private static var §͠§:Boolean;
      
      private static var §͘§:Ǿ = new Ǿ();
      
      private static var §͙§:LocalConnection = new LocalConnection();
      
      private static var §͡§:String = uts(91,70,67,93);
      
      public static var §͗§:* = bleachvsnaruto;
      
      private static var labelXML:XML = <language>
	<appError en="APP ERROR!" zh-CN="程序发生错误：重要数据被破坏" zh-TW="程式數據被破壞" ru="ошибка приложения"/>
	<shell en="No running in a loader." zh-CN="不允许加壳运行" zh-TW="不允許加殼運行" />		
</language>;
      
      public function ȑ()
      {
         super();
      }
      
      [FrameTask]
      public static function §͢§() : void
      {
         if(ǵ.ɐ.ɉ)
         {
            §ͣ§();
         }
         else
         {
            ǵ.ɐ.addEventListener("complete",§ͣ§);
         }
      }
      
      private static function §ͣ§(param1:ȏ = null) : void
      {
         var _loc2_:String = null;
         Ȧ("app loaded");
         FB.updateLoadingUI(false);
         if(ǵ.ɐ.Ʌ)
         {
            if(!FB.serviceHold.ˢ && FB.serviceHold.isReady)
            {
               _loc2_ = getLabel("shell");
               FB.showError(_loc2_);
               Ȧ(_loc2_);
               return;
            }
         }
         §͞§ = §ͥ§(§͗§);
         if(!ǵ.ɐ.Ɉ && §ͦ§())
         {
            §͸§();
            return;
         }
         §ͧ§();
      }
      
      private static function §ͤ§() : Boolean
      {
         return ǻ.ˎ && ǻ.ˏ;
      }
      
      private static function §ͥ§(param1:*) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:Array = null;
         var _loc4_:ByteArray = null;
         var _loc9_:ByteArray = null;
         var _loc10_:int = 0;
         var _loc2_:ByteArray = null;
         var _loc3_:Array = null;
         var _loc8_:ByteArray = null;
         var _loc7_:* = null;
         try
         {
            _loc5_ = FB.getInstanceBy(param1,DisplayObject,ByteArray);
            if(_loc5_)
            {
               _loc7_ = _loc5_;
            }
            else if(param1 is Array && param1.length > 0)
            {
               _loc6_ = param1.concat();
               if(_loc6_.length == 1 || typeof _loc6_[1] == "number")
               {
                  _loc5_ = FB.getInstanceBy(_loc6_[0],ByteArray,DisplayObject);
                  if(_loc5_)
                  {
                     if(_loc5_ is ByteArray && _loc6_.length > 1)
                     {
                        _loc4_ = _loc5_;
                        _loc6_[0] = _loc4_;
                        _loc5_ = new ByteArray();
                        _loc5_.writeBytes.apply(null,_loc6_);
                        _loc4_.clear();
                     }
                     _loc7_ = _loc5_;
                  }
               }
               else
               {
                  _loc9_ = new ByteArray();
                  _loc10_ = 0;
                  while(_loc10_ < _loc6_.length)
                  {
                     _loc2_ = FB.getInstanceBy(_loc6_[_loc10_],ByteArray);
                     if(_loc2_)
                     {
                        _loc9_.writeBytes(_loc2_);
                        _loc2_.clear();
                     }
                     else if(_loc6_[_loc10_] is Array && _loc6_[_loc10_].length > 0)
                     {
                        _loc3_ = _loc6_[_loc10_].concat();
                        _loc8_ = FB.getInstanceBy(_loc3_[0],ByteArray);
                        if(_loc8_)
                        {
                           _loc3_[0] = _loc8_;
                           _loc2_ = new ByteArray();
                           _loc2_.writeBytes.apply(null,_loc3_);
                           _loc8_.clear();
                           _loc9_.writeBytes(_loc2_);
                           _loc2_.clear();
                        }
                     }
                     _loc10_++;
                  }
                  if(_loc9_.length > 0)
                  {
                     _loc7_ = _loc9_;
                  }
               }
            }
         }
         catch(err:Error)
         {
            _loc7_ = null;
         }
         return _loc7_;
      }
      
      private static function §ͦ§() : Boolean
      {
         if(!§͞§)
         {
            return true;
         }
         if(ǵ.ɐ.bytesTotal == ǵ.ɐ.timeline[uts(108,111,97,100,101,114,73,110,102,111)][uts(98,121,116,101,115)][uts(108,101,110,103,116,104)])
         {
            return false;
         }
         return true;
      }
      
      private static function §ͧ§() : void
      {
         Ȧ("init app instance");
         if(§͞§ is DisplayObject)
         {
            §͚§ = 1;
            §͝§ = §͞§;
            §͛§ = 3;
            §ͭ§();
         }
         else
         {
            §͚§ = 2;
            §͜§ = Math.random() * 16777215 >> 0;
            §͟§ = "message_" + §͜§;
            §͹§();
            §͘§.§̅§.applicationDomain = new ApplicationDomain();
            §͘§.§̅§.parameters = {
               "connectionName":§͟§,
               "connectionLength":§͟§.length.toString(),
               "in4399":FB.serviceHold.ˢ.toString(),
               "ready4399":FB.serviceHold.isReady.toString()
            };
            §͘§.count.§́§ = 1;
            §͘§.loadHandle.onFail = §ͨ§;
            §͘§.loadHandle.onComplete = §ͨ§;
            §͘§.loadBytes(§͞§);
         }
      }
      
      private static function §ͨ§(param1:Ǿ) : void
      {
         var _loc3_:Sprite = null;
         var _loc2_:AVM1Movie = null;
         if(param1.state.§͐§)
         {
            param1.loadHandle.onError = null;
            §͸§(param1.logText);
         }
         else if(param1.state.§͏§)
         {
            §͛§ = param1.loaderInfo.actionScriptVersion;
            if(§͛§ == 2)
            {
               _loc3_ = new Sprite();
               _loc3_.addChild(param1.loaderInfo.loader);
               §͝§ = _loc3_;
               §ͪ§(0);
               _loc2_ = param1.content as AVM1Movie;
               _loc2_.opaqueBackground = §͜§;
            }
            else
            {
               §͝§ = param1.content;
            }
            §͙§.addEventListener("asyncError",§ͩ§);
            §͙§.addEventListener("status",§ͩ§);
            Ȅ.§̰§(param1.loaderInfo.bytes);
            ǵ.ɐ.timeline.stage.frameRate = param1.loaderInfo.frameRate;
            §ͭ§();
         }
      }
      
      private static function §ͩ§(param1:Event) : void
      {
         trace("on connect error:",param1.type);
      }
      
      private static function §ͪ§(param1:Number) : void
      {
         var _loc3_:SoundTransform = null;
         var _loc2_:Sprite = §͝§ as Sprite;
         if(_loc2_)
         {
            _loc3_ = _loc2_.soundTransform;
            _loc3_.volume = param1;
            _loc2_.soundTransform = _loc3_;
         }
      }
      
      private static function uts(... rest) : String
      {
         return "".constructor.fromCharCode.apply(null,rest);
      }
      
      private static function §ͫ§() : Object
      {
         var _loc1_:Function = FB.bind;
         return {
            "moregames":_loc1_(§ͬ§,null,"moregames"),
            "rank":_loc1_(§ͬ§,null,"rank"),
            "score":_loc1_(§ͬ§,null,"score"),
            "getData":_loc1_(ͺ,"onGetData",§͘§.§̅§.parameters)
         };
      }
      
      private static function §ͬ§(param1:String, ... rest) : *
      {
         var _loc5_:String = "as" + §͛§;
         trace("call from " + _loc5_ + ":",param1,rest);
         var _loc4_:Array = rest.concat();
         _loc4_.unshift(param1);
         var _loc3_:Event = new DataEvent(_loc5_ + "game_event",false,true,JSON.stringify(_loc4_));
         ǵ.ɐ.timeline.stage.dispatchEvent(_loc3_);
         if(_loc3_.isDefaultPrevented() == false)
         {
            switch(param1)
            {
               case "moregames":
                  FB.serviceHold.showGameList();
                  break;
               case "rank":
                  FB.serviceHold.showSort();
                  break;
               case "score":
                  FB.serviceHold.showRefer(rest[0]);
            }
         }
      }
      
      private static function §ͭ§() : void
      {
         ǵ.ɐ.dispatchEvent(new ȃ("appInit"));
         Ȧ("app inited");
         ͱ();
         if(FB.remoteLoading)
         {
            Ȧ("remote loading, listener error");
            §ͮ§(true);
         }
         else
         {
            Ȧ("remoteSkiped",FB.remoteSkipped);
            §΃§();
         }
      }
      
      private static function §ͮ§(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = ["load_io_error","load_security_error","load_deal_error"];
         var _loc3_:int = int(_loc2_.length);
         if(param1)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               FB.text_bin_loader.addEventListener(_loc2_[_loc4_],§ͯ§);
               FB.swf_loader.addEventListener(_loc2_[_loc4_],§ͯ§);
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               FB.text_bin_loader.removeEventListener(_loc2_[_loc4_],§ͯ§);
               FB.swf_loader.removeEventListener(_loc2_[_loc4_],§ͯ§);
               _loc4_++;
            }
         }
      }
      
      private static function §ͯ§(param1:ȏ) : void
      {
         Ȧ("on remote error",param1.type);
         §ͮ§(false);
         §΃§();
      }
      
      private static function Ͱ(... rest) : Boolean
      {
         Ȧ("reload");
         if(ǵ.ɐ.ɉ)
         {
            try
            {
               §͘§.stop();
               try
               {
                  §͙§.close();
               }
               catch(err:Error)
               {
               }
               §͟§ = null;
               §΂§();
               ͱ();
               §͝§ && §͝§.parent && §͝§.parent.removeChild(§͝§);
               §͝§ = null;
               §͚§ = 0;
               §ͣ§();
            }
            catch(error:Error)
            {
               Ȧ(error.message);
               return false;
            }
            return true;
         }
         return false;
      }
      
      private static function ͱ() : void
      {
         if(§͞§ is ByteArray)
         {
            try
            {
               §͞§.clear();
            }
            catch(e:Error)
            {
               §͞§.position = 0;
               §͞§.length = 0;
            }
            §͞§ = null;
         }
      }
      
      private static function Ͳ() : Boolean
      {
         if(FB.remoteLoaded)
         {
            return FB.wait;
         }
         return Ǵ.ȧ || FB.wait || FB.shouldWait && !ǵ.ɐ.ɇ;
      }
      
      private static function ͳ(param1:Event) : void
      {
         if(Ͳ() == false)
         {
            Ȧ("on waiting complete, app is no need to wait.");
            §΂§();
            §͵§();
         }
      }
      
      private static function ʹ() : void
      {
         try
         {
            if(FB.serviceHold.isReady)
            {
               §͝§[uts(115,101,116,72,111,108,100)](FB.serviceHold.hold);
            }
         }
         catch(e:Error)
         {
         }
         try
         {
            §΅§[uts(115,101,116,83,116,97,116,101)](Ǵ.active,Ǵ.ȧ);
         }
         catch(e:Error)
         {
         }
      }
      
      private static function §͵§() : void
      {
         Ȧ("add app");
         ʹ();
         Ǵ.ȣ();
         ǵ.ɐ.ɀ();
         if(§͛§ == 2)
         {
            Ȧ("app resume volume");
            §ͪ§(1);
         }
         var _loc1_:DisplayObjectContainer = ǵ.ɐ.Ɂ;
         try
         {
            _loc1_.addChild(§͝§);
         }
         catch(error:Error)
         {
            Ȧ("app add to stage error:",error);
         }
         if(§͝§.stage)
         {
            if(!ǵ.ɐ.Ɉ && _loc1_.loaderInfo.bytes.length != parseInt("0x" + "#04236f9c".slice(1)))
            {
               ȑ.§͸§();
               §͝§.parent.removeChild(§͝§);
            }
            else
            {
               ǵ.ɐ.dispatchEvent(new ȃ("appAdded"));
               if(ͷ(§͝§.stage))
               {
                  Ȧ("stage is empty");
                  FB.updateLoadingUI(false,true);
                  §͝§.addEventListener("enterFrame",Ͷ);
               }
            }
         }
         else
         {
            ȑ.§͸§();
         }
      }
      
      private static function Ͷ(param1:Event = null) : void
      {
         if(!ͷ(§͝§.stage))
         {
            Ǵ.ȣ();
            §͝§.removeEventListener("enterFrame",Ͷ);
            Ȧ("stage has child");
         }
      }
      
      private static function ͷ(param1:DisplayObjectContainer) : Boolean
      {
         var _loc3_:Stage = param1.stage;
         var _loc2_:Array = param1.getObjectsUnderPoint(new Point(_loc3_.stageWidth / 2,_loc3_.stageHeight / 2));
         return !_loc2_ || _loc2_.length == 0;
      }
      
      public static function §͸§(... rest) : void
      {
         var _loc3_:String = uts(97,112,112,69,114,114,111,114);
         var _loc2_:String = getLabel(_loc3_);
         rest.unshift(_loc2_);
         Ȧ(_loc3_,rest);
         FB.showError.apply(null,rest);
      }
      
      private static function §͹§() : void
      {
         try
         {
            §͙§.client = §ͫ§();
            §͙§.connect(§͟§ + "_app_to_manager");
            trace("connect manager");
         }
         catch(e:Error)
         {
            §͙§.client = null;
         }
      }
      
      private static function ͺ(param1:String, ... rest) : void
      {
         var _loc3_:Array = rest.concat();
         _loc3_.unshift(§͟§ + "_manager_to_app",param1);
         try
         {
            §͙§.send.apply(null,_loc3_);
            trace("send from manager:",_loc3_);
         }
         catch(error:Error)
         {
         }
      }
      
      [Alias(key="97,112,112")]
      public static function get ͻ() : DisplayObject
      {
         return §͝§;
      }
      
      [Alias(key="105,110,115,116,97,110,99,101")]
      public static function get instance() : *
      {
         return §͞§;
      }
      
      [Alias(key="97,112,112,84,121,112,101")]
      public static function get ͼ() : uint
      {
         return §͚§;
      }
      
      [Alias(key="97,99,116,105,111,110,115,99,114,105,112,116,86,101,114,115,105,111,110")]
      public static function get ͽ() : uint
      {
         return §͛§;
      }
      
      [Alias(key="97,112,112,76,111,97,100,101,114,73,110,102,111")]
      public static function get §;§() : LoaderInfo
      {
         switch(§͚§ - 2)
         {
            case 0:
               return §͘§.loaderInfo;
            default:
               return ǵ.ɐ.timeline.loaderInfo;
         }
      }
      
      [Alias(key="97,112,112,76,111,97,100,101,114")]
      public static function get Ϳ() : Ǿ
      {
         return §͘§;
      }
      
      [Alias(key="97,112,112,76,111,99,97,108,67,111,110,110,101,99,116,105,111,110")]
      public static function get §΀§() : LocalConnection
      {
         return §͙§;
      }
      
      [Alias(key="97,112,112,67,111,110,110,101,99,116,105,111,110,78,97,109,101")]
      public static function get §΁§() : String
      {
         return §͟§;
      }
      
      [Alias(key="103,101,116,76,97,98,101,108")]
      public static function getLabel(param1:String) : String
      {
         return String(labelXML[param1]["@" + Ǵ.language] || labelXML[param1].@en);
      }
      
      private static function Ȧ(... rest) : void
      {
         ǵ.ɐ.Ɍ.apply(null,[§͡§].concat(rest));
      }
      
      [Alias(key="99,97,110,99,101,108,87,97,105,116,105,110,103")]
      public static function §΂§() : void
      {
         if(§͠§)
         {
            Ȧ("app cancel waiting.");
            ǵ.ɐ.timeline.removeEventListener("enterFrame",ͳ);
            §͠§ = false;
         }
      }
      
      [Alias(key="97,100,100,65,112,112")]
      public static function §΃§() : void
      {
         if(§͌§)
         {
            Ȧ("unable add app beacuse app is waiting.");
            return;
         }
         if(Έ)
         {
            Ȧ("unable add app beacuse app is playing.");
            return;
         }
         if(Ͳ())
         {
            §͠§ = true;
            ǵ.ɐ.timeline.addEventListener("enterFrame",ͳ);
            Ȧ("unable add app beacuse app should wait.");
            return;
         }
         §͵§();
      }
      
      [Alias(key="105,115,82,101,97,100,121")]
      public static function get §΄§() : Boolean
      {
         return !!§͝§;
      }
      
      [Alias(key="97,112,112,73,110,102,111")]
      public static function get §΅§() : *
      {
         var _loc1_:String = null;
         try
         {
            _loc1_ = uts(95,95,105,110,102,111,95,95);
            return null;
         }
         catch(error:Error)
         {
         }
         return null;
      }
      
      [Alias(key="105,110,102,111,68,101,97,108,105,110,103")]
      public static function get Ά() : Boolean
      {
         var _loc1_:String = null;
         try
         {
            _loc1_ = uts(105,110,102,111,82,101,97,100,121);
            return false;
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      [Alias(key="117,110,105,116,121,68,101,97,108,105,110,103")]
      public static function get §·§() : Boolean
      {
         var _loc1_:String = null;
         if(§͛§ == 3)
         {
            _loc1_ = uts(105,115,83,116,97,114,116,101,100);
            return §͝§ && _loc1_ in §͝§ && §͝§[_loc1_] != true;
         }
         return false;
      }
      
      [Alias(key="105,115,87,97,105,116,105,110,103")]
      public static function get §͌§() : Boolean
      {
         return §͠§;
      }
      
      [Alias(key="105,115,80,108,97,121,105,110,103")]
      public static function get Έ() : Boolean
      {
         return §͝§ && §͝§.stage;
      }
      
      [Alias(key="108,111,103,115")]
      public static function get ɋ() : Array
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc1_:Array = ǵ.ɐ.ɋ;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc4_] + "";
            if(_loc3_.indexOf(§͡§) == 0)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}

