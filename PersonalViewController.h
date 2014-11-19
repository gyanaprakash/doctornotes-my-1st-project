//
//  PersonalViewController.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController

{
    BOOL isclicked;
}

@property (retain, nonatomic) IBOutlet UITextView *personalData;
@property (retain, nonatomic) IBOutlet UIButton *edit;
@property (retain, nonatomic) IBOutlet UILabel *PlaceHolder;
@property (retain, nonatomic) IBOutlet UITextField *titlename;
@property (retain, nonatomic) IBOutlet UILabel *midleHeader;
@property (retain, nonatomic) IBOutlet UILabel *hearderlbl;

- (IBAction)Backbuttonclciked:(UIButton *)sender;

- (IBAction)edit:(UIButton *)sender;
- (IBAction)infotable:(UIButton *)sender;

@end
