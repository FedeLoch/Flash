Class {
	#name : 'FlashWorkspaceWindow',
	#superclass : 'BlElement',
	#instVars : [
		'workspace',
		'transportBar',
		'matrixElement',
		'oscilloscopeElement',
		'eventStream',
		'synthPanelElement',
		'editorWindow',
		'particleCanvas'
	],
	#category : 'Flash-Workspace',
	#package : 'Flash-Workspace'
}

{ #category : 'instance creation' }
FlashWorkspaceWindow class >> onWorkspace: aWorkspace [
	^ self new workspace: aWorkspace
]

{ #category : 'running' }
FlashWorkspaceWindow >> advanceClock [
	| events |
	events := workspace advanceClock.
	self tickPlayhead.
	events do: [ :e |
		self pulseVisualsFor: e ].
	^ events size
]

{ #category : 'building' }
FlashWorkspaceWindow >> buildWindow [
	| rightColumn midRow bottomRow sideColumn |
	self layout: BlLinearLayout vertical.
	self extent: 1000 @ 680.
	self background: (Color fromHexString: '#0A0E14').
	transportBar := FlashTransportBarElement onWorkspace: workspace.
	transportBar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 44 ].
	matrixElement := FlashSequencerMatrixElement onWorkspace: workspace.
	matrixElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	editorWindow := FlashEditorWindowElement new.
	editorWindow constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	particleCanvas := FlashParticleCanvasElement new.
	particleCanvas constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	oscilloscopeElement := FlashOscilloscopeElement new.
	oscilloscopeElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 140 ].
	rightColumn := self verticalPane.
	rightColumn constraintsDo: [ :c |
		c horizontal exact: 320.
		c vertical matchParent ].
	rightColumn addChildren: { particleCanvas. oscilloscopeElement }.
	midRow := self horizontalPane.
	midRow addChildren: { editorWindow. rightColumn }.
	bottomRow := self horizontalPane.
	eventStream := FlashEventStreamElement new.
	eventStream constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	synthPanelElement := FlashSynthPanelElement new.
	synthPanelElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 132 ].
	sideColumn := self verticalPane.
	sideColumn constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical matchParent ].
	sideColumn addChildren: { eventStream. synthPanelElement }.
	bottomRow addChildren: { matrixElement. sideColumn }.
	self addChildren: { transportBar. midRow. bottomRow }
]

{ #category : 'accessing' }
FlashWorkspaceWindow >> editorWindow [
	^ editorWindow
]

{ #category : 'accessing' }
FlashWorkspaceWindow >> eventStream [
	^ eventStream
]

{ #category : 'building' }
FlashWorkspaceWindow >> horizontalPane [
	| pane |
	pane := BlElement new.
	pane layout: BlLinearLayout horizontal.
	pane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ pane
]

{ #category : 'initialization' }
FlashWorkspaceWindow >> initialize [
	super initialize.
	workspace := FlashWorkspace new.
	self buildWindow
]

{ #category : 'accessing' }
FlashWorkspaceWindow >> matrixElement [
	^ matrixElement
]

{ #category : 'accessing' }
FlashWorkspaceWindow >> oscilloscopeElement [
	^ oscilloscopeElement
]

{ #category : 'accessing' }
FlashWorkspaceWindow >> particleCanvas [
	^ particleCanvas
]

{ #category : 'accessing' }
FlashWorkspaceWindow >> lastLogEntries [
	| entries |
	entries := workspace soundEventLog entries.
	^ entries size <= 6
		ifTrue: [ entries ]
		ifFalse: [ entries last: 6 ]
]

{ #category : 'events' }
FlashWorkspaceWindow >> pulseVisualsFor: aFlashMelodyEvent [
	particleCanvas pulseFor: aFlashMelodyEvent.
	matrixElement tickToStep: (workspace transportClock step).
	transportBar flashPlayhead.
	oscilloscopeElement setSamples: ((1 to: 24) collect: [ :i |
		i = (workspace transportClock step + 1)
			ifTrue: [ aFlashMelodyEvent normalizedPitch ]
			ifFalse: [ 0 ] ]).
	eventStream refreshWith: (self lastLogEntries)
]

{ #category : 'accessing' }
FlashWorkspaceWindow >> synthPanelElement [
	^ synthPanelElement
]

{ #category : 'events' }
FlashWorkspaceWindow >> tickPlayhead [
	matrixElement tickToStep: (workspace transportClock step).
	transportBar flashPlayhead
]

{ #category : 'accessing' }
FlashWorkspaceWindow >> transportBar [
	^ transportBar
]

{ #category : 'building' }
FlashWorkspaceWindow >> verticalPane [
	| pane |
	pane := BlElement new.
	pane layout: BlLinearLayout vertical.
	pane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ pane
]

{ #category : 'accessing' }
FlashWorkspaceWindow >> workspace [
	^ workspace
]

{ #category : 'accessing' }
FlashWorkspaceWindow >> workspace: aWorkspace [
	workspace := aWorkspace.
	transportBar workspace: workspace.
	matrixElement workspace: workspace
]