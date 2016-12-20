#import "Helper.h"
#import <Security/Security.h>

@implementation Helper

-(id) initWithService:(NSString *) service_ withGroup:(NSString*)group_
{
    self =[super init];
    if(self)
    {
        service = [NSString stringWithString:service_];
        
        if(group_)
            group = [NSString stringWithString:group_];
    }
    
    return  self;
}

-(BOOL) put:(NSString *)key value:(NSString *) value {
    NSString *key1 = key;
    NSData * value1 = [value dataUsingEncoding:NSUTF8StringEncoding];
    
    BOOL status = [self insert:key1 :value1];
    
    return status;
}

- (NSString*) get:(NSString *) key {
    NSData * data = [self find:key];
    
    NSString* result = nil;
    
    if(data){
        result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return result;
}

- (BOOL) remove:(NSString*) key {
    return[self remove:key];
}


-(NSMutableDictionary*) prepareDict:(NSString *) key
{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    NSData *encodedKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    [dict setObject:encodedKey forKey:(__bridge id)kSecAttrGeneric];
    [dict setObject:encodedKey forKey:(__bridge id)kSecAttrAccount];
    [dict setObject:service forKey:(__bridge id)kSecAttrService];
    [dict setObject:(__bridge id)kSecAttrAccessibleAlwaysThisDeviceOnly forKey:(__bridge id)kSecAttrAccessible];
    
    //This is for sharing data across apps
    if(group != nil)
        [dict setObject:group forKey:(__bridge id)kSecAttrAccessGroup];
    
    return  dict;
}


-(BOOL) insert:(NSString *)key : (NSData *)data
{
    NSMutableDictionary * dict =[self prepareDict:key];
    [dict setObject:data forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dict, NULL);
    if(errSecSuccess != status) {
        NSLog(@"Unable add item with key =%@ error:%ld",key,status);
    }
    return (errSecSuccess == status);
}

-(NSData*) find:(NSString*)key
{
    NSMutableDictionary *dict = [self prepareDict:key];
    [dict setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    [dict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)dict,&result);
    
    if( status != errSecSuccess) {
        NSLog(@"Unable to fetch item for key %@ with error:%ld",key,status);
        return nil;
    }
    
    return (__bridge NSData *)result;
}

-(BOOL) update:(NSString*)key :(NSData*) data
{
    NSMutableDictionary * dictKey =[self prepareDict:key];
    
    NSMutableDictionary * dictUpdate =[[NSMutableDictionary alloc] init];
    [dictUpdate setObject:data forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)dictKey, (__bridge CFDictionaryRef)dictUpdate);
    if(errSecSuccess != status) {
        NSLog(@"Unable add update with key =%@ error:%ld",key,status);
    }
    return (errSecSuccess == status);
    
    return YES;
    
}

-(BOOL) remove: (NSString*)key
{
    NSMutableDictionary *dict = [self prepareDict:key];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)dict);
    if( status != errSecSuccess) {
        NSLog(@"Unable to remove item for key %@ with error:%ld",key,status);
        return NO;
    }
    return  YES;
}

@end