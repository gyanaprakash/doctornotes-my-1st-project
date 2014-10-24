//
//  UpdateViewController.h
//  doctornotes
//
//  Created by Balu on 14/01/14.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPatientRecord.h"
#import "UIViewHelper.h"

@interface UpdateViewController : UITableViewController<
UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate>
{
    NewPatientRecord *form;
    UISegmentedControl *gender;
    UITableView *insertTable;
    NSMutableDictionary *formLabels;
    UITextField *fnameTextfeild;
    UITextField *lnameTextfeild;
    UITextField *emailTextfeild;
    UITextField *ageTextfeild;
    UITextField *genderTextfield;
    UITextView *symptomsTextview;
    UITextView  *diseasesTextview;
    UIDatePicker *picker;
    UIActionSheet *actionSheet;
    
    BOOL formJustLoaded;
    BOOL FirstnameFieldValid;
    BOOL LastnameFieldValid;
    BOOL emailFieldValid;
    BOOL PhoneFieldValid;
    BOOL ageFieldValid;
    BOOL genderFieldValid;
    BOOL NextDateFieldValid;
    BOOL symptomsFeildValid;
    NSDate *selectedDate;
    NSString*lastappoinment;
    int dateIndex;
}
@property (strong) NSManagedObject *RecordData;
@property(nonatomic, retain)  UIActionSheet *actionSheet;
@property(nonatomic, retain) UIDatePicker *picker;
@property(nonatomic, retain) UITableView *insertTable;
@property(nonatomic, retain) UITextField *fnameTextfeild;
@property(nonatomic, retain) UITextField *lnameTextfeild;
@property(nonatomic, retain) UITextField *emailTextfeild;
@property(nonatomic, retain) UITextField *phoneTextfeild;
@property(nonatomic, retain) UITextField *ageTextfeild;
@property(nonatomic, retain) UITextField *genderTextfield;
@property(nonatomic, retain) UITextView *symptomsTextview;
@property(nonatomic, retain) UITextView  *diseasesTextview;
@property(nonatomic, retain) UITextView  *drugsTextView;
@property(nonatomic, retain) UITextField *nextDate;
@property(nonatomic,retain) NSArray *data;
@property (nonatomic,retain)  NewPatientRecord *form;
@property (nonatomic,retain) NSMutableDictionary *formLabels;
@property (nonatomic) BOOL formJustLoaded;
@property (nonatomic) BOOL isValid;
@property(nonatomic, retain) UIBarButtonItem *doneButton;
@property(nonatomic)BOOL FirstnameFieldValid;
@property(nonatomic)BOOL lnameFieldValid;
@property(nonatomic)BOOL NextDateFieldValid;
@property(nonatomic)BOOL emailFieldValid;
@property(nonatomic)BOOL PhoneFieldValid;
@property(nonatomic)BOOL ageFieldValid;
@property(nonatomic)BOOL symptomsFeildValid;
@property(nonatomic)BOOL diseasesFieldValid;
@property(nonatomic)BOOL drugsFieldValid;
-(void)onBackTouched:(id)sender;
-(void)onUpdateTouched:(id)sender;
-(void)onEditTouched:(id)sender;
@end
