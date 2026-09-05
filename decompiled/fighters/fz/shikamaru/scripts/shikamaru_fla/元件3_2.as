package shikamaru_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol43")]
   public dynamic class 元件3_2 extends MovieClip
   {
      
      public var atm1:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 元件3_2()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
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
         this.$attacker_ctrler.moveToTarget(0,NaN);
      }
      
      internal function frame3() : *
      {
         this.$attacker_ctrler.moveToTarget(0,NaN);
      }
   }
}

