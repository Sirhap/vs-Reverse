package stake_fla
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
         addFrameScript(0,this.frame1,9,this.frame10,20,this.frame21,26,this.frame27,33,this.frame34,42,this.frame43,73,this.frame74);
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
            "hitx":4,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":20,
            "hitType":1,
            "hitx":2,
            "hity":0,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm3",{
            "power":100,
            "hitType":5,
            "hitx":10,
            "hity":0,
            "hurtTime":800,
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
      
      internal function frame21() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame27() : *
      {
         this.$assisterCtrler.moveToTarget(-50,0,false);
      }
      
      internal function frame34() : *
      {
         this.$assisterCtrler.move(10,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame43() : *
      {
         this.$assisterCtrler.move(10,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame74() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

