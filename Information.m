//
//  Information.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2014 nacreservices. All rights reserved.
//

#import "Information.h"
#import "EmiModal.h"
@interface Information ()

{
    NSMutableArray *nameData;
}

@end

//***********************************************************************************************
@implementation Information

//***********************************************************************************************
- (void)viewDidLoad
{
    // Do any additional setup after loading the view from its nib.
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"PersonalData" ofType:@"plist"];
    
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *plistPath = [paths stringByAppendingPathComponent:PLIST_NAME];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    nameData = [dict objectForKey:@"TitleName"];
    NSLog(@"%@",nameData);
    [super viewDidLoad];

}

//***********************************************************************************************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [nameData count];
}

//***********************************************************************************************

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [nameData objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    return cell;
}

//***********************************************************************************************
- (IBAction)Back:(id)sender
{
    POP_TO_VIEWCONTROLLER_ANIMATED;
}
//***********************************************************************************************
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//***********************************************************************************************
- (void)dealloc
{
    [_informationtable release];
    [super dealloc];
}
//***********************************************************************************************


@end
