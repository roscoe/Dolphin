"Filed out from Dolphin Smalltalk 7"!

ODBDeserializers subclass: #ODBCopyValue
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ODBCopyValue guid: (GUID fromString: '{8162ee0b-0fb8-11d4-b091-000000000000}')!
ODBCopyValue comment: ''!
!ODBCopyValue categoriesForClass!No category! !
!ODBCopyValue methodsFor!

odbDeserialize: deserializer

	^value copy!

value: anObject

    value := anObject.! !
!ODBCopyValue categoriesFor: #odbDeserialize:!private! !
!ODBCopyValue categoriesFor: #value:!private! !

!ODBCopyValue class methodsFor!

value: anObject 
	^self new value: anObject! !
!ODBCopyValue class categoriesFor: #value:!accessing!public! !

