/*
 * A n t l r  T r a n s l a t i o n  H e a d e r
 *
 * Terence Parr, Will Cohen, and Hank Dietz: 1989-1998
 * Purdue University Electrical Engineering
 * With AHPCRC, University of Minnesota
 * ANTLR Version 1.33MR14
 *
 *   antlr -gl -fe gkm_errors.m gkm.g
 *
 */

#define ANTLR_VERSION	13314
#include "pcctscfg.h"
#include PCCTS_STDIO_H
#line 1 "gkm.g"

#import <Foundation/Foundation.h>
#import "GKMAttribute.h"
#import "GKModuleParser.h"
#define zzSET_SIZE 8
#include "antlr.h"
#include "tokens.h"
#include "dlgdef.h"
#include "mode.h"
#ifndef PURIFY
#define PURIFY(r,s) memset((char *) &(r),'\0',(s));
#endif
ANTLR_INFO
#line 11 "gkm.g"

extern GKModuleParser *activeParser;

void
#ifdef __USE_PROTOS
gkmodule(void)
#else
gkmodule()
#endif
{
#line 119 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 120 "gkm.g"
	zzmatch(TOK_BEGIN_MODULE);
#line 120 "gkm.g"
	[activeParser enterModule];
 zzCONSUME;

#line 121 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (setwd1[LA(1)]&0x1) ) {
#line 121 "gkm.g"
			topLevelElement();
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
#line 122 "gkm.g"
	zzmatch(TOK_END_MODULE);
#line 122 "gkm.g"
	[activeParser leaveModule];
 zzCONSUME;

#line 123 "gkm.g"
	zzmatch(1); zzCONSUME;
	zzEXIT(zztasp1);
	return;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd1, 0x2);
	}
}

void
#ifdef __USE_PROTOS
element(void)
#else
element()
#endif
{
#line 126 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 127 "gkm.g"
	genericElement();
	zzEXIT(zztasp1);
	return;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd1, 0x4);
	}
}

void
#ifdef __USE_PROTOS
topLevelElement(void)
#else
topLevelElement()
#endif
{
#line 130 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
	if ( (LA(1)==BEGIN_TAG) ) {
#line 131 "gkm.g"
		element();
	}
	else {
		if ( (LA(1)==BEGIN_REFERENCE_TAG) ) {
#line 132 "gkm.g"
			referenceElement();
		}
		else {zzFAIL(1,zzerr1,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
	}
	zzEXIT(zztasp1);
	return;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd1, 0x8);
	}
}

void
#ifdef __USE_PROTOS
assignElement(void)
#else
assignElement()
#endif
{
#line 135 "gkm.g"
	zzRULE;
	Attrib at, i;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 136 "gkm.g"
	id value = nil;
#line 137 "gkm.g"
	zzmatch(BEGIN_ASSIGN_TAG);
	at = zzaCur;
 zzCONSUME;
#line 138 "gkm.g"
	zzmatch(IDENTIFIER);
	i = zzaCur;
 zzCONSUME;
#line 139 "gkm.g"
	zzmatch(TOK_ASSIGN); zzCONSUME;
#line 140 "gkm.g"
	 value  = attributeValue( [ i text] );

#line 141 "gkm.g"
	zzmatch(END_EMPTY_TAG);
#line 142 "gkm.g"
	[activeParser applyAssignment: at assign:value to: i];
 zzCONSUME;

	zzEXIT(zztasp1);
	return;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd1, 0x10);
	}
}

void
#ifdef __USE_PROTOS
referenceElement(void)
#else
referenceElement()
#endif
{
#line 145 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 146 "gkm.g"
	
	NSDictionary *al = nil;
#line 149 "gkm.g"
	zzmatch(BEGIN_REFERENCE_TAG);
#line 149 "gkm.g"
	[activeParser beginReferenceElement];
 zzCONSUME;

#line 150 "gkm.g"
	attributeList();
#line 151 "gkm.g"
	zzmatch(END_TAG); zzCONSUME;
#line 152 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (LA(1)==BEGIN_ASSIGN_TAG) ) {
#line 152 "gkm.g"
			assignElement();
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
#line 153 "gkm.g"
	zzmatch(REFERENCE_CLOSETAG);
#line 153 "gkm.g"
	[activeParser endReferenceElement];
 zzCONSUME;

	zzEXIT(zztasp1);
	return;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd1, 0x20);
	}
}

void
#ifdef __USE_PROTOS
genericElement(void)
#else
genericElement()
#endif
{
#line 156 "gkm.g"
	zzRULE;
	Attrib bi, ci;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 157 "gkm.g"
	
#line 158 "gkm.g"
	zzmatch(BEGIN_TAG); zzCONSUME;
#line 158 "gkm.g"
	zzmatch(IDENTIFIER);
	bi = zzaCur;

#line 158 "gkm.g"
	[activeParser beginGenericElement: bi];
 zzCONSUME;

#line 159 "gkm.g"
	attributeList();
#line 160 "gkm.g"
	[activeParser startGenericElement: bi];
#line 161 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		if ( (LA(1)==END_EMPTY_TAG) ) {
#line 161 "gkm.g"
			zzmatch(END_EMPTY_TAG); zzCONSUME;
		}
		else {
			if ( (LA(1)==END_TAG) ) {
#line 162 "gkm.g"
				zzmatch(END_TAG);
#line 163 "gkm.g"
				[activeParser beginGenericElementContent: bi];
 zzCONSUME;

#line 166 "gkm.g"
				{
					zzBLOCK(zztasp3);
					zzMake0;
					{
					while ( 1 ) {
						if ( !((setwd1[LA(1)]&0x40))) break;
						if ( (LA(1)==BEGIN_TAG) ) {
#line 164 "gkm.g"
							element();
						}
						else {
							if ( (LA(1)==BEGIN_ASSIGN_TAG) ) {
#line 165 "gkm.g"
								assignElement();
							}
							else break; /* MR6 code for exiting loop "for sure" */
						}
						zzLOOP(zztasp3);
					}
					zzEXIT(zztasp3);
					}
				}
#line 167 "gkm.g"
				[activeParser endGenericElementContent: bi];
#line 168 "gkm.g"
				zzmatch(BEGIN_CLOSETAG); zzCONSUME;
#line 169 "gkm.g"
				zzmatch(IDENTIFIER);
				ci = zzaCur;
 zzCONSUME;
#line 170 "gkm.g"
				zzmatch(END_TAG); zzCONSUME;
			}
			else {zzFAIL(1,zzerr2,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
		}
		zzEXIT(zztasp2);
		}
	}
#line 172 "gkm.g"
	[activeParser endGenericElement: bi];
	zzEXIT(zztasp1);
	return;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd1, 0x80);
	}
}

 id  
#ifdef __USE_PROTOS
specialAttributeValues( NSString *a )
#else
specialAttributeValues(a)
 NSString *a ;
#endif
{
	 id  	 _retv;
#line 175 "gkm.g"
	zzRULE;
	Attrib pa, pl;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
	if ( (LA(1)==ATTRVALUE_AUTOMATIC) ) {
#line 176 "gkm.g"
		zzmatch(ATTRVALUE_AUTOMATIC);
		pa = zzaCur;

#line 176 "gkm.g"
		_retv=[activeParser valueForAutomatic: pa attribute: a];
 zzCONSUME;

	}
	else {
		if ( (LA(1)==ATTRVALUE_ALWAYS) ) {
#line 177 "gkm.g"
			zzmatch(ATTRVALUE_ALWAYS);
			pl = zzaCur;

#line 177 "gkm.g"
			_retv=[activeParser valueForAlways: pl    attribute: a];
 zzCONSUME;

		}
		else {zzFAIL(1,zzerr3,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
	}
	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd2, 0x1);
	return _retv;
	}
}

 id  
#ifdef __USE_PROTOS
compoundAttributeValues( NSString *a )
#else
compoundAttributeValues(a)
 NSString *a ;
#endif
{
	 id  	 _retv;
#line 180 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
	if ( (LA(1)==BEGIN_LAYOUT) ) {
#line 181 "gkm.g"
		 _retv  = layoutValue();

	}
	else {
		if ( (setwd2[LA(1)]&0x2) ) {
#line 182 "gkm.g"
			 _retv  = compoundProperty();

		}
		else {zzFAIL(1,zzerr4,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
	}
	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd2, 0x4);
	return _retv;
	}
}

 id  
#ifdef __USE_PROTOS
basicAttributeValues( NSString *a )
#else
basicAttributeValues(a)
 NSString *a ;
#endif
{
	 id  	 _retv;
#line 185 "gkm.g"
	zzRULE;
	Attrib s, i, f, r, e, n, y;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
	if ( (LA(1)==STRING) ) {
#line 186 "gkm.g"
		zzmatch(STRING);
		s = zzaCur;

#line 186 "gkm.g"
		_retv = [activeParser valueForString: s    attribute: a];
 zzCONSUME;

	}
	else {
		if ( (LA(1)==INTEGER) ) {
#line 187 "gkm.g"
			zzmatch(INTEGER);
			i = zzaCur;

#line 187 "gkm.g"
			_retv = [activeParser valueForInt: i       attribute: a];
 zzCONSUME;

		}
		else {
			if ( (LA(1)==FLOAT) ) {
#line 188 "gkm.g"
				zzmatch(FLOAT);
				f = zzaCur;

#line 188 "gkm.g"
				_retv = [activeParser valueForFloat: f     attribute: a];
 zzCONSUME;

			}
			else {
				if ( (LA(1)==ID_REFERENCE) ) {
#line 189 "gkm.g"
					zzmatch(ID_REFERENCE);
					r = zzaCur;

#line 189 "gkm.g"
					_retv = [activeParser valueForReference: r attribute: a];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==SELECTOR) ) {
#line 190 "gkm.g"
						zzmatch(SELECTOR);
						e = zzaCur;

#line 190 "gkm.g"
						_retv = [activeParser valueForSelector: e  attribute: a];
 zzCONSUME;

					}
					else {
						if ( (LA(1)==ATTRVALUE_NO) ) {
#line 191 "gkm.g"
							zzmatch(ATTRVALUE_NO);
							n = zzaCur;

#line 191 "gkm.g"
							_retv = [activeParser valueForBool: n      attribute: a];
 zzCONSUME;

						}
						else {
							if ( (LA(1)==ATTRVALUE_YES) ) {
#line 192 "gkm.g"
								zzmatch(ATTRVALUE_YES);
								y = zzaCur;

#line 192 "gkm.g"
								_retv = [activeParser valueForBool: y      attribute: a];
 zzCONSUME;

							}
							else {zzFAIL(1,zzerr5,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
						}
					}
				}
			}
		}
	}
	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd2, 0x8);
	return _retv;
	}
}

 id  
#ifdef __USE_PROTOS
attributeValue( NSString *a )
#else
attributeValue(a)
 NSString *a ;
#endif
{
	 id  	 _retv;
#line 195 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
	if ( (setwd2[LA(1)]&0x10) ) {
#line 196 "gkm.g"
		 _retv  = basicAttributeValues(  a );

	}
	else {
		if ( (setwd2[LA(1)]&0x20) ) {
#line 197 "gkm.g"
			 _retv  = specialAttributeValues(  a );

		}
		else {
			if ( (setwd2[LA(1)]&0x40) ) {
#line 198 "gkm.g"
				 _retv  = compoundAttributeValues(  a );

			}
			else {zzFAIL(1,zzerr6,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
		}
	}
	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd2, 0x80);
	return _retv;
	}
}

void
#ifdef __USE_PROTOS
attributePair(void)
#else
attributePair()
#endif
{
#line 201 "gkm.g"
	zzRULE;
	Attrib aki, ais, gi, gs, px, py, pw, ph, pi;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 202 "gkm.g"
	id value = nil;
	if ( (LA(1)==ATTRKEY_ID) ) {
#line 203 "gkm.g"
		zzmatch(ATTRKEY_ID); zzCONSUME;
#line 204 "gkm.g"
		zzmatch(TOK_ASSIGN); zzCONSUME;
#line 205 "gkm.g"
		{
			zzBLOCK(zztasp2);
			zzMake0;
			{
			if ( (LA(1)==IDENTIFIER) ) {
#line 205 "gkm.g"
				zzmatch(IDENTIFIER);
				aki = zzaCur;

#line 205 "gkm.g"
				value = [aki text];
 zzCONSUME;

			}
			else {
				if ( (LA(1)==STRING) ) {
#line 206 "gkm.g"
					zzmatch(STRING);
					ais = zzaCur;

#line 206 "gkm.g"
					value = [ais text];
 zzCONSUME;

				}
				else {zzFAIL(1,zzerr7,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
			}
			zzEXIT(zztasp2);
			}
		}
#line 208 "gkm.g"
		[activeParser setElementName:value];
	}
	else {
		if ( (LA(1)==ATTRKEY_GROUP) ) {
#line 209 "gkm.g"
			zzmatch(ATTRKEY_GROUP); zzCONSUME;
#line 210 "gkm.g"
			zzmatch(TOK_ASSIGN); zzCONSUME;
#line 211 "gkm.g"
			{
				zzBLOCK(zztasp2);
				zzMake0;
				{
				if ( (LA(1)==IDENTIFIER) ) {
#line 211 "gkm.g"
					zzmatch(IDENTIFIER);
					gi = zzaCur;

#line 211 "gkm.g"
					value = [gi text];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==STRING) ) {
#line 212 "gkm.g"
						zzmatch(STRING);
						gs = zzaCur;

#line 212 "gkm.g"
						value = [gs text];
 zzCONSUME;

					}
					else {zzFAIL(1,zzerr8,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
				}
				zzEXIT(zztasp2);
				}
			}
#line 214 "gkm.g"
			[activeParser setElementRadioGroup:value];
		}
		else {
			if ( (LA(1)==ATTRKEY_POSITION) ) {
#line 215 "gkm.g"
				zzmatch(ATTRKEY_POSITION); zzCONSUME;
#line 216 "gkm.g"
				zzmatch(TOK_ASSIGN); zzCONSUME;
#line 217 "gkm.g"
				zzmatch(BEGIN_LAYOUT); zzCONSUME;
#line 217 "gkm.g"
				zzmatch(INTEGER);
				px = zzaCur;
 zzCONSUME;
#line 217 "gkm.g"
				zzmatch(INTEGER);
				py = zzaCur;
 zzCONSUME;
#line 217 "gkm.g"
				zzmatch(END_LAYOUT);
#line 218 "gkm.g"
				[activeParser setElementPosition:
				[[ px text] intValue]:[[ py text] intValue]];
 zzCONSUME;

			}
			else {
				if ( (LA(1)==ATTRKEY_SIZE) ) {
#line 220 "gkm.g"
					zzmatch(ATTRKEY_SIZE); zzCONSUME;
#line 221 "gkm.g"
					zzmatch(TOK_ASSIGN); zzCONSUME;
#line 222 "gkm.g"
					zzmatch(BEGIN_LAYOUT); zzCONSUME;
#line 222 "gkm.g"
					zzmatch(INTEGER);
					pw = zzaCur;
 zzCONSUME;
#line 222 "gkm.g"
					zzmatch(INTEGER);
					ph = zzaCur;
 zzCONSUME;
#line 222 "gkm.g"
					zzmatch(END_LAYOUT);
#line 223 "gkm.g"
					[activeParser setElementSize:[[ pw text] intValue]:[[ ph text] intValue]];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==IDENTIFIER) ) {
#line 224 "gkm.g"
						zzmatch(IDENTIFIER);
						pi = zzaCur;
 zzCONSUME;
#line 225 "gkm.g"
						zzmatch(TOK_ASSIGN); zzCONSUME;
#line 226 "gkm.g"
						 value  = attributeValue( [ pi text] );

#line 227 "gkm.g"
						[activeParser setValue:value forProperty: pi];
					}
					else {zzFAIL(1,zzerr9,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
				}
			}
		}
	}
	zzEXIT(zztasp1);
	return;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd3, 0x1);
	}
}

void
#ifdef __USE_PROTOS
attributeList(void)
#else
attributeList()
#endif
{
#line 230 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 231 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (setwd3[LA(1)]&0x2) ) {
#line 231 "gkm.g"
			attributePair();
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
	zzEXIT(zztasp1);
	return;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd3, 0x4);
	}
}

 id  
#ifdef __USE_PROTOS
layoutValue(void)
#else
layoutValue()
#endif
{
	 id  	 _retv;
#line 234 "gkm.g"
	zzRULE;
	Attrib pi, as, ai, af, an, ay;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
#line 235 "gkm.g"
	
	NSMutableDictionary *al = [NSMutableDictionary dictionaryWithCapacity:8];
	NSString *attrKey    = nil;
	NSString *layoutType = nil;
	id v = nil;
#line 241 "gkm.g"
	zzmatch(BEGIN_LAYOUT); zzCONSUME;
#line 242 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		if ( (LA(1)==LAYOUT_FIXED) ) {
#line 242 "gkm.g"
			zzmatch(LAYOUT_FIXED);
#line 242 "gkm.g"
			layoutType = @"fixed";
 zzCONSUME;

		}
		else {
			if ( (LA(1)==LAYOUT_BOX) ) {
#line 243 "gkm.g"
				zzmatch(LAYOUT_BOX);
#line 243 "gkm.g"
				layoutType = @"box";
 zzCONSUME;

			}
			else {
				if ( (LA(1)==LAYOUT_TABLE) ) {
#line 244 "gkm.g"
					zzmatch(LAYOUT_TABLE);
#line 244 "gkm.g"
					layoutType = @"table";
 zzCONSUME;

				}
				else {zzFAIL(1,zzerr10,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
			}
		}
		zzEXIT(zztasp2);
		}
	}
#line 255 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (LA(1)==IDENTIFIER) ) {
#line 246 "gkm.g"
			zzmatch(IDENTIFIER);
			pi = zzaCur;

#line 246 "gkm.g"
			attrKey = [ pi text];
 zzCONSUME;

#line 247 "gkm.g"
			zzmatch(TOK_ASSIGN); zzCONSUME;
#line 248 "gkm.g"
			{
				zzBLOCK(zztasp3);
				zzMake0;
				{
				if ( (LA(1)==STRING) ) {
#line 248 "gkm.g"
					zzmatch(STRING);
					as = zzaCur;

#line 248 "gkm.g"
					v = [as text];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==INTEGER) ) {
#line 249 "gkm.g"
						zzmatch(INTEGER);
						ai = zzaCur;

#line 249 "gkm.g"
						v = [NSNumber numberWithInt:[[ai text] intValue]];
 zzCONSUME;

					}
					else {
						if ( (LA(1)==FLOAT) ) {
#line 250 "gkm.g"
							zzmatch(FLOAT);
							af = zzaCur;

#line 250 "gkm.g"
							v = [NSNumber numberWithFloat:[[af text] floatValue]];
 zzCONSUME;

						}
						else {
							if ( (LA(1)==ATTRVALUE_NO) ) {
#line 251 "gkm.g"
								zzmatch(ATTRVALUE_NO);
								an = zzaCur;

#line 251 "gkm.g"
								v = [NSNumber numberWithBool:NO];
 zzCONSUME;

							}
							else {
								if ( (LA(1)==ATTRVALUE_YES) ) {
#line 252 "gkm.g"
									zzmatch(ATTRVALUE_YES);
									ay = zzaCur;

#line 252 "gkm.g"
									v = [NSNumber numberWithBool:YES];
 zzCONSUME;

								}
								else {zzFAIL(1,zzerr11,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
							}
						}
					}
				}
				zzEXIT(zztasp3);
				}
			}
#line 254 "gkm.g"
			[al setObject:v forKey:attrKey]; v = nil;
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
#line 256 "gkm.g"
	zzmatch(END_LAYOUT);
#line 257 "gkm.g"
	_retv = [activeParser valueForLayoutType:layoutType values:al];
 zzCONSUME;

	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd3, 0x8);
	return _retv;
	}
}

 id  
#ifdef __USE_PROTOS
arrayProperty(void)
#else
arrayProperty()
#endif
{
	 id  	 _retv;
#line 262 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
#line 263 "gkm.g"
	id obj = nil;
#line 264 "gkm.g"
	zzmatch(TOK_LPAREN); zzCONSUME;
#line 265 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		if ( (LA(1)==TOK_RPAREN) ) {
#line 265 "gkm.g"
			zzmatch(TOK_RPAREN);
#line 265 "gkm.g"
			_retv = [NSArray array];
 zzCONSUME;

		}
		else {
			if ( (setwd3[LA(1)]&0x10) ) {
#line 266 "gkm.g"
				_retv = [NSMutableArray array];
#line 267 "gkm.g"
				 obj  = property();

#line 267 "gkm.g"
				[_retv addObject:obj];
#line 270 "gkm.g"
				{
					zzBLOCK(zztasp3);
					zzMake0;
					{
					while ( (LA(1)==TOK_COMMA) ) {
#line 268 "gkm.g"
						zzmatch(TOK_COMMA); zzCONSUME;
#line 269 "gkm.g"
						 obj  = property();

#line 269 "gkm.g"
						[_retv addObject:obj];
						zzLOOP(zztasp3);
					}
					zzEXIT(zztasp3);
					}
				}
#line 271 "gkm.g"
				zzmatch(TOK_RPAREN); zzCONSUME;
			}
			else {zzFAIL(1,zzerr12,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
		}
		zzEXIT(zztasp2);
		}
	}
	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd3, 0x20);
	return _retv;
	}
}

 id  
#ifdef __USE_PROTOS
dictinaryProperty(void)
#else
dictinaryProperty()
#endif
{
	 id  	 _retv;
#line 275 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
#line 276 "gkm.g"
	id key = nil, value = nil;
#line 277 "gkm.g"
	zzmatch(TOK_LBRACE);
#line 277 "gkm.g"
	_retv = [NSMutableDictionary dictionary];
 zzCONSUME;

#line 283 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (setwd3[LA(1)]&0x40) ) {
#line 279 "gkm.g"
			 key  = stringProperty();

#line 280 "gkm.g"
			zzmatch(TOK_ASSIGN); zzCONSUME;
#line 281 "gkm.g"
			 value  = property();

#line 282 "gkm.g"
			[_retv setObject:value forKey:key];
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
#line 284 "gkm.g"
	zzmatch(TOK_RBRACE); zzCONSUME;
	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd3, 0x80);
	return _retv;
	}
}

 NSString * 
#ifdef __USE_PROTOS
stringProperty(void)
#else
stringProperty()
#endif
{
	 NSString * 	 _retv;
#line 287 "gkm.g"
	zzRULE;
	Attrib i, s;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( NSString * 	))
	zzMake0;
	{
	if ( (LA(1)==IDENTIFIER) ) {
#line 288 "gkm.g"
		zzmatch(IDENTIFIER);
		i = zzaCur;

#line 288 "gkm.g"
		_retv = AUTORELEASE([[ i text] copy]);
 zzCONSUME;

	}
	else {
		if ( (LA(1)==STRING) ) {
#line 289 "gkm.g"
			zzmatch(STRING);
			s = zzaCur;

#line 289 "gkm.g"
			_retv = AUTORELEASE([[ s text] copy]);
 zzCONSUME;

		}
		else {zzFAIL(1,zzerr13,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
	}
	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd4, 0x1);
	return _retv;
	}
}

 id  
#ifdef __USE_PROTOS
property(void)
#else
property()
#endif
{
	 id  	 _retv;
#line 292 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
	if ( (setwd4[LA(1)]&0x2) ) {
#line 293 "gkm.g"
		 _retv  = stringProperty();

	}
	else {
		if ( (setwd4[LA(1)]&0x4) ) {
#line 294 "gkm.g"
			 _retv  = compoundProperty();

		}
		else {zzFAIL(1,zzerr14,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
	}
	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd4, 0x8);
	return _retv;
	}
}

 id  
#ifdef __USE_PROTOS
compoundProperty(void)
#else
compoundProperty()
#endif
{
	 id  	 _retv;
#line 297 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
	if ( (LA(1)==TOK_LPAREN) ) {
#line 298 "gkm.g"
		 _retv  = arrayProperty();

	}
	else {
		if ( (LA(1)==TOK_LBRACE) ) {
#line 299 "gkm.g"
			 _retv  = dictinaryProperty();

		}
		else {zzFAIL(1,zzerr15,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
	}
	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd4, 0x10);
	return _retv;
	}
}
