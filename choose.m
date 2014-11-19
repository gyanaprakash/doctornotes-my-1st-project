//
//  choose.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "choose.h"
#import "CalculatorViewController.h"

@interface choose ()

@end

@implementation choose

@synthesize VC,general,about,date,time;

//***********************************************************************************************
- (void)viewDidLoad
{
    //FOR ANIMATION TE IMAGE...
    NSArray *imageNames = @[@"dr_icsfdon.png", @"dr_icon 2.png", @"dr_icon 3.png", @"dr_icon 4.png",
                            @"dr_icon.png"];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    _animationImg.animationImages = images;
    _animationImg.animationDuration = 0.9;
    
    [self.view addSubview:_animationImg];
    [_animationImg startAnimating];
   
    nowZoomed = YES;
    NSTimer *timer1 = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:0.7 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    NSRunLoop *run1 = [NSRunLoop currentRunLoop];
    [run1 addTimer:timer1 forMode:NSDefaultRunLoopMode];
    [self animation1];
    
    [self.navigationController setNavigationBarHidden:YES];
        
    NSTimer *timer = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:0.1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    NSRunLoop *run = [NSRunLoop currentRunLoop];
    [run addTimer:timer forMode:NSDefaultRunLoopMode];
    
    NSTimer *dater = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:0.1 target:self selector:@selector(updatedate) userInfo:nil repeats:YES];
    NSRunLoop *daterun = [NSRunLoop currentRunLoop];
    [daterun addTimer:dater forMode:NSDefaultRunLoopMode];
    
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}

//***********************************************************************************************

-(void)updateTimer
{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"HH:mm:ss a"];
    NSString *dateInStringFormated=[dateformatter stringFromDate:[NSDate date]];
    //[time setFont:[UIFont fontWithName:@"DS-DIGII.TTF" size:20]];
    [time setTextColor:[UIColor whiteColor]];
    self.time.text = dateInStringFormated;
}

//***********************************************************************************************

-(void)updatedate
{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"dd-MM-YYYY"];
    NSString *dateInStringFormated=[dateformatter stringFromDate:[NSDate date]];
    [date setTextColor:[UIColor whiteColor]];
    [date setFont:[UIFont fontWithName:@"DS-DIGII.TTF" size:10]];
    self.date.text = dateInStringFormated;
}

//***********************************************************************************************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//***********************************************************************************************

- (IBAction)chooseButton:(UIButton *)sender
{
    UIButton*Button=(UIButton*)sender;

    if (Button.tag == 1) {
        VC = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if (Button.tag == 2)
    {
        general = [[GeneralTask alloc]initWithNibName:@"GeneralTask" bundle:nil];
        [self.navigationController pushViewController:general animated:YES];
    }
    else if (Button.tag == 3)
    {
        CalculatorViewController *emi = [[CalculatorViewController alloc]initWithNibName:@"Calculator" bundle:nil];
        [self.navigationController pushViewController:emi animated:YES];
    }
    else if (Button.tag == 4)
    {
        about = [[[AboutUsViewController alloc]initWithNibName:@"AboutUs" bundle:nil]autorelease];
        [self.navigationController pushViewController:about animated:YES];
    }
    else if (Button.tag == 5)
    {
        self.health = [[HealthTipsViewController alloc]initWithNibName:@"HealthTipsViewController" bundle:nil];
        [self.navigationController pushViewController:_health animated:YES];
    }
    else if (Button.tag == 6)
    {
        exit(0);
    }
}

//***********************************************************************************************

#pragma mark animation

-(void)animation1
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    if (nowZoomed ==YES)
    {
        [animation setFromValue:[NSNumber numberWithFloat:0.8f]];
        [animation setToValue:[NSNumber numberWithFloat:1.0f]];
        
        // Set duration
        [animation setDuration:0.7f];
        
        // Set animation to be consistent on completion
        [animation setRemovedOnCompletion:NO];
        [animation setFillMode:kCAFillModeBoth];
        
        // Add animation to the view's layer
        [[_dr layer] addAnimation:animation forKey:@"scale"];
        [[_user layer] addAnimation:animation forKey:@"scale"];
        [[_cal layer] addAnimation:animation forKey:@"scale"];
        [[_about1 layer] addAnimation:animation forKey:@"scale"];
        [[_imglbl layer]addAnimation:animation forKey:@"scale"];
        [[_healthtips layer]addAnimation:animation forKey:@"scale"];
    }
    else if (nowZoomed == NO)
    {
        // Set the initial and the final values
        [animation setFromValue:[NSNumber numberWithFloat:1.0f]];
        [animation setToValue:[NSNumber numberWithFloat:0.8f]];
        
        // Set duration
        [animation setDuration:0.7f];
        
        // Set animation to be consistent on completion
        [animation setRemovedOnCompletion:NO];
        [animation setFillMode:kCAFillModeBoth];
        
        // Add animation to the view's layer
        [[_dr layer] addAnimation:animation forKey:@"scale"];
        [[_user layer] addAnimation:animation forKey:@"scale"];
        [[_cal layer] addAnimation:animation forKey:@"scale"];
        [[_about1 layer] addAnimation:animation forKey:@"scale"];
        [[_imglbl layer]addAnimation:animation forKey:@"scale"];
        [[_healthtips layer]addAnimation:animation forKey:@"scale"];

    }
    nowZoomed = !nowZoomed;
}

//***********************************************************************************************

-(void)weather
{
    NSURL *url = [NSURL URLWithString:@"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
         }
     }];
}


//***********************************************************************************************

- (void)dealloc
{
    [_imglbl release];
    [about release];
    [_cal release];
    [_user release];
    [_dr release];
    [time release];
    [date release];
    [_animationImg release];
    [_healthtips release];
    [super dealloc];
}
//***********************************************************************************************

@end
