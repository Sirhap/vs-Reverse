package com.green.net
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import Ȋ.Ǵ;
   
   use namespace Ǵ;
   
   public class Ǿ extends ǽ
   {
      
      protected var §̂§:LoaderContext;
      
      protected var loader:Loader;
      
      private var parent:DisplayObjectContainer;
      
      private var §̃§:Boolean;
      
      public function Ǿ(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         §̂§ = new LoaderContext();
         loader = new Loader();
         super.init();
      }
      
      override protected function ˮ(param1:Object) : void
      {
         if("applicationDomain" in param1)
         {
            §̂§.applicationDomain = param1.applicationDomain;
            delete param1.applicationDomain;
         }
         if("allowCodeImport" in param1 && "allowCodeImport" in §̂§)
         {
            §̂§.allowCodeImport = param1.allowCodeImport;
         }
         if("parent" in param1)
         {
            container = param1.parent;
         }
         super.ˮ(param1);
      }
      
      override protected function §˴§() : void
      {
         load_bytes(§˺§);
      }
      
      private function load_bytes(param1:ByteArray) : void
      {
         §̃§ = true;
         loader.contentLoaderInfo.addEventListener("ioError",§̄§);
         loader.contentLoaderInfo.addEventListener("complete",§̄§);
         try
         {
            loader.loadBytes(param1,§̂§);
         }
         catch(e:Error)
         {
            §̃§ = false;
            log("deal error:",e.message);
            §˩§.exec("load_deal_error");
            §˸§();
         }
      }
      
      private function §̄§(param1:Event) : void
      {
         var _loc2_:IOErrorEvent = null;
         switch(param1.type)
         {
            case "complete":
               §̃§ = false;
               log("deal complete: loader loaded the bytearray");
               if(!("requestedContentParenu" in §̂§) && parent)
               {
                  parent.addChild(content);
               }
               §˵§();
               break;
            case "ioError":
               §̃§ = false;
               _loc2_ = param1 as IOErrorEvent;
               log("deal error:",_loc2_.text);
               §˩§.exec("load_deal_error");
               §˸§();
         }
      }
      
      public function get content() : DisplayObject
      {
         return loader.content;
      }
      
      public function set container(param1:DisplayObjectContainer) : void
      {
         parent = param1;
         if("requestedContentParenu" in §̂§)
         {
            §̂§.requestedContentParenu = parent;
         }
      }
      
      public function get container() : DisplayObjectContainer
      {
         return "requestedContentParenu" in §̂§ ? §̂§.requestedContentParenu : parent;
      }
      
      public function get §̅§() : LoaderContext
      {
         return §̂§;
      }
      
      override public function stop() : void
      {
         if(§̃§)
         {
            loader.close();
         }
         super.stop();
      }
      
      public function get loaderInfo() : LoaderInfo
      {
         return loader.contentLoaderInfo;
      }
   }
}

