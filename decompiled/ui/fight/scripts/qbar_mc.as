package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol78")]
   public dynamic class qbar_mc extends MovieClip
   {
      
      public var barmc:qbar_barmc;
      
      public var facemc:qbar_facemc;
      
      public var fzqibar:qbar_fzqi_mc;
      
      public var readymc:MovieClip;
      
      public function qbar_mc()
      {
         super();
         addFrameScript(0,this.frame1,14,this.frame15,37,this.frame38);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame15() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function frame38() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

