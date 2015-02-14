package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxTypedGroup;

class PlayState extends FlxState {

	var player   :Player;
	var bg 	     :Background;
	public var platforms:FlxTypedGroup<Platform>; 

	override public function create():Void {
		super.create();

		add(bg = new Background("assets/images/bg1.png"));

		add(player = new Player());


		platforms = new FlxTypedGroup();
		add(platforms);
		platforms.add(new Platform(0, FlxG.height-50, FlxG.width, 40));
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		FlxG.collide(player,platforms);

		if(FlxG.keys.justPressed.Q)
			Sys.exit(0);
	}	
}