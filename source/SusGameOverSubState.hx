package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;

class SusGameOverSubState extends MusicBeatSubstate
{
	var bf:Boyfriend;

	var stageSuffix:String = "";

	public function new()
	{

		super();

		Conductor.songPosition = 0;

		FlxG.camera.zoom = FlxMath.lerp(0.3, FlxG.camera.zoom, 0.95);

		var space:FlxSprite = new FlxSprite().loadGraphic(Paths.image('sus/meeting/space', 'shared'));
		space.antialiasing = true;
		space.screenCenter();

		bf = new Boyfriend(0, 0, 'bf');
		add(bf);
		bf.x = -1350;
		bf.setGraphicSize(Std.int(bf.width / 3));
		FlxTween.tween(bf, {x: 2000}, 6, {ease: FlxEase.elasticInOut});
		FlxTween.tween(bf, {angle: 360}, 12, {ease: FlxEase.elasticInOut});

				var txt:FlxText = new FlxText(0, 0, FlxG.width, "Boyfriend Was Not The Impostor.", 24);
				txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
				txt.borderColor = FlxColor.BLACK;
				txt.borderSize = 3;
				txt.borderStyle = FlxTextBorderStyle.OUTLINE;
				txt.screenCenter();
				add(txt);
				txt.alpha = 0;
				FlxTween.tween(txt, {alpha: 1}, 1, {ease: FlxEase.elasticInOut});
	
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));

		bf.playAnim('singeject');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new MainMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
