package pain_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol308")]
   public dynamic class 招2效果_20 extends MovieClip
   {
      
      public var zh20atm:MovieClip;
      
      public var zh2atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 招2效果_20()
      {
         super();
         addFrameScript(0,this.frame1,11,this.frame12,24,this.frame25,37,this.frame38,38,this.frame39,41,this.frame42);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame12() : *
      {
         this.$attacker_ctrler.move(15,0);
         this.$attacker_ctrler.setHitTarget("zh20atm","hit");
      }
      
      internal function frame25() : *
      {
         this.$attacker_ctrler.damping(15);
      }
      
      internal function frame38() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
      
      internal function frame39() : *
      {
         this.$attacker_ctrler.move(20,0);
         this.$attacker_ctrler.damping(5,0);
      }
      
      internal function frame42() : *
      {
         this.$attacker_ctrler.damping(20);
         this.$attacker_ctrler.endAct();
      }
   }
}

