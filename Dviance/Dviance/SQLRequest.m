//
//  SQLRequest.m
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 26/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import "SQLRequest.h"

#import "NSString.h"

@implementation SQLRequest

+ (id)requestWithSQL:(NSString*)sql, ...
{
    SQLRequest *request = [SQLRequest alloc];
    if (request)
    {
        va_list args;
        va_start(args, sql);
        
        int args_iterator = 0;
        NSRange range = NSMakeRange(0, [sql length]);
        NSRange occurenceRange = [sql rangeOfString:@"%" options:NSCaseInsensitiveSearch range:range];
        while (occurenceRange.location != NSNotFound)
        {
            unichar caracter = [sql characterAtIndex:occurenceRange.location+1];
            
            NSLog(@"%c", caracter);
            
            range.location = occurenceRange.location + 1;
            if (range.location >= [sql length]) break;
            occurenceRange = [sql rangeOfString:@"%" options:NSCaseInsensitiveSearch range:range];
            args_iterator++;
        }
        /*NSUInteger length = [sql length];
        unichar last = '\0';
        for (NSUInteger i = 0; i < length; ++i) {
            id arg = nil;
            unichar current = [sql characterAtIndex:i];
            unichar add = current;
            if (last == '%') {
                switch (current) {
                    case '@':
                        arg = va_arg(args, id);
                        break;
                    case 'c':
                        // warning: second argument to 'va_arg' is of promotable type 'char'; this va_arg has undefined behavior because arguments will be promoted to 'int'
                        arg = [NSString stringWithFormat:@"%c", va_arg(args, int)];
                        break;
                    case 's':
                        arg = [NSString stringWithUTF8String:va_arg(args, char*)];
                        break;
                    case 'd':
                    case 'D':
                    case 'i':
                        arg = [NSNumber numberWithInt:va_arg(args, int)];
                        break;
                    case 'u':
                    case 'U':
                        arg = [NSNumber numberWithUnsignedInt:va_arg(args, unsigned int)];
                        break;
                    case 'h':
                        i++;
                        if (i < length && [sql characterAtIndex:i] == 'i') {
                            //  warning: second argument to 'va_arg' is of promotable type 'short'; this va_arg has undefined behavior because arguments will be promoted to 'int'
                            arg = [NSNumber numberWithShort:(short)(va_arg(args, int))];
                        }
                        else if (i < length && [sql characterAtIndex:i] == 'u') {
                            // warning: second argument to 'va_arg' is of promotable type 'unsigned short'; this va_arg has undefined behavior because arguments will be promoted to 'int'
                            arg = [NSNumber numberWithUnsignedShort:(unsigned short)(va_arg(args, uint))];
                        }
                        else {
                            i--;
                        }
                        break;
                    case 'q':
                        i++;
                        if (i < length && [sql characterAtIndex:i] == 'i') {
                            arg = [NSNumber numberWithLongLong:va_arg(args, long long)];
                        }
                        else if (i < length && [sql characterAtIndex:i] == 'u') {
                            arg = [NSNumber numberWithUnsignedLongLong:va_arg(args, unsigned long long)];
                        }
                        else {
                            i--;
                        }
                        break;
                    case 'f':
                        arg = [NSNumber numberWithDouble:va_arg(args, double)];
                        break;
                    case 'g':
                        // warning: second argument to 'va_arg' is of promotable type 'float'; this va_arg has undefined behavior because arguments will be promoted to 'double'
                        arg = [NSNumber numberWithFloat:(float)(va_arg(args, double))];
                        break;
                    case 'l':
                        i++;
                        if (i < length) {
                            unichar next = [sql characterAtIndex:i];
                            if (next == 'l') {
                                i++;
                                if (i < length && [sql characterAtIndex:i] == 'd') {
                                    //%lld
                                    arg = [NSNumber numberWithLongLong:va_arg(args, long long)];
                                }
                                else if (i < length && [sql characterAtIndex:i] == 'u') {
                                    //%llu
                                    arg = [NSNumber numberWithUnsignedLongLong:va_arg(args, unsigned long long)];
                                }
                                else {
                                    i--;
                                }
                            }
                            else if (next == 'd') {
                                //%ld
                                arg = [NSNumber numberWithLong:va_arg(args, long)];
                            }
                            else if (next == 'u') {
                                //%lu
                                arg = [NSNumber numberWithUnsignedLong:va_arg(args, unsigned long)];
                            }
                            else {
                                i--;
                            }
                        }
                        else {
                            i--;
                        }
                        break;
                    default:
                        // something else that we can't interpret. just pass it on through like normal
                        break;
                }
            }
            else if (current == '%') {
                // percent sign; skip this character
                add = '\0';
            }
            
            if (arg != nil) {
                [cleanedSQL appendString:@"?"];
                [arguments addObject:arg];
            }
            else if (add != '\0') {
                [cleanedSQL appendFormat:@"%C", add];
            }
            last = current;
        }*/
        
        va_end(args);
    }
    return request;
}

@end
