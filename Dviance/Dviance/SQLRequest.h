//
//  SQLRequest.h
//  Dviance
//
//  Created by Sylvain FAY-CHATELARD on 26/04/13.
//  Copyright (c) 2013 dviance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLRequest : NSObject

+(id)requestWithSQL:(NSString*)sql, ...;

//-(id)requestInsertInto:(NSString*)table andValues:...;
//-(id)requestUpdateWithValues:...;

@end
