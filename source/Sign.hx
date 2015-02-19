package;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class Sign extends FlxSprite {
    
    public function new(X:Float, Y:Float, Name, Flip) {

        super();

        loadGraphic("assets/images/"+Name+".png");

        scale.set(3,3);
        pixelPerfectRender = false;
        centerOffsets();
        updateHitbox();
        x = X;
        y = Y+20;

        alpha = 0.1;

        FlxTween.tween(this, {y:Y, alpha:1}, 0.3, {ease:flixel.tweens.FlxEase.elasticOut});

        flipX = Flip;

    }

    public override function kill() {

        FlxTween.tween(this, {y:y+20, alpha:0}, 0.5, {ease:flixel.tweens.FlxEase.elasticIn, 
            complete:function(_) {
                done();
            }});
    }
    public function done():Void {
        super.kill();
    }

}