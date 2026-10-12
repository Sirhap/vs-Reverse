package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=gameover DefineBinaryData id=227 charId=39 export=stg_gameover_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:stg_gameover_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class stg_gameover_mc extends MovieClip
   {
      public function stg_gameover_mc()
      {
         super();
      }
   }
}
