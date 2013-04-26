//
//  NSData.h
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 23/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (dviance)

-(id)initWithContentOfURL:(NSURL*)url andPOSTData:(NSString*)postData;
-(id)initWithContentOfURL:(NSURL*)url andGETData:(NSString*)getData;

+(id)dataWithContentOfURL:(NSURL*)url andPOSTData:(NSString*)postData;
+(id)dataWithContentOfURL:(NSURL*)url andGETData:(NSString*)getData;

@end
