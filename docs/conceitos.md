# Conceitos do Sistema de UI Responsiva

Este documento explica os conceitos fundamentais do sistema de UI responsiva para HaxeFlixel.

## 1. Sistema de Grid (12 Colunas)

O sistema usa um grid de 12 colunas inspirado no Bootstrap:

```haxe
// Obtendo largura de 4 colunas (1/3 da tela)
var width = layout.getGridWidth(4);

// Obtendo posição X da coluna 3
var x = layout.getGridX(3);

// Células do grid com linha e coluna
var bounds = layout.getGridCellBounds(column: 0, row: 0, span: 4, rowHeight: 100);
```

**Por que 12 colunas?**
- Divisível por 2, 3, 4 e 6
- Layouts flexíveis: 2 colunas (6+6), 3 colunas (4+4+4), 4 colunas (3+3+3+3)
- Padrão da indústria (Bootstrap, Material Design)

## 2. Breakpoints Responsivos

O sistema detecta automaticamente o tipo de dispositivo:

```haxe
// Breakpoints (pixels)
MOBILE:  < 640px   - Telefones
TABLET:  640-1024px - Tablets
DESKTOP: > 1024px  - Computadores

// Uso
if (layout.isMobile()) {
    // Layout de 1 coluna
    columns = 1;
} else if (layout.isTablet()) {
    // Layout de 2 colunas
    columns = 2;
} else {
    // Layout de 3+ colunas
    columns = 3;
}
```

## 3. Escala Responsiva

Elementos escalam automaticamente baseado no dispositivo:

```haxe
// Tamanhos base (desktop)
var baseFontSize = 16;
var baseSpacing = 20;
var baseWidth = 300;

// Escalados automaticamente
var fontSize = layout.getResponsiveFontSize(baseFontSize);
var spacing = layout.getResponsiveSpacing(baseSpacing);
var dimensions = layout.getResponsiveDimensions(baseWidth, baseHeight);

// Fatores de escala por dispositivo:
// Desktop: 1.0 (100%)
// Tablet:  0.85 (85%)
// Mobile:  0.7 (70%)
```

## 4. Safe Areas

Áreas seguras para notches, barras de sistema, etc:

```haxe
// Configurar safe areas
layout.setSafeAreas(top: 40, bottom: 20, left: 0, right: 0);

// Obter dimensões considerando safe areas
var safeWidth = layout.getSafeContentWidth();
var safeHeight = layout.getSafeContentHeight();
```

## 5. Sistema de Scroll

Scroll completo com múltiplos métodos de entrada:

```haxe
// Configuração
scroll.setMaxScroll(totalContentHeight - screenHeight);
scroll.showScrollbar = true;
scroll.showBoundsIndicators = true;

// Métodos de entrada automáticos:
// - Mouse wheel (scrollSpeed configurável)
// - Drag com mouse
// - Teclado (setas, Page Up/Down, Home/End)
// - Scrollbar interativa

// Controle programático
scroll.scrollTo(position, animated: true);
scroll.scrollBy(deltaY);
scroll.resetScroll();

// Verificar estado
var progress = scroll.getScrollProgress(); // 0-1
var isVisible = scroll.isElementVisible(y, height);
```

## 6. Backgrounds Responsivos

Sistema de backgrounds com auto-resize:

```haxe
// Cores e gradientes
background.createSolid(FlxColor.BLACK);
background.createVerticalGradient(topColor, bottomColor);
background.createHorizontalGradient(leftColor, rightColor);

// Imagens com scale modes
background.createImage("bg.png", ScaleMode.FIT);
// FIT - Mantém aspect ratio, pode ter bordas
// FILL - Preenche tela, pode cortar
// STRETCH - Estica para preencher
// NONE - Tamanho original

// Parallax (múltiplas camadas)
background.addParallaxLayer("layer1.png", scrollFactor: 0.3);
background.addParallaxLayer("layer2.png", scrollFactor: 0.6);
background.addParallaxColor(FlxColor.RED, scrollFactor: 0.5, alpha: 0.3);
```

## 7. Componentes UI

Componentes pré-construídos no estilo Bootstrap - veja exemplos detalhados em [UIComponentsExampleState.hx](../source/states/UIComponentsExampleState.hx).

## 8. Performance

### Sprites Coloridos Eficientes
```haxe
// ❌ Evitar (cria textura grande)
sprite.makeGraphic(1920, 1080, FlxColor.RED);

// ✅ Usar (textura 1x1 + escala GPU)
sprite = SpriteUtil.createColoredSprite(1920, 1080, FlxColor.RED);
```

### Scroll Baseado em Câmera
```haxe
// Scroll move a câmera, não os objetos individuais
FlxG.camera.scroll.y = scrollY;
// Mais eficiente que mover centenas de objetos
```

Para mais detalhes, consulte a [documentação completa](../.github/copilot-instructions.md).
