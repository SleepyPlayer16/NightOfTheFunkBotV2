package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'lane':
				tex = Paths.getSparrowAtlas('Lane_assets');
				frames = tex;
				animation.addByPrefix('idle', "lane idle", 24, false);
				animation.addByPrefix('singUP', "lane singup", 24, false);
				animation.addByPrefix('singRIGHT', "lane singright", 24, false);
				animation.addByPrefix('singLEFT', "lane singleft", 24, false);
				animation.addByPrefix('singDOWN', "lane singdown", 24, false);

				addOffset('idle', -9, -10);
				addOffset('singUP', -5, 6);
				addOffset("singRIGHT", -85, -38);
				addOffset("singLEFT", 128, 0);
				addOffset("singDOWN", 10, -19);
					
				playAnim('idle');

			case 'lane-hacked':
				tex = Paths.getSparrowAtlas('hackedlane_assets');
				frames = tex;

				animation.addByPrefix('idle', 'LaneHackedIdle', 24, false);
				animation.addByPrefix('singUP', 'LaneHackedUp', 24, false);
				animation.addByPrefix('singRIGHT', 'LaneHackedRight', 24, false);
				animation.addByPrefix('singDOWN', 'LaneHackedDown', 24, false);
				animation.addByPrefix('singLEFT', 'LaneHackedLeft', 24, false);
			
				addOffset('idle', -2, 0);
				addOffset('singUP', 12, 0);
				addOffset("singRIGHT", -96, -43);
				addOffset("singLEFT", 24, -17);
				addOffset("singDOWN", 16, -12);
						
				playAnim('idle');

			case 'path':
				tex = Paths.getSparrowAtlas('path_assets');
				frames = tex;
	
				animation.addByPrefix('idle', 'pathIDLE', 24, false);
				animation.addByPrefix('singUP', 'pathUP', 24, false);
				animation.addByPrefix('singRIGHT', 'pathRIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'pathDOWN', 24, false);
				animation.addByPrefix('singLEFT', 'pathLEFT', 24, false);

				animation.addByPrefix('singUP-alt', 'pathUP', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'pathRIGHT', 24, false);
				animation.addByPrefix('singDOWN-alt', 'pathDOWN', 24, false);
				animation.addByPrefix('singLEFT-alt', 'pathLEFT', 24, false);
		
				addOffset('idle', 49, -21);
				addOffset('singUP', 32, 34);
				addOffset("singRIGHT", -103, -47);
				addOffset("singLEFT", 143, -91);
				addOffset("singDOWN", 103, -63);

				addOffset('singUP-alt', 32, 34);
				addOffset("singRIGHT-alt", -103, -47);
				addOffset("singLEFT-alt", 143, -91);
				addOffset("singDOWN-alt", 103, -63);				

				playAnim('idle');

			case 'lanelle':
				tex = Paths.getSparrowAtlas('lanelle_assets');
				frames = tex;
		
				animation.addByPrefix('idle', 'lanelleIDLE', 24, false);
				animation.addByPrefix('singUP', 'lanelleUP', 24, false);
				animation.addByPrefix('singRIGHT', 'lanelleRIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'lanelleDOWN', 24, false);
				animation.addByPrefix('singLEFT', 'lanelleLEFT', 24, false);
			
				addOffset('idle', -2, 4);
				addOffset('singUP', -84, 32);
				addOffset("singRIGHT", 80, -46);
				addOffset("singLEFT", 81, -15);
				addOffset("singDOWN", 0, -42 );
								
				playAnim('idle');

			case 'bfandpico':
				tex = Paths.getSparrowAtlas('characters/bfAndPico_assets');
				frames = tex;

				animation.addByPrefix('idle', 'BfPicoIDLE', 24, false);
				animation.addByPrefix('singUP', 'BfPicoUP', 24, false);
				animation.addByPrefix('singRIGHT', 'BfPicoRIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'BfPicoDOWN', 24, false);
				animation.addByPrefix('singLEFT', 'BfPicoLEFT', 24, false);
		
				animation.addByPrefix('singUPmiss', 'BfPicoUMISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BfPicoLMISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BfPicoRMISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BfPicoDMISS', 24, false);
		
				animation.addByPrefix('singUP-alt', 'PicoBfUP', 24, false);
				animation.addByPrefix('singDOWN-alt', 'PicoBfDOWN', 24, false);
				animation.addByPrefix('singLEFT-alt', 'PicoBfLEFT', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'PicoBfRIGHT', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);				
				
				addOffset('idle');
				addOffset("singUP", 38, 27);
				addOffset("singRIGHT",-41,1);
				addOffset("singLEFT",83,-12);
				addOffset("singDOWN",104,-82);
			
				addOffset("singUP-alt");
				addOffset("singRIGHT-alt");
				addOffset("singLEFT-alt");
				addOffset("singDOWN-alt");
		
				addOffset("singUPmiss",38,66);
				addOffset("singRIGHTmiss",-38,46);
				addOffset("singLEFTmiss",79,23);
				addOffset("singDOWNmiss",101,-36);

				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);		
				
				playAnim('idle');						

				flipX = true;
//sex
			case 'gf-playable':
				tex = Paths.getSparrowAtlas('characters/gf_ass_sets');
				frames = tex;
				animation.addByPrefix('idle', 'gf idle', 24, false);
				animation.addByPrefix('singUP', 'gf noteU', 24, false);
				animation.addByPrefix('singLEFT', 'gf noteR', 24, false);
				animation.addByPrefix('singRIGHT', 'gf noteL', 24, false);
				animation.addByPrefix('singDOWN', 'gf noteD', 24, false);
				
				animation.addByPrefix('singUPmiss', 'gf missUp', 24, false);
				animation.addByPrefix('singLEFTmiss', 'gf missRight', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'gf missLeft', 24, false);
				animation.addByPrefix('singDOWNmiss', 'gf missDown', 24, false);
		
				animation.addByPrefix('firstDeath', "FUCKYOUADOBEANIMATE", 24, false);
				animation.addByPrefix('deathLoop', "gfDEAD", 24, true);
				animation.addByPrefix('deathConfirm', "deathConfirm", 24, false);
		
				// i think you need to also do this for any new added poses but im not sure, haven't tried
				addOffset('idle');
				addOffset("singUP", 32, 9);
				addOffset("singRIGHT",-55,0);
				addOffset("singLEFT",8,4);
				addOffset("singDOWN",7,-29);
		
				addOffset("singUPmiss",32, 9);
				addOffset("singRIGHTmiss",-55,0);
				addOffset("singLEFTmiss",8,4);
				addOffset("singDOWNmiss", 7,-29);
		
				addOffset("firstDeath",34, 4);
				addOffset("deathLoop",22, 0);
				addOffset("deathConfirm",20,0);
		
				playAnim('idle');
	
				playAnim('idle');
	
				flipX = true;
			case 'proto-lane':
				tex = Paths.getSparrowAtlas('characters/LaneMinus');
				frames = tex;
				animation.addByPrefix('idle', 'lane idle', 24, false);
				animation.addByPrefix('singUP', 'minusLaneUP', 24, false);
				animation.addByPrefix('singRIGHT', 'MinusLane_RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'MinusLane_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'MinusLane_LEFT', 24, false); 
		
				animation.addByPrefix('singUPmiss', 'MinusLaneMissU', 24, false);
				animation.addByPrefix('singLEFTmiss', 'MinusLaneMissL', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'MinusLaneMissR', 24, false);
				animation.addByPrefix('singDOWNmiss', 'MinusLaneMissD', 24, false);
		
				animation.addByPrefix('firstDeath', "MinusLaneDead1", 24, false);
				animation.addByPrefix('deathLoop', "MinusLaneDEADwait", 24, true);
				animation.addByPrefix('deathConfirm', "retry confirm", 24, false);
				addOffset('idle');

				addOffset("singUP", -3, 47);
				addOffset("singRIGHT",-76,12);
				addOffset("singLEFT",83,63);
				addOffset("singDOWN",-89,-75);
			
				addOffset("singUPmiss",-3, 47);
				addOffset("singRIGHTmiss",-76,12);
				addOffset("singLEFTmiss",83,63);
				addOffset("singDOWNmiss",-89,-75);
				
				addOffset("firstDeath",55, 146);
				addOffset("deathLoop",-183, -178);
				addOffset("deathConfirm",-106,-89);
	
				playAnim('idle');
	
			case 'proto-lane-playable':
				tex = Paths.getSparrowAtlas('characters/LaneMinusPlayable');
				frames = tex;
				animation.addByPrefix('idle', 'lane idle', 24, false);
				animation.addByPrefix('singUP', 'minusLaneUP', 24, false);
				animation.addByPrefix('singRIGHT', 'MinusLane_RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'MinusLane_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'MinusLane_LEFT', 24, false); 
		
				animation.addByPrefix('singUPmiss', 'MinusLaneMissU', 24, false);
				animation.addByPrefix('singLEFTmiss', 'MinusLaneMissL', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'MinusLaneMissR', 24, false);
				animation.addByPrefix('singDOWNmiss', 'MinusLaneMissD', 24, false);
		
				animation.addByPrefix('firstDeath', "MinusLaneDead1", 24, false);
				animation.addByPrefix('deathLoop', "retry brain loop", 24, true);
				animation.addByPrefix('deathConfirm', "retry confirm", 24, false);
				addOffset('idle');

				addOffset("singUP", -27, 45);
				addOffset("singLEFT",1,11);
				addOffset("singRIGHT",-89,62);
				addOffset("singDOWN",-74,-78);
			
				addOffset("singUPmiss",-27, 45);
				addOffset("singLEFTmiss",1,11);
				addOffset("singRIGHTmiss",-89,62);
				addOffset("singDOWNmiss",-74,-78);
				
				addOffset("firstDeath",157, 137);
				addOffset("deathLoop",-135, -193);
				addOffset("deathConfirm",-57,-105);
	
				playAnim('idle');
				flipX = true;
			case 'kapi':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/kapi');
				frames = tex;
				animation.addByIndices('idle', 'Dad idle dance', [2, 4, 6, 8, 10, 0], "", 12, false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);
				animation.addByPrefix('meow', 'Dad meow', 24, false);
				animation.addByPrefix('stare', 'Dad stare', 24, false);
				
				addOffset('idle');
				
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				addOffset("stare");
				addOffset("meow");
				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
