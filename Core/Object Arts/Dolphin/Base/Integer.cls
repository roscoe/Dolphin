﻿"Filed out from Dolphin Smalltalk 7"!

Number subclass: #Integer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
Integer guid: (GUID fromString: '{87b4c65c-026e-11d3-9fd7-00a0cc3e4a32}')!
Integer isAbstract: true!
Integer comment: ''!
!Integer categoriesForClass!Magnitude-Numbers! !
!Integer methodsFor!

- operand
	"Answer a <number> which is the difference between the receiver and the argument, operand."

	^operand subtractFromInteger: self!

& anInteger
	"Answer the result of a bitwise AND between the receiver and the argument, anInteger.
	N.B. Use of #bitAnd: is preferred (even though it is more typing) because it is
	a special selector (i.e. it is more compact and faster), and is portable."

	^self bitAnd: anInteger!

* aNumber
	"Answer the result of multiplying the receiver by aNumber."

	^aNumber multiplyByInteger: self!

/ operand
	"Answer the <number> which is the result of dividing the receiver by <number>, operand. 
	If their is any remainder, then the result will be a <Fraction>. Raise a <ZeroDivide> 
	exception if the operand is zero."

	^operand divideIntoInteger: self!

// aNumber
	"Answer the quotient resulting from dividing the receiver by aNumber with 
	truncation towards negative infinity."

	| quo |
	self isZero ifTrue: [^self].
	quo := self quo: aNumber.
	(quo negative	
		ifTrue: [quo * aNumber ~= self]
		ifFalse: [quo isZero and: [self negative ~= aNumber negative]])
				ifTrue: [^quo - 1]
				ifFalse: [^quo].
!

| anInteger
	"Answer the result of a bitwise OR between the receiver and the argument, 
	anInteger.
	N.B. Use of #bitOr: is preferred (even though it is more typing) because it is
	a special selector (i.e. it is more compact and faster), and is portable."

	^self bitOr: anInteger!

+ aNumber
	"Answer a Number which is the sum of the receiver and aNumber."

	^aNumber addToInteger: self!

< aNumber
	"Answer whether the receiver is less than the argument, aNumber."

	^aNumber greaterThanInteger: self!

<< anInteger
	"Answer the result of shifting the receiver left anInteger bits.
	N.B. Use of #bitShift: is preferred (even though it is more typing) because it is
	a special selector (i.e. it is more compact and faster), and is portable."

	^self bitShift: anInteger!

>> anInteger
	"Answer the result of shifting the receiver right anInteger bits.
	N.B. Use of #bitShift: (with a negative argument) is preferred (even 
	though it is more typing) because it is a special selector (i.e. it is 
	more compact and faster), and is portable."

	^self bitShift: anInteger negated!

addToFloat: aFloat
	"Private - Add the receiver from the known Float, aFloat."

	^aFloat + self asFloat!

addToFraction: aFraction
	"Private - Add the receiver to the known Fraction, aFraction.
	There is no need to normalise the result."

	^Fraction
		numerator: self * aFraction denominator + aFraction numerator
		denominator: aFraction denominator!

allMask: mask
	"Answer whether all of the bits that are set in the <integer> mask are also set in 
	the receiver."

	^(self bitAnd: mask) = mask!

anyBitSetFrom: startInteger to: stopInteger
	"Answer whether any bits are set in the specified range in the receiver's 2's complement
	representation. This is probably not a useful enquiry for negative integer, since these have
	an infinite stream of leading bits."

	"Implementation Note: This is just about the simplest implementation, but relies on a fast
	bitShift:. In normal circumanstances, for reasonable ranges, this should be fine."

	| mask |
	mask := (1 bitShift: stopInteger - startInteger + 1) - 1 bitShift: startInteger - 1.
	^(mask bitAnd: self) ~~ 0!

anyMask: mask
	"Answer whether any of the bits that are set in the <integer> mask are also set 
	in the receiver."

	^(self bitAnd: mask) ~= 0!

asBoolean
	"Answer whether the receiver is non-zero."

	^self ~= 0
!

asCharacter
	"Answer the character whose Unicode code is the receiver."

	^Character value: self
!

asDword
	"Answer the receiver as an unsigned double word value. Assumes the receiver is 
	a 32 bit integer.
	Implementation Note: LargeInteger constant receiver 
	to avoid always failing the SmallInteger bitAnd: primitive."

	^16rFFFFFFFF bitAnd: self!

asExternalAddress
	"Answer the receiver as an ExternalAddress."

	^VMLibrary default addressFromInteger: self!

asExternalHandle
	"Answer the receiver as an ExternalHandle.
	Implementation Note: Use the external call primitive coercion trick for speed."

	^VMLibrary default handleFromInteger: self!

asFraction
	"Answer the normalized fractional representation of the receiver, in this
	case an exact representation."

	^self!

asInteger
	"Answer the integer value of the receiver."

	^self
!

asResourceId
	^self
!

asScaledDecimal: anInteger 
	"Answer a <ScaledDecimal> number, with the fractional precision 
	of 0 (i.e. the argument is effectively ignored). See ANSI 5.6.5.3 p127."

	^ScaledDecimal newFromNumber: self scale: 0!

asSDword
	"Answer the receiver as an signed double word value. Assumes the receiver is 
	a 32 bit integer.
	Implementation Note: Get the external library primitive to perform the coercion
	for us."

	^VMLibrary default signedFromUnsigned: self!

asStackPointer
	"Private - Answer a <SmallInteger> value which can be stored into a stack slot and which will be
	correctly interpreted by the VM when processing stack frames as a pointer to the value at
	the address represented by the receiver."

	^(16r40000000 + self bitAnd: 16r7FFFFFFF) + -16r40000000!

asUIntPtr
	"Answer the receiver as an unsigned double word value. Assumes the receiver is 
	a 32 bit integer.
	Implementation Note: LargeInteger constant receiver 
	to avoid always failing the SmallInteger bitAnd: primitive."

	^VMConstants.IntPtrMask bitAnd: self!

at: anInteger 
	"Integer's do not support indexed instance variables."

	^self shouldNotImplement!

basicPrintDigitsOn: aStream base: anInteger 
	"Private - Print the digits of the receiver in base anInteger to aStream. N.B. The receiver
	MUST be positive for this to work correctly."

	| quotient digits index |
	quotient := self.
	index := self digitLength * 8.
	digits := Utf8String new: index.
	[quotient < anInteger] whileFalse: 
			[| quoRem |
			quoRem := quotient quoAndRem: anInteger.
			digits at: index put: ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' at: (quoRem at: 2) + 1).
			index := index - 1.
			quotient := quoRem at: 1].
	digits at: index put: ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' at: quotient + 1).
	aStream 
		next: digits size - index + 1
		putAll: digits
		startingAt: index!

bitAnd: operand
	"Answer an <integer> whose bits are the logical AND of the
	receiver's bits and those of the <integer> argument, operand."

	^self subclassResponsibility!

bitAt: index
	"Answer the <integer> 0 or 1 which is the binary value of the bit at 
	the <integer> position, index, in the receiver's 2's complement binary representation."

	^(self bitAnd: (1 bitShift: index - 1)) == 0
		ifTrue: [0]
		ifFalse: [1]!

bitAt: index put: value
	"Set the binary value of the bit at the <integer> position, index, in the 
	receiver's 2's complement binary representation to the low-order bit
	of the <integer> argument, value.
	Note: Integers are immutable, so there is no effect on the receiver and the
	answer is a new integer."

	^(self bitAnd: (1 bitShift: index-1) bitInvert)
		bitOr: ((value bitAnd: 1) bitShift: index - 1)!

bitInvert
	"Answer an integer whose bits are the complement of the receiver."

	^-1 - self!

bitOr: operand
	"Answer an integer whose bits are the logical OR of the
	receiver's bits and those of the <integer> argument, operand."

	^self subclassResponsibility!

bitShift: shift
	"Answer an <integer> which is the receiver shifted left by the
	<integer>, shift, number of bit positions if the operand is positive, 	
	or shifted right for shift negated number of bit positions if the operand
	is negative."

	shift isInteger
		ifFalse: [self error: 'non-integer argument'].
	shift >= 0
		ifTrue: [^self * (2 raisedToInteger: shift)].
	^self // (2 raisedToInteger: shift negated)!

bitXor: operand
	"Answer an <integer> whose bits are the logical XOR of the
	receiver's bits and those of the <integer> argument, operand"

	^self subclassResponsibility!

byteAt: anInteger 
	"Private - Answer the byte at index, index, of the absolute value of the
	receiver (i.e. magnitude  only representation)."

	^anInteger > 0 
		ifTrue: [(self abs bitShift: (1 - anInteger) * 8) bitAnd: 16rFF]
		ifFalse: [self errorSubscriptBounds: anInteger]!

byteSize
	"Private - Answer the number of bytes in the receiver's 2's complement
	representation."

	^self subclassResponsibility!

ceiling
	"Answer the integer nearest the receiver toward positive infinity."

	^self
!

clearBit: index
	"Answer the Integer which results from clearing the index'th bit of the receiver,
	where the least significant bit is considered to have index 1."

	^self maskClear: (1 bitShift: index-1)!

coerce: anArithmeticValue
	"Private - Answer the Integer representation of anArithmeticValue."

	^anArithmeticValue asInteger!

digitAt: anInteger 
	"Answer the index'th byte of 2's complement representation of the receiver. e.g. 1 at: 1 =
	1, -1 at: 1 = 255 (see also #byteAt:). Report an error if index is not greater than 0, but
	answer 0/255 if index is greater than the size of the receiver as this is a sensible action
	for Integers."

	^anInteger > 0 
		ifTrue: [(self bitShift: (1 - anInteger) * 8) bitAnd: 16rFF]
		ifFalse: [self errorSubscriptBounds: anInteger]!

digitLength
	"Answer the number of significant radix-256 digits in the receiver."

	^((self abs bitOr: 1) highBit - 1 bitShift: -3) + 1!

displayString
	"Answer a String whose characters are a representation of the receiver as a user
	would want to see it.
	Implementation Note: For Integers this is the same as the #printString, and for
	many cases that has an optimized implementation of which we wish to take
	advantage."

	^self printString!

divideIntoFloat: aFloat
	"Private - Divide the receiver into the known Float, aFloat. Answer the result."

	^aFloat / self asFloat!

divideIntoFraction: aFraction
	"Private - Answer the result of dividing the receiver into the argument, with
	truncation towards negative infinity. In general Integer division is more
	likely to be inexact, so assume a Fraction will be needed. The Fraction class
	instance creation method will answer an Integer if it can."

	^Fraction
		rationalisedNumerator: aFraction numerator
		denominator: self * aFraction denominator!

divideIntoInteger: anInteger 
	"Private - Answer the result of dividing the receiver into the argument, with
	truncation towards negative infinity. In general Integer division is more
	likely to be inexact, so assume a Fraction will be needed. The Fraction class
	instance creation method will answer an Integer if it can."

	^Fraction rationalisedNumerator: anInteger denominator: self!

even
	"Answer whether the receiver is an even integer. Zero is considered even.
	Override superclass as we've a more efficient implementation."

	^(self bitAnd: 1) == 0!

exp10
	"Answer an <integer> which is base-10 exponent of the receiver (i.e. 10 raised to the power
	of the receiver)."

	"There is a small benefit in exploiting the fact that 10^N = 5^N * 2^N, at least when N is
	large. This is really only worthwhile because the LargeInteger multiplication primitive is
	not as efficient as it could be and so there is a small benefit in multiplying smaller
	numbers and then performing one bitshift to add the trailing zeroes."

	^self < 20 ifTrue: [10 raisedToInteger: self] ifFalse: [(5 raisedToInteger: self) bitShift: self]!

factorial
	"Answer the <integer> factorial of the receiver. It is an error for the receiver to be
	negative."

	^self factorial2p!

factorial2p
	"Private - 2-partition fast factorial algorithm from 'Fast Computation of Factorials of Numbers',
	Thompson & Ugur."

	| x0 x1 x2 |
	self < 2 ifTrue: [^self < 0 ifTrue: [self error: 'negative factorial'] ifFalse: [1]].
	x0 := 2.
	x1 := 10.
	x2 := x0.
	self // 2 - 1 timesRepeat: 
			[x0 := x0 + x1.
			x1 := x1 + 8.
			x2 := x2 * x0].
	self odd ifTrue: [x2 := x2 * self].
	^x2!

factorialIterative
	"Private - Answer the factorial of the receiver. The receiver must be not less than 0."

	| factorial |
	self < 0
		ifTrue: [^self error: 'negative factorial' ].
 	factorial := 1.
	2 to: self asInteger do: [ :i | factorial := i * factorial ].
	^factorial!

floor
	"Answer the integer nearest the receiver (i.e. the receiver)."

	^self!

fractionPart
	"Answer a <number> of the same type as the receiver, representing the 
	fractional part of  the receiver."

	^0!

gcd: operand 
	"Answer the greatest common divisor of the receiver and the <integer>, operand, computed 
	using Euclid's algorithm. See Knuth vol. II"

	| u v |
	v := operand abs.
	u := self abs.
	[v == 0] whileFalse: 
			[| r |
			r := u \\ v.
			u := v.
			v := r].
	^u!

gcdbin: operand 
	"Answer the greatest common divisor of the receiver and the <integer>, operand, computed 
	using Stein's binary algorithm. See Knuth vol. II"

	| k u v t |
	u := self abs.
	v := operand abs.
	k := 0.
	[u even and: [v even]] whileTrue: 
			[k := k + 1.
			u := u bitShift: -1.
			v := v bitShift: -1].
	t := u even ifTrue: [u bitShift: -1] ifFalse: [v negated].
	
	[[t even] whileTrue: [t := t bitShift: -1].
	t > 0 ifTrue: [u := t] ifFalse: [v := t negated].
	t := u - v.
	t == 0] 
			whileFalse.
	^u bitShift: k!

greaterThanFloat: aFloat
	"Private - Answer whether the receiver is greater than the known Float, aFloat."

	^aFloat < self asFloat!

greaterThanFraction: aFraction
	"Private - Answer whether the receiver is greater than the known Fraction, aFraction"

	^aFraction numerator < (self * aFraction denominator)!

hash
	"Answer the <integer> hash value of the receiver."

	"Implementation Note: In order to satisfy the invariant that Floats that compare
	equal also have the same hash, we have to limit the precision of the hash by using 
	only the top hashBits bits of the absolute value of the receiver, xor'ing in the shift
	as a way of taking some account of the magnitude of the receiver.
	Thanks to John Brant for contributing this hash function."

	| bitCount shiftDistance |
	self negative ifTrue: [^self negated hash negated].
	bitCount := self highBit.
	^bitCount > self hashBits 
		ifTrue: 
			[| value |
			shiftDistance := self hashBits - bitCount + 1.
			value := (self bitShift: shiftDistance) + 1 bitShift: -1.
			value highBit > self hashBits 
				ifTrue: [(value bitShift: -1) bitXor: (shiftDistance - 1) abs]
				ifFalse: [value bitXor: shiftDistance abs]]
		ifFalse: [self]!

hex
	"Answer a <readableString> whose characters are a description of 
	the receiver in the hexadecimal."

	^self printStringRadix: 16 showRadix: true!

highBit
	"Answer the <integer> index of the most significant non-zero bit of the binary 
	representation of the receiver.
	N.B. This operation is not defined for negative integers."

	| digits |
	digits := self digitLength.
	^(self byteAt: digits) highBit + (digits - 1 bitShift: 3)!

highByte
	"Private - Answer the most significant radix-256 digit of the receiver."

	^self byteAt: self digitLength!

highPartSigned
	"Answers the high order signed word of the receiver (assumes the receiver is a machine word sized integer)."

	^(self bitShift: ##(VMConstants.HalfPtrBits negated)) lowPartSigned!

highWord
	"Answers the high order unsigned word of the receiver (assumes the receiver is a 32-bit Integer)."

	^(self bitShift: -16) bitAnd: 16rFFFF!

integerPart
	"Answer an <integer> representing the whole integer part of the receiver."

	^self!

isBitSet: index
	"Answer whether the index'th bit of the receiver is set (has the value 1), 
	where the least significant bit is considered to have index 1."

	^self anyMask: (1 bitShift: index-1)!

isInteger
	"Answer whether the receiver is an <integer>."

	^true!

isNull
	"Answer whether the receiver is 'null' (equal to zero)."

	^self == 0!

isPowerOfTwo
	"Return true if the receiver is an integral power of two."

	^self strictlyPositive and: [(self bitAnd: self - 1) == 0]!

isSDWORD
	"Answer whether the receiver can be represented as a 32-bit two's complement signed integer
	(i.e. as an SDWORD)."

	^self >= ##(-2 raisedToInteger: 31) and: [self < ##(2 raisedToInteger: 31)]!

lcm: anInteger 
	"Answer the least common multiple of the receiver and the <integer> argument."

	| gcd |
	anInteger = 0 ifTrue: [^0].
	gcd := self gcd: anInteger.
	^gcd == 0 ifTrue: [1] ifFalse: [(self // gcd * anInteger) abs]!

lowBit
	"Answer the index of the lowest order bit of the receiver which is set."

	1 to: self basicSize
		do: 
			[:i | 
			| byte |
			byte := self byteAt: i.
			byte == 0 ifFalse: [^byte lowBit + ((i - 1) * 8)]].
	^0!

lowPart
	"Answers the low order unsigned word of the receiver (assumes the receiver is a machine word sized Integer, i.e. an INT_PTR)."

	^self bitAnd: VMConstants.HalfPtrMask!

lowPartSigned
	"Answers the low order signed word of the receiver (assumes the receiver is a machine word sized Integer)."

	| part |
	part := self lowPart.
	^part > VMConstants.HalfPtrMax 
		ifTrue: [(part bitXor: VMConstants.HalfPtrMask) bitInvert]
		ifFalse: [part]!

lowWord
	"Answers the low order word of the receiver."

	^self bitAnd: 16rFFFF.!

mask: integerMask set: aBoolean
	"Answer the result of setting/resetting the specified mask in the receiver."

	^aBoolean 
		ifTrue: [self maskSet: integerMask]
		ifFalse: [self maskClear: integerMask]
!

maskClear: anInteger
	"Answer a copy of the receiver with the bits of the argument, anInteger, masked out."

	^self bitAnd: anInteger bitInvert!

maskSet: anInteger
	"Answer a copy of the receiver with the bits of the argument, anInteger, masked in"

	^self bitOr: anInteger!

multiplyByFloat: aFloat
	"Private - Multiply the receiver by the known Float, aFloat. Answer the result."

	^aFloat * self asFloat!

multiplyByFraction: aFraction
	"Private - Answer the result of multiplying the receiver by the known Fraction, aFraction."

	^Fraction
		rationalisedNumerator: self * aFraction numerator
		denominator: aFraction denominator!

negated
	"Answer a <number> of the same type of the receiver
	which is its negation.

	Implementation Note: Overridden purely for improved performance."

	^0 - self!

negative
	"Answer whether the receiver is a negative number.
	Implementation Note: Override for performance only."

	^self < 0!

noMask: mask
	"Answer whether none of the bits that are set in the <integer> argument, mask,
	are also set in the receiver."

	^(self bitAnd: mask) == 0!

normalize
	"Private - Answer the receiver in its minimal representation (i.e. itself)."

	^self!

notNull
	"Answer whether the receiver is not 'null' (not equal to zero)"

	^self ~~ 0!

printDigitsOn: aStream base: anInteger 
	"Private - Recursively print the digits of the receiver in base anInteger to aStream.
	N.B. The receiver MUST be positive for this to work correctly."

	self basicPrintDigitsOn: aStream base: anInteger!

printOn: aStream
	"Append the ASCII representation of the receiver to aStream.
	Although not strictly part of the ANSI protocol <number>, this method is the
	means by which Integer complies with that protocol in order to produce
	a literal representation of the receiver."

	self printOn: aStream base: 10 showRadix: false!

printOn: output base: base
	"Append a text representation of the receiver on the <puttableStream>, output,
	in the specified <integer> base with a radix prefix."

	self printOn: output base: base showRadix: true!

printOn: output base: base showRadix: flag
	"Append a text representation of the receiver on the <puttableStream>, output,
	in the specified <integer> base, showing a radix prefix if requested."

	self negative
		ifTrue: [ 
			output nextPut: $-.
			self negated printOn: output base: base showRadix: flag]
		ifFalse: [
			flag ifTrue: [base printOn: output. output nextPut: $r].
			self printDigitsOn: output base: base]!

printStringRadix: base
	"Answer a <readableString> whose characters are a description of 
	the receiver in the specified <integer> radix."

	^self printStringRadix: base showRadix: true!

printStringRadix: base showRadix: flag
	"Answer a String which represents the receiver in the radix, base (an Integer).
	The radix prefix is included if the boolean flag is true."

	| aStream |
	aStream := String writeStream: 16.
	self printOn: aStream base: base showRadix: flag.
	^aStream contents
!

quo: aNumber
	"Answer the integer quotient of the receiver divided by aNumber with 
	truncation toward zero (i.e. like C integer division)."

	^(self quoAndRem: aNumber) basicAt: 1
!

rounded
	"Answer the integer nearest the receiver."

	^self
!

setBit: index
	"Answer the Integer which results from setting the index'th bit of the receiver,
	where the least significant bit is considered to have index 1."

	^self maskSet: (1 bitShift: index-1)!

size
	"Integer's do not support indexed instance variables."

	^self shouldNotImplement!

subtractFromFloat: aFloat
	"Private - Subtract the receiver from the known Float, aFloat, and answer the result."

	^aFloat - self asFloat!

subtractFromFraction: aFraction
	"Private - Subtract the receiver from the known fraction, aFraction and answer the result.
	There is no need to normalise the result."

	^Fraction
		numerator: aFraction numerator - (self * aFraction denominator)
		denominator: aFraction denominator!

timesRepeat: aBlock 
	"Evaluate aBlock repeatedly, once for each integer from 1 to the floor of 
	the receiver."

	"Implementation Note: This message is normally inlined by the Compiler,
	but it is only able to make that optimization if the argument is a literal
	block. Although at first glance infinitely recursive, the most optimal 
	implementation is to exploit that inlining and implement this method
	in terms of itself."

	self timesRepeat: [aBlock value]!

truncated
	"Answer the integer nearest the receiver toward zero."

	^self
! !
!Integer categoriesFor: #-!arithmetic!public! !
!Integer categoriesFor: #&!bit manipulation!public! !
!Integer categoriesFor: #*!arithmetic!public! !
!Integer categoriesFor: #/!arithmetic!public! !
!Integer categoriesFor: #//!arithmetic!public! !
!Integer categoriesFor: #|!bit manipulation!public! !
!Integer categoriesFor: #+!arithmetic!public! !
!Integer categoriesFor: #<!comparing!public! !
!Integer categoriesFor: #<<!bit manipulation!public! !
!Integer categoriesFor: #>>!bit manipulation!public! !
!Integer categoriesFor: #addToFloat:!double dispatch!private! !
!Integer categoriesFor: #addToFraction:!double dispatch!private! !
!Integer categoriesFor: #allMask:!bit manipulation!public! !
!Integer categoriesFor: #anyBitSetFrom:to:!bit manipulation!public! !
!Integer categoriesFor: #anyMask:!bit manipulation!public! !
!Integer categoriesFor: #asBoolean!converting!public! !
!Integer categoriesFor: #asCharacter!converting!public! !
!Integer categoriesFor: #asDword!converting!public! !
!Integer categoriesFor: #asExternalAddress!converting!public! !
!Integer categoriesFor: #asExternalHandle!converting!public! !
!Integer categoriesFor: #asFraction!converting!public! !
!Integer categoriesFor: #asInteger!converting!public! !
!Integer categoriesFor: #asResourceId!converting!public! !
!Integer categoriesFor: #asScaledDecimal:!converting!public! !
!Integer categoriesFor: #asSDword!converting!public! !
!Integer categoriesFor: #asStackPointer!converting!private! !
!Integer categoriesFor: #asUIntPtr!converting!public! !
!Integer categoriesFor: #at:!accessing!public! !
!Integer categoriesFor: #basicPrintDigitsOn:base:!printing!private! !
!Integer categoriesFor: #bitAnd:!bit manipulation!public! !
!Integer categoriesFor: #bitAt:!bit manipulation!public! !
!Integer categoriesFor: #bitAt:put:!bit manipulation!public! !
!Integer categoriesFor: #bitInvert!bit manipulation!public! !
!Integer categoriesFor: #bitOr:!bit manipulation!public! !
!Integer categoriesFor: #bitShift:!bit manipulation!public! !
!Integer categoriesFor: #bitXor:!bit manipulation!public! !
!Integer categoriesFor: #byteAt:!accessing!private! !
!Integer categoriesFor: #byteSize!accessing!private! !
!Integer categoriesFor: #ceiling!public!truncation and round off! !
!Integer categoriesFor: #clearBit:!bit manipulation!public! !
!Integer categoriesFor: #coerce:!coercing!private! !
!Integer categoriesFor: #digitAt:!accessing!public! !
!Integer categoriesFor: #digitLength!enquiries!public! !
!Integer categoriesFor: #displayString!printing!public! !
!Integer categoriesFor: #divideIntoFloat:!double dispatch!private! !
!Integer categoriesFor: #divideIntoFraction:!double dispatch!private! !
!Integer categoriesFor: #divideIntoInteger:!double dispatch!private! !
!Integer categoriesFor: #even!public!testing! !
!Integer categoriesFor: #exp10!mathematical!public! !
!Integer categoriesFor: #factorial!factorization!public! !
!Integer categoriesFor: #factorial2p!factorization!private! !
!Integer categoriesFor: #factorialIterative!factorization!private! !
!Integer categoriesFor: #floor!public!truncation and round off! !
!Integer categoriesFor: #fractionPart!accessing!public! !
!Integer categoriesFor: #gcd:!factorization!public! !
!Integer categoriesFor: #gcdbin:!factorization!public! !
!Integer categoriesFor: #greaterThanFloat:!double dispatch!private! !
!Integer categoriesFor: #greaterThanFraction:!double dispatch!private! !
!Integer categoriesFor: #hash!comparing!public! !
!Integer categoriesFor: #hex!printing!public! !
!Integer categoriesFor: #highBit!bit manipulation!public! !
!Integer categoriesFor: #highByte!accessing!private! !
!Integer categoriesFor: #highPartSigned!bit manipulation!public! !
!Integer categoriesFor: #highWord!bit manipulation!public! !
!Integer categoriesFor: #integerPart!accessing!public! !
!Integer categoriesFor: #isBitSet:!bit manipulation!public!testing! !
!Integer categoriesFor: #isInteger!public!testing! !
!Integer categoriesFor: #isNull!public!testing! !
!Integer categoriesFor: #isPowerOfTwo!public!testing! !
!Integer categoriesFor: #isSDWORD!public!testing! !
!Integer categoriesFor: #lcm:!factorization!public! !
!Integer categoriesFor: #lowBit!bit manipulation!public! !
!Integer categoriesFor: #lowPart!bit manipulation!public! !
!Integer categoriesFor: #lowPartSigned!bit manipulation!public! !
!Integer categoriesFor: #lowWord!bit manipulation!public! !
!Integer categoriesFor: #mask:set:!bit manipulation!public! !
!Integer categoriesFor: #maskClear:!bit manipulation!public! !
!Integer categoriesFor: #maskSet:!bit manipulation!public! !
!Integer categoriesFor: #multiplyByFloat:!double dispatch!private! !
!Integer categoriesFor: #multiplyByFraction:!double dispatch!private! !
!Integer categoriesFor: #negated!arithmetic!public! !
!Integer categoriesFor: #negative!public!testing! !
!Integer categoriesFor: #noMask:!bit manipulation!public! !
!Integer categoriesFor: #normalize!converting!private! !
!Integer categoriesFor: #notNull!public!testing! !
!Integer categoriesFor: #printDigitsOn:base:!printing!private! !
!Integer categoriesFor: #printOn:!printing!public! !
!Integer categoriesFor: #printOn:base:!printing!public! !
!Integer categoriesFor: #printOn:base:showRadix:!printing!public! !
!Integer categoriesFor: #printStringRadix:!printing!public! !
!Integer categoriesFor: #printStringRadix:showRadix:!printing!public! !
!Integer categoriesFor: #quo:!arithmetic!public! !
!Integer categoriesFor: #rounded!public!truncation and round off! !
!Integer categoriesFor: #setBit:!bit manipulation!public! !
!Integer categoriesFor: #size!accessing!public! !
!Integer categoriesFor: #subtractFromFloat:!double dispatch!private! !
!Integer categoriesFor: #subtractFromFraction:!double dispatch!private! !
!Integer categoriesFor: #timesRepeat:!evaluating!public! !
!Integer categoriesFor: #truncated!public!truncation and round off! !

Integer methodProtocol: #integer attributes: #(#ansi #readOnly) selectors: #(#- #* #/ #// #+ #< #allMask: #anyMask: #asFraction #asInteger #asScaledDecimal: #bitAnd: #bitAt: #bitAt:put: #bitOr: #bitShift: #bitXor: #ceiling #even #factorial #floor #fractionPart #gcd: #highBit #integerPart #lcm: #negated #negative #noMask: #odd #printOn:base:showRadix: #printStringRadix: #quo: #rounded #truncated)!

!Integer class methodsFor!

primesUpTo: aNumber 
	"Answer a <sequencedReadableCollection> of all primes less than or equal to the <integer> argument."

	| limit flags prime primes |
	limit := aNumber asInteger - 1.
	flags := ByteArray new: limit withAll: 1.
	primes := Array writeStream.
	1 to: limit
		do: 
			[:i | 
			(flags at: i) == 1 
				ifTrue: 
					[| k |
					prime := i + 1.
					k := i + prime.
					[k <= limit] whileTrue: 
							[flags at: k put: 0.
							k := k + prime].
					primes nextPut: prime]].
	^primes contents!

readFrom: aStream
	"Instantiate a new subinstance of the receiver from aStream and answer it.
	Handles negative integers with a leading minus sign. Also allows for bases
	other than 10 (with leading nnr format) with digits greater than 10 being
	represented by characters A-Z.
	Does not handle NLS characters (e.g. thousand separators)."

	| neg answer |
	neg := aStream peekFor: $-.
	answer := self readFrom: aStream
				initialInteger: (self readPositiveFrom: aStream radix: 10).
	^neg ifTrue: [answer negated] ifFalse: [answer]!

readFrom: aStream initialInteger: initialInteger
	"Private - Instantiate a new instance of the receiver from aStream and answer it.
	The <integer>, initialInteger, has already been read from the stream.
	All we need to do is to check whether initialInteger is in fact a radix prefix, and
	proceed accordingly."

	^(aStream peekFor: $r) 
		ifTrue: [self readPositiveFrom: aStream radix: initialInteger]
		ifFalse: [initialInteger]!

readFrom: aStream radix: anInteger
	"Instantiate a subinstance of the receiver from aStream using the specified
	radix, and answer it. 
	Note: This is intended for reading Integer's obeying Smalltalk syntax, not locale specific
	formats, and therefore it does not handle NLS characters (e.g. thousand separators)."

	| neg value |
	neg := aStream peekFor: $-.
	value := self readPositiveFrom: aStream radix: anInteger.
	^neg ifTrue: [value negated] ifFalse: [value]!

readPositiveFrom: aStream radix: anInteger
	| value |
	value := 0.
	[aStream atEnd] whileFalse: 
			[| char digit |
			char := aStream next.
			((digit := char digitValue) < anInteger and: [digit >= 0]) 
				ifTrue: [value := value * anInteger + digit]
				ifFalse: 
					[aStream pop.
					^value]].
	^value! !
!Integer class categoriesFor: #primesUpTo:!enquiries!public! !
!Integer class categoriesFor: #readFrom:!instance creation!public! !
!Integer class categoriesFor: #readFrom:initialInteger:!instance creation!private! !
!Integer class categoriesFor: #readFrom:radix:!instance creation!public! !
!Integer class categoriesFor: #readPositiveFrom:radix:!instance creation!private! !

