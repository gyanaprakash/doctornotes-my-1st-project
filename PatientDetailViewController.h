//
//  PatientDetailViewController.h
//  doctornotes
//
//  Created by Mac on 19/12/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *patientTable;
    UISearchBar*searchBar;
    NSMutableArray *recordeArray;
    NSMutableArray *filterdAray;
    BOOL letUserSelectRow;
    BOOL isSearching;
    BOOL editing;
}
@property(nonatomic,retain)  UITableView *patientTable;

@property(nonatomic, retain) UISearchBar*searchBar;

@property(nonatomic, retain) NSMutableArray *recordeArray;
@property(nonatomic, retain) NSMutableArray *filterdAray;

-(void)searchtableView;

-(void)onCancelTouched:(id)sender;


@end
