Class {
	#name : 'FlashWorkspaceElementTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Workspace',
	#package : 'Flash-Tests-Workspace'
}

{ #category : 'tests' }
FlashWorkspaceElementTest >> testEditorWindowAssembles [
	| window |
	window := FlashEditorWindowElement new.
	self assert: window liveEditor isNotNil.
	self assert: window doItButton isNotNil.
	self assert: window printItButton isNotNil.
	self assert: window inspectItButton isNotNil
]

{ #category : 'tests' }
FlashWorkspaceElementTest >> testMatrixRowCounts [
	| matrix |
	matrix := FlashSequencerMatrixElement onWorkspace: FlashWorkspace new.
	self assert: matrix rowPanels size equals: 3
]

{ #category : 'tests' }
FlashWorkspaceElementTest >> testMatrixTickHighlights [
	| matrix |
	matrix := FlashSequencerMatrixElement onWorkspace: FlashWorkspace new.
	self assert: (matrix tickToStep: 0) equals: 0.
	self assert: (matrix isLaneActiveAtStep: 0 lane: #kick)
]

{ #category : 'tests' }
FlashWorkspaceElementTest >> testMatrixTickStepDoesNotError [
	| matrix |
	matrix := FlashSequencerMatrixElement onWorkspace: FlashWorkspace new.
	16 timesRepeat: [ matrix tickToStep: matrix stepIndex + 1 ].
	self assert: matrix stepIndex equals: 15
]

{ #category : 'tests' }
FlashWorkspaceElementTest >> testTransportBarBuilds [
	| bar workspace |
	workspace := FlashWorkspace new.
	bar := FlashTransportBarElement onWorkspace: workspace.
	self assert: bar playPauseButton isNotNil.
	self assert: bar tapButton isNotNil.
	self assert: bar panicButton isNotNil.
	self assert: bar beatLamp isNotNil.
	self assert: (bar bpmValueLabel text asString includesSubstring: '138')
]

{ #category : 'tests' }
FlashWorkspaceElementTest >> testTransportFlashPlayheadDoesNotError [
	| bar |
	bar := FlashTransportBarElement onWorkspace: FlashWorkspace new.
	bar flashPlayhead.
	self assert: bar beatLamp background paint color equals: (Color fromHexString: '#00F2FF')
]

{ #category : 'tests' }
FlashWorkspaceElementTest >> testWindowAssembles [
	| window |
	window := FlashWorkspaceWindow onWorkspace: FlashWorkspace new.
	self assert: window transportBar isNotNil.
	self assert: window matrixElement isNotNil.
	self assert: window editorWindow isNotNil.
	self assert: window particleCanvas isNotNil.
	self assert: window oscilloscopeElement isNotNil.
	self assert: window eventStream isNotNil.
	self assert: window synthPanelElement isNotNil
]

{ #category : 'tests' }
FlashWorkspaceElementTest >> testWindowAdvanceClockDrivesUi [
	| window count |
	window := FlashWorkspaceWindow onWorkspace: FlashWorkspace new.
	count := 0.
	16 timesRepeat: [ count := count + (window advanceClock) ].
	self assert: count equals: 21
]