package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=select DefineBinaryData id=2210 charId=87 export=selected_item_p1_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:selected_item_p1_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class selected_item_p1_mc extends MovieClip
   {
      public function selected_item_p1_mc()
      {
         super();
      }
   }
}
