//
//  ViewController.m
//  doctornotes
//
//  Created by Mac on 19/12/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "ViewController.h"
#import "AddPatientViewController.h"
#import "PatientDetailViewController.h"
#import "AppointmentViewController.h"
#import "MoreViewController.h"
#import "AboutUsViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize addPateintButtn,pateintDetail,aboutUs,more,appointment;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    UIImageView*backview=[[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)]autorelease];
    [backview setImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:backview];
    
    
    UIImageView *iconimgview =[[[UIImageView alloc]initWithFrame:CGRectMake(50,30,220,50)]autorelease];
    [iconimgview setImage:[UIImage imageNamed:@"icon.png"]];
    [self.view addSubview:iconimgview];
    
    
    addPateintButtn =[ UIButton buttonWithType:UIButtonTypeCustom];
    [addPateintButtn setFrame:CGRectMake(50, 90, 200, 50)];
    [addPateintButtn setImage:[UIImage imageNamed:@"addbutton.png"] forState:UIControlStateNormal];
    [addPateintButtn setImage:[UIImage imageNamed:@"addbutton_s.png"] forState:UIControlStateHighlighted];
    [addPateintButtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [addPateintButtn setTag:1];
    [self.view addSubview:addPateintButtn];
    
    
    pateintDetail =[[ UIButton buttonWithType:UIButtonTypeCustom]autorelease];
    
    [pateintDetail setFrame:CGRectMake(50, 160, 200, 50)];
    [pateintDetail setImage:[UIImage imageNamed:@"display.png"] forState:UIControlStateNormal];
    [pateintDetail setImage:[UIImage imageNamed:@"display_s.png"] forState:UIControlStateHighlighted];
    [pateintDetail addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [pateintDetail setTag:2];
    [self.view addSubview:pateintDetail];
    
    
    appointment =[[ UIButton buttonWithType:UIButtonTypeCustom]autorelease];
    
    [appointment setFrame:CGRectMake(50, 230, 200, 50)];
    [appointment setImage:[UIImage imageNamed:@"apbutton.png"] forState:UIControlStateNormal];
     [appointment setImage:[UIImage imageNamed:@"apbutton_s.png"] forState:UIControlStateHighlighted];
    [appointment addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [appointment setTag:3];
    [self.view addSubview:appointment];
    
    
    more =[[ UIButton buttonWithType:UIButtonTypeCustom]autorelease];
    
    [more setFrame:CGRectMake(50, 300, 200, 50)];
    [more setImage:[UIImage imageNamed:@"morebutton.png"] forState:UIControlStateNormal];
     [more setImage:[UIImage imageNamed:@"morebutton_s.png"] forState:UIControlStateHighlighted];
    [more addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [more setTag:4];
    [self.view addSubview:more];
    
    
    aboutUs =[[ UIButton buttonWithType:UIButtonTypeCustom]autorelease];
    
    [aboutUs setFrame:CGRectMake(50, 370, 200, 50)];

    [aboutUs setImage:[UIImage imageNamed:@"aboutbutton.png"] forState:UIControlStateNormal];
    [aboutUs setImage:[UIImage imageNamed:@"aboutbutton_s.png"] forState:UIControlStateHighlighted];
    [aboutUs addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [aboutUs setTag:5];
    [self.view addSubview:aboutUs];
    
    
}
-(void)buttonClicked:(id)sender
{
    
    UIButton*Button=(UIButton*)sender;
    if (Button.tag==1)
    {
        
        AddPatientViewController*AddPatientview=[[AddPatientViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:AddPatientview animated:YES];      
    }
    
    
    else if (Button.tag==2)
    {
        PatientDetailViewController*pdetail=[[PatientDetailViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:pdetail animated:YES];

    }
    else if (Button.tag==3)
    {
        AppointmentViewController*appointmentview=[[AppointmentViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:appointmentview animated:YES];

    }

    else if (Button.tag==4)
    {
        MoreViewController*moreview=[[MoreViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:moreview animated:YES];
    }
     else if (Button.tag==5)
    {
        AboutUsViewController*aboutview=[[[AboutUsViewController alloc]initWithNibName:nil bundle:nil]autorelease];
        [self.navigationController pushViewController:aboutview animated:YES];
    }
    
    else;

}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
