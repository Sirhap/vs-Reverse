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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol195")]
   public dynamic class Timeline_7 extends MovieClip
   {
      
      public var zh3atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function Timeline_7()
      {
         super();
         addFrameScript(0,this.frame1,3,this.frame4);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame4() : *
      {
         this.$attacker_ctrler.stopFollowTarget();
      }
   }
}

