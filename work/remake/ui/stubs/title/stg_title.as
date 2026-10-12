package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=title DefineBinaryData id=2215 charId=64 export=stg_title
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:stg_title` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class stg_title extends MovieClip
   {
      public function stg_title()
      {
         super();
      }
   }
}
