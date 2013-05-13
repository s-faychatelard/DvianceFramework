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

@end

@implementation SQLDatabase

- (id)init
{
    [NSException raise:@"Cannot init SQLDatabase" format:@"You must use +databaseWithFile: to create a SQLDatabase"];
    
    return nil;
}
+ (id)databaseWithFile:(NSString*)file
{
    SQLDatabase * database = [SQLDatabase alloc];
    if (database)
    {
    }
    return database;
}

- (void)close
{
    [NSException raise:@"Not yet implemented" format:@"close is not implemented"];
}

- (NSDictionary*)request:(SQLRequest*)request
{
    _request = request;
    return nil;
}

@end
