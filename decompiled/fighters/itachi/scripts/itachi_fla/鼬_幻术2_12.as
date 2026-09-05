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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol285")]
   public dynamic class 鼬_幻术2_12 extends MovieClip
   {
      
      public var zh21atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var zh30atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 鼬_幻术2_12()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3,24,this.frame25,25,this.frame26,42,this.frame43);
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
         this.$attacker_ctrler.move(15,0);
         this.$attacker_ctrler.setHitTarget("zh30atm","hit");
      }
      
      internal function frame25() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
      
      internal function frame26() : *
      {
         this.$attacker_ctrler.move(5,-10);
         this.$attacker_ctrler.damping(1,0.5);
      }
      
      internal function frame43() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

