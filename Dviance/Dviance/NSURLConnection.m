//
//  NSURLConnection.m
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 23/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//


#import "NSURLConnection.h"

@interface NSURLConnection (dviance_private)

+(NSData*)getContentOfURL:(NSURL*)url withData:(NSData*)data andType:(NSString*)type;

@end

@implementation NSURLConnection (dviance)

+ (NSData*)getContentOfURL:(NSURL*)url withData:(NSData*)data andType:(NSString*)type
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    [request setHTTPMethod:type];
    [request setHTTPBody:data];
    
    return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

+ (NSData*)getContentOfURL:(NSURL*)url withGetData:(NSString*)getData
{
    return [NSURLConnection getContentOfURL:url withData:[getData dataUsingEncoding:NSUTF8StringEncoding] andType:@"GET"];
}

+ (NSData*)getContentOfURL:(NSURL*)url withPostData:(NSString*)postData
{
    return [NSURLConnection getContentOfURL:url withData:[postData dataUsingEncoding:NSUTF8StringEncoding] andType:@"POST"];
}

@end
