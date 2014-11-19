//
//  EMICalculatorViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "EMICalculatorViewController.h"
#import "EmiModal.h"
@interface EMICalculatorViewController ()
{
    NSInteger timeCnvt;
}
@end

@implementation EMICalculatorViewController

- (void)viewDidLoad
//***********************************************************************************************

{
    [self.emilbl setHidden:YES];
    [self.intlbl setHidden:YES];
    [self.totallbl setHidden:YES];
    
    iscleacked = YES;
    nowZoomed = YES;
    
    NSTimer *timer = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:0.7 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    NSRunLoop *run = [NSRunLoop currentRunLoop];
    [run addTimer:timer forMode:NSDefaultRunLoopMode];
    [self animation1];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//***********************************************************************************************

- (IBAction)year:(UIButton *)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1)
    {
        if (iscleacked)
        {
            iscleacked = NO;
            [self.monthButton setEnabled:NO];
            [self.yearButton setBackgroundImage:[UIImage imageNamed:@"Untitled12.png"] forState:UIControlStateNormal];
            
            NSString *tim = self.time.text ;
            NSInteger n = [tim integerValue];
            timeCnvt = n*12;
            self.cnvtTime.text = [NSString stringWithFormat:@"%ld month",(long)timeCnvt];
        }
        else
        {
            self.cnvtTime.text = @"";
            [self.monthButton setEnabled:YES];
            [self.yearButton setBackgroundImage:[UIImage imageNamed:@"Untitled.png"] forState:UIControlStateNormal];
            iscleacked = YES;
        }
        
    }
    else if (button.tag == 2)
    {
        if (iscleacked)
        {
            NSString *tim = self.time.text ;
            NSInteger n = [tim integerValue];
            if (n>=13)
            {
                timeCnvt= n;
                NSInteger x,year,a;
                year = n/12;
                a = (year*12);
                x=n-a;
                self.cnvtTime.text = [NSString stringWithFormat:@"%ld.%ld year",(long)year,(long)x];
            }
            else
            {
                timeCnvt = n;
                self.cnvtTime.text = [NSString stringWithFormat:@"%ld month",(long)timeCnvt];
            }
            [self.yearButton setEnabled:NO];
            [self.monthButton setBackgroundImage:[UIImage imageNamed:@"Untitled12.png"] forState:UIControlStateNormal];
            iscleacked = NO;
        }
        else
        {
            self.cnvtTime.text = @"";
            [self.yearButton setEnabled:YES];
            [self.monthButton setBackgroundImage:[UIImage imageNamed:@"Untitled.png"] forState:UIControlStateNormal];
            iscleacked = YES;
        }
    }
}

//***********************************************************************************************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark textfield delegate
//***********************************************************************************************

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [_cnvtTime setText:@""];
    return YES;
}

//***********************************************************************************************

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma mark calculate button action
//Calculate section with calculation method
//***********************************************************************************************

- (IBAction)calculate:(UIButton *)sender
{
    if (self.amount.text.length == 0)
    {
        ALERT_VIEW(@"Enter a correct",@"amount");
    }
    else if (self.intRate.text.length == 0)
    {
        ALERT_VIEW(@"Enter a correct",@"Interest rate");
    }
    else if (self.time.text.length == 0)
    {
        ALERT_VIEW(@"Enter a correct",@"time");
    }
    else
    {
        [self.emilbl setHidden:NO];
        [self.intlbl setHidden:NO];
        [self.totallbl setHidden:NO];
        
        //NSInteger *emi;
        NSInteger emiInterest, emiPermth, totalEmiInt;
        
        NSString *amt = self.amount.text ;
//        NSString *tim = self.time.text ;
        NSString *intrst = self.intRate.text ;
        
        NSInteger p = [amt integerValue];
//        NSInteger n = [tim integerValue];
        NSInteger r = [intrst integerValue];
                
        self.principalamnt.text = self.amount.text;
        
        emiInterest = (((p*timeCnvt*r)/100)+p)/timeCnvt;
        self.emiamount.text = [NSString stringWithFormat:@"%ld",emiInterest];
        
        totalEmiInt = ((p*timeCnvt*r)/100)+p;
        self.principalamnt.text = [NSString stringWithFormat:@"%ld",totalEmiInt];
        
        emiPermth = totalEmiInt-p;
        self.total.text = [NSString stringWithFormat:@"%ld",emiPermth];
        
        [self.amount resignFirstResponder];
        [self.time resignFirstResponder];
        [self.intRate resignFirstResponder];
    }
}

#pragma mark back button action
//navigation back button action
//***********************************************************************************************

- (IBAction)back:(UIButton *)sender
{
    POP_TO_VIEWCONTROLLER_ANIMATED;
}

#pragma mark animation
//***********************************************************************************************

-(void)animation1
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    if (nowZoomed ==YES)
    {
        [animation setFromValue:[NSNumber numberWithFloat:1.1f]];
        [animation setToValue:[NSNumber numberWithFloat:1.8f]];
        
        // Set duration
        [animation setDuration:0.7f];
        
        // Set animation to be consistent on completion
        [animation setRemovedOnCompletion:NO];
        [animation setFillMode:kCAFillModeBoth];
        
        // Add animation to the view's layer
        [[_imageView layer] addAnimation:animation forKey:@"scale"];
        
    }
    else if (nowZoomed == NO)
    {
        // Set the initial and the final values
        [animation setFromValue:[NSNumber numberWithFloat:1.8f]];
        [animation setToValue:[NSNumber numberWithFloat:1.1f]];
        
        // Set duration
        [animation setDuration:0.7f];
        
        // Set animation to be consistent on completion
        [animation setRemovedOnCompletion:NO];
        [animation setFillMode:kCAFillModeBoth];
        
        // Add animation to the view's layer
        [[_imageView layer] addAnimation:animation forKey:@"scale"];
    }
    nowZoomed = !nowZoomed;
}

#pragma mark dealloc
// Memory release
//***********************************************************************************************

- (void)dealloc
{
    [_imageView release];
    [_intlbl release];
    [_totallbl release];
    [_emilbl release];
    [_principalamnt release];
    [_total release];
    [_emiamount release];
    [_intRate release];
    [_time release];
    [_amount release];
    [_yearButton release];
    [_monthButton release];
    [_cnvtTime release];
    [super dealloc];
}
@end
