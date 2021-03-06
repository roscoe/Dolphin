﻿"Filed out from Dolphin Smalltalk 7"!

ArrayedCollectionTest subclass: #AbstractStringTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AbstractStringTest guid: (GUID fromString: '{262b323f-d574-423e-8571-63b1fab0d021}')!
AbstractStringTest isAbstract: true!
AbstractStringTest comment: ''!
!AbstractStringTest categoriesForClass!Unclassified! !
!AbstractStringTest methodsFor!

assimilate: each 
	^Character codePoint: each asInteger!

assimilateString: aString
	^self subclassResponsibility!

caseConversionCases
	^{{'abc £12' asAnsiString. 'ABC £12' asAnsiString}.
		{'oña' asAnsiString. 'OÑA' asAnsiString}.
		{'árvízturo tükörfúrógép' asAnsiString. 'ÁRVÍZTURO TÜKÖRFÚRÓGÉP' asAnsiString}.
		{AnsiString fromByteArray: #[97 0 98]. AnsiString fromByteArray: #[65 0 66]}}!

equalityTestCases
	^#('' 'a' 'abc' '' 'tükörfúrógép' 'Ḽơᶉëᶆ ȋṕšᶙṁ ḍỡḽǭᵳ ʂǐť ӓṁệẗ, ĉṓɲṩḙċťᶒțûɾ ấɖḯƥĭṩčįɳġ ḝłįʈ, șếᶑ ᶁⱺ ẽḭŭŝḿꝋď ṫĕᶆᶈṓɍ ỉñḉīḑȋᵭṵńť ṷŧ ḹẩḇőꝛế éȶ đꝍꞎôꝛȇ ᵯáꞡᶇā ąⱡîɋṹẵ' 'a🐬' 'a £=1.2€')!

newNumericArray: anInteger 
	^self newCollection: ((1 to: anInteger) collect: [:each | Character digitValue: each])!

reverseTestCases
	^#(#('' '') #('a' 'a') #('ab' 'ba') #('abc' 'cba') #('oña' 'año'))!

testAsByteArray
	super testAsByteArray.
	"Try round-trip"
	#('' 'A' 'AB' 'ABC' 'ABCD' 'ABCDE' 'ABCDEF') do: 
			[:each | 
			| bytes |
			bytes := self byteArrayForSequence: each.
			(self collectionClass fromAddress: bytes yourAddress length: each size) 
				= (self newCopy: each)]!

testAt
	self assert: ((self newCollection: 'Hello') at: 1) equals: $H!

testCapitalized
	| string cap |
	string := self assimilateString: ''.
	self assert: (string capitalized equals: string).
	string := self newCollection: 'a'.
	cap := string capitalized.
	self assert: (cap equals: (self newCollection: 'A')).
	self assert: string equals: (self newCollection: 'a').
	string := self newCollection: 'A'.
	cap := string capitalized.
	self assert: (cap equals: (self newCollection: 'A')).
	self assert: string equals: (self newCollection: 'A').
	string := self newCollection: 'ab'.
	cap := string capitalized.
	self assert: (cap equals: (self newCollection: 'Ab')).
	self assert: string equals: (self newCollection: 'ab').
	string := self newCollection: 'Ab'.
	cap := string capitalized.
	self assert: (cap equals: (self newCollection: 'Ab')).
	self assert: string equals: (self newCollection: 'Ab')!

testCaseConversions
	| subject actual expected |
	self caseConversionCases do: 
			[:each |
			subject := self assimilateString: each first.
			actual := subject asUppercase.
			expected := (self assimilateString: each last).
			self assert: actual equals: expected mutableCopy.
			actual := expected asLowercase.
			self assert: actual equals: subject mutableCopy]!

testClassReadFrom
	"Tests String class>>readFrom:. Some interested cases are:
	- Content before the first quote (skipped - not sure that is right, but has always done that)
	- Unterminated (reads up to end)
	- Embedded (doubled) quotes - quotes are undoubled
	- Trailing content - should be left with the stream positioned after the final quote."

	{#('' '' '').
		#('abc' '' '').
		#('abc''A''B' 'A' 'B').
		#('a''AB''CD' 'AB' 'CD').
		#('''a''' 'a' '').
		#('''a' 'a' '').
		#('''abc''' 'abc' '').
		#('''abc' 'abc' '').
		#('''abc''''d'' ''e''' 'abc''d' ' ''e''')} do: 
				[:each |
				| actual expected stream remainder |
				expected := self assimilateString: each second.
				stream := each first readStream.
				actual := self collectionClass readFrom: stream.
				self assert: actual class identicalTo: self collectionClass.
				self assert: actual equals: expected.
				remainder := stream upToEnd.
				self assert: remainder equals: each last]!

testEmpty
	self assert: self collectionClass empty class identicalTo: self collectionClass!

testEquals
	| abc |
	self equalityTestCases do: 
			[:each |
			| subject |
			subject := self assimilateString: each.
			"Identical must be equal"
			self assert: subject equals: subject.
			"Same characters must be equal"
			self assert: subject equals: subject copy.
			each isEmpty ifFalse: [self deny: subject equals: subject asUppercase].
			self assert: subject equals: subject asUtf8String.
			self assert: subject equals: subject asUtf16String.
			"Not equal to ByteArrays"
			self deny: subject asByteArray equals: subject.
			self deny: subject equals: subject asByteArray.
			"Nor Arrays of characters"
			self deny: subject asArray equals: subject.
			self deny: subject equals: subject asArray].
	"Symbols are only ever equal to other symbols, not strings with the same characters"
	abc := self assimilateString: 'abc'.
	self deny: #abc equals: abc.
	self deny: abc equals: #abc.
!

testFindStringStartingAt
	| searchee abc a empty ba ab bb bba abba |
	searchee := self newCollection: 'abcdefgabcdef'.
	abc := self newCollection: 'abc'.
	self assert: (searchee findString: abc startingAt: 1) equals: 1.
	self assert: (searchee findString: abc startingAt: 2) equals: 8.
	self assert: (searchee findString: abc startingAt: 9) equals: 0.
	self assert: (searchee findString: abc startingAt: 11) equals: 0.
	self assert: (searchee findString: abc startingAt: 1) equals: 1.
	self assert: (searchee findString: abc startingAt: 9) equals: 0.
	searchee := self newCollection: 'aabcabc'.
	self assert: (searchee findString: abc startingAt: 6) equals: 0.
	a := self newCollection: 'a'.
	empty := self newCollection: ''.
	self assert: (empty findString: a startingAt: 1) equals: 0.
	self assert: ('b' findString: a startingAt: 1) equals: 0.
	self assert: (a findString: a startingAt: 1) equals: 1.

	"Search for empty string, should return zero"
	self assert: (a findString: empty startingAt: 1) equals: 0.
	ba := self newCollection: 'ba'.
	self assert: (ba findString: a startingAt: 1) equals: 2.
	ab := self newCollection: 'ab'.
	self assert: (ab findString: a startingAt: 1) equals: 1.
	bb := self newCollection: 'bb'.
	self assert: (bb findString: a startingAt: 1) equals: 0.
	bba := self newCollection: 'bba'.
	self assert: (bba findString: a startingAt: 1) equals: 3.
	self assert: (bba findString: a startingAt: 2) equals: 3.
	self assert: (bba findString: a startingAt: 3) equals: 3.
	abba := self newCollection: 'abba'.
	self assert: (abba findString: ab startingAt: 3) equals: 0.
	self assert: (abba findString: ab startingAt: 4) equals: 0.
	self assert: (abba findString: ab startingAt: 2) equals: 0.
	self assert: (abba findString: ab startingAt: 1) equals: 1.
	searchee := self
				newCollection: 'Now''s the time for all good men to come to the aid of their country.'.
	self assert: (searchee findString: (self newCollection: 'time') startingAt: 1) equals: 11.
	self assert: (searchee findString: (self newCollection: 'timid') startingAt: 1) equals: 0.
	self assert: (searchee findString: (self newCollection: 'try') startingAt: 1) equals: 65.
	searchee := self newCollection: 'babcbabcabcaabcabcabcacabc'.
	self assert: (searchee findString: 'abcabcacab' startingAt: 1) equals: 16.
	searchee := self newCollection: 'aaaaaaabcabcadefg'.
	self assert: (searchee findString: (self newCollection: 'abcad') startingAt: 1) equals: 10.
	self assert: (searchee findString: ab startingAt: 1) equals: 7!

testFindStringStartingAtIgnoreCase
	| searchee abc a empty ba ab bb bba abba |
	searchee := self newCollection: 'abCdefgAbcdef'.
	(searchee respondsTo: #findString:startingAt:ignoreCase:)
		ifFalse: 
			["Introduced in D6"
			^self].
	abc := self newCollection: 'aBc'.
	self assert: (searchee
				findString: abc
				startingAt: 1
				ignoreCase: true)
		equals: 1.
	self assert: (searchee
				findString: abc
				startingAt: 1
				ignoreCase: false)
		equals: 0.
	self assert: (searchee
				findString: abc
				startingAt: 2
				ignoreCase: true)
		equals: 8.
	self assert: (searchee
				findString: abc
				startingAt: 9
				ignoreCase: true)
		equals: 0.
	self assert: (searchee
				findString: abc
				startingAt: 11
				ignoreCase: true)
		equals: 0.
	self assert: (searchee
				findString: abc
				startingAt: 1
				ignoreCase: true)
		equals: 1.
	self assert: (searchee
				findString: abc
				startingAt: 9
				ignoreCase: true)
		equals: 0.
	searchee := self newCollection: 'aAbcaBC'.
	self assert: (searchee
				findString: abc
				startingAt: 6
				ignoreCase: true)
		equals: 0.
	a := self newCollection: 'a'.
	empty := self newCollection: ''.
	self assert: (empty
				findString: a
				startingAt: 1
				ignoreCase: true)
		equals: 0.
	self assert: ('b'
				findString: a
				startingAt: 1
				ignoreCase: true)
		equals: 0.
	self assert: (a
				findString: a asUppercase
				startingAt: 1
				ignoreCase: true)
		equals: 1.

	"Search for empty string, should return zero"
	self assert: (a findString: empty startingAt: 1) equals: 0.
	ba := self newCollection: 'BA'.
	self assert: (ba
				findString: a
				startingAt: 1
				ignoreCase: true)
		equals: 2.
	ab := self newCollection: 'AB'.
	self assert: (ab
				findString: a
				startingAt: 1
				ignoreCase: true)
		equals: 1.
	bb := self newCollection: 'BB'.
	self assert: (bb
				findString: a
				startingAt: 1
				ignoreCase: true)
		equals: 0.
	bba := self newCollection: 'BBA'.
	self assert: (bba
				findString: a
				startingAt: 1
				ignoreCase: true)
		equals: 3.
	self assert: (bba
				findString: a
				startingAt: 2
				ignoreCase: true)
		equals: 3.
	self assert: (bba
				findString: a
				startingAt: 3
				ignoreCase: true)
		equals: 3.
	abba := self newCollection: 'ABBA'.
	self assert: (abba
				findString: ab
				startingAt: 3
				ignoreCase: true)
		equals: 0.
	self assert: (abba
				findString: ab
				startingAt: 4
				ignoreCase: true)
		equals: 0.
	self assert: (abba
				findString: ab
				startingAt: 2
				ignoreCase: true)
		equals: 0.
	self assert: (abba
				findString: ab
				startingAt: 1
				ignoreCase: true)
		equals: 1.
	searchee := self
				newCollection: 'Now''s the time for all good men to come to the aid of their country.'.
	self assert: (searchee
				findString: (self newCollection: 'TIME')
				startingAt: 1
				ignoreCase: true)
		equals: 11.
	self assert: (searchee
				findString: (self newCollection: 'timiD')
				startingAt: 1
				ignoreCase: true)
		equals: 0.
	self assert: (searchee
				findString: (self newCollection: 'tRy')
				startingAt: 1
				ignoreCase: true)
		equals: 65.
	searchee := self newCollection: 'babcbabcabcaabcabcabcacabc'.
	self assert: (searchee
				findString: 'abcABCacab'
				startingAt: 1
				ignoreCase: true)
		equals: 16.
	searchee := self newCollection: 'AaAaAaAbCaBcAdEfG'.
	self assert: (searchee
				findString: (self newCollection: 'abcad')
				startingAt: 1
				ignoreCase: true)
		equals: 10.
	self assert: (searchee
				findString: ab
				startingAt: 1
				ignoreCase: true)
		equals: 7!

testInvalidComparisons
	| str literals |
	str := self newCollection: 'blah'.
	literals := #(1.0 1 16rFFFFFFFF 1s2 $a #()).
	literals do: [:each | self deny: str equals: each].
	literals do: [:each | self deny: str equals: each].
	literals do: [:each | self should: [str < each] raise: Error].
	literals do: [:each | self should: [str <= each] raise: Error].
	literals do: [:each | self should: [str > each] raise: Error].
	literals do: [:each | self should: [str >= each] raise: Error].
	literals do: [:each | self should: [each < str] raise: Error].
	literals do: [:each | self should: [each <= str] raise: Error].
	literals do: [:each | self should: [each > str] raise: Error].
	literals do: [:each | self should: [each >= str] raise: Error]!

testMutableCopy
	self caseConversionCases do: 
			[:each |
			| subject actual |
			subject := self assimilateString: each first.
			actual := subject mutableCopy.
			self deny: actual identicalTo: subject.
			self assert: actual isKindOf: subject species.
			self assert: (actual _cmp: subject) equals: 0]!

testReverse
	"Tests reversing a variety of 1, 2, 3 and 4 byte encodings"

	self reverseTestCases do: 
			[:each |
			| subject expected actual |
			subject := self assimilateString: each first.
			expected := self assimilateString: each last.
			actual := subject reverse.
			self assert: actual equals: expected mutableCopy.
			"Reverse it back"
			actual := actual reverse.
			self assert: actual equals: subject mutableCopy]!

testStreamUtfRoundTrip
	| expected actual |
	self collectionClass == Symbol ifTrue: [^self].
	"Test a variety of 1 to 4 byte encodings"
	{''.
		'a'.
		'abc'.
		'£'.
		'être'.
		Utf8String fromByteArray: #[228 185 157 233 190 141 231 129 163].
		Utf8String
			fromByteArray: #[230 150 135 229 173 151 229 140 150 227 129 145 227 131 134 227 130 185 227 131 136].
		Utf8String
			fromByteArray: #[216 167 217 132 216 165 216 185 217 132 216 167 217 134 32 216 167 217 132 216 185 216 167 217 132 217 133 217 137 32 217 132 216 173 217 130 217 136 217 130 32 216 167 217 132 216 165 217 134 216 179 216 167 217 134].
		Utf8String fromByteArray: #[240 144 140 176 240 144 140 177 240 144 140 178]} do: 
				[:each |
				expected := self assimilateString: each.
				actual := expected species writeStream
							nextPutAll: expected;
							contents.
				self assert: (self assimilateString: actual) equals: expected]!

testSubStrings
	"Test single character delimiter"

	self assert: ((self newCollection: '') subStrings: $-)
		equals: (#() collect: [:e | self newCollection: e]).
	self assert: ((self newCollection: 'a') subStrings: $-)
		equals: (#('a') collect: [:e | self newCollection: e]).
	self assert: ((self newCollection: '-a') subStrings: $-)
		equals: (#('' 'a') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'a-') subStrings: $-)
		equals: (#('a') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: '--a') subStrings: $-)
		equals: (#('' '' 'a') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'a--') subStrings: $-)
		equals: (#('a' '') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'ab') subStrings: $-)
		equals: (#('ab') collect: [:e | self newCollection: e]).
	self assert: ((self newCollection: '-ab') subStrings: $-)
		equals: (#('' 'ab') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'ab-') subStrings: $-)
		equals: (#('ab') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'ab---') subStrings: $-)
		equals: (#('ab' '' '') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: '--ab') subStrings: $-)
		equals: (#('' '' 'ab') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'a-b') subStrings: $-)
		equals: (#('a' 'b') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'a--b') subStrings: $-)
		equals: (#('a' '' 'b') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'ab-c-') subStrings: $-)
		equals: (#('ab' 'c') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'a-b--c') subStrings: $-)
		equals: (#('a' 'b' '' 'c') collect: [:e | self newCopy: e]).

	"And again but using a string argument of only one character"
	self assert: ((self newCollection: '') subStrings: (self newCollection: '-'))
		equals: (#() collect: [:e | self newCollection: e]).
	self assert: ((self newCollection: 'a') subStrings: (self newCollection: '-'))
		equals: (#('a') collect: [:e | self newCollection: e]).
	self assert: ((self newCollection: '-a') subStrings: (self newCollection: '-'))
		equals: (#('' 'a') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'a-') subStrings: (self newCollection: '-'))
		equals: (#('a') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: '--a') subStrings: (self newCollection: '-'))
		equals: (#('' '' 'a') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'a--') subStrings: (self newCollection: '-'))
		equals: (#('a' '') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'ab') subStrings: (self newCollection: '-'))
		equals: (#('ab') collect: [:e | self newCollection: e]).
	self assert: ((self newCollection: '-ab') subStrings: (self newCollection: '-'))
		equals: (#('' 'ab') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'ab-') subStrings: (self newCollection: '-'))
		equals: (#('ab') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'ab---') subStrings: (self newCollection: '-'))
		equals: (#('ab' '' '') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: '--ab') subStrings: (self newCollection: '-'))
		equals: (#('' '' 'ab') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'a-b') subStrings: (self newCollection: '-'))
		equals: (#('a' 'b') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'a--b') subStrings: (self newCollection: '-'))
		equals: (#('a' '' 'b') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'ab-c-') subStrings: (self newCollection: '-'))
		equals: (#('ab' 'c') collect: [:e | self newCopy: e]).
	self assert: ((self newCollection: 'a-b--c') subStrings: (self newCollection: '-'))
		equals: (#('a' 'b' '' 'c') collect: [:e | self newCopy: e]).

	"The separator an also be a string, but must not be empty"
	self should: [(self newCollection: 'abc') subStrings: (self newCollection: '')] raise: Error.
	#todo	"Test multi-character separators"!

testTrimNulls
	"#1187"

	| string trimmed |
	string := self newCollection: #($a $\0 $\0).
	trimmed := string trimNulls.
	self assert: trimmed size equals: 1.
	self assert: (self newCollection: trimmed) equals: (self newCollection: 'a')!

testUnescapePercents
	"Test URI decoding per RFC3986"

	| unreserved misencoded |
	#(#('' '') #('+' ' ') #('A' 'A') #('+A' ' A') #('++A' '  A') #('A+' 'A ') #('A++' 'A  ') #('AB' 'AB') #('+A+B+' ' A B ') #('++A++B++' '  A  B  ') #('%41' 'A') #('+%41+' ' A ') #('%41B' 'AB') #('%41+B' 'A B') #('%41++B' 'A  B') #('%41BC' 'ABC') #('%41%42' 'AB') #('%41B%43' 'ABC') #('%41BC%44' 'ABCD') #('A%42%43' 'ABC') #('AB%43%44' 'ABCD') #('AB%43D%45' 'ABCDE') #('AB%43DE%46' 'ABCDEF') #('AB%43DE%46G' 'ABCDEFG') #('AB%43DE%46GH' 'ABCDEFGH') #('~25%25' '~25%'))
		do: 
			[:each |
			| subject actual |
			subject := self collectionClass fromString: each first.
			actual := subject unescapePercents.
			self assert: actual equals: each last].
	"Test case from @fxgallego"
	self assert: (self collectionClass fromString: 'Ca%C3%B1%C3%B3n') unescapePercents equals: 'Cañón'.
	"Non-latin 3-byte encoding test case from RFC3986"
	self assert: (self collectionClass fromString: '%E3%82%A2') unescapePercents
		equals: $\x30A2 asUtf8String.
	"And a 4-byte encoding for fun"
	self assert: (self collectionClass fromString: '%F0%9F%90%AC') unescapePercents equals: '🐬'.

	"All reserved characters in RFC3986, exception '+', should be unaffected by decoding"
	self assert: (self collectionClass fromString: ':/?#[]@!!$&''()*+,;=') unescapePercents
		equals: ':/?#[]@!!$&''()* ,;='.

	"Unreserved characters, also untouched"
	unreserved := (Character byteCharacterSet select: [:each | each isEnglishLetter or: [each isDigit]])
				, '-._~'.
	self assert: (self collectionClass fromString: unreserved) unescapePercents equals: unreserved.
	"But should be coded if found encoded"
	misencoded := String writeStream.
	unreserved do: 
			[:each |
			misencoded nextPut: $%.
			each asciiValue
				printOn: misencoded
				base: 16
				showRadix: false].
	misencoded := misencoded contents.
	self assert: (self collectionClass fromString: misencoded) unescapePercents equals: unreserved.

	"Invalid cases, therefore assume not an escaped string"
	#('%GA' '%AG' '%[1' '%1[' '+%A' '%1' '100%' '%+') do: 
			[:each |
			| subject actual |
			subject := self collectionClass fromString: each.
			actual := subject unescapePercents.
			self assert: actual equals: (self newCopy: subject)].

	"Special cases of non-ASCII input - these should be detected and not decoded"
	#('€5+&+change' '£5+') do: 
			[:each |
			| subject actual |
			subject := self collectionClass fromString: each.
			actual := subject unescapePercents.
			self assert: actual equals: each].
	self collectionClass == AnsiString
		ifFalse: 
			[| subject |
			subject := self collectionClass fromString: '%97+🐬'.
			self assert: subject unescapePercents equals: subject]!

testWithNormalizedLineDelimiters
	"Empty"

	| cr lf crlf char |
	char := self newCollection: '+'.
	cr := self newCollection: (self collectionClass with: Character cr).
	crlf := self newCollection: self collectionClass lineDelimiter.
	lf := self newCollection: (self collectionClass with: Character lf).
	self assert: (self newCollection: '') withNormalizedLineDelimiters equals: (self newCopy: '').
	"Not empty, but no delims"
	self assert: (self newCollection: '') withNormalizedLineDelimiters equals: (self newCopy: '').
	"Single CR"
	self assert: cr withNormalizedLineDelimiters equals: (self newCopy: crlf).
	self assert: (char , cr) withNormalizedLineDelimiters equals: char , crlf.
	self assert: (char , cr , char) withNormalizedLineDelimiters equals: char , crlf , char.
	"Single LF"
	self assert: lf withNormalizedLineDelimiters equals: (self newCopy: crlf).
	self assert: (char , lf) withNormalizedLineDelimiters equals: char , crlf.
	self assert: (char , lf , char) withNormalizedLineDelimiters equals: char , crlf , char.
	"Single CR/LF - no change"
	self assert: crlf withNormalizedLineDelimiters equals: (self newCopy: crlf).
	self assert: (char , crlf) withNormalizedLineDelimiters equals: char , crlf.
	self assert: (char , crlf , char) withNormalizedLineDelimiters equals: char , crlf , char.
	"LF,CR"
	self assert: (lf , cr) withNormalizedLineDelimiters equals: crlf , crlf.
	self assert: (lf , cr , char) withNormalizedLineDelimiters equals: crlf , crlf , char.
	self assert: (char , lf , cr , char) withNormalizedLineDelimiters equals: char , crlf , crlf , char.
	"LF,LF"
	self assert: (lf , lf) withNormalizedLineDelimiters equals: crlf , crlf.
	self assert: (lf , lf , char) withNormalizedLineDelimiters equals: crlf , crlf , char.
	self assert: (char , lf , lf , char) withNormalizedLineDelimiters equals: char , crlf , crlf , char.
	"CR,CR"
	self assert: (cr , cr) withNormalizedLineDelimiters equals: crlf , crlf.
	self assert: (cr , cr , char) withNormalizedLineDelimiters equals: crlf , crlf , char.
	self assert: (char , cr , cr , char) withNormalizedLineDelimiters equals: char , crlf , crlf , char.
	"CRLFLF"
	self assert: (cr , lf , lf) withNormalizedLineDelimiters equals: crlf , crlf.
	"CRLFCR"
	self assert: (cr , lf , cr) withNormalizedLineDelimiters equals: crlf , crlf!

verifyConcatenationResult: resultString of: receiverString with: argumentString
	"When concatenating strings the result should be of the same type as the receiver, unless a
	UTF string is being concatenated with an AnsiString, in which case the result will be of the
	same type as the argument."

	| expected |
	expected := Utf8String writeStream
				nextPutAll: receiverString;
				nextPutAll: argumentString;
				contents.
	self assert: resultString equals: expected! !
!AbstractStringTest categoriesFor: #assimilate:!helpers!private! !
!AbstractStringTest categoriesFor: #assimilateString:!helpers!private! !
!AbstractStringTest categoriesFor: #caseConversionCases!constants!private! !
!AbstractStringTest categoriesFor: #equalityTestCases!constants!private! !
!AbstractStringTest categoriesFor: #newNumericArray:!helpers!private! !
!AbstractStringTest categoriesFor: #reverseTestCases!constants!private! !
!AbstractStringTest categoriesFor: #testAsByteArray!public!unit tests! !
!AbstractStringTest categoriesFor: #testAt!public!unit tests! !
!AbstractStringTest categoriesFor: #testCapitalized!public!unit tests! !
!AbstractStringTest categoriesFor: #testCaseConversions!public! !
!AbstractStringTest categoriesFor: #testClassReadFrom!public! !
!AbstractStringTest categoriesFor: #testEmpty!public!testing / accessing! !
!AbstractStringTest categoriesFor: #testEquals!public!unit tests! !
!AbstractStringTest categoriesFor: #testFindStringStartingAt!public!unit tests! !
!AbstractStringTest categoriesFor: #testFindStringStartingAtIgnoreCase!public!unit tests! !
!AbstractStringTest categoriesFor: #testInvalidComparisons!public!unit tests! !
!AbstractStringTest categoriesFor: #testMutableCopy!public! !
!AbstractStringTest categoriesFor: #testReverse!public! !
!AbstractStringTest categoriesFor: #testStreamUtfRoundTrip!public! !
!AbstractStringTest categoriesFor: #testSubStrings!public!unit tests! !
!AbstractStringTest categoriesFor: #testTrimNulls!public!unit tests! !
!AbstractStringTest categoriesFor: #testUnescapePercents!public!unit tests! !
!AbstractStringTest categoriesFor: #testWithNormalizedLineDelimiters!public!unit tests! !
!AbstractStringTest categoriesFor: #verifyConcatenationResult:of:with:!helpers!private! !

