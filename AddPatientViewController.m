//
//  AddPatientViewController.m
//  doctornotes
//
//  Created by Mac on 19/12/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "AddPatientViewController.h"
#import "UIViewHelper.h"
#import "NewPatientRecord.h"
#import "ValidationHelper.h"
#import "AppDelegate.h"

@interface AddPatientViewController ()

@end

@implementation AddPatientViewController
@synthesize fnameTextfeild;
@synthesize lnameTextfeild;
@synthesize emailTextfeild;
@synthesize ageTextfeild;
@synthesize PhoneFieldValid;
@synthesize phoneTextfeild;
@synthesize genderTextfield;
@synthesize symptomsTextview;
@synthesize diseasesTextview;
@synthesize drugsTextView;
@synthesize nextDate;
@synthesize insertTable;
@synthesize NextDateFieldValid;
@synthesize ageFieldValid;
@synthesize FirstnameFieldValid;
@synthesize delegate;
@synthesize emailFieldValid;
@synthesize symptomsFeildValid;
@synthesize form,isValid,formJustLoaded,formLabels;
@synthesize doneButton,actionSheet,picker;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationItem setTitle:@"New Patient"];
        self.form=[[[NewPatientRecord alloc]init]autorelease];
        //[self setForm:[[NewPatientRecord alloc] init]];
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
        [self setFirstnameFieldValid:NO];
        [self setLnameFieldValid:NO];
        [self setEmailFieldValid:NO];
        [self setAgeFieldValid:NO];
        [self setPhoneFieldValid:NO];
        [self setGenderTextfield:NO];
        [self setNextDateFieldValid:NO];
        [self setSymptomsFeildValid:NO];
        [self setDrugsFieldValid:NO];
        [self setDiseasesFieldValid:NO];
        
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
       
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewValueChanged:) name:UITextViewTextDidChangeNotification object:nil];


    
    UIImageView*backview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    [backview setImage:[UIImage imageNamed:@""]];
    [self.view addSubview:backview];
    
     UIView *tf=nil;
    tf = [UIViewHelper createTextFeild:@"" placeholder:@"First Name" withEditing:YES];
    tf.frame = CGRectMake(130, 5, 180, 35);
    [self setFnameTextfeild:(UITextField*)tf];
    [self.fnameTextfeild setDelegate:self];
   
    [self.fnameTextfeild setBackgroundColor:[UIColor clearColor]];

    tf = [UIViewHelper createTextFeild:@"" placeholder:@"Last Name" withEditing:YES];
    tf.frame = CGRectMake(130, 5, 180, 35);
    [self setLnameTextfeild:(UITextField*)tf];
    [self.lnameTextfeild setDelegate:self];
    [self.lnameTextfeild setBackgroundColor:[UIColor clearColor]];
    
    tf = [UIViewHelper createTextFeild:@"" placeholder:@"Email" withEditing:YES];
    tf.frame = CGRectMake(130, 5, 180, 35);
    [self setEmailTextfeild:(UITextField*)tf];
    [self.emailTextfeild setDelegate:self];
    [self.emailTextfeild setBackgroundColor:[UIColor clearColor]];
    
    
    tf = [UIViewHelper createTextFeild:@"" placeholder:@"Age" withEditing:YES];
    tf.frame = CGRectMake(130, 5, 180, 35);
    [self setAgeTextfeild:(UITextField*)tf];
    [self.ageTextfeild setDelegate:self];
    [self.ageTextfeild setBackgroundColor:[UIColor clearColor]];
    
    gender =[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Male", @"Female", nil]];
    gender.frame = CGRectMake(120, 2, 135, 35);
    gender.selectedSegmentIndex=0;
    
    
    tf = [UIViewHelper createTextFeild:@"" placeholder:@"Phone" withEditing:YES];
    tf.frame = CGRectMake(130, 5, 180, 35);
    [self setPhoneTextfeild:(UITextField*)tf];
    [self.phoneTextfeild setDelegate:self];
    [self.phoneTextfeild setBackgroundColor:[UIColor clearColor]];
    
    tf =[UIViewHelper makeTextView:@"" lines:5 WithEditing:YES];
    tf.frame = CGRectMake(130, 5, 180, 50);
    [self setSymptomsTextview:(UITextView *)tf];
    [self.symptomsTextview setDelegate:self];
    
    tf =[UIViewHelper makeTextView:@"" lines:5 WithEditing:YES];
    tf.frame = CGRectMake(130, 5, 180, 50);
    [self setDiseasesTextview:(UITextView *)tf];
    [self.diseasesTextview setDelegate:self];
    
    tf =[UIViewHelper makeTextView:@"" lines:5 WithEditing:YES];
    tf.frame = CGRectMake(130, 5, 180, 50);
    [self setDrugsTextView:(UITextView*)tf];
    [self.drugsTextView setDelegate:self];
    
    tf = [UIViewHelper createTextFeild:@"" placeholder:@"Next Visit " withEditing:YES];
    tf.frame = CGRectMake(130, 5, 180, 35);
    [self setNextDate:(UITextField*)tf];
    [self.nextDate setDelegate:self];
    [self.nextDate setBackgroundColor:[UIColor clearColor]];
    
    insertTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 415) style:UITableViewStyleGrouped ];
    
    [insertTable setDelegate:self];
    [insertTable setDataSource:self];
    [self.view addSubview:insertTable];
    [insertTable setAllowsSelection:NO];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onSaveTouched:)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancle" style:UIBarButtonSystemItemCancel target:self action:@selector(onBackTouched:)];
    
    
    [self.navigationItem setLeftBarButtonItem:cancelButton animated:NO];
    [self.navigationItem setRightBarButtonItem:okButton animated:NO];
    [self setDoneButton:okButton];
    [self.doneButton setEnabled:FALSE];

}

#pragma -Mark Handling Dialog cancel and done actions

-(void)onBackTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onSaveTouched:(id)sender
{
    AppDelegate*appobj=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appobj managedObjectContext];
    NSManagedObject *newrecord = [NSEntityDescription insertNewObjectForEntityForName:@"PATIENT" inManagedObjectContext:context];
    [newrecord setValue:self.form.ageValue forKey:@"age"];
    [newrecord setValue:[NSDate date] forKey:@"currentdate"];
    [newrecord setValue:self.form.diseasesValue forKey:@"diseases"];
    [newrecord setValue:self.form.drugsValue forKey:@"drugs"];
    [newrecord setValue:self.form.emailValue forKey:@"email"];
    [newrecord setValue:self.form.firstNameValue forKey:@"firstname"];
    
    id gend;
    if (gender.selectedSegmentIndex == 0)
    {
        gend = @"Male";
    }
    else{
        gend = @"Female";
    }
    [newrecord setValue:gend forKey:@"gender"];
    
    [newrecord setValue:self.form.lastNameValue forKey:@"lastname"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString*datestring=[formatter stringFromDate:[self.picker date]];
    [newrecord setValue:datestring forKey:@"nextdate"];
    
    [newrecord setValue:self.form.phoneValue forKey:@"phone"];
    [newrecord setValue:self.form.symptomsValue forKey:@"symptoms"];
    selectedDate = [NSDate date];
    [newrecord  setValue:selectedDate forKey:@"currentdate"];
    
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
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma Keyboard Notication Handling

- (void)keyboardWasShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 220.0, 0.0);
    self.insertTable.contentInset = contentInsets;
    self.insertTable.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    
}
- (void) keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.insertTable.contentInset = contentInsets;
    self.insertTable.scrollIndicatorInsets = contentInsets;
}

#pragma -mark UITableViewDelegateMethods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    if (section==0)
      return 6;
    else if (section==1)
        return 3;
    else
        return 1;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //header title
    if (section == 0)
        return @"Personal Details";
    
    else if (section == 1)
        return @"About Health";
    else
        return @"Next Appointment";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 40.0f;
    if(indexPath.section==1)
    {
        height=60.0f;
    }
    return height;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:nil];
    if (cell==NULL)
    {
        cell =[[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if(indexPath.section==0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                [cell.textLabel setText:@"First Name"];
                [self.formLabels setObject:cell.textLabel forKey:@"First Name"];
                [cell.contentView addSubview:self.fnameTextfeild];
            }break;
            case 1:
            {
                  [cell.textLabel setText:@"LastName"];
                  [self.formLabels setObject:cell.textLabel forKey:@"Last Name"];
                  [cell.contentView addSubview:self.lnameTextfeild];
            } break;
                case 2:
                {
                    [cell.textLabel setText:@"Email"];
                    [self.formLabels setObject:cell.textLabel forKey:@"Email"];
                    [cell.contentView addSubview:self.emailTextfeild];

                } break;
                case 3:
                {
                    [cell.textLabel setText:@"Age"];
                    [self.formLabels setObject:cell.textLabel forKey:@"Age"];
                [cell.contentView addSubview:self.ageTextfeild];

                } break;
               case 4:
              {
                [cell.textLabel setText:@"Phone"];
                [self.formLabels setObject:cell.textLabel forKey:@"Phone"];
                [cell.contentView addSubview:self.phoneTextfeild];
              } break;
                case 5:
                {
                    [cell.textLabel setText:@"Gender"];
                    [self.formLabels setObject:cell.textLabel forKey:@"Gender"];
                    [cell.contentView addSubview:gender];
                    
                } break;
                
            }
        }
    else if(indexPath.section==1)
    {
        switch (indexPath.row)
        {
            case 0:{
                    [cell.textLabel setText:@"Symptoms"];
                    [self.formLabels setObject:cell.textLabel forKey:@"Symptoms"];
                    [cell.contentView addSubview:self.symptomsTextview];
                      
                   }break;
            case 1:{
                    [cell.textLabel setText:@"Diseases"];
                    [self.formLabels setObject:cell.textLabel forKey:@"Diseases"];
                    [cell.contentView addSubview:self.diseasesTextview];
                
               } break;
            case 2:
                 {
                   [cell.textLabel setText:@"Drugs"];
                   [self.formLabels setObject:cell.textLabel forKey:@"Drugs"];
                [cell.contentView addSubview:self.drugsTextView];
            }  break;
        
        }
    }
    else if(indexPath.section==2)
    {
        switch (indexPath.row)
        {
            case 0:
            {
    
                [cell.textLabel setText:@"Date"];
                [self.formLabels setObject:cell.textLabel forKey:@"Date"];
                [cell.contentView addSubview:self.nextDate];
               }break;
                  
            }
    }
    return cell;
}

#pragma -mark UITextFieldMethods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField;
{
    
    if(self.formJustLoaded==NO)
    {
        //  First Name Field
        if(textField==self.fnameTextfeild)
        {
                       
            UILabel *label = (UILabel*)[self.formLabels objectForKey:@"First Name"];
            [label setTextColor:[UIColor blackColor]];
        }
       
        //Last Name Field
        if(textField==self.lnameTextfeild)
        {
            UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Last Name"];
            [label setTextColor:[UIColor blackColor]];
        }
        //  Email Field
        if(textField==self.emailTextfeild)
        {
           
            UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Email"];
            [label setTextColor:[UIColor blackColor]];
        }
        //Age Field
        if(textField==self.ageTextfeild)
        {
            UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Age"];
            [label setTextColor:[UIColor blackColor]];
        }
        if(textField==self.phoneTextfeild)
        {
            UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Phone"];
            [label setTextColor:[UIColor blackColor]];
        }
        // next Date
        if(textField==self.nextDate)
        {
            [textField resignFirstResponder];
            
            [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 25.0)];
            
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"Done" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            
            actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
            
            [actionSheet setBackgroundColor:[UIColor grayColor]];
            [actionSheet setAlpha:1];
            [actionSheet setDelegate:self];
            picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(30 ,0, 120, 220)];
            picker.datePickerMode=UIDatePickerModeDate;
            
            CGRect frame = self.picker.frame;
            frame.size.width -= 50;
            frame.size.height-=100;
            [picker setFrame: frame];
            
            
            [picker addTarget:self action:@selector
             (pickerChanged:) forControlEvents:UIControlEventValueChanged];
            [self.nextDate setInputView:picker];
            
            [actionSheet addSubview:picker];
            [self.view addSubview:actionSheet];
            [actionSheet showInView:self.view];
            
            CGRect menuRect = actionSheet.frame;
            CGFloat orgHeight = menuRect.size.height;
            menuRect.origin.y -= 160;
            //height of picker
            menuRect.size.height = orgHeight+214;
            actionSheet.frame = menuRect;
            
            CGRect pickerRect = picker.frame;
            pickerRect.origin.y = orgHeight;
            picker.frame = pickerRect;
        }
    }
}
    
- (void)pickerChanged:(id)sender
{
    NSLog(@"value: %@",[sender date]);
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.nextDate.text = [dateFormatter stringFromDate:[self.picker date]];
 //   NSLog(@"Date %@",self.nextDate.text);
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField;
{
    NSNotification *notification = [NSNotification notificationWithName:@"Custom" object:textField];
    [self textFieldValueChanged:notification];
}

- (void)textFieldValueChanged:(NSNotification *)notification;
{
    UITextField *textField = (UITextField*)notification.object;
    BOOL valid;
    if(self.formJustLoaded==NO)
    {
        //  First store field values!
        {
            if(textField==self.fnameTextfeild)
                [self.form setFirstNameValue:textField.text];
            
            if(textField==self.lnameTextfeild)
                [self.form setLastNameValue:textField.text];
            
            if(textField==self.emailTextfeild)
                [self.form setEmailValue:textField.text];
            
            if(textField==self.emailTextfeild)
                [self.form setEmailValue:textField.text];
            
            if(textField==self.ageTextfeild)
                [self.form setAgeValue:textField.text];
              if (textField==self.phoneTextfeild)
                [self.form setPhoneValue:textField.text];
            
            if(textField==self.nextDate)
            [self.form setNextDate:textField.text];
            
        }
        //   validate data 
        {
            //  First Name Field
            if(textField==self.fnameTextfeild)
            {
                UILabel *label = (UILabel*)[self.formLabels objectForKey:@"First Name"];
                valid=[self.form isFirstNameFieldValid];
                if(valid==NO)
                {
                    [self setFirstnameFieldValid:NO];
                    [label setTextColor:[UIColor redColor]];
                }
                else
                {
                valid=[self.form isFirstNameFieldMorethen64char];
                    if(valid==NO)
                    {
                        [self setFirstnameFieldValid:NO];
                        [label setTextColor:[UIColor redColor]];
                    }
                    else
                    {
                    [self setFirstnameFieldValid:YES];
                    [label setTextColor:[UIColor blackColor]];
                    }
                }
                
            }
            if(textField==self.nextDate)
            {
                UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Next Visit"];
                valid=[self.form isNextDateFieldValid];
                if(valid==NO)
                {
                    [self setNextDateFieldValid:NO];
                    [label setTextColor:[UIColor redColor]];
                }
            }
          //  Last Name Field
            if(textField==self.lnameTextfeild)
            {
                UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Last Name"];
                valid=[self.form isLastNameFieldValid];
                if(valid==NO)
                {
                    [self setLnameFieldValid:NO];
                    [label setTextColor:[UIColor redColor]];
                }
                else
                {
                valid=[self.form isLastNameFieldMorethen64char];
                    if(valid==NO)
                    {
                        [self setLnameFieldValid:NO];
                        [label setTextColor:[UIColor redColor]];
                    }
                    else
                    {
                     [self setLnameFieldValid:YES];
                    [label setTextColor:[UIColor blackColor]];
                    }
                }
            }
            if (textField==self.emailTextfeild)
            {
                
                NSLog(@"valid email");
                UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Email"];
                
                [self setEmailFieldValid:[self.form isEmailFieldValid]];
                if (self.emailFieldValid==NO)
                {
                    [label setTextColor:[UIColor redColor]];
                }
                else
                {
                    [label setTextColor:[UIColor blackColor]];
                }
            }
            if(textField==self.ageTextfeild)
            {
                UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Age"];
                valid=[self.form isAgeFeildValid];
                if(valid==NO)
                {
                    [self setAgeFieldValid:NO];
                    [label setTextColor:[UIColor redColor]];
                }
                else
                {
                    valid=[self.form isAgeFieldAlpha];
                    if(valid==NO)
                    {
                        [self setAgeFieldValid:NO];
                        [label setTextColor:[UIColor redColor]];
                }
                    else
                    {
                        valid=[self.form isAgeValidRange];
                        if(valid==NO)
                        {
                        [self setAgeFieldValid:NO];
                        [label setTextColor:[UIColor redColor]];
                        }
                        else
                        {
                        [self setAgeFieldValid:YES];
                      [label setTextColor:[UIColor blackColor]];
                        }
                    }
                
                }
            }
            if(textField==self.phoneTextfeild)
            {
                UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Phone"];
                valid=[self.form isPhoneFieldValid];
                if(valid==NO)
                {
                    [self setPhoneFieldValid:NO];
                    [label setTextColor:[UIColor redColor]];
                }
                else
                {
                    valid=[self.form isPhoneFieldNot10char];
                    if(valid==NO)
                    {
                        [self setPhoneFieldValid:NO];
                        [label setTextColor:[UIColor redColor]];
                    }
                    else
                    {
                        valid=[self.form isPhoneFieldAlpha];
                        if(valid==NO)
                        {
                        [self setPhoneFieldValid:NO];
                        [label setTextColor:[UIColor redColor]];
                        }
                        
                        else
                        {
                            [self setPhoneFieldValid:YES];
                        [label setTextColor:[UIColor blackColor]];
                        }
                    }
                }
            }
        }
    }
               
        //  Enable or Disable the 'Done' button if things are or arent valid..
    //  Check all validation flags!
    if(self.FirstnameFieldValid &&self.lnameFieldValid && self.emailFieldValid && self.ageFieldValid && self.PhoneFieldValid && self.symptomsFeildValid && self.diseasesFieldValid && self.drugsFieldValid)
    {
        [self setIsValid:YES];
    }
    else{
        [self setIsValid:NO];
    }
    
        if(self.isValid==NO)
        {
            //  Disable done button
            [self.doneButton setEnabled:NO];
        }
        else
        {
            //  Enable done button
            [self.doneButton setEnabled:YES];
        }
}  

#pragma -mark UITextViewMethod
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if(self.formJustLoaded==NO)
    {
        //  symptoms Field
        if(textView==self.symptomsTextview)
        {
        UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Sympptoms"];
            [label setTextColor:[UIColor blackColor]];
        }
    }
    if (textView==self.diseasesTextview)
    {
        UILabel *label = (UILabel*)[self.formLabels objectForKey:@"diseases"];
        [label setTextColor:[UIColor blackColor]];
     }
    if (textView==self.drugsTextView)
    {
        UILabel *label = (UILabel*)[self.formLabels objectForKey:@"drugs"];
        [label setTextColor:[UIColor blackColor]];
    }

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSNotification *notification = [NSNotification notificationWithName:@"Custom" object:textView];
    [self textViewValueChanged:notification];
}

- (void)textViewValueChanged:(NSNotification *)notification;
{
    
    UITextView *textView = (UITextView*)notification.object;
     BOOL valid;
    if(self.formJustLoaded==NO)
    {
        
        {
            if(textView==self.symptomsTextview)
                [self.form setSymptomsValue:textView.text];
            
            if(textView==self.diseasesTextview)
                [self.form setDiseasesValue:textView.text];
            
            if(textView==self.drugsTextView)
                [self.form setDrugsValue:textView.text];
           }
        
        //   validation 
        {
            
            if(textView==self.symptomsTextview)
            {
                UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Symptoms"];
                
                valid=[self.form isSymptomsFieldValid];
                if(valid==NO)
                {
                    [self setSymptomsFeildValid:NO];
                    [label setTextColor:[UIColor redColor]];
                }
                else
                {
                    [self setSymptomsFeildValid:YES];
                    [label setTextColor:[UIColor blackColor]];
                }
         }
            
            if(textView==self.diseasesTextview)
            {
                UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Diseases"];
                
                valid=[self.form isDiseasesFieldValid];
                if(valid==NO)
                {
                    [self setDrugsFieldValid:NO];
                    [label setTextColor:[UIColor redColor]];
                }
                else
                {
                    [self setDiseasesFieldValid:YES];
                    [label setTextColor:[UIColor blackColor]];
                }
            }

            if(textView==self.drugsTextView)
            {
                UILabel *label = (UILabel*)[self.formLabels objectForKey:@"Drugs"];
                
                valid=[self.form isDrugsFieldValid];
                if(valid==NO)
                {
                    [self setDrugsFieldValid:NO];
                    [label setTextColor:[UIColor redColor]];
                }
                else
                {
                    [self setDrugsFieldValid:YES];
                    [label setTextColor:[UIColor blackColor]];
                }
            }
        }
        
        //  Check all validation flags!
        if(self.FirstnameFieldValid &&self.lnameFieldValid && self.emailFieldValid && self.ageFieldValid && self.PhoneFieldValid && self.symptomsFeildValid && self.diseasesFieldValid && self.drugsFieldValid)
        {
            [self setIsValid:YES];
        }
        else{
            [self setIsValid:NO];
        }
        
        if(self.isValid==NO)
        {
            //  Disable done button
            [self.doneButton setEnabled:NO];
        }
        else
        {
            //  Enable done button
            [self.doneButton setEnabled:YES];
        }
    }
}

@end
