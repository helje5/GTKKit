#header <<
#import <Foundation/Foundation.h>
#import "GKMAttribute.h"
#import "GKModuleParser.h"
>>

<<
extern GKModuleParser *activeParser;
>>

// ******************** TOKENS ********************

#token TOK_BEGIN_MODULE "<MODULE\>"
#token TOK_END_MODULE   "</MODULE\>"

#token "<\!\-\-"                      << zzmode(COMMENT); zzskip(); >>

#token BEGIN_OBJECT_TAG    "<OBJECT"     << zzmode(TAG); >>
#token BEGIN_REFERENCE_TAG "<REFERENCE"  << zzmode(TAG); >>
#token BEGIN_ASSIGN_TAG    "<ASSIGN"     << zzmode(TAG); >>
#token OBJECT_CLOSETAG     "</OBJECT[\ \t]*\>"
#token REFERENCE_CLOSETAG  "</REFERENCE[\ \t]*\>"

#token BEGIN_CLOSETAG   "</"          << zzmode(TAG); >>
#token BEGIN_TAG        "<"           << zzmode(TAG); >>

#token "\!"                   << zzskip(); >>
#token "\-"                   << zzskip(); >>
#token "[\t\ ]"               << zzskip(); >>
#token "[\n\r]"               << zzline++; zzskip(); >>
#token "~[\t\ \n\r\<\-\!]+"   << zzskip(); >>

// *****************
#lexclass TAG

#token END_EMPTY_TAG  "/\>"                   << zzmode(START); >>
#token END_TAG        "\>"                    << zzmode(START); >>

#token ATTRKEY_ID           "ID"
#token ATTRKEY_GROUP        "GROUP"
#token ATTRKEY_POSITION     "POSITION"
#token ATTRKEY_SIZE         "SIZE"
#token ATTRVALUE_NO         "NO"
#token ATTRVALUE_YES        "YES"
#token ATTRVALUE_AUTOMATIC  "AUTOMATIC"
#token ATTRVALUE_ALWAYS     "ALWAYS"

#token BEGIN_LAYOUT   "\["                    << zzmode(LAYOUT_TAG); >>

#token TOK_ASSIGN     "\="
#token STRING         "\"~[\n\r\"]*\""
#token INTEGER        "([1-9][0-9]*) | (\-[1-9][0-9]*) | 0"
#token FLOAT          "([0-9]+.[0-9]* | [0-9]*.[0-9]+)"
#token ID_REFERENCE   "\#[a-zA-Z][a-zA-Z0-9_]*"
#token SELECTOR       "\@[a-zA-Z][a-zA-Z0-9_\:]*"
#token IDENTIFIER     "[a-zA-Z][a-zA-Z0-9_]*"
#token "[\t\ ]+"                              << zzskip(); >>
#token "[\n\r]"		                            << zzline++; zzskip(); >>

// *****************
#lexclass LAYOUT_TAG

#token END_LAYOUT     "\]"                    << zzmode(TAG); >>

#token LAYOUT_FIXED   "Fixed"
#token LAYOUT_BOX     "Box"
#token LAYOUT_TABLE   "Table"

#token ATTRVALUE_NO         "NO"
#token ATTRVALUE_YES        "YES"

#token TOK_ASSIGN     "\="
#token STRING         "\"~[\n\r\"]*\""
#token INTEGER        "([1-9][0-9]*) | 0"
#token FLOAT          "([0-9]+.[0-9]* | [0-9]*.[0-9]+)"

#token IDENTIFIER     "[a-zA-Z][a-zA-Z0-9_]*"
#token "[\t\ ]+"                              << zzskip(); >>
#token "[\n\r]"	                              << zzline++; zzskip(); >>

// *****************
#lexclass COMMENT

#token "\-\-\>"       << zzmode(START); zzskip(); >>
#token "\-"           << zzmore(); >>
#token "\>"           << zzmore(); >>
#token "[\n\r]"       << zzline++; zzmore(); >>
#token "~[\-\>\n\r]+" << zzmore(); >>

// *****************
#lexclass START

// ******************** RULES *********************

gkmodule
  : TOK_BEGIN_MODULE     << [activeParser enterModule]; >>
    ( topLevelElement )*
    TOK_END_MODULE       << [activeParser leaveModule]; >>
    "@"
  ;

element
  : genericElement
  ;

topLevelElement
  : element
  | referenceElement
  ;

assignElement
  : << id value = nil; >>
    at:BEGIN_ASSIGN_TAG
    i:IDENTIFIER 
    TOK_ASSIGN 
    attributeValue > [value]
    END_EMPTY_TAG
    << [activeParser applyAssignment:$at assign:value to:$i]; >>
  ;

referenceElement
  : << 
      NSDictionary *al = nil;
    >>
    BEGIN_REFERENCE_TAG     << [activeParser beginReferenceElement]; >>
    attributeList
    END_TAG
    ( assignElement )*
    REFERENCE_CLOSETAG      << [activeParser endReferenceElement];   >>
  ;

genericElement
  : << >>
    BEGIN_TAG bi:IDENTIFIER  << [activeParser beginGenericElement:$bi];  >>
    attributeList
    << [activeParser startGenericElement:$bi]; >>
    ( END_EMPTY_TAG
    | END_TAG
      << [activeParser beginGenericElementContent:$bi]; >>
      ( element
      | assignElement
      )*
      << [activeParser endGenericElementContent:$bi]; >>
      BEGIN_CLOSETAG 
        ci:IDENTIFIER 
      END_TAG
    )
    << [activeParser endGenericElement:$bi]; >>
  ; 

attributeValue > [id result]
  : s:STRING        << $result = [activeParser valueForStringAttribute:$s];    >>
  | i:INTEGER       << $result = [activeParser valueForIntAttribute:$i];       >>
  | f:FLOAT         << $result = [activeParser valueForFloatAttribute:$f];     >>
  | r:ID_REFERENCE  << $result = [activeParser valueForReferenceAttribute:$r]; >>
  | e:SELECTOR      << $result = [activeParser valueForSelectorAttribute:$e];  >>
  | n:ATTRVALUE_NO  << $result = [activeParser valueForBoolAttribute:$n];      >>
  | y:ATTRVALUE_YES << $result = [activeParser valueForBoolAttribute:$y];      >>
  | pa:ATTRVALUE_AUTOMATIC << $result = [activeParser valueForAutomaticAttribute:$pa];>>
  | pl:ATTRVALUE_ALWAYS    << $result = [activeParser valueForAlwaysAttribute:$pl];>>
  | layoutValue > [$result]
  ;

attributePair
  : << id value = nil; >>
    ATTRKEY_ID 
    TOK_ASSIGN 
    ( aki:IDENTIFIER << value = [aki text]; >>
    | ais:STRING     << value = [ais text]; >>
    )
    << [activeParser setElementName:value]; >>
  | ATTRKEY_GROUP
    TOK_ASSIGN
    ( gi:IDENTIFIER << value = [gi text]; >>
    | gs:STRING     << value = [gs text]; >>
    )
    << [activeParser setElementRadioGroup:value]; >>
  | ATTRKEY_POSITION
    TOK_ASSIGN
    BEGIN_LAYOUT px:INTEGER py:INTEGER END_LAYOUT
    << [activeParser setElementPosition:[[$px text] intValue]:[[$py text] intValue]]; >>
  | ATTRKEY_SIZE
    TOK_ASSIGN
    BEGIN_LAYOUT pw:INTEGER ph:INTEGER END_LAYOUT
    << [activeParser setElementSize:[[$pw text] intValue]:[[$ph text] intValue]]; >>
  | pi:IDENTIFIER
    TOK_ASSIGN 
    attributeValue > [value]
    << [activeParser setValue:value forProperty:$pi]; >>
  ;

attributeList
  : ( attributePair )*
  ;

layoutValue > [id result]
  : << 
      NSMutableDictionary *al = [NSMutableDictionary dictionaryWithCapacity:8];
      NSString *attrKey    = nil;
      NSString *layoutType = nil;
      id v = nil;
    >>
    BEGIN_LAYOUT
    ( LAYOUT_FIXED << layoutType = @"fixed"; >>
    | LAYOUT_BOX   << layoutType = @"box";   >>
    | LAYOUT_TABLE << layoutType = @"table"; >>
    )
    ( pi:IDENTIFIER       << attrKey = [$pi text]; >>
      TOK_ASSIGN
      ( as:STRING         << v = [as text]; >>
      | ai:INTEGER        << v = [NSNumber numberWithInt:[[ai text] intValue]]; >>
      | af:FLOAT          << v = [NSNumber numberWithFloat:[[af text] floatValue]]; >>
      | an:ATTRVALUE_NO   << v = [NSNumber numberWithBool:NO]; >>
      | ay:ATTRVALUE_YES  << v = [NSNumber numberWithBool:YES]; >>
      )
      << [al setObject:v forKey:attrKey]; v = nil; >>
    )*
    END_LAYOUT
    << $result = [activeParser valueForLayoutType:layoutType values:al]; >>
  ;
