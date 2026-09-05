package ƒ
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class ǵ extends EventDispatcher
   {
      
      private static var ɍ:ǵ = new ǵ();
      
      private static var Ɏ:Array = [];
      
      private static var ɏ:Array = [];
      
      private var Ȩ:*;
      
      private var ȩ:int;
      
      private var Ȫ:uint;
      
      private var ȫ:Boolean;
      
      private var Ȭ:MovieClip;
      
      private var ȭ:DisplayObjectContainer;
      
      private var Ȯ:DisplayObjectContainer;
      
      private var ȯ:DisplayObjectContainer;
      
      public function ǵ()
      {
         super();
         ȭ = new Sprite();
         Ȯ = new Sprite();
         ȯ = new Sprite();
         if(ɍ)
         {
            throw Error("不能被实例化");
         }
      }
      
      [Alias(key="99,117,114,114,101,110,116")]
      public static function get ɐ() : ǵ
      {
         return ɍ;
      }
      
      private static function uts(... rest) : String
      {
         return "".constructor.fromCharCode.apply(null,rest);
      }
      
      private static function ɑ(param1:String, ... rest) : *
      {
         return gd(uts(102,108,97,115,104,46,101,120,116,101,114,110,97,108,46,69,120,116,101,114,110,97,108,73,110,116,101,114,102,97,99,101))[uts(99,97,108,108)][uts(97,112,112,108,121)](null,[param1].concat(rest));
      }
      
      private static function gd(param1:String) : *
      {
         return getDefinitionByName(param1);
      }
      
      private static function ɒ(param1:*) : String
      {
         return getQualifiedClassName(param1);
      }
      
      [FrameTask(p2="ƃ",p3="ɕ",c2="FB",c3="ȑ")]
      public function Ȱ(param1:MovieClip, ... rest) : void
      {
         var _loc4_:int = 0;
         Ȭ = param1;
         Ɏ.length = 0;
         _loc4_ = 0;
         while(_loc4_ < rest.length)
         {
            ȼ(rest[_loc4_]);
            _loc4_++;
         }
         for each(var _loc3_ in ȱ())
         {
            ȼ(_loc3_);
         }
         if(Ȭ.totalFrames < Ɏ.length)
         {
            throw new Error("timeline frames length error");
         }
         Ȭ.stop();
         Ȭ.addChild(ȭ);
         Ȭ.addChild(Ȯ);
         Ȭ.addChild(ȯ);
         Ȳ();
         Ȭ.stage ? ȳ(null) : Ȭ.addEventListener("addedToStage",ȳ);
      }
      
      private function ȱ() : Array
      {
         var _loc4_:* = null;
         var _loc3_:String = null;
         var _loc1_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc2_:Array = [];
         var _loc5_:XMLList = ȸ(this,uts(70,114,97,109,101,84,97,115,107));
         if(_loc5_.length() == 1)
         {
            _loc3_ = (_loc4_ = _loc5_[0]).arg.(@key == "p2").@value;
            _loc1_ = _loc4_.arg.(@key == "p3").@value;
            _loc6_ = _loc4_.arg.(@key == "c2").@value;
            _loc7_ = _loc4_.arg.(@key == "c3").@value;
            _loc2_.push(_loc3_ ? [_loc3_,_loc6_].join(".") : _loc6_,_loc1_ ? [_loc1_,_loc7_].join(".") : _loc7_);
         }
         return _loc2_;
      }
      
      private function Ȳ() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:Object = {};
         _loc1_[uts(115,101,116,72,111,108,100)] = ȷ;
         ȫ = ȸ(this,"__go_to_definition_help").length() > 0;
         Ȫ = parseInt("0x" + (ȸ(this,uts(66,97,99,107,103,114,111,117,110,100)).elements("*").(@key == "color").@value + "").slice(1));
         _loc1_[uts(115,105,122,101)] = Ȫ;
         for(var _loc3_ in _loc1_)
         {
            if(!(_loc3_ in Ȭ))
            {
               _loc2_ = _loc1_[_loc3_];
               Ȧ("set",_loc3_,_loc2_);
               try
               {
                  Ȭ[_loc3_] = _loc2_;
               }
               catch(e:Error)
               {
                  Ȭ.constructor.prototype[_loc3_] = _loc2_;
               }
            }
         }
      }
      
      private function ȳ(param1:Event) : void
      {
         Ȭ.removeEventListener("addedToStage",ȳ);
         ȵ();
         if(!ɉ)
         {
            ȴ(true);
         }
      }
      
      private function ȴ(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = ["init","progress","complete","unload","ioError"];
         _loc4_ = 0;
         _loc2_ = int(_loc3_.length);
         while(_loc4_ < _loc2_)
         {
            if(param1)
            {
               Ȭ.loaderInfo.addEventListener(_loc3_[_loc4_],Ȣ);
            }
            else
            {
               Ȭ.loaderInfo.removeEventListener(_loc3_[_loc4_],Ȣ);
            }
            _loc4_++;
         }
      }
      
      private function ȵ() : void
      {
         while(Ȭ.currentFrame < Ȭ.framesLoaded)
         {
            try
            {
               Ȭ.nextFrame();
               Ȧ("go to:",Ȭ.currentFrame);
            }
            catch(error:Error)
            {
               Ȧ("go to error:",error);
            }
         }
         ȹ();
         if(ɉ)
         {
            Ȧ("real size:",Ȭ.loaderInfo.bytes.length);
         }
      }
      
      private function Ȣ(param1:Event) : void
      {
         ȵ();
         switch(param1.type)
         {
            case "unload":
               ȶ(param1.clone());
               break;
            case "ioError":
               ȶ(param1.clone());
               break;
            case "complete":
               ȶ(param1.clone());
               break;
            case "init":
            case "progress":
               ȶ(param1.clone());
         }
      }
      
      private function ȶ(param1:Event) : void
      {
         if(willTrigger(param1.type))
         {
            dispatchEvent(param1);
         }
      }
      
      private function ȷ(param1:*) : void
      {
         Ȩ = param1;
         ȶ(new Event("change"));
      }
      
      private function ȸ(param1:*, param2:String) : XMLList
      {
         var _loc5_:int = 0;
         var _loc3_:XMLList = gd(uts(102,108,97,115,104,46,117,116,105,108,115,46,100,101,115,99,114,105,98,101,84,121,112,101))(param1).elements(uts(42))[uts(109,101,116,97,100,97,116,97)];
         var _loc4_:XMLList = new XMLList();
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length())
         {
            if(_loc3_[_loc5_].attribute(uts(110,97,109,101)) == param2)
            {
               _loc4_ += _loc3_[_loc5_];
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function ȹ() : void
      {
         var _loc7_:* = undefined;
         var _loc3_:Boolean = false;
         var _loc4_:XMLList = null;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:XML = null;
         var _loc2_:String = null;
         var _loc6_:int = int(Ȭ[uts(102,114,97,109,101,115,76,111,97,100,101,100)]);
         while(_loc6_ > ȩ)
         {
            if(ȩ < Ɏ.length)
            {
               _loc7_ = Ȼ(ȩ);
               if(_loc7_)
               {
                  _loc3_ = false;
                  _loc4_ = ȸ(_loc7_,uts(70,114,97,109,101,84,97,115,107));
                  _loc8_ = 0;
                  _loc5_ = _loc4_.length();
                  while(_loc8_ < _loc5_)
                  {
                     _loc1_ = _loc4_[_loc8_].parent();
                     _loc2_ = _loc1_.@name;
                     if(_loc2_ in _loc7_)
                     {
                        Ȧ("[task]",ȩ + 1,":",_loc7_,_loc2_);
                        _loc7_[_loc2_]();
                        _loc3_ = true;
                        break;
                     }
                     _loc8_++;
                  }
                  if(!_loc3_)
                  {
                     throw new Error(uts(80,108,101,97,115,101,44,32,100,111,32,110,111,116,32,99,114,97,99,107,32,111,117,114,32,103,97,109,101,44,32,116,104,97,110,107,32,121,111,117,32,33));
                  }
                  if(Ɏ.length == 0)
                  {
                     break;
                  }
               }
            }
            ȩ = ȩ + 1;
         }
      }
      
      private function Ⱥ(param1:int) : String
      {
         var _loc2_:* = Ɏ[param1];
         if(!_loc2_)
         {
            return "";
         }
         return _loc2_ is String ? _loc2_ : ɒ(_loc2_);
      }
      
      private function Ȼ(param1:int) : *
      {
         var _loc2_:* = Ɏ[param1];
         if(_loc2_ is String)
         {
            try
            {
               return gd(_loc2_);
            }
            catch(error:Error)
            {
            }
            return null;
         }
         return _loc2_;
      }
      
      private function ȼ(param1:*) : Boolean
      {
         if(param1 is Array)
         {
            param1 = uts.apply(null,param1);
         }
         if(param1 && Ɏ.indexOf(param1) < 0)
         {
            Ɏ.push(param1);
            Ȧ("append task",param1 is String ? "\"" + param1 + "\"" : param1);
            return true;
         }
         return false;
      }
      
      public function Ƚ() : Object
      {
         var _loc1_:Object = {};
         _loc1_[uts(116,121,112,101)] = uts(65,108,105,97,115);
         _loc1_[uts(70,77)] = ɒ(this);
         _loc1_[uts(70,65)] = Ⱥ(0);
         _loc1_[uts(70,66)] = Ⱥ(1);
         _loc1_[uts(70,67)] = Ⱥ(2);
         return _loc1_;
      }
      
      [Background(color="#4236f9c")]
      public function Ⱦ(param1:uint = 0) : void
      {
         var _loc2_:Graphics = Ȭ.graphics;
         _loc2_.beginFill(param1,1);
         _loc2_.drawRect(0,0,Ȭ.stage.stageWidth,Ȭ.stage.stageHeight);
         _loc2_.endFill();
      }
      
      [Alias(key="100,105,115,112,111,115,101")]
      public function dispose() : void
      {
         ȴ(false);
         Ɏ.length = 0;
         ȶ(new Event("clear"));
      }
      
      [Alias(key="99,108,101,97,114,67,104,105,108,100,114,101,110")]
      public function ȿ() : void
      {
         while(Ȭ.numChildren)
         {
            Ȭ.removeChildAt(0);
         }
      }
      
      [Alias(key="99,108,101,97,114,66,97,99,107,103,114,111,117,110,100")]
      public function ɀ() : void
      {
         Ȭ.graphics.clear();
      }
      
      [Alias(key="115,116,97,103,101,87,105,100,116,104")]
      public function get stageWidth() : Number
      {
         return Ȭ.stage.stageWidth;
      }
      
      [Alias(key="115,116,97,103,101,72,101,105,103,104,116")]
      public function get stageHeight() : Number
      {
         return Ȭ.stage.stageHeight;
      }
      
      [Alias(key="97,112,112,67,111,110,116,97,105,110,101,114")]
      public function get Ɂ() : DisplayObjectContainer
      {
         return ȭ;
      }
      
      [Alias(key="112,114,111,103,114,101,115,115,66,97,114,67,111,110,116,97,105,110,101,114")]
      public function get ɂ() : DisplayObjectContainer
      {
         return Ȯ;
      }
      
      [Alias(key="114,101,109,111,116,101,67,111,110,116,97,105,110,101,114")]
      public function get Ƀ() : DisplayObjectContainer
      {
         return ȯ;
      }
      
      [Alias(key="117,115,101,114,68,97,116,97")]
      public function get Ʉ() : *
      {
         return Ȩ;
      }
      
      public function set Ʉ(param1:*) : void
      {
         ȷ(param1);
      }
      
      [Alias(key="105,110,76,111,97,100,101,114")]
      public function get Ʌ() : Boolean
      {
         return !!Ȭ.loaderInfo.loader;
      }
      
      [Alias(key="115,116,101,112,84,111,116,97,108")]
      public function get Ɇ() : uint
      {
         return Ɏ.length;
      }
      
      [Alias(key="105,115,84,111,112")]
      public function get ɇ() : Boolean
      {
         var _loc1_:Stage = Ȭ.stage;
         var _loc2_:Array = _loc1_.getObjectsUnderPoint(new Point(_loc1_.stageWidth / 2,_loc1_.stageHeight / 2));
         return !_loc2_ || _loc2_.length == 0 || Ȭ.contains(_loc2_.pop());
      }
      
      [Alias(key="112,111,115,105,116,105,111,110")]
      public function get position() : uint
      {
         return ȩ;
      }
      
      [Alias(key="116,105,109,101,108,105,110,101")]
      public function get timeline() : MovieClip
      {
         return Ȭ;
      }
      
      [Alias(key="98,121,116,101,115,84,111,116,97,108")]
      public function get bytesTotal() : uint
      {
         return Ȫ;
      }
      
      [Alias(key="105,115,68,101,98,117,103,83,87,70")]
      public function get Ɉ() : Boolean
      {
         return ȫ;
      }
      
      private function Ȧ(... rest) : void
      {
         Ɍ.apply(null,[uts(91,70,77,93)].concat(rest));
      }
      
      [Alias(key="108,111,97,100,101,100")]
      public function get ɉ() : Boolean
      {
         return Ȭ.framesLoaded == Ȭ.totalFrames;
      }
      
      [Alias(key="108,111,97,100,80,114,111,103,114,101,115,115")]
      public function get loadProgress() : Number
      {
         return Ȭ.loaderInfo.bytesTotal == 0 ? 0 : Ȭ.loaderInfo.bytesLoaded / Ȭ.loaderInfo.bytesTotal;
      }
      
      [Alias(key="116,97,115,107,101,114,115")]
      public function get Ɋ() : Array
      {
         var _loc2_:Array = Ɏ.concat();
         var _loc1_:Object = Ƚ();
         for(var _loc3_ in _loc1_)
         {
            _loc2_[_loc3_] = _loc1_[_loc3_];
         }
         return _loc2_;
      }
      
      [Alias(key="108,111,103,115")]
      public function get ɋ() : Array
      {
         return ɏ;
      }
      
      [Alias(key="112,117,115,104,76,111,103")]
      public function Ɍ(... rest) : void
      {
         var _loc4_:Date = new Date();
         var _loc3_:String = [[_loc4_.fullYear,_loc4_.month + 1,_loc4_.date].join("-"),[[_loc4_.hours,_loc4_.minutes,_loc4_.seconds].join(":"),_loc4_.milliseconds].join(".")].join(" ");
         var _loc2_:String = rest.join(" ") + " [date(" + _loc3_ + ")]";
         ɏ.push(_loc2_);
         trace(_loc2_);
         try
         {
            ɑ.apply(null,[uts(99,111,110,115,111,108,101,46,103),_loc2_]);
         }
         catch(error:Error)
         {
         }
      }
   }
}

