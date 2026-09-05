package soifon_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol329")]
   public dynamic class 元件21_10 extends MovieClip
   {
      
      public var bs2atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 元件21_10()
      {
         super();
         addFrameScript(0,this.frame1,101,this.frame102,255,this.frame256,265,this.frame266,271,this.frame272);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
         this.gotoAndPlay("hit");
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame102() : *
      {
         this.$attacker_ctrler.effect.shine(16711680);
      }
      
      internal function frame256() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
      
      internal function frame266() : *
      {
         this.$attacker_ctrler.effect.slowDown(2);
      }
      
      internal function frame272() : *
      {
         this.$attacker_ctrler.effect.shine(16711680);
      }
   }
}

