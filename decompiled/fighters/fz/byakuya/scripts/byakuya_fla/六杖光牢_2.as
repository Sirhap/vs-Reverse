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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol16")]
   public dynamic class 六杖光牢_2 extends MovieClip
   {
      
      public var atm1:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 六杖光牢_2()
      {
         super();
         addFrameScript(0,this.frame1,8,this.frame9,14,this.frame15);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame9() : *
      {
         this.$attacker_ctrler.stop();
      }
      
      internal function frame15() : *
      {
         this.$attacker_ctrler.removeSelf();
      }
   }
}

