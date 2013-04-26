//
//  NSURLConnection.h
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 23/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLConnection (dviance)

+(NSData*)getContentOfURL:(NSURL*)url withGetData:(NSString*)getData;
+(NSData*)getContentOfURL:(NSURL*)url withPostData:(NSString*)postData;

@end
