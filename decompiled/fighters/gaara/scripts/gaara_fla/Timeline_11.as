package gaara_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol468")]
   public dynamic class Timeline_11 extends MovieClip
   {
      
      public var cbsatm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var cbs3atm:MovieClip;
      
      public var cbs2atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function Timeline_11()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,61,this.frame62,108,this.frame109);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame10() : *
      {
         this.$attacker_ctrler.stop();
      }
      
      internal function frame62() : *
      {
         this.$attacker_ctrler.owner_fighter_ctrler.setTargetVelocity(0,-0.1);
         this.$attacker_ctrler.owner_fighter_ctrler.setTargetDamping(0,0);
      }
      
      internal function frame109() : *
      {
         this.$attacker_ctrler.gotoAndPlay("end");
      }
   }
}

