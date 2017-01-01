"Filed out from Dolphin Smalltalk 7"!

Object subclass: #SubscriptionRegistry
	instanceVariableNames: 'subscriptions monitor'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SubscriptionRegistry guid: (GUID fromString: '{A785D939-EDAB-48AD-B4A7-0BF0A69EC5F3}')!
SubscriptionRegistry comment: 'The subscription registry is a threadsafe storage for the subscriptions to an Announcer.
!SubscriptionRegistry categoriesForClass!Announcements-Core! !
!SubscriptionRegistry methodsFor!

add: subscription

deliver: anAnnouncement

deliver: anAnnouncement to: subs

deliver: anAnnouncement to: subs startingAt: startIndex

glmSubscriptions

initialize

numberOfSubscriptions

protected: aBlock

remove: subscription

removeSubscriber: subscriber

replace: subscription with: newOne

reset

subscriptionsHandling: anAnnouncement

subscriptionsOf: aSubscriber do: aBlock
!SubscriptionRegistry categoriesFor: #add:!add/remove!public! !
!SubscriptionRegistry categoriesFor: #deliver:!announcing!public! !
!SubscriptionRegistry categoriesFor: #deliver:to:!private! !
!SubscriptionRegistry categoriesFor: #deliver:to:startingAt:!private! !
!SubscriptionRegistry categoriesFor: #glmSubscriptions!*glamour/tests/core!public! !
!SubscriptionRegistry categoriesFor: #initialize!initialization!public! !
!SubscriptionRegistry categoriesFor: #numberOfSubscriptions!accessing!public! !
!SubscriptionRegistry categoriesFor: #protected:!private! !
!SubscriptionRegistry categoriesFor: #remove:!add/remove!public! !
!SubscriptionRegistry categoriesFor: #removeSubscriber:!add/remove!public! !
!SubscriptionRegistry categoriesFor: #replace:with:!add/remove!public! !
!SubscriptionRegistry categoriesFor: #reset!initialize/release!public! !
!SubscriptionRegistry categoriesFor: #subscriptionsHandling:!accessing!public! !
!SubscriptionRegistry categoriesFor: #subscriptionsOf:do:!iterating!public! !

!SubscriptionRegistry class methodsFor!

new	
	^super new initialize! !
!SubscriptionRegistry class categoriesFor: #new!public! !
