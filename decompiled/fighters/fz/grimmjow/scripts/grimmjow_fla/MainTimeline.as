package grimmjow_fla
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
      
      public var atm3:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,19,this.frame20,35,this.frame36,36,this.frame37,40,this.frame41,44,this.frame45,107,this.frame108);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":20,
            "hitType":2,
            "hitx":3,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":5,
            "hitType":1,
            "hitx":0,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm3",{
            "power":50,
            "hitType":6,
            "hitx":5,
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
      
      internal function frame20() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame36() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame37() : *
      {
         this.$assisterCtrler.move(10,0);
         this.$assisterCtrler.damping(0.5,0);
      }
      
      internal function frame41() : *
      {
         this.$assisterCtrler.moveToTarget(-50,0,false);
      }
      
      internal function frame45() : *
      {
         this.$assisterCtrler.effect.shine(9461864);
         this.$assisterCtrler.move(10,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame108() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

