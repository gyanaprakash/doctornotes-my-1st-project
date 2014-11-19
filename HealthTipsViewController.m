//
//  HealthTipsViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "HealthTipsViewController.h"

@interface HealthTipsViewController ()

@end

@implementation HealthTipsViewController

//***********************************************************************************************

- (void)viewDidAppear:(BOOL)animated {
    
}

//***********************************************************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//***********************************************************************************************

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//***********************************************************************************************

- (IBAction)buttonAction:(UIButton *)sender {
    UIButton *button = (UIButton *)sender;
    if (button.tag ==1)
    {
        POP_TO_VIEWCONTROLLER_ANIMATED;
    }
    else if (button.tag == 2)
    {
       // [_stomacview setFrame:CGRectMake(30, 30, 260, 530)];
        [self.view addSubview:self.stomacview];
    }
    else if (button.tag == 3)
    {
        [self.view addSubview:self.bloodpresure];
    }
    else if (button.tag == 4)
    {
        [self.view addSubview:self.feaber];
    }
    else if (button.tag == 5)
    {
        [self.view addSubview:self.diabits];
    }
    else if (button.tag == 6)
    {
        [self.view addSubview:self.heart];
    }
    else if (button.tag == 7)
    {
        [self.view addSubview:self.brain];
    }
    else if (button.tag == 8)
    {
        [self.view addSubview:self.dental];
    }
}

//***********************************************************************************************

- (IBAction)backbutton:(UIButton *)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1)
    {
        [UIView animateWithDuration:.5 animations:^{
            
            // Move the view down
            self.stomacview.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds)+CGRectGetHeight(self.stomacview.bounds));
            
            // ...and rotate it along the way
            CGAffineTransform t = CGAffineTransformMakeRotation(M_PI * .5);
            t = CGAffineTransformScale(t, .5, .5);
            self.stomacview.transform = t;
            
        } completion:^(BOOL finished)
        {
            [self.stomacview release];
        }];
        [_brain removeFromSuperview];

    }
    if (button.tag == 2)
    {
        [UIView animateWithDuration:.5 animations:^{
            
            [self.bloodpresure setEasingFunction:easeInBack forKeyPath:@"center"];
            [self.bloodpresure setEasingFunction:easeOutQuint forKeyPath:@"transform"];
            
            // Move the view down
            self.bloodpresure.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds)+CGRectGetHeight(self.bloodpresure.bounds));
            
            // ...and rotate it along the way
            CGAffineTransform t = CGAffineTransformMakeRotation(M_PI * .3);
            t = CGAffineTransformScale(t, .75, .75);
            
            self.bloodpresure.transform = t;
            
        } completion:^(BOOL finished) {
            
            [self.bloodpresure removeEasingFunctionForKeyPath:@"center"];
            [self.bloodpresure removeEasingFunctionForKeyPath:@"transform"];
            
            [self.bloodpresure removeFromSuperview];
            
            
        }];

    }
    if (button.tag == 3)
    {
        [_feaber removeFromSuperview];
    }
    if (button.tag == 4)
    {
        [_diabits removeFromSuperview];
    }
    if (button.tag == 5)
    {
        [_heart removeFromSuperview];
    }
    if (button.tag == 6)
    {
        [_brain removeFromSuperview];
    }
    if (button.tag == 7)
    {
        [_dental removeFromSuperview];
    }
}

//***********************************************************************************************

- (void)dealloc {
    [_stomacview release];
    [_bloodpresure release];
    [_dental release];
    [_diabits release];
    [_brain release];
    [_feaber release];
    [_heart release];
    [_action release];
    [super dealloc];
}

//***********************************************************************************************

@end
