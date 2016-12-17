/**
 * @author Raja Khan
 *
 */

#import <Cordova/CDV.h>

@interface Vault : CDVPlugin

- (void)get:(CDVInvokedUrlCommand*)command;
- (void)set:(CDVInvokedUrlCommand*)command;

@end