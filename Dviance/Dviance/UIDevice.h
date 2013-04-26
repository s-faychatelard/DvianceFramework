//
//  UIDevice.h
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 25/03/13.
//  Copyright (c) 2013 Dviance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#ifdef UI_DEVICE_H
#define UI_DEVICE_H

////
// Dimensions of common iPhone OS Views

/**
 * The standard height of a row in a table view controller.
 * @const 44 pixels
 */
extern const CGFloat kDefaultRowHeight;

/**
 * The standard height of a toolbar in portrait orientation.
 * @const 44 pixels
 */
extern const CGFloat kDefaultPortraitToolbarHeight;

/**
 * The standard height of a toolbar in landscape orientation.
 * @const 33 pixels
 */
extern const CGFloat kDefaultLandscapeToolbarHeight;

/**
 * The standard height of the keyboard in portrait orientation.
 * @const 216 pixels
 */
extern const CGFloat kDefaultPortraitKeyboardHeight;

/**
 * The standard height of the keyboard in landscape orientation.
 * @const 160 pixels
 */
extern const CGFloat kDefaultLandscapeKeyboardHeight;

/**
 * The space between the edge of the screen and the cell edge in grouped table views.
 * @const 10 pixels
 */
extern const CGFloat kGroupedTableCellInset;

////
// Animation

/**
 * The standard duration length for a transition.
 * @const 0.3 seconds
 */
extern const CGFloat kDefaultTransitionDuration;

/**
 * The standard duration length for a fast transition.
 * @const 0.2 seconds
 */
extern const CGFloat kDefaultFastTransitionDuration;

/**
 * The standard duration length for a flip transition.
 * @const 0.7 seconds
 */
extern const CGFloat kDefaultFlipTransitionDuration;

#endif




////
// UIDevice

@interface UIDevice (dviance)

/**
 * @return the current runtime version of the iPhone OS.
 */
+(float)osVersion;

/**
 * Checks if the run-time version of the OS is at least a certain version.
 */
+(BOOL)runtimeOSVersionIsAtLeastVersion:(float)version;

/**
 * Checks if the link-time version of the OS is at least a certain version.
 */
+(BOOL)osVersionIsAtLeastVersion:(float)version;

/**
 * @return YES if the keyboard is visible.
 */
+(BOOL)isKeyboardVisible;

/**
 * @return YES if the device has phone capabilities.
 */
+(BOOL)isPhoneSupported;

/**
 * @return YES if the device is an iPad.
 */
+(BOOL)isPad;

/**
 * @return YES if the device supports multitasking mode
 */
+(BOOL)isMultiTaskingSupported;

/**
 * @return the current device orientation.
 */
+(UIDeviceOrientation)deviceOrientation;

/**
 * @return YES if the current device orientation is portrait or portrait upside down.
 */
+(BOOL)deviceOrientationIsPortrait;


/**
 * @return YES if the current device orientation is landscape left, or landscape right.
 */
+(BOOL)deviceOrientationIsLandscape;

/**
 * @return the device full model name in human readable strings
 */
+(NSString*)deviceModelName;

/**
 * On iPhone/iPod touch
 * Checks if the orientation is portrait, landscape left, or landscape right.
 * This helps to ignore upside down and flat orientations.
 *
 * On iPad:
 * Always returns Yes.
 */
+(BOOL)isSupportedOrientation:(UIInterfaceOrientation)orientation;

/**
 * @return the rotation transform for a given orientation.
 */
+(CGAffineTransform)rotateTransformForOrientation:(UIInterfaceOrientation)orientation;

/**
 * @return the application frame with no offset.
 *
 * Note :
 * From the Apple docs:
 * Frame of application screen area in points (i.e. entire screen minus status bar if visible)
 */
+(CGRect)applicationFrame;

/**
 * @return the toolbar height for a given orientation.
 *
 * Note :
 * The toolbar is slightly shorter in landscape.
 */
+(CGFloat)toolbarHeightForOrientation:(UIInterfaceOrientation)orientation;

/**
 * @return the height of the keyboard for a given orientation.
 */
+(CGFloat)keyboardHeightForOrientation:(UIInterfaceOrientation)orientation;

/**
 * @return the space between the edge of the screen and a grouped table cell. Larger on iPad.
 */
+(CGFloat)groupedTableCellInset;

@end
