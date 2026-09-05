package uryuu_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol207")]
   public dynamic class Timeline_13 extends MovieClip
   {
      
      public var zh2atm:MovieClip;
      
      public var zh21atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function Timeline_13()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,5,this.frame6,6,this.frame7,12,this.frame13);
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
         this.$attacker_ctrler.move(0,30);
      }
      
      internal function frame3() : *
      {
         this.$attacker_ctrler.setTouchFloor("击地");
      }
      
      internal function frame6() : *
      {
         this.$attacker_ctrler.stop();
      }
      
      internal function frame7() : *
      {
         this.$attacker_ctrler.effect.shake(0,3);
      }
      
      internal function frame13() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

