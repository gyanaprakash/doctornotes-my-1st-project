//
//  HealthTipsViewController.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Easing.h"

#import "EmiModal.h"

@interface HealthTipsViewController : UIViewController

- (IBAction)buttonAction:(UIButton *)sender;


- (IBAction)backbutton:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UIView *stomacview;
@property (retain, nonatomic) IBOutlet UIView *dental;
@property (retain, nonatomic) IBOutlet UIView *diabits;
@property (retain, nonatomic) IBOutlet UIView *brain;
@property (retain, nonatomic) IBOutlet UIView *feaber;
@property (retain, nonatomic) IBOutlet UIView *heart;

@property (retain, nonatomic) IBOutlet UIView *bloodpresure;
@property (retain, nonatomic) IBOutlet UIButton *action;

@end
