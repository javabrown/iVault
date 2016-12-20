/**
 * @author Raja Khan
 *
 */

 
#import <Foundation/Foundation.h>
#import "EventKit/EventKit.h"

@interface Helper : CDVPlugin
 {
    NSString * service;
    NSString * group;
    UIView* extendedView;
 }

#define KEY @"KEY"
#define VALUE @"VALUE"
 
- (BOOL) put:(NSString *)key value:(NSString *) value;

- (NSString*) get:(NSString *) key;

- (BOOL) remove:(NSString*) key;

@end