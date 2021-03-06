﻿"Filed out from Dolphin Smalltalk 7"!

NMHDR subclass: #NMKEYDOWN
	instanceVariableNames: ''
	classVariableNames: '_OffsetOf_flags _OffsetOf_wVKey'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
NMKEYDOWN guid: (GUID fromString: '{87b4c628-026e-11d3-9fd7-00a0cc3e4a32}')!
NMKEYDOWN addClassConstant: '_OffsetOf_flags' value: 16r10!
NMKEYDOWN addClassConstant: '_OffsetOf_wVKey' value: 16rC!
NMKEYDOWN comment: 'NMKEYDOWN is an ExternalStructure class to represent the Win32 structures NMTVKEYDOWN, NMTCKEYDOWN and NMLVKEYDOWN, all of which have the same fields.
'!
!NMKEYDOWN categoriesForClass!External-Data-Structured-Win32! !
!NMKEYDOWN methodsFor!

flags
	"Answer the <Integer> value of the receiver's 'flags' field."

	^bytes dwordAtOffset: _OffsetOf_flags!

wVKey
	"Answer the <Integer> value of the receiver's 'wVKey' field."

	^bytes wordAtOffset: _OffsetOf_wVKey! !
!NMKEYDOWN categoriesFor: #flags!**compiled accessors**!public! !
!NMKEYDOWN categoriesFor: #wVKey!**compiled accessors**!public! !

!NMKEYDOWN class methodsFor!

defineFields
	"Define the fields of the Win32 NMKEYDOWN structure
		NMKEYDOWN compileDefinition
	"

	super defineFields.		"NMHDR fields"
	self defineField: #wVKey type: WORDField readOnly;
		defineField: #flags type: DWORDField readOnly!

getFieldNames
	^#(#hwndFrom #idFrom #code #wVKey #flags)! !
!NMKEYDOWN class categoriesFor: #defineFields!initializing!public! !
!NMKEYDOWN class categoriesFor: #getFieldNames!**compiled accessors**!constants!private! !

