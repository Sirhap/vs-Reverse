package itachi_fla
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
         addFrameScript(0,this.frame1,23,this.frame24,41,this.frame42,46,this.frame47,58,this.frame59,60,this.frame61,75,this.frame76,91,this.frame92,124,this.frame125,127,this.frame128,143,this.frame144,159,this.frame160,175,this.frame176,180,this.frame181);
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
            "hitType":4,
            "hitx":0,
            "hity":0,
            "hurtTime":2000,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":20,
            "hitType":1,
            "hitx":0,
            "hity":0,
            "hurtTime":600,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm3",{
            "power":40,
            "hitType":1,
            "hitx":-3,
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
      
      internal function frame24() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame42() : *
      {
         this.$assisterCtrler.effect.shine(0);
      }
      
      internal function frame47() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame59() : *
      {
         this.$assisterCtrler.justHit("atm1","攻击2",false);
      }
      
      internal function frame61() : *
      {
         this.$assisterCtrler.endAct();
      }
      
      internal function frame76() : *
      {
         this.$assisterCtrler.finish();
      }
      
      internal function frame92() : *
      {
         this.$assisterCtrler.moveToTarget(0,null,false);
      }
      
      internal function frame125() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame128() : *
      {
         this.$assisterCtrler.effect.shine(0);
      }
      
      internal function frame144() : *
      {
         this.$assisterCtrler.effect.shine(0);
      }
      
      internal function frame160() : *
      {
         this.$assisterCtrler.effect.shine(0);
      }
      
      internal function frame176() : *
      {
         this.$assisterCtrler.effect.shine(0);
      }
      
      internal function frame181() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

