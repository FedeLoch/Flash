Class {
	#name : #BaselineOfCoypuLive,
	#superclass : #BaselineOf,
	#category : #BaselineOfCoypuLive
}

{
	#category : #baselines
}
BaselineOfCoypuLive >> baseline: spec
	<baseline>
	spec for: #common do: [
		spec
			baseline: 'Coypu'
			with: [ spec repository: 'github://lucretiomsp/coypu:master' ].
		spec
			package: 'CoypuLive-Editor' with: [ spec requires: #('Coypu') ];
			package: 'CoypuLive-Events' with: [ spec requires: #('Coypu') ];
			package: 'CoypuLive-Effects';
			package: 'CoypuLive-Themes' with: [ spec requires: #('CoypuLive-Effects' 'CoypuLive-Events') ];
			package: 'CoypuLive-Themes-Editor' with: [ spec requires: #('CoypuLive-Themes' 'CoypuLive-Editor') ];
			package: 'CoypuLive-Tests-Editor' with: [ spec requires: #('CoypuLive-Editor') ];
			package: 'CoypuLive-Tests-Events' with: [ spec requires: #('CoypuLive-Events') ];
			package: 'CoypuLive-Tests-Effects' with: [ spec requires: #('CoypuLive-Effects') ];
			package: 'CoypuLive-Tests-Themes' with: [ spec requires: #('CoypuLive-Themes') ];
			package: 'CoypuLive-Tests-Integration' with: [ spec requires: #('CoypuLive-Editor' 'CoypuLive-Events' 'Coypu') ];
			package: 'CoypuLive' with: [ spec requires: #('CoypuLive-Editor' 'CoypuLive-Events' 'CoypuLive-Effects' 'CoypuLive-Themes') ] ]
