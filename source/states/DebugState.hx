package states;

import flixel.FlxG;

class DebugState extends DefaultState
{
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// Open responsive example state
		if (FlxG.keys.justPressed.Y)
			FlxG.switchState(ResponsiveExampleState.new);
		// Open background example state
		if (FlxG.keys.justPressed.B)
			FlxG.switchState(BackgroundExampleState.new);
		// Open UI components example state
		if (FlxG.keys.justPressed.U)
			FlxG.switchState(UIComponentsExampleState.new);
	}
}
