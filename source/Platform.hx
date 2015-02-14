package;

import flixel.FlxSprite;

class Platform extends FlxSprite {

    public function new(X:Float, Y:Float, Width:Int, Height:Int) {

        super(X, Y);

        makeGraphic(Width, Height, 0xffff0000, true);
        
        immovable = true;

    }

}