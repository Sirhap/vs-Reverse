package sasuke_xz_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol319")]
   public dynamic class 加具土命效果_15 extends MovieClip
   {
      
      public var bsatm:MovieClip;
      
      public var mian:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 加具土命效果_15()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,23,this.frame24,24,this.frame25,27,this.frame28);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame2() : *
      {
         this.$attacker_ctrler.move(13,0);
         this.$attacker_ctrler.setHitTarget("mian","hit");
      }
      
      internal function frame24() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
      
      internal function frame25() : *
      {
         this.$attacker_ctrler.move(5,0);
         this.$attacker_ctrler.damping(0.1,0);
      }
      
      internal function frame28() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

