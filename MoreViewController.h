//
//  MoreViewController.h
//  doctornotes
//
//  Created by Balu on 14/01/14.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UITableViewController
{
    NSMutableArray*Data;
    NSMutableArray*images;
}
@property(nonatomic,retain) NSMutableArray*Data;
@property(nonatomic,retain)NSMutableArray*images;
@end
