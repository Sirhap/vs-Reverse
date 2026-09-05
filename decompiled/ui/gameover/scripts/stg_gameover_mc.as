package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol39")]
   public dynamic class stg_gameover_mc extends MovieClip
   {
      
      public var btn_back:MovieClip;
      
      public var btn_no:MovieClip;
      
      public var btn_yes:MovieClip;
      
      public var ct_char:MovieClip;
      
      public var ct_score:MovieClip;
      
      public function stg_gameover_mc()
      {
         super();
         addFrameScript(49,this.frame50,84,this.frame85,123,this.frame124,237,this.frame238);
      }
      
      internal function frame50() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function frame85() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function frame124() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function frame238() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

