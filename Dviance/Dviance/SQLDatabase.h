//
//  SQLDatabase.h
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 26/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SQLRequest.h"

@interface SQLDatabase : NSObject

+(id)databaseWithFile:(NSString*)file;
-(void)close;
-(NSDictionary*)request:(SQLRequest*)request;

@end
