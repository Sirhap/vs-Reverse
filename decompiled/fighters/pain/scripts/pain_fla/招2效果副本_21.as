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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol320")]
   public dynamic class 招2效果副本_21 extends MovieClip
   {
      
      public var zh30atm:MovieClip;
      
      public var zh3atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 招2效果副本_21()
      {
         super();
         addFrameScript(0,this.frame1,10,this.frame11,26,this.frame27,41,this.frame42,42,this.frame43,45,this.frame46);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame11() : *
      {
         this.$attacker_ctrler.move(15,-10);
         this.$attacker_ctrler.setHitTarget("zh30atm","hit");
      }
      
      internal function frame27() : *
      {
         this.$attacker_ctrler.damping(15,15);
      }
      
      internal function frame42() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
      
      internal function frame43() : *
      {
         this.$attacker_ctrler.move(20,-20);
         this.$attacker_ctrler.damping(5,5);
      }
      
      internal function frame46() : *
      {
         this.$attacker_ctrler.damping(20);
         this.$attacker_ctrler.endAct();
      }
   }
}

