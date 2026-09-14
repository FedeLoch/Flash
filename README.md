# Flash

A Pharo live-coding environment with music-reactive visual effects. Built on [Bloc](https://github.com/feenkcom/bloc)/[Album](https://github.com/feenkcom/album) and integrated with the [Coypu](https://github.com/lucretiomsp/Coypu) live-coding music engine.

The editor executes Pharo code (like the standard Playground), listens for melody/sound events from Coypu's `Performance`/`Sequencer` engine, and renders visual effects on the code text in response — driven by switchable effect themes.

## Installation

```smalltalk
Metacello new
  baseline: 'Flash';
  repository: 'github://FedeLoch/Flash:main';
  load.
```

**Requirements:** Pharo 12+ (ships with Bloc/Album). [Coypu](https://github.com/lucretiomsp/Coypu) is loaded automatically as a dependency.

## Quick Start

### Open the full live-coding workspace

```smalltalk
window := FlashWorkspaceWindow onWorkspace: FlashWorkspace new.
window openInSpace.
```

The workspace assembles the live editor (CodeMirror-style), transport bar (play/tap/panic/BPM), a 16-step sequencer matrix (kick/acid/hihat), the particle canvas, an oscilloscope, a live event stream, and a synth panel.

### Open the performance Stage

```smalltalk
controller := FlashStageController new.
controller initializeStage.
controller screen openInSpace.
```

The stage is a full-screen performance mode with 4 visual presets (Phosphor CRT, Neon Pulse, Cyber Grid, Acid Storm), a background canvas with scanlines and music-reactive particle bursts, a floating HUD editor, a bottom dock (mini matrix, transport, VU meters, spark/burst/panic controls), and a zen mode that hides the chrome.

```smalltalk
controller toggleZen.           "hide HUD + dock"
controller activatePreset: #acid.
controller advanceClock.        "drives particles + matrix from the sequencer"
```

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

## Test the Editor

### See effects instantly (no dependencies)

Open the editor and run a self-contained beat loop. No Coypu or SuperDirt needed:

```smalltalk
| editor beat i |
editor := FlashLiveEditor new.
editor openInSpace.

beat := #(
  'bd'   'kick'     0.9
  'sn'   'snare'    0.8
  'bass' 'bass'     0.7
  'superpiano' 'lead' 1.0
).

i := 0.
[
  [ true ] whileTrue: [
    | idx |
    idx := (i \\ 4) * 3 + 1.
    editor handleMelodyEvent: (FlashMelodyEvent new
      soundName: (beat at: idx);
      sequencerKey: (beat at: idx + 1);
      velocity: (beat at: idx + 2);
      yourself).
    i := i + 1.
    (Delay forMilliseconds: 300) wait ]
] fork.
```

This cycles through kick (green flash) → snare (green flash) → bass (green wave) → lead (cyan color shift) every 300ms. To stop it, close the editor window.

### Manually trigger individual events

```smalltalk
editor := FlashLiveEditor new.
editor openInSpace.

editor handleMelodyEvent: (FlashMelodyEvent new
  soundName: 'bd'; sequencerKey: #kick; velocity: 0.9; yourself).
```

### Write music with Coypu (requires SuperDirt)

If you have [SuperDirt](https://github.com/musikinformatik/SuperDirt) running, you can write Coypu sequencers in the editor and hear audio alongside the visual effects.

Open the editor connected to the performance:

```smalltalk
Performance uniqueInstance openLiveEditor.
```

Type a sequencer into the editor and execute with `Cmd`+`D`:

```smalltalk
Performance uniqueInstance
  at: #kick put: (SequencerMono new
    seqKey: #kick;
    gates: #(1 0 0 0 1 0 0 0) asRhythm;
    notes: #(60);
    dirtMessage: (Dictionary new at: 's' put: #('bd') asDirtArray; yourself);
    yourself).
Performance uniqueInstance play.
```

Try other sounds:

```smalltalk
Performance uniqueInstance
  at: #snare put: (SequencerMono new
    seqKey: #snare;
    gates: #(0 0 1 0) asRhythm;
    notes: #(62);
    dirtMessage: (Dictionary new at: 's' put: #('sn') asDirtArray; yourself);
    yourself).
Performance uniqueInstance
  at: #bass put: (SequencerMono new
    seqKey: #bass;
    gates: #(1 0 1 0) asRhythm;
    notes: #(36);
    dirtMessage: (Dictionary new at: 's' put: #('bass') asDirtArray; yourself);
    yourself).
Performance uniqueInstance
  at: #lead put: (SequencerMono new
    seqKey: #lead;
    gates: #(1 1 1 1) asRhythm;
    notes: #(60 64 67 72);
    dirtMessage: (Dictionary new at: 's' put: #('superpiano') asDirtArray; yourself);
    yourself).
Performance uniqueInstance play.
```

### Switch themes

```smalltalk
editor effectTheme: FlashNeonEffectTheme new.
```

With the Neon theme, drums flash hot pink, bass triggers electric blue waves, and leads produce yellow color shifts.

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
| `Flash-Effects` | `FlashVisualEffect` + 6 concrete effects, `FlashScanlineOverlay` |
| `Flash-Themes` | `FlashEffectTheme`, `FlashRanaEffectTheme`, `FlashNeonEffectTheme` |
| `Flash-Themes-Editor` | `FlashThemeEditorElement` (preferences UI) |
| `Flash-Support` | `FlashTransportClock`, `FlashPitchParser`, `FlashSequencerSnapshot`, demo patterns |
| `Flash-Particles` | `FlashParticle`/`FlashParticleEngine` + `FlashParticleCanvasElement` |
| `Flash-Workspace` | `FlashWorkspace` model, `FlashWorkspaceWindow`, transport, matrix, scope, stream, synth panel, editor window |
| `Flash-Stage` | `FlashStageController`, `FlashStageScreen`, canvas, HUD editor, dock, zen controller, 4 presets |
| `Flash-Tests-Core` | Editor and evaluator tests |
| `Flash-Tests-Events` | Event and listener tests |
| `Flash-Tests-Effects` | Visual effect tests |
| `Flash-Tests-Themes` | Theme and theme editor tests |
| `Flash-Tests-Support` | Clock, pitch, snapshot tests |
| `Flash-Tests-Particles` | Particle engine and canvas tests |
| `Flash-Tests-Workspace` | Workspace model and element tests |
| `Flash-Tests-Stage` | Stage controller, presets, zen tests |
| `Flash-Tests-Integration` | Coypu integration tests |

Dependency graph:

```
Flash-Core ────┬── Flash-Events ─── Coypu
               ├── Flash-Effects
               └── Flash-Themes ──┬── Flash-Effects
                                  └── Flash-Events
Flash-Particles ── Flash-Support + Flash-Events + Flash-Effects + Bloc
Flash-Workspace ── Flash-Core + Flash-Particles + Flash-Themes-Editor + Bloc/Album
Flash-Stage ───── Flash-Workspace + Flash-Particles + Flash-Effects + Flash-Themes
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

With the partial packages loaded, test classes are: Flash-Tests-Support, -Events, -Effects, -Themes, -Core, -Particles, -Workspace, -Stage, -Integration.

```smalltalk
suite := TestSuite named: 'Flash'.
#('Flash-Tests-Support' 'Flash-Tests-Events' 'Flash-Tests-Effects'
  'Flash-Tests-Themes' 'Flash-Tests-Themes' 'Flash-Tests-Core'
  'Flash-Tests-Particles' 'Flash-Tests-Workspace' 'Flash-Tests-Stage'
  'Flash-Tests-Integration')
  do: [ :pkg |
    suite addTests: ((PackageOrganizer default packageNamed: pkg) definedClasses
      select: [ :c | c isTestCase ] thenCollect: [ :c | c buildSuite ]) ].
TestRunner new runSuite: suite.
```

Or run individual test classes, for example:

```smalltalk
(FlashLiveEditorTest selector: #testInitializationCreatesAlbEditor) run.
(FlashMelodyEventTest selector: #testSoundCategoryForDrumSounds) run.
(FlashEditorWorkflowTest selector: #testDrumEventTriggersFlashEffect) run.
```

## Test Summary

The suite is verified green (38 test classes, 168 tests) on a fresh Pharo 12 image loaded from the Metacello baseline.

| Test Class | # Tests | Component |
|---|---|---|
| `FlashLiveEditorTest` | 7 | Editor init, effects, cleanup |
| `FlashEditorCodeEvaluatorTest` | 6 | DoIt, PrintIt, contexts, errors |
| `FlashEditorCompletionControllerTest` | 4 | Popup, suggestions |
| `FlashEditorEventListenerTest` | 5 | Announcer, subscriptions |
| `FlashMelodyEventTest` | 11 | Properties, categories, factory, pitch |
| `FlashVisualEffectTest` | 4 | Duration, intensity, protocol |
| `FlashFlashEffectTest` | 3 | Background, color, duration |
| `FlashGlowEffectTest` | 2 | Border, duration |
| `FlashPulseEffectTest` | 2 | Transform, scale |
| `FlashWaveEffectTest` | 2 | Sequential, displacement |
| `FlashColorShiftEffectTest` | 3 | Color shift, restore, blend |
| `FlashBorderFlashEffectTest` | 2 | Border, width proportion |
| `FlashScanlineOverlayTest` | 2 | Bloc element, mouse transparency |
| `FlashEffectThemeTest` | 4 | Lookup, fallback, colors |
| `FlashRanaEffectThemeTest` | 7 | Mappings, colors, categories |
| `FlashNeonEffectThemeTest` | 4 | Mappings, colors |
| `FlashThemeEditorElementTest` | 5 | Sub-elements, themes, STON, animations |
| `FlashThemePaletteTest` | 3 | Surface monotonicity |
| `FlashTransportClockTest` | 7 | Swing, tap tempo, payload duration |
| `FlashPitchParserTest` | 5 | Note names, frequencies, black keys |
| `FlashDemoPatternsTest` | 3 | Sixteen-step demo patterns |
| `FlashSequencerSnapshotTest` | 3 | Lane/track round-trip |
| `FlashSoundEventLogTest` | 3 | Add/format, clear, ring buffer |
| `FlashCoypuAdapterTest` | 2 | Snapshot skips non-Coypu objects |
| `FlashParticleTest` | 4 | Particle lifecycle |
| `FlashParticleEngineTest` | 6 | Shockwave/spark/shower spawns |
| `FlashParticleCanvasElementTest` | 6 | Canvas assembly, reset, label |
| `FlashWorkspaceTest` | 7 | Lane mapping, cycle beats, panic |
| `FlashWorkspaceElementTest` | 8 | Window assembles, advance clock drives UI |
| `FlashOscilloscopeTest` | 5 | Ring buffer + element bars |
| `FlashEventStreamElementTest` | 3 | Row formatting |
| `FlashSynthPanelTest` | 5 | Model clamps, +/- steppers |
| `FlashStagePresentationTest` | 4 | Presets, apply, fallback |
| `FlashZenControllerTest` | 4 | Enter/exit/toggle zen |
| `FlashStageControllerTest` | 4 | Screen assembly, advance, presets |
| `FlashStageElementTest` | 5 | Canvas/HUD/dock/screen parts |
| `FlashCoypuIntegrationTest` | 4 | Extension methods, events |
| `FlashEditorWorkflowTest` | 12 | End-to-end editor workflow |
| **Total** | **168** | 38 test classes, all green |

## License

MIT
