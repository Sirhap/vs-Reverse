package net.play5d.game.bvn.web
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import net.play5d.game.bvn.ctrl.SoundCtrl;
   
   public class SubmitScoreBtn extends Sprite
   {
      
      private var _asset:Class = §submitscore_png$2019b938d40548ede75322f262e40e85-2138765347§;
      
      private var _png:Bitmap;
      
      private var _highCt:ColorTransform;
      
      public function SubmitScoreBtn(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.buttonMode = true;
         this.mouseChildren = false;
         var _loc3_:Bitmap = new _asset();
         _loc3_.smoothing = true;
         addChild(_loc3_);
         _png = _loc3_;
         _highCt = new ColorTransform();
         _highCt.redOffset = _highCt.blueOffset = _highCt.greenOffset = 30;
         this.addEventListener("click",mouseHandler);
         this.addEventListener("mouseUp",mouseHandler);
         this.addEventListener("mouseDown",mouseHandler);
         this.addEventListener("mouseOver",mouseHandler);
         this.addEventListener("mouseOut",mouseHandler);
      }
      
      private function mouseHandler(param1:MouseEvent) : void
      {
         switch(param1.type)
         {
            case "mouseOver":
               _png.transform.colorTransform = _highCt;
               SoundCtrl.I.sndSelect();
               break;
            case "mouseOut":
               _png.transform.colorTransform = new ColorTransform();
               break;
            case "mouseDown":
               _png.y = 5;
               break;
            case "mouseUp":
               _png.y = 0;
               _png.alpha = 1;
               break;
            case "click":
               SoundCtrl.I.sndConfrim();
               Ctrler4399.submitScore();
         }
      }
   }
}

