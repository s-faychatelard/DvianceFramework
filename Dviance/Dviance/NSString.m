//
//  NSString.m
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 26/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import "NSString.h"

@implementation NSString (dviance)

- (NSInteger)countOccurencesOfString:(NSString*)searchString
{
    int strCount = [self length] - [[self stringByReplacingOccurrencesOfString:searchString withString:@""] length];
    return strCount / [searchString length];
}

@end
