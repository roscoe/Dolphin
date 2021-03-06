﻿"Filed out from Dolphin Smalltalk 7"!

Win32Structure subclass: #PROTOENT
	instanceVariableNames: ''
	classVariableNames: '_OffsetOf_p_aliases _OffsetOf_p_name _OffsetOf_p_proto'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
PROTOENT guid: (GUID fromString: '{87b4c60a-026e-11d3-9fd7-00a0cc3e4a32}')!
PROTOENT addClassConstant: '_OffsetOf_p_aliases' value: 16r4!
PROTOENT addClassConstant: '_OffsetOf_p_name' value: 16r0!
PROTOENT addClassConstant: '_OffsetOf_p_proto' value: 16r8!
PROTOENT comment: '<PROTOENT> is an <ExternalStructure> class to wrap the struct ''Win32.PROTOENT'' from type information in the ''Win32 API'' library.

The type library contains the following helpstring for this struct
	"The name and protocol numbers that correspond to a given protocol name. Applications must never attempt to modify this structure or to free any of its components. Furthermore, only one copy of this structure is allocated per thread."

Warning: This comment was automatically generated from the struct''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

typedef [uuid(87B4C60A-026E-11D3-9FD7-00A0CC3E4A32), helpstring("The name and protocol numbers that correspond to a given protocol name. Applications must never attempt to modify this structure or to free any of its components. Furthermore, only one copy of this structure is allocated per thread.")]
struct tagPROTOENT {
	[readonly, helpstring("Official name of the protocol.")] LPCSTR p_name;
	[hidden, readonly, helpstring("Null-terminated array of alternate names.")] void** p_aliases;
	[readonly, helpstring("Protocol number, in host byte order.")] short p_proto;
} PROTOENT;
'!
!PROTOENT categoriesForClass!Win32-Structs! !
!PROTOENT methodsFor!

aliases
	"Answer an <Array> of <String>, being the alias names for the protocol."

	| i addresses list each |
	addresses := Array writeStream.
	i := 0.
	list := (bytes uintPtrAtOffset: _OffsetOf_p_aliases) asExternalAddress.
	
	[each := list uintPtrAtOffset: i.
	each isNull] whileFalse: 
				[addresses nextPut: (AnsiString fromAddress: each).
				i := i + VMConstants.IntPtrSize].
	^addresses contents!

p_name
	"Answer the <AnsiString> value of the receiver's 'p_name' field."

	^AnsiString fromAddress: (bytes intPtrAtOffset: _OffsetOf_p_name)!

p_proto
	"Answer the <Integer> value of the receiver's 'p_proto' field."

	^bytes swordAtOffset: _OffsetOf_p_proto!

printFieldsOn: aStream limit: anInteger
	super printFieldsOn: aStream limit: anInteger.
	aStream
		nextPutAll: ', aliases=';
		print: self aliases!

protocol
	"Answer the <integer> protocol number."

	| bigEndian |
	bigEndian := self p_proto.
	^(bigEndian << 8 bitOr: bigEndian >> 8) bitAnd: 16rFFFF! !
!PROTOENT categoriesFor: #aliases!public! !
!PROTOENT categoriesFor: #p_name!**compiled accessors**!public! !
!PROTOENT categoriesFor: #p_proto!**compiled accessors**!public! !
!PROTOENT categoriesFor: #printFieldsOn:limit:!development!printing!private! !
!PROTOENT categoriesFor: #protocol!public! !

!PROTOENT class methodsFor!

defineFields
	"Define the fields of the PROTOENT structure.

	PROTOENT  compileDefinition

		typedef [uuid(87B4C60A-026E-11D3-9FD7-00A0CC3E4A32), helpstring('The name and protocol numbers that correspond to a given protocol name. Applications must never attempt to modify this structure or to free any of its components. Furthermore, only one copy of this structure is allocated per thread.')]
		struct tagPROTOENT {
			[readonly, helpstring('Official name of the protocol.')] LPCSTR p_name;
			[hidden, readonly, helpstring('Null-terminated array of alternate names.')] LPCSTR* p_aliases;
			[readonly, helpstring('Protocol number, in host byte order.')] short p_proto;
		} PROTOENT;
"

	self
		defineField: #p_name type: (PointerField type: AnsiString) beReadOnly offset: 0;
		defineField: #p_aliases type: (PointerField type: LPSTR) beReadOnly beFiller offset: 4;
		defineField: #p_proto type: SWORDField new beReadOnly offset: 8.
	self byteSize: 12!

fromString: aString
	"Answer the static (per-thread) PROTOENT instance populated with data for the named protocol.
		(self fromString: 'tcp') 
	"

	| answer lib |
	lib := WS2_32Library default.
	answer := lib getprotobyname: aString.
	^answer isNull ifTrue: [SocketError signalWith: lib wsaGetLastError] ifFalse: [answer]!

getFieldNames
	^#(#p_name #p_proto)! !
!PROTOENT class categoriesFor: #defineFields!**auto generated**!initializing!public! !
!PROTOENT class categoriesFor: #fromString:!public! !
!PROTOENT class categoriesFor: #getFieldNames!**compiled accessors**!constants!private! !

