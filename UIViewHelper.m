//
//  UIViewHelper.m
//  doctornotes
//
//  Created by nareshit on 12/19/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "UIViewHelper.h"

@implementation UIViewHelper

+(UILabel*)makeLabelField:(NSString*)text placeholder:(NSString*)placeholderer{
    
    UILabel *lbl =[[[UILabel alloc]init]autorelease];
    [lbl setText:text];
    lbl.adjustsFontSizeToFitWidth = YES;
    lbl.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    return lbl ;    
}

+(UITextField*)createTextFeild:(NSString*)text placeholder:(NSString*)placeHolder withEditing:(BOOL)flag{
    
    UITextField *tf = [[[UITextField alloc] init]autorelease];
    [tf setEnabled:flag];
    [tf setPlaceholder:placeHolder];
    [tf setText:text];
    [tf setReturnKeyType:UIReturnKeyDone];
    tf.autocorrectionType = UITextAutocorrectionTypeNo ;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.textAlignment = NSTextAlignmentLeft;
    [tf setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [tf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    tf.adjustsFontSizeToFitWidth = YES;
    tf.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    return tf ;
}

+(UITextView*)makeTextView:(NSString*)text lines:(int)lines WithEditing:(BOOL)flag
    {
        UITextView *tf = [[[UITextView alloc] init]autorelease];
        [tf setText:text];
        [tf setEditable:flag];
        [tf setReturnKeyType:UIReturnKeyDone];
        [tf setBackgroundColor:[UIColor clearColor]];
        tf.autocorrectionType = UITextAutocorrectionTypeNo ;
        tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
        tf.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
        [tf setFont:[UIFont fontWithName:@"Helvetica" size:18.0]];
        return tf ;
            
}




@end
