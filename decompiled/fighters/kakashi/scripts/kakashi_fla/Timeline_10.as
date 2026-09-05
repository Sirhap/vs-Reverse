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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol351")]
   public dynamic class Timeline_10 extends MovieClip
   {
      
      public var sbsatm:MovieClip;
      
      public var sbs2atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function Timeline_10()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
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
         this.$attacker_ctrler.move(12,0);
      }
   }
}

