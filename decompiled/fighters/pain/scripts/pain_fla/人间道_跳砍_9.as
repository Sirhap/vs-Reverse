package pain_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol52")]
   public dynamic class 人间道_跳砍_9 extends MovieClip
   {
      
      public var tk2atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 人间道_跳砍_9()
      {
         super();
         addFrameScript(0,this.frame1,4,this.frame5,7,this.frame8);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
         this.$attacker_ctrler.move(2,0);
         this.$attacker_ctrler.damping(0.3,0);
      }
      
      internal function frame5() : *
      {
         this.$attacker_ctrler.move(20,0);
      }
      
      internal function frame8() : *
      {
         this.$attacker_ctrler.move(6,0);
         this.$attacker_ctrler.damping(0.5,0);
      }
   }
}

