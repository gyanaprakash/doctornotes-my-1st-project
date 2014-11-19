//
//  ViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "ViewController.h"
#import "AddPatientViewController.h"
#import "PatientDetailViewController.h"
#import "AboutUsViewController.h"
#import "AppointmentViewController.h"
#import "PersonalViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//***********************************************************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
}
//***********************************************************************************************

#pragma mark button action

- (IBAction)ButtonClicked:(UIButton *)sender
{
    UIButton*Button=(UIButton*)sender;
    if (Button.tag == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (Button.tag==1)
    {
        AddPatientViewController *AddPatientview = [[AddPatientViewController alloc]initWithNibName:@"AddPatient" bundle:nil];
        [self.navigationController pushViewController:AddPatientview animated:YES];
    }
    else if (Button.tag==2)
    {
        PatientDetailViewController *pdetail = [[PatientDetailViewController alloc]initWithNibName:@"PatientDetail" bundle:nil];
        [self.navigationController pushViewController:pdetail animated:YES];
    }
    else if (Button.tag==3)
    {
        AppointmentViewController *appointmentview = [[AppointmentViewController alloc]initWithNibName:@"AppointmentViewController" bundle:nil];
        [self.navigationController pushViewController:appointmentview animated:YES];
    }
    else;
}
//***********************************************************************************************

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
//***********************************************************************************************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//***********************************************************************************************

- (void)dealloc
{
    [_AddPatientbutton release];
    [_PateintDetail release];
    [_Appointment release];
    [_More release];
    [_Appointment release];
    [_More release];
    [_AboutUs release];
    [super dealloc];
}
//***********************************************************************************************

@end
