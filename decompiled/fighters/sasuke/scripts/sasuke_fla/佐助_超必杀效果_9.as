package sasuke_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol401")]
   public dynamic class 佐助_超必杀效果_9 extends MovieClip
   {
      
      public var cbsatm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 佐助_超必杀效果_9()
      {
         super();
         addFrameScript(0,this.frame1,13,this.frame14);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame14() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

