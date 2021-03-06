﻿"Filed out from Dolphin Smalltalk 7"!

Object subclass: #InternetAddress
	instanceVariableNames: 'host ipAddress'
	classVariableNames: ''
	poolDictionaries: 'WinSocketConstants'
	classInstanceVariableNames: ''!
InternetAddress guid: (GUID fromString: '{87b4c495-026e-11d3-9fd7-00a0cc3e4a32}')!
InternetAddress comment: 'This class represents an Internet IP address. It can be created indirectly from the host name using the #host: class method or, if the IP address is known, from this using #ipAddress:, #fromString: or #readFrom:. 

Since conversion from IP address to host name and vice versa requires a DNS or HOSTS lookup, the #ipAddress and #host accessors may lazily evaluate their answers if the information was not available when the instance was created. This is to save a potentially expensive DNS lookup during instantiation when it may not be appropriate or a TCP/IP connection may not be available. Note that a reverse lookup (ipAddress->host name) seems to be a particularly time consuming operation under Windows.
'!
!InternetAddress categoriesForClass!Windows Sockets! !
!InternetAddress methodsFor!

asParameter
	"Answer the receiver in a form suitable for passing to an external function."

	^self ipAddress!

displayIPOn: aStream 
	self ipAddress do: [:each | aStream display: each] separatedBy: [aStream nextPut: $.]!

displayOn: aStream 
	"Append, to aStream, a String whose characters are a description
	as a user might want to see it. We don't resolve the host or IP address
	by default, as this can take a long time, and may give an error."

	host isNil 
		ifTrue: [ipAddress isNil ifFalse: [self displayIPOn: aStream]]
		ifFalse: [host displayOn: aStream]!

host
	"Answer the name of the host defined by the address held by the receiver.
	This may be lazily evaluated if the receiver was initialized from an IP address and
	in such cases will require a DNS lookup"

	(host isNil and: [ipAddress notNil]) 
		ifTrue: 
			[| hostent |
			hostent := WS2_32Library default 
						gethostbyaddr: ipAddress
						len: ipAddress size
						type: AF_INET.
			hostent isNull ifTrue: [^SocketError signalWith: Processor activeProcess lastError].
			host := hostent host].
	^host!

host: aStringHostName 
	"Private - Set the name of the host for the address held by the receiver
	to aStringHostName."

	host := aStringHostName!

ipAddress
	"Answer the address as a ByteArray, i.e. #[192 169 0 1].
	This may be lazily evaluated if the receiver was initialized from a host name and in
	such cases will require a DNS or HOSTS reverse lookup"

	ipAddress isNil ifTrue: [ipAddress := (HOSTENT host: self host) address ipAddress].
	^ipAddress!

ipAddress: bytes 
	"Private - Set the address instance variable to the specified bytes."

	ipAddress := bytes asByteArray!

ipString
	"Answer the IP address as a dotted IP address string."

	| stream |
	stream := String writeStream: 15.
	self displayIPOn: stream.
	^stream contents!

printOn: aStream 
	"Append, to aStream, a String whose characters are a description
	of the receiver as a developer would want to see it."

	aStream
		basicPrint: self;
		nextPut: $(;
		display: self;
		nextPut: $)! !
!InternetAddress categoriesFor: #asParameter!accessing!public! !
!InternetAddress categoriesFor: #displayIPOn:!displaying!public! !
!InternetAddress categoriesFor: #displayOn:!displaying!public! !
!InternetAddress categoriesFor: #host!accessing!public! !
!InternetAddress categoriesFor: #host:!accessing!private! !
!InternetAddress categoriesFor: #ipAddress!accessing!public! !
!InternetAddress categoriesFor: #ipAddress:!accessing!private! !
!InternetAddress categoriesFor: #ipString!accessing!public! !
!InternetAddress categoriesFor: #printOn:!printing!public! !

!InternetAddress class methodsFor!

allForHost: aStringHostName
	"Answer an Array of instances of the receiver for all the addresses of the host with
	aStringHostName.

		InternetAddress allForHost: SessionManager current computerName
	"

	^(HOSTENT host: aStringHostName) allAddresses!

fromIPString: aString
	"Instantiate a new instance of the receiver from aString representing the textual
	form of the IP address.

		InternetAddress fromIPString: '192.169.0.1'
	"

	^(IN_ADDR fromString: aString) address!

fromString: aString 
	"Instantiate a new instance of the receiver from aString. This may contain either a host
	name or an IP address."

	^(self isIPString: aString) ifTrue: [self fromIPString: aString] ifFalse: [self host: aString]!

host: aStringHostName 
	"Answer a new instance of the receiver containing the address of host with
	aStringHostName.

		InternetAddress host: 'moll.object-arts.com'
	"

	^(self new)
		host: aStringHostName;
		yourself!

ipAddress: aByteArray 
	"Answer a new instance of the receiver containing the address, aByteArray.
	This will be a 4 byte array containing the IP address,

	InternetAddress ipAddress: #[192 169 0 1]
	"

	^(self new)
		ipAddress: aByteArray;
		yourself!

isIPString: aString 
	"Answer if aString is a IPv4 address, based on the test described in Section 3.2.2 of
	<http://www.ietf.org/rfc/rfc2396.txt>"

	| lastDot |
	lastDot := aString lastIndexOf: $..
	^lastDot > 0 and: [lastDot < aString size and: [(aString at: lastDot + 1) isDigit]]!

localHost
	"Answer a new instance of the receiver containing the address of the local host."

	| hostName result |
	hostName := String new: 256.
	result := WS2_32Library default gethostname: hostName namelen: hostName size.
	result = SOCKET_ERROR ifTrue: [^SocketError signal].
	^self host: hostName trimNulls! !
!InternetAddress class categoriesFor: #allForHost:!accessing!public! !
!InternetAddress class categoriesFor: #fromIPString:!instance creation!public! !
!InternetAddress class categoriesFor: #fromString:!instance creation!public! !
!InternetAddress class categoriesFor: #host:!instance creation!public! !
!InternetAddress class categoriesFor: #ipAddress:!instance creation!public! !
!InternetAddress class categoriesFor: #isIPString:!public!testing! !
!InternetAddress class categoriesFor: #localHost!instance creation!public! !

