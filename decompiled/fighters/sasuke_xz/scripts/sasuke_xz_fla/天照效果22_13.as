package sasuke_xz_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol253")]
   public dynamic class 天照效果22_13 extends MovieClip
   {
      
      public var zh10atm:MovieClip;
      
      public var zh11atm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 天照效果22_13()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,36,this.frame37,37,this.frame38,47,this.frame48);
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
         this.$attacker_ctrler.move(8,0);
         this.$attacker_ctrler.setHitTarget("zh10atm","hit");
      }
      
      internal function frame37() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
      
      internal function frame38() : *
      {
         this.$attacker_ctrler.damping(10,0);
      }
      
      internal function frame48() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

