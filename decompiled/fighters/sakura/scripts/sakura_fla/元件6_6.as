package sakura_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol187")]
   public dynamic class 元件6_6 extends MovieClip
   {
      
      public var kj11atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 元件6_6()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,5,this.frame6,9,this.frame10,14,this.frame15,24,this.frame25);
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
         this.$attacker_ctrler.move(12,-7);
         this.$attacker_ctrler.damping(0,1);
      }
      
      internal function frame6() : *
      {
         this.$attacker_ctrler.setTouchFloor("touchfloor");
      }
      
      internal function frame10() : *
      {
         this.$attacker_ctrler.stop();
      }
      
      internal function frame15() : *
      {
         this.$attacker_ctrler.move(0,0);
         this.$attacker_ctrler.effect.shake(0,3);
      }
      
      internal function frame25() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

