# Responsive UI System Documentation

This is a comprehensive responsive UI system for HaxeFlixel projects, inspired by Bootstrap and modern web frameworks.

## Overview

The Responsive UI System provides a complete solution for creating adaptive, professional-looking interfaces in HaxeFlixel games. It includes layout management, scrolling, backgrounds, and pre-built UI components that automatically scale based on device type.

## Core Components

### 1. ResponsiveLayout (`backend/ResponsiveLayout.hx`)
Shared responsive layout system for states and substates with breakpoints, grid system, and safe areas.

**Key Features:**
- 12-column grid system (like Bootstrap)
- Device type detection (Mobile/Tablet/Desktop)
- Responsive breakpoints: Mobile (640px), Tablet (1024px), Desktop (1920px)
- Automatic scaling based on device type
- Safe area management for notches/cutouts

**Important Implementation Details:**
- Uses `MathUtil.clamp()` only when BOTH limits are required
- Internal helper methods:
  - `clampValue(value, min, max)` - Handles optional min/max with simple `if` checks; uses `MathUtil.clamp()` only when both are present
  - `validateColumnSpan(value, min, max)` - Uses `MathUtil.clampInt()` for integer validation (always has both limits)
  - `calculateColumnWidth(columns, totalWidth, gap)` - Centralized column width calculation
  - `validateSpacing()` - Ensures spacing values are non-negative using simple `if` checks (single limit only)

**Device Detection:**
```haxe
getDeviceType() // Returns MOBILE, TABLET, or DESKTOP
isMobile(), isTablet(), isDesktop() // Device type checks
isPortrait(), isLandscape() // Orientation checks
```

**Grid System (12-column):**
```haxe
getGridWidth(span) // Get width for column span
getGridX(column) // Get X position for column
getGridCellBounds(column, row, span, rowHeight) // Complete cell positioning
getMaxColumns(minColumnWidth) // Calculate max columns that fit
```

**Layout Helpers:**
```haxe
getColumnWidth(columns), getColumnX(columns, index) // Column layout
getCenterX(width), getCenterY(height) // Centering
maintainAspectRatio(targetW, targetH, maxW, maxH) // Aspect ratio preservation
```

**Responsive Scaling:**
```haxe
getResponsiveScale() // Scale factor based on device type
getResponsiveFontSize(baseSize) // Scale font sizes
getResponsiveSpacing(baseSpacing) // Scale spacing
getResponsiveDimensions(width, height) // Scale dimensions
```

**Safe Areas and Spacing:**
```haxe
setSafeAreas(top, bottom, left, right) // Configure safe areas with validation
resetSafeAreas() // Reset safe areas to zero
updateSpacing(padding, margin, columnGap, rowGap) // Update spacing with recalculation
calculateTotalSpacing(itemCount, gap) // Calculate total spacing needed
```

**Content Dimensions:**
```haxe
getContentWidth(), getContentHeight() // Available content area
getSafeContentWidth(), getSafeContentHeight() // Content area minus safe zones
// All dimensions validated to prevent negative values
```

---

### 2. ScrollSystem (`backend/ScrollSystem.hx`)
Complete scroll system with smooth scrolling, drag, keyboard, and scrollbar support.

**Key Features:**
- Mouse wheel scrolling (configurable speed)
- Drag scrolling with smooth tracking
- Keyboard: Arrow keys, PageUp/Down, Home/End
- Scrollbar with proportional sizing
- Top/bottom scroll indicators with fade effects
- Automatic repositioning on screen resize

**Code Quality:**
- Refactored to eliminate duplicate code
- Internal helper methods:
  - `validateScreenHeight(height)` - Validates screen height with fallback
  - `createColoredSprite(width, height, color, alpha)` - Creates sprites using 1x1 texture + scaling (GPU efficient)
  - `calculateIndicatorAlpha(distance)` - Calculates fade alpha for indicators using `MathUtil.clamp()` (always has both limits)
  - `clampScroll(value)` - Clamps scroll position to valid range using `MathUtil.clamp()` (always has both limits)
  - `calculateScrollbarHeight()` - Calculates proportional scrollbar height (eliminates duplication)
  - `calculateScrollbarY(scrollbarHeight)` - Calculates scrollbar Y position (eliminates duplication)
  - `positionScrollbarTrack()` - Positions scrollbar track at right edge (centralized positioning)
  - `resizeSprite(sprite, width, height)` - Resizes sprite efficiently without recreating graphics

**Scroll Control:**
```haxe
scrollTo(position, animated, onComplete) // Scroll to specific position with animation
scrollBy(deltaY, animated) // Scroll by delta amount
scrollToElement(y, height, margin) // Scroll to make element visible
setScrollProgress(progress, animated) // Set scroll by percentage (0-1)
resetScroll() // Reset to top
```

**Scroll State Queries:**
```haxe
getScrollProgress() // Current scroll progress (0-1)
isAtTop(), isAtBottom() // Check scroll position
isScrollable() // Check if content exceeds viewport
getViewportBounds() // Get current visible area bounds
getContentHeight() // Get total content height (viewport + scrollable area)
getScreenHeight() // Get viewport height
```

**Element Visibility:**
```haxe
isElementVisible(y, height) // Check if element is partially or fully in viewport
isElementPartiallyVisible(y, height) // Alias for isElementVisible() for clarity
isElementFullyVisible(y, height) // Check if entire element is in viewport
getElementVisibility(y, height) // Get visibility percentage (0-1)
```

**Configuration:**
```haxe
setMaxScroll(contentHeight) // Set maximum scroll distance
setInputEnabled(enabled) // Enable/disable all input methods
setUIVisibility(scrollbar, indicators) // Control UI visibility
updateScreenSize() // Handle screen size changes with scroll ratio preservation
repositionUI() // Reposition all UI elements (uses helper methods for efficiency)
```

---

### 3. ResponsiveBackground (`backend/ResponsiveBackground.hx`)
Complete background management system with automatic resizing.

**Key Features:**
- Solid colors, gradients, images, and parallax scrolling
- Automatic resizing on screen size changes
- Layer management with named layers
- Multiple scale modes for images

**Important Implementation Details:**
- Uses `MathUtil.clamp()` for alpha and scroll factor validation (always has both limits 0-1)
- Internal helper methods:
  - `clampAlpha(alpha)` - Uses `MathUtil.clamp()` for alpha validation (0-1, always has both limits)
  - `clampScrollFactor(factor)` - Uses `MathUtil.clamp()` for scroll factor validation (0-1, always has both limits)
  - `resizeGradient(layer)` - Resizes gradients preserving colors and orientation
  - `createGradient(color1, color2, vertical, alpha)` - Consolidated gradient creation

**Background Types:**
```haxe
createSolid(color, alpha) // Solid colors
createVerticalGradient(topColor, bottomColor, alpha) // Vertical gradients
createHorizontalGradient(leftColor, rightColor, alpha) // Horizontal gradients
createImage(imagePath, scaleMode, alpha) // Images
```

**Parallax Layers:**
```haxe
addParallaxLayer(imagePath, scrollFactor, scaleMode, alpha) // Image parallax
addParallaxColor(color, scrollFactor, alpha) // Color parallax
```

**Layer Management:**
```haxe
getLayer(name) // Get layer sprite by name
removeLayer(name) // Remove specific layer
setLayerAlpha(name, alpha) // Change layer transparency
hasLayer(name) // Check if layer exists
getLayerCount() // Get number of layers
```

**Scale Modes (ScaleMode enum):**
- `FIT` - Fit maintaining aspect ratio (may have borders)
- `FILL` - Fill maintaining aspect ratio (may crop)
- `STRETCH` - Stretch to fill (ignores aspect ratio)
- `NONE` - Keep original size

**Configuration:**
```haxe
setAutoResize(value) // Enable/disable automatic resizing
onResize(width, height) // Manual resize trigger
```

**Layer Metadata Tracking:**
- Each layer stores its type (SOLID, GRADIENT, IMAGE, PARALLAX)
- Gradients store orientation for correct resizing
- Proper FlxPoint memory management (get/put)

---

### 4. ResponsiveUI (`backend/ResponsiveUI.hx`)
Bootstrap-style UI components for creating professional interfaces.

**Component Types:**

#### Buttons
Interactive buttons with callbacks.
- **Styles:** PRIMARY, SECONDARY, SUCCESS, DANGER, WARNING, INFO, LIGHT, DARK
- **Sizes:** SMALL, MEDIUM, LARGE

```haxe
createButton(text, onClick, style, size, layout) // Standard button
createIconButton(icon, text, onClick, style, size, layout) // Button with icon
```

Features:
- Automatic hover/pressed states
- Enable/disable support

#### Cards
Container components with title and content area.

```haxe
createCard(title, width, height, layout) // Card with title bar
card.getContentY() // Get Y position for content
card.getContentWidth() // Get available content width
```

#### Badges
Small labels/tags for status indicators.
- **Styles:** PRIMARY, SECONDARY, SUCCESS, DANGER, WARNING, INFO, LIGHT, DARK

```haxe
createBadge(text, style, layout) // Auto-sized badge
badge.setText(text) // Update badge text
```

#### Progress Bars
Visual progress indicators.
- **Styles:** SUCCESS, INFO, WARNING, DANGER

```haxe
createProgressBar(width, height, progress, style, layout) // Progress bar (0-1)
progressBar.setProgress(value) // Update progress instantly
progressBar.animateProgress(targetValue, duration) // Smooth animated progress
```

#### Alerts
Notification boxes with styled borders.
- **Styles:** SUCCESS, INFO, WARNING, DANGER

```haxe
createAlert(message, width, style, layout) // Alert box
alert.setMessage(text) // Update alert message
alert.dismiss(duration) // Fade out and destroy
```

#### Toggles
Switch components for boolean states.

```haxe
createToggle(initialState, onToggle, layout) // Toggle switch
toggle.toggle() // Toggle state
toggle.setOn(value, animate) // Set specific state
```

Features:
- Automatic animation between states

**Usage Example:**
```haxe
// Create button with callback
var btn = ResponsiveUI.createButton("Click Me", function() {
    trace("Button clicked!");
}, PRIMARY, MEDIUM, layout);
btn.x = getCenterX(btn.width);
btn.y = 100;
add(btn);

// Create progress bar
var progress = ResponsiveUI.createProgressBar(300, 25, 0.5, SUCCESS, layout);
progress.animateProgress(1.0, 2.0); // Animate to 100% over 2 seconds

// Create toggle
var toggle = ResponsiveUI.createToggle(true, function(isOn:Bool) {
    trace('Toggle is ${isOn ? "ON" : "OFF"}');
}, layout);
```

**Component Classes:**
All return interactive `FlxSpriteGroup` subclasses:
- `UIButton` - Interactive button with hover/pressed states
- `UICard` - Card container with title and content area
- `UIBadge` - Badge/label component
- `UIProgressBar` - Progress bar with animation support
- `UIAlert` - Alert/notification box
- `UIToggle` - Toggle switch with animation

---

### 5. LayoutConstants (`backend/LayoutConstants.hx`)
Centralized constants for responsive layout system.

**Categories:**
- Screen size fallbacks: `DEFAULT_SCREEN_WIDTH`, `DEFAULT_SCREEN_HEIGHT`, `MIN_SCREEN_HEIGHT`
- UI positioning: `DEBUGGER_BOTTOM_OFFSET`, `MODAL_PADDING`, `MODAL_BUTTON_HEIGHT`, etc.
- Visibility thresholds: `SCROLL_SNAP_THRESHOLD`, `BOUNDS_INDICATOR_FADE_DISTANCE`, etc.
- Scroll speeds: `SCROLL_SPEED_BASE`, `SCROLL_SPEED_PAGE_MULTIPLIER`, `SMOOTH_SCROLL_SPEED`, etc.
- Scrollbar configuration: `SCROLLBAR_WIDTH`, `SCROLLBAR_PADDING`, `SCROLLBAR_MIN_HEIGHT`, etc.

**Best Practice:** Use these constants instead of hardcoding values for consistency.

---

## Base State Classes

### ResponsiveState
Base class for states with responsive layouts.

```haxe
class MyState extends ResponsiveState
{
    override public function create():Void
    {
        super.create();
        
        // Set background
        setBackgroundColor(FlxColor.BLACK);
        // or
        background.createImage("myBackground", FILL);
        
        // Use grid system
        var buttonWidth = getGridWidth(4); // 4 columns wide
        var buttonX = getGridX(4); // Start at column 4
        
        // Use responsive scaling
        var fontSize = getResponsiveFontSize(16);
        var padding = getResponsiveSpacing(20);
        
        // Create UI elements...
        
        // Set up scrolling if needed
        scroll.setMaxScroll(totalContentHeight);
        scroll.showScrollbar = true;
    }
    
    override public function onResizeContent():Void
    {
        // Handle custom content repositioning when screen resizes
    }
}
```

**Features:**
- Includes `ResponsiveLayout`, `ResponsiveBackground`, and `ScrollSystem`
- Override `onResizeContent()` to handle custom content repositioning
- Automatic screen resize handling

### ResponsiveSubState
Base class for substates/modals with responsive layouts.

```haxe
class MyModal extends ResponsiveSubState
{
    override public function create():Void
    {
        super.create();
        
        // Create modal content
        var card = ResponsiveUI.createCard("Modal Title", 400, 300, layout);
        card.x = getCenterX(400);
        card.y = getCenterY(300);
        add(card);
    }
    
    override public function onResizeContent():Void
    {
        // Reposition modal elements
    }
}
```

**Features:**
- Includes `ResponsiveLayout` and `ResponsiveBackground` (no scroll system)
- Override `onResizeContent()` to handle custom content repositioning
- Perfect for modal dialogs and popups

---

## Example States

### ResponsiveExampleState
Demonstrates grid system, responsive scaling, and scrolling.

**Features shown:**
- 12-column grid layout
- Responsive text sizing
- Scroll system with all input methods
- Screen resize handling

**Controls:**
- **ESC:** Return to previous state
- Resize window to see responsive layout adapt
- Scroll with mouse wheel, drag, or keyboard

### ResponsiveExampleSubState
Demonstrates modal dialogs with responsive sizing.

**Features shown:**
- Centered modal dialog
- Responsive button sizing
- Background dimming

### BackgroundExampleState
Demonstrates all ResponsiveBackground features.

**Controls:**
- **1:** Solid color background
- **2:** Vertical gradient background
- **3:** Horizontal gradient background
- **4:** Image background (if available)
- **5:** Animated parallax layers example
- **ESC:** Return to previous state

### UIComponentsExampleState
Complete demonstration of all ResponsiveUI components.

**Controls:**
- **ESC:** Return to previous state
- **Mouse:** Click buttons and toggles to interact
- **Scroll:** Navigate through all component examples

**Components demonstrated:**
- Buttons (all 8 styles and 3 sizes)
- Icon buttons
- Cards with content
- Badges
- Progress bars (with animation)
- Alerts (with dismiss functionality)
- Toggles (interactive switches)

---

## Integration Guide

### Adding to Your Project

1. **Copy the required files to your project:**
   ```
   source/backend/
   ├── ResponsiveLayout.hx
   ├── ResponsiveBackground.hx
   ├── ScrollSystem.hx
   ├── ResponsiveUI.hx
   └── LayoutConstants.hx
   
   source/states/
   ├── ResponsiveState.hx
   └── ResponsiveSubState.hx
   ```

2. **Ensure dependencies are available:**
   - `core/utils/MathUtil.hx`
   - `core/utils/StringUtil.hx`
   - `core/utils/ArrayUtil.hx`
   - `core/utils/SpriteUtil.hx`
   - `backend/Paths.hx` (for image loading)

3. **Create your first responsive state:**
   ```haxe
   package states;
   
   import flixel.util.FlxColor;
   import states.ResponsiveState;
   
   class MyGameState extends ResponsiveState
   {
       override public function create():Void
       {
           super.create();
           
           setBackgroundColor(FlxColor.fromRGB(30, 30, 40));
           
           // Your UI code here
       }
   }
   ```

### Best Practices

1. **Always extend ResponsiveState or ResponsiveSubState**
   - Don't extend FlxState/FlxSubState directly if you need responsive features

2. **Use the grid system for layouts**
   - More consistent than manual positioning
   - Automatically adapts to screen sizes

3. **Use ResponsiveUI for common components**
   - Consistent styling across your application
   - Pre-built interactive states

4. **Override onResizeContent() for custom repositioning**
   - This is called automatically when screen size changes
   - Recalculate positions for your custom elements

5. **Use responsive scaling functions**
   - `getResponsiveFontSize()` for text
   - `getResponsiveSpacing()` for margins/padding
   - `getResponsiveDimensions()` for element sizes

6. **Test on different screen sizes**
   - Test with mobile, tablet, and desktop breakpoints
   - Resize window to verify layout adapts correctly

7. **Use LayoutConstants for magic numbers**
   - Define your own constants for consistency
   - Easier to adjust globally

### Common Patterns

#### Creating a Menu Screen
```haxe
class MenuState extends ResponsiveState
{
    override public function create():Void
    {
        super.create();
        
        setBackgroundColor(FlxColor.fromRGB(20, 20, 30));
        
        // Title
        var title = new FlxText(0, 50, 0, "GAME TITLE", 48);
        title.x = getCenterX(title.width);
        add(title);
        
        // Buttons
        var buttonWidth = getGridWidth(4);
        var buttons = ["Play", "Options", "Quit"];
        var y = 200;
        
        for (text in buttons)
        {
            var btn = ResponsiveUI.createButton(text, function() {
                trace('Clicked: $text');
            }, PRIMARY, LARGE, layout);
            btn.x = getCenterX(buttonWidth);
            btn.y = y;
            add(btn);
            y += 80;
        }
    }
}
```

#### Creating a Settings Panel
```haxe
class SettingsState extends ResponsiveState
{
    override public function create():Void
    {
        super.create();
        
        var currentY = 20;
        var padding = getResponsiveSpacing(20);
        
        // Card container
        var card = ResponsiveUI.createCard("Settings", 600, 400, layout);
        card.x = getCenterX(600);
        card.y = getCenterY(400);
        add(card);
        
        // Settings inside card
        var contentY = card.getContentY();
        var contentX = card.x + 20;
        
        // Volume toggle
        var volumeLabel = new FlxText(contentX, contentY, 0, "Sound:");
        add(volumeLabel);
        
        var volumeToggle = ResponsiveUI.createToggle(true, function(on) {
            FlxG.sound.muted = !on;
        }, layout);
        volumeToggle.x = contentX + 200;
        volumeToggle.y = contentY;
        add(volumeToggle);
        
        // More settings...
    }
}
```

#### Creating a Scrollable List
```haxe
class ItemListState extends ResponsiveState
{
    override public function create():Void
    {
        super.create();
        
        var currentY = 20;
        var itemHeight = 80;
        var items = 20; // Number of items
        
        // Create list items
        for (i in 0...items)
        {
            var card = ResponsiveUI.createCard('Item ${i + 1}', 600, itemHeight, layout);
            card.x = getCenterX(600);
            card.y = currentY;
            add(card);
            
            currentY += itemHeight + 10;
        }
        
        // Set up scrolling
        scroll.setMaxScroll(currentY - FlxG.height + 50);
        scroll.showScrollbar = true;
    }
}
```

---

## Performance Considerations

1. **Efficient Colored Sprites**
   - ScrollSystem and ResponsiveBackground use `SpriteUtil.createColoredSprite()`
   - Creates only 1 pixel texture, GPU handles scaling
   - Much more memory efficient than `makeGraphic(width, height, color)`

2. **Sprite Resizing**
   - Use `SpriteUtil.resize()` for efficient resizing
   - Avoids recreating graphics unnecessarily

3. **Scroll Optimization**
   - Camera-based scrolling (via `FlxG.camera.scroll.y`)
   - No need to manually move all objects

4. **Layout Recalculation**
   - Only recalculate on screen resize, not every frame
   - Cache calculated values where possible

---

## Troubleshooting

### Scroll Not Working
**Issue:** Elements don't scroll or scroll incorrectly.

**Solution:**
- Position elements absolutely, not relative to scroll position
- Don't use `getContentY()` for initial positioning
- ResponsiveState applies scroll via camera
- Call `setMaxScroll()` before showing scrollbar

### Elements Not Responsive
**Issue:** Elements don't resize or reposition on screen size change.

**Solution:**
- Override `onResizeContent()` in your state
- Use grid system and responsive scaling functions
- Test by resizing window

### Background Not Resizing
**Issue:** Background doesn't adapt to screen size changes.

**Solution:**
- Ensure `setAutoResize(true)` is called (default)
- Check that image exists if using image background
- Verify scale mode is appropriate (FILL vs FIT vs STRETCH)

### UI Components Not Appearing
**Issue:** ResponsiveUI components are invisible or positioned incorrectly.

**Solution:**
- Ensure `layout` parameter is passed correctly
- Check z-order (add order matters)
- Verify parent container is added to state

---

## API Quick Reference

### ResponsiveLayout
```haxe
// Device detection
layout.getDeviceType()
layout.isMobile(), layout.isTablet(), layout.isDesktop()

// Grid system
layout.getGridWidth(span)
layout.getGridX(column)

// Responsive scaling
layout.getResponsiveFontSize(baseSize)
layout.getResponsiveSpacing(baseSpacing)

// Content dimensions
layout.getContentWidth()
layout.getCenterX(width), layout.getCenterY(height)
```

### ScrollSystem
```haxe
// Setup
scroll.setMaxScroll(contentHeight)
scroll.showScrollbar = true

// Control
scroll.scrollTo(position, animated)
scroll.scrollBy(deltaY)
scroll.resetScroll()

// Query
scroll.getScrollProgress()
scroll.isAtTop(), scroll.isAtBottom()
scroll.isElementVisible(y, height)
```

### ResponsiveBackground
```haxe
// Create backgrounds
background.createSolid(color, alpha)
background.createVerticalGradient(topColor, bottomColor)
background.createImage(path, scaleMode)

// Parallax
background.addParallaxLayer(path, scrollFactor, scaleMode)

// Manage layers
background.getLayer(name)
background.setLayerAlpha(name, alpha)
background.removeLayer(name)
```

### ResponsiveUI
```haxe
// Create components
ResponsiveUI.createButton(text, onClick, style, size, layout)
ResponsiveUI.createCard(title, width, height, layout)
ResponsiveUI.createBadge(text, style, layout)
ResponsiveUI.createProgressBar(width, height, progress, style, layout)
ResponsiveUI.createAlert(message, width, style, layout)
ResponsiveUI.createToggle(initialState, onToggle, layout)
```

---

## License and Credits

This responsive UI system was created for HaxeFlixel projects and is designed to be portable and reusable.

**Technologies:**
- HaxeFlixel
- OpenFL
- Lime

**Inspiration:**
- Bootstrap CSS framework
- Modern web responsive design principles
- Material Design

Feel free to adapt and use this system in your own HaxeFlixel projects!
