package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=setting DefineBinaryData id=2211 charId=9 export=stg_set_ui
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:stg_set_ui` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class stg_set_ui extends MovieClip
   {
      public function stg_set_ui()
      {
         super();
      }
   }
}
