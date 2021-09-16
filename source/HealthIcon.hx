package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;



	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		switch(char){
			case 'bf' | 'bf-old'  | 'gf':
				loadGraphic(Paths.image('iconGrid'), true, 150, 150);
				animation.add('bf', [0, 1], 0, false, isPlayer);
				animation.add('bf-old', [14, 15], 0, false, isPlayer);
				animation.add('gf', [16, 16], 0, false, isPlayer);
				animation.add('dad', [13, 13], 0, false, isPlayer);
			case 'crew' | 'wires' | 'green' | 'impostor' | 'sus' | 'mongus' | 'duo':
				loadGraphic(Paths.image('iconGridMongus'), true, 150, 150);
				animation.add('crew', [0, 1], 0, false, isPlayer);
				animation.add('wires', [0, 1], 0, false, isPlayer);
				animation.add('impostor', [4, 5], 0, false, isPlayer);
				animation.add('sus', [2, 3], 0, false, isPlayer);
				animation.add('duo', [6, 6], 0, false, isPlayer);
				animation.add('mongus', [8, 9], 0, false, isPlayer);
				animation.add('green', [10, 11], 0, false, isPlayer);
		}
		antialiasing = true;
		animation.play(char);

		switch(char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				antialiasing = false;
		}

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
