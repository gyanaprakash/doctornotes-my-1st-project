//
//  AddPatientViewController.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewHelper.h"
#import "NewPatientRecord.h"

//***********************************************************************************************

@protocol AddPatientViewControllerDelegate<NSObject>

//***********************************************************************************************

-(void)formDidCancel;
-(void)formDidCompleteWithForm:(NewPatientRecord *)form;

//***********************************************************************************************

@end
//***********************************************************************************************

@interface AddPatientViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

//***********************************************************************************************

{
    NewPatientRecord *form;
    id<AddPatientViewControllerDelegate> delegate;
    UISegmentedControl *gender;
    NSMutableDictionary *formLabels;
    UIActionSheet *actionSheet;
    
    IBOutlet UIView *viewAlert;
    BOOL formJustLoaded;
    
    NSDate *selectedDate;
 }

//***********************************************************************************************

@property (nonatomic,retain)  NewPatientRecord *form;
@property (nonatomic,retain) id<AddPatientViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UIScrollView *Scroll;
@property (retain, nonatomic) IBOutlet UISegmentedControl *gender;

@property (nonatomic) BOOL formJustLoaded;
@property (nonatomic) BOOL isValid;
@property (retain, nonatomic) IBOutlet UITextField *fnameTextfeild;
@property (retain, nonatomic) IBOutlet UITextField *lnameTextfeild;
@property (retain, nonatomic) IBOutlet UITextField *emailTextfeild;
@property (retain, nonatomic) IBOutlet UITextField *ageTextfeild;
@property (retain, nonatomic) IBOutlet UITextField *phoneTextfeild;
@property (retain, nonatomic) IBOutlet UITextView *symptomsTextview;
@property (retain, nonatomic) IBOutlet UITextView *diseasesTextview;
@property (retain, nonatomic) IBOutlet UITextView *drugsTextView;

@property (retain, nonatomic) IBOutlet UITextField *nextDate;

@property (nonatomic,retain) NSMutableDictionary *formLabels;
@property (retain, nonatomic) IBOutlet UIButton *savebutton;
@property (retain, nonatomic) IBOutlet UIButton *BackButton;
@property (retain, nonatomic) IBOutlet UITextField *genderfld;

@property (retain, nonatomic) IBOutlet UILabel *firstnamelbl;
@property (retain, nonatomic) IBOutlet UILabel *lastname;
@property (retain, nonatomic) IBOutlet UILabel *emailflbl;
@property (retain, nonatomic) IBOutlet UILabel *agelbl;
@property (retain, nonatomic) IBOutlet UILabel *phonelbl;
@property (retain, nonatomic) IBOutlet UILabel *genderlbl;
@property (retain, nonatomic) IBOutlet UILabel *symtomslbl;
@property (retain, nonatomic) IBOutlet UILabel *diseas;
@property (retain, nonatomic) IBOutlet UILabel *druglbl;
@property (retain, nonatomic) IBOutlet UILabel *nextdatelbl;

//***********************************************************************************************

- (IBAction)SaveButtonClick:(UIButton *)sender;
- (IBAction)BackButtonClicked:(id)sender;
- (IBAction)datepicker:(UIButton *)sender;

//***********************************************************************************************

@end
