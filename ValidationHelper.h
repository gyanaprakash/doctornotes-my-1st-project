//
//  ValidationHelper.h
//  doctornotes
//
//  Created by nareshit on 12/20/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidationHelper : NSObject
{
}
+(BOOL)NSStringIsNotEmpty:(NSString*)string;
+(BOOL)NSSTRingIsExitMaxLenght:(NSString*)string Maxlenght:(int)lenght;
+(BOOL)NSStringIsNotNumber:(NSString*)string;
+(BOOL)NSStringIsNotRange:(NSString*)string;
+(BOOL)NSStringisEmailaddress:(NSString*)string;
+(BOOL)NSStringisNotEqlToSomeDigit:(NSString *)string;
+(BOOL)NSStringIsValidDate:(NSString*)string;
+(BOOL)NSDate:(NSDate*)date occursOnOrAfter:(NSDate*)matchDate;
+(NSString*)genRandStringLength:(int)len;
+(BOOL)NSStringIsValidDateFormat:(NSString *)string;
+(NSDate*)NSDateInUTCFromNSString:(NSString*)string;
+(NSDate*)NSDateInUTCForToday;

    


@end
