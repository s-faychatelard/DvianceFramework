//
//  SQLDatabase.h
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 26/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "SQLRequest.h"

typedef enum {
    SQL_INTEGER = SQLITE_INTEGER,
    SQL_FLOAT = SQLITE_FLOAT,
    SQL_DATA = SQLITE_BLOB,
    SQL_STRING = SQLITE_TEXT,
    SQL_NIL = SQLITE_NULL
} SQLType;

@interface SQLDatabase : NSObject

+(id)databaseWithFile:(NSString*)file;
-(void)close;

-(NSDictionary*)request:(SQLRequest*)request;
+(SQLType)typeOfValue:(id)value;

@end
