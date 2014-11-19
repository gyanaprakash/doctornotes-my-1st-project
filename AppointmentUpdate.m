//
//  AppointmentUpdate.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "AppointmentUpdate.h"
#import "EmiModal.h"
#import "UIViewHelper.h"

@interface AppointmentUpdate ()

@end

@implementation AppointmentUpdate
//***********************************************************************************************

@synthesize fnameTextfeild;
@synthesize lnameTextfeild;
@synthesize emailTextfeild;
@synthesize selectedData;
@synthesize symptomsTextview;
@synthesize ageTextfeild;
@synthesize genderTextfield;
@synthesize actionSheet;
@synthesize formLabels;
@synthesize picker;
@synthesize PhoneTextfeild;
@synthesize DiseasesTextview;
@synthesize drugsTextView;
@synthesize NextDate;
//***********************************************************************************************

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.formLabels=[[NSMutableDictionary alloc]init];
               [self setTitle:@"Update Date"];
        [self.navigationController setNavigationBarHidden:YES];

        UIView *tf=nil;
        tf = [UIViewHelper createTextFeild:@"" placeholder:nil withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setFnameTextfeild:(UITextField*)tf];
        [self.fnameTextfeild setBackgroundColor:[UIColor clearColor]];
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:nil withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setLnameTextfeild:(UITextField*)tf];
        [self.lnameTextfeild setBackgroundColor:[UIColor clearColor]];
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:nil withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setEmailTextfeild:(UITextField*)tf];
        [self.emailTextfeild setBackgroundColor:[UIColor clearColor]];
        
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:nil withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setAgeTextfeild:(UITextField*)tf];
        [self.ageTextfeild setBackgroundColor:[UIColor clearColor]];
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:nil withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setPhoneTextfeild:(UITextField*)tf];
        [self.PhoneTextfeild setBackgroundColor:[UIColor clearColor]];
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:nil withEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setGenderTextfield:(UITextField*)tf];
        [self.genderTextfield setBackgroundColor:[UIColor clearColor]];
        
        tf =[UIViewHelper makeTextView:@"" lines:5 WithEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 50);
        [self setSymptomsTextview:(UITextView *)tf];
        
        tf =[UIViewHelper makeTextView:@"" lines:5 WithEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 50);
        [self setDiseasesTextview:(UITextView *)tf];
        
        tf =[UIViewHelper makeTextView:@"" lines:5 WithEditing:NO];
        tf.frame = CGRectMake(130, 5, 180, 50);
        [self setDrugsTextView:(UITextView*)tf];
        
        tf = [UIViewHelper createTextFeild:@"" placeholder:@"Next Visit " withEditing:YES];
        tf.frame = CGRectMake(130, 5, 180, 35);
        [self setNextDate:(UITextField*)tf];
        [self.NextDate setDelegate:self];
        [self.NextDate setBackgroundColor:[UIColor clearColor]];
        [self.NextDate setUserInteractionEnabled:NO];
        
    }
    return self;
}
//***********************************************************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lastappoinment=[selectedData valueForKey:@"nextdate"];
    
    UIBarButtonItem *updateButton = [[UIBarButtonItem alloc]initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(onEditTouched:)];
    [self.navigationItem setRightBarButtonItem:updateButton animated:YES];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(onBackTouched:)];
    [self.navigationItem setLeftBarButtonItem:backButton animated:YES];
    [self.tableView setAllowsSelection:NO];
    
}
//***********************************************************************************************

#pragma mark buttonactions

-(void)onBackTouched:(id)sender
{
    POP_TO_VIEWCONTROLLER_ANIMATED;
}
//***********************************************************************************************

-(void)onEditTouched:(id)sender
{
    [self.NextDate setUserInteractionEnabled:YES];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onSaveTouched:)];
    [self.navigationItem setRightBarButtonItem:saveButton animated:NO];
    
}
//***********************************************************************************************

-(void)onSaveTouched:(id)sender
{
    NSString *moID= [[[selectedData objectID]URIRepresentation]absoluteString];
    [selectedData setValue:self.NextDate.text forKey:@"nextdate"];
    AppDelegate*appobject=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appobject managedObjectContext];
    if ([context hasChanges])
    {
        NSError *error = nil;
        [context save:&error];
        
        NSManagedObject *visitedrecord = [NSEntityDescription insertNewObjectForEntityForName:@"VISITED" inManagedObjectContext:context];
        [visitedrecord setValue:lastappoinment forKey:@"vdate"];
        [visitedrecord setValue:moID forKey:@"pid"];
        // Save the object to persistent store
        if (![context save:&error])
        {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
    POP_TO_VIEWCONTROLLER_ANIMATED;
}
//***********************************************************************************************

#pragma mark didReceiveMemoryWarning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//***********************************************************************************************

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
//***********************************************************************************************

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 6;
    else if (section==1)
        return 3;
    else
        return 1;
}
//***********************************************************************************************

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
                [self.fnameTextfeild setText:[selectedData valueForKey:@"firstname"]];
                
            }
                break;
            case 1:
            {
                [cell.textLabel setText:@"LastName"];
                [self.formLabels setObject:cell.textLabel forKey:@"Last Name"];
                [cell.contentView addSubview:self.lnameTextfeild];
                [self.lnameTextfeild setText:[selectedData valueForKey:@"lastname"]];
            }
                break;
            case 2:
            {
                [cell.textLabel setText:@"Email"];
                [self.formLabels setObject:cell.textLabel forKey:@"Email"];
                [cell.contentView addSubview:self.emailTextfeild];
                [self.emailTextfeild setText:[selectedData valueForKey:@"email"]];
                
            }
                break;
            case 3:
            {
                [cell.textLabel setText:@"Age"];
                [self.formLabels setObject:cell.textLabel forKey:@"Age"];
                [cell.contentView addSubview:self.ageTextfeild];
                [self.ageTextfeild setText:[selectedData valueForKey:@"age"]];
                
            }
                break;
            case 4:
            {
                [cell.textLabel setText:@"Phone"];
                [self.formLabels setObject:cell.textLabel forKey:@"Phone"];
                [cell.contentView addSubview:self.PhoneTextfeild];
                [self.PhoneTextfeild setText:[selectedData valueForKey:@"phone"]];
            }
                break;
            case 5:
            {
                NSString*gender=[selectedData valueForKey:@"gender"];
                [cell.textLabel setText:@"Gender"];
                [self.formLabels setObject:cell.textLabel forKey:@"Gender"];
                [cell.contentView addSubview:self.genderTextfield];
                [self.genderTextfield setText:gender];
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
                [self.symptomsTextview setText:[selectedData valueForKey:@"symptoms"]];
                
                
            }
                break;
            case 1:{
                [cell.textLabel setText:@"Diseases"];
                [self.formLabels setObject:cell.textLabel forKey:@"Diseases"];
                [cell.contentView addSubview:self.DiseasesTextview];
                [self.DiseasesTextview setText:[selectedData valueForKey:@"diseases"]];
            }
                break;
            case 2:
            {
                [cell.textLabel setText:@"Drugs"];
                [self.formLabels setObject:cell.textLabel forKey:@"Drugs"];
                [cell.contentView addSubview:self.drugsTextView];
                [self.drugsTextView setText:[selectedData valueForKey:@"drugs"]];
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
                [cell.contentView addSubview:self.NextDate];
                [self.NextDate setText:[selectedData valueForKey:@"nextdate"]];
            }
                break;
        }
    }
    return cell;
}
//***********************************************************************************************

#pragma -mark UITextFieldMethods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}
//***********************************************************************************************

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   if(textField==self.NextDate)
   {
     [textField resignFirstResponder];
     actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    [actionSheet setBackgroundColor:[UIColor grayColor]];
    [actionSheet setAlpha:1];
    [actionSheet setDelegate:self];
    picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(30 ,0, 120, 220)];
    picker.datePickerMode=UIDatePickerModeDate;
       [picker setMinimumDate:[NSDate date]];
    CGRect frame = self.picker.frame;
    frame.size.width -= 50;
    frame.size.height-=100;
    [picker setFrame: frame];
    [picker addTarget:self action:@selector
             (pickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.NextDate setInputView:picker];
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
//***********************************************************************************************

#pragma mark pickerChanged

- (void)pickerChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.NextDate.text = [dateFormatter stringFromDate:[self.picker date]];
}
//***********************************************************************************************

#pragma mark actionSheet

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.NextDate.text = [dateFormatter stringFromDate:[self.picker date]];
}
//***********************************************************************************************

@end
