package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol450")]
   public dynamic class movie_howtoplay extends MovieClip
   {
      
      public var skip_btn:SimpleButton;
      
      public var txt_attack:TextField;
      
      public var txt_bisha:TextField;
      
      public var txt_dash:TextField;
      
      public var txt_down:TextField;
      
      public var txt_jump:TextField;
      
      public var txt_left:TextField;
      
      public var txt_right:TextField;
      
      public var txt_skill:TextField;
      
      public var txt_special:TextField;
      
      public var txt_up:TextField;
      
      public function movie_howtoplay()
      {
         super();
         addFrameScript(0,this.frame1,1210,this.frame1211);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame1211() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

