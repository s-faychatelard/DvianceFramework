//
//  UIAlert.h
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 26/03/13.
//  Copyright (c) 2013 Dviance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (dviance)

/** @name Alert */

/**
 * A convenient way to show a UIAlertView with a message.
 * Default title is @"Alert"
 * Default button is @"OK"
 *
 * @param message, message to print
 *
 * @sa alertWithoutTitle:
 */
+(void)alert:(NSString*)message;

/**
 * Same as alert: but the alert view has no title.
 * Default button is @"OK"
 *
 * @param message, message to print
 *
 * @sa alert:
 */
+(void)alertWithoutTitle:(NSString*)message;

@end
