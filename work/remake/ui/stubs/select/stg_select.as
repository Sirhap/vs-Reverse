package
{
   import flash.display.MovieClip;

   /**
    * Empty remake stub for UI SymbolClass export.
    * UI=select DefineBinaryData id=2210 charId=75 export=stg_select
    * Purpose: give JPEXS/ASC a named MovieClip subclass so engine scripts can type
    * `:stg_select` (or keep `:*`). Does NOT embed artwork — nest SWF SymbolClass still owns pixels.
    * Cross-pool: if engine pool != home SWF, resolve via loading (see CROSS-POOL.md).
    */
   public class stg_select extends MovieClip
   {
      public function stg_select()
      {
         super();
      }
   }
}
