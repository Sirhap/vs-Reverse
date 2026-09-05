package ichigo_white2_fla
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
         addFrameScript(0,this.frame1,14,this.frame15,28,this.frame29,31,this.frame32,43,this.frame44,54,this.frame55,61,this.frame62,62,this.frame63,69,this.frame70,89,this.frame90,92,this.frame93);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":30,
            "hitType":1,
            "hitx":10,
            "hity":-10,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":10,
            "hitType":1,
            "hitx":5,
            "hity":-5,
            "hurtTime":500,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm3",{
            "power":50,
            "hitType":5,
            "hitx":10,
            "hity":10,
            "hurtTime":0,
            "hurtType":1,
            "isBreakDef":true
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame15() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame29() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame32() : *
      {
         this.$assisterCtrler.moveToTarget(50,0,true);
         this.$assisterCtrler.effect.slowDown(0.5);
      }
      
      internal function frame44() : *
      {
         this.$assisterCtrler.justHit("atm1","act1",false);
      }
      
      internal function frame55() : *
      {
         this.$assisterCtrler.finish(true);
      }
      
      internal function frame62() : *
      {
         this.$assisterCtrler.moveToTarget(10,0,true);
      }
      
      internal function frame63() : *
      {
         this.$assisterCtrler.effect.shine();
      }
      
      internal function frame70() : *
      {
         this.$assisterCtrler.moveToTarget(-30,-50,false);
         this.$assisterCtrler.move(1,-1);
      }
      
      internal function frame90() : *
      {
         this.$assisterCtrler.move(0,0);
      }
      
      internal function frame93() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

