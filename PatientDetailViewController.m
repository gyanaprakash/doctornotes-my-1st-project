//
//  PatientDetailViewController.m
//  doctornotes
//
//  Created by Gyana on 06/10/2014.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "PatientDetailViewController.h"
#import "EmiModal.h"
#import "UpdateViewController.h"

@interface PatientDetailViewController ()

@end

@implementation PatientDetailViewController

@synthesize patientDetai,searchBar,recordeArray,filterdAray;
//***********************************************************************************************

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //Hide application navigation bar..
        self.navigationController.NavigationBarHidden = YES;
    }
    return self;
}
//***********************************************************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    [patientDetai setBackgroundColor:[UIColor clearColor]];
    
	// Do any additional setup after loading the view.
    //search bar detail..
    [searchBar setDelegate:self];
    [searchBar setAutocorrectionType:UITextAutocorrectionTypeNo];
    [searchBar setExclusiveTouch:YES];
  
    recordeArray = [[ NSMutableArray alloc]init];
    filterdAray = [[NSMutableArray alloc] init];
}
//***********************************************************************************************

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    AppDelegate*appobj=[[UIApplication sharedApplication]delegate];
   NSManagedObjectContext *context = [appobj managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"PATIENT"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"firstname" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.recordeArray = [[context executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    [patientDetai reloadData];
    isSearching=NO;
    letUserSelectRow=YES;
    searchBar.text=@"";
    [searchBar resignFirstResponder];
}

#pragma mark button actio...
//***********************************************************************************************

- (IBAction)Backbuttonclciked:(UIButton *)sender
{
    POP_TO_VIEWCONTROLLER_ANIMATED;
}

//***********************************************************************************************

- (IBAction)edit:(UIButton *)sender
{
    if(self.editing)
    {
        [self.edit setTitle:@"Edit" forState:UIControlStateNormal];
        [super setEditing:NO animated:NO];
        [patientDetai setEditing:NO animated:NO];
        [patientDetai reloadData];
    }
    else
    {
        [self.edit setTitle:@"Done" forState:UIControlStateNormal];
        [super setEditing:YES animated:YES];
        [patientDetai setEditing:YES animated:YES];
        [patientDetai reloadData];
    }
}

#pragma -mark UITableViewDelegates
//***********************************************************************************************

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isSearching)
		return [filterdAray count];
	else{
      return ([self.recordeArray count]);
    }
}

//***********************************************************************************************

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==NULL)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]autorelease];
        cell.editingAccessoryType=YES; //Enable editing
        cell.accessoryType= UITableViewCellAccessoryDetailDisclosureButton;
    }
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    if(isSearching)
    cell.textLabel.text = [filterdAray objectAtIndex:indexPath.row];
    else
    {
        NSManagedObject *patientObject = [self.recordeArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:[NSString stringWithFormat:@"%@",[patientObject valueForKey:@"firstname"]]];
        NSDateFormatter *dFM = [[NSDateFormatter alloc] init];
        [dFM setDateFormat:@"EEE-MMM-yyyy"];
        NSString *str = [dFM stringFromDate:[patientObject valueForKey:@"currentdate"]];
        [cell.detailTextLabel setText:str];
    }
    return cell;
}

//***********************************************************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedItem = nil;
	if(isSearching)
		selectedItem = [filterdAray objectAtIndex:indexPath.row];
	else
    {
       selectedItem = [recordeArray objectAtIndex:indexPath.row];
    }
        UpdateViewController *detailViewController = [[UpdateViewController alloc]initWithStyle:UITableViewStyleGrouped];
        NSManagedObject *selectedObject = [self.recordeArray objectAtIndex:indexPath.row];
        detailViewController.RecordData=selectedObject;
        
        [self.navigationController pushViewController:detailViewController animated:YES];
        [self.navigationController setNavigationBarHidden:YES];
        [detailViewController release];
}

//***********************************************************************************************

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(letUserSelectRow)
		return indexPath;
	else
		return nil;
}
//***********************************************************************************************

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//***********************************************************************************************

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate*appobj=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appobj managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [context deleteObject:[self.recordeArray objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        [self.recordeArray removeObjectAtIndex:indexPath.row];
        [self.patientDetai deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma -mark UISearchBar
//***********************************************************************************************

-(void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar
{
    if(isSearching)
	isSearching = YES;
	letUserSelectRow = YES;
	self.patientDetai.scrollEnabled = NO;
    return ;
}
//***********************************************************************************************

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText
{
    [filterdAray removeAllObjects];
	if([searchText length] > 0)
    {
		isSearching = YES;
		letUserSelectRow = YES;
		self.patientDetai.scrollEnabled = YES;
		[self searchtableView];
	}
	else
    {
        isSearching = NO;
		letUserSelectRow = YES;
		self.patientDetai.scrollEnabled = NO;
	}
	[self.patientDetai reloadData];
}
//***********************************************************************************************

-(void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    [searchBar resignFirstResponder];
	[self searchtableView];
}
//***********************************************************************************************

-(void)searchtableView
{
    NSString *searchText = searchBar.text;
   
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    for(NSArray *array1 in recordeArray)
	{
        NSMutableArray *array = [NSMutableArray arrayWithObject:[array1 valueForKey:@"firstname"]];
		
		[searchArray addObjectsFromArray:array];
	}
    for (NSString *sTemp in searchArray)
	{
		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
		if (titleResultsRange.length > 0)
        [filterdAray addObject:sTemp];
	}
    searchArray = nil;
}
//***********************************************************************************************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//***********************************************************************************************

- (void)dealloc
{
    [patientDetai release];
    [UISearchBar release];
    [_edit release];
    [super dealloc];
}
@end
