package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5")]
   public dynamic class trans_mc extends MovieClip
   {
      
      public function trans_mc()
      {
         super();
         addFrameScript(0,this.frame1,25,this.frame26,60,this.frame61);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame26() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function frame61() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

