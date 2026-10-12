package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=common_ui DefineBinaryData id=225 charId=8 export=select_arrow_mc
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:select_arrow_mc` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class select_arrow_mc extends MovieClip
   {
      public function select_arrow_mc()
      {
         super();
      }
   }
}
