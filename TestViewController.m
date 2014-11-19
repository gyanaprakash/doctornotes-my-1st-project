//
//  TestViewController.h
//  CirucularLock
//
//  Created by Gyan on 10/06/14.
//  Copyright (c) 2014 gyan. All rights reserved.
//

#import "TestViewController.h"
#import "CircularLock.h"

@implementation TestViewController

- (void)loadView
{
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    CircularLock *c = [[CircularLock alloc] initWithCenter:CGPointMake(self.view.center.x, self.view.frame.size.height - 100)
                                                    radius:50
                                                  duration:1.5
                                               strokeWidth:15
                                                 ringColor:[UIColor greenColor]
                                               strokeColor:[UIColor whiteColor]
                                               lockedImage:[UIImage imageNamed:@"11.png"]
                                             unlockedImage:[UIImage imageNamed:@"2.png"]
                                                  isLocked:NO
                                         didlockedCallback:^{
                                             [self alertWithMessage:@"Unlocked"];
                                         }
                                       didUnlockedCallback:^{
                                           [self alertWithMessage:@"locked"];
                                       }];
    [self.view addSubview:c];
}

- (void)alertWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCLE", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        choose *choosetype =[[choose alloc]initWithNibName:@"choose" bundle:nil];
        [self.navigationController pushViewController:choosetype animated:YES];
    }
    else
    {
    exit(0);
    }
}

- (void)dealloc {
    [super dealloc];
}
@end
