package tenten_fla
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
         addFrameScript(0,this.frame1,15,this.frame16,37,this.frame38,39,this.frame40,45,this.frame46,51,this.frame52,57,this.frame58,63,this.frame64,77,this.frame78,113,this.frame114);
      }
      
      public function setAssistCtrler(param1:*) : void
      {
         this.$assisterCtrler = param1;
         this.defineActions();
      }
      
      public function defineActions() : void
      {
         this.$assisterCtrler.defineAction("atm1",{
            "power":10,
            "hitType":1,
            "hitx":2,
            "hity":0,
            "hurtTime":800,
            "hurtType":0,
            "isBreakDef":false
         });
         this.$assisterCtrler.defineAction("atm2",{
            "power":50,
            "hitType":6,
            "hitx":10,
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
      
      internal function frame16() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame38() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame40() : *
      {
         this.$assisterCtrler.fire("atm1",{
            "x":20,
            "hits":1
         });
      }
      
      internal function frame46() : *
      {
         this.$assisterCtrler.fire("atm1",{
            "x":20,
            "hits":1
         });
      }
      
      internal function frame52() : *
      {
         this.$assisterCtrler.fire("atm1",{
            "x":20,
            "hits":1
         });
      }
      
      internal function frame58() : *
      {
         this.$assisterCtrler.fire("atm1",{
            "x":20,
            "hits":1
         });
      }
      
      internal function frame64() : *
      {
         this.$assisterCtrler.fire("atm1",{
            "x":20,
            "hits":1
         });
      }
      
      internal function frame78() : *
      {
         this.$assisterCtrler.fire("atm2",{
            "x":30,
            "hits":1
         });
      }
      
      internal function frame114() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

