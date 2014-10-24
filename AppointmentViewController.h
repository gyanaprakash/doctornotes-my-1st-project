//
//  AppointmentViewController.h
//  doctornotes
//
//  Created by Mac on 19/12/13.
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
@property(nonatomic,retain)UITextField *dateField;
@property(nonatomic,retain)UITableView *appointmentTable;
@property(nonatomic,retain)NSMutableArray *recordeArray2;
@property(nonatomic,retain)NSMutableArray *fullDetailarray2;


- (void)pickerChanged:(id)sender;
@end
