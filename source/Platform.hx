package;

import flixel.FlxSprite;

class Platform extends FlxSprite {

    public function new(X:Float, Y:Float, Width:Int, Height:Int, Colour:Int=0x00ffffff) {

        super(X, Y);

        makeGraphic(Width, Height, Colour, true);
        
        immovable = true;

    }

}