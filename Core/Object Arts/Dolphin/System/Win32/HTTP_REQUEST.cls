"Filed out from Dolphin Smalltalk 7"!

ExternalStructure subclass: #HTTP_REQUEST
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
HTTP_REQUEST guid: (GUID fromString: '{5f3f936f-b824-47af-a69e-62dc4730010c}')!
HTTP_REQUEST comment: '<HTTP_REQUEST> is an <ExternalStructure> class to wrap the struct ''Win32.HTTP_REQUEST'' from type information in the ''Win32 API'' library.

The type library contains the following helpstring for this struct
	"Represents an incoming HTTP request (N.B. this is the V2 structure)"

** This comment was automatically generated from a type library. Delete this line to prevent any manual edits from being overwritten if the wrapper class is regenerated. **

IDL definition follows:

typedef [uuid(5f3f936f-b824-47af-a69e-62dc4730010c), helpstring("Represents an incoming HTTP request (N.B. this is the V2 structure)")]
struct tagHTTP_REQUEST {
	[helpstring("Request flags (see HTTP_REQUEST_FLAG_* definitions below).")] ULONG flags;
	[helpstring("An opaque request identifier. These values are used by the driver to correlate outgoing responses with incoming requests.")] unsigned __int64 ConnectionId;
	unsigned __int64 RequestId;
	[helpstring("The context associated with the URL prefix.")] HTTP_URL_CONTEXT UrlContext;
	[helpstring("The HTTP version number.")] HTTP_VERSION Version;
	[helpstring("The request verb.")] HTTP_VERB Verb;
	[nonbrowsable, helpstring("The length of the verb string if the Verb field is HttpVerbUnknown. In bytes not including the NUL")] USHORT UnknownVerbLength;
	[nonbrowsable, helpstring("The length of the raw (uncooked) URL in bytes not including the NUL")] USHORT RawUrlLength;
	[helpstring("Pointer to the verb string if the Verb field is HttpVerbUnknown."), string, size_is("UnknownVerbLength")] LPCSTR pUnknownVerb;
	[helpstring("Pointer to the raw (uncooked) URL"), string, size_is("RawUrlLength")] LPCSTR pRawUrl;
	[helpstring("The canonicalized Unicode URL")] HTTP_COOKED_URL CookedUrl;
	[helpstring("Local and remote transport addresses for the connection.")] HTTP_TRANSPORT_ADDRESS Address;
	[helpstring("The request headers.")] HTTP_REQUEST_HEADERS Headers;
	[helpstring("The total number of bytes received from network for this request.")] unsigned __int64 BytesReceived;
	USHORT EntityChunkCount;
	[helpstring("pEntityChunks is an array of EntityChunkCount HTTP_DATA_CHUNKs. The entity body is copied only if HTTP_RECEIVE_REQUEST_FLAG_COPY_BODY was passed to HttpReceiveHttpRequest().")] HTTP_DATA_CHUNK* pEntityChunks;
	unsigned __int64 RawConnectionId;
	[helpstring("SSL connection information.")] PHTTP_SSL_INFO pSslInfo;
	USHORT RequestInfoCount;
	[helpstring("Additional Request Informations.")] PHTTP_REQUEST_INFO pRequestInfo;
} HTTP_REQUEST;
'!
!HTTP_REQUEST categoriesForClass!Win32-Structs! !
!HTTP_REQUEST methodsFor!

Address
	"Answer the <PointerArray> value of the receiver's 'Address' field."

	^PointerArray
		fromAddress: bytes yourAddress + ##(self offsetOf: #Address)
		length: 2
		elementClass: SOCKADDR!

Address: aStructureArrayOfSOCKADDR
	"Set the receiver's 'Address' field to the value of the argument, aStructureArrayOfSOCKADDR"

	| size |
	size := aStructureArrayOfSOCKADDR byteSize min: ##(2 * SOCKADDR basicByteSize).
	aStructureArrayOfSOCKADDR
		replaceBytesOf: bytes
		from: ##((self offsetOf: #Address) + 1)
		to: ##(self offsetOf: #Address) + size
		startingAt: 1!

byteSize
	^bytes class isIndirection ifTrue: [super byteSize] ifFalse: [bytes size]!

BytesReceived
	"Answer the <Integer> value of the receiver's 'BytesReceived' field."

	^bytes qwordAtOffset: ##(self offsetOf: #BytesReceived)!

BytesReceived: anInteger
	"Set the receiver's 'BytesReceived' field to the value of the argument, anInteger"

	bytes qwordAtOffset: ##(self offsetOf: #BytesReceived) put: anInteger!

ConnectionId
	"Answer the <Integer> value of the receiver's 'ConnectionId' field."

	^bytes qwordAtOffset: ##(self offsetOf: #ConnectionId)!

ConnectionId: anInteger
	"Set the receiver's 'ConnectionId' field to the value of the argument, anInteger"

	bytes qwordAtOffset: ##(self offsetOf: #ConnectionId) put: anInteger!

CookedUrl
	"Answer the <HTTP_COOKED_URL> value of the receiver's 'CookedUrl' field."

	^HTTP_COOKED_URL fromAddress: bytes yourAddress + ##(self offsetOf: #CookedUrl)!

CookedUrl: aHTTP_COOKED_URL
	"Set the receiver's 'CookedUrl' field to the value of the argument, aHTTP_COOKED_URL"

	aHTTP_COOKED_URL
		replaceBytesOf: bytes
		from: ##((self offsetOf: #CookedUrl) + 1)
		to: ##((self offsetOf: #CookedUrl) + HTTP_COOKED_URL basicByteSize)
		startingAt: 1!

EntityChunkCount
	"Answer the <Integer> value of the receiver's 'EntityChunkCount' field."

	^bytes wordAtOffset: ##(self offsetOf: #EntityChunkCount)!

EntityChunkCount: anInteger
	"Set the receiver's 'EntityChunkCount' field to the value of the argument, anInteger"

	bytes wordAtOffset: ##(self offsetOf: #EntityChunkCount) put: anInteger!

flags
	"Answer the <Integer> value of the receiver's 'flags' field."

	^bytes dwordAtOffset: 0!

flags: anInteger
	"Set the receiver's 'flags' field to the value of the argument, anInteger"

	bytes dwordAtOffset: 0 put: anInteger!

Headers
	"Answer the <HTTP_REQUEST_HEADERS> value of the receiver's 'Headers' field."

	^HTTP_REQUEST_HEADERS fromAddress: bytes yourAddress + ##(self offsetOf: #Headers)!

Headers: aHTTP_REQUEST_HEADERS
	"Set the receiver's 'Headers' field to the value of the argument, aHTTP_REQUEST_HEADERS"

	aHTTP_REQUEST_HEADERS
		replaceBytesOf: bytes
		from: ##((self offsetOf: #Headers) + 1)
		to: ##((self offsetOf: #Headers) + HTTP_REQUEST_HEADERS basicByteSize)
		startingAt: 1!

pEntityChunks
	"Answer the <HTTP_DATA_CHUNK> value of the receiver's 'pEntityChunks' field."

	^HTTP_DATA_CHUNK fromAddress: (bytes intPtrAtOffset: ##(self offsetOf: #pEntityChunks))!

pEntityChunks: aHTTP_DATA_CHUNK
	"Set the receiver's 'pEntityChunks' field to the value of the argument, aHTTP_DATA_CHUNK"

	bytes uintPtrAtOffset: ##(self offsetOf: #pEntityChunks) put: aHTTP_DATA_CHUNK yourAddress!

pRawUrl
	"Answer the <String> value of the receiver's 'pRawUrl' field."

	^String fromAddress: (bytes intPtrAtOffset: ##(self offsetOf: #pRawUrl)) length: self RawUrlLength!

pRawUrl: aString
	"Set the receiver's 'pRawUrl' field to the value of the argument, aString"

	bytes uintPtrAtOffset: ##(self offsetOf: #pRawUrl) put: aString yourAddress.
	self RawUrlLength: aString size!

pRequestInfo
	"Answer the <HTTP_REQUEST_INFO> value of the receiver's 'pRequestInfo' field."

	^HTTP_REQUEST_INFO fromAddress: (bytes intPtrAtOffset: ##(self offsetOf: #pRequestInfo))!

pRequestInfo: aHTTP_REQUEST_INFO
	"Set the receiver's 'pRequestInfo' field to the value of the argument, aHTTP_REQUEST_INFO"

	bytes uintPtrAtOffset: ##(self offsetOf: #pRequestInfo) put: aHTTP_REQUEST_INFO yourAddress!

pSslInfo
	"Answer the <HTTP_SSL_INFO> value of the receiver's 'pSslInfo' field."

	^HTTP_SSL_INFO fromAddress: (bytes intPtrAtOffset: ##(self offsetOf: #pSslInfo))!

pSslInfo: aHTTP_SSL_INFO
	"Set the receiver's 'pSslInfo' field to the value of the argument, aHTTP_SSL_INFO"

	bytes uintPtrAtOffset: ##(self offsetOf: #pSslInfo) put: aHTTP_SSL_INFO yourAddress!

pUnknownVerb
	"Answer the <String> value of the receiver's 'pUnknownVerb' field."

	^String fromAddress: (bytes intPtrAtOffset: ##(self offsetOf: #pUnknownVerb))
		length: self UnknownVerbLength!

pUnknownVerb: aString
	"Set the receiver's 'pUnknownVerb' field to the value of the argument, aString"

	bytes uintPtrAtOffset: ##(self offsetOf: #pUnknownVerb) put: aString yourAddress.
	self UnknownVerbLength: aString size!

RawConnectionId
	"Answer the <Integer> value of the receiver's 'RawConnectionId' field."

	^bytes qwordAtOffset: ##(self offsetOf: #RawConnectionId)!

RawConnectionId: anInteger
	"Set the receiver's 'RawConnectionId' field to the value of the argument, anInteger"

	bytes qwordAtOffset: ##(self offsetOf: #RawConnectionId) put: anInteger!

RawUrlLength
	"Private - Answer the <Integer> value of the receiver's 'RawUrlLength' field."

	^bytes wordAtOffset: ##(self offsetOf: #RawUrlLength)!

RawUrlLength: anInteger
	"Set the receiver's 'RawUrlLength' field to the value of the argument, anInteger"

	bytes wordAtOffset: ##(self offsetOf: #RawUrlLength) put: anInteger!

RequestId
	"Answer the <Integer> value of the receiver's 'RequestId' field."

	^bytes qwordAtOffset: ##(self offsetOf: #RequestId)!

RequestId: anInteger
	"Set the receiver's 'RequestId' field to the value of the argument, anInteger"

	bytes qwordAtOffset: ##(self offsetOf: #RequestId) put: anInteger!

RequestInfoCount
	"Answer the <Integer> value of the receiver's 'RequestInfoCount' field."

	^bytes wordAtOffset: ##(self offsetOf: #RequestInfoCount)!

RequestInfoCount: anInteger
	"Set the receiver's 'RequestInfoCount' field to the value of the argument, anInteger"

	bytes wordAtOffset: ##(self offsetOf: #RequestInfoCount) put: anInteger!

UnknownVerbLength
	"Private - Answer the <Integer> value of the receiver's 'UnknownVerbLength' field."

	^bytes wordAtOffset: ##(self offsetOf: #UnknownVerbLength)!

UnknownVerbLength: anInteger
	"Set the receiver's 'UnknownVerbLength' field to the value of the argument, anInteger"

	bytes wordAtOffset: ##(self offsetOf: #UnknownVerbLength) put: anInteger!

UrlContext
	"Answer the <Integer> value of the receiver's 'UrlContext' field."

	^bytes qwordAtOffset: ##(self offsetOf: #UrlContext)!

UrlContext: anInteger
	"Set the receiver's 'UrlContext' field to the value of the argument, anInteger"

	bytes qwordAtOffset: ##(self offsetOf: #UrlContext) put: anInteger!

Verb
	"Answer the <Integer> value of the receiver's 'Verb' field."

	^bytes sdwordAtOffset: ##(self offsetOf: #Verb)!

Verb: anInteger
	"Set the receiver's 'Verb' field to the value of the argument, anInteger"

	bytes sdwordAtOffset: ##(self offsetOf: #Verb) put: anInteger!

Version
	"Answer the <WORDArray> value of the receiver's 'Version' field."

	^WORDArray fromAddress: bytes yourAddress + ##(self offsetOf: #Version) length: 2!

Version: aWORDArray
	"Set the receiver's 'Version' field to the value of the argument, aWORDArray"

	| size |
	size := aWORDArray byteSize min: ##(2 * WORDArray elementSize).
	aWORDArray
		replaceBytesOf: bytes
		from: ##((self offsetOf: #Version) + 1)
		to: ##(self offsetOf: #Version) + size
		startingAt: 1! !
!HTTP_REQUEST categoriesFor: #Address!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #Address:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #byteSize!accessing!public! !
!HTTP_REQUEST categoriesFor: #BytesReceived!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #BytesReceived:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #ConnectionId!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #ConnectionId:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #CookedUrl!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #CookedUrl:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #EntityChunkCount!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #EntityChunkCount:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #flags!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #flags:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #Headers!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #Headers:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #pEntityChunks!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #pEntityChunks:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #pRawUrl!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #pRawUrl:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #pRequestInfo!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #pRequestInfo:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #pSslInfo!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #pSslInfo:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #pUnknownVerb!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #pUnknownVerb:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #RawConnectionId!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #RawConnectionId:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #RawUrlLength!**compiled accessors**!private! !
!HTTP_REQUEST categoriesFor: #RawUrlLength:!**compiled accessors**!private! !
!HTTP_REQUEST categoriesFor: #RequestId!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #RequestId:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #RequestInfoCount!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #RequestInfoCount:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #UnknownVerbLength!**compiled accessors**!private! !
!HTTP_REQUEST categoriesFor: #UnknownVerbLength:!**compiled accessors**!private! !
!HTTP_REQUEST categoriesFor: #UrlContext!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #UrlContext:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #Verb!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #Verb:!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #Version!**compiled accessors**!public! !
!HTTP_REQUEST categoriesFor: #Version:!**compiled accessors**!public! !

!HTTP_REQUEST class methodsFor!

defineFields
	"Define the fields of the HTTP_REQUEST structure.

	HTTP_REQUEST  compileDefinition

		typedef [uuid(5f3f936f-b824-47af-a69e-62dc4730010c), helpstring('Represents an incoming HTTP request (N.B. this is the V2 structure)')]
		struct tagHTTP_REQUEST {
			[helpstring('Request flags (see HTTP_REQUEST_FLAG_* definitions below).')] ULONG flags;
			[helpstring('An opaque request identifier. These values are used by the driver to correlate outgoing responses with incoming requests.')] unsigned __int64 ConnectionId;
			unsigned __int64 RequestId;
			[helpstring('The context associated with the URL prefix.')] HTTP_URL_CONTEXT UrlContext;
			[helpstring('The HTTP version number.')] HTTP_VERSION Version;
			[helpstring('The request verb.')] HTTP_VERB Verb;
			[nonbrowsable, helpstring('The length of the verb string if the Verb field is HttpVerbUnknown. In bytes not including the NUL')] USHORT UnknownVerbLength;
			[nonbrowsable, helpstring('The length of the raw (uncooked) URL in bytes not including the NUL')] USHORT RawUrlLength;
			[helpstring('Pointer to the verb string if the Verb field is HttpVerbUnknown.'), string, size_is('UnknownVerbLength')] LPCSTR pUnknownVerb;
			[helpstring('Pointer to the raw (uncooked) URL'), string, size_is('RawUrlLength')] LPCSTR pRawUrl;
			[helpstring('The canonicalized Unicode URL')] HTTP_COOKED_URL CookedUrl;
			[helpstring('Local and remote transport addresses for the connection.')] HTTP_TRANSPORT_ADDRESS Address;
			[helpstring('The request headers.')] HTTP_REQUEST_HEADERS Headers;
			[helpstring('The total number of bytes received from network for this request.')] unsigned __int64 BytesReceived;
			USHORT EntityChunkCount;
			[helpstring('pEntityChunks is an array of EntityChunkCount HTTP_DATA_CHUNKs. The entity body is copied only if HTTP_RECEIVE_REQUEST_FLAG_COPY_BODY was passed to HttpReceiveHttpRequest().')] HTTP_DATA_CHUNK* pEntityChunks;
			unsigned __int64 RawConnectionId;
			[helpstring('SSL connection information.')] PHTTP_SSL_INFO pSslInfo;
			USHORT RequestInfoCount;
			[helpstring('Additional Request Informations.')] PHTTP_REQUEST_INFO pRequestInfo;
		} HTTP_REQUEST;
"

	self
		defineField: #flags type: DWORDField new offset: 0;
		defineField: #ConnectionId type: QWORDField new offset: 8;
		defineField: #RequestId type: QWORDField new offset: 16;
		defineField: #UrlContext type: QWORDField new offset: 24;
		defineField: #Version type: (ArrayField type: WORDArray length: 2) offset: 32;
		defineField: #Verb type: SDWORDField new offset: 36;
		defineField: #UnknownVerbLength type: WORDField new beNonBrowsable offset: 40;
		defineField: #RawUrlLength type: WORDField new beNonBrowsable offset: 42;
		defineField: #pUnknownVerb type: (ConformantArrayPointerField type: String length: #UnknownVerbLength) offset: 44;
		defineField: #pRawUrl type: (ConformantArrayPointerField type: String length: #RawUrlLength) offset: 48;
		defineField: #CookedUrl type: (StructureField type: HTTP_COOKED_URL) offset: 52;
		defineField: #Address type: (PointerArrayField type: SOCKADDR length: 2) offset: 76;
		defineField: #Headers type: (StructureField type: HTTP_REQUEST_HEADERS) offset: 84;
		defineField: #BytesReceived type: QWORDField new offset: 432;
		defineField: #EntityChunkCount type: WORDField new offset: 440;
		defineField: #pEntityChunks type: (PointerField type: HTTP_DATA_CHUNK) offset: 444;
		defineField: #RawConnectionId type: QWORDField new offset: 448;
		defineField: #pSslInfo type: (PointerField type: HTTP_SSL_INFO) offset: 456;
		defineField: #RequestInfoCount type: WORDField new offset: 460;
		defineField: #pRequestInfo type: (PointerField type: HTTP_REQUEST_INFO) offset: 464.
	self byteSize: 472! !
!HTTP_REQUEST class categoriesFor: #defineFields!**auto generated**!initializing!public! !
