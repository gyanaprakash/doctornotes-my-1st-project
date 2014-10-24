//
//  AppointmentUpdate.h
//  doctornotes
//
//  Created by Balu on 09/01/14.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentUpdate : UITableViewController<UIActionSheetDelegate,UITextFieldDelegate>
{
    NSMutableDictionary *formLabels;
    UITextField *fnameTextfeild;
    UITextField *lnameTextfeild;
    UITextField *emailTextfeild;
    UITextField *ageTextfeild;
    UITextField *genderTextfield;
    UITextView  *symptomsTextview;
    UIDatePicker *picker;
    UIActionSheet *actionSheet;
    NSDate *selectedDate;
    NSManagedObject*selectedData;
    UITextField*PhoneTextfeild;
    UITextView*DiseasesTextview;
    UITextView*drugsTextView;
    UITextField*NextDate;
    NSString*lastappoinment;
}
@property(strong)NSManagedObject*selectedData;
@property(nonatomic,retain)UISegmentedControl *gender;
@property(nonatomic,retain)NSMutableDictionary *formLabels;
@property(nonatomic,retain)UITextField *fnameTextfeild;
@property(nonatomic,retain)UITextField *lnameTextfeild;
@property(nonatomic,retain)UITextField *emailTextfeild;
@property(nonatomic,retain)UITextField *ageTextfeild;
@property(nonatomic,retain)UITextField *genderTextfield;
@property(nonatomic,retain)UITextView  *symptomsTextview;
@property(nonatomic,retain)UIDatePicker *picker;
@property(nonatomic,retain)UIActionSheet *actionSheet;
@property(nonatomic,retain)UITextField*PhoneTextfeild;
@property(nonatomic,retain)UITextView*DiseasesTextview;
@property(nonatomic,retain) UITextView*drugsTextView;
@property(nonatomic,retain)UITextField*NextDate;
@end
