//
//  GeneralTask.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "GeneralTask.h"
#import "PersonalViewController.h"
#import "EmiModal.h"
@interface GeneralTask ()

@end

@implementation GeneralTask
//***********************************************************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//***********************************************************************************************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//***********************************************************************************************

- (IBAction)back:(UIButton *)sender
{
    UIButton*Button=(UIButton*)sender;
    if (Button.tag == 1)
    {
        POP_TO_VIEWCONTROLLER_ANIMATED;
    }
    else if (Button.tag == 2)
    {
        PersonalViewController *personal = [[PersonalViewController alloc]initWithNibName:@"PersonalViewController" bundle:nil];
        [self.navigationController pushViewController:personal animated:YES];
    }
}

//***********************************************************************************************

@end
