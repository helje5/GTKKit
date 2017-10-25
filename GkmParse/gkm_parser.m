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
#line 7 "gkm.g"

extern GKModuleParser *activeParser;

void
#ifdef __USE_PROTOS
gkmodule(void)
#else
gkmodule()
#endif
{
#line 95 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 96 "gkm.g"
	zzmatch(TOK_BEGIN_MODULE);
#line 96 "gkm.g"
	[activeParser enterModule];
 zzCONSUME;

#line 97 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (setwd1[LA(1)]&0x1) ) {
#line 97 "gkm.g"
			topLevelElement();
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
#line 98 "gkm.g"
	zzmatch(TOK_END_MODULE);
#line 98 "gkm.g"
	[activeParser leaveModule];
 zzCONSUME;

#line 99 "gkm.g"
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
#line 102 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 103 "gkm.g"
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
#line 106 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
	if ( (LA(1)==BEGIN_TAG) ) {
#line 107 "gkm.g"
		element();
	}
	else {
		if ( (LA(1)==BEGIN_REFERENCE_TAG) ) {
#line 108 "gkm.g"
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
#line 111 "gkm.g"
	zzRULE;
	Attrib at, i;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 112 "gkm.g"
	id value = nil;
#line 113 "gkm.g"
	zzmatch(BEGIN_ASSIGN_TAG);
	at = zzaCur;
 zzCONSUME;
#line 114 "gkm.g"
	zzmatch(IDENTIFIER);
	i = zzaCur;
 zzCONSUME;
#line 115 "gkm.g"
	zzmatch(TOK_ASSIGN); zzCONSUME;
#line 116 "gkm.g"
	 value  = attributeValue();

#line 117 "gkm.g"
	zzmatch(END_EMPTY_TAG);
#line 118 "gkm.g"
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
#line 121 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 122 "gkm.g"
	
	NSDictionary *al = nil;
#line 125 "gkm.g"
	zzmatch(BEGIN_REFERENCE_TAG);
#line 125 "gkm.g"
	[activeParser beginReferenceElement];
 zzCONSUME;

#line 126 "gkm.g"
	attributeList();
#line 127 "gkm.g"
	zzmatch(END_TAG); zzCONSUME;
#line 128 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (LA(1)==BEGIN_ASSIGN_TAG) ) {
#line 128 "gkm.g"
			assignElement();
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
#line 129 "gkm.g"
	zzmatch(REFERENCE_CLOSETAG);
#line 129 "gkm.g"
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
#line 132 "gkm.g"
	zzRULE;
	Attrib bi, ci;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 133 "gkm.g"
	
#line 134 "gkm.g"
	zzmatch(BEGIN_TAG); zzCONSUME;
#line 134 "gkm.g"
	zzmatch(IDENTIFIER);
	bi = zzaCur;

#line 134 "gkm.g"
	[activeParser beginGenericElement: bi];
 zzCONSUME;

#line 135 "gkm.g"
	attributeList();
#line 136 "gkm.g"
	[activeParser startGenericElement: bi];
#line 137 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		if ( (LA(1)==END_EMPTY_TAG) ) {
#line 137 "gkm.g"
			zzmatch(END_EMPTY_TAG); zzCONSUME;
		}
		else {
			if ( (LA(1)==END_TAG) ) {
#line 138 "gkm.g"
				zzmatch(END_TAG);
#line 139 "gkm.g"
				[activeParser beginGenericElementContent: bi];
 zzCONSUME;

#line 142 "gkm.g"
				{
					zzBLOCK(zztasp3);
					zzMake0;
					{
					while ( 1 ) {
						if ( !((setwd1[LA(1)]&0x40))) break;
						if ( (LA(1)==BEGIN_TAG) ) {
#line 140 "gkm.g"
							element();
						}
						else {
							if ( (LA(1)==BEGIN_ASSIGN_TAG) ) {
#line 141 "gkm.g"
								assignElement();
							}
							else break; /* MR6 code for exiting loop "for sure" */
						}
						zzLOOP(zztasp3);
					}
					zzEXIT(zztasp3);
					}
				}
#line 143 "gkm.g"
				[activeParser endGenericElementContent: bi];
#line 144 "gkm.g"
				zzmatch(BEGIN_CLOSETAG); zzCONSUME;
#line 145 "gkm.g"
				zzmatch(IDENTIFIER);
				ci = zzaCur;
 zzCONSUME;
#line 146 "gkm.g"
				zzmatch(END_TAG); zzCONSUME;
			}
			else {zzFAIL(1,zzerr2,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
		}
		zzEXIT(zztasp2);
		}
	}
#line 148 "gkm.g"
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
attributeValue(void)
#else
attributeValue()
#endif
{
	 id  	 _retv;
#line 151 "gkm.g"
	zzRULE;
	Attrib s, i, f, r, e, n, y, pa, pl;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
	if ( (LA(1)==STRING) ) {
#line 152 "gkm.g"
		zzmatch(STRING);
		s = zzaCur;

#line 152 "gkm.g"
		_retv = [activeParser valueForStringAttribute: s];
 zzCONSUME;

	}
	else {
		if ( (LA(1)==INTEGER) ) {
#line 153 "gkm.g"
			zzmatch(INTEGER);
			i = zzaCur;

#line 153 "gkm.g"
			_retv = [activeParser valueForIntAttribute: i];
 zzCONSUME;

		}
		else {
			if ( (LA(1)==FLOAT) ) {
#line 154 "gkm.g"
				zzmatch(FLOAT);
				f = zzaCur;

#line 154 "gkm.g"
				_retv = [activeParser valueForFloatAttribute: f];
 zzCONSUME;

			}
			else {
				if ( (LA(1)==ID_REFERENCE) ) {
#line 155 "gkm.g"
					zzmatch(ID_REFERENCE);
					r = zzaCur;

#line 155 "gkm.g"
					_retv = [activeParser valueForReferenceAttribute: r];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==SELECTOR) ) {
#line 156 "gkm.g"
						zzmatch(SELECTOR);
						e = zzaCur;

#line 156 "gkm.g"
						_retv = [activeParser valueForSelectorAttribute: e];
 zzCONSUME;

					}
					else {
						if ( (LA(1)==ATTRVALUE_NO) ) {
#line 157 "gkm.g"
							zzmatch(ATTRVALUE_NO);
							n = zzaCur;

#line 157 "gkm.g"
							_retv = [activeParser valueForBoolAttribute: n];
 zzCONSUME;

						}
						else {
							if ( (LA(1)==ATTRVALUE_YES) ) {
#line 158 "gkm.g"
								zzmatch(ATTRVALUE_YES);
								y = zzaCur;

#line 158 "gkm.g"
								_retv = [activeParser valueForBoolAttribute: y];
 zzCONSUME;

							}
							else {
								if ( (LA(1)==ATTRVALUE_AUTOMATIC) ) {
#line 159 "gkm.g"
									zzmatch(ATTRVALUE_AUTOMATIC);
									pa = zzaCur;

#line 159 "gkm.g"
									_retv = [activeParser valueForAutomaticAttribute: pa];
 zzCONSUME;

								}
								else {
									if ( (LA(1)==ATTRVALUE_ALWAYS) ) {
#line 160 "gkm.g"
										zzmatch(ATTRVALUE_ALWAYS);
										pl = zzaCur;

#line 160 "gkm.g"
										_retv = [activeParser valueForAlwaysAttribute: pl];
 zzCONSUME;

									}
									else {
										if ( (LA(1)==BEGIN_LAYOUT) ) {
#line 161 "gkm.g"
											 _retv  = layoutValue();

										}
										else {zzFAIL(1,zzerr3,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
									}
								}
							}
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
	zzresynch(setwd2, 0x1);
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
#line 164 "gkm.g"
	zzRULE;
	Attrib aki, ais, gi, gs, px, py, pw, ph, pi;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 165 "gkm.g"
	id value = nil;
	if ( (LA(1)==ATTRKEY_ID) ) {
#line 166 "gkm.g"
		zzmatch(ATTRKEY_ID); zzCONSUME;
#line 167 "gkm.g"
		zzmatch(TOK_ASSIGN); zzCONSUME;
#line 168 "gkm.g"
		{
			zzBLOCK(zztasp2);
			zzMake0;
			{
			if ( (LA(1)==IDENTIFIER) ) {
#line 168 "gkm.g"
				zzmatch(IDENTIFIER);
				aki = zzaCur;

#line 168 "gkm.g"
				value = [aki text];
 zzCONSUME;

			}
			else {
				if ( (LA(1)==STRING) ) {
#line 169 "gkm.g"
					zzmatch(STRING);
					ais = zzaCur;

#line 169 "gkm.g"
					value = [ais text];
 zzCONSUME;

				}
				else {zzFAIL(1,zzerr4,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
			}
			zzEXIT(zztasp2);
			}
		}
#line 171 "gkm.g"
		[activeParser setElementName:value];
	}
	else {
		if ( (LA(1)==ATTRKEY_GROUP) ) {
#line 172 "gkm.g"
			zzmatch(ATTRKEY_GROUP); zzCONSUME;
#line 173 "gkm.g"
			zzmatch(TOK_ASSIGN); zzCONSUME;
#line 174 "gkm.g"
			{
				zzBLOCK(zztasp2);
				zzMake0;
				{
				if ( (LA(1)==IDENTIFIER) ) {
#line 174 "gkm.g"
					zzmatch(IDENTIFIER);
					gi = zzaCur;

#line 174 "gkm.g"
					value = [gi text];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==STRING) ) {
#line 175 "gkm.g"
						zzmatch(STRING);
						gs = zzaCur;

#line 175 "gkm.g"
						value = [gs text];
 zzCONSUME;

					}
					else {zzFAIL(1,zzerr5,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
				}
				zzEXIT(zztasp2);
				}
			}
#line 177 "gkm.g"
			[activeParser setElementRadioGroup:value];
		}
		else {
			if ( (LA(1)==ATTRKEY_POSITION) ) {
#line 178 "gkm.g"
				zzmatch(ATTRKEY_POSITION); zzCONSUME;
#line 179 "gkm.g"
				zzmatch(TOK_ASSIGN); zzCONSUME;
#line 180 "gkm.g"
				zzmatch(BEGIN_LAYOUT); zzCONSUME;
#line 180 "gkm.g"
				zzmatch(INTEGER);
				px = zzaCur;
 zzCONSUME;
#line 180 "gkm.g"
				zzmatch(INTEGER);
				py = zzaCur;
 zzCONSUME;
#line 180 "gkm.g"
				zzmatch(END_LAYOUT);
#line 181 "gkm.g"
				[activeParser setElementPosition:[[ px text] intValue]:[[ py text] intValue]];
 zzCONSUME;

			}
			else {
				if ( (LA(1)==ATTRKEY_SIZE) ) {
#line 182 "gkm.g"
					zzmatch(ATTRKEY_SIZE); zzCONSUME;
#line 183 "gkm.g"
					zzmatch(TOK_ASSIGN); zzCONSUME;
#line 184 "gkm.g"
					zzmatch(BEGIN_LAYOUT); zzCONSUME;
#line 184 "gkm.g"
					zzmatch(INTEGER);
					pw = zzaCur;
 zzCONSUME;
#line 184 "gkm.g"
					zzmatch(INTEGER);
					ph = zzaCur;
 zzCONSUME;
#line 184 "gkm.g"
					zzmatch(END_LAYOUT);
#line 185 "gkm.g"
					[activeParser setElementSize:[[ pw text] intValue]:[[ ph text] intValue]];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==IDENTIFIER) ) {
#line 186 "gkm.g"
						zzmatch(IDENTIFIER);
						pi = zzaCur;
 zzCONSUME;
#line 187 "gkm.g"
						zzmatch(TOK_ASSIGN); zzCONSUME;
#line 188 "gkm.g"
						 value  = attributeValue();

#line 189 "gkm.g"
						[activeParser setValue:value forProperty: pi];
					}
					else {zzFAIL(1,zzerr6,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
				}
			}
		}
	}
	zzEXIT(zztasp1);
	return;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd2, 0x2);
	}
}

void
#ifdef __USE_PROTOS
attributeList(void)
#else
attributeList()
#endif
{
#line 192 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 193 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (setwd2[LA(1)]&0x4) ) {
#line 193 "gkm.g"
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
	zzresynch(setwd2, 0x8);
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
#line 196 "gkm.g"
	zzRULE;
	Attrib pi, as, ai, af, an, ay;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
#line 197 "gkm.g"
	
	NSMutableDictionary *al = [NSMutableDictionary dictionaryWithCapacity:8];
	NSString *attrKey    = nil;
	NSString *layoutType = nil;
	id v = nil;
#line 203 "gkm.g"
	zzmatch(BEGIN_LAYOUT); zzCONSUME;
#line 204 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		if ( (LA(1)==LAYOUT_FIXED) ) {
#line 204 "gkm.g"
			zzmatch(LAYOUT_FIXED);
#line 204 "gkm.g"
			layoutType = @"fixed";
 zzCONSUME;

		}
		else {
			if ( (LA(1)==LAYOUT_BOX) ) {
#line 205 "gkm.g"
				zzmatch(LAYOUT_BOX);
#line 205 "gkm.g"
				layoutType = @"box";
 zzCONSUME;

			}
			else {
				if ( (LA(1)==LAYOUT_TABLE) ) {
#line 206 "gkm.g"
					zzmatch(LAYOUT_TABLE);
#line 206 "gkm.g"
					layoutType = @"table";
 zzCONSUME;

				}
				else {zzFAIL(1,zzerr7,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
			}
		}
		zzEXIT(zztasp2);
		}
	}
#line 217 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (LA(1)==IDENTIFIER) ) {
#line 208 "gkm.g"
			zzmatch(IDENTIFIER);
			pi = zzaCur;

#line 208 "gkm.g"
			attrKey = [ pi text];
 zzCONSUME;

#line 209 "gkm.g"
			zzmatch(TOK_ASSIGN); zzCONSUME;
#line 210 "gkm.g"
			{
				zzBLOCK(zztasp3);
				zzMake0;
				{
				if ( (LA(1)==STRING) ) {
#line 210 "gkm.g"
					zzmatch(STRING);
					as = zzaCur;

#line 210 "gkm.g"
					v = [as text];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==INTEGER) ) {
#line 211 "gkm.g"
						zzmatch(INTEGER);
						ai = zzaCur;

#line 211 "gkm.g"
						v = [NSNumber numberWithInt:[[ai text] intValue]];
 zzCONSUME;

					}
					else {
						if ( (LA(1)==FLOAT) ) {
#line 212 "gkm.g"
							zzmatch(FLOAT);
							af = zzaCur;

#line 212 "gkm.g"
							v = [NSNumber numberWithFloat:[[af text] floatValue]];
 zzCONSUME;

						}
						else {
							if ( (LA(1)==ATTRVALUE_NO) ) {
#line 213 "gkm.g"
								zzmatch(ATTRVALUE_NO);
								an = zzaCur;

#line 213 "gkm.g"
								v = [NSNumber numberWithBool:NO];
 zzCONSUME;

							}
							else {
								if ( (LA(1)==ATTRVALUE_YES) ) {
#line 214 "gkm.g"
									zzmatch(ATTRVALUE_YES);
									ay = zzaCur;

#line 214 "gkm.g"
									v = [NSNumber numberWithBool:YES];
 zzCONSUME;

								}
								else {zzFAIL(1,zzerr8,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
							}
						}
					}
				}
				zzEXIT(zztasp3);
				}
			}
#line 216 "gkm.g"
			[al setObject:v forKey:attrKey]; v = nil;
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
#line 218 "gkm.g"
	zzmatch(END_LAYOUT);
#line 219 "gkm.g"
	_retv = [activeParser valueForLayoutType:layoutType values:al];
 zzCONSUME;

	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd2, 0x10);
	return _retv;
	}
}
