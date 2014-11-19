//
//  CalculatorViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "CalculatorViewController.h"
#import "EmiModal.h"
@interface CalculatorViewController ()

@end

@implementation CalculatorViewController
//***********************************************************************************************

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//***********************************************************************************************

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//***********************************************************************************************

- (IBAction)buttonAction:(UIButton *)sender
{
    UIButton*Button=(UIButton*)sender;
    if (Button.tag == 1)
    {
        POP_TO_VIEWCONTROLLER_ANIMATED;
    }
    else if (Button.tag == 2)
    {
        EMICalculatorViewController *emiCal = [[EMICalculatorViewController alloc]initWithNibName:@"EMICalculatorViewController" bundle:nil];
        [self.navigationController pushViewController:emiCal animated:YES];
    }
}
//***********************************************************************************************

@end
