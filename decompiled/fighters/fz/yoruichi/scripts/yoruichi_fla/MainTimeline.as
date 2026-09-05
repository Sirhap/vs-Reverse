package yoruichi_fla
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
   
   public dynamic class MainTimeline extends MovieClip
   {
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":0,
            "hitType":0,
            "hitx":0,
            "hity":0,
            "hurtTime":0,
            "hurtType":0,
            "isBreakDef":false
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         this.$assisterCtrler.effect.shine(16776960);
         this.$assisterCtrler.getOwner().getCtrler().moveOnce(120,0);
         this.$assisterCtrler.getOwner().getBuffCtrl().speedUp(5,5);
      }
   }
}

