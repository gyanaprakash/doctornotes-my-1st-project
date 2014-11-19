//
//  EmiCalculationViewController.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmiCalculationViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *amount;
@property (retain, nonatomic) IBOutlet UITextField *intRate;

@property (retain, nonatomic) IBOutlet UITextField *noOfMnth;

@end

/******************************************************************************************************************
 EMI = [P x R x (1+R)N]/[(1+R)N-1]
 
 where
 P stands for the loan amount or principal
 R is the interest rate per month [if the interest rate per annum is 11%, then the rate of interest will be 11/(12 x 100)]
 N is the number of monthly instalments
********************************************************************************************************************/
