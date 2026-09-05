package jiraiya_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol146")]
   public dynamic class 元件15_5 extends MovieClip
   {
      
      public var kj12atm:MovieClip;
      
      public var kj1atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 元件15_5()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,3,this.frame4,8,this.frame9,9,this.frame10);
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
         this.$attacker_ctrler.move(10,-10);
         this.$attacker_ctrler.damping(0,0.5);
      }
      
      internal function frame4() : *
      {
         this.$attacker_ctrler.setTouchFloor("hitfloor");
      }
      
      internal function frame9() : *
      {
         this.$attacker_ctrler.stop();
      }
      
      internal function frame10() : *
      {
         this.$attacker_ctrler.effect.shake(0,3);
         this.$attacker_ctrler.move(0,0);
      }
   }
}

