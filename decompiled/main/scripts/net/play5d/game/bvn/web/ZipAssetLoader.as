package net.play5d.game.bvn.web
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.media.Sound;
   import net.play5d.game.bvn.interfaces.IAssetLoader;
   import net.play5d.kyo.utils.setFrameOut;
   
   public class ZipAssetLoader implements IAssetLoader
   {
      
      public function ZipAssetLoader()
      {
         super();
      }
      
      public function loadXML(param1:String, param2:Function, param3:Function = null) : void
      {
         var _loc4_:XML = ZipCtrler.I.getXML(param1);
         if(_loc4_)
         {
            doNextFrame(param2,_loc4_);
         }
         else
         {
            doNextFrame(param3);
         }
      }
      
      public function loadSwf(param1:String, param2:Function, param3:Function = null, param4:Function = null) : void
      {
         var url:String = param1;
         var back:Function = param2;
         var fail:Function = param3;
         var process:Function = param4;
         var loadCom:* = function(param1:Event):void
         {
            loader.contentLoaderInfo.removeEventListener("complete",loadCom);
            if(process != null)
            {
               process(1);
            }
            if(back != null)
            {
               back(loader);
            }
         };
         var loader:Loader = ZipCtrler.I.getLoader(url);
         if(!loader)
         {
            doNextFrame(fail);
            return;
         }
         loader.contentLoaderInfo.addEventListener("complete",loadCom);
      }
      
      public function loadBitmap(param1:String, param2:Function, param3:Function = null, param4:Function = null) : void
      {
         var url:String = param1;
         var back:Function = param2;
         var fail:Function = param3;
         var process:Function = param4;
         var loadCom:* = function(param1:Event):void
         {
            loader.contentLoaderInfo.removeEventListener("complete",loadCom);
            if(process != null)
            {
               process(1);
            }
            if(back != null)
            {
               back(loader.content);
            }
         };
         var loader:Loader = ZipCtrler.I.getLoader(url);
         if(!loader)
         {
            doNextFrame(fail);
            return;
         }
         loader.contentLoaderInfo.addEventListener("complete",loadCom);
      }
      
      public function loadSound(param1:String, param2:Function, param3:Function = null, param4:Function = null) : void
      {
         var url:String = param1;
         var back:Function = param2;
         var fail:Function = param3;
         var process:Function = param4;
         var sound:Sound = ZipCtrler.I.getSound(url);
         if(sound)
         {
            doNextFrame(function():void
            {
               if(back != null)
               {
                  back(sound);
               }
               if(process != null)
               {
                  process(1);
               }
            });
         }
         else
         {
            doNextFrame(fail);
         }
      }
      
      public function dispose(param1:String) : void
      {
         ZipCtrler.I.removeFile(param1);
      }
      
      private function doNextFrame(param1:Function, ... rest) : void
      {
         var func:Function = param1;
         var params:Array = rest;
         if(func == null)
         {
            return;
         }
         setFrameOut(function():void
         {
            func.apply(null,params);
         },1,bleachvsnaruto.STAGE);
      }
      
      public function needPreLoad() : Boolean
      {
         return true;
      }
      
      public function loadPreLoad(param1:Function, param2:Function = null, param3:Function = null) : void
      {
         ZipCtrler.I.init(param1,param3);
      }
   }
}

