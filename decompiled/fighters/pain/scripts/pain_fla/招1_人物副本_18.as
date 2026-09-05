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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol270")]
   public dynamic class 招1_人物副本_18 extends MovieClip
   {
      
      public var zh13atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 招1_人物副本_18()
      {
         super();
         addFrameScript(0,this.frame1,42,this.frame43);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame43() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

