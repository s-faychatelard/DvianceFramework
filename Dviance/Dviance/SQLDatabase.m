//
//  SQLDatabase.m
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 26/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import "SQLDatabase.h"

@interface SQLDatabase ()

@property (nonatomic, strong) SQLRequest *request;
@property (nonatomic, strong) NSMutableArray *arguments;

@property (readwrite) sqlite3 *sqlDatabase;

@end

@implementation SQLDatabase

- (id)init
{
    [NSException raise:@"Cannot init SQLDatabase" format:@"You must use +databaseWithFile: to create a SQLDatabase"];
    
    return nil;
}

- (void)dealloc
{
    [self close];
}

+ (id)databaseWithFile:(NSString*)file
{
    SQLDatabase * database = [SQLDatabase alloc];
    if (database)
    {
        // Init and open db
        sqlite3 *db = NULL;
        int res = 0;
        
        res = sqlite3_open_v2([file UTF8String], &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL);
        
        if (res != SQLITE_OK)
        {
            [database setSqlDatabase:NULL];
            
            [NSException raise:@"Cannot open SQLDatabase" format:@"An error occured, SQLite code %d, %s", sqlite3_errcode(db), sqlite3_errmsg(db)];
        }
        
        [database setSqlDatabase:db];
    }
    return database;
}

- (void)close
{
    int res = 0;
    
    res = sqlite3_close(_sqlDatabase);
    
    if (res != SQLITE_OK)
        [NSException raise:@"Cannot close SQLDatabase" format:@"An error occured, SQLite code %d, %s", sqlite3_errcode(_sqlDatabase), sqlite3_errmsg(_sqlDatabase)];
}

- (NSDictionary*)request:(SQLRequest*)request
{
    _request = request;
    return nil;
}

@end
