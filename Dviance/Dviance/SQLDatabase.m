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

- (NSArray*)request:(SQLRequest*)request
{
    _request = request;
    
    int res = 0;
    
    res = sqlite3_prepare_v2(_sqlDatabase, [[request request] UTF8String], -1, &_statement, NULL);
    
    if (res != SQLITE_OK)
    {
        sqlite3_finalize(_statement);
        [NSException raise:@"Cannot prepare SQLRequest" format:@"An error occured, SQLite code %d, %s", sqlite3_errcode(_sqlDatabase), sqlite3_errmsg(_sqlDatabase)];
    }
    
    int nbParam = sqlite3_bind_parameter_count(_statement);
    for (int i=0; i<[[request arguments] count] && i<nbParam; i++)
    {
        switch ([SQLDatabase typeOfValue:[[request arguments] objectAtIndex:i]]) {
            case SQL_INTEGER:
                sqlite3_bind_int(_statement, i, [[[request arguments] objectAtIndex:i] intValue]);
                break;
            case SQL_FLOAT:
                sqlite3_bind_double(_statement, i, [[[request arguments] objectAtIndex:i] doubleValue]);
                break;
            case SQL_DATA:
                sqlite3_bind_blob(_statement, i, CFBridgingRetain([[[request arguments] objectAtIndex:i] bytes]), [[[request arguments] objectAtIndex:i] length], SQLITE_TRANSIENT);
                break;
            case SQL_STRING:
                sqlite3_bind_text(_statement, i, [[[request arguments] objectAtIndex:i] UTF8String], -1, SQLITE_TRANSIENT);
                break;
            case SQL_NIL:
                sqlite3_bind_value(_statement, i, CFBridgingRetain([NSNull null]));
                break;
        }
    }
    
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    do
    {
        res = sqlite3_step(_statement);
        if(res == SQLITE_ROW)
        {
            int type = 0;
            int nbColumn = 0;
            
            NSMutableDictionary *row = [[NSMutableDictionary alloc] init];
            
            nbColumn = sqlite3_column_count(_statement);
            
            for (int i=0; i<nbColumn; i++)
            {
                NSString *key = [NSString stringWithUTF8String:sqlite3_column_name(_statement, i)];
                id value = nil;
                
                NSLog(@"Key : %@", key);
                
                type = sqlite3_column_type(_statement, i);
                switch (type) {
                        
                    case SQLITE_INTEGER:
                        value = [NSNumber numberWithInteger:sqlite3_column_int(_statement, i)];
                        NSLog(@"INTEGER : %d", [value intValue]);
                        break;
                        
                    case SQLITE_FLOAT:
                        value = [NSNumber numberWithDouble:sqlite3_column_double(_statement, i)];
                        NSLog(@"FLOAT : %f", [value floatValue]);
                        break;
                        
                    case SQLITE_BLOB: {
                        int dataSize = sqlite3_column_bytes(_statement, i);
                        value = [NSMutableData dataWithLength:(NSUInteger)dataSize];
                        memcpy([value mutableBytes], sqlite3_column_blob(_statement, i), dataSize);
                        NSLog(@"BLOB : %@", value);
                        break;
                    }
                    case SQLITE_NULL: // Think it's a string
                        NSLog(@"NULL");
                        break;
                        
                    case SQLITE_TEXT:
                        value = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(_statement, i)];
                        NSLog(@"TEXT : %@", value);
                        break;
                        
                    default:
                        [NSException raise:@"Unknown type" format:@"Unknown type %d for result at column %d", type, i];
                        break;
                }
                
                [row setValue:value forKey:key];
            }
            
            [resultArray addObject:row];
        }
        else if(res != SQLITE_DONE)
        {
            sqlite3_finalize(_statement);
            [NSException raise:@"Cannot get result of SQLRequest" format:@"An error occured, SQLite code %d, %s", sqlite3_errcode(_sqlDatabase), sqlite3_errmsg(_sqlDatabase)];
        }
    }
    while(res != SQLITE_DONE);
    
    sqlite3_finalize(_statement);
    
    return resultArray;
}

+(SQLType)typeOfValue:(id)value
{
    if (value == nil)
    {
        return SQL_NIL;
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        return SQL_STRING;
    }
    else if ([value isKindOfClass:[NSData class]])
    {
        return SQL_DATA;
    }
    else if ([value isKindOfClass:[NSNumber class]])
    {
        CFNumberType numberType = CFNumberGetType((CFNumberRef)value);
        
        switch (numberType) {
            case kCFNumberSInt8Type:
            case kCFNumberSInt16Type:
            case kCFNumberSInt32Type:
            case kCFNumberSInt64Type:
            case kCFNumberCharType:
            case kCFNumberShortType:
            case kCFNumberIntType:
            case kCFNumberLongType:
            case kCFNumberLongLongType:
            case kCFNumberCFIndexType:
            case kCFNumberNSIntegerType:
                return SQL_INTEGER;
                
            case kCFNumberFloatType:
            case kCFNumberDoubleType:
            case kCFNumberCGFloatType: // equal to kCFNumberMaxType
            case kCFNumberFloat32Type:
            case kCFNumberFloat64Type:
                return SQL_FLOAT;
        }
    }
    
    return SQL_NIL;
}

@end
