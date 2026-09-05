package Ȇ
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ȍ
   {
      
      private var t:TextField;
      
      public function ȍ(param1:TextField)
      {
         super();
         this.t = param1;
      }
      
      public function §̳§(param1:Object) : void
      {
         if(!param1)
         {
            throw new TypeError("参数不能为空",2007);
         }
         var _loc3_:TextFormat = t.defaultTextFormat;
         for(var _loc2_ in param1)
         {
            if(_loc2_ in _loc3_)
            {
               _loc3_[_loc2_] = param1[_loc2_];
            }
         }
         t.defaultTextFormat = _loc3_;
      }
      
      public function §͇§(param1:TextFormat) : void
      {
         t.defaultTextFormat = param1;
      }
      
      public function set align(param1:String) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.align = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get align() : String
      {
         return t.defaultTextFormat.align;
      }
      
      public function set blockIndent(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.blockIndent = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get blockIndent() : Object
      {
         return t.defaultTextFormat.blockIndent;
      }
      
      public function set bold(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.bold = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get bold() : Object
      {
         return t.defaultTextFormat.bold;
      }
      
      public function set bullet(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.bullet = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get bullet() : Object
      {
         return t.defaultTextFormat.bullet;
      }
      
      public function set color(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.color = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get color() : Object
      {
         return t.defaultTextFormat.color;
      }
      
      public function set font(param1:String) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.font = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get font() : String
      {
         return t.defaultTextFormat.font;
      }
      
      public function set indent(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.indent = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get indent() : Object
      {
         return t.defaultTextFormat.indent;
      }
      
      public function set italic(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.italic = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get italic() : Object
      {
         return t.defaultTextFormat.italic;
      }
      
      public function set kerning(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.kerning = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get kerning() : Object
      {
         return t.defaultTextFormat.kerning;
      }
      
      public function set leading(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.leading = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get leading() : Object
      {
         return t.defaultTextFormat.leading;
      }
      
      public function set leftMargin(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.leftMargin = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get leftMargin() : Object
      {
         return t.defaultTextFormat.leftMargin;
      }
      
      public function set letterSpacing(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.letterSpacing = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get letterSpacing() : Object
      {
         return t.defaultTextFormat.letterSpacing;
      }
      
      public function set rightMargin(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.rightMargin = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get rightMargin() : Object
      {
         return t.defaultTextFormat.rightMargin;
      }
      
      public function set size(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.size = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get size() : Object
      {
         return t.defaultTextFormat.size;
      }
      
      public function set tabStops(param1:Array) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.tabStops = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get tabStops() : Array
      {
         return t.defaultTextFormat.tabStops;
      }
      
      public function set target(param1:String) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.target = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get target() : String
      {
         return t.defaultTextFormat.target;
      }
      
      public function set underline(param1:Object) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.underline = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get underline() : Object
      {
         return t.defaultTextFormat.underline;
      }
      
      public function set url(param1:String) : void
      {
         var _loc2_:TextFormat = t.defaultTextFormat;
         _loc2_.url = param1;
         t.defaultTextFormat = _loc2_;
      }
      
      public function get url() : String
      {
         return t.defaultTextFormat.url;
      }
      
      public function apply(param1:int = -1, param2:int = -1) : void
      {
         t.setTextFormat(t.defaultTextFormat,param1,param2);
      }
   }
}

