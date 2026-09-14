Class {
	#name : #FlashCoypuAdapterTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Events'
}

{
	#category : #tests
}
FlashCoypuAdapterTest >> testSnapshotSkipsNonCoypuObjects [
	| snapshot |
	snapshot := FlashCoypuAdapter snapshotFrom: 42.
	self assert: snapshot keys isEmpty
]

{
	#category : #tests
}
FlashCoypuAdapterTest >> testSnapshotUsesSequencers [
	| fake snapshot |
	fake := FakePerformanceWithSequencers new.
	fake sequencers: {
		(FakeFlashSequencer new
			seqKey: #kick;
			gates: #(1 0 0 0 1 0 0 0 1 0 1 0 1 0 0 0);
			notes: #(36);
			yourself).
		(FakeFlashSequencer new
			seqKey: #lead;
			gates: #(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1);
			notes: #(60 62 64 65);
			yourself) }.
	snapshot := FlashCoypuAdapter snapshotFrom: fake.
	self assert: (snapshot hasLane: #kick).
	self assert: (snapshot hasLane: #lead).
	self assert: ((snapshot laneAtKey: #lead) noteAt: 3) equals: 64
]