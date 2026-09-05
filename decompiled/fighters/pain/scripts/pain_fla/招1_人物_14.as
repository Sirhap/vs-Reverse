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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol261")]
   public dynamic class 招1_人物_14 extends MovieClip
   {
      
      public var zh13atm:MovieClip;
      
      public var zh1atm:MovieClip;
      
      public var $attacker_ctrler:*;
      
      public function 招1_人物_14()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,10,this.frame11,15,this.frame16,20,this.frame21,29,this.frame30,31,this.frame32);
      }
      
      public function setAttackerCtrler(param1:*) : void
      {
         this.$attacker_ctrler = param1;
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame2() : *
      {
         this.$attacker_ctrler.move(-10,0);
         this.$attacker_ctrler.damping(1,0);
      }
      
      internal function frame11() : *
      {
         this.$attacker_ctrler.fire("zh1atm",{
            "x":20,
            "y":0,
            "hold":1,
            "hits":1
         });
      }
      
      internal function frame16() : *
      {
         this.$attacker_ctrler.fire("zh1atm",{
            "x":20,
            "y":0,
            "hold":1,
            "hits":1
         });
      }
      
      internal function frame21() : *
      {
         this.$attacker_ctrler.fire("zh13atm",{
            "x":20,
            "y":0,
            "hold":1,
            "hits":1
         });
      }
      
      internal function frame30() : *
      {
         this.$attacker_ctrler.move(10,0);
      }
      
      internal function frame32() : *
      {
         this.$attacker_ctrler.endAct();
      }
   }
}

