package com.sh
{
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getDefinitionByName;
   
   public class Ǽ extends EventDispatcher
   {
      
      private var §˙§:*;
      
      private var main:DisplayObject;
      
      private var stage:Stage;
      
      private var §˚§:Object;
      
      private var §˛§:Boolean;
      
      public function Ǽ()
      {
         super();
         §˙§ = null;
      }
      
      private static function ˣ(param1:String, ... rest) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         _loc4_ = 0;
         while(_loc4_ < rest.length)
         {
            _loc3_ = rest[_loc4_] is Array ? String.fromCharCode.apply(null,rest[_loc4_]) : rest[_loc4_];
            if(new RegExp("^" + _loc3_.replace(/^\*\./,"(\\S+.){0,}").replace(/\./g,"\\.").replace(/\*/g,"\\S*")).test(param1))
            {
               return true;
            }
            _loc4_++;
         }
         return false;
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
      
      public function §˜§(param1:*, param2:DisplayObject) : void
      {
         §˙§ = param1;
         this.main = param2;
         if(param2.stage)
         {
            onAdded(null);
         }
         else
         {
            param2.addEventListener("addedToStage",onAdded);
         }
      }
      
      private function onAdded(param1:Event) : void
      {
         main.removeEventListener("addedToStage",onAdded);
         stage = main.stage;
         §˝§();
      }
      
      private function §˝§() : void
      {
         stage.addEventListener("logreturn",ˠ);
         stage.addEventListener("userLoginOut",ˠ);
         stage.addEventListener("MVC_CLOSE_PANEL",ˠ);
         stage.addEventListener("serverTimeEvent",ˠ);
         §˛§ = true;
      }
      
      public function §˞§(param1:Function) : void
      {
         var f:Function = param1;
         stage && stage.addEventListener("MVC_CLOSE_PANEL",function(param1:Event):void
         {
            param1.currentTarget.removeEventListener(param1.type,arguments.callee);
            trace("面板被关闭");
            f && f();
         });
      }
      
      public function getServerTime(param1:Function) : void
      {
         var f:Function = param1;
         addEventListener("render_time",function(param1:Ȉ):void
         {
            param1.currentTarget.removeEventListener(param1.type,arguments.callee);
            f && f(param1.date);
         });
         renderTime();
      }
      
      public function get §˟§() : Boolean
      {
         return §˛§;
      }
      
      private function ˠ(param1:Event) : void
      {
         switch(param1.type)
         {
            case "logreturn":
               §˚§ = param1["ret"];
               dispatchEvent(new ȇ("login",§˚§));
               break;
            case "userLoginOut":
               dispatchEvent(new ȇ("logout",§˚§));
               §˚§ = null;
               break;
            case "serverTimeEvent":
               dispatchEvent(new Ȉ("render_time",false,false,param1["data"]));
               break;
            case "MVC_CLOSE_PANEL":
         }
      }
      
      public function get isReady() : Boolean
      {
         return !!§˙§;
      }
      
      public function showGameList() : void
      {
         §˙§ && §˙§.showGameList();
      }
      
      public function get isLog() : Boolean
      {
         return ˡ ? true : false;
      }
      
      public function get ˡ() : Boolean
      {
         return §˙§ ? §˙§.isLog : null;
      }
      
      public function showLogPanel() : void
      {
         §˙§ && §˙§.showLogPanel();
      }
      
      public function userLogOut() : void
      {
         if(isLog)
         {
            §˙§.userLogOut();
         }
      }
      
      public function renderTime() : void
      {
         §˙§ && §˙§.getServerTime();
      }
      
      public function showRefer(param1:int) : void
      {
         §˙§ && §˙§.showRefer(param1);
      }
      
      public function changeScore(param1:int) : void
      {
         §˙§ && §˙§.changeScore(param1);
      }
      
      public function showSort() : void
      {
         §˙§ && §˙§.showSort();
      }
      
      public function get hold() : *
      {
         return §˙§;
      }
      
      public function get ˢ() : Boolean
      {
         return ˣ(get_domain(),[42,46,52,51,57,57,46,99,111,109],[42,46,52,51,57,57,97,112,105,46,99,111,109],[42,46,52,51,57,57,112,107,46,99,111,109],[42,46,53,48,53,52,51,57,57,46,99,111,109],[42,46,52,51,57,57,100,109,119,46,99,111,109],[42,46,52,51,57,57,101,114,46,99,111,109],[42,46,101,100,117,52,51,57,57,46,99,111,109],[42,46,51,51,56,55,46,99,111,109],[42,46,52,51,57,57,46,99,110],[42,46,52,51,57,57,46,110,101,116],[42,46,52,51,57,57,101,110,46,99,111,109],[42,46,52,51,57,57,119,97,110,106,117,46,99,111,109],[42,46,51,51,48,52,51,57,57,46,99,111,109]);
      }
   }
}

