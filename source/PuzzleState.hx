package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxGroup;

class PuzzleState extends FlxState {

	public var player:Player;
	var bg 	   :Background;
	var bgLayer:FlxGroup;

	public var platforms:FlxTypedGroup<Platform>; 
	public var boxes    :FlxTypedGroup<Box>;

	override public function create():Void {
		super.create();

		bgLayer = new FlxGroup();
		add(bgLayer);

		platforms = new FlxTypedGroup();
		add(platforms);

		boxes = new FlxTypedGroup();
		add(boxes);

		add(player = new Player());
		player.setPos(Reg.playerSpawnX, Reg.playerSpawnY);

	}
	
	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		FlxG.collide(player,platforms);
		FlxG.collide(boxes,platforms);

		if(FlxG.keys.justPressed.Q)
			Sys.exit(0);
	}	
}