package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var lanePortrait:FlxSprite;
	var gfportrait:FlxSprite;
	var bfportrait:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-400, -200).makeGraphic(Std.int(FlxG.width * 8), Std.int(FlxG.height * 8), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-880, 380);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'getting-freaky' | 'earth' | 'pollution' | 'beyond-the-stars':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);	
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		lanePortrait = new FlxSprite(-240, 40);
		lanePortrait.frames = Paths.getSparrowAtlas('laneportrait');
		lanePortrait.animation.addByPrefix('enter', 'Portrait Enter', 24, false);
		lanePortrait.updateHitbox();
		lanePortrait.scrollFactor.set();
		add(lanePortrait);
		lanePortrait.visible = false;

		bfportrait = new FlxSprite(0, 40);
		bfportrait.frames = Paths.getSparrowAtlas('bfportrait');
		bfportrait.animation.addByPrefix('enter', 'Portrait Enter', 24, false);
		bfportrait.updateHitbox();
		bfportrait.scrollFactor.set();
		add(bfportrait);
		bfportrait.visible = false;

		gfportrait = new FlxSprite(420, 40);
		gfportrait.frames = Paths.getSparrowAtlas('gfportrait');
		gfportrait.animation.addByPrefix('enter', 'Portrait Enter', 24, false);
		gfportrait.updateHitbox();
		gfportrait.scrollFactor.set();
		add(gfportrait);
		gfportrait.visible = false;

		box.animation.play('normalOpen');
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			box.y = 350;
			box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Pixel Arial 11 Bold';
			dropText.color = 0xFFD89494;
			add(dropText);

			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Pixel Arial 11 Bold';
			swagDialogue.color = 0xFF3F2021;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);

			dialogue = new Alphabet(0, 80, "", false, true);
		}
		// dialogue.x = 90;
		// add(dialogue);
		else
		{
			dropText = new FlxText(242, 508, Std.int(FlxG.width *0.6), "", 32);
			dropText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.BLACK, LEFT);
			add(dropText);
	
			swagDialogue = new FlxTypeText(242, 508, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.BLACK, LEFT);
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);
	
			dialogue = new Alphabet(0, 80, "", false, true);
		}

	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;
					
					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'pollution')
						FlxG.sound.music.fadeOut(2.2, 0);
					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						lanePortrait.visible = false;
						bfportrait.visible = false;
						gfportrait.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'gf':
				lanePortrait.visible = false;
				bfportrait.visible = false;

			if (!gfportrait.visible)
				{
					gfportrait.visible = true;
					gfportrait.animation.play('enter');
				}
			case 'lane':
				gfportrait.visible = false;
				bfportrait.visible = false;
				if (!lanePortrait.visible)
				{
					lanePortrait.visible = true;
					lanePortrait.animation.play('enter');
				}		
			case 'dad':
				lanePortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
				{
					lanePortrait.visible = false;
					gfportrait.visible = false;
					bfportrait.visible = false;			
					portraitLeft.visible = false;
					if (!portraitRight.visible)
						{
							portraitRight.visible = true;
							portraitRight.animation.play('enter');
						}
				} 
				else
				{
					lanePortrait.visible = false;
					gfportrait.visible = false;
					if (!bfportrait.visible)
						{
							bfportrait.visible = true;
							bfportrait.animation.play('enter');
						}
				}

		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
