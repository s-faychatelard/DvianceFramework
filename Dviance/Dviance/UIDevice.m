//
//  UIDevice.m
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 25/03/13.
//  Copyright (c) 2013 Dviance. All rights reserved.
//

#import "UIDevice.h"
#import "UIWindow.h"

#include <sys/types.h>
#include <sys/sysctl.h>

const CGFloat kDefaultRowHeight = 44.0f;

const CGFloat kDefaultPortraitToolbarHeight   = 44.0f;
const CGFloat kDefaultLandscapeToolbarHeight  = 33.0f;

const CGFloat kDefaultPortraitKeyboardHeight      = 216.0f;
const CGFloat kDefaultLandscapeKeyboardHeight     = 160.0f;
const CGFloat kDefaultPadPortraitKeyboardHeight   = 264.0f;
const CGFloat kDefaultPadLandscapeKeyboardHeight  = 352.0f;

const CGFloat kGroupedTableCellInset = 9.0f;
const CGFloat kGroupedPadTableCellInset = 42.0f;

const CGFloat kDefaultTransitionDuration      = 0.3f;
const CGFloat kDefaultFastTransitionDuration  = 0.2f;
const CGFloat kDefaultFlipTransitionDuration  = 0.7f;

@implementation UIDevice (dviance)

+ (float)osVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (BOOL)runtimeOSVersionIsAtLeastVersion:(float)version
{
    static const CGFloat kEpsilon = 0.0000001f;
    return [UIDevice osVersion] - version > -kEpsilon;
}

+ (BOOL)osVersionIsAtLeastVersion:(float)version
{
    // Floating-point comparison is pretty bad, so let's cut it some slack with an epsilon.
    static const CGFloat kEpsilon = 0.0000001f;
    
#ifdef __IPHONE_6_1
    return 6.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_6_0
    return 6.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_5_1
    return 5.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_5_0
    return 5.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_4_3
    return 4.3 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_4_2
    return 4.2 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_4_1
    return 4.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_4_0
    return 4.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_3_2
    return 3.2 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_3_1
    return 3.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_3_0
    return 3.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_2_2
    return 2.2 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_2_1
    return 2.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_2_0
    return 2.0 - version >= -kEpsilon;
#endif
    return NO;
}

+ (BOOL)isKeyboardVisible
{
    // Operates on the assumption that the keyboard is visible if and only if there is a first
    // responder; i.e. a control responding to key events
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    return !![window findFirstResponder];
}

+ (BOOL)isPhoneSupported
{
    return [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"];
}

+ (BOOL)isPad
{
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}

+ (BOOL)isMultiTaskingSupported
{
    UIDevice* device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ([device respondsToSelector:@selector(isMultitaskingSupported)]) {
        backgroundSupported = device.multitaskingSupported;
    }
    return backgroundSupported;
}

+ (UIDeviceOrientation)deviceOrientation
{
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationUnknown == o) {
        return UIDeviceOrientationPortrait;
    }
    else {
        return o;
    }
}

+ (BOOL)deviceOrientationIsPortrait
{
    UIDeviceOrientation o = [UIDevice deviceOrientation];
    
    switch (o)
    {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            return YES;
        default:
            return NO;
    }
}

+ (BOOL)deviceOrientationIsLandscape
{
    UIDeviceOrientation o = [UIDevice deviceOrientation];
    
    switch (o)
    {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            return YES;
        default:
            return NO;
    }
}

+ (NSString*)deviceModelName
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM rev A)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi rev A)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (Global)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    
    return platform;
}

+ (BOOL)isSupportedOrientation:(UIInterfaceOrientation)orientation
{
    if ([UIDevice isPad]) {
        return YES;
        
    }
    else {
        switch (orientation)
        {
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
                return YES;
            default:
                return NO;
        }
    }
}

+ (CGAffineTransform)rotateTransformForOrientation:(UIInterfaceOrientation)orientation
{
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
        
    }
    else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
        
    }
    else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
        
    }
    else {
        return CGAffineTransformIdentity;
    }
}

+ (CGRect)applicationFrame
{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    return CGRectMake(0, 0, frame.size.width, frame.size.height);
}

+ (CGFloat)toolbarHeightForOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation) || [UIDevice isPad]) {
        return kDefaultRowHeight;
        
    }
    else {
        return kDefaultLandscapeKeyboardHeight;
    }
}

+ (CGFloat)keyboardHeightForOrientation:(UIInterfaceOrientation)orientation
{
    if ([UIDevice isPad]) {
        return UIInterfaceOrientationIsPortrait(orientation) ? kDefaultPadPortraitKeyboardHeight
        : kDefaultPadLandscapeKeyboardHeight;
    }
    else {
        return UIInterfaceOrientationIsPortrait(orientation) ? kDefaultPortraitKeyboardHeight
        : kDefaultLandscapeKeyboardHeight;
    }
}

+ (CGFloat)groupedTableCellInset
{
    return [UIDevice isPad] ? kGroupedPadTableCellInset : kGroupedTableCellInset;
}

@end
