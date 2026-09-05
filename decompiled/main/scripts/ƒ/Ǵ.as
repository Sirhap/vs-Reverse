package ƒ
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import Ƿ.Ƕ;
   import ǹ.Ǹ;
   
   public class Ǵ
   {
      
      [Alias(key="118,101,114,115,105,111,110")]
      public static const version:String = "2.0";
      
      private static var Ȝ:DisplayObject;
      
      private static var ț:Ǹ = new Ǹ();
      
      private static var labelXML:XML = <language>
	<!--加载中的提示信息-->
	<progress en="Loading..." zh-CN="正在加载文件" zh-TW="正在加載檔案" ru="погрузка..."/>
	<!--加载被取消提示信息-->
	<unload en="Unloaded" zh-CN="加载被取消" zh-TW="加載被取消" ru="выгружен"/>
	<!--网络问题提示信息-->
	<ioError en="Net error, please refresh to reload!" zh-CN="加载发生错误，如需重新加载请刷新页面" zh-TW="加載發生錯誤，重新加載請刷新頁面" ru="ошибка ввода-вывода"/>
</language>;
      
      public function Ǵ()
      {
         super();
      }
      
      [FrameTask]
      public static function ȝ() : void
      {
         ǵ.ɐ.Ⱦ();
         Ȥ(new Ƕ());
         var _loc1_:ǵ = ǵ.ɐ;
         if(_loc1_.ɉ == false)
         {
            _loc1_.addEventListener("complete",Ȣ);
            _loc1_.addEventListener("progress",Ȣ);
            _loc1_.addEventListener("ioError",Ȣ);
            _loc1_.addEventListener("unload",Ȣ);
            _loc1_.addEventListener("clear",Ȣ);
         }
         _loc1_.addEventListener("throttle",Ƞ);
         _loc1_.addEventListener("activate",ȡ);
         _loc1_.addEventListener("deactivate",ȡ);
      }
      
      private static function Ȟ(param1:Number) : void
      {
         ț.ɥ(param1);
         ȥ(Ȝ,param1,[{
            "key":"progress",
            "type":"property"
         },{
            "key":"setProgress",
            "type":"function"
         }]);
      }
      
      private static function ȟ(param1:String) : void
      {
         ț.ɦ(param1);
         ȥ(Ȝ,param1,[{
            "key":"label",
            "type":"property"
         },{
            "key":"setLabel",
            "type":"function"
         }]);
      }
      
      private static function Ƞ(param1:Event) : void
      {
         ț.ɧ(param1["state"] != "resume");
      }
      
      private static function ȡ(param1:Event) : void
      {
         switch(param1.type)
         {
            case "activate":
               ț.ɨ(true);
               break;
            case "deactivate":
               ț.ɨ(false);
         }
      }
      
      private static function Ȣ(param1:Event) : void
      {
         var _loc2_:ǵ = null;
         switch(param1.type)
         {
            case "clear":
               _loc2_ = ǵ.ɐ;
               _loc2_.removeEventListener("complete",Ȣ);
               _loc2_.removeEventListener("progress",Ȣ);
               _loc2_.removeEventListener("ioError",Ȣ);
               _loc2_.removeEventListener("unload",Ȣ);
               _loc2_.removeEventListener("clear",Ȣ);
               break;
            case "unload":
               ȟ(getLabel("unload"));
               break;
            case "ioError":
               ȟ(getLabel("ioError"));
               break;
            case "init":
            case "progress":
               Ȟ(ǵ.ɐ.loadProgress);
               ȟ(getLabel("progress"));
               break;
            case "complete":
         }
      }
      
      [Alias(key="108,97,110,103,117,97,103,101")]
      public static function get language() : String
      {
         return Capabilities.language;
      }
      
      [Alias(key="114,101,109,111,118,101,80,114,111,103,114,101,115,115,66,97,114")]
      public static function ȣ() : void
      {
         if(Ȝ && Ȝ.parent)
         {
            Ȝ.parent.removeChild(Ȝ);
         }
         Ȝ = null;
      }
      
      private static function uts(... rest) : String
      {
         return "".constructor.fromCharCode.apply(null,rest);
      }
      
      [Alias(key="99,104,97,110,103,101,80,114,111,103,114,101,115,115,66,97,114")]
      public static function Ȥ(param1:DisplayObject, param2:Boolean = true) : void
      {
         var _loc10_:Rectangle = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!param1)
         {
            return;
         }
         ȣ();
         Ȝ = param1;
         Ȝ.name = "progressBar";
         var _loc3_:ǵ = ǵ.ɐ;
         _loc3_.ɂ.addChild(Ȝ);
         var _loc7_:String = "align" in Ȝ ? Ȝ["align"] + "" : "default";
         var _loc9_:Number = _loc3_.stageWidth / 2;
         var _loc8_:Number = _loc3_.stageHeight / 2;
         switch(_loc7_)
         {
            default:
               _loc10_ = Ȝ.parent.getBounds(Ȝ);
               _loc4_ = _loc9_ - (_loc10_.left + _loc10_.width / 2);
               _loc5_ = _loc8_ - (_loc10_.top + _loc10_.height / 2);
               Ȝ.x += _loc4_;
               Ȝ.y += _loc5_;
               break;
            case "center":
               Ȝ.x = _loc9_;
               Ȝ.y = _loc8_;
               break;
            case "auto":
         }
         if(param2)
         {
            Ȟ(ț.ɡ);
            ȟ(ț.ɢ);
         }
      }
      
      [Alias(key="103,101,116,76,97,98,101,108")]
      public static function getLabel(param1:String) : String
      {
         return String(labelXML[param1]["@" + language] || labelXML[param1].@en);
      }
      
      private static function ȥ(param1:*, param2:*, param3:Array) : void
      {
         var _loc8_:int = 0;
         var _loc5_:* = undefined;
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc4_:Boolean = false;
         if(param1 && param3)
         {
            _loc8_ = 0;
            while(_loc8_ < param3.length)
            {
               _loc5_ = param3[_loc8_];
               _loc7_ = _loc5_.key;
               if(_loc7_ in param1)
               {
                  try
                  {
                     switch(_loc6_ = _loc5_.type)
                     {
                        case "property":
                           param1[_loc7_] = param2;
                           break;
                        case "function":
                           param1[_loc7_](param2);
                     }
                     _loc4_ = true;
                  }
                  catch(error:Error)
                  {
                  }
               }
               _loc8_++;
            }
         }
         if(!_loc4_)
         {
            Ȧ("fail to",_loc7_ || "set value",param2);
         }
      }
      
      private static function Ȧ(... rest) : void
      {
         ǵ.ɐ.Ɍ.apply(null,[uts(91,70,65,93)].concat(rest));
      }
      
      [Alias(key="116,104,114,111,116,116,108,101")]
      public static function get ȧ() : Boolean
      {
         return ț.ɣ;
      }
      
      [Alias(key="97,99,116,105,118,101")]
      public static function get active() : Boolean
      {
         return ț.ɤ;
      }
   }
}

