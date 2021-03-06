﻿"Filed out from Dolphin Smalltalk 7"!

Dialog subclass: #PersonalAccountTransactionDialog
	instanceVariableNames: 'datePresenter amountPresenter descriptionPresenter isDebitPresenter'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
PersonalAccountTransactionDialog guid: (GUID fromString: '{87b4c6a3-026e-11d3-9fd7-00a0cc3e4a32}')!
PersonalAccountTransactionDialog comment: 'PersonalAccountTransactionDialog is a <dialogPresenter> used to edit the contents of an <PersonalAccountTransaction> model.

To see an example operating on a new transaction evaluate:

PersonalAccountTransactionDialog showModal

Instance Variables:
	datePresenter		<DatePresenter> for the #date aspect.
	amountPresenter		<NumberPresenter> for the #amount aspect.
	descriptionPresenter		<TextPresenter> for the #description aspect.
	isDebitPresenter		<BooleanPresenter> for the #isDebit aspect.

'!
!PersonalAccountTransactionDialog categoriesForClass!MVP-Presenters!Samples! !
!PersonalAccountTransactionDialog methodsFor!

createComponents
	"Create the presenters contained by the receiver"

	super createComponents.
	datePresenter := self add: DatePresenter new name: 'date'.
	amountPresenter := self add: NumberPresenter new name: 'amount'.
	descriptionPresenter := self add: TextPresenter new name: 'description'.
	isDebitPresenter := self add: BooleanPresenter new name: 'isDebit'.

!

model: aPersonalAccountTransaction
	"Set the model associated with the receiver."

	| aspectBuffer |
	super model: aPersonalAccountTransaction.

	aspectBuffer := self model.
	datePresenter model: (aspectBuffer aspectValue: #date).
	amountPresenter model: (aspectBuffer aspectValue: #amount).
	descriptionPresenter model: (aspectBuffer aspectValue: #description).
	isDebitPresenter model: (aspectBuffer aspectValue: #isDebit).
! !
!PersonalAccountTransactionDialog categoriesFor: #createComponents!initializing!public! !
!PersonalAccountTransactionDialog categoriesFor: #model:!accessing!public! !

!PersonalAccountTransactionDialog class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it
	is initialized."

	^PersonalAccountTransaction new
!

resource_Default_view
	"Answer the literal data from which the 'Default view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Default_view)
	"

	^#(#'!!STL' 4 788558 10 ##(Smalltalk.STBViewProxy) ##(Smalltalk.DialogView) 34 30 nil nil 8 #(13107200 65536) 416 nil 786694 ##(Smalltalk.ColorDefault) 8 4278190080 328198 ##(Smalltalk.Point) 861 571 165 nil nil nil 416 nil 170 192 34 8 410 ##(Smalltalk.TextEdit) 34 16 nil 416 34 2 8 1140920320 1025 576 nil 480 nil 7 nil nil nil 576 nil 8 1915280032 787206 ##(Smalltalk.NumberToText) nil 8 '' nil 1 983302 ##(Smalltalk.MessageSequence) 138 144 34 1 721670 ##(Smalltalk.MessageSend) #createAt:extent: 34 2 514 215 267 514 201 51 576 983302 ##(Smalltalk.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 107 0 0 0 133 0 0 0 207 0 0 0 158 0 0 0] 8 #() 514 193 193 nil 27 8 'amount' 410 ##(Smalltalk.DateTimePicker) 34 16 nil 416 34 2 8 1140916228 1025 944 721990 2 ##(Smalltalk.ValueHolder) nil nil 1376774 ##(Smalltalk.PluggableSearchPolicy) 459270 ##(Smalltalk.Message) #= 8 #() 1074 #hash 8 #() nil 480 nil 7 nil nil nil 944 nil 8 1915873632 852486 ##(Smalltalk.NullConverter) nil nil nil 706 138 144 34 3 770 #createAt:extent: 34 2 514 215 57 514 601 51 944 770 #text: 34 1 8 '16 October 2018' 944 770 #range: 34 1 34 2 655622 ##(Smalltalk.SYSTEMTIME) 8 #[216 6 9 0 4 0 14 0 0 0 0 0 0 0 0 0] nil 944 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 107 0 0 0 28 0 0 0 151 1 0 0 53 0 0 0] 8 #() 912 nil 27 8 'date' 410 ##(Smalltalk.CheckBox) 34 16 nil 416 34 2 8 1140924451 1 1520 1010 nil nil 1114118 ##(Smalltalk.NeverSearchPolicy) false 480 nil 7 nil nil nil 1520 nil 8 1915188384 1170 nil nil nil 706 138 144 34 2 770 #createAt:extent: 34 2 514 25 347 514 221 61 1520 770 #text: 34 1 8 'Debit:' 1520 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 12 0 0 0 173 0 0 0 122 0 0 0 203 0 0 0] 8 #() 912 nil 27 8 'isDebit' 410 ##(Smalltalk.TextEdit) 34 16 nil 416 34 2 8 1140920320 1025 1888 nil 480 nil 7 nil nil nil 1888 nil 8 1915280032 1170 nil nil 1 706 138 144 34 1 770 #createAt:extent: 34 2 514 215 127 514 601 121 1888 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 107 0 0 0 63 0 0 0 151 1 0 0 123 0 0 0] 8 #() 912 nil 27 8 'description' 590342 ##(Smalltalk.Rectangle) 514 1 1 514 1 1 nil nil nil nil 3 nil nil nil nil 1 nil nil 590598 ##(Smalltalk.Semaphore) nil nil 1 nil 8 2011052416 706 138 144 34 3 770 #createAt:extent: 34 2 514 3839 21 514 861 571 416 770 #text: 34 1 8 'Transaction Details' 416 770 #updateMenuBar 8 #() 416 850 8 #[44 0 0 0 0 0 0 0 0 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 127 7 0 0 10 0 0 0 45 9 0 0 39 1 0 0] 34 9 410 ##(Smalltalk.StaticText) 34 16 nil 416 34 2 8 1140850944 1 2512 1010 nil nil 1616 8 'Amount:' nil nil 7 nil nil nil 2512 nil 8 1915124368 1170 nil nil nil 706 138 144 34 2 770 #createAt:extent: 34 2 514 25 277 514 171 51 2512 770 #text: 34 1 8 'Amount:' 2512 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 12 0 0 0 138 0 0 0 97 0 0 0 163 0 0 0] 8 #() 912 nil 27 410 ##(Smalltalk.StaticText) 34 16 nil 416 34 2 8 1140850944 1 2848 1010 nil nil 1616 8 'Description:' nil nil 7 nil nil nil 2848 nil 8 1915124368 1170 nil nil nil 706 138 144 34 2 770 #createAt:extent: 34 2 514 25 137 514 171 51 2848 770 #text: 34 1 8 'Description:' 2848 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 12 0 0 0 68 0 0 0 97 0 0 0 93 0 0 0] 8 #() 912 nil 27 410 ##(Smalltalk.StaticText) 34 16 nil 416 34 2 8 1140850944 1 3184 1010 nil nil 1616 8 'Date:' nil nil 7 nil nil nil 3184 nil 8 1915124368 1170 nil nil nil 706 138 144 34 2 770 #createAt:extent: 34 2 514 25 57 514 171 51 3184 770 #text: 34 1 8 'Date:' 3184 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 12 0 0 0 28 0 0 0 97 0 0 0 53 0 0 0] 8 #() 912 nil 27 1888 576 1520 410 ##(Smalltalk.PushButton) 34 20 nil 416 34 2 8 1140924416 1 3520 nil 480 nil 7 nil nil nil 3520 nil 8 1915188384 1180998 4 ##(Smalltalk.CommandDescription) #ok 8 '&Ok' 1 1 nil nil false nil nil nil 706 138 144 34 3 770 #createAt:extent: 34 2 514 215 427 514 201 51 3520 770 #isEnabled: 8 #(false) 3520 770 #text: 34 1 8 '&Ok' 3520 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 107 0 0 0 213 0 0 0 207 0 0 0 238 0 0 0] 8 #() 912 nil 29 410 ##(Smalltalk.PushButton) 34 20 nil 416 34 2 8 1140924416 1 3888 nil 480 nil 7 nil nil nil 3888 nil 8 1915188384 3602 #cancel 8 '&Cancel' 1 1 nil nil false nil nil nil 706 138 144 34 2 770 #createAt:extent: 34 2 514 615 427 514 201 51 3888 770 #text: 34 1 8 '&Cancel' 3888 850 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 51 1 0 0 213 0 0 0 151 1 0 0 238 0 0 0] 8 #() 912 nil 29 944 912 nil 27 )! !
!PersonalAccountTransactionDialog class categoriesFor: #defaultModel!models!public! !
!PersonalAccountTransactionDialog class categoriesFor: #resource_Default_view!public!resources-views! !

