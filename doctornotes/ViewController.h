//
//  ViewController.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPatientViewController.h"

@interface ViewController : UIViewController<UINavigationBarDelegate,UINavigationControllerDelegate>

@property (retain, nonatomic) IBOutlet UIButton *AddPatientbutton;
@property (retain, nonatomic) IBOutlet UIButton *PateintDetail;
@property (retain, nonatomic) IBOutlet UIButton *Appointment;
@property (retain, nonatomic) IBOutlet UIButton *More;
@property (retain, nonatomic) IBOutlet UIButton *AboutUs;

- (IBAction)ButtonClicked:(UIButton *)sender;

@end
