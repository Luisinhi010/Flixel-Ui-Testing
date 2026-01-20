package states;

import backend.ResponsiveUI.*;
import backend.ResponsiveUI;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * Example state demonstrating all ResponsiveUI components.
 * Shows buttons, cards, badges, progress bars, alerts, and toggles.
 */
class UIComponentsExampleState extends ResponsiveState
{
	private var infoText:FlxText;
	private var progressBar:UIProgressBar;
	private var currentProgress:Float = 0;
	private var currentY:Float;
	
	override public function create():Void
	{
		super.create();
		
		// Background
		setBackgroundColor(FlxColor.fromRGB(30, 30, 35));
		
		// Title
		var title = new FlxText(0, 20, screenWidth, "UI Components Demo");
		title.setFormat(null, getResponsiveFontSize(28), FlxColor.WHITE, CENTER);
		add(title);
		
		// Info text
		infoText = new FlxText(0, title.y + 40, screenWidth, "Explore Bootstrap-style responsive components");
		infoText.setFormat(null, getResponsiveFontSize(14), FlxColor.CYAN, CENTER);
		add(infoText);
		
		currentY = infoText.y + 60;
		
		// === BUTTONS SECTION ===
		createButtonsSection(currentY);
		currentY += 200;
		
		// === CARDS SECTION ===
		createCardsSection(currentY);
		currentY += 300;
		
		// === BADGES SECTION ===
		createBadgesSection(currentY);
		currentY += 100;
		
		// === PROGRESS BARS SECTION ===
		createProgressSection(currentY);
		currentY += 150;
		
		// === ALERTS SECTION ===
		createAlertsSection(currentY);
		currentY += 250;
		
		// === TOGGLES SECTION ===
		createTogglesSection(currentY);
		currentY += 100;
		
		// Configure scroll
		setMaxScroll(currentY - screenHeight + 100);
		scroll.showScrollbar = true;
		addScroll();
	}
	
	private function createButtonsSection(startY:Float):Void
	{
		var sectionTitle = new FlxText(getContentX(), startY, getContentWidth(), "Buttons");
		sectionTitle.setFormat(null, getResponsiveFontSize(20), FlxColor.LIME, LEFT);
		add(sectionTitle);
		
		var y = startY + 35;
		var x = getCenterX(0);
		
		// Button styles - row 1
		var styles = [PRIMARY, SUCCESS, DANGER];
		var labels = ["Primary", "Success", "Danger"];
		var spacing = 20;
		
		for (i in 0...styles.length)
		{
			var btn = ResponsiveUI.createButton(labels[i], function() {
				trace('${labels[i]} button clicked!');
				updateInfo('${labels[i]} button clicked!');
			}, styles[i], MEDIUM, layout);
			
			var totalWidth = (150 * layout.getResponsiveScale()) * styles.length + spacing * (styles.length - 1);
			var btnX = getCenterX(totalWidth) + i * (150 * layout.getResponsiveScale() + spacing);
			btn.x = btnX;
			btn.y = y;
			add(btn);
		}
		
		y += 60;
		
		// Button styles - row 2
		var styles2 = [WARNING, INFO, SECONDARY];
		var labels2 = ["Warning", "Info", "Secondary"];
		
		for (i in 0...styles2.length)
		{
			var btn = ResponsiveUI.createButton(labels2[i], function() {
				trace('${labels2[i]} button clicked!');
				updateInfo('${labels2[i]} button clicked!');
			}, styles2[i], MEDIUM, layout);
			
			var totalWidth = (150 * layout.getResponsiveScale()) * styles2.length + spacing * (styles2.length - 1);
			var btnX = getCenterX(totalWidth) + i * (150 * layout.getResponsiveScale() + spacing);
			btn.x = btnX;
			btn.y = y;
			add(btn);
		}
		
		y += 60;
		
		// Button sizes
		var smallBtn = ResponsiveUI.createButton("Small", function() {
			updateInfo("Small button!");
		}, PRIMARY, SMALL, layout);
		smallBtn.x = getCenterX(smallBtn.width) - 100;
		smallBtn.y = y;
		add(smallBtn);
		
		var mediumBtn = ResponsiveUI.createButton("Medium", function() {
			updateInfo("Medium button!");
		}, PRIMARY, MEDIUM, layout);
		mediumBtn.x = getCenterX(mediumBtn.width);
		mediumBtn.y = y;
		add(mediumBtn);
		
		var largeBtn = ResponsiveUI.createButton("Large", function() {
			updateInfo("Large button!");
		}, PRIMARY, LARGE, layout);
		largeBtn.x = getCenterX(largeBtn.width) + 100;
		largeBtn.y = y;
		add(largeBtn);
	}
	
	private function createCardsSection(startY:Float):Void
	{
		var sectionTitle = new FlxText(getContentX(), startY, getContentWidth(), "Cards");
		sectionTitle.setFormat(null, getResponsiveFontSize(20), FlxColor.LIME, LEFT);
		add(sectionTitle);
		
		var y = startY + 35;
		
		// Create 3 cards
		var cardWidth = isMobile() ? getContentWidth() : getContentWidth() / 3 - 20;
		var cardHeight = 200;
		
		for (i in 0...3)
		{
			var card = ResponsiveUI.createCard('Card ${i + 1}', cardWidth, cardHeight, layout);
			
			if (isMobile())
			{
				card.x = getContentX();
				card.y = y + i * (cardHeight + 20);
			}
			else
			{
				card.x = getContentX() + i * (cardWidth + 20);
				card.y = y;
			}
			
			add(card);
			
			// Add content to card
			var content = new FlxText(card.x + card.contentPadding, card.getContentY(), card.getContentWidth(),
				'This is card ${i + 1} content.\n\nCards are great for organizing UI elements.');
			content.setFormat(null, getResponsiveFontSize(12), FlxColor.GRAY, LEFT);
			add(content);
		}
	}
	
	private function createBadgesSection(startY:Float):Void
	{
		var sectionTitle = new FlxText(getContentX(), startY, getContentWidth(), "Badges");
		sectionTitle.setFormat(null, getResponsiveFontSize(20), FlxColor.LIME, LEFT);
		add(sectionTitle);
		
		var y = startY + 35;
		var x = getCenterX(0);
		
		var styles:Array<BadgeStyle> = [PRIMARY, SUCCESS, DANGER, WARNING, INFO];
		var labels = ["Primary", "Success", "Danger", "Warning", "Info"];
		var spacing = 10;
		var currentX = getContentX();
		
		for (i in 0...styles.length)
		{
			var badge = ResponsiveUI.createBadge(labels[i], styles[i], layout);
			badge.x = currentX;
			badge.y = y;
			add(badge);
			
			currentX += badge.width + spacing;
		}
	}
	
	private function createProgressSection(startY:Float):Void
	{
		var sectionTitle = new FlxText(getContentX(), startY, getContentWidth(), "Progress Bars");
		sectionTitle.setFormat(null, getResponsiveFontSize(20), FlxColor.LIME, LEFT);
		add(sectionTitle);
		
		var y = startY + 35;
		var barWidth = getContentWidth() * 0.8;
		var barHeight = 25;
		
		// Different progress values and styles
		var progresses = [0.25, 0.5, 0.75, 1.0];
		var styles:Array<ProgressStyle> = [SUCCESS, INFO, WARNING, DANGER];
		var labels = ["25% - Success", "50% - Info", "75% - Warning", "100% - Danger"];
		
		for (i in 0...progresses.length)
		{
			var label = new FlxText(getCenterX(barWidth), y, barWidth, labels[i]);
			label.setFormat(null, getResponsiveFontSize(12), FlxColor.WHITE, LEFT);
			add(label);
			
			var bar = ResponsiveUI.createProgressBar(barWidth, barHeight, progresses[i], styles[i], layout);
			bar.x = getCenterX(barWidth);
			bar.y = y + 20;
			add(bar);
			
			if (i == 1) // Store the second bar for animation
			{
				progressBar = bar;
			}
			
			y += 50;
		}
	}
	
	private function createAlertsSection(startY:Float):Void
	{
		var sectionTitle = new FlxText(getContentX(), startY, getContentWidth(), "Alerts");
		sectionTitle.setFormat(null, getResponsiveFontSize(20), FlxColor.LIME, LEFT);
		add(sectionTitle);
		
		var y = startY + 35;
		var alertWidth = getContentWidth() * 0.9;
		
		var styles:Array<AlertStyle> = [SUCCESS, INFO, WARNING, DANGER];
		var messages = [
			"Success! Your operation completed successfully.",
			"Info: This is an informational message.",
			"Warning: Please review this important notice.",
			"Danger! Critical error occurred."
		];
		
		for (i in 0...styles.length)
		{
			var alert = ResponsiveUI.createAlert(messages[i], alertWidth, styles[i], layout);
			alert.x = getCenterX(alertWidth);
			alert.y = y;
			add(alert);
			
			y += alert.height + 15;
		}
	}
	
	private function createTogglesSection(startY:Float):Void
	{
		var sectionTitle = new FlxText(getContentX(), startY, getContentWidth(), "Toggle Switches");
		sectionTitle.setFormat(null, getResponsiveFontSize(20), FlxColor.LIME, LEFT);
		add(sectionTitle);
		
		var y = startY + 35;
		
		// Toggle 1 - ON
		var toggle1Label = new FlxText(getContentX(), y, 200, "Enabled:");
		toggle1Label.setFormat(null, getResponsiveFontSize(14), FlxColor.WHITE, LEFT);
		add(toggle1Label);
		
		var toggle1 = ResponsiveUI.createToggle(true, function(isOn:Bool) {
			trace('Toggle 1 is now ${isOn ? "ON" : "OFF"}');
			updateInfo('Toggle 1: ${isOn ? "ON" : "OFF"}');
		}, layout);
		toggle1.x = toggle1Label.x + toggle1Label.width + 10;
		toggle1.y = y;
		add(toggle1);
		
		// Toggle 2 - OFF
		var toggle2Label = new FlxText(toggle1.x + toggle1.width + 50, y, 200, "Disabled:");
		toggle2Label.setFormat(null, getResponsiveFontSize(14), FlxColor.WHITE, LEFT);
		add(toggle2Label);
		
		var toggle2 = ResponsiveUI.createToggle(false, function(isOn:Bool) {
			trace('Toggle 2 is now ${isOn ? "ON" : "OFF"}');
			updateInfo('Toggle 2: ${isOn ? "ON" : "OFF"}');
		}, layout);
		toggle2.x = toggle2Label.x + toggle2Label.width + 10;
		toggle2.y = y;
		add(toggle2);
	}
	
	private function updateInfo(text:String):Void
	{
		if (infoText != null)
		{
			infoText.text = text;
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		// Animate progress bar
		if (progressBar != null)
		{
			currentProgress += elapsed * 0.2;
			if (currentProgress > 1)
				currentProgress = 0;
			progressBar.setProgress(currentProgress);
		}
		
		// ESC to go back
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(DebugState.new);
		}
	}
	override public function onResizeContent():Void
	{
		setMaxScroll(currentY - screenHeight + 100);
	}
	
	override private function printStateSpecificInfo():Void
	{
		trace("=== UI Components Example State ===");
		trace("Device Type: " + getDeviceType());
		trace("Screen: " + Std.int(screenWidth) + "x" + Std.int(screenHeight));
		trace("Responsive Scale: " + layout.getResponsiveScale());
		trace("---");
		trace("Components Demonstrated:");
		trace("  - Buttons (8 styles, 3 sizes)");
		trace("  - Cards (3 examples)");
		trace("  - Badges (5 styles)");
		trace("  - Progress Bars (4 styles, animated)");
		trace("  - Alerts (4 styles)");
		trace("  - Toggle Switches (2 examples)");
		trace("---");
		trace("Controls:");
		trace("  ESC: Return to Debug State");
		trace("  F6: Show debug info");
		trace("  Mouse: Click buttons and toggles");
	}
}
