//
//  EmiModal.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "EmiModal.h"

@implementation EmiModal

/***********************************************************
 interest cal culation = (P * R/12) * [ (1+R/12)^N] / [ (1+R/12)^N-1], where
 
 P = Principal (loan amount);
 R = Annual Interest Rate;
 N = No. of Monthly Instalments
 
 EMI = (L*I)* {(1+I)^N / [(1+I)^N]-1}
 
 Where
 
 L = loan amount
 I = interest Rate(rate per annum devided by 12)
 ^ = to the power of
 N = Loan Period in months
 
 Assuming a loan of Rs. 1 lakh at 11% per annum,repayable in 15 years, the EMI using the formula will be:
 
 EMI = (100000*0.00916)* {(1+0.00916)^180 / [(1+0.00916)^180]-1}
 
 = 916 * (5.161846 / 4.161846)
 
 EMI = Rs. 1,136
 ************************************************************/


@end
