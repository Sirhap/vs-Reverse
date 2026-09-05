package itachi_fla
{
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol169")]
   public dynamic class 鼬_幻术1_9 extends MovieClip
   {
      
      public var kj1atm:MovieClip;
      
      public var zh30atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 鼬_幻术1_9()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3,50,this.frame51,51,this.frame52,57,this.frame58);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame3() : *
      {
         this.$attacker_ctrler.move(3,0);
         this.$attacker_ctrler.setHitTarget("zh30atm","hit");
      }
      
      internal function frame51() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
      
      internal function frame52() : *
      {
         this.$attacker_ctrler.damping(4);
      }
      
      internal function frame58() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

