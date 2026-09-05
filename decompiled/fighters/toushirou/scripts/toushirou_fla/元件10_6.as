package toushirou_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol471")]
   public dynamic class 元件10_6 extends MovieClip
   {
      
      public var cbs1atm:MovieClip;
      
      public var cbsatm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 元件10_6()
      {
         super();
         addFrameScript(0,this.frame1,86,this.frame87);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame87() : *
      {
         this.$attacker_ctrler.effect.shine();
      }
   }
}

