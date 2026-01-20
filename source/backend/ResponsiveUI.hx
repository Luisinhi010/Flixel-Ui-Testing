package backend;

import core.utils.SpriteUtil;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * Bootstrap-style responsive UI components.
 * Provides buttons, cards, badges, and other reusable UI elements.
 */
class ResponsiveUI
{
	/**
	 * Create a responsive button with text and callback.
	 * @param text Button label text
	 * @param onClick Callback function when button is clicked
	 * @param style Button style (PRIMARY, SECONDARY, SUCCESS, DANGER, WARNING, INFO, LIGHT, DARK)
	 * @param size Button size (SMALL, MEDIUM, LARGE)
	 * @param layout ResponsiveLayout instance for sizing calculations
	 * @return Button group containing background and text
	 */
	public static function createButton(text:String, onClick:Void->Void, style:ButtonStyle = PRIMARY, size:ButtonSize = MEDIUM, 
		layout:ResponsiveLayout):UIButton
	{
		var buttonGroup = new UIButton();
		
		// Calculate dimensions based on size and device
		var dimensions = getButtonDimensions(size, layout);
		var fontSize = getButtonFontSize(size, layout);
		
		// Create button background with style colors
		var colors = getButtonColors(style);
		var bg = SpriteUtil.createColoredSprite(Std.int(dimensions.width), Std.int(dimensions.height), colors.bg);
		buttonGroup.add(bg);
		buttonGroup.background = bg;
		
		// Create button text
		var label = new FlxText(0, 0, dimensions.width, text);
		label.setFormat(null, fontSize, colors.text, CENTER);
		label.y = (dimensions.height - label.height) / 2; // Center vertically
		buttonGroup.add(label);
		buttonGroup.label = label;
		
		// Store properties
		buttonGroup.onClick = onClick;
		buttonGroup.style = style;
		buttonGroup.size = size;
		buttonGroup.defaultColor = colors.bg;
		buttonGroup.hoverColor = colors.hover;
		buttonGroup.pressedColor = colors.pressed;
		buttonGroup.disabledColor = colors.disabled;
		
		return buttonGroup;
	}
	
	/**
	 * Create a button with an icon (uses text characters for now).
	 * @param icon Icon character/text
	 * @param text Button label text
	 * @param onClick Callback function
	 * @param style Button style
	 * @param size Button size
	 * @param layout ResponsiveLayout instance
	 * @return Button group with icon and text
	 */
	public static function createIconButton(icon:String, text:String, onClick:Void->Void, style:ButtonStyle = PRIMARY, 
		size:ButtonSize = MEDIUM, layout:ResponsiveLayout):UIButton
	{
		var buttonGroup = new UIButton();
		
		var dimensions = getButtonDimensions(size, layout);
		var fontSize = getButtonFontSize(size, layout);
		
		var colors = getButtonColors(style);
		var bg = SpriteUtil.createColoredSprite(Std.int(dimensions.width), Std.int(dimensions.height), colors.bg);
		buttonGroup.add(bg);
		buttonGroup.background = bg;
		
		// Icon text
		var iconText = new FlxText(10, 0, 0, icon);
		iconText.setFormat(null, fontSize, colors.text, LEFT);
		iconText.y = (dimensions.height - iconText.height) / 2;
		buttonGroup.add(iconText);
		
		// Label text
		var label = new FlxText(iconText.x + iconText.width + 10, 0, dimensions.width - iconText.width - 30, text);
		label.setFormat(null, fontSize, colors.text, LEFT);
		label.y = (dimensions.height - label.height) / 2;
		buttonGroup.add(label);
		buttonGroup.label = label;
		
		buttonGroup.onClick = onClick;
		buttonGroup.style = style;
		buttonGroup.size = size;
		buttonGroup.defaultColor = colors.bg;
		buttonGroup.hoverColor = colors.hover;
		buttonGroup.pressedColor = colors.pressed;
		buttonGroup.disabledColor = colors.disabled;
		
		return buttonGroup;
	}
	
	/**
	 * Create a card container with title and content area.
	 * @param title Card title
	 * @param width Card width
	 * @param height Card height
	 * @param layout ResponsiveLayout instance
	 * @return Card group with background, title, and content area
	 */
	public static function createCard(title:String, width:Float, height:Float, layout:ResponsiveLayout):UICard
	{
		var card = new UICard();
		
		var fontSize = layout.getResponsiveFontSize(18);
		var padding = layout.getResponsiveSpacing(15);
		
		// Card background
		var bg = SpriteUtil.createColoredSprite(Std.int(width), Std.int(height), FlxColor.fromRGB(50, 50, 60));
		card.add(bg);
		card.background = bg;
		
		// Card border/outline effect (darker border)
		var border = SpriteUtil.createColoredSprite(Std.int(width), 2, FlxColor.fromRGB(70, 70, 80));
		card.add(border);
		
		// Title background
		var titleHeight = fontSize + padding * 2;
		var titleBg = SpriteUtil.createColoredSprite(Std.int(width), Std.int(titleHeight), FlxColor.fromRGB(60, 60, 70));
		card.add(titleBg);
		
		// Title text
		var titleText = new FlxText(padding, padding, width - padding * 2, title);
		titleText.setFormat(null, fontSize, FlxColor.WHITE, LEFT);
		card.add(titleText);
		card.title = titleText;
		
		// Content area position (below title)
		card.contentY = titleHeight;
		card.contentPadding = padding;
		
		return card;
	}
	
	/**
	 * Create a badge/label component.
	 * @param text Badge text
	 * @param style Badge style
	 * @param layout ResponsiveLayout instance
	 * @return Badge sprite group
	 */
	public static function createBadge(text:String, style:BadgeStyle = INFO, layout:ResponsiveLayout):UIBadge
	{
		var badge = new UIBadge();
		
		var fontSize = layout.getResponsiveFontSize(12);
		var padding = layout.getResponsiveSpacing(8);
		
		// Calculate badge size based on text
		var tempText = new FlxText(0, 0, 0, text);
		tempText.setFormat(null, fontSize);
		var textWidth = tempText.width;
		var textHeight = tempText.height;
		
		var badgeWidth = textWidth + padding * 2;
		var badgeHeight = textHeight + padding;
		
		var colors = getBadgeColors(style);
		
		// Badge background
		var bg = SpriteUtil.createColoredSprite(Std.int(badgeWidth), Std.int(badgeHeight), colors.bg);
		badge.add(bg);
		badge.background = bg;
		
		// Badge text
		var label = new FlxText(padding, padding / 2, textWidth, text);
		label.setFormat(null, fontSize, colors.text, CENTER);
		badge.add(label);
		badge.label = label;
		
		badge.style = style;
		
		return badge;
	}
	
	/**
	 * Create a progress bar.
	 * @param width Bar width
	 * @param height Bar height
	 * @param progress Initial progress (0-1)
	 * @param style Progress bar style
	 * @param layout ResponsiveLayout instance
	 * @return Progress bar group
	 */
	public static function createProgressBar(width:Float, height:Float, progress:Float = 0, style:ProgressStyle = SUCCESS, 
		layout:ResponsiveLayout):UIProgressBar
	{
		var progressBar = new UIProgressBar();
		
		// Background (empty bar)
		var bg = SpriteUtil.createColoredSprite(Std.int(width), Std.int(height), FlxColor.fromRGB(40, 40, 50));
		progressBar.add(bg);
		progressBar.background = bg;
		
		// Progress fill
		var colors = getProgressColors(style);
		var fillWidth = width * progress;
		var fill = SpriteUtil.createColoredSprite(Std.int(fillWidth), Std.int(height), colors.fill);
		progressBar.add(fill);
		progressBar.fill = fill;
		
		progressBar.maxWidth = width;
		progressBar.progress = progress;
		progressBar.style = style;
		
		return progressBar;
	}
	
	/**
	 * Create an alert/notification box.
	 * @param message Alert message
	 * @param width Alert width
	 * @param style Alert style
	 * @param layout ResponsiveLayout instance
	 * @return Alert sprite group
	 */
	public static function createAlert(message:String, width:Float, style:AlertStyle = INFO, layout:ResponsiveLayout):UIAlert
	{
		var alert = new UIAlert();
		
		var fontSize = layout.getResponsiveFontSize(14);
		var padding = layout.getResponsiveSpacing(15);
		
		// Calculate height based on text
		var tempText = new FlxText(0, 0, width - padding * 2, message);
		tempText.setFormat(null, fontSize);
		var textHeight = tempText.height;
		var alertHeight = textHeight + padding * 2;
		
		var colors = getAlertColors(style);
		
		// Alert background
		var bg = SpriteUtil.createColoredSprite(Std.int(width), Std.int(alertHeight), colors.bg);
		SpriteUtil.setAlpha(bg, 0.9);
		alert.add(bg);
		alert.background = bg;
		
		// Border accent
		var border = SpriteUtil.createColoredSprite(4, Std.int(alertHeight), colors.accent);
		alert.add(border);
		
		// Alert text
		var label = new FlxText(padding + 10, padding, width - padding * 2 - 10, message);
		label.setFormat(null, fontSize, colors.text, LEFT);
		alert.add(label);
		alert.message = label;
		
		alert.style = style;
		
		return alert;
	}
	
	/**
	 * Create a toggle switch.
	 * @param initialState Initial toggle state (true = on, false = off)
	 * @param onToggle Callback when toggled (receives new state)
	 * @param layout ResponsiveLayout instance
	 * @return Toggle switch group
	 */
	public static function createToggle(initialState:Bool, onToggle:Bool->Void, layout:ResponsiveLayout):UIToggle
	{
		var toggle = new UIToggle();
		
		var scale = layout.getResponsiveScale();
		var width = 50 * scale;
		var height = 26 * scale;
		var knobSize = 20 * scale;
		
		// Track background
		var trackColor = initialState ? FlxColor.fromRGB(40, 167, 69) : FlxColor.fromRGB(108, 117, 125);
		var track = SpriteUtil.createColoredSprite(Std.int(width), Std.int(height), trackColor);
		toggle.add(track);
		toggle.track = track;
		
		// Knob
		var knobX = initialState ? (width - knobSize - 3) : 3;
		var knob = SpriteUtil.createColoredSprite(Std.int(knobSize), Std.int(knobSize), FlxColor.WHITE);
		SpriteUtil.setPosition(knob, knobX, (height - knobSize) / 2);
		toggle.add(knob);
		toggle.knob = knob;
		
		toggle.isOn = initialState;
		toggle.onToggle = onToggle;
		toggle.onColor = FlxColor.fromRGB(40, 167, 69);
		toggle.offColor = FlxColor.fromRGB(108, 117, 125);
		
		return toggle;
	}
	
	// Helper functions for dimensions and colors
	
	private static function getButtonDimensions(size:ButtonSize, layout:ResponsiveLayout):{width:Float, height:Float}
	{
		var scale = layout.getResponsiveScale();
		return switch (size)
		{
			case SMALL: {width: 100 * scale, height: 32 * scale};
			case MEDIUM: {width: 150 * scale, height: 40 * scale};
			case LARGE: {width: 200 * scale, height: 50 * scale};
		}
	}
	
	private static function getButtonFontSize(size:ButtonSize, layout:ResponsiveLayout):Int
	{
		var baseSize = switch (size)
		{
			case SMALL: 12;
			case MEDIUM: 14;
			case LARGE: 18;
		}
		return layout.getResponsiveFontSize(baseSize);
	}
	
	private static function getButtonColors(style:ButtonStyle):{bg:FlxColor, text:FlxColor, hover:FlxColor, pressed:FlxColor, disabled:FlxColor}
	{
		return switch (style)
		{
			case PRIMARY: {
				bg: FlxColor.fromRGB(0, 123, 255),
				text: FlxColor.WHITE,
				hover: FlxColor.fromRGB(0, 105, 217),
				pressed: FlxColor.fromRGB(0, 86, 179),
				disabled: FlxColor.fromRGB(100, 150, 200)
			};
			case SECONDARY: {
				bg: FlxColor.fromRGB(108, 117, 125),
				text: FlxColor.WHITE,
				hover: FlxColor.fromRGB(90, 98, 104),
				pressed: FlxColor.fromRGB(72, 79, 83),
				disabled: FlxColor.fromRGB(150, 155, 160)
			};
			case SUCCESS: {
				bg: FlxColor.fromRGB(40, 167, 69),
				text: FlxColor.WHITE,
				hover: FlxColor.fromRGB(33, 136, 56),
				pressed: FlxColor.fromRGB(27, 110, 45),
				disabled: FlxColor.fromRGB(120, 190, 135)
			};
			case DANGER: {
				bg: FlxColor.fromRGB(220, 53, 69),
				text: FlxColor.WHITE,
				hover: FlxColor.fromRGB(200, 35, 51),
				pressed: FlxColor.fromRGB(176, 29, 44),
				disabled: FlxColor.fromRGB(230, 130, 140)
			};
			case WARNING: {
				bg: FlxColor.fromRGB(255, 193, 7),
				text: FlxColor.fromRGB(30, 30, 30),
				hover: FlxColor.fromRGB(228, 173, 6),
				pressed: FlxColor.fromRGB(200, 152, 5),
				disabled: FlxColor.fromRGB(255, 215, 100)
			};
			case INFO: {
				bg: FlxColor.fromRGB(23, 162, 184),
				text: FlxColor.WHITE,
				hover: FlxColor.fromRGB(19, 132, 150),
				pressed: FlxColor.fromRGB(15, 107, 122),
				disabled: FlxColor.fromRGB(120, 195, 210)
			};
			case LIGHT: {
				bg: FlxColor.fromRGB(248, 249, 250),
				text: FlxColor.fromRGB(30, 30, 30),
				hover: FlxColor.fromRGB(226, 227, 229),
				pressed: FlxColor.fromRGB(200, 201, 203),
				disabled: FlxColor.fromRGB(235, 236, 238)
			};
			case DARK: {
				bg: FlxColor.fromRGB(52, 58, 64),
				text: FlxColor.WHITE,
				hover: FlxColor.fromRGB(42, 47, 51),
				pressed: FlxColor.fromRGB(33, 37, 41),
				disabled: FlxColor.fromRGB(120, 125, 130)
			};
		}
	}
	
	private static function getBadgeColors(style:BadgeStyle):{bg:FlxColor, text:FlxColor}
	{
		return switch (style)
		{
			case PRIMARY: {bg: FlxColor.fromRGB(0, 123, 255), text: FlxColor.WHITE};
			case SECONDARY: {bg: FlxColor.fromRGB(108, 117, 125), text: FlxColor.WHITE};
			case SUCCESS: {bg: FlxColor.fromRGB(40, 167, 69), text: FlxColor.WHITE};
			case DANGER: {bg: FlxColor.fromRGB(220, 53, 69), text: FlxColor.WHITE};
			case WARNING: {bg: FlxColor.fromRGB(255, 193, 7), text: FlxColor.fromRGB(30, 30, 30)};
			case INFO: {bg: FlxColor.fromRGB(23, 162, 184), text: FlxColor.WHITE};
			case LIGHT: {bg: FlxColor.fromRGB(248, 249, 250), text: FlxColor.fromRGB(30, 30, 30)};
			case DARK: {bg: FlxColor.fromRGB(52, 58, 64), text: FlxColor.WHITE};
		}
	}
	
	private static function getProgressColors(style:ProgressStyle):{fill:FlxColor}
	{
		return switch (style)
		{
			case SUCCESS: {fill: FlxColor.fromRGB(40, 167, 69)};
			case INFO: {fill: FlxColor.fromRGB(23, 162, 184)};
			case WARNING: {fill: FlxColor.fromRGB(255, 193, 7)};
			case DANGER: {fill: FlxColor.fromRGB(220, 53, 69)};
		}
	}
	
	private static function getAlertColors(style:AlertStyle):{bg:FlxColor, accent:FlxColor, text:FlxColor}
	{
		return switch (style)
		{
			case SUCCESS: {
				bg: FlxColor.fromRGB(212, 237, 218),
				accent: FlxColor.fromRGB(40, 167, 69),
				text: FlxColor.fromRGB(21, 87, 36)
			};
			case INFO: {
				bg: FlxColor.fromRGB(209, 236, 241),
				accent: FlxColor.fromRGB(23, 162, 184),
				text: FlxColor.fromRGB(12, 84, 96)
			};
			case WARNING: {
				bg: FlxColor.fromRGB(255, 243, 205),
				accent: FlxColor.fromRGB(255, 193, 7),
				text: FlxColor.fromRGB(133, 100, 4)
			};
			case DANGER: {
				bg: FlxColor.fromRGB(248, 215, 218),
				accent: FlxColor.fromRGB(220, 53, 69),
				text: FlxColor.fromRGB(114, 28, 36)
			};
		}
	}
}

// UI Component Classes

/**
 * Interactive button component.
 */
class UIButton extends FlxSpriteGroup
{
	public var background:FlxSprite;
	public var label:FlxText;
	public var onClick:Void->Void;
	public var style:ButtonStyle;
	public var size:ButtonSize;
	public var enabled:Bool = true;
	
	// Colors for different states
	public var defaultColor:FlxColor;
	public var hoverColor:FlxColor;
	public var pressedColor:FlxColor;
	public var disabledColor:FlxColor;
	
	private var isHovered:Bool = false;
	private var isPressed:Bool = false;
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (!enabled)
		{
			background.color = disabledColor;
			return;
		}
		
		// Simple mouse interaction (assumes button is positioned correctly)
		var mouseX = flixel.FlxG.mouse.x;
		var mouseY = flixel.FlxG.mouse.y;
		
		var bounds = getBounds();
		isHovered = mouseX >= bounds.x && mouseX <= bounds.x + bounds.width &&
					mouseY >= bounds.y && mouseY <= bounds.y + bounds.height;
		
		if (isHovered)
		{
			if (flixel.FlxG.mouse.pressed)
			{
				isPressed = true;
				background.color = pressedColor;
			}
			else
			{
				if (isPressed && flixel.FlxG.mouse.justReleased && onClick != null)
				{
					onClick();
				}
				isPressed = false;
				background.color = hoverColor;
			}
		}
		else
		{
			isPressed = false;
			background.color = defaultColor;
		}
	}
	
	/**
	 * Set button enabled/disabled state.
	 */
	public function setEnabled(value:Bool):Void
	{
		enabled = value;
		if (!enabled)
		{
			background.color = disabledColor;
		}
	}
	
	/**
	 * Update button text.
	 */
	public function setText(text:String):Void
	{
		if (label != null)
		{
			label.text = text;
		}
	}
	
	private function getBounds():{x:Float, y:Float, width:Float, height:Float}
	{
		return {x: x, y: y, width: background.width, height: background.height};
	}
}

/**
 * Card container component.
 */
class UICard extends FlxSpriteGroup
{
	public var background:FlxSprite;
	public var title:FlxText;
	public var contentY:Float = 0;
	public var contentPadding:Float = 0;
	
	/**
	 * Get the Y position where content should start.
	 */
	public function getContentY():Float
	{
		return y + contentY;
	}
	
	/**
	 * Get available content width.
	 */
	public function getContentWidth():Float
	{
		return background.width - contentPadding * 2;
	}
}

/**
 * Badge/label component.
 */
class UIBadge extends FlxSpriteGroup
{
	public var background:FlxSprite;
	public var label:FlxText;
	public var style:BadgeStyle;
	
	/**
	 * Update badge text.
	 */
	public function setText(text:String):Void
	{
		if (label != null)
		{
			label.text = text;
		}
	}
}

/**
 * Progress bar component.
 */
class UIProgressBar extends FlxSpriteGroup
{
	public var background:FlxSprite;
	public var fill:FlxSprite;
	public var maxWidth:Float;
	public var progress:Float = 0;
	public var style:ProgressStyle;
	
	/**
	 * Update progress (0-1).
	 */
	public function setProgress(value:Float):Void
	{
		progress = core.utils.MathUtil.clamp(value, 0, 1);
		SpriteUtil.resize(fill, Std.int(maxWidth * progress), Std.int(background.height));
	}
	
	/**
	 * Animate progress change smoothly.
	 */
	public function animateProgress(targetValue:Float, duration:Float = 0.3):Void
	{
		var targetProgress = core.utils.MathUtil.clamp(targetValue, 0, 1);
		var startProgress = progress;
		flixel.tweens.FlxTween.num(startProgress, targetProgress, duration, {
			onUpdate: function(tween:flixel.tweens.FlxTween) {
				var currentValue = startProgress + (targetProgress - startProgress) * tween.percent;
				setProgress(currentValue);
			}
		});
	}
}

/**
 * Alert/notification component.
 */
class UIAlert extends FlxSpriteGroup
{
	public var background:FlxSprite;
	public var message:FlxText;
	public var style:AlertStyle;
	
	/**
	 * Update alert message.
	 */
	public function setMessage(text:String):Void
	{
		if (message != null)
		{
			message.text = text;
		}
	}
	
	/**
	 * Fade out and destroy the alert.
	 */
	public function dismiss(duration:Float = 0.3):Void
	{
		flixel.tweens.FlxTween.tween(this, {alpha: 0}, duration, {
			onComplete: function(_) {
				destroy();
			}
		});
	}
}

/**
 * Toggle switch component.
 */
class UIToggle extends FlxSpriteGroup
{
	public var track:FlxSprite;
	public var knob:FlxSprite;
	public var isOn:Bool = false;
	public var onToggle:Bool->Void;
	public var onColor:FlxColor;
	public var offColor:FlxColor;
	
	private var isAnimating:Bool = false;
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (isAnimating)
			return;
		
		var mouseX = flixel.FlxG.mouse.x;
		var mouseY = flixel.FlxG.mouse.y;
		
		var bounds = getBounds();
		var isHovered = mouseX >= bounds.x && mouseX <= bounds.x + bounds.width &&
						mouseY >= bounds.y && mouseY <= bounds.y + bounds.height;
		
		if (isHovered && flixel.FlxG.mouse.justPressed)
		{
			toggle();
		}
	}
	
	/**
	 * Toggle the switch state.
	 */
	public function toggle():Void
	{
		setOn(!isOn, true);
	}
	
	/**
	 * Set toggle state.
	 * @param value New state
	 * @param animate Whether to animate the transition
	 */
	public function setOn(value:Bool, animate:Bool = false):Void
	{
		if (isOn == value)
			return;
		
		isOn = value;
		
		var targetX = isOn ? (track.width - knob.width - 3) : 3;
		var targetColor = isOn ? onColor : offColor;
		
		if (animate)
		{
			isAnimating = true;
			flixel.tweens.FlxTween.tween(knob, {x: x + targetX}, 0.2, {
				onComplete: function(_) {
					isAnimating = false;
				}
			});
			flixel.tweens.FlxTween.color(track, 0.2, track.color, targetColor);
		}
		else
		{
			knob.x = x + targetX;
			track.color = targetColor;
		}
		
		if (onToggle != null)
		{
			onToggle(isOn);
		}
	}
	
	private function getBounds():{x:Float, y:Float, width:Float, height:Float}
	{
		return {x: x, y: y, width: track.width, height: track.height};
	}
}

// Enums for styles and sizes

enum ButtonStyle
{
	PRIMARY;
	SECONDARY;
	SUCCESS;
	DANGER;
	WARNING;
	INFO;
	LIGHT;
	DARK;
}

enum ButtonSize
{
	SMALL;
	MEDIUM;
	LARGE;
}

enum BadgeStyle
{
	PRIMARY;
	SECONDARY;
	SUCCESS;
	DANGER;
	WARNING;
	INFO;
	LIGHT;
	DARK;
}

enum ProgressStyle
{
	SUCCESS;
	INFO;
	WARNING;
	DANGER;
}

enum AlertStyle
{
	SUCCESS;
	INFO;
	WARNING;
	DANGER;
}
