//
//  AddPatientViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "AddPatientViewController.h"
#import "EmiModal.h"
#import "UIViewHelper.h"
#import "NewPatientRecord.h"
#import "ValidationHelper.h"
#import "AppDelegate.h"
//***********************************************************************************************

@interface AddPatientViewController ()<NSFileManagerDelegate>
{
    NSString *name;
}
@end

@implementation AddPatientViewController

//***********************************************************************************************

@synthesize gender,emailTextfeild,genderfld,ageTextfeild,phoneTextfeild,symptomsTextview,diseasesTextview,drugsTextView,nextDate,delegate,form,isValid,formJustLoaded,formLabels,Scroll,lnameTextfeild,lastname,fnameTextfeild;

@synthesize firstnamelbl,emailflbl,phonelbl,agelbl,genderlbl,symtomslbl,diseas,druglbl;

//***********************************************************************************************

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.form=[[[NewPatientRecord alloc]init]autorelease];

        [self.form setFirstNameValue:@""];
        [self.form setLastNameValue:@""];
        [self.form setEmailValue:@""];
        [self.form setAgeValue:@""];
        [self.form setGenderValue:@""];
        [self.form setPhoneValue:@""];
        [self.form setSymptomsValue:@""];
        [self.form setDiseasesValue:@""];
        [self.form setDrugsValue:@""];
        [self.form setNextDate:@""];
        [self.form setCurrentDate:@""];
        [self setFormLabels:[NSMutableDictionary dictionary]];
        [self setFormJustLoaded:NO];
        [self setIsValid:NO];
    }
    return self;
}

//***********************************************************************************************

- (void)viewDidLoad
{
    [self.savebutton setUserInteractionEnabled:NO];

    [nextDate setDelegate:self];
    [nextDate setBackgroundColor:[UIColor clearColor]];
    NSDateFormatter *dfm = [[NSDateFormatter alloc]init];
    [dfm setDateFormat:@"dd/MM/yyyy"];
    nextDate.text=[dfm stringFromDate:[NSDate date]];

    [gender.layer setCornerRadius:7.0];
    [gender setClipsToBounds:YES];

	// Do any additional setup after loading the view.
    [Scroll setContentSize:CGSizeMake(320, 850)];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewValueChanged:) name:UITextViewTextDidChangeNotification object:nil];
     UIView *tf=nil;
    tf = [UIViewHelper createTextFeild:@"" placeholder:@"First Name" withEditing:YES];
    [self setFnameTextfeild:(UITextField*)tf];
    [fnameTextfeild setDelegate:self];

    [self.fnameTextfeild setBackgroundColor:[UIColor clearColor]];

    tf = [UIViewHelper createTextFeild:@"" placeholder:@"Last Name" withEditing:YES];
    [self setLnameTextfeild:(UITextField*)tf];
    [lnameTextfeild setDelegate:self];
 
    tf = [UIViewHelper createTextFeild:@"" placeholder:@"Email" withEditing:YES];
    [self setEmailTextfeild:(UITextField*)tf];
    [emailTextfeild setDelegate:self];
 
    tf = [UIViewHelper createTextFeild:@"" placeholder:@"Age" withEditing:YES];
    [self setAgeTextfeild:(UITextField*)tf];
    [ageTextfeild setDelegate:self];
    
    gender =[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Male", @"Female", nil]];
    gender.selectedSegmentIndex=0;
    [gender setUserInteractionEnabled:YES];

    tf = [UIViewHelper createTextFeild:@"" placeholder:@"Phone" withEditing:YES];
    [self setPhoneTextfeild:(UITextField*)tf];
    [self.phoneTextfeild setDelegate:self];
    
    tf =[UIViewHelper makeTextView:@"" lines:15 WithEditing:YES];
    [self setSymptomsTextview:(UITextView *)tf];
    [self.symptomsTextview setDelegate:self];
    
    tf =[UIViewHelper makeTextView:@"" lines:15 WithEditing:YES];
    [self setDiseasesTextview:(UITextView *)tf];
    [self.diseasesTextview setDelegate:self];
    
    tf =[UIViewHelper makeTextView:@"" lines:15 WithEditing:YES];
    [self setDrugsTextView:(UITextView*)tf];
    [self.drugsTextView setDelegate:self];
    
    tf = [UIViewHelper createTextFeild:@"" placeholder:@"Next Visit " withEditing:YES];
    [self setNextDate:(UITextField*)tf];
    [nextDate setDelegate:self];
    
    [super viewDidLoad];
}

//***********************************************************************************************

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma -Mark ButtonAction Handling
//***********************************************************************************************

- (IBAction)BackButtonClicked:(id)sender
{
    POP_TO_VIEWCONTROLLER_ANIMATED;
}

//***********************************************************************************************

- (IBAction)datepicker:(UIButton *)sender
{
    UIDatePicker *date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 400, 320, 100)];
    [date setBackgroundColor:[UIColor greenColor]];
    date.datePickerMode=UIDatePickerModeDate;
    [self.view addSubview:date];
}

- (IBAction)SaveButtonClick:(UIButton *)sender
{
    NSString *msg = self.fnameTextfeild.text;
    NSLog(@"GYANNA = %@",msg);
    
    AppDelegate*appobj=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appobj managedObjectContext];
    NSManagedObject *newrecord = [NSEntityDescription insertNewObjectForEntityForName:@"PATIENT" inManagedObjectContext:context];
    [newrecord setValue:self.form.firstNameValue forKey:@"firstname"];
    [newrecord setValue:self.form.lastNameValue forKey:@"lastname"];
    [newrecord setValue:self.form.emailValue forKey:@"email"];
    [newrecord setValue:self.form.ageValue forKey:@"age"];
    [newrecord setValue:self.form.phoneValue forKey:@"phone"];
    
    id gend;
    if (gender.selectedSegmentIndex == 0)
    {
        gend = @"Male";
    }
    else{
        gend = @"Female";
    }
    [newrecord setValue:gend forKey:@"gender"];
    
    [newrecord setValue:self.form.symptomsValue forKey:@"symptoms"];
    [newrecord setValue:self.form.diseasesValue forKey:@"diseases"];
    [newrecord setValue:self.form.drugsValue forKey:@"drugs"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    //NSString*datestring=[formatter stringFromDate:[self.picker date]];
    //selectedDate = [NSDate date];
    [newrecord  setValue:selectedDate forKey:@"currentdate"];
    
    //[newrecord setValue:datestring forKey:@"nextdate"];
    [newrecord setValue:[NSDate date] forKey:@"currentdate"];

    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else
    {
        NSManagedObject *visitedrecord = [NSEntityDescription insertNewObjectForEntityForName:@"VISITED" inManagedObjectContext:context];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        NSString*datestring=[formatter stringFromDate:[NSDate date]];
        [visitedrecord setValue:datestring forKey:@"vdate"];
        NSString *moID= [[[newrecord objectID]URIRepresentation]absoluteString];
        [visitedrecord setValue:moID forKey:@"pid"];
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error])
        {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
    ALERT_VIEW(@"DATA SAVED FOR", msg);
}

#pragma Keyboard Notication Handling
//***********************************************************************************************

- (void)keyboardWasShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 220.0, 0.0);
   self.Scroll.contentInset = contentInsets;
    self.Scroll.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    
}
//***********************************************************************************************

- (void) keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.Scroll.contentInset = contentInsets;
    self.Scroll.scrollIndicatorInsets = contentInsets;
}

#pragma -mark UITextField Delegate
//***********************************************************************************************

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}
//***********************************************************************************************

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.formJustLoaded==NO)
    {
        /*
        //custome alert view...
//        for (id object in [viewAlert subviews]) {
//            
//            if ([object isKindOfClass:[UIView class]]) {
//                
//                UIView *vw1 = (UIView *) object;
//                [vw1.layer setCornerRadius:4.0f];
//                [vw1 setClipsToBounds:YES];
//            }
//        }
//        
//        [viewAlert setFrame:self.view.frame];
//        [self.view addSubview:viewAlert];

        */
        //  First Name Field

        if(textField.tag==10)
        {
            fnameTextfeild=[self.formLabels objectForKey:@"First Name"];
        }
        //Last Name Field
        else if(textField.tag==20)
        {
            lnameTextfeild=[self.formLabels objectForKey:@"Last Name"];
        }
        //  Email Field
      else if(textField.tag==30)
        {
            emailTextfeild=[self.formLabels objectForKey:@"Email"];
        }
        //Age Field
      else if(textField.tag==40)
        {
            ageTextfeild=[self.formLabels objectForKey:@"Age"];
        }
      else if(textField.tag==50)
        {
            phoneTextfeild=[self.formLabels objectForKey:@"Phone"];
        }
        // next Date
        else if(textField.tag==60)
        {
            

            //[textField resignFirstResponder];
//                    
//            actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
//            
//            actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
//            
//            [actionSheet setBackgroundColor:[UIColor grayColor]];
//            [actionSheet setAlpha:1];
//            [actionSheet setDelegate:self];
//            
//            picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(30 ,0, 120, 220)];
//            picker.datePickerMode=UIDatePickerModeDate;
//            
//            CGRect frame = self.picker.frame;
//            frame.size.width = 50;
//            frame.size.height = 100;
//            [picker setFrame: frame];
//
//            [picker addTarget:self action:@selector
//             (pickerChanged:) forControlEvents:UIControlEventValueChanged];
//            [self.nextDate setInputView:picker];
//            
//            [actionSheet addSubview:picker];
//            [self.view addSubview:actionSheet];
//            [actionSheet showInView:self.view];
//            
//            CGRect menuRect = actionSheet.frame;
//            CGFloat orgHeight = menuRect.size.height;
//            menuRect.origin.y -= 160;
//            //height of picker
//            menuRect.size.height = orgHeight+214;
//            actionSheet.frame = menuRect;
//            
//            CGRect pickerRect = picker.frame;
//            pickerRect.origin.y = orgHeight;
//            picker.frame = pickerRect;
        }
    }
}
//***********************************************************************************************

- (void)pickerChanged:(id)sender
{
    NSLog(@"value: %@",[sender date]);
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
   // self.nextDate.text = [dateFormatter stringFromDate:[self.picker date]];
}
//***********************************************************************************************

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    name = fnameTextfeild.text;
    NSNotification *notification = [NSNotification notificationWithName:@"Custom" object:textField];
    [self textFieldValueChanged:notification];
}
//***********************************************************************************************

- (void)textFieldValueChanged:(NSNotification *)notification
{
    UITextField *textField = (UITextField*)notification.object;
    BOOL valid;
    if(self.formJustLoaded==NO)
    {
        //  First store field values!
        {
            switch (textField.tag) {
                case 10:
                    [self.form setFirstNameValue:textField.text];
                    break;
                case 20:
                    [self.form setLastNameValue:textField.text];
                    break;
                case 30:
                    [self.form setEmailValue:textField.text];
                    break;
                case 40:
                    [self.form setAgeValue:textField.text];
                    break;
                case 50:
                    [self.form setPhoneValue:textField.text];
                    break;
                case 60:
                    [self.form setNextDate:textField.text];
                    break;
                default:
                    break;
            }
        }
        //   validate data 
        {
            //  First Name Field
            if(textField.tag == 10)
            {
                valid=[self.form isFirstNameFieldValid];
                if(valid==NO)
                {
                    [firstnamelbl setTextColor:[UIColor redColor]];
                }
                else
                {
                valid=[self.form isFirstNameFieldMorethen64char];
                    if(valid==NO)
                    {
                        [firstnamelbl setTextColor:[UIColor redColor]];
                    }
                    else
                    {
                    [firstnamelbl setTextColor:[UIColor whiteColor]];
                    }
                }
            }
            
          //  Last Name Field
            if(textField.tag == 20)
            {
                valid=[self.form isLastNameFieldValid];
                if(valid==NO)
                {
                    [lastname setTextColor:[UIColor redColor]];
                }
                else
                {
                valid=[self.form isLastNameFieldMorethen64char];
                    if(valid==NO)
                    {
                        [lastname setTextColor:[UIColor redColor]];
                    }
                    else
                    {
                    [lastname setTextColor:[UIColor whiteColor]];
                    }
                }
            }
            if (textField.tag == 30)
            {
                valid=[self.form isEmailFieldValid];

                if (valid==NO)
                {
                    [emailflbl setTextColor:[UIColor redColor]];
                }
                else
                {
                    [emailflbl setTextColor:[UIColor whiteColor]];
                }
            }
            if(textField.tag == 40)
            {
                valid=[self.form isAgeFeildValid];
                if(valid==NO)
                {
                    [agelbl setTextColor:[UIColor redColor]];
                }
                else
                {
                    valid=[self.form isAgeFieldAlpha];
                    if(valid==NO)
                    {
                        [agelbl setTextColor:[UIColor redColor]];
                }
                    else
                    {
                        valid=[self.form isAgeValidRange];
                        if(valid==NO)
                        {
                        [agelbl setTextColor:[UIColor redColor]];
                        }
                        else
                        {
                      [agelbl setTextColor:[UIColor whiteColor]];
                        }
                    }
                }
            }
            if(textField.tag == 50)
            {
                valid=[self.form isPhoneFieldValid];
                if(valid==NO)
                {
                    [phonelbl setTextColor:[UIColor redColor]];
                }
                else
                {
                    valid=[self.form isPhoneFieldNot10char];
                    if(valid==NO)
                    {
                        [phonelbl setTextColor:[UIColor redColor]];
                    }
                    else
                    {
                        valid=[self.form isPhoneFieldAlpha];
                        if(valid==NO)
                        {
                        [phonelbl setTextColor:[UIColor redColor]];
                        }
                        else
                        {
                        [phonelbl setTextColor:[UIColor whiteColor]];
                        }
                    }
                }
            }
            if(textField.tag == 60)
            {
                valid=[self.form isNextDateFieldValid];
                if(valid==NO)
                {
                    [nextDate setTextColor:[UIColor redColor]];
                }
                else
                {
                    [self.nextdatelbl setTextColor:[UIColor whiteColor]];
                }
            }
        }
    }
    
}
#pragma -mark UITextViewMethod
//***********************************************************************************************

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30f];
    CGPoint offset = self.Scroll.contentOffset;
    offset.y += 216;
    [self.Scroll setContentOffset:offset];
    [UIView commitAnimations];
}

//***********************************************************************************************

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}

//***********************************************************************************************

- (void)textViewValueChanged:(NSNotification *)notification;
{
    UITextView *textView = (UITextView*)notification.object;
     BOOL valid;
    if(self.formJustLoaded==NO)
    {
        {
            switch (textView.tag)
            {
                case 1:
                [self.form setSymptomsValue:textView.text];
                break;
                case 2:
                [self.form setDiseasesValue:textView.text];
                break;
                case 3:
                [self.form setDrugsValue:textView.text];
                default:
                break;
            }
    }
        //   validation
        {
            if(textView.tag == 1)
            {
                valid=[self.form isSymptomsFieldValid];
                if(valid==NO)
                {
                    [symtomslbl setTextColor:[UIColor redColor]];
                }
                else
                {
                    [symtomslbl setTextColor:[UIColor whiteColor]];
                }
         }
            if(textView.tag == 2)
            {
                valid=[self.form isDiseasesFieldValid];
                if(valid==NO)
                {
                    [diseas setTextColor:[UIColor redColor]];
                }
                else
                {
                    [diseas setTextColor:[UIColor whiteColor]];
                }
            }
            if(textView.tag == 3)
            {
                valid=[self.form isDrugsFieldValid];
                if(valid==NO)
                {
                    [druglbl setTextColor:[UIColor redColor]];
                }
                else
                {
                    [druglbl setTextColor:[UIColor whiteColor]];
                }
            }
        }
        [self.savebutton setUserInteractionEnabled:YES];
    }
}
//***********************************************************************************************

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30f];
    CGPoint offset = self.Scroll.contentOffset;
    offset.y -= 216; // You can change this, but 200 doesn't create any problems
    [self.Scroll setContentOffset:offset];
    [UIView commitAnimations];
}

//***********************************************************************************************

- (IBAction)keyboardresign:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}
//***********************************************************************************************

- (void)dealloc
{
    [fnameTextfeild release];
    [emailTextfeild release];
    [ageTextfeild release];
    [phoneTextfeild release];
    [symptomsTextview release];
    [diseasesTextview release];
    [drugsTextView release];
    [nextDate release];
    [gender release];
    [genderfld release];
    [_savebutton release];
    [_BackButton release];
    [gender release];
    [nextDate release];
    [Scroll release];
    [agelbl release];
    [lastname release];
    [emailflbl release];
    [agelbl release];
    [phonelbl release];
    [genderlbl release];
    [symtomslbl release];
    [druglbl release];

    [gender release];
    [viewAlert release];
    [_nextdatelbl release];
    [super dealloc];
}

@end
