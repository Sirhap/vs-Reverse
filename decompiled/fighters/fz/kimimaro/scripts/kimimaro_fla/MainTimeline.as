package kimimaro_fla
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
      
      public var atm0:MovieClip;
      
      public var atm1:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,15,this.frame16,29,this.frame30,33,this.frame34,49,this.frame50,64,this.frame65,69,this.frame70,100,this.frame101);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":15,
            "hitType":1,
            "hitx":0,
            "hity":0,
            "hurtTime":400,
            "hurtType":0,
            "isBreakDef":false
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame16() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame30() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame34() : *
      {
         this.$assisterCtrler.move(20,0);
         this.$assisterCtrler.setHitTarget("atm0","动作2");
         this.$assisterCtrler.effect.dash();
      }
      
      internal function frame50() : *
      {
         this.$assisterCtrler.endAct();
         this.$assisterCtrler.damping(2,0);
      }
      
      internal function frame65() : *
      {
         this.$assisterCtrler.finish();
      }
      
      internal function frame70() : *
      {
         this.$assisterCtrler.damping(4,0);
      }
      
      internal function frame101() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

