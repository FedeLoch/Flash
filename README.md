# Flash

A Pharo live-coding environment with music-reactive visual effects. Built on [Bloc](https://github.com/feenkcom/bloc)/[Album](https://github.com/feenkcom/album) and integrated with the [Coypu](https://github.com/lucretiomsp/Coypu) live-coding music engine.

The editor executes Pharo code (like the standard Playground), listens for melody/sound events from Coypu's `Performance`/`Sequencer` engine, and renders visual effects on the code text in response — driven by switchable effect themes.

## Installation

```smalltalk
Metacello new
  baseline: 'Flash';
  repository: 'github://your-org/Flash:main';
  load.
```

To load locally from a cloned repository:

```smalltalk
Metacello new
  baseline: 'Flash';
  repository: 'file://', (FileLocator imageDirectory / 'pharo-local' / 'Flash' / 'src') pathString;
  load.
```

**Requirements:** Pharo 12+ (ships with Bloc/Album). [Coypu](https://github.com/lucretiomsp/Coypu) is loaded automatically as a dependency.

## Quick Start

### Open the editor standalone

```smalltalk
editor := FlashLiveEditor new.
editor openInSpace.
```

Type some Pharo code, select it, and use:
- `Cmd`+`D` — DoIt (evaluate, discard result)
- `Cmd`+`P` — PrintIt (evaluate, insert result as text)
- `Cmd`+`I` — InspectIt (evaluate, open inspector)
- `Cmd`+`G` — DebugIt (evaluate in debugger)

### Open the editor connected to Coypu

```smalltalk
Performance uniqueInstance openLiveEditor.
```

This opens a live editor wired to the running performance. Every note played by the sequencers will trigger visual effects on the editor.

### Apply a theme

```smalltalk
editor := FlashLiveEditor new.
editor effectTheme: FlashRanaEffectTheme new.
editor openInSpace.
```

### Create events manually

```smalltalk
event := FlashMelodyEvent new
  sequencerKey: #kick;
  soundName: 'bd';
  noteValue: 60;
  velocity: 0.9;
  yourself.

editor handleMelodyEvent: event.
```

## Architecture

```
Coypu (music engine)           Flash (visuals)
 ┌─────────────────┐           ┌──────────────────────────────┐
 │  Performer      │──ext──▶   │  FlashEditorEventListener    │
 │  SuperDirt      │           │  (global announcer)          │
 │  playNoteFor:   │           └──────────┬───────────────────┘
 └─────────────────┘                      │
        │                                 ▼
        │                     ┌──────────────────────────────┐
        │                     │  FlashMelodyEvent            │
        │                     │  • soundName, velocity, etc. │
        └────────────────────▶│  • soundCategory (#drum,     │
                              │    #bass, #lead, #pad ...)   │
                              └──────────┬───────────────────┘
                                         │
                    ┌────────────────────┴────────────────────┐
                    │            FlashLiveEditor               │
                    │  ┌─────────────────┐  ┌──────────────┐  │
                    │  │   AlbEditor      │  │ effectLayer  │  │
                    │  │  (text editing)  │  │ (overlay)    │  │
                    │  └─────────────────┘  └──────┬───────┘  │
                    └──────────────────────────────┼──────────┘
                                                   │
                    ┌──────────────────────────────┴──────────┐
                    │         FlashEffectTheme                 │
                    │  #drum → FlashFlashEffect   (green)     │
                    │  #bass → FlashWaveEffect    (deep green)│
                    │  #lead → FlashColorShift    (cyan)       │
                    │  #pad  → FlashGlowEffect    (soft green) │
                    └─────────────────────────────────────────┘
```

## Package Structure

| Package | Contents |
|---|---|
| `Flash-Core` | `FlashLiveEditor`, `FlashEditorCodeEvaluator`, `FlashEditorCompletionController` |
| `Flash-Events` | `FlashMelodyEvent`, `FlashEditorEventListener`, Coypu extension methods |
| `Flash-Effects` | `FlashVisualEffect` + 6 concrete effects |
| `Flash-Themes` | `FlashEffectTheme`, `FlashRanaEffectTheme`, `FlashNeonEffectTheme` |
| `Flash-Themes-Editor` | `FlashThemeEditorElement` (preferences UI) |
| `Flash-Tests-Core` | Editor and evaluator tests |
| `Flash-Tests-Events` | Event and listener tests |
| `Flash-Tests-Effects` | Visual effect tests |
| `Flash-Tests-Themes` | Theme and theme editor tests |
| `Flash-Tests-Integration` | Coypu integration tests |
| `Flash` | Umbrella package for all components |

Dependency graph:

```
Flash-Core ────┬── Flash-Events ─── Coypu
               ├── Flash-Effects
               └── Flash-Themes ──┬── Flash-Effects
                                  └── Flash-Events
Flash-Editor ── Flash-Core + Flash-Events + Flash-Effects + Flash-Themes
Flash-Themes-Editor ── Flash-Themes + Flash-Editor
Flash ── all of the above
```

## Visual Effects

Every visual effect is a subclass of `FlashVisualEffect`. Effects are applied to a `BlElement` (typically the editor or its overlay layer) when a `FlashMelodyEvent` is received.

| Effect | Description | Default Duration |
|---|---|---|
| `FlashFlashEffect` | Brief color flash on background via `BlColorTransition` | 200ms |
| `FlashGlowEffect` | Glowing border halo with animated opacity | 400ms |
| `FlashPulseEffect` | Scale-up/down transform pulse (uses separate composition layer) | 300ms |
| `FlashWaveEffect` | Horizontal ripple/shake via sequential transform animations | 400ms |
| `FlashColorShiftEffect` | Temporary text color shift with restore | 300ms |
| `FlashBorderFlashEffect` | Animated border width and color | 250ms |

Using effects directly:

```smalltalk
effect := FlashFlashEffect new
  color: Color green;
  intensity: 0.8;
  duration: 300 milliSeconds;
  yourself.

element := BlElement new size: 200@200; background: Color black.
effect applyTo: element withEvent: (FlashMelodyEvent new velocity: 0.9; yourself).
```

## Theme System

Themes map sound categories to visual effects. Two themes ship built-in:

### FlashRanaEffectTheme

Green phosphor CRT aesthetic.

| Category | Effect | Color |
|---|---|---|
| `#drum` | `FlashFlashEffect` | `#00FF41` (bright green) |
| `#snare` | `FlashPulseEffect` | `#FFB000` (amber) |
| `#hihat` | `FlashGlowEffect` | `#39FF14` alpha 0.3 |
| `#bass` | `FlashWaveEffect` | `#00CC33` (deep green) |
| `#lead` | `FlashColorShiftEffect` | `#00FFFF` (cyan) |
| `#pad` | `FlashGlowEffect` | `#33FF33` alpha 0.15 |
| `#fx` / `#sample` | `FlashBorderFlashEffect` | white alpha 0.5 |

Background: black. Text color: `#00FF41`.

### FlashNeonEffectTheme

Neon/synthwave aesthetic.

| Category | Effect | Color |
|---|---|---|
| `#drum` | `FlashFlashEffect` | `#FF006E` (hot pink) |
| `#bass` | `FlashWaveEffect` | `#3A86FF` (electric blue) |
| `#lead` | `FlashColorShiftEffect` | `#FFBE0B` (neon yellow) |
| `#pad` | `FlashGlowEffect` | `#8338EC` (purple) |
| Default | `FlashFlashEffect` | `#00F5FF` (cyan) |

Background: `#0D0221` (deep indigo). Text color: `#00F5FF`.

### Switching themes

```smalltalk
editor effectTheme: FlashNeonEffectTheme new.
```

### Creating a custom theme

```smalltalk
theme := FlashEffectTheme new.
theme name: 'MyTheme'.
theme backgroundColor: Color black.
theme textColor: Color white.
theme mappings at: #drum put: {
  #effectClass -> FlashFlashEffect.
  #config -> { #color -> Color red. #intensity -> 0.8 }
} asDictionary.
```

## Event Model

`FlashMelodyEvent` is an `Announcement` subclass carrying all data from a sequencer play step:

```smalltalk
event := FlashMelodyEvent fromSequencer: aSequencer at: 0.
event sequencerKey   "→ #kick"
event soundName      "→ 'bd'"
event noteValue      "→ 60"
event velocity       "→ 0.9"
event soundCategory  "→ #drum"
event isPercussive   "→ true"
event normalizedPitch "→ 0.472"
```

Sound categorization heuristics:

| Category | Sounds |
|---|---|
| `#drum` | bd, kick, sn, snare, hh, hihat, cp, clap, rim, tom, crash, ride, cymbal |
| `#bass` | bass*, sub*, bass1*, bass2*, bass3* |
| `#lead` | superpiano*, supersquare*, supersaw*, superfm*, supercomparg* |
| `#pad` | pad*, ambient*, drone* |
| `#fx` | fx*, noise*, beat*, loop* |
| `#sample` | everything else |

## Extension Methods

The package adds three extension methods to Coypu classes (no Coypu source modification needed):

- `Performer >> announcePlayOf: aSequencer at: anIndex` — announces a `FlashMelodyEvent` on the global announcer
- `PerformerSuperDirt >> playNoteFor: aSequencer at: anIndex` — wraps the original play method
- `Performance >> openLiveEditor` — convenience to open a connected editor

## Running Tests

```smalltalk
suite := TestSuite named: 'Flash'.
#('Flash-Core' 'Flash-Events' 'Flash-Effects' 'Flash-Themes' 'Flash-Tests-Integration')
  do: [ :pkg |
    suite addTests: ((PackageOrganizer default packageNamed: pkg) definedClasses
      select: [ :c | c isTestCase ] thenCollect: [ :c | c buildSuite ]) ].
TestRunner new runSuite: suite.
```

Or run individual test classes:

```smalltalk
(FlashLiveEditorTest selector: #testInitializationCreatesAlbEditor) run.
(FlashMelodyEventTest selector: #testSoundCategoryForDrumSounds) run.
```

## Test Summary

| Test Class | # Tests | Component |
|---|---|---|
| `FlashLiveEditorTest` | 7 | Editor init, effects, cleanup |
| `FlashEditorCodeEvaluatorTest` | 6 | DoIt, PrintIt, contexts, errors |
| `FlashEditorCompletionControllerTest` | 4 | Popup, suggestions |
| `FlashMelodyEventTest` | 9 | Properties, categories, factory |
| `FlashEditorEventListenerTest` | 5 | Announcer, start/stop, subscriptions |
| `FlashVisualEffectTest` | 4 | Duration, intensity, protocol |
| `FlashFlashEffectTest` | 3 | Background, color, duration |
| `FlashGlowEffectTest` | 2 | Border, duration comparison |
| `FlashPulseEffectTest` | 2 | Transform, scale factor |
| `FlashWaveEffectTest` | 2 | Sequential, displacement |
| `FlashColorShiftEffectTest` | 3 | Color shift, restore, blend |
| `FlashBorderFlashEffectTest` | 2 | Border, width proportion |
| `FlashEffectThemeTest` | 5 | Lookup, fallback, colors |
| `FlashRanaEffectThemeTest` | 7 | Mappings, colors, categories |
| `FlashNeonEffectThemeTest` | 4 | Mappings, colors |
| `FlashThemeEditorElementTest` | 5 | Sub-elements, themes, STON |
| `FlashCoypuIntegrationTest` | 4 | Extension methods, events |
| **Total** | **72** | |

## License

MIT
