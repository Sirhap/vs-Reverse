package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol30")]
   public dynamic class hits_mc extends MovieClip
   {
      
      public var ct:MovieClip;
      
      public var hitsmc:MovieClip;
      
      public function hits_mc()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,19,this.frame20,37,this.frame38,55,this.frame56);
      }
      
      internal function frame1() : *
      {
         stop();
         this.visible = false;
      }
      
      internal function frame10() : *
      {
         this.visible = true;
      }
      
      internal function frame20() : *
      {
         stop();
      }
      
      internal function frame38() : *
      {
         stop();
      }
      
      internal function frame56() : *
      {
         gotoAndStop(1);
      }
   }
}

