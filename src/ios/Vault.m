#import <UIKit/UIScreen.h>

@implementation Vault : CDVPlugin

- (void)get:(CDVInvokedUrlCommand*)command
{
  NSLog("get called");
}

- (void)set:(CDVInvokedUrlCommand*)command
{
  NSLog("set called");
}
@end