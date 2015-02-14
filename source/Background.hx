package;

import flixel.FlxSprite;
import flixel.FlxG;

class Background extends FlxSprite {

    public function new(Path:String, Scale:Float = -1) {
        super(0,0,Path);
        
        var zMin;
        
        if(Scale == -1) {
            // Scale image up to fit window
            var zX = FlxG.width / width;
            var zY = FlxG.height / height;
            zMin = Math.min(zX, zY);
        }
        else
            zMin = Scale;

        scale.set(zMin,zMin);
        centerOffsets();
        updateHitbox();

        // Center image on screen
        x = (FlxG.width - width) / 2;
        y = (FlxG.height - height) / 2;

    }

}