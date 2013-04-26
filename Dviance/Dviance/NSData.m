//
//  NSData.m
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 23/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import "NSData.h"
#import "NSURLConnection.h"

@implementation NSData (dviance)

- (id)initWithContentOfURL:(NSURL*)url andPOSTData:(NSString*)postData
{
    return [NSURLConnection getContentOfURL:url withPostData:postData];
}
- (id)initWithContentOfURL:(NSURL*)url andGETData:(NSString*)getData
{
    return [NSURLConnection getContentOfURL:url withGetData:getData];
}


+ (id)dataWithContentOfURL:(NSURL*)url andPOSTData:(NSString*)postData
{
    return [NSURLConnection getContentOfURL:url withPostData:postData];
}

+ (id)dataWithContentOfURL:(NSURL*)url andGETData:(NSString*)getData
{
    return [NSURLConnection getContentOfURL:url withGetData:getData];
}

@end
