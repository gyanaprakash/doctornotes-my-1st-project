//
//  MoreViewController.m
//  doctornotes
//
//  Created by Balu on 14/01/14.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "MoreViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize images;
@synthesize Data;
#define kBoarderWidth 3.0
#define kCornerRadius 8.0
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setTitle:@"More Options"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UIImageView*backview=[[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 412)]autorelease];
    [backview setImage:[UIImage imageNamed:@"background.png"]];
    [self.tableView setBackgroundView:backview];
    [self.tableView setScrollEnabled:NO];
    Data=[[NSMutableArray alloc]initWithObjects:@"Nacreservices.com",@"Nacre on Twitter",@"Nacre on Facebook",@"Nacre on Linkedin",@"nareshit.in",nil];
    images=[[NSMutableArray alloc]initWithObjects:@"www.png",@"twitter.png",@"facebook.png",@"linkedin.png",@"www.png",nil];
    CALayer *borderLayer = [CALayer layer];
    CGRect borderFrame = CGRectMake(0, 0, 320, 412);
    [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [borderLayer setFrame:borderFrame];
    [borderLayer setMasksToBounds:YES];
    [borderLayer setNeedsDisplayOnBoundsChange:YES];
    [borderLayer setCornerRadius:kCornerRadius];
    [borderLayer setBorderWidth:kBoarderWidth-1];
    [borderLayer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.view.layer addSublayer:borderLayer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([Data count]);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    UILabel*nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake( 73.0, 0.0, 230.0, 40 )] autorelease];
    nameLabel.font = [UIFont fontWithName:@"chalkduster" size:20];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    [nameLabel setTextAlignment:NSTextAlignmentLeft];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text=[Data objectAtIndex:indexPath.row];
    [cell.contentView addSubview: nameLabel];
    NSString*imagetitle=[images objectAtIndex:indexPath.row];
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(10,15, 50, 50)];
    imv.image=[UIImage imageNamed:imagetitle];
    [cell.contentView addSubview:imv];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.nacreservices.com"]];
        
    }
    if(indexPath.row==1)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://twitter.com/nacrean"]];
    }
    else if(indexPath.row==2)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://www.facebook.com/pages/Nacre/255639417830767"]];
    }
    else if(indexPath.row==3)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.linkedin.com/company/2418845?trk=tyah"]];
    }
    else if(indexPath.row==4)
    {
         [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://nareshit.in"]];
    }
    else;
}

@end
