package mayuri_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol452")]
   public dynamic class Timeline_12 extends MovieClip
   {
      
      public var cbsatm:MovieClip;
      
      public var cbs1atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function Timeline_12()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,39,this.frame40,41,this.frame42,54,this.frame55);
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
         this.$attacker_ctrler.move(10,0);
      }
      
      internal function frame40() : *
      {
         this.$attacker_ctrler.damping(2,0);
      }
      
      internal function frame42() : *
      {
         this.$attacker_ctrler.effect.shine(4580164);
      }
      
      internal function frame55() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

