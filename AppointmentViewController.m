//
//  AppointmentViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "AppointmentViewController.h"
#import "EmiModal.h"
#import "AppointmentUpdate.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController
@synthesize picker,actionSheet,appointmentTable,dateField,recordeArray2,fullDetailarray2;
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
    [self.navigationController setNavigationBarHidden:YES];
    
    [dateField setDelegate:self];
    NSDateFormatter *dfm = [[NSDateFormatter alloc]init];
    [dfm setDateFormat:@"dd/MM/yyyy"];
    [dateField setBackgroundColor:[UIColor clearColor]];
    dateField.text=[dfm stringFromDate:[NSDate date]];
    recordeArray2 = [[NSMutableArray alloc]init];
    
   [appointmentTable setDelegate:self];
    [appointmentTable setDataSource:self];
    appointmentTable.backgroundColor = [UIColor clearColor];
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([self.recordeArray2 count]);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:nil];
    if (cell==NULL)
    {
        cell =[[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    NSString *str =[[recordeArray2 objectAtIndex:indexPath.row] valueForKey:@"firstname"];
    [cell.textLabel setText:str];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section!=0)
    {
        AppointmentUpdate *updateview = [[AppointmentUpdate alloc]initWithStyle:UITableViewStyleGrouped];
        updateview.selectedData=[recordeArray2 objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:updateview animated:YES];
    }
}

#pragma mark textFieldShouldBeginEditing

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
    {
        if(textField==dateField)
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
            [dateField setInputView:picker];
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

#pragma mark button action

- (IBAction)Backbuttobclicked:(id)sender
{
    POP_TO_VIEWCONTROLLER_ANIMATED;
}

#pragma mark pickerChanged

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
- (void)dealloc
{
    [dateField release];
    [appointmentTable release];
    [super dealloc];
}
@end
