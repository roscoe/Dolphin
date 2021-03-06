﻿"Filed out from Dolphin Smalltalk 7"!

TextPresenter subclass: #RichTextPresenter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'CommonDialogConstants RichEditConstants'
	classInstanceVariableNames: ''!
RichTextPresenter guid: (GUID fromString: '{87b4c6d4-026e-11d3-9fd7-00a0cc3e4a32}')!
RichTextPresenter comment: 'RichTextPresenter is a <valuePresenter> that displays a <valueModel> onto a <richString> value. A RichTextPresenter can be connected to any <valueView> capable of displaying <richString> values. Often, this will be a <RichTextEdit> although alternative views may be chosen with the installation of an appropriate <typeConverter>.'!
!RichTextPresenter categoriesForClass!MVP-Presenters! !
!RichTextPresenter methodsFor!

alignParagraphCenter
	"Align the receiver's paragraph selection to centre"

	self view paragraphAlignment: #center!

alignParagraphLeft
	"Align the receiver's selection paragraph to the left"

	self view paragraphAlignment: #left!

alignParagraphRight
	"Align the receiver's paragraph selection to the right"

	self view paragraphAlignment: #right!

bePlain
	"Set the selection in the receiver to plain text"

	self view bePlain!

chooseSelectionColor
	"Choose the color for the selection in the receiver"

	(ColorDialog on: (self view aspectValue: #selectionColor))
		caption: 'Selection Color';
		showModal!

chooseSelectionFont
	"Choose the font for the selection in the receiver - note that the user can also choose font
	colours and effects, and change one aspect of a selection range without affecting other
	aspects."

	| dialog struct charFormat |
	charFormat := self view selectionCharFormat.
	dialog := FontDialog on: charFormat font.
	struct := dialog winStruct.
	charFormat populateChooseFont: struct.
	dialog showModal.
	dialog isConfirmed ifTrue: [self view selectionCharFormat: (CHARFORMAT2W fromChooseFont: struct)]!

queryCommand: query
	"Private - Enters details about a potential command for the receiver into 
	the <CommandQuery>, query"

	| cmd answer |
	answer := super queryCommand: query.		"Supersend to get enablement of understood selectors"
	cmd := query commandSymbol.

	cmd == #toggleBold ifTrue: [
		query isChecked: self view isBold.
		^true].
	cmd == #toggleItalic ifTrue: [
		query isChecked: self view isItalic.
		^true].
	cmd == #toggleUnderlined ifTrue: [
		query isChecked: self view isUnderlined.
		^true].

	cmd == #alignParagraphLeft ifTrue: [
		query isChecked: self view paragraphAlignment == #left.
		^true].
	cmd == #alignParagraphCenter ifTrue: [
		query isChecked: self view paragraphAlignment == #center.
		^true].
	cmd == #alignParagraphRight ifTrue: [
		query isChecked: self view paragraphAlignment == #right.
		^true].

	^answer!

toggleBold
	"Toggle bold mode for the selection in the receiver"

	self view isBold: self view isBold not!

toggleItalic
	"Toggle italic mode for the selection in the receiver"

	self view isItalic: self view isItalic not!

toggleUnderlined
	"Toggle underline mode for the selection in the receiver"

	self view isUnderlined: self view isUnderlined not! !
!RichTextPresenter categoriesFor: #alignParagraphCenter!commands!public! !
!RichTextPresenter categoriesFor: #alignParagraphLeft!commands!public! !
!RichTextPresenter categoriesFor: #alignParagraphRight!commands!public! !
!RichTextPresenter categoriesFor: #bePlain!commands!public! !
!RichTextPresenter categoriesFor: #chooseSelectionColor!commands!public! !
!RichTextPresenter categoriesFor: #chooseSelectionFont!commands!public! !
!RichTextPresenter categoriesFor: #queryCommand:!commands!private! !
!RichTextPresenter categoriesFor: #toggleBold!commands!public! !
!RichTextPresenter categoriesFor: #toggleItalic!commands!public! !
!RichTextPresenter categoriesFor: #toggleUnderlined!commands!public! !

!RichTextPresenter class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it
	is initialized."

	^String new asRichText asValue!

resource_Default_view
	"Answer the literal data from which the 'Default view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Default_view)
	"

	^#(#'!!STL' 4 788558 10 ##(Smalltalk.STBViewProxy) ##(Smalltalk.RichTextEdit) 34 18 nil nil 34 2 8 1140920644 1025 416 nil 786694 ##(Smalltalk.ColorDefault) 8 4278190080 nil 7 265030 4 ##(Smalltalk.Menu) nil true 34 10 984134 2 ##(Smalltalk.CommandMenuItem) 1 1180998 4 ##(Smalltalk.CommandDescription) #chooseSelectionFont 8 '&Font...' 1 1 nil nil nil 983366 1 ##(Smalltalk.DividerMenuItem) 4097 578 1 610 #bePlain 8 '&Plain' 1 1 nil nil nil 578 1 610 #toggleBold 8 '&Bold' 1 1 nil nil nil 578 1 610 #toggleItalic 8 '&Italic' 1 1 nil nil nil 578 1 610 #toggleUnderlined 8 '&Underlined' 1 1 nil nil nil 658 4097 530 nil true 34 3 578 1025 610 #alignParagraphLeft 8 '&Left' 1 1 nil nil nil 578 1025 610 #alignParagraphCenter 8 '&Centre' 1 1 nil nil nil 578 1025 610 #alignParagraphRight 8 '&Right' 1 1 nil nil nil 8 '&Align' nil 1 nil nil nil nil nil 658 4097 578 1 610 #chooseSelectionColor 8 '&Colour...' 1 1 nil nil nil 8 '' nil 1 nil nil nil nil nil nil nil 416 nil 8 1804752336 852486 ##(Smalltalk.NullConverter) nil nil 9 nil 655622 ##(Smalltalk.EDITSTREAM) 8 #[0 0 0 0 0 0 0 0 16 0 248 3] 983302 ##(Smalltalk.MessageSequence) 138 144 34 5 721670 ##(Smalltalk.MessageSend) #createAt:extent: 34 2 328198 ##(Smalltalk.Point) 2799 21 1378 421 351 416 1330 #contextMenu: 34 1 544 416 1330 #text: 34 1 524550 ##(Smalltalk.RichText) 8 '{\urtf1\ansi\ansicpg1252\deff0\deflang2057{\fonttbl{\f0\froman Times New Roman;}}
\viewkind4\uc1\pard\f0\fs22\par
}
' 416 1330 #textLimit: 8 #(1073741823) 416 1330 #resetCharFormat 8 #() 416 983302 ##(Smalltalk.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 119 5 0 0 10 0 0 0 73 6 0 0 185 0 0 0] 8 #() 1378 193 193 nil 27 )!

resource_Static_text
	"Answer the literal data from which the 'Static text' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Static_text)
	"

	^#(#'!!STL' 4 788558 10 ##(Smalltalk.STBViewProxy) ##(Smalltalk.RichTextEdit) 34 18 nil nil 34 2 8 1140855108 1025 416 nil 786694 ##(Smalltalk.ColorDefault) 8 4278190080 nil 7 265030 4 ##(Smalltalk.Menu) nil true 34 10 984134 2 ##(Smalltalk.CommandMenuItem) 1 1180998 4 ##(Smalltalk.CommandDescription) #chooseSelectionFont 8 '&Font...' 1 1 nil nil nil 983366 1 ##(Smalltalk.DividerMenuItem) 4097 578 1 610 #bePlain 8 '&Plain' 1 1 nil nil nil 578 1 610 #toggleBold 8 '&Bold' 1 1 nil nil nil 578 1 610 #toggleItalic 8 '&Italic' 1 1 nil nil nil 578 1 610 #toggleUnderlined 8 '&Underlined' 1 1 nil nil nil 658 4097 530 nil true 34 3 578 1025 610 #alignParagraphLeft 8 '&Left' 1 1 nil nil nil 578 1025 610 #alignParagraphCenter 8 '&Centre' 1 1 nil nil nil 578 1025 610 #alignParagraphRight 8 '&Right' 1 1 nil nil nil 8 '&Align' nil 1 nil nil nil nil nil 658 4097 578 1 610 #chooseSelectionColor 8 '&Colour...' 1 1 nil nil nil 8 '' nil 1 nil nil nil nil nil nil nil 416 nil 8 1804752336 852486 ##(Smalltalk.NullConverter) nil nil 43 nil 655622 ##(Smalltalk.EDITSTREAM) 8 #[0 0 0 0 0 0 0 0 16 0 248 3] 983302 ##(Smalltalk.MessageSequence) 138 144 34 5 721670 ##(Smalltalk.MessageSend) #createAt:extent: 34 2 328198 ##(Smalltalk.Point) 2799 21 1378 421 131 416 1330 #contextMenu: 34 1 544 416 1330 #text: 34 1 524550 ##(Smalltalk.RichText) 8 '{\urtf1\ansi\ansicpg1252\deff0\deflang2057{\fonttbl{\f0\fnil\fcharset0 Times New Roman;}{\f1\froman Times New Roman;}}
\viewkind4\uc1\pard\qc\f0\fs22 Type \b Rich \b0\i Static \i0 text \ul here\ulnone .\f1\par
}
' 416 1330 #textLimit: 8 #(1073741823) 416 1330 #resetCharFormat 8 #() 416 983302 ##(Smalltalk.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 119 5 0 0 10 0 0 0 73 6 0 0 75 0 0 0] 8 #() 1378 193 193 nil 27 )! !
!RichTextPresenter class categoriesFor: #defaultModel!models!public! !
!RichTextPresenter class categoriesFor: #resource_Default_view!public!resources-views! !
!RichTextPresenter class categoriesFor: #resource_Static_text!public!resources-views! !

