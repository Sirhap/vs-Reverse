package ichigo_zero_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol518")]
   public dynamic class 必杀效果副本_23 extends MovieClip
   {
      
      public var sbsatm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 必杀效果副本_23()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,7,this.frame8);
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
         this.$attacker_ctrler.move(0,-30);
      }
      
      internal function frame8() : *
      {
         this.$attacker_ctrler.move(0,-5);
      }
   }
}

