package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=135 export=score_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:score_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class score_mc extends MovieClip
   {
      public function score_mc()
      {
         super();
      }
   }
}
