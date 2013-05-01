//
//  SQLRequest.h
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 26/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLRequest : NSObject

@property (nonatomic, strong, getter = request) NSString *requestString;
@property (nonatomic, strong) NSMutableArray *arguments;

/**
 * WARNING : Cast int to float or double if needed !
 */
+(id)requestWithSQL:(NSString*)sql, ...;

//-(id)requestInsertInto:(NSString*)table andValues:...;
//-(id)requestUpdateWithValues:...;

@end
