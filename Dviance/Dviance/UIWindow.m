//
//  UIWindow.m
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 25/03/13.
//  Copyright (c) 2013 Dviance. All rights reserved.
//

#import "UIWindow.h"

@implementation UIWindow (dviance)

////
- (UIView*)findFirstResponder {
    return [self findFirstResponderInView:self];
}

////
- (UIView*)findFirstResponderInView:(UIView*)topView {
    if ([topView isFirstResponder]) {
        return topView;
    }
    
    for (UIView* subView in topView.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
        
        UIView* firstResponderCheck = [self findFirstResponderInView:subView];
        if (nil != firstResponderCheck) {
            return firstResponderCheck;
        }
    }
    return nil;
}

@end
