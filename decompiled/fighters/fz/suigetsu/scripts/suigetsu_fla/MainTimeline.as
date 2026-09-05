package suigetsu_fla
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
         addFrameScript(0,this.frame1,12,this.frame13,27,this.frame28,34,this.frame35,43,this.frame44,52,this.frame53,63,this.frame64);
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
            "hitType":1,
            "hitx":3,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":50,
            "hitType":6,
            "hitx":5,
            "hity":-5,
            "hurtTime":600,
            "hurtType":0,
            "isBreakDef":false
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame13() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame28() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame35() : *
      {
         this.$assisterCtrler.moveToTarget(80,null,true);
         this.$assisterCtrler.effect.slowDown(0.5);
      }
      
      internal function frame44() : *
      {
         this.$assisterCtrler.move(10,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame53() : *
      {
         this.$assisterCtrler.move(10,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame64() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

