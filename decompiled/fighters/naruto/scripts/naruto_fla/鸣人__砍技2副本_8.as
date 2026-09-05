package naruto_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol249")]
   public dynamic class 鸣人__砍技2副本_8 extends MovieClip
   {
      
      public var kj25atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 鸣人__砍技2副本_8()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,14,this.frame15,21,this.frame22);
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
         this.$attacker_ctrler.move(15);
      }
      
      internal function frame15() : *
      {
         this.$attacker_ctrler.damping(4);
      }
      
      internal function frame22() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

