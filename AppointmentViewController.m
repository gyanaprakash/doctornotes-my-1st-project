//
//  AppointmentViewController.m
//  doctornotes
//
//  Created by Mac on 19/12/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "AppointmentViewController.h"
#import "AppDelegate.h"
#import "PatientDetailViewController.h"
#import "AppointmentUpdate.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController
@synthesize picker,dateField,actionSheet,appointmentTable,recordeArray2,fullDetailarray2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationItem setTitle:@"Appointments"];
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationController setNavigationBarHidden:NO];
    
  

    dateField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 205, 35)];
    [dateField setDelegate:self];
    [dateField setTextAlignment:NSTextAlignmentLeft];
    [dateField setBackgroundColor:[UIColor clearColor]];
    NSDateFormatter *dfm = [[NSDateFormatter alloc]init];
    [dfm setDateFormat:@"dd/MM/yyyy"];
    dateField.text=[dfm stringFromDate:[NSDate date]];
    recordeArray2 = [[NSMutableArray alloc]init];
    
   appointmentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 420) style:UITableViewStyleGrouped];
   [appointmentTable setDelegate:self];
    [appointmentTable setDataSource:self];
    appointmentTable.backgroundColor = [UIColor clearColor];
    [appointmentTable setBounces:NO];
    [self.view addSubview:appointmentTable];
}

-(void)viewDidAppear:(BOOL)animated
{
    AppDelegate*appobj=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appobj managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nextdate ==[c] %@", dateField.text];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"PATIENT"];
    fetchRequest.predicate = predicate;
    self.recordeArray2 = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [appointmentTable reloadData];
}
#pragma -mark UITableViewDelegateMethods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else
        return ([self.recordeArray2 count]);
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //header title
    if (section == 0)
        return @"Appointment On";
    else
        return @"Appointments";
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:nil];
    if (cell==NULL)
    {
        cell =[[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    if (indexPath.section==0)
    {
            [cell.textLabel setText:@"Date:"];
            [cell addSubview:dateField];

        }
        else
        {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            NSString *str =[[recordeArray2 objectAtIndex:indexPath.row] valueForKey:@"firstname"];
            [cell.textLabel setText:str];
            
        }
        
    return cell;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
    {
        if(textField==self.dateField)
        {
            
            [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 25.0)];
        
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            
            actionSheet.actionSheetStyle=UIActionSheetStyleDefault;
            [actionSheet setBackgroundColor:[UIColor redColor]];
            [actionSheet setAlpha:1];
            
            picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(30 ,0, 120, 220)];
            picker.datePickerMode=UIDatePickerModeDate;
            CGRect frame = self.picker.frame;
            frame.size.width -= 50;
            frame.size.height-=100;
            [picker setFrame: frame];
            //[picker setMinimumDate:[NSDate date]];
            [picker addTarget:self action:@selector
             (pickerChanged:) forControlEvents:UIControlEventValueChanged];
            [self.dateField setInputView:picker];
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
            [textField resignFirstResponder];
            return FALSE;
        }    
        return YES;
    }
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==0)
    {
        [recordeArray2 removeAllObjects];
        AppDelegate*appobj=[[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context = [appobj managedObjectContext];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nextdate ==[c] %@", dateField.text];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"PATIENT"];
        fetchRequest.predicate = predicate;
        self.recordeArray2 = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
        [appointmentTable reloadData];

    }
}
// date
- (void)pickerChanged:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString*datestring=[formatter stringFromDate:[self.picker date]];
    self.dateField.text =datestring;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section!=0)
    {
        AppointmentUpdate *updateview = [[AppointmentUpdate alloc]initWithStyle:UITableViewStyleGrouped];
        updateview.selectedData=[recordeArray2 objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:updateview animated:YES];
    }
    
}
@end
