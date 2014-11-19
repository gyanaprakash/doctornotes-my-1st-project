//
//  AboutUsViewController.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmiModal.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface AboutUsViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *devlbl;
@property (retain, nonatomic) IBOutlet UILabel *namelbl;

- (IBAction)ButtonClicked:(UIButton *)sender;

@end
