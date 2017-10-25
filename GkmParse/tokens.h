#ifndef tokens_h
#define tokens_h
/* tokens.h -- List of labelled tokens and stuff
 *
 * Generated from: gkm.g
 *
 * Terence Parr, Will Cohen, and Hank Dietz: 1989-1998
 * Purdue University Electrical Engineering
 * ANTLR Version 1.33MR14
 */
#define zzEOF_TOKEN 1
#define TOK_BEGIN_MODULE 2
#define TOK_END_MODULE 3
#define BEGIN_OBJECT_TAG 5
#define BEGIN_REFERENCE_TAG 6
#define BEGIN_ASSIGN_TAG 7
#define OBJECT_CLOSETAG 8
#define REFERENCE_CLOSETAG 9
#define BEGIN_CLOSETAG 10
#define BEGIN_TAG 11
#define END_EMPTY_TAG 17
#define END_TAG 18
#define ATTRKEY_ID 19
#define ATTRKEY_GROUP 20
#define ATTRKEY_POSITION 21
#define ATTRKEY_SIZE 22
#define ATTRVALUE_NO 23
#define ATTRVALUE_YES 24
#define ATTRVALUE_AUTOMATIC 25
#define ATTRVALUE_ALWAYS 26
#define BEGIN_LAYOUT 27
#define TOK_ASSIGN 28
#define STRING 29
#define INTEGER 30
#define FLOAT 31
#define ID_REFERENCE 32
#define SELECTOR 33
#define IDENTIFIER 34
#define END_LAYOUT 37
#define LAYOUT_FIXED 38
#define LAYOUT_BOX 39
#define LAYOUT_TABLE 40

#ifdef __USE_PROTOS
void gkmodule(void);
#else
extern void gkmodule();
#endif

#ifdef __USE_PROTOS
void element(void);
#else
extern void element();
#endif

#ifdef __USE_PROTOS
void topLevelElement(void);
#else
extern void topLevelElement();
#endif

#ifdef __USE_PROTOS
void assignElement(void);
#else
extern void assignElement();
#endif

#ifdef __USE_PROTOS
void referenceElement(void);
#else
extern void referenceElement();
#endif

#ifdef __USE_PROTOS
void genericElement(void);
#else
extern void genericElement();
#endif

#ifdef __USE_PROTOS
extern  id   attributeValue(void);
#else
extern  id   attributeValue();
#endif

#ifdef __USE_PROTOS
void attributePair(void);
#else
extern void attributePair();
#endif

#ifdef __USE_PROTOS
void attributeList(void);
#else
extern void attributeList();
#endif

#ifdef __USE_PROTOS
extern  id   layoutValue(void);
#else
extern  id   layoutValue();
#endif

#endif
extern SetWordType zzerr1[];
extern SetWordType zzerr2[];
extern SetWordType zzerr3[];
extern SetWordType setwd1[];
extern SetWordType zzerr4[];
extern SetWordType zzerr5[];
extern SetWordType zzerr6[];
extern SetWordType zzerr7[];
extern SetWordType zzerr8[];
extern SetWordType setwd2[];
