//
//  UpdateViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "UpdateViewController.h"
#import "EmiModal.h"
#import "AppDelegate.h"
//***********************************************************************************************

@interface UpdateViewController ()

@end

@implementation UpdateViewController
//***********************************************************************************************

@synthesize insertTable;
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
@synthesize NextDateFieldValid;
@synthesize ageFieldValid;
@synthesize FirstnameFieldValid;
@synthesize emailFieldValid;
@synthesize symptomsFeildValid;
@synthesize form,isValid,formJustLoaded,formLabels;
@synthesize doneButton,actionSheet,picker;
@synthesize RecordData;
@synthesize data;

//***********************************************************************************************

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        // Custom initialization
        self.form=[[[NewPatientRecord alloc]init]autorelease];
        [self setFormLabels:[NSMutableDictionary dictionary]];
        UIView *tf=nil;
        tf = [UIViewHelper createTextFeild:@"" placeholder:@"" withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setFnameTextfeild:(UITextField*)tf];
        [self.fnameTextfeild setDelegate:self];
        [self.fnameTextfeild setBackgroundColor:[UIColor clearColor]];
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:@"" withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setLnameTextfeild:(UITextField*)tf];
        [self.lnameTextfeild setDelegate:self];
        [self.lnameTextfeild setBackgroundColor:[UIColor clearColor]];
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:@"" withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setEmailTextfeild:(UITextField*)tf];
        [self.emailTextfeild setDelegate:self];
        [self.emailTextfeild setBackgroundColor:[UIColor clearColor]];
        
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:@"" withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setAgeTextfeild:(UITextField*)tf];
        [self.ageTextfeild setDelegate:self];
        [self.ageTextfeild setBackgroundColor:[UIColor clearColor]];
        
        gender =[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Male", @"Female", nil]];
        gender.frame = CGRectMake(120, 2, 135, 35);
        gender.selectedSegmentIndex=0;
        [gender setUserInteractionEnabled:NO];
        
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:@"" withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setPhoneTextfeild:(UITextField*)tf];
        [self.phoneTextfeild setDelegate:self];
        [self.phoneTextfeild setBackgroundColor:[UIColor clearColor]];
        
        tf =[UIViewHelper makeTextView:@"" lines:5 WithEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 50);
        [self setSymptomsTextview:(UITextView *)tf];
        [self.symptomsTextview setDelegate:self];
        
        tf =[UIViewHelper makeTextView:@"" lines:5 WithEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 50);
        [self setDiseasesTextview:(UITextView *)tf];
        [self.diseasesTextview setDelegate:self];
        
        tf =[UIViewHelper makeTextView:@"" lines:5 WithEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 50);
        [self setDrugsTextView:(UITextView*)tf];
        [self.drugsTextView setDelegate:self];
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:@"" withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setNextDate:(UITextField*)tf];
        [self.nextDate setDelegate:self];
        [self.nextDate setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
//***********************************************************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewValueChanged:) name:UITextViewTextDidChangeNotification object:nil];

    [self.tableView setAllowsSelection:NO];
    
    
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(onEditTouched:)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancle" style:UIBarButtonSystemItemCancel target:self action:@selector(onBackTouched:)];
    
    [self.navigationItem setLeftBarButtonItem:cancelButton animated:NO];
    [self.navigationItem setRightBarButtonItem:okButton animated:NO];
    [self setDoneButton:okButton];
    [doneButton setEnabled:YES];
    data = [[NSArray alloc]init];
    AppDelegate*appobject=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appobject managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"VISITED"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY pid==%@",[[[RecordData objectID]URIRepresentation]absoluteString]];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDis = [[NSSortDescriptor alloc]initWithKey:@"vdate" ascending:YES];
    [request setSortDescriptors:@[sortDis]];
    self.data = [[context executeFetchRequest:request error:nil]mutableCopy];
    for(int i=0; i<[data count];i++)
    {
        NSManagedObject*object=[data objectAtIndex:i];
        NSString *dateString =[object valueForKey:@"vdate"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSDate *lastdate = [[NSDate alloc] init];
        lastdate = [dateFormatter dateFromString:dateString];
        
        NSString *todatystring = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *today =[dateFormatter dateFromString:todatystring];
        NSComparisonResult result;
        result = [today compare:lastdate];
        if(result==NSOrderedAscending)
        {
            dateIndex=i;
            break;
        }
        else if(result==NSOrderedDescending)
        {
            
        }
        else if(result==NSOrderedSame)
            dateIndex=1;
        [dateFormatter release];
    }
    NSLog(@"count:%lu",(unsigned long)[data count]);
    
}
//***********************************************************************************************

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.form setFirstNameValue:[RecordData valueForKey:@"firstname"]];
    [self.fnameTextfeild setText:self.form.firstNameValue];
    
    [self.form setLastNameValue:[RecordData valueForKey:@"lastname"]];
    [self.lnameTextfeild setText:self.form.lastNameValue];
    
    [self.form setEmailValue:[RecordData valueForKey:@"email"]];
    [self.emailTextfeild setText:self.form.emailValue];
    
    [self.form setAgeValue:[RecordData valueForKey:@"age"]];
    [self.ageTextfeild setText:self.form.ageValue];
    
    [self.form setGenderValue:[RecordData valueForKey:@"gender"]];
    if([[self.form genderValue]isEqualToString:@"Male"])
    {
        gender.selectedSegmentIndex=0;
    
    }
    else
        gender.selectedSegmentIndex=1;
    
    [self.form setPhoneValue:[RecordData valueForKey:@"phone"]];
    [self.phoneTextfeild setText:self.form.phoneValue];
    
    [self.form setSymptomsValue:[RecordData valueForKey:@"symptoms"]];
    [self.symptomsTextview setText:self.form.symptomsValue];
    
    [self.form setDiseasesValue:[RecordData valueForKey:@"diseases"]];
    [self.diseasesTextview setText:self.form.diseasesValue];
    
    [self.form setDrugsValue:[RecordData valueForKey:@"drugs"]];
    [self.drugsTextView setText:self.form.drugsValue];
    [self.form setNextDate:[RecordData valueForKey:@"nextdate"]];
    [self.nextDate setText:self.form.nextDate];
    lastappoinment=[RecordData valueForKey:@"nextdate"];
    
    [self setFormJustLoaded:NO];
    [self setIsValid:YES];
    [self setFirstnameFieldValid:YES];
    [self setLnameFieldValid:YES];
    [self setEmailFieldValid:YES];
    [self setAgeFieldValid:YES];
    [self setPhoneFieldValid:YES];
    [self setNextDateFieldValid:YES];
    [self setSymptomsFeildValid:YES];
    [self setDrugsFieldValid:YES];
    [self setDiseasesFieldValid:YES];
}

#pragma Mark Button actions

-(void)onBackTouched:(id)sender
{

    POP_TO_VIEWCONTROLLER_ANIMATED;
}
//***********************************************************************************************

-(void)onEditTouched:(id)sender
{
    [self.fnameTextfeild setEnabled:YES];
    [self.lnameTextfeild setEnabled:YES];
    [self.emailTextfeild setEnabled:YES];
    [self.ageTextfeild setEnabled:YES];
    [gender setUserInteractionEnabled:YES];
    [self.phoneTextfeild setEnabled:YES];
    [self.symptomsTextview setEditable:YES];
    [self.diseasesTextview setEditable:YES];
    [self.drugsTextView setEditable:YES];
    [self.nextDate setEnabled:YES];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(onUpdateTouched:)];
    [self.navigationItem setRightBarButtonItem:saveButton animated:NO];
    [self setDoneButton:saveButton];
    [doneButton setEnabled:NO];
    
}
//***********************************************************************************************

-(void)onUpdateTouched:(id)sender
{
    [RecordData setValue:self.form.firstNameValue forKey:@"firstname"];
    [RecordData setValue:self.form.lastNameValue forKey:@"lastname"];
    [RecordData setValue:self.form.emailValue forKey:@"email"];
    [RecordData setValue:self.form.phoneValue forKey:@"phone"];
    [RecordData setValue:self.form.ageValue forKey:@"age"];
    id gend;
    if (gender.selectedSegmentIndex == 0)
    {
        gend = @"Male";
    }
    else{
        gend = @"Female";
    }
    [RecordData setValue:gend forKey:@"gender"];
    [RecordData setValue:self.form.diseasesValue forKey:@"diseases"];
    [RecordData setValue:self.form.drugsValue forKey:@"drugs"];
    [RecordData setValue:self.nextDate.text forKey:@"nextdate"];
    [RecordData setValue:self.form.symptomsValue forKey:@"symptoms"];
    AppDelegate*appobject=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appobject managedObjectContext];
    if ([context hasChanges])
    {
        NSError *error = nil;
        [context save:&error];
    
        NSManagedObject *visitedrecord = [NSEntityDescription insertNewObjectForEntityForName:@"VISITED" inManagedObjectContext:context];
        [visitedrecord setValue:lastappoinment forKey:@"vdate"];
        NSString *moID= [[[RecordData objectID]URIRepresentation]absoluteString];
        [visitedrecord setValue:moID forKey:@"pid"];
        // Save the object to persistent store
        if (![context save:&error])
        {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
    POP_TO_VIEWCONTROLLER_ANIMATED;
}

#pragma mark TapGestureRecognizer
//***********************************************************************************************

- (IBAction)Tapped:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}
//***********************************************************************************************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITableViewDelegateMethods
//***********************************************************************************************

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
//***********************************************************************************************

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 6;
    else if (section==1)
        return 3;
    else if (section==2)
        return 1;
    if(section==3)
    {
      if(dateIndex==1)
        return 1;
      else if(dateIndex==2)
        return 2;
      else
        return 3;
    }
    return 0;
}
//***********************************************************************************************

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //header title
    if (section == 0)
        return @"Personal Details";
    else if (section == 1)
        return @"About Health";
    else if (section == 2)
        return @"Next Appointment";
    else
        return @"Last Visited";
}
//***********************************************************************************************

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 40.0f;
    if(indexPath.section==1)
    {
        height=60.0f;
    }
    return height;
}
//***********************************************************************************************

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
            }
                break;
            case 1:
            {
                [cell.textLabel setText:@"LastName"];
                [self.formLabels setObject:cell.textLabel forKey:@"Last Name"];
                [cell.contentView addSubview:self.lnameTextfeild];
            }
                break;
            case 2:
            {
                [cell.textLabel setText:@"Email"];
                [self.formLabels setObject:cell.textLabel forKey:@"Email"];
                [cell.contentView addSubview:self.emailTextfeild];
            }
                break;
            case 3:
            {
                [cell.textLabel setText:@"Age"];
                [self.formLabels setObject:cell.textLabel forKey:@"Age"];
                [cell.contentView addSubview:self.ageTextfeild];
                
            }
                break;
            case 4:
            {
                [cell.textLabel setText:@"Phone"];
                [self.formLabels setObject:cell.textLabel forKey:@"Phone"];
                [cell.contentView addSubview:self.phoneTextfeild];
            }
                break;
            case 5:
            {
                [cell.textLabel setText:@"Gender"];
                [self.formLabels setObject:cell.textLabel forKey:@"Gender"];
                [cell.contentView addSubview:gender];
            }
                break;
        }
    }
    else if(indexPath.section==1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                [cell.textLabel setText:@"Symptoms"];
                [self.formLabels setObject:cell.textLabel forKey:@"Symptoms"];
                [cell.contentView addSubview:self.symptomsTextview];
            }
                break;
            case 1:
            {
                [cell.textLabel setText:@"Diseases"];
                [self.formLabels setObject:cell.textLabel forKey:@"Diseases"];
                [cell.contentView addSubview:self.diseasesTextview];
            }
                break;
            case 2:
            {
                [cell.textLabel setText:@"Drugs"];
                [self.formLabels setObject:cell.textLabel forKey:@"Drugs"];
                [cell.contentView addSubview:self.drugsTextView];
            }
                break;
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
            }
                break;
        }
    }
    
    else if(indexPath.section==3)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                NSManagedObject *patientObject = [self.data objectAtIndex:dateIndex-1];
                [cell.textLabel setText:[NSString stringWithFormat:@"%@",[patientObject valueForKey:@"vdate"]]];
                
            }break;
            case 1:
            {
                NSManagedObject *patientObject = [self.data objectAtIndex:dateIndex-2];
                [cell.textLabel setText:[NSString stringWithFormat:@"%@",[patientObject valueForKey:@"vdate"]]];
            }
                break;
            case 2:
            {
                NSManagedObject *patientObject = [self.data objectAtIndex:dateIndex-3];
                [cell.textLabel setText:[NSString stringWithFormat:@"%@",[patientObject valueForKey:@"vdate"]]];
            }
                break;
        }
    }
    return cell;
}

#pragma -mark UITextFieldMethods
//***********************************************************************************************

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}
//***********************************************************************************************

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
#pragma mark pickerChanged
//***********************************************************************************************

- (void)pickerChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.nextDate.text = [dateFormatter stringFromDate:[self.picker date]];
}

-(void)textFieldDidEndEditing:(UITextField *)textField;
{
    NSNotification *notification = [NSNotification notificationWithName:@"Custom" object:textField];
    [self textFieldValueChanged:notification];
}
//***********************************************************************************************

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
    else
    {
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
//***********************************************************************************************

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

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSNotification *notification = [NSNotification notificationWithName:@"Custom" object:textView];
    [self textViewValueChanged:notification];
}
//***********************************************************************************************

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
                    [self setDiseasesFieldValid:NO];
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
//***********************************************************************************************

- (void)dealloc
{
    [insertTable release];
    [super dealloc];
}
@end
