package;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxState;
class MenuState extends FlxState {
    
    override public function create():Void {

        super.create();

        FlxG.camera.fade(0xff000000, 0.6, true);

        add(new Background("assets/images/menu.png"));

        var b;
        b=new FlxButton();
        add(b);
        b.loadGraphic("assets/images/play.png");
        b.scale.set(4,4);
        b.centerOrigin();
        b.updateHitbox();
        b.x = FlxG.width/6;
        b.y = FlxG.height/2.5;
        b.onDown.callback=function() {
            FlxG.switchState(new puzzles.InsideHut());
        }
        var k = new FlxSprite();
        k.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
        if(Reg.toFin) {
            add(k);
            Reg.toFin = false;
            FlxG.switchState(new FinState());
        }

        Reg.playerSpawnX = 1050;
        Reg.playerSpawnY = 200;

    }

}