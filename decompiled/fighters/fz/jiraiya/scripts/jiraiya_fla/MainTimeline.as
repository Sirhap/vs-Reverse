package jiraiya_fla
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
      
      public var atm2:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,29,this.frame30,30,this.frame31,35,this.frame36,47,this.frame48,73,this.frame74);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":50,
            "hitType":4,
            "hitx":3,
            "hity":0,
            "hurtTime":800,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":50,
            "hitType":5,
            "hitx":15,
            "hity":0,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame10() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame30() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame31() : *
      {
         this.$assisterCtrler.effect.dash();
         this.$assisterCtrler.move(10,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame36() : *
      {
         this.$assisterCtrler.moveToTarget(-100,0,false);
         this.$assisterCtrler.move(10,0);
         this.$assisterCtrler.damping(0.5,0);
      }
      
      internal function frame48() : *
      {
         this.$assisterCtrler.effect.shine();
      }
      
      internal function frame74() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

