//
//  ValidationHelper.m
//  doctornotes
//
//  Created by nareshit on 12/20/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "ValidationHelper.h"

@implementation ValidationHelper
+(BOOL)NSStringIsNotEmpty:(NSString*)string
{
    return ([string isEqualToString:@""])?FALSE:TRUE;
}
+(BOOL)NSSTRingIsExitMaxLenght:(NSString*)string Maxlenght:(int)lenght
{
    return ([string length]>lenght?FALSE:TRUE);
}
+(BOOL)NSStringIsNotNumber:(NSString*)string
{
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:string];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    return (!valid? FALSE:TRUE);
}
+(BOOL)NSStringIsNotRange:(NSString*)string
{
    int range=[string intValue];
    BOOL valid;
    valid=(range>0&&range<105)?TRUE:FALSE;
    return (!valid?FALSE:TRUE);
}
+(BOOL)NSStringisEmailaddress:(NSString*)string
{
    
    BOOL valid;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    valid = [emailTest evaluateWithObject:string];
    NSLog(@"yy%c",valid);
    return ( !valid? FALSE:TRUE);
}
+(BOOL)NSStringisNotEqlToSomeDigit:(NSString *)string
{
    int l=[string length];
    return l!=10?FALSE:TRUE;
}
+(BOOL)NSStringIsValidDate:(NSString*)string
{
    BOOL valid = NO;
    NSDate *date=nil;
    
    valid = [ValidationHelper NSStringIsNotEmpty:string];
    
    //  If first check passed!
    if(valid==TRUE){
        if([ValidationHelper NSStringIsValidDateFormat:string])
        {
            
        }
        else
        {
            valid = FALSE;
        }
    }
    
    //  Third Check! - is an actual real date! i.e. the days, months and year are in realistic ranges
    if(valid==TRUE){
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormat setTimeZone:timeZone];
        
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        date = [[dateFormat dateFromString:string]autorelease];
        
        if(date==NULL){
            valid=FALSE;
        }
    }
    
    return valid;
}

+(BOOL)NSDate:(NSDate*)date occursOnOrAfter:(NSDate*)matchDate;
{
    
    BOOL valid = FALSE;
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [calendar setTimeZone:timeZone];
    
    NSDateComponents* components = [calendar components:flags fromDate:matchDate];
    NSDate *dateOnly = [calendar dateFromComponents:components];
    
    NSDateComponents* dComponents = [calendar components:flags fromDate:date];
    NSDate *matchDateOnly = [calendar dateFromComponents:dComponents];
    
    if([dateOnly compare:matchDateOnly]== NSOrderedSame || [dateOnly compare:matchDateOnly]== NSOrderedAscending){
        valid=TRUE;
    }
    return valid;
    
    
}
+(NSString*)genRandStringLength:(int)len
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

+(BOOL)NSStringIsValidDateFormat:(NSString *)string
{
    NSString *dateRegex = @"^[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]$";
    
    //NSPredicate *dateTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", dateRegex];
    //    return [dateTest evaluateWithObject:string];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:dateRegex options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string
                                                        options:0
                                                          range:NSMakeRange(0, [string length])];
    
    return (numberOfMatches==1)?TRUE:FALSE;
}

+(NSDate*)NSDateInUTCFromNSString:(NSString*)string
{
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init]autorelease];
    NSTimeZone *timeZone = [[NSTimeZone timeZoneWithName:@"UTC"]autorelease];
    
    //  Configure timezone for UTC!!!
    [dateFormat setTimeZone:timeZone];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    //  Create date and get todays
    NSDate *date = [[dateFormat dateFromString:string]autorelease];
    
    return date;
}

+(NSDate*)NSDateInUTCForToday
{
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init]autorelease];
    NSTimeZone *timeZone = [[NSTimeZone timeZoneWithName:@"UTC"]autorelease];
    //nsstrjhbf
    
    //  Configure timezone for UTC!!!
    [dateFormat setTimeZone:timeZone];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *todaysDate = [[NSDate date]autorelease];
    return todaysDate;
}
+(NSString*)NSDateFromStringInShortFormat:(NSDate*)date
{
    NSLog(@"Converting a date %@ to string",date);
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [[dateFormatter stringFromDate:date]autorelease];
    NSLog(@"Date String is %@", strDate);
    return strDate;
}

@end
