# CoypuLive

A Pharo live-coding environment with music-reactive visual effects. Built on [Bloc](https://github.com/feenkcom/bloc)/[Album](https://github.com/feenkcom/album) and integrated with the [Coypu](https://github.com/lucretiomsp/Coypu) live-coding music engine.

The editor executes Pharo code (like the standard Playground), listens for melody/sound events from Coypu's `Performance`/`Sequencer` engine, and renders visual effects on the code text in response — driven by switchable effect themes.

## Installation

```smalltalk
Metacello new
  baseline: 'CoypuLive';
  repository: 'github://your-org/CoypuLive:main';
  load.
```

To load locally from a cloned repository:

```smalltalk
Metacello new
  baseline: 'CoypuLive';
  repository: 'file://', (FileLocator imageDirectory / 'pharo-local' / 'CoypuLive' / 'src') pathString;
  load.
```

**Requirements:** Pharo 12+ (ships with Bloc/Album). [Coypu](https://github.com/lucretiomsp/Coypu) is loaded automatically as a dependency.

## Quick Start

### Open the editor standalone

```smalltalk
editor := CoyLiveEditor new.
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
editor := CoyLiveEditor new.
editor effectTheme: CoyRanaEffectTheme new.
editor openInSpace.
```

### Create events manually

```smalltalk
event := CoyMelodyEvent new
  sequencerKey: #kick;
  soundName: 'bd';
  noteValue: 60;
  velocity: 0.9;
  yourself.

editor handleMelodyEvent: event.
```

## Architecture

```
Coypu (music engine)           CoypuLive (visuals)
 ┌─────────────────┐           ┌──────────────────────────────┐
 │  Performer      │──ext──▶   │  CoyEditorEventListener      │
 │  SuperDirt      │           │  (global announcer)          │
 │  playNoteFor:   │           └──────────┬───────────────────┘
 └─────────────────┘                      │
        │                                 ▼
        │                     ┌──────────────────────────────┐
        │                     │  CoyMelodyEvent              │
        │                     │  • soundName, velocity, etc. │
        └────────────────────▶│  • soundCategory (#drum,     │
                              │    #bass, #lead, #pad ...)   │
                              └──────────┬───────────────────┘
                                         │
                    ┌────────────────────┴────────────────────┐
                    │              CoyLiveEditor               │
                    │  ┌─────────────────┐  ┌──────────────┐  │
                    │  │   AlbEditor      │  │ effectLayer  │  │
                    │  │  (text editing)  │  │ (overlay)    │  │
                    │  └─────────────────┘  └──────┬───────┘  │
                    └──────────────────────────────┼──────────┘
                                                   │
                    ┌──────────────────────────────┴──────────┐
                    │           CoyEffectTheme                 │
                    │  #drum → CoyFlashEffect   (green)       │
                    │  #bass → CoyWaveEffect    (deep green)  │
                    │  #lead → CoyColorShift    (cyan)        │
                    │  #pad  → CoyGlowEffect    (soft green)  │
                    └─────────────────────────────────────────┘
```

## Package Structure

| Package | Contents |
|---|---|
| `CoypuLive-Editor` | `CoyLiveEditor`, `CoyEditorCodeEvaluator`, `CoyEditorCompletionController` |
| `CoypuLive-Events` | `CoyMelodyEvent`, `CoyEditorEventListener`, Coypu extension methods |
| `CoypuLive-Effects` | `CoyVisualEffect` + 6 concrete effects |
| `CoypuLive-Themes` | `CoyEffectTheme`, `CoyRanaEffectTheme`, `CoyNeonEffectTheme` |
| `CoypuLive-Themes-Editor` | `CoyThemeEditorElement` (preferences UI) |
| `CoypuLive-Tests-*` | 72 unit tests across 17 test classes |

## Visual Effects

Every visual effect is a subclass of `CoyVisualEffect`. Effects are applied to a `BlElement` (typically the editor or its overlay layer) when a `CoyMelodyEvent` is received.

| Effect | Description | Default Duration |
|---|---|---|
| `CoyFlashEffect` | Brief color flash on background via `BlColorTransition` | 200ms |
| `CoyGlowEffect` | Glowing border halo with animated opacity | 400ms |
| `CoyPulseEffect` | Scale-up/down transform pulse (uses separate composition layer) | 300ms |
| `CoyWaveEffect` | Horizontal ripple/shake via sequential transform animations | 400ms |
| `CoyColorShiftEffect` | Temporary text color shift with restore | 300ms |
| `CoyBorderFlashEffect` | Animated border width and color | 250ms |

Using effects directly:

```smalltalk
effect := CoyFlashEffect new
  color: Color green;
  intensity: 0.8;
  duration: 300 milliSeconds;
  yourself.

element := BlElement new size: 200@200; background: Color black.
effect applyTo: element withEvent: (CoyMelodyEvent new velocity: 0.9; yourself).
```

## Theme System

Themes map sound categories to visual effects. Two themes ship built-in:

### CoyRanaEffectTheme

Green phosphor CRT aesthetic inspired by the existing `RanaTheme`.

| Category | Effect | Color |
|---|---|---|
| `#drum` | `CoyFlashEffect` | `#00FF41` (bright green) |
| `#snare` | `CoyPulseEffect` | `#FFB000` (amber) |
| `#hihat` | `CoyGlowEffect` | `#39FF14` alpha 0.3 |
| `#bass` | `CoyWaveEffect` | `#00CC33` (deep green) |
| `#lead` | `CoyColorShiftEffect` | `#00FFFF` (cyan) |
| `#pad` | `CoyGlowEffect` | `#33FF33` alpha 0.15 |
| `#fx` / `#sample` | `CoyBorderFlashEffect` | white alpha 0.5 |

Background: black. Text color: `#00FF41`.

### CoyNeonEffectTheme

Neon/synthwave aesthetic.

| Category | Effect | Color |
|---|---|---|
| `#drum` | `CoyFlashEffect` | `#FF006E` (hot pink) |
| `#bass` | `CoyWaveEffect` | `#3A86FF` (electric blue) |
| `#lead` | `CoyColorShiftEffect` | `#FFBE0B` (neon yellow) |
| `#pad` | `CoyGlowEffect` | `#8338EC` (purple) |
| Default | `CoyFlashEffect` | `#00F5FF` (cyan) |

Background: `#0D0221` (deep indigo). Text color: `#00F5FF`.

### Switching themes

```smalltalk
editor effectTheme: CoyNeonEffectTheme new.
```

### Creating a custom theme

```smalltalk
theme := CoyEffectTheme new.
theme name: 'MyTheme'.
theme backgroundColor: Color black.
theme textColor: Color white.
theme mappings at: #drum put: {
  #effectClass -> CoyFlashEffect.
  #config -> { #color -> Color red. #intensity -> 0.8 }
} asDictionary.
```

## Event Model

`CoyMelodyEvent` is an `Announcement` subclass carrying all data from a sequencer play step:

```smalltalk
event := CoyMelodyEvent fromSequencer: aSequencer at: 0.
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

- `Performer >> announcePlayOf: aSequencer at: anIndex` — announces a `CoyMelodyEvent` on the global announcer
- `PerformerSuperDirt >> playNoteFor: aSequencer at: anIndex` — wraps the original play method
- `Performance >> openLiveEditor` — convenience to open a connected editor

## Running Tests

```smalltalk
suite := TestSuite named: 'CoypuLive'.
suite addTests: ((PackageOrganizer default packageNamed: 'CoypuLive-Editor') definedClasses
  select: [ :c | c isTestCase ] thenCollect: [ :c | c buildSuite ]).
suite addTests: ((PackageOrganizer default packageNamed: 'CoypuLive-Events') definedClasses
  select: [ :c | c isTestCase ] thenCollect: [ :c | c buildSuite ]).
suite addTests: ((PackageOrganizer default packageNamed: 'CoypuLive-Effects') definedClasses
  select: [ :c | c isTestCase ] thenCollect: [ :c | c buildSuite ]).
suite addTests: ((PackageOrganizer default packageNamed: 'CoypuLive-Themes') definedClasses
  select: [ :c | c isTestCase ] thenCollect: [ :c | c buildSuite ]).
suite addTests: ((PackageOrganizer default packageNamed: 'CoypuLive-Tests-Integration') definedClasses
  select: [ :c | c isTestCase ] thenCollect: [ :c | c buildSuite ]).
TestRunner new runSuite: suite.
```

Or run individual test classes:

```smalltalk
(CoyLiveEditorTest selector: #testInitializationCreatesAlbEditor) run.
(CoyMelodyEventTest selector: #testSoundCategoryForDrumSounds) run.
```

## Test Summary

| Test Class | # Tests | Component |
|---|---|---|
| `CoyLiveEditorTest` | 7 | Editor init, effects, cleanup |
| `CoyEditorCodeEvaluatorTest` | 6 | DoIt, PrintIt, contexts, errors |
| `CoyEditorCompletionControllerTest` | 4 | Popup, suggestions |
| `CoyMelodyEventTest` | 9 | Properties, categories, factory |
| `CoyEditorEventListenerTest` | 5 | Announcer, start/stop, subscriptions |
| `CoyVisualEffectTest` | 4 | Duration, intensity, protocol |
| `CoyFlashEffectTest` | 3 | Background, color, duration |
| `CoyGlowEffectTest` | 2 | Border, duration comparison |
| `CoyPulseEffectTest` | 2 | Transform, scale factor |
| `CoyWaveEffectTest` | 2 | Sequential, displacement |
| `CoyColorShiftEffectTest` | 3 | Color shift, restore, blend |
| `CoyBorderFlashEffectTest` | 2 | Border, width proportion |
| `CoyEffectThemeTest` | 5 | Lookup, fallback, colors |
| `CoyRanaEffectThemeTest` | 7 | Mappings, colors, categories |
| `CoyNeonEffectThemeTest` | 4 | Mappings, colors |
| `CoyThemeEditorElementTest` | 5 | Sub-elements, themes, STON |
| `CoyCoypuIntegrationTest` | 4 | Extension methods, events |
| **Total** | **72** | |

## License

MIT
