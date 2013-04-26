//
//  UIWindow.h
//  Dviance
//
//  Thanks to Three20
//
//  Created by Sylvain FAY-CHATELARD on 25/03/13.
//  Copyright (c) 2013 Dviance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (dviance)

/**
 * Searches the view hierarchy recursively for the first responder, starting with this window.
 */
- (UIView*)findFirstResponder;

/**
 * Searches the view hierarchy recursively for the first responder, starting with topView.
 */
- (UIView*)findFirstResponderInView:(UIView*)topView;

@end
