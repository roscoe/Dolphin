"Filed out from Dolphin Smalltalk 7"!

Object subclass: #WeakSubscriptionBuilder
	instanceVariableNames: 'announcer'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
WeakSubscriptionBuilder guid: (GUID fromString: '{C8B3FF0E-ED6E-4D0E-BD5C-316314346CC8}')!
WeakSubscriptionBuilder comment: 'I am a wrapper around an Announcer, used to create weak subscriptions at subscription time.
!WeakSubscriptionBuilder categoriesForClass!Announcements-Core! !
!WeakSubscriptionBuilder methodsFor!

announcer: anAnnouncer

on: anAnnouncementClass do: aValuable

on: anAnnouncementClass send: aSelector to: anObject

subscribe: anAnnouncementClass do: aValuable 

subscribe: anAnnouncementClass send: aSelector to: anObject

weak

when: anAnnouncementClass do: aValuable

when: anAnnouncementClass send: aSelector to: anObject
!WeakSubscriptionBuilder categoriesFor: #announcer:!initialize/release!public! !
!WeakSubscriptionBuilder categoriesFor: #on:do:!public!wrapped protocol! !
!WeakSubscriptionBuilder categoriesFor: #on:send:to:!public!wrapped protocol! !
!WeakSubscriptionBuilder categoriesFor: #subscribe:do:!private! !
!WeakSubscriptionBuilder categoriesFor: #subscribe:send:to:!public!wrapped protocol! !
!WeakSubscriptionBuilder categoriesFor: #weak!public!wrapped protocol! !
!WeakSubscriptionBuilder categoriesFor: #when:do:!public!wrapped protocol! !
!WeakSubscriptionBuilder categoriesFor: #when:send:to:!public!wrapped protocol! !

!WeakSubscriptionBuilder class methodsFor!

on: announcer
!WeakSubscriptionBuilder class categoriesFor: #on:!instance creation!public! !
