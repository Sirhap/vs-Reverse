package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=select DefineBinaryData id=2210 charId=90 export=select_map_txt_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:select_map_txt_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class select_map_txt_mc extends MovieClip
   {
      public function select_map_txt_mc()
      {
         super();
      }
   }
}
