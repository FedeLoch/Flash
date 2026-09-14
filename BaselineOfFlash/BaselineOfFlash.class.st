Class {
	#name : 'BaselineOfFlash',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFlash',
	#package : 'BaselineOfFlash'
}

{ #category : 'baselines' }
BaselineOfFlash >> baseline: spec [

	<baseline>
	spec for: #common do: [
			spec baseline: 'Coypu' with: [ spec repository: 'github://lucretiomsp/coypu:master' ].
			spec baseline: 'Bloc' with: [ spec repository: 'github://pharo-graphics/Bloc:master' ].
			spec baseline: 'Album' with: [ spec repository: 'github://pharo-graphics/Album:master' ].
			
			spec package: 'Flash-Support'.
			spec package: 'Flash-Core' with: [ spec requires: #( 'Flash-Events' 'Flash-Effects' 'Flash-Themes' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Events' with: [ spec requires: #( 'Coypu' 'Flash-Support' ) ].
			spec package: 'Flash-Effects' with: [ spec requires: #( 'Flash-Events' 'Flash-Support' 'Bloc' ) ].
			spec package: 'Flash-Themes' with: [ spec requires: #( 'Flash-Effects' 'Flash-Events' 'Flash-Support' ) ].
			spec package: 'Flash-Themes-Editor' with: [ spec requires: #( 'Flash-Themes' 'Flash-Effects' 'Flash-Events' 'Bloc' ) ].
			spec package: 'Flash-Particles' with: [ spec requires: #( 'Flash-Support' 'Flash-Events' 'Flash-Effects' 'Bloc' ) ].
			spec package: 'Flash-Workspace' with: [ spec requires: #( 'Flash-Core' 'Flash-Particles' 'Flash-Events' 'Flash-Effects' 'Flash-Themes' 'Flash-Themes-Editor' 'Flash-Support' 'Bloc' 'Album' ) ].
			spec package: 'Flash-Stage' with: [ spec requires: #( 'Flash-Workspace' 'Flash-Particles' 'Flash-Effects' 'Flash-Themes' 'Flash-Support' 'Bloc' ) ].
			spec package: 'Flash-Tests-Support' with: [ spec requires: #( 'Flash-Support' ) ].
			spec package: 'Flash-Tests-Core' with: [ spec requires: #( 'Flash-Core' ) ].
			spec package: 'Flash-Tests-Events' with: [ spec requires: #( 'Flash-Events' 'Flash-Support' ) ].
			spec package: 'Flash-Tests-Effects' with: [ spec requires: #( 'Flash-Effects' 'Flash-Events' ) ].
			spec package: 'Flash-Tests-Themes' with: [ spec requires: #( 'Flash-Themes' 'Flash-Effects' 'Flash-Events' 'Flash-Themes-Editor' ) ].
			spec package: 'Flash-Tests-Particles' with: [ spec requires: #( 'Flash-Particles' ) ].
			spec package: 'Flash-Tests-Workspace' with: [ spec requires: #( 'Flash-Workspace' ) ].
			spec package: 'Flash-Tests-Stage' with: [ spec requires: #( 'Flash-Stage' ) ].
			spec package: 'Flash-Tests-Integration' with: [ spec requires: #( 'Flash-Core' 'Flash-Events' 'Flash-Particles' 'Flash-Workspace' ) ]
	]
]
