//
//  SQLRequest.m
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 26/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import "SQLRequest.h"

#import "NSString.h"

@interface SQLRequest ()

@end

@implementation SQLRequest

+ (id)requestWithSQL:(NSString*)sql, ...
{
    SQLRequest *request = [SQLRequest alloc];
    if (request)
    {
        NSMutableArray *arguments = [[NSMutableArray alloc] init];
        [request setArguments:arguments];
        
        va_list args;
        va_start(args, sql);
        
        NSRange occurenceRange = [sql rangeOfString:@"%" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [sql length])];
        
        NSMutableString *requestString = [[NSMutableString alloc] initWithString:sql];
        
        while (occurenceRange.location != NSNotFound)
        {
            id arg = nil;
            unichar sign = '\0';
            unichar caracter = [sql characterAtIndex:occurenceRange.location+1];
            
            switch (caracter) {
                case '@': // %@
                    arg = va_arg(args, id);
                    break;
                    
                case 'c': // %c
                    // warning: second argument to 'va_arg' is of promotable type 'char'; this va_arg has undefined behavior because arguments will be promoted to 'int'
                    arg = [NSString stringWithFormat:@"%c", va_arg(args, int)];
                    break;
                    
                case 's': // %s
                    arg = [NSString stringWithUTF8String:va_arg(args, char*)];
                    break;
                    
                case 'd': // %d
                case 'D': // %D
                case 'i': // %i
                    arg = [NSNumber numberWithInt:va_arg(args, int)];
                    break;
                    
                case 'u': // %u
                case 'U': // %U
                    arg = [NSNumber numberWithUnsignedInt:va_arg(args, unsigned int)];
                    break;
                    
                case 'h': // %h
                    sign = [sql characterAtIndex:occurenceRange.location+2];
                    
                    if (sign == 'i') // %hi
                    {
                        //  warning: second argument to 'va_arg' is of promotable type 'short'; this va_arg has undefined behavior because arguments will be promoted to 'int'
                        arg = [NSNumber numberWithShort:(short)(va_arg(args, int))];
                    }
                    else if (sign == 'u') // %hu
                    {
                        // warning: second argument to 'va_arg' is of promotable type 'unsigned short'; this va_arg has undefined behavior because arguments will be promoted to 'int'
                        arg = [NSNumber numberWithUnsignedShort:(unsigned short)(va_arg(args, uint))];
                    }
                    break;
                    
                case 'q': // %q(i|u)
                    sign = [sql characterAtIndex:occurenceRange.location+2];
                    
                    if (sign == 'i') // %qi
                    {
                        arg = [NSNumber numberWithLongLong:va_arg(args, long long)];
                    }
                    else if (sign == 'u') // %qu
                    {
                        arg = [NSNumber numberWithUnsignedLongLong:va_arg(args, unsigned long long)];
                    }
                    break;
                    
                case 'f': // %f
                    arg = [NSNumber numberWithDouble:va_arg(args, double)];
                    break;
                    
                case 'g': // %g
                    // warning: second argument to 'va_arg' is of promotable type 'float'; this va_arg has undefined behavior because arguments will be promoted to 'double'
// TODO error if pass an integer
                    arg = [NSNumber numberWithFloat:(float)(va_arg(args, double))];
                    break;
                    
                case 'l': // %l(d|u|(l(d|u))
                    sign = [sql characterAtIndex:occurenceRange.location+2];
                    if (sign == 'l') {
                        sign = [sql characterAtIndex:occurenceRange.location+3];
                        if (sign == 'd') //%lld
                        {
                            arg = [NSNumber numberWithLongLong:va_arg(args, long long)];
                        }
                        else if (sign == 'u') //%llu
                        {
                            arg = [NSNumber numberWithUnsignedLongLong:va_arg(args, unsigned long long)];
                        }
                    }
                    else if (sign == 'd') //%ld
                    {
                        arg = [NSNumber numberWithLong:va_arg(args, long)];
                    }
                    else if (sign == 'u') //%lu
                    {
                        arg = [NSNumber numberWithUnsignedLong:va_arg(args, unsigned long)];
                    }
                    break;
                    
                default:
                    // Something else that we can't interpret. Just pass it through.
                    break;
            }
            
            if (arg != nil)
            {
                [requestString replaceCharactersInRange:NSMakeRange(occurenceRange.location - ([sql length] - [requestString length]), 2) withString:@"?"];
                [[request arguments] addObject:arg];
            }
            
            @try
            {
                occurenceRange = [sql rangeOfString:@"%" options:NSCaseInsensitiveSearch range:NSMakeRange(occurenceRange.location + 1, [sql length] - occurenceRange.location - 1)];
            }
            @catch (NSException *e)
            {
                NSLog(@"Error : %@", [e description]);
                return nil;
            }
        }
        
        va_end(args);
        
        [request setRequestString:requestString];
        NSLog(@"Request : %@", [request request]);
        NSLog(@"Arguments : %@", [request arguments]);
    }
    
    return request;
}

@end
