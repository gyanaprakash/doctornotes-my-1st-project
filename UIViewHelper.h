//
//  UIViewHelper.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewHelper : NSObject

+(UILabel*)makeLabelField:(NSString*)text placeholder:(NSString*)placeholdere;

+(UITextField*)createTextFeild:(NSString*)textFeild placeholder:(NSString*)placeHolder withEditing:(BOOL)flag;


+(UITextView*)makeTextView:(NSString*)text lines:(int)lines WithEditing:(BOOL)flag;

@end
