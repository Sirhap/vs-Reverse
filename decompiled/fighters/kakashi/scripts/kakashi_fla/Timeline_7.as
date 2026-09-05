package kakashi_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol172")]
   public dynamic class Timeline_7 extends MovieClip
   {
      
      public var zh2atm:MovieClip;
      
      public var zh20atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function Timeline_7()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,16,this.frame17,29,this.frame30,39,this.frame40,61,this.frame62,62,this.frame63);
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
         this.$attacker_ctrler.move(20,0);
         this.$attacker_ctrler.setHitTarget("zh20atm","hit");
      }
      
      internal function frame17() : *
      {
         this.$attacker_ctrler.damping(5,0);
      }
      
      internal function frame30() : *
      {
         this.$attacker_ctrler.move(15,0);
      }
      
      internal function frame40() : *
      {
         this.$attacker_ctrler.damping(5,0);
      }
      
      internal function frame62() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
      
      internal function frame63() : *
      {
         this.$attacker_ctrler.damping(5,0);
      }
   }
}

