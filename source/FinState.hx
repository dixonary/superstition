package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class FinState extends FlxState {
    
    override public function create():Void {
        super.create();

        Reg.toFin = false;

        var finbg = new Background("assets/images/fin.png");
        finbg.alpha = 0;
        add(finbg);

        var t = new flixel.text.FlxText(0, FlxG.height/2,FlxG.width, "you killed the witch");
        t.setFormat("assets/fonts/oe.ttf", 48, 0xffffffff, "center");
        add(t);
        t.alpha = 0;

        var b = new FlxButton();
        b.loadGraphic("assets/images/home.png");
        b.scale.set(4,4);
        b.centerOrigin();
        b.updateHitbox();
        b.x = (FlxG.width-b.width)/2;
        b.y = 2*FlxG.height/3;
        b.alpha = 0;
        b.onDown.callback=toMenu;
        add(b);

        FlxTween.tween(finbg, {alpha:1}, 1.5);
        FlxTween.tween(t, {alpha:1}, 1.5);
        new FlxTimer(2, function(_) {
            FlxTween.tween(b, {alpha:1}, 1.5);
        });
    }

    public function toMenu() {
        FlxG.camera.fade(0xff000000, 0.6, false, function(){
            FlxG.switchState(new MenuState());
        });
    }

}