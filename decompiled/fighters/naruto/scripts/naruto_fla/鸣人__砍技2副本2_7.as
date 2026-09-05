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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol236")]
   public dynamic class 鸣人__砍技2副本2_7 extends MovieClip
   {
      
      public var kj23atm:MovieClip;
      
      public var kj24atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 鸣人__砍技2副本2_7()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,6,this.frame7,19,this.frame20);
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
      
      internal function frame7() : *
      {
         this.$attacker_ctrler.damping(2);
      }
      
      internal function frame20() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

