//
//  AppointmentViewController.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentViewController : UIViewController<UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate>
{
    UIDatePicker *picker;
    UITableView *appointmentTable;
    UITextField *dateField;
    UIActionSheet *actionSheet;
    NSMutableArray *recordeArray2;
    NSMutableArray *fullDetailarray2;

}
@property(nonatomic,retain)UIDatePicker *picker;
@property(nonatomic,retain) UIActionSheet *actionSheet;
@property(nonatomic,retain)NSMutableArray *recordeArray2;
@property(nonatomic,retain)NSMutableArray *fullDetailarray2;
//@property (retain, nonatomic) IBOutlet UILabel *dateField;
@property (retain, nonatomic) IBOutlet UITableView *appointmentTable;
@property (retain, nonatomic) IBOutlet UITextField *dateField;

- (IBAction)Backbuttobclicked:(id)sender;

- (void)pickerChanged:(id)sender;
@end
