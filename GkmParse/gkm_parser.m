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
#line 93 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 94 "gkm.g"
	zzmatch(TOK_BEGIN_MODULE);
#line 94 "gkm.g"
	[activeParser enterModule];
 zzCONSUME;

#line 95 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (setwd1[LA(1)]&0x1) ) {
#line 95 "gkm.g"
			topLevelElement();
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
#line 96 "gkm.g"
	zzmatch(TOK_END_MODULE);
#line 96 "gkm.g"
	[activeParser leaveModule];
 zzCONSUME;

#line 97 "gkm.g"
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
#line 100 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 101 "gkm.g"
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
#line 104 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
	if ( (LA(1)==BEGIN_TAG) ) {
#line 105 "gkm.g"
		element();
	}
	else {
		if ( (LA(1)==BEGIN_OBJECT_TAG) ) {
#line 106 "gkm.g"
			objectElement();
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
#line 109 "gkm.g"
	zzRULE;
	Attrib at, i;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 110 "gkm.g"
	id value = nil;
#line 111 "gkm.g"
	zzmatch(BEGIN_ASSIGN_TAG);
	at = zzaCur;
 zzCONSUME;
#line 112 "gkm.g"
	zzmatch(IDENTIFIER);
	i = zzaCur;
 zzCONSUME;
#line 113 "gkm.g"
	zzmatch(TOK_ASSIGN); zzCONSUME;
#line 114 "gkm.g"
	 value  = attributeValue();

#line 115 "gkm.g"
	zzmatch(END_EMPTY_TAG);
#line 116 "gkm.g"
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
objectElement(void)
#else
objectElement()
#endif
{
#line 119 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 120 "gkm.g"
	
	NSDictionary *al = nil;
#line 123 "gkm.g"
	zzmatch(BEGIN_OBJECT_TAG);
#line 123 "gkm.g"
	[activeParser beginObjectElement];
 zzCONSUME;

#line 124 "gkm.g"
	attributeList();
#line 125 "gkm.g"
	zzmatch(END_TAG); zzCONSUME;
#line 126 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (LA(1)==BEGIN_ASSIGN_TAG) ) {
#line 126 "gkm.g"
			assignElement();
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
#line 127 "gkm.g"
	zzmatch(OBJECT_CLOSETAG);
#line 127 "gkm.g"
	[activeParser endObjectElement];
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
#line 130 "gkm.g"
	zzRULE;
	Attrib bi, ci;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 131 "gkm.g"
	
#line 132 "gkm.g"
	zzmatch(BEGIN_TAG); zzCONSUME;
#line 132 "gkm.g"
	zzmatch(IDENTIFIER);
	bi = zzaCur;

#line 132 "gkm.g"
	[activeParser beginGenericElement: bi];
 zzCONSUME;

#line 133 "gkm.g"
	attributeList();
#line 134 "gkm.g"
	[activeParser startGenericElement: bi];
#line 135 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		if ( (LA(1)==END_EMPTY_TAG) ) {
#line 135 "gkm.g"
			zzmatch(END_EMPTY_TAG); zzCONSUME;
		}
		else {
			if ( (LA(1)==END_TAG) ) {
#line 136 "gkm.g"
				zzmatch(END_TAG);
#line 137 "gkm.g"
				[activeParser beginGenericElementContent: bi];
 zzCONSUME;

#line 139 "gkm.g"
				{
					zzBLOCK(zztasp3);
					zzMake0;
					{
					while ( (LA(1)==BEGIN_TAG) ) {
#line 138 "gkm.g"
						element();
						zzLOOP(zztasp3);
					}
					zzEXIT(zztasp3);
					}
				}
#line 140 "gkm.g"
				[activeParser endGenericElementContent: bi];
#line 141 "gkm.g"
				zzmatch(BEGIN_CLOSETAG); zzCONSUME;
#line 142 "gkm.g"
				zzmatch(IDENTIFIER);
				ci = zzaCur;
 zzCONSUME;
#line 143 "gkm.g"
				zzmatch(END_TAG); zzCONSUME;
			}
			else {zzFAIL(1,zzerr2,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
		}
		zzEXIT(zztasp2);
		}
	}
#line 145 "gkm.g"
	[activeParser endGenericElement: bi];
	zzEXIT(zztasp1);
	return;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd1, 0x40);
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
#line 148 "gkm.g"
	zzRULE;
	Attrib s, i, f, r, e, n, y, pa, pl;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
	if ( (LA(1)==STRING) ) {
#line 149 "gkm.g"
		zzmatch(STRING);
		s = zzaCur;

#line 149 "gkm.g"
		_retv = [activeParser valueForStringAttribute: s];
 zzCONSUME;

	}
	else {
		if ( (LA(1)==INTEGER) ) {
#line 150 "gkm.g"
			zzmatch(INTEGER);
			i = zzaCur;

#line 150 "gkm.g"
			_retv = [activeParser valueForIntAttribute: i];
 zzCONSUME;

		}
		else {
			if ( (LA(1)==FLOAT) ) {
#line 151 "gkm.g"
				zzmatch(FLOAT);
				f = zzaCur;

#line 151 "gkm.g"
				_retv = [activeParser valueForFloatAttribute: f];
 zzCONSUME;

			}
			else {
				if ( (LA(1)==ID_REFERENCE) ) {
#line 152 "gkm.g"
					zzmatch(ID_REFERENCE);
					r = zzaCur;

#line 152 "gkm.g"
					_retv = [activeParser valueForReferenceAttribute: r];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==SELECTOR) ) {
#line 153 "gkm.g"
						zzmatch(SELECTOR);
						e = zzaCur;

#line 153 "gkm.g"
						_retv = [activeParser valueForSelectorAttribute: e];
 zzCONSUME;

					}
					else {
						if ( (LA(1)==ATTRVALUE_NO) ) {
#line 154 "gkm.g"
							zzmatch(ATTRVALUE_NO);
							n = zzaCur;

#line 154 "gkm.g"
							_retv = [activeParser valueForBoolAttribute: n];
 zzCONSUME;

						}
						else {
							if ( (LA(1)==ATTRVALUE_YES) ) {
#line 155 "gkm.g"
								zzmatch(ATTRVALUE_YES);
								y = zzaCur;

#line 155 "gkm.g"
								_retv = [activeParser valueForBoolAttribute: y];
 zzCONSUME;

							}
							else {
								if ( (LA(1)==ATTRVALUE_AUTOMATIC) ) {
#line 156 "gkm.g"
									zzmatch(ATTRVALUE_AUTOMATIC);
									pa = zzaCur;

#line 156 "gkm.g"
									_retv = [activeParser valueForAutomaticAttribute: pa];
 zzCONSUME;

								}
								else {
									if ( (LA(1)==ATTRVALUE_ALWAYS) ) {
#line 157 "gkm.g"
										zzmatch(ATTRVALUE_ALWAYS);
										pl = zzaCur;

#line 157 "gkm.g"
										_retv = [activeParser valueForAlwaysAttribute: pl];
 zzCONSUME;

									}
									else {
										if ( (LA(1)==BEGIN_LAYOUT) ) {
#line 158 "gkm.g"
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
	zzresynch(setwd1, 0x80);
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
#line 161 "gkm.g"
	zzRULE;
	Attrib aki, ais, gi, gs, px, py, pw, ph, pi;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 162 "gkm.g"
	id value = nil;
	if ( (LA(1)==ATTRKEY_ID) ) {
#line 163 "gkm.g"
		zzmatch(ATTRKEY_ID); zzCONSUME;
#line 164 "gkm.g"
		zzmatch(TOK_ASSIGN); zzCONSUME;
#line 165 "gkm.g"
		{
			zzBLOCK(zztasp2);
			zzMake0;
			{
			if ( (LA(1)==IDENTIFIER) ) {
#line 165 "gkm.g"
				zzmatch(IDENTIFIER);
				aki = zzaCur;

#line 165 "gkm.g"
				value = [aki text];
 zzCONSUME;

			}
			else {
				if ( (LA(1)==STRING) ) {
#line 166 "gkm.g"
					zzmatch(STRING);
					ais = zzaCur;

#line 166 "gkm.g"
					value = [ais text];
 zzCONSUME;

				}
				else {zzFAIL(1,zzerr4,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
			}
			zzEXIT(zztasp2);
			}
		}
#line 168 "gkm.g"
		[activeParser setElementName:value];
	}
	else {
		if ( (LA(1)==ATTRKEY_GROUP) ) {
#line 169 "gkm.g"
			zzmatch(ATTRKEY_GROUP); zzCONSUME;
#line 170 "gkm.g"
			zzmatch(TOK_ASSIGN); zzCONSUME;
#line 171 "gkm.g"
			{
				zzBLOCK(zztasp2);
				zzMake0;
				{
				if ( (LA(1)==IDENTIFIER) ) {
#line 171 "gkm.g"
					zzmatch(IDENTIFIER);
					gi = zzaCur;

#line 171 "gkm.g"
					value = [gi text];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==STRING) ) {
#line 172 "gkm.g"
						zzmatch(STRING);
						gs = zzaCur;

#line 172 "gkm.g"
						value = [gs text];
 zzCONSUME;

					}
					else {zzFAIL(1,zzerr5,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
				}
				zzEXIT(zztasp2);
				}
			}
#line 174 "gkm.g"
			[activeParser setElementRadioGroup:value];
		}
		else {
			if ( (LA(1)==ATTRKEY_POSITION) ) {
#line 175 "gkm.g"
				zzmatch(ATTRKEY_POSITION); zzCONSUME;
#line 176 "gkm.g"
				zzmatch(TOK_ASSIGN); zzCONSUME;
#line 177 "gkm.g"
				zzmatch(BEGIN_LAYOUT); zzCONSUME;
#line 177 "gkm.g"
				zzmatch(INTEGER);
				px = zzaCur;
 zzCONSUME;
#line 177 "gkm.g"
				zzmatch(INTEGER);
				py = zzaCur;
 zzCONSUME;
#line 177 "gkm.g"
				zzmatch(END_LAYOUT);
#line 178 "gkm.g"
				[activeParser setElementPosition:[[ px text] intValue]:[[ py text] intValue]];
 zzCONSUME;

			}
			else {
				if ( (LA(1)==ATTRKEY_SIZE) ) {
#line 179 "gkm.g"
					zzmatch(ATTRKEY_SIZE); zzCONSUME;
#line 180 "gkm.g"
					zzmatch(TOK_ASSIGN); zzCONSUME;
#line 181 "gkm.g"
					zzmatch(BEGIN_LAYOUT); zzCONSUME;
#line 181 "gkm.g"
					zzmatch(INTEGER);
					pw = zzaCur;
 zzCONSUME;
#line 181 "gkm.g"
					zzmatch(INTEGER);
					ph = zzaCur;
 zzCONSUME;
#line 181 "gkm.g"
					zzmatch(END_LAYOUT);
#line 182 "gkm.g"
					[activeParser setElementSize:[[ pw text] intValue]:[[ ph text] intValue]];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==IDENTIFIER) ) {
#line 183 "gkm.g"
						zzmatch(IDENTIFIER);
						pi = zzaCur;
 zzCONSUME;
#line 184 "gkm.g"
						zzmatch(TOK_ASSIGN); zzCONSUME;
#line 185 "gkm.g"
						 value  = attributeValue();

#line 186 "gkm.g"
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
	zzresynch(setwd2, 0x1);
	}
}

void
#ifdef __USE_PROTOS
attributeList(void)
#else
attributeList()
#endif
{
#line 189 "gkm.g"
	zzRULE;
	zzBLOCK(zztasp1);
	zzMake0;
	{
#line 190 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (setwd2[LA(1)]&0x2) ) {
#line 190 "gkm.g"
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
	zzresynch(setwd2, 0x4);
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
#line 193 "gkm.g"
	zzRULE;
	Attrib pi, as, ai, af, an, ay;
	zzBLOCK(zztasp1);
	PURIFY(_retv,sizeof( id  	))
	zzMake0;
	{
#line 194 "gkm.g"
	
	NSMutableDictionary *al = [NSMutableDictionary dictionaryWithCapacity:8];
	NSString *attrKey    = nil;
	NSString *layoutType = nil;
	id v = nil;
#line 200 "gkm.g"
	zzmatch(BEGIN_LAYOUT); zzCONSUME;
#line 201 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		if ( (LA(1)==LAYOUT_FIXED) ) {
#line 201 "gkm.g"
			zzmatch(LAYOUT_FIXED);
#line 201 "gkm.g"
			layoutType = @"fixed";
 zzCONSUME;

		}
		else {
			if ( (LA(1)==LAYOUT_BOX) ) {
#line 202 "gkm.g"
				zzmatch(LAYOUT_BOX);
#line 202 "gkm.g"
				layoutType = @"box";
 zzCONSUME;

			}
			else {
				if ( (LA(1)==LAYOUT_TABLE) ) {
#line 203 "gkm.g"
					zzmatch(LAYOUT_TABLE);
#line 203 "gkm.g"
					layoutType = @"table";
 zzCONSUME;

				}
				else {zzFAIL(1,zzerr7,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
			}
		}
		zzEXIT(zztasp2);
		}
	}
#line 214 "gkm.g"
	{
		zzBLOCK(zztasp2);
		zzMake0;
		{
		while ( (LA(1)==IDENTIFIER) ) {
#line 205 "gkm.g"
			zzmatch(IDENTIFIER);
			pi = zzaCur;

#line 205 "gkm.g"
			attrKey = [ pi text];
 zzCONSUME;

#line 206 "gkm.g"
			zzmatch(TOK_ASSIGN); zzCONSUME;
#line 207 "gkm.g"
			{
				zzBLOCK(zztasp3);
				zzMake0;
				{
				if ( (LA(1)==STRING) ) {
#line 207 "gkm.g"
					zzmatch(STRING);
					as = zzaCur;

#line 207 "gkm.g"
					v = [as text];
 zzCONSUME;

				}
				else {
					if ( (LA(1)==INTEGER) ) {
#line 208 "gkm.g"
						zzmatch(INTEGER);
						ai = zzaCur;

#line 208 "gkm.g"
						v = [NSNumber numberWithInt:[[ai text] intValue]];
 zzCONSUME;

					}
					else {
						if ( (LA(1)==FLOAT) ) {
#line 209 "gkm.g"
							zzmatch(FLOAT);
							af = zzaCur;

#line 209 "gkm.g"
							v = [NSNumber numberWithFloat:[[af text] floatValue]];
 zzCONSUME;

						}
						else {
							if ( (LA(1)==ATTRVALUE_NO) ) {
#line 210 "gkm.g"
								zzmatch(ATTRVALUE_NO);
								an = zzaCur;

#line 210 "gkm.g"
								v = [NSNumber numberWithBool:NO];
 zzCONSUME;

							}
							else {
								if ( (LA(1)==ATTRVALUE_YES) ) {
#line 211 "gkm.g"
									zzmatch(ATTRVALUE_YES);
									ay = zzaCur;

#line 211 "gkm.g"
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
#line 213 "gkm.g"
			[al setObject:v forKey:attrKey]; v = nil;
			zzLOOP(zztasp2);
		}
		zzEXIT(zztasp2);
		}
	}
#line 215 "gkm.g"
	zzmatch(END_LAYOUT);
#line 216 "gkm.g"
	_retv = [activeParser valueForLayoutType:layoutType values:al];
 zzCONSUME;

	zzEXIT(zztasp1);
	return _retv;
fail:
	zzEXIT(zztasp1);
	zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
	zzresynch(setwd2, 0x8);
	return _retv;
	}
}
