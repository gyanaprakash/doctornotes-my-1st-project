//
//  AboutUsViewController.m
//  doctornotes
//
//  Created by Mac on 19/12/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "AboutUsViewController.h"
#import "ViewController.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
//@synthesize home;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        [self.navigationItem setTitle:@"About App"];

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UIImageView*backview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    [backview setImage:[UIImage imageNamed:@"aboutapp.png"]];
    [self.view addSubview:backview];
  
    UILabel*developed=[[UILabel alloc]initWithFrame:CGRectMake(80, 250, 140, 45)];
    [developed setBackgroundColor:[UIColor clearColor]];
    [developed setText:@"Developed By"];
    [developed setTextColor:[UIColor redColor]];
    [developed setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:20]];
    [self.view addSubview:developed];
    
    
    UILabel*kapil=[[UILabel alloc]initWithFrame:CGRectMake(60, 280, 240, 45)];
    [kapil setBackgroundColor:[UIColor clearColor]];
    [kapil setText:@"Gyana Prakash Gouda"];
    [kapil setTextColor:[UIColor yellowColor]];
    [kapil setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:20]];
    [self.view addSubview:kapil];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
