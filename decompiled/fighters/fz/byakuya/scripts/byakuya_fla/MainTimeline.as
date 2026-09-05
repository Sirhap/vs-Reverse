package byakuya_fla
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
      
      public var lzgl:MovieClip;
      
      public var $assisterCtrler:*;
      
      public var judge:Boolean;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,18,this.frame19,46,this.frame47,49,this.frame50,50,this.frame51,51,this.frame52,59,this.frame60,60,this.frame61,84,this.frame85);
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
            "hitType":11,
            "hitx":0,
            "hity":0,
            "hurtTime":1750,
            "hurtType":0,
            "isBreakDef":false
         });
      }
      
      public function HurtStateEvent(param1:Event) : void
      {
         if(this.$assisterCtrler.getOwner().getCtrler().getTargetState() != 21)
         {
            this.$assisterCtrler.getOwner().getCtrler().getMcCtrl().getAttacker("lzgl").gotoAndPlay("end");
            this.removeEventListener(Event.ENTER_FRAME,this.HurtStateEvent);
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame19() : *
      {
         this.$assisterCtrler.effect.bisha(false);
      }
      
      internal function frame47() : *
      {
         this.$assisterCtrler.effect.endBisha();
      }
      
      internal function frame50() : *
      {
         this.judge = false;
         this.$assisterCtrler.setHitTarget("atm0","success");
      }
      
      internal function frame51() : *
      {
         this.$assisterCtrler.gotoAndPlay("failure");
      }
      
      internal function frame52() : *
      {
         this.$assisterCtrler.effect.shine(16776960);
         this.judge = true;
         this.$assisterCtrler.addAttacker("lzgl",{
            "x":{
               "followTarget":true,
               "offset":0
            },
            "y":{
               "followTarget":true,
               "offset":-30
            },
            "applyG":false
         });
      }
      
      internal function frame60() : *
      {
         if(this.$assisterCtrler.getOwner().getCtrler().getTargetState() == 21 && this.judge)
         {
            this.$assisterCtrler.getTarget().getCtrler().getMcCtrl().isApplyG(false);
         }
         if(this.judge)
         {
            this.addEventListener(Event.ENTER_FRAME,this.HurtStateEvent);
         }
      }
      
      internal function frame61() : *
      {
         this.$assisterCtrler.endAct();
      }
      
      internal function frame85() : *
      {
         this.$assisterCtrler.finish();
      }
   }
}

