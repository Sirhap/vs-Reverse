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
   
   public dynamic class MainTimeline extends MovieClip
   {
      
      public var atm1:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,16,this.frame17,19,this.frame20,38,this.frame39,40,this.frame41,46,this.frame47);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":80,
            "hitType":5,
            "hitx":3,
            "hity":10,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame17() : *
      {
         this.$assisterCtrler.moveToTarget(0,-100);
         this.$assisterCtrler.setApplyG(false);
      }
      
      internal function frame20() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame39() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame41() : *
      {
         this.$assisterCtrler.effect.shine();
         this.$assisterCtrler.effect.shine(7329791);
         this.$assisterCtrler.move(0,-5);
         this.$assisterCtrler.damping(0,0.5);
      }
      
      internal function frame47() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

