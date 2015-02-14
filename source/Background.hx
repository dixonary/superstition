package;

import flixel.FlxSprite;
import flixel.FlxG;

class Background extends FlxSprite {

    public function new(Path:String) {
        super(0,0,Path);

        // Scale image up to fit window
        var zX = FlxG.width / width;
        var zY = FlxG.height / height;
        var zMin = Math.min(zX, zY);

        scale.set(zMin,zMin);

        // Center image on screen
        x = (FlxG.width - width) / 2;
        y = (FlxG.height - height) / 2;

    }

}