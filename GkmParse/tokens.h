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
#define BEGIN_ASSIGN_TAG 6
#define OBJECT_CLOSETAG 7
#define BEGIN_CLOSETAG 8
#define BEGIN_TAG 9
#define END_EMPTY_TAG 15
#define END_TAG 16
#define ATTRKEY_ID 17
#define ATTRKEY_GROUP 18
#define ATTRKEY_POSITION 19
#define ATTRKEY_SIZE 20
#define ATTRVALUE_NO 21
#define ATTRVALUE_YES 22
#define ATTRVALUE_AUTOMATIC 23
#define ATTRVALUE_ALWAYS 24
#define BEGIN_LAYOUT 25
#define TOK_ASSIGN 26
#define STRING 27
#define INTEGER 28
#define FLOAT 29
#define ID_REFERENCE 30
#define SELECTOR 31
#define IDENTIFIER 32
#define END_LAYOUT 35
#define LAYOUT_FIXED 36
#define LAYOUT_BOX 37
#define LAYOUT_TABLE 38

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
void objectElement(void);
#else
extern void objectElement();
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
extern SetWordType zzerr4[];
extern SetWordType zzerr5[];
extern SetWordType zzerr6[];
extern SetWordType setwd1[];
extern SetWordType zzerr7[];
extern SetWordType zzerr8[];
extern SetWordType setwd2[];
