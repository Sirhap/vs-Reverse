package temari_fla
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
         addFrameScript(0,this.frame1,19,this.frame20,35,this.frame36,36,this.frame37,37,this.frame38,38,this.frame39,68,this.frame69);
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
            "hitType":4,
            "hitx":0.5,
            "hity":-1,
            "hurtTime":300,
            "hurtType":0,
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
         this.$assisterCtrler.move(5,0);
         this.$assisterCtrler.damping(1,0);
      }
      
      internal function frame38() : *
      {
         this.$assisterCtrler.fire("atm1",{
            "x":{
               "start":20,
               "hit":1
            },
            "hits":-1
         });
      }
      
      internal function frame39() : *
      {
         this.$assisterCtrler.effect.shine(9461864);
      }
      
      internal function frame69() : *
      {
         this.$assisterCtrler.endAct();
      }
   }
}

