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
@property (readwrite) sqlite3_stmt *statement;

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
    
    int res = 0;
    
    res = sqlite3_prepare_v2(_sqlDatabase, [[request request] UTF8String], [[request request] length], &_statement, NULL);
    
    if (res != SQLITE_OK)
    {
        sqlite3_finalize(_statement);
        [NSException raise:@"Cannot prepare SQLRequest" format:@"An error occured, SQLite code %d, %s", sqlite3_errcode(_sqlDatabase), sqlite3_errmsg(_sqlDatabase)];
    }
    
    do
    {
        res = sqlite3_step(_statement);
        if(res == SQLITE_ROW)
        {
            int type = 0;
            int nbColumn = 0;
            
            nbColumn = sqlite3_column_count(_statement);
            
            for (int i=0; i<nbColumn; i++)
            {
                //sqlite3_column_name(<#sqlite3_stmt *#>, <#int N#>)
                type = sqlite3_column_type(_statement, i);
                
                switch (type) {
                        
                    case SQLITE_INTEGER:
                        NSLog(@"INTEGER");
                        break;
                        
                    case SQLITE_FLOAT:
                        NSLog(@"FLOAT");
                        break;
                        
                    case SQLITE_BLOB:
                        NSLog(@"BLOB");
                        break;
                        
                    case SQLITE_NULL:
                        NSLog(@"NULL");
                        break;
                        
                    case SQLITE_TEXT:
                        NSLog(@"TEXT");
                        break;
                        
                    default:
                        [NSException raise:@"Unknown type" format:@"Unknown type %d for result at column %d", type, i];
                        break;
                }
            }
        }
        else if(res != SQLITE_DONE)
        {
            sqlite3_finalize(_statement);
            [NSException raise:@"Cannot get result of SQLRequest" format:@"An error occured, SQLite code %d, %s", sqlite3_errcode(_sqlDatabase), sqlite3_errmsg(_sqlDatabase)];
        }
    }
    while(res != SQLITE_DONE);
    
    sqlite3_finalize(_statement);
    
    return nil;
}

@end
