package fight_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol187")]
   public dynamic class 元件25_46 extends MovieClip
   {
      
      public var isPerfect:Boolean;
      
      public function 元件25_46()
      {
         super();
         addFrameScript(0,this.frame1,28,this.frame29,55,this.frame56);
      }
      
      internal function frame1() : *
      {
         this.isPerfect = false;
      }
      
      internal function frame29() : *
      {
         if(!this.isPerfect)
         {
            stop();
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      internal function frame56() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

