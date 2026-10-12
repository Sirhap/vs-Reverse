package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=fight DefineBinaryData id=226 charId=216 export=txtmc_score
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:txtmc_score` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class txtmc_score extends MovieClip
   {
      public function txtmc_score()
      {
         super();
      }
   }
}
