package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=loading DefineBinaryData id=229 charId=105 export=cover_bgimg
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:cover_bgimg` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class cover_bgimg extends MovieClip
   {
      public function cover_bgimg()
      {
         super();
      }
   }
}
