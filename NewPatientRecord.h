//
//  NewPatientRecord.h
//  doctornotes
//
//  Created by nareshit on 12/19/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewPatientRecord : NSObject
{
    NSString *firstNameValue;
    NSString *lastNameValue;
    NSString *emailValue;
    NSString *ageValue;
    NSString *phoneValue;
    NSString *currentDate;
    NSString *nextDate;
    NSString *genderValue;
    NSString *symptpmsValue;
    NSString *diseasesValue;
    NSString *drugsValue;
}
@property (nonatomic,retain)NSString *firstNameValue;
@property (nonatomic,retain)NSString *lastNameValue;
@property (nonatomic,retain)NSString *emailValue;
@property (nonatomic,retain)NSString *ageValue;
@property (nonatomic,retain)NSString *genderValue;
@property (nonatomic,retain)NSString *phoneValue;
@property (nonatomic,retain)NSString *currentDate;
@property (nonatomic,retain)NSString *nextDate;
@property (nonatomic,retain)NSString *symptomsValue;
@property (nonatomic,retain)NSString *diseasesValue;
@property (nonatomic,retain)NSString *drugsValue;


-(BOOL)isFirstNameFieldValid;
-(BOOL)isLastNameFieldValid;
-(BOOL)isFirstNameFieldMorethen64char;
-(BOOL)isLastNameFieldMorethen64char;
-(BOOL)isEmailFieldValid;
-(BOOL)isAgeFeildValid;
-(BOOL)isAgeFieldAlpha;
-(BOOL)isAgeValidRange;
-(BOOL)isPhoneFieldValid;
-(BOOL)isPhoneFieldAlpha;
-(BOOL)isPhoneFieldNot10char;

-(BOOL)isSymptomsFieldValid;
-(BOOL)isDiseasesFieldValid;
-(BOOL)isDrugsFieldValid;
-(BOOL)isNextDateFieldValid;


@end
