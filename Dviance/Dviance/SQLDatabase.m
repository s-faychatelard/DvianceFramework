//
//  SQLDatabase.m
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 26/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import "SQLDatabase.h"

@interface SQLDatabase ()

@property (nonatomic, readwrite, setter = setOpen:) BOOL isOpen;

@property (nonatomic, strong) SQLRequest *request;
@property (nonatomic, strong) NSMutableArray *arguments;

@end

@implementation SQLDatabase

+ (id)databaseWithFile:(NSString*)file
{
    SQLDatabase * database = [SQLDatabase alloc];
    if (database)
    {
        [database setOpen:YES];
    }
    return database;
}

- (void)close
{
    [NSException raise:@"Not yet implemented" format:@"close is not implemented"];
}

- (NSDictionary*)request:(SQLRequest*)request
{
    if (!_isOpen) [NSException raise:@"No database open" format:@"You must use +databaseWithFile: to create a SQLDatabase"];
    
    _request = request;
    return nil;
}

@end
