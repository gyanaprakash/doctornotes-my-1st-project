//
//  EmiCalculationViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "EmiCalculationViewController.h"

@interface EmiCalculationViewController ()

@end

@implementation EmiCalculationViewController
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

/******************************************************************************************************************
 EMI = [P x R x (1+R)N]/[(1+R)N-1]
 
 where 
 P stands for the loan amount or principal
 R is the interest rate per month [if the interest rate per annum is 11%, then the rate of interest will be 11/(12 x 100)]
 N is the number of monthly instalments
********************************************************************************************************************/

//***********************************************************************************************

- (void)dealloc {
    [_noOfMnth release];
    [_intRate release];
    [_amount release];
    [super dealloc];
}
@end
