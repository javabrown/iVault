/**
 * @author Raja Khan
 *
 */

#import <UIKit/UIScreen.h>
#import "Helper.h"

@implementation Vault : CDVPlugin


-(void) get:(CDVInvokedUrlCommand *) command {
    
    NSDictionary* options   = [command.arguments objectAtIndex:0];
    NSString* key      = [options objectForKey:@"KEY"];
	
    Helper* helper = [[Helper alloc] init];
    NSString* value = [helper get:KEY];
   
    
    NSString* responseJson = nil;
    
    if(key && value){
        NSDictionary *dict = @{key : value};
        responseJson = [BizHelper toJson:dict];
    }
    
    CDVPluginResult *pluginResult = nil;
    
    if(responseJson == nil){
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        NSLog(@"Not stored credential found!!");
    }
    else{
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: responseJson];
        NSLog(@"Credential found!!");
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)set:(CDVInvokedUrlCommand*)command
{
    NSLog("set called");
  
    NSDictionary* options   = [command.arguments objectAtIndex:0];
    NSString* key      = [options objectForKey:@"KEY"];
    NSString* val    = [options objectForKey:@"VALUE"];

    Helper* helper = [[Helper alloc] init];
    BOOL status = [helper put:key value:val];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    
    if(!status)
    {
        NSLog(@"Failed to store the credential!!");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    else
    {
        NSLog(@"Successfully stored the credential!!");
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
 
}


@end

 