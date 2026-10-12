package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=howtoplay DefineBinaryData id=228 charId=450 export=movie_howtoplay
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:movie_howtoplay` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class movie_howtoplay extends MovieClip
   {
      public function movie_howtoplay()
      {
         super();
      }
   }
}
