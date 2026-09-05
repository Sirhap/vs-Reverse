package pain_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol332")]
   public dynamic class 上必杀效果1_23 extends MovieClip
   {
      
      public var sbs1atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 上必杀效果1_23()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame10() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

