//
//  AboutUsViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "AboutUsViewController.h"
#import <QuartzCore/QuartzCore.h>

//********************************************************************************************************

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

@synthesize devlbl;

//********************************************************************************************************

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}
//********************************************************************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    [devlbl setText:@"Developed By"];
    [devlbl setTextColor:[UIColor redColor]];
    [devlbl setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:20]];
    [self.namelbl setTextColor:[UIColor yellowColor]];
    [self.namelbl setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:20]];
}
//********************************************************************************************************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ButtonClicked action
//********************************************************************************************************
- (IBAction)ButtonClicked:(UIButton *)sender
{
        UIButton*Button=(UIButton*)sender;
        if (Button.tag==1)
        {
            SHARED_APPLICATION(@"http://wemakeappz.com/");
        }
        else if (Button.tag==2)
        {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *twetter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [twetter setTitle:@"twetter SHARE"];
                [twetter setEditing:NO];
                [twetter setInitialText:@"My new application DOCTOR,S NOTE"];
                [twetter addURL:[NSURL URLWithString:@"https://www.facebook.com/video.php?v=744127149007429&set=vb.100002304511746&type=2&theater"]];
                [twetter addImage:[UIImage imageNamed:@"shareicon.png"]];
                [self presentViewController:twetter animated:YES completion:nil];
                
                [twetter setCompletionHandler:^(SLComposeViewControllerResult result) {
                    switch (result) {
                        case SLComposeViewControllerResultCancelled:
                            ALERT_VIEW(@"Post Canceled", @"Post Canceled");
                            break;
                        case SLComposeViewControllerResultDone:
                            ALERT_VIEW(@"Post Sucessful", @"Post Sucessful");
                            break;
                        default:
                            break;
                    }
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            }
            else
            {
                ALERT_VIEW(@"Sorry", @"You can't send a facebook right now, make sure your device has an internet connection and you have at least one Twitter account setup");
            }
        }
        else if (Button.tag==3)
        {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [facebook setTitle:@"FACEBOOK SHARE"];
                [facebook setEditing:NO];
                [facebook setInitialText:@"My new application DOCTOR,S NOTE"];
                [facebook addURL:[NSURL URLWithString:@"https://www.facebook.com/video.php?v=744127149007429&set=vb.100002304511746&type=2&theater"]];
                [facebook addImage:[UIImage imageNamed:@"shareicon.png"]];
                [self presentViewController:facebook animated:YES completion:nil];

                [facebook setCompletionHandler:^(SLComposeViewControllerResult result) {
                    switch (result) {
                        case SLComposeViewControllerResultCancelled:
                            ALERT_VIEW(@"Post Canceled", @"Post Canceled");
                            break;
                        case SLComposeViewControllerResultDone:
                            ALERT_VIEW(@"Post Sucessful", @"Post Sucessful");
                            break;
                        default:
                            break;
                    }
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
            }
            else
            {
                ALERT_VIEW(@"Sorry", @"You can't send a facebook right now, make sure your device has an internet connection and you have at least one Twitter account setup");
            }
        }
        else if (Button.tag==4)
        {
            SHARED_APPLICATION(@"http://www.linkedin.com/company/2418845?trk=tyah");
        }
        else if (Button.tag ==5)
        {
            POP_TO_VIEWCONTROLLER_ANIMATED;
        }
}
//********************************************************************************************************

- (void)dealloc
{
    [devlbl release];
    [_namelbl release];
    [super dealloc];
}
//********************************************************************************************************

@end
