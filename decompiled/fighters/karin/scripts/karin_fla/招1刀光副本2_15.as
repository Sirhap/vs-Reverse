package karin_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol377")]
   public dynamic class 招1刀光副本2_15 extends MovieClip
   {
      
      public var cbs2atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var hitmc:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 招1刀光副本2_15()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,3,this.frame4,4,this.frame5);
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
         this.$attacker_ctrler.move(25,0);
         this.$attacker_ctrler.setHitTarget("hitmc","hit");
         this.$attacker_ctrler.setCrossMap(true);
      }
      
      internal function frame4() : *
      {
         this.$attacker_ctrler.stop();
      }
      
      internal function frame5() : *
      {
         this.$attacker_ctrler.move(0,0);
         this.$attacker_ctrler.moveToTarget(0);
      }
   }
}

