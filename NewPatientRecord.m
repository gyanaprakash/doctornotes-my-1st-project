//
//  NewPatientRecord.m
//  doctornotes
//
//  Created by nareshit on 12/19/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "NewPatientRecord.h"
#import "ValidationHelper.h"
#import "UIViewHelper.h"

@implementation NewPatientRecord


@synthesize firstNameValue;
@synthesize lastNameValue;
@synthesize emailValue;
@synthesize phoneValue;
@synthesize currentDate;
@synthesize nextDate;
@synthesize ageValue,genderValue,symptomsValue,drugsValue,diseasesValue;
-(id)init
{
    if((self = [super init]))
    {
        [self setFirstNameValue:@""];
        [self setLastNameValue:@""];
        [self setEmailValue:@""];
        [self setAgeValue:@""];
        [self setPhoneValue:@""];
        [self setGenderValue:@""];
        [self setDiseasesValue:@""];
        [self setSymptomsValue:@""];
        [self setNextDate:@""];
        [self setDrugsValue:@""];
        [self setCurrentDate:@""];
        



    }
    return self;
}
-(BOOL)isFirstNameFieldValid
{
  return [ValidationHelper NSStringIsNotEmpty:self.firstNameValue];
    
}
-(BOOL)isLastNameFieldValid
{
   return [ValidationHelper NSStringIsNotEmpty:self.lastNameValue];
    
}
-(BOOL)isFirstNameFieldMorethen64char
{
    return [ValidationHelper NSSTRingIsExitMaxLenght:self.firstNameValue Maxlenght:64];
}
-(BOOL)isLastNameFieldMorethen64char
{
    return [ValidationHelper NSSTRingIsExitMaxLenght:self.lastNameValue Maxlenght:64];
}
-(BOOL)isEmailFieldValid
{
  return [ValidationHelper NSStringisEmailaddress:self.emailValue];
}
-(BOOL)isPhoneFieldValid
{
    return [ValidationHelper NSStringIsNotEmpty:self.phoneValue];
}
-(BOOL)isPhoneFieldNot10char
{
    return [ValidationHelper NSStringisNotEqlToSomeDigit:self.phoneValue];
}
-(BOOL)isPhoneFieldAlpha
{
return [ValidationHelper NSStringIsNotNumber:self.phoneValue];
}
-(BOOL)isAgeFeildValid
{
    return [ValidationHelper NSStringIsNotEmpty:self.ageValue];
}
-(BOOL)isAgeFieldAlpha
{
    return [ValidationHelper NSStringIsNotNumber:self.ageValue];
}
-(BOOL)isAgeValidRange
{
    return [ValidationHelper NSStringIsNotRange:self.ageValue];
}
-(BOOL)isSymptomsFieldValid
{
  return [ValidationHelper NSStringIsNotEmpty:self.symptomsValue];
}
-(BOOL)isDiseasesFieldValid
{
  return [ValidationHelper NSStringIsNotEmpty:self.diseasesValue];
}
-(BOOL)isDrugsFieldValid
{
  return [ValidationHelper NSStringIsNotEmpty:self.drugsValue];
}
-(BOOL)isNextDateFieldValid
{
    return [ValidationHelper NSStringIsNotEmpty:self.nextDate];
}


@end
