//
//  PatientDetailViewController.h
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UISearchBar*searchBar;
    NSMutableArray *recordeArray;
    NSMutableArray *filterdAray;
    
    BOOL letUserSelectRow;
    BOOL isSearching;
    BOOL editing;
}
@property (retain, nonatomic) IBOutlet UITableView *patientDetai;

@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;

@property(nonatomic, retain) NSMutableArray *recordeArray;
@property(nonatomic, retain) NSMutableArray *filterdAray;

-(void)searchtableView;
@property (retain, nonatomic) IBOutlet UIButton *edit;

- (IBAction)Backbuttonclciked:(UIButton *)sender;
- (IBAction)edit:(UIButton *)sender;

@end
