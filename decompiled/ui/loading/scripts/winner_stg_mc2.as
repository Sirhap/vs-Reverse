package
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol69")]
   public dynamic class winner_stg_mc2 extends MovieClip
   {
      
      public var btns:MovieClip;
      
      public var f0:MovieClip;
      
      public var f1:MovieClip;
      
      public var f2:MovieClip;
      
      public var scoremc:MovieClip;
      
      public var txtmc:MovieClip;
      
      public function winner_stg_mc2()
      {
         super();
         addFrameScript(91,this.frame92);
      }
      
      internal function frame92() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
         this.txtmc.gotoAndPlay(2);
      }
   }
}

