//
//  EMICalculatorViewController.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface EMICalculatorViewController : UIViewController<UITextFieldDelegate>
{
    bool nowZoomed;
    BOOL iscleacked;

}
@property (retain, nonatomic) IBOutlet UILabel *cnvtTime;
@property (retain, nonatomic) IBOutlet UITextField *amount;
@property (retain, nonatomic) IBOutlet UITextField *time;
@property (retain, nonatomic) IBOutlet UITextField *intRate;
@property (retain, nonatomic) IBOutlet UILabel *emiamount;
@property (retain, nonatomic) IBOutlet UILabel *total;
@property (retain, nonatomic) IBOutlet UILabel *principalamnt;
@property (retain, nonatomic) IBOutlet UILabel *emilbl;
@property (retain, nonatomic) IBOutlet UILabel *totallbl;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (retain, nonatomic) IBOutlet UILabel *intlbl;

- (IBAction)calculate:(UIButton *)sender;
- (IBAction)back:(UIButton *)sender;
- (IBAction)year:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UIButton *yearButton;
@property (retain, nonatomic) IBOutlet UIButton *monthButton;

@end
