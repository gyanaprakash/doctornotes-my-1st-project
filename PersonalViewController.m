//
//  PersonalViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "PersonalViewController.h"
#import "EmiModal.h"
#import "Information.h"

//***********************************************************************************************

@interface PersonalViewController ()

{
    NSMutableDictionary *data;
    NSMutableArray *arraysData;
}

@end
@implementation PersonalViewController

//***********************************************************************************************

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES];
     data= [[NSMutableDictionary alloc] init];

    isclicked = NO;
    [super viewDidLoad];
    self.titlename.enabled = NO;
    [self.personalData setUserInteractionEnabled:NO];
    [self.personalData.layer setBorderColor:[[[UIColor redColor] colorWithAlphaComponent:1.0] CGColor]];
    [self.personalData.layer setBorderWidth:2.0];
    self.personalData.layer.cornerRadius = 5;
    
    self.titlename.layer.borderColor=[[UIColor redColor]CGColor];
    self.titlename.layer.cornerRadius = 5;
    self.titlename.layer.borderWidth=2.0;
    [self.midleHeader setTextColor:[UIColor redColor]];
    [self.midleHeader setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:20]];
    
    [self.hearderlbl setTextColor:[UIColor redColor]];
    [self.hearderlbl setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:20]];
}

#pragma mark Button Clciked Method

//****************************************************************************************************************
- (IBAction)Backbuttonclciked:(UIButton *)sender
{
    POP_TO_VIEWCONTROLLER_ANIMATED;
}

//****************************************************************************************************************

- (IBAction)edit:(UIButton *)sender {
    if (!isclicked)
    {
        isclicked=YES;
        self.titlename.enabled = YES;
        [self.personalData setUserInteractionEnabled:YES];
        [self.edit setTitle:@"Save" forState:UIControlStateNormal];
        if (self.personalData.text > 0)
        {
            self.PlaceHolder.text = @"";
        }
    }
    else
    {
        if (_titlename.text.length == 0)
        {
            ALERT_VIEW(@"Enter a valid", @"Name");
        }
        else if (_personalData.text.length == 0)
        {
            ALERT_VIEW(@"Enter a valid", @"Information");
        }
        else
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *path = [documentsDirectory stringByAppendingPathComponent:PLIST_NAME];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            if ((path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:PLIST_NAME]))
            {
                if ([fileManager isWritableFileAtPath:path])
                {
                    NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
                    [infoDict setObject:_titlename.text forKey:@"TitleName"];
                    [infoDict writeToFile:path atomically:YES];
                    [fileManager changeFileAttributes:[NSDictionary dictionaryWithObject:[NSDate date] forKey:NSFileModificationDate] atPath: [[NSBundle mainBundle] bundlePath]];
                }
           
                NSError *error = nil;
            NSMutableDictionary *plistDict = [NSMutableDictionary dictionaryWithObject:_titlename.text forKey:@"TitleName"];
            NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                           format:NSPropertyListXMLFormat_v1_0
                                                                 errorDescription:error];
            if(plistData) {
                [plistData writeToFile:plistData atomically:YES];
                NSLog(@"%@",plistData);
                self.PlaceHolder.text=@"Click on edit then enter your information";
                [self.edit setTitle:@"Edit" forState:UIControlStateNormal];
                self.personalData.text = @"";
                self.titlename.text = @"";
                [self.personalData resignFirstResponder];
                [self.titlename resignFirstResponder];
            }
            else {
                [error release];
            }
        }
            
    }
    }
}
    //navigation orieantation and custom key board
//*****************************************************************************************************************

#pragma MARK INFORMATIONTABLE BUTTON CLICKED

- (IBAction)infotable:(UIButton *)sender
    {
        Information *info =[[Information alloc]initWithNibName:@"Information" bundle:nil];
        [self.navigationController pushViewController:info animated:YES];
    }

//******************************************************************************************************************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//******************************************************************************************************************

- (void)dealloc
{
    [_personalData release];
    [_edit release];
    [_titlename release];
    [_midleHeader release];
    [_hearderlbl release];
    [super dealloc];
}
//******************************************************************************************************************

@end

