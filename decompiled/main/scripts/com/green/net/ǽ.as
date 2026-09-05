package com.green.net
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import Ȋ.Ǵ;
   import Ȋ.ȉ;
   import Ȋ.ȋ;
   import Ȋ.Ȏ;
   
   use namespace Ǵ;
   
   public class ǽ extends EventDispatcher
   {
      
      public static var §̀§:uint = 4294967295;
      
      public static var §́§:uint = 2000;
      
      private var ˤ:URLLoader;
      
      private var §˥§:URLRequest;
      
      private var delay:uint;
      
      protected var ms:uint;
      
      protected var §˦§:Array;
      
      protected var §˧§:Ȏ;
      
      protected var §˨§:ȋ;
      
      protected var §˩§:ȉ;
      
      private var §˪§:uint;
      
      private var §˫§:uint;
      
      public function ǽ(param1:Object = null)
      {
         super();
         init();
         §˭§(param1);
      }
      
      protected function init() : void
      {
         §˦§ = [];
         §˥§ = new URLRequest();
         ˤ = new URLLoader();
         ˤ.dataFormat = "binary";
         §˩§ = new ȉ(this);
         §˧§ = new Ȏ();
         §˨§ = new ȋ(0,§̀§);
         ms = §́§;
         ˬ();
      }
      
      protected function ˬ() : void
      {
         ˤ.addEventListener("open",§˯§);
         ˤ.addEventListener("progress",§˯§);
         ˤ.addEventListener("complete",§˯§);
         ˤ.addEventListener("ioError",§˯§);
         ˤ.addEventListener("securityError",§˯§);
      }
      
      public function §˭§(param1:*) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 is String)
         {
            url = param1;
            return;
         }
         ˮ(param1);
         if(url && param1.start)
         {
            start();
         }
      }
      
      protected function ˮ(param1:Object) : void
      {
         var _loc2_:* = undefined;
         if("onEvent" in param1)
         {
            §˩§.onEvent = param1.onEvent;
            delete param1.onEvent;
         }
         for(var _loc3_ in param1)
         {
            _loc2_ = param1[_loc3_];
            switch(_loc3_)
            {
               case "url":
                  url = _loc2_;
                  break;
               case "ms":
               case "reloadDelay":
                  ms = _loc2_;
                  break;
               case "repeat":
                  §˨§.§́§ = _loc2_;
                  break;
               case "onStart":
                  §˩§.onStart = _loc2_;
                  break;
               case "onOpen":
                  §˩§.onOpen = _loc2_;
                  break;
               case "onProgress":
                  §˩§.onProgress = _loc2_;
                  break;
               case "onComplete":
                  §˩§.onComplete = _loc2_;
                  break;
               case "onError":
                  §˩§.onError = _loc2_;
                  break;
               case "onFail":
                  §˩§.onFail = _loc2_;
            }
         }
      }
      
      public function set url(param1:String) : void
      {
         §˥§.url = param1;
      }
      
      public function get url() : String
      {
         return §˥§.url;
      }
      
      public function get requestHeaders() : Array
      {
         return §˥§.requestHeaders;
      }
      
      public function set requestHeaders(param1:Array) : void
      {
         §˥§.requestHeaders = param1;
      }
      
      public function start() : void
      {
         if(§˧§.isReady || §˧§.§͎§)
         {
            §˪§ = getTimer();
         }
         stop();
         §˰§();
         ˤ.load(§˥§);
      }
      
      public function load(param1:String) : void
      {
         url = param1;
         start();
      }
      
      public function stop() : void
      {
         if(§˧§.§͊§)
         {
            ˤ.close();
         }
         if(§˧§.§͌§)
         {
            clearTimeout(delay);
            delay = 0;
         }
         if(§˧§.§͉§)
         {
            §˧§.setType(0);
         }
      }
      
      protected function log(... rest) : void
      {
         var _loc2_:String = rest.join(" ") + " at: " + getTimer();
         §˦§.unshift(_loc2_);
      }
      
      private function §˯§(param1:Event) : void
      {
         var _loc2_:ProgressEvent = null;
         var _loc4_:SecurityErrorEvent = null;
         var _loc3_:IOErrorEvent = null;
         switch(param1.type)
         {
            case "open":
               log("load open: urlloader start load data");
               §˲§();
               break;
            case "progress":
               _loc2_ = param1 as ProgressEvent;
               log("load progress:",_loc2_.bytesLoaded,"/",_loc2_.bytesTotal);
               §˳§();
               break;
            case "complete":
               log("load complete: urlloader loaded complete");
               §˴§();
               break;
            case "securityError":
               _loc4_ = param1 as SecurityErrorEvent;
               log("load security error:",_loc4_.text);
               §˶§();
               break;
            case "ioError":
               _loc3_ = param1 as IOErrorEvent;
               log("load io error:",_loc3_.text);
               §˷§();
         }
      }
      
      protected function §˰§() : void
      {
         §˧§.setType(1);
         ++§˨§.ɐ;
         §˩§.exec("load_start");
      }
      
      protected function §˱§() : void
      {
         §˧§.setType(4);
         delay = setTimeout(start,ms);
      }
      
      protected function §˲§() : void
      {
         §˧§.setType(2);
         §˩§.exec("load_open");
      }
      
      protected function §˳§() : void
      {
         §˧§.setType(3);
         §˩§.exec("load_progress");
      }
      
      protected function §˴§() : void
      {
         §˧§.setType(6);
         §˵§();
      }
      
      final protected function §˵§() : void
      {
         §˫§ = getTimer();
         §˧§.setType(7);
         §˩§.exec("load_complete");
      }
      
      protected function §˶§() : void
      {
         §˧§.setType(5);
         §˩§.exec("load_security_error");
         §˸§();
      }
      
      protected function §˷§() : void
      {
         §˧§.setType(5);
         §˩§.exec("load_io_error");
         if(§˨§.§˹§)
         {
            §˸§();
         }
         else
         {
            §˱§();
         }
      }
      
      protected function §˸§() : void
      {
         §˫§ = getTimer();
         §˧§.setType(8);
         §˩§.exec("load_fail");
      }
      
      public function get §˹§() : Boolean
      {
         return §˨§.§˹§;
      }
      
      final public function get §˺§() : ByteArray
      {
         return ˤ.data as ByteArray;
      }
      
      public function loadBytes(param1:ByteArray) : void
      {
         ˤ.data = param1;
         §˴§();
      }
      
      public function get progress() : Number
      {
         return §˧§.§͏§ ? 1 : (bytesTotal == 0 ? 0 : §˼§ / bytesTotal);
      }
      
      public function §˻§(param1:int = 1, param2:uint = 2) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return progress.toFixed(param2 * 100) + " %";
            case 1:
               return §˼§ + " / " + (bytesTotal == 0 ? "unknown" : bytesTotal);
            default:
               return progress.toString();
         }
      }
      
      public function get §˼§() : uint
      {
         return ˤ.bytesLoaded;
      }
      
      public function get bytesTotal() : uint
      {
         return ˤ.bytesTotal;
      }
      
      public function get logText() : String
      {
         return §˦§[0] as String;
      }
      
      public function get §˽§() : String
      {
         return §˦§.concat().reverse().join("\n");
      }
      
      public function get ɋ() : Array
      {
         return §˦§;
      }
      
      public function get state() : Ȏ
      {
         return §˧§;
      }
      
      public function get count() : ȋ
      {
         return §˨§;
      }
      
      public function get loadHandle() : ȉ
      {
         return §˩§;
      }
      
      public function §˾§(param1:Function, param2:Boolean = false, param3:int = 0, param4:Boolean = false) : void
      {
         addEventListener("load_progress",param1,param2,param3,param4);
         addEventListener("load_fail",param1,param2,param3,param4);
         addEventListener("load_complete",param1,param2,param3,param4);
      }
      
      public function removeAllListeners(param1:Function, param2:Boolean = false) : void
      {
         removeEventListener("load_progress",param1,param2);
         removeEventListener("load_fail",param1,param2);
         removeEventListener("load_complete",param1,param2);
      }
      
      public function get §˿§() : uint
      {
         return state.§͎§ ? §˫§ - §˪§ : getTimer() - §˪§;
      }
      
      public function get reloadDelay() : uint
      {
         return ms;
      }
      
      public function set reloadDelay(param1:uint) : void
      {
         ms = param1;
      }
   }
}

