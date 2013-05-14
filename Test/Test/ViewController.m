//
//  ViewController.m
//  Test
//
//  Created by Sylvain FAY-CHATELARD on 22/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import "ViewController.h"

#import <Dviance/Dviance.h>

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UILabel *deviceNameLbl;
@property (nonatomic, strong) IBOutlet UILabel *osVersionLbl;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [_deviceNameLbl setText:[UIDevice deviceModelName]];
    [_osVersionLbl setText:[NSString stringWithFormat:@"%.1f", [UIDevice osVersion]]];
    
    /*NSData * data = [NSURLConnection getContentOfURL:[NSURL URLWithString:@"http://apple.com"] withGetData:nil];
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", str);
    
    data = [[NSData alloc] initWithContentOfURL:[NSURL URLWithString:@"http://apple.com"] andGETData:nil];
    str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);*/
    
    NSArray *res;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *dbFile = [NSString stringWithFormat:@"%@/database.db", cachePath];
    SQLDatabase * database = [SQLDatabase databaseWithFile:dbFile];
    
    SQLRequest * request = [SQLRequest requestWithSQL:@"CREATE TABLE IF NOT EXISTS 'Test.Record' ( id INTEGER PRIMARY KEY ASC AUTOINCREMENT, name TEXT, defaultValue INTEGER DEFAULT 0);"];
    res = [database request:request];
    
    request = [SQLRequest requestWithSQL:@"INSERT INTO 'Test.Record' (id, name, defaultValue) values(NULL, %@, %d);", @"Test", 2];
    res = [database request:request];
    
    request = [SQLRequest requestWithSQL:@"SELECT * FROM 'Test.Record'"];
    res = [database request:request];
    NSLog(@"Res : %@", res);
    
    // Not needed will be called during dealloc
    //[database close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
