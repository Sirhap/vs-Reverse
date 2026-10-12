package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=select DefineBinaryData id=2210 charId=106 export=select_item_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:select_item_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class select_item_mc extends MovieClip
   {
      public function select_item_mc()
      {
         super();
      }
   }
}
