//
//  choose.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "GeneralTask.h"
#import "AboutUsViewController.h"
#import "HealthTipsViewController.h"


@interface choose : UIViewController 
{
    bool nowZoomed;

}
@property (nonatomic, retain) ViewController *VC;
@property (nonatomic, retain) GeneralTask *general;
@property (nonatomic, retain) AboutUsViewController*about;
@property (nonatomic, retain) HealthTipsViewController *health;
@property (retain, nonatomic) IBOutlet UILabel *time;
@property (retain, nonatomic) IBOutlet UILabel *date;
@property (retain, nonatomic) IBOutlet UIImageView *animationImg;

- (IBAction)chooseButton:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UIButton *dr;
@property (retain, nonatomic) IBOutlet UIButton *user;
@property (retain, nonatomic) IBOutlet UIButton *cal;
@property (retain, nonatomic) IBOutlet UIButton *about1;
@property (retain, nonatomic) IBOutlet UIButton *healthtips;
@property (retain, nonatomic) IBOutlet UIImageView *imglbl;
-(void)weather;


@end
