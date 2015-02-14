package;

import flixel.FlxSprite;
import flixel.FlxG;

class Box extends FlxSprite {
    
    function new(X:Float, Y:Float) {
        super(X,Y);

        antialiasing = true;
        pixelPerfectRender = false;

        acceleration.y = 3000;

        loadGraphic("assets/images/box.png");
    }

    override function update() {
        velocity.y += acceleration.y * FlxG.elapsed;
        y += velocity.y * FlxG.elapsed;
        x += velocity.x * FlxG.elapsed;
    }

}