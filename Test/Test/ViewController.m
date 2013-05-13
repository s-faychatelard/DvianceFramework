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
    
    //@"INSERT INTO Table values(%d, %@, %c)", 1, @"tutu", 'd'
	
    [_deviceNameLbl setText:[UIDevice deviceModelName]];
    [_osVersionLbl setText:[NSString stringWithFormat:@"%.1f", [UIDevice osVersion]]];
    NSData * data = [NSURLConnection getContentOfURL:[NSURL URLWithString:@"http://apple.com"] withGetData:nil];
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", str);
    
    data = [[NSData alloc] initWithContentOfURL:[NSURL URLWithString:@"http://apple.com"] andGETData:nil];
    str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"BundlePath : %@", cachePath);
    
    NSString *dbFile = [NSString stringWithFormat:@"%@/database.db", cachePath];
    
    SQLRequest * request = [SQLRequest requestWithSQL:@"CREATE TABLE IF NOT EXISTS 'FreeStroke.Record' ( id INTEGER PRIMARY KEY ASC AUTOINCREMENT, name TEXT, creation_date TEXT, gesture TEXT, command TEXT, command_type INTEGER, isCommandActive INTEGER DEFAULT 1, isGestureActive INTEGER DEFAULT 1, isDeleted INTEGER DEFAULT 0);;"];
    SQLDatabase * database = [SQLDatabase databaseWithFile:dbFile];
    NSDictionary *res = [database request:request];
    
    NSLog(@"%@", res);
    
    // Throw an exception 'Not yet implemented'
    //[database close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
