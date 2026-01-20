# 📱 HaxeFlixel Responsive UI System

> Sistema completo de UI responsiva para HaxeFlixel, inspirado em Bootstrap e frameworks web modernos.

[![Haxe](https://img.shields.io/badge/Haxe-4.0+-orange.svg)](https://haxe.org/)
[![HaxeFlixel](https://img.shields.io/badge/HaxeFlixel-5.0+-green.svg)](https://haxeflixel.com/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## 📋 Sobre o Projeto

Este é um **projeto de teste** que implementa um sistema completo de UI responsiva para HaxeFlixel, permitindo criar interfaces adaptativas e profissionais que se ajustam automaticamente a diferentes tamanhos de tela e dispositivos.

### ✨ Características

- 📐 **Grid System**: Sistema de 12 colunas (como Bootstrap)
- 📱 **Device Detection**: Detecção automática de Mobile/Tablet/Desktop
- 🎨 **Componentes UI**: Botões, cards, badges, progress bars, alerts e toggles
- 🖼️ **Backgrounds Responsivos**: Suporte a cores sólidas, gradientes, imagens e parallax
- 📜 **Sistema de Scroll**: Scroll completo com mouse wheel, drag, keyboard e scrollbar
- ⚡ **Breakpoints**: Pontos de quebra responsivos (640px, 1024px, 1920px)
- 🔄 **Auto-resize**: Redimensionamento automático ao mudar tamanho da janela

### 🎯 Recursos Implementados

- ✅ ResponsiveLayout - Sistema de layout com grid e breakpoints
- ✅ ResponsiveBackground - Gerenciamento de backgrounds com auto-resize
- ✅ ScrollSystem - Sistema completo de scroll com UI e indicadores
- ✅ ResponsiveUI - Componentes Bootstrap-style (botões, cards, etc.)
- ✅ ResponsiveState/SubState - Estados base com layout responsivo
- ✅ Estados de exemplo demonstrando todas as funcionalidades
- ✅ Utilitários matemáticos, de string e arrays
- ✅ Sistema de cache de assets otimizado

## 🚀 Começando

### Pré-requisitos

Antes de começar, você precisa ter instalado:

- [Haxe](https://haxe.org/download/) (4.0 ou superior)
- [HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/) (instale via haxelib)

### 📦 Instalação

1. **Clone o repositório**

   ```bash
   git clone https://github.com/Luisinhi010/Flixel-Ui-Testing.git
   cd Flixel-Ui-Testing
   ```

2. **Instale as dependências do Haxe**

   ```bash
   haxelib install lime
   haxelib install openfl
   haxelib install flixel
   haxelib install flixel-addons
   ```

3. **Configure o HaxeFlixel** (primeira vez apenas)

   ```bash
   haxelib run lime setup
   haxelib run flixel-tools setup
   ```

### ▶️ Como Executar

#### Windows (Debug)

```bash
lime test windows -debug
```

#### Web/HTML5 (Debug)

```bash
lime test html5 -debug
```

#### Modo Release

```bash
lime test windows -release
```

### 🎮 Controles

No **DebugState** (estado inicial):

- **Y**: Abrir ResponsiveExampleState (demo de grid e scroll)
- **B**: Abrir BackgroundExampleState (demo de backgrounds)
- **U**: Abrir UIComponentsExampleState (demo de componentes UI)
- **F5**: Recarregar estado atual (disponível em todos os estados)
- **F6**: Exibir informações de debug no console

#### ResponsiveExampleState
- **SPACE**: Abrir modal de exemplo (ResponsiveExampleSubState)
- **ESC**: Voltar ao DebugState
- **Mouse Wheel / Drag / Setas**: Scroll da página

#### BackgroundExampleState
- **1**: Background cor sólida
- **2**: Background gradiente vertical
- **3**: Background gradiente horizontal
- **4**: Background com parallax (múltiplas camadas)
- **5**: Background gradiente animado
- **ESC**: Voltar ao DebugState

#### UIComponentsExampleState
- **Mouse**: Interagir com botões e toggles
- **Mouse Wheel / Drag / Setas**: Scroll para ver todos os componentes
- **ESC**: Voltar ao DebugState


## 📁 Estrutura do Projeto

```text
Flixel-Ui-Testing/
├── source/
│   ├── Main.hx                    # Ponto de entrada
│   ├── Util.hx                    # Utilitários de plataforma
│   ├── backend/                   # Sistemas de UI responsiva
│   │   ├── ResponsiveLayout.hx    # Sistema de grid e breakpoints
│   │   ├── ResponsiveBackground.hx # Gerenciamento de backgrounds
│   │   ├── ScrollSystem.hx        # Sistema completo de scroll
│   │   ├── ResponsiveUI.hx        # Componentes UI (botões, cards, etc.)
│   │   ├── LayoutConstants.hx     # Constantes centralizadas
│   │   ├── Paths.hx               # Sistema de cache de assets
│   │   └── FilePath.hx            # Gerenciamento de caminhos
│   ├── core/
│   │   └── utils/                 # Utilitários gerais
│   │       ├── MathUtil.hx        # Funções matemáticas
│   │       ├── StringUtil.hx      # Formatação de strings
│   │       ├── SpriteUtil.hx      # Funções para FlxSprites
│   │       └── ArrayUtil.hx       # Manipulação de arrays
│   └── states/                    # Estados do jogo
│       ├── DefaultState.hx        # Estado base com debug
│       ├── DefaultSubState.hx     # SubState base com debug
│       ├── ResponsiveState.hx     # Estado base com UI responsiva
│       ├── ResponsiveSubState.hx  # SubState base com UI responsiva
│       ├── DebugState.hx          # Menu principal de testes
│       ├── ResponsiveExampleState.hx     # Demo de grid e scroll
│       ├── ResponsiveExampleSubState.hx  # Demo de modal
│       ├── BackgroundExampleState.hx     # Demo de backgrounds
│       └── UIComponentsExampleState.hx   # Demo de componentes UI
├── assets/
│   ├── images/                    # Imagens e sprites
│   ├── music/                     # Arquivos de música
│   ├── sounds/                    # Efeitos sonoros
│   ├── shaders/                   # Shaders (gradient.glsl)
│   └── ui/                        # Assets de UI
├── docs/                          # Documentação adicional
│   ├── conceitos.md               # Conceitos do sistema
│   └── implementacao.md           # Detalhes de implementação
├── .github/
│   └── copilot-instructions.md    # Documentação completa do sistema
├── Project.xml                    # Configuração do projeto
├── hxformat.json                  # Configuração de formatação
└── README.MD                      # Este arquivo
```

## 🎨 Sistema de UI Responsiva

### 1. ResponsiveLayout

Sistema de layout baseado em grid de 12 colunas com breakpoints responsivos.

**Breakpoints:**
- Mobile: < 640px
- Tablet: 640px - 1024px
- Desktop: > 1024px

**Principais recursos:**
```haxe
// Detecção de dispositivo
layout.getDeviceType() // MOBILE, TABLET ou DESKTOP
layout.isMobile(), layout.isTablet(), layout.isDesktop()

// Grid system (12 colunas)
layout.getGridWidth(span) // Largura para N colunas
layout.getGridX(column) // Posição X da coluna

// Escala responsiva
layout.getResponsiveFontSize(baseSize)
layout.getResponsiveSpacing(baseSpacing)
layout.getResponsiveDimensions(width, height)

// Posicionamento
layout.getCenterX(width), layout.getCenterY(height)
```

### 2. ResponsiveBackground

Sistema de backgrounds com suporte a cores, gradientes, imagens e parallax.

**Recursos:**
```haxe
// Backgrounds simples
background.createSolid(color, alpha)
background.createVerticalGradient(topColor, bottomColor)
background.createHorizontalGradient(leftColor, rightColor)
background.createImage(path, scaleMode)

// Parallax (múltiplas camadas)
background.addParallaxLayer(imagePath, scrollFactor, scaleMode)
background.addParallaxColor(color, scrollFactor)

// Gerenciamento
background.getLayer(name)
background.setLayerAlpha(name, alpha)
background.removeLayer(name)
```

**Scale Modes:** FIT, FILL, STRETCH, NONE

### 3. ScrollSystem

Sistema completo de scroll com múltiplos métodos de entrada.

**Recursos:**
```haxe
// Configuração
scroll.setMaxScroll(contentHeight)
scroll.showScrollbar = true
scroll.showBoundsIndicators = true

// Controle
scroll.scrollTo(position, animated)
scroll.scrollBy(deltaY)
scroll.resetScroll()

// Estado
scroll.getScrollProgress() // 0-1
scroll.isAtTop(), scroll.isAtBottom()
scroll.isElementVisible(y, height)
```

**Métodos de entrada:**
- Mouse wheel (velocidade configurável)
- Drag com mouse
- Teclado (setas, Page Up/Down, Home/End)
- Scrollbar interativa

### 4. ResponsiveUI

Componentes UI no estilo Bootstrap.

**Componentes disponíveis:**

#### Buttons
```haxe
ResponsiveUI.createButton(text, onClick, style, size, layout)
ResponsiveUI.createIconButton(icon, text, onClick, style, size, layout)
```
**Estilos:** PRIMARY, SECONDARY, SUCCESS, DANGER, WARNING, INFO, LIGHT, DARK  
**Tamanhos:** SMALL, MEDIUM, LARGE

#### Cards
```haxe
var card = ResponsiveUI.createCard(title, width, height, layout)
card.getContentY() // Y para adicionar conteúdo
card.getContentWidth() // Largura disponível
```

#### Badges
```haxe
var badge = ResponsiveUI.createBadge(text, style, layout)
badge.setText(newText)
```

#### Progress Bars
```haxe
var progress = ResponsiveUI.createProgressBar(width, height, progress, style, layout)
progress.setProgress(value) // Instantâneo
progress.animateProgress(targetValue, duration) // Animado
```

#### Alerts
```haxe
var alert = ResponsiveUI.createAlert(message, width, style, layout)
alert.setMessage(newText)
alert.dismiss(duration) // Fade out
```

#### Toggles
```haxe
var toggle = ResponsiveUI.createToggle(initialState, onToggle, layout)
toggle.toggle()
toggle.setOn(value, animate)
```

### 5. ResponsiveState / ResponsiveSubState

Classes base para estados com UI responsiva.

**Uso:**
```haxe
class MyState extends ResponsiveState
{
    override public function create():Void
    {
        super.create();
        
        // Background
        setBackgroundColor(FlxColor.BLACK);
        // ou
        background.createImage("myBg", FILL);
        
        // Usar grid system
        var btnWidth = getGridWidth(4); // 4 colunas
        var btnX = getGridX(4); // Começa na coluna 4
        
        // Criar UI
        var btn = ResponsiveUI.createButton("Click", onClick, PRIMARY, MEDIUM, layout);
        btn.x = btnX;
        btn.y = 100;
        add(btn);
        
        // Configurar scroll (se necessário)
        scroll.setMaxScroll(totalContentHeight);
        scroll.showScrollbar = true;
        addScroll();
    }
    
    override public function onResizeContent():Void
    {
        // Reposicionar elementos quando tela redimensionar
    }
}
```

## 🛠️ Desenvolvimento

### Como Usar em Seu Projeto

1. **Copie os arquivos necessários:**
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

2. **Copie as dependências:**
   ```
   source/core/utils/
   ├── MathUtil.hx
   ├── StringUtil.hx
   ├── ArrayUtil.hx
   └── SpriteUtil.hx
   
   source/backend/
   ├── Paths.hx
   └── FilePath.hx
   ```

3. **Crie seu estado:**
   ```haxe
   import states.ResponsiveState;
   
   class MyGameState extends ResponsiveState
   {
       override public function create():Void
       {
           super.create();
           // Seu código aqui
       }
   }
   ```

### Boas Práticas

1. **Sempre estenda ResponsiveState ou ResponsiveSubState**
   - Não estenda FlxState/FlxSubState diretamente

2. **Use o grid system para layouts**
   - Mais consistente que posicionamento manual
   - Adapta automaticamente a diferentes telas

3. **Use ResponsiveUI para componentes comuns**
   - Estilo consistente em toda aplicação
   - Estados interativos pré-implementados

4. **Override onResizeContent() para reposicionamento**
   - Chamado automaticamente ao redimensionar janela
   - Recalcule posições dos seus elementos

5. **Use funções de escala responsiva**
   - `getResponsiveFontSize()` para texto
   - `getResponsiveSpacing()` para margens/padding
   - `getResponsiveDimensions()` para tamanhos

6. **Teste em diferentes resoluções**
   - Redimensione a janela para verificar adaptação
   - Teste breakpoints de mobile, tablet e desktop

### Estilo de Código

- Indentação: **Tabs** (convenção HaxeFlixel)
- Chaves: Linha nova para abertura/fechamento (exceto object literals)
- Nomenclatura:
  - Classes: `PascalCase`
  - Variáveis/Funções: `camelCase`
  - Constantes: `UPPER_CASE`
- Type annotations obrigatórias
- Veja `hxformat.json` para detalhes


## 📝 Documentação

Documentação completa disponível em:

- [.github/copilot-instructions.md](.github/copilot-instructions.md) - Guia completo do sistema de UI responsiva
- `docs/conceitos.md` - Conceitos fundamentais
- `docs/implementacao.md` - Detalhes de implementação

### Estados de Exemplo

- **ResponsiveExampleState** - Demonstra grid system, escala responsiva e scroll
- **ResponsiveExampleSubState** - Demonstra modal/dialog responsivo
- **BackgroundExampleState** - Demonstra todos os tipos de background
- **UIComponentsExampleState** - Demonstra todos os componentes UI

## 🎯 Casos de Uso

Este sistema é ideal para:

- Menus de jogos adaptativos
- Interfaces de configuração
- Painéis de HUD responsivos
- Diálogos e modais
- Telas de seleção de níveis
- Inventários e lojas
- Qualquer UI que precise funcionar em múltiplos tamanhos de tela

## ⚡ Performance

### Otimizações Implementadas

- **Sprites coloridos eficientes**: Usa textura 1x1 + escala GPU (via SpriteUtil)
- **Scroll baseado em câmera**: Não move objetos individualmente
- **Cache de assets**: Sistema Paths.hx para evitar recarregamentos
- **Recálculo inteligente**: Layout só recalcula ao redimensionar tela
- **Sprite resizing eficiente**: Usa `SpriteUtil.resize()` sem recriar gráficos

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/NovaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona NovaFeature'`)
4. Push para a branch (`git push origin feature/NovaFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto é open source e está disponível sob a [MIT License](LICENSE).

## 👤 Autor

**Luisinhi010**

- GitHub: [@Luisinhi010](https://github.com/Luisinhi010)

## 🙏 Agradecimentos

- Comunidade HaxeFlixel
- Inspiração: Bootstrap CSS framework, Material Design
- Todos os contribuidores do projeto

---

⭐ Se este projeto foi útil, considere dar uma estrela!
