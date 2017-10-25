// $Id: GTKObject+Bean.h,v 1.1 1998/08/16 20:21:02 helge Exp $

#import <GTKKit/GTKObject.h>

@class NSString, NSDictionary;

/*
  Enables GTKObject's to set their properties by names.

  Eg, if you the Object has a property title available through the methods
  setTitle: and title you can set the value of the property by calling:

    [object setProperty:@"title" toValue:@"hallo"];
*/

@interface GTKObject(Bean)

- (id)initWithPropertyList:(id)_propertyList; // list must be a dictionary

// setting & getting

- (BOOL)takeValue:(id)_value forKey:(NSString *)_key;
- (void)takeValuesFromDictionary:(NSDictionary *)_dictionary;

@end
