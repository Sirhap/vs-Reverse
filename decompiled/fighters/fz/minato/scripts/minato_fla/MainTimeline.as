package minato_fla
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
      
      public var atm4:MovieClip;
      
      public var atm5:MovieClip;
      
      public var $assisterCtrler:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3,24,this.frame25,30,this.frame31,34,this.frame35,39,this.frame40,49,this.frame50,59,this.frame60,69,this.frame70,84,this.frame85,90,this.frame91,91,this.frame92,98,this.frame99,133,this.frame134,138,this.frame139,163,this.frame164,169,this.frame170);
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
            "hitType":5,
            "hitx":0,
            "hity":20,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm3",{
            "power":20,
            "hitType":3,
            "hitx":5,
            "hity":-10,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm5",{
            "power":5,
            "hitType":4,
            "hitx":0,
            "hity":20,
            "hurtTime":300,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":20,
            "hitType":3,
            "hitx":5,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm4",{
            "power":20,
            "hitType":6,
            "hitx":-4,
            "hity":0,
            "hurtTime":1000,
            "hurtType":0,
            "isBreakDef":true
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame25() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame31() : *
      {
         this.$assisterCtrler.moveToTarget(-100,0,false);
         this.$assisterCtrler.move(15,0);
         this.$assisterCtrler.damping(0.5,0);
         this.$assisterCtrler.effect.shadow(200,200,0);
      }
      
      internal function frame35() : *
      {
         this.$assisterCtrler.effect.shine();
         this.$assisterCtrler.effect.shine(1069248);
      }
      
      internal function frame40() : *
      {
         this.$assisterCtrler.effect.endShadow();
      }
      
      internal function frame50() : *
      {
         this.$assisterCtrler.justHit("atm2","attack2",false);
      }
      
      internal function frame60() : *
      {
         this.$assisterCtrler.gotoAndPlay("atm");
      }
      
      internal function frame70() : *
      {
         this.$assisterCtrler.moveToTarget(10,0,false);
      }
      
      internal function frame85() : *
      {
         this.$assisterCtrler.endAct();
      }
      
      internal function frame91() : *
      {
         this.$assisterCtrler.finish(false);
      }
      
      internal function frame92() : *
      {
         this.$assisterCtrler.effect.shine();
         this.$assisterCtrler.effect.shine(1069248);
      }
      
      internal function frame99() : *
      {
         this.$assisterCtrler.moveToTarget(40,0,true);
      }
      
      internal function frame134() : *
      {
         this.$assisterCtrler.moveToTarget(-20,-200,false);
         this.$assisterCtrler.move(0,20);
         this.$assisterCtrler.effect.shadow(200,200,0);
      }
      
      internal function frame139() : *
      {
         this.$assisterCtrler.effect.endShadow();
      }
      
      internal function frame164() : *
      {
         this.$assisterCtrler.endAct();
      }
      
      internal function frame170() : *
      {
         this.$assisterCtrler.finish(false);
      }
   }
}

