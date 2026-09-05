package net.play5d.game.bvn.web
{
   import deng.fzip.FZip;
   import deng.fzip.FZipFile;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.utils.ByteArray;
   
   public class ZipCtrler
   {
      
      private static var _i:ZipCtrler;
      
      private var _embedZip:Class = assets_zip$1de7dd7d6855592a2a2b869bcaf19a4b1288174545;
      
      private var _zipBytes:ByteArray;
      
      private var _fZip:FZip;
      
      private var _zipAssetLoader:ZipAssetLoader;
      
      public function ZipCtrler()
      {
         super();
      }
      
      public static function get I() : ZipCtrler
      {
         if(!_i)
         {
            _i = new ZipCtrler();
         }
         return _i;
      }
      
      public function init(param1:Function, param2:Function = null) : void
      {
         var back:Function = param1;
         var process:Function = param2;
         var onZipComplete:* = function(param1:Event):void
         {
            _fZip.removeEventListener("complete",onZipComplete);
            _zipBytes.clear();
            _zipBytes = null;
            _embedZip = null;
            if(back != null)
            {
               back();
            }
         };
         var onZipProcess:* = function(param1:ProgressEvent):void
         {
            if(Boolean(process))
            {
               process(param1.bytesLoaded / param1.bytesTotal);
            }
         };
         _zipBytes = new _embedZip();
         _fZip = new FZip();
         _fZip.addEventListener("complete",onZipComplete);
         _fZip.addEventListener("progress",onZipProcess);
         _fZip.loadBytesStep(_zipBytes,20);
      }
      
      public function getLoader(param1:String) : Loader
      {
         var _loc2_:FZipFile = null;
         var _loc3_:Loader = new Loader();
         try
         {
            _loc2_ = _fZip.getFileByName(param1);
            _loc3_.loadBytes(_loc2_.content);
         }
         catch(e:Error)
         {
            trace("ZipCtrler.getLoader Error ::",e);
            _loc3_ = null;
         }
         return _loc3_;
      }
      
      public function removeFile(param1:String) : void
      {
         trace("remove file from zip :",param1);
         _fZip.removeFileByName(param1);
      }
      
      public function getText(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:FZipFile = null;
         var _loc2_:ByteArray = null;
         try
         {
            _loc4_ = _fZip.getFileByName(param1);
            _loc2_ = _loc4_.content;
            _loc2_.position = 0;
            _loc3_ = _loc2_.readUTFBytes(_loc2_.bytesAvailable);
         }
         catch(e:Error)
         {
            trace("ZipCtrler.getText Error ::",e);
         }
         return _loc3_;
      }
      
      public function getSound(param1:String) : Sound
      {
         var _loc4_:Sound = null;
         var _loc3_:FZipFile = null;
         var _loc2_:ByteArray = null;
         try
         {
            _loc3_ = _fZip.getFileByName(param1);
            _loc2_ = _loc3_.content;
            _loc2_.position = 0;
            _loc4_ = new Sound();
            _loc4_.loadCompressedDataFromByteArray(_loc2_,_loc2_.bytesAvailable);
         }
         catch(e:Error)
         {
            trace("ZipCtrler.getSound Error ::",e);
         }
         return _loc4_;
      }
      
      public function getXML(param1:String) : XML
      {
         var _loc2_:String = getText(param1);
         return new XML(_loc2_);
      }
   }
}

