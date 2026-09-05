package naruto_xr_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol381")]
   public dynamic class 空中必杀特效_11 extends MovieClip
   {
      
      public var kbs1atm:MovieClip;
      
      public var kbs2atm:MovieClip;
      
      public var kbsatm:MovieClip;
      
      public var main:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 空中必杀特效_11()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,3,this.frame4,4,this.frame5,44,this.frame45,49,this.frame50);
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
         this.$attacker_ctrler.move(20,20);
         this.$attacker_ctrler.setHitTarget("main","hit");
         this.$attacker_ctrler.setTouchFloor("hit_floor");
      }
      
      internal function frame4() : *
      {
         this.$attacker_ctrler.stop();
      }
      
      internal function frame5() : *
      {
         this.$attacker_ctrler.move(0,0);
         this.$attacker_ctrler.setTouchFloor(null);
      }
      
      internal function frame45() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
      
      internal function frame50() : *
      {
         this.$attacker_ctrler.move(0,0);
         this.$attacker_ctrler.effect.shake(0,3);
      }
   }
}

