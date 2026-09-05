package Ƿ
{
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class Ƕ extends Sprite
   {
      
      public static var ɝ:uint = 16777215;
      
      private var ɓ:Array;
      
      private var loading:Array;
      
      private var ɔ:int;
      
      private var ɕ:Number;
      
      private var ɖ:uint;
      
      private var ɗ:Number;
      
      public function Ƕ(param1:Number = 25, param2:Number = 3, param3:uint = 268435455)
      {
         var _loc4_:int = 0;
         loading = [0,0.2,1.5,1.86,3.4,3.6,5];
         super();
         ɗ = param1;
         ɕ = param2;
         ɖ = param3 > 16777215 ? ɝ : param3;
         ɓ = [];
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            ɓ.push(addChild(new Shape()));
            _loc4_++;
         }
         ə();
         addEventListener("addedToStage",onAdded);
      }
      
      private function onAdded(param1:Event) : void
      {
         addEventListener("removedFromStage",onRemove);
         ɔ = getTimer();
         play();
      }
      
      private function onUpdate(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = getTimer() - ɔ;
         var _loc2_:Number = _loc3_ / 1000 % loading[loading.length - 1];
         _loc4_ = 0;
         while(_loc4_ < ɓ.length)
         {
            ɘ(ɓ[_loc4_],_loc2_ - 0.2 * _loc4_);
            _loc4_++;
         }
      }
      
      private function ɘ(param1:DisplayObject, param2:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:int = 0;
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc11_:int = 0;
         var _loc9_:Number = NaN;
         _loc11_ = 0;
         while(_loc11_ < loading.length)
         {
            _loc9_ = Number(loading[_loc11_]);
            if(param2 < _loc9_)
            {
               break;
            }
            _loc3_ = _loc9_;
            _loc8_ = _loc11_ + 1;
            _loc7_ = Number(loading[_loc8_]);
            _loc11_++;
         }
         var _loc5_:Number = (param2 - _loc3_) / (_loc7_ - _loc3_);
         switch(_loc8_ - 1)
         {
            case 0:
               _loc4_ = -30 + 60 * _loc5_;
               _loc6_ = _loc5_;
               break;
            case 1:
               _loc4_ = 30 + 240 * _loc5_;
               _loc6_ = 1;
               break;
            case 2:
               _loc4_ = -90 + 150 * _loc5_;
               _loc6_ = 1;
               break;
            case 3:
               _loc4_ = 60 + 210 * _loc5_;
               _loc6_ = 1;
               break;
            case 4:
               _loc4_ = -90 + 90 * _loc5_;
               _loc6_ = 1 - _loc5_;
               break;
            default:
               _loc4_ = 0;
               _loc6_ = 0;
         }
         param1.alpha = _loc6_;
         param1.rotation = _loc4_;
      }
      
      private function ə() : void
      {
         var _loc1_:Shape = null;
         var _loc2_:int = 0;
         graphics.clear();
         graphics.beginFill(0,0);
         graphics.drawCircle(0,0,ɗ + ɕ);
         graphics.endFill();
         _loc2_ = 0;
         while(_loc2_ < ɓ.length)
         {
            _loc1_ = ɓ[_loc2_];
            _loc1_.graphics.clear();
            _loc1_.graphics.beginFill(ɖ);
            _loc1_.graphics.drawCircle(0,ɗ,ɕ);
            _loc1_.graphics.endFill();
            _loc1_.alpha = 0;
            _loc2_++;
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         auto();
      }
      
      override public function set alpha(param1:Number) : void
      {
         super.alpha = param1;
         auto();
      }
      
      private function auto() : void
      {
         if(stage && alpha > 0 && visible)
         {
            play();
         }
         else
         {
            stop();
         }
      }
      
      private function play() : void
      {
         addEventListener("enterFrame",onUpdate);
      }
      
      private function stop() : void
      {
         removeEventListener("enterFrame",onUpdate);
      }
      
      private function onRemove(param1:Event) : void
      {
         stop();
      }
      
      public function get ɚ() : Number
      {
         return ɕ;
      }
      
      public function set ɚ(param1:Number) : void
      {
         ɕ = param1;
         ə();
      }
      
      public function get ɛ() : uint
      {
         return ɖ;
      }
      
      public function set ɛ(param1:uint) : void
      {
         ɖ = param1;
         ə();
      }
      
      public function get ɜ() : Number
      {
         return ɗ;
      }
      
      public function set ɜ(param1:Number) : void
      {
         ɗ = param1;
         ə();
      }
      
      public function get align() : String
      {
         return "center";
      }
   }
}

