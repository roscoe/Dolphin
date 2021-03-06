﻿"Filed out from Dolphin Smalltalk 7"!

IUnknown subclass: #IShellFolder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
IShellFolder guid: (IID fromString: '{000214E6-0000-0000-C000-000000000046}')!
IShellFolder comment: ''!
!IShellFolder categoriesForClass!COM-Interfaces! !
!IShellFolder methodsFor!

BindToObject: bindToObject pbc: pbc riid: riid ppvOut: ppvOut
	"Callout for the IShellFolder::BindToObject() interface function.
	N.B. This method has been automatically generated from 
	the vtable defined in IShellFolder>>defineFunctions. DO NOT MODIFY!!"

	<virtual stdcall: HRESULT 6 lpvoid lpvoid REFGUID lppvoid>
	^self invalidCall!

BindToStorage: bindToStorage pbc: pbc riid: riid ppv: ppv
	"Callout for the IShellFolder::BindToStorage() interface function.
	N.B. This method has been automatically generated from 
	the vtable defined in IShellFolder>>defineFunctions. DO NOT MODIFY!!"

	<virtual stdcall: HRESULT 7 lpvoid lpvoid REFGUID lppvoid>
	^self invalidCall!

CompareIDs: compareIDs pidl1: pidl1 pidl2: pidl2
	"Callout for the IShellFolder::CompareIDs() interface function.
	N.B. This method has been automatically generated from 
	the vtable defined in IShellFolder>>defineFunctions. DO NOT MODIFY!!"

	<virtual stdcall: HRESULT 8 DWORD lpvoid lpvoid>
	^self invalidCall!

CreateViewObject: createViewObject riid: riid ppvOut: ppvOut
	"Callout for the IShellFolder::CreateViewObject() interface function.
	N.B. This method has been automatically generated from 
	the vtable defined in IShellFolder>>defineFunctions. DO NOT MODIFY!!"

	<virtual stdcall: HRESULT 9 handle REFGUID lppvoid>
	^self invalidCall!

EnumObjects: enumObjects grfFlags: grfFlags ppenumIDList: ppenumIDList
	"Callout for the IShellFolder::EnumObjects() interface function.
	N.B. This method has been automatically generated from 
	the vtable defined in IShellFolder>>defineFunctions. DO NOT MODIFY!!"

	<virtual stdcall: HRESULT 5 handle DWORD lppvoid>
	^self invalidCall!

GetAttributesOf: getAttributesOf apidl: apidl rgfInOut: rgfInOut
	"Callout for the IShellFolder::GetAttributesOf() interface function.
	N.B. This method has been automatically generated from 
	the vtable defined in IShellFolder>>defineFunctions. DO NOT MODIFY!!"

	<virtual stdcall: HRESULT 10 DWORD lppvoid DWORD*>
	^self invalidCall!

GetDisplayNameOf: getDisplayNameOf uFlags: uFlags lpName: lpName
	"Callout for the IShellFolder::GetDisplayNameOf() interface function.
	N.B. This method has been automatically generated from 
	the vtable defined in IShellFolder>>defineFunctions. DO NOT MODIFY!!"

	<virtual stdcall: HRESULT 12 lpvoid DWORD lpvoid>
	^self invalidCall!

GetUIObjectOf: getUIObjectOf cidl: cidl apidl: apidl riid: riid prgfInOut: prgfInOut ppvOut: ppvOut
	"Callout for the IShellFolder::GetUIObjectOf() interface function.
	N.B. This method has been automatically generated from 
	the vtable defined in IShellFolder>>defineFunctions. DO NOT MODIFY!!"

	<virtual stdcall: HRESULT 11 handle DWORD lppvoid REFGUID DWORD* lppvoid>
	^self invalidCall!

idlFromPath: path 
	"Answer an ITEMIDLIST from the specified <readableString> path."

	^ITEMIDLIST fromAddress: (self pidlFromPath: path)!

ParseDisplayName: parseDisplayName pbc: pbc lpwszDisplayName: lpwszDisplayName pchEaten: pchEaten ppidl: ppidl pdwAttributes: pdwAttributes
	"Callout for the IShellFolder::ParseDisplayName() interface function.
	N.B. This method has been automatically generated from 
	the vtable defined in IShellFolder>>defineFunctions. DO NOT MODIFY!!"

	<virtual stdcall: HRESULT 4 handle lpvoid lpwstr DWORD* lppvoid DWORD*>
	^self invalidCall!

pidlFromPath: path
	"Answer a PIDL from the specified <readableString> path."

	| answer |
	answer := WindowsShellMemory new.
	self
		ParseDisplayName: nil
		pbc: nil
		lpwszDisplayName: path
		pchEaten: nil
		ppidl: answer
		pdwAttributes: nil.
	^answer!

SetNameOf: setNameOf pidl: pidl lpszName: lpszName uFlags: uFlags ppidlOut: ppidlOut
	"Callout for the IShellFolder::SetNameOf() interface function.
	N.B. This method has been automatically generated from 
	the vtable defined in IShellFolder>>defineFunctions. DO NOT MODIFY!!"

	<virtual stdcall: HRESULT 13 handle lpvoid lpwstr DWORD lppvoid>
	^self invalidCall! !
!IShellFolder categoriesFor: #BindToObject:pbc:riid:ppvOut:!COM Interfaces-IShellFolder!public! !
!IShellFolder categoriesFor: #BindToStorage:pbc:riid:ppv:!COM Interfaces-IShellFolder!public! !
!IShellFolder categoriesFor: #CompareIDs:pidl1:pidl2:!COM Interfaces-IShellFolder!public! !
!IShellFolder categoriesFor: #CreateViewObject:riid:ppvOut:!COM Interfaces-IShellFolder!public! !
!IShellFolder categoriesFor: #EnumObjects:grfFlags:ppenumIDList:!COM Interfaces-IShellFolder!public! !
!IShellFolder categoriesFor: #GetAttributesOf:apidl:rgfInOut:!COM Interfaces-IShellFolder!public! !
!IShellFolder categoriesFor: #GetDisplayNameOf:uFlags:lpName:!COM Interfaces-IShellFolder!public! !
!IShellFolder categoriesFor: #GetUIObjectOf:cidl:apidl:riid:prgfInOut:ppvOut:!COM Interfaces-IShellFolder!public! !
!IShellFolder categoriesFor: #idlFromPath:!public! !
!IShellFolder categoriesFor: #ParseDisplayName:pbc:lpwszDisplayName:pchEaten:ppidl:pdwAttributes:!COM Interfaces-IShellFolder!public! !
!IShellFolder categoriesFor: #pidlFromPath:!operations!public! !
!IShellFolder categoriesFor: #SetNameOf:pidl:lpszName:uFlags:ppidlOut:!COM Interfaces-IShellFolder!public! !

!IShellFolder class methodsFor!

defineFunctions
	"Declare the virtual function table for the COM interface IShellFolder
		IShellFolder compileFunctions
	"

	self
		defineFunction: #ParseDisplayName:pbc:lpwszDisplayName:pchEaten:ppidl:pdwAttributes:
			argumentTypes: 'handle void* lpwstr dword* lppvoid dword*';
		defineFunction: #EnumObjects:grfFlags:ppenumIDList:
			argumentTypes: 'handle dword lppvoid';
		defineFunction: #BindToObject:pbc:riid:ppvOut:
			argumentTypes: 'lpvoid void* GUID* lppvoid';
		defineFunction: #BindToStorage:pbc:riid:ppv:
			argumentTypes: 'lpvoid void* GUID* lppvoid';
		defineFunction: #CompareIDs:pidl1:pidl2:
			argumentTypes: 'dword lpvoid lpvoid';
		defineFunction: #CreateViewObject:riid:ppvOut:
			argumentTypes: 'handle GUID* lppvoid';
		defineFunction: #GetAttributesOf:apidl:rgfInOut:
			argumentTypes: 'dword lppvoid dword*';
		defineFunction: #GetUIObjectOf:cidl:apidl:riid:prgfInOut:ppvOut:
			argumentTypes: 'handle dword lppvoid GUID* dword* lppvoid';
		defineFunction: #GetDisplayNameOf:uFlags:lpName:
			argumentTypes: 'lpvoid dword lpvoid';
		defineFunction: #SetNameOf:pidl:lpszName:uFlags:ppidlOut:
			argumentTypes: 'handle lpvoid lpwstr dword lppvoid'
! !
!IShellFolder class categoriesFor: #defineFunctions!initializing!public! !

