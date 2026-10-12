package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=select DefineBinaryData id=2210 charId=81 export=ctmc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:ctmc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class ctmc extends MovieClip
   {
      public function ctmc()
      {
         super();
      }
   }
}
