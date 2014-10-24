//
//  UIViewHelper.h
//  doctornotes
//
//  Created by nareshit on 12/19/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewHelper : NSObject
+(UILabel*)makeLabelField:(NSString*)text placeholder:(NSString*)placeholdere;

+(UITextField*)createTextFeild:(NSString*)textFeild placeholder:(NSString*)placeHolder withEditing:(BOOL)flag;


+(UITextView*)makeTextView:(NSString*)text lines:(int)lines WithEditing:(BOOL)flag;

@end
