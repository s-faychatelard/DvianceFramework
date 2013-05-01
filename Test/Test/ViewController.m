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
    
    SQLRequest * request = [SQLRequest requestWithSQL:@"INSERT INTO Table values(%f, %@, %s, %g);", (double)1, @"toto", "tutu", (float)1];
    SQLDatabase * database = [SQLDatabase databaseWithFile:@"file"];
    NSDictionary *res = [database request:request];
    
    // Throw an exception 'Not yet implemented'
    //[database close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
