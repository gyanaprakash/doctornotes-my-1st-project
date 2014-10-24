//
//  PatientDetailViewController.m
//  doctornotes
//
//  Created by Mac on 19/12/13.
//  Copyright (c) 2013 nacreservices. All rights reserved.
//

#import "PatientDetailViewController.h"
#import "AppDelegate.h"
#import "UpdateViewController.h"
@interface PatientDetailViewController ()

@end

@implementation PatientDetailViewController
@synthesize patientTable,searchBar,recordeArray,filterdAray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationItem setTitle:@"Visited Patients"];
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    UIBarButtonItem*button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
     self.navigationItem.rightBarButtonItem = button;
    
    UIBarButtonItem*backbutton=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelTouched:)];
    self.navigationItem.leftBarButtonItem = backbutton;
    
    patientTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 415) style:UITableViewStylePlain];
    [patientTable setDelegate:self];
    [patientTable setDataSource:self];
    [self.view addSubview:patientTable];
    

    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    [searchBar setDelegate:self];
    [searchBar setAutocorrectionType:UITextAutocorrectionTypeNo];
    [searchBar setExclusiveTouch:YES];
    self.patientTable.tableHeaderView = searchBar;
    
  
    recordeArray = [[ NSMutableArray alloc]init];
    filterdAray = [[NSMutableArray alloc] init];
  
}

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
    
     [patientTable reloadData];
    isSearching=NO;
    letUserSelectRow=YES;
    searchBar.text=@"";
    [searchBar resignFirstResponder];
    
}
-(void)edit
{
    if(self.editing)
	{
		[super setEditing:NO animated:NO];
		[patientTable setEditing:NO animated:NO];
		[patientTable reloadData];
        UIBarButtonItem*button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
        self.navigationItem.rightBarButtonItem = button;
        [self.navigationItem.leftBarButtonItem setEnabled:TRUE];
	}
	else
	{
		[super setEditing:YES animated:YES];
		[patientTable setEditing:YES animated:YES];
		[patientTable reloadData];
		UIBarButtonItem*button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(edit)];
        self.navigationItem.rightBarButtonItem = button;
        [self.navigationItem.leftBarButtonItem setEnabled:FALSE];
        
	}
}
-(void)onCancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark UITableViewDelegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isSearching)
		return [filterdAray count];
	else{
      return ([self.recordeArray count]);
    }
}

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
    if(isSearching)
    cell.textLabel.text = [filterdAray objectAtIndex:indexPath.row];
    else
    {
            NSManagedObject *patientObject = [self.recordeArray objectAtIndex:indexPath.row];
        
       //NSString *moID= [[[patientObject objectID]URIRepresentation]absoluteString];
        //NSLog(@"%@",moID);
       
            [cell.textLabel setText:[NSString stringWithFormat:@"%@",[patientObject valueForKey:@"firstname"]]];
            
            NSDateFormatter *dFM = [[NSDateFormatter alloc] init];
            [dFM setDateFormat:@"EEE-MMM-yyyy"];
            
            NSString *str = [dFM stringFromDate:[patientObject valueForKey:@"currentdate"]];
            [cell.detailTextLabel setText:str];
        }
    return cell;
}
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
        [detailViewController release];
}

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(letUserSelectRow)
		return indexPath;
	else
		return nil;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate*appobj=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appobj managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete object from database
        [context deleteObject:[self.recordeArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        // Remove device from table view
        [self.recordeArray removeObjectAtIndex:indexPath.row];
        [self.patientTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma -mark UISearchBar
-(void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar{
	
	if(isSearching)
		return;
	isSearching = YES;
	letUserSelectRow = NO;
	self.patientTable.scrollEnabled = NO;
}
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
	
	[filterdAray removeAllObjects];
    
	if([searchText length] > 0)
    {
		isSearching = YES;
		letUserSelectRow = YES;
		self.patientTable.scrollEnabled = YES;
		[self searchtableView];
	}
	else
    {
		isSearching = NO;
		letUserSelectRow = NO;
		self.patientTable.scrollEnabled = NO;
	}
	[self.patientTable reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    [searchBar resignFirstResponder];
	[self searchtableView];
}
-(void)searchtableView
{
    NSString *searchText = searchBar.text;
   
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    for(NSArray *array1 in recordeArray)
	{
        NSMutableArray *array = [NSArray arrayWithObject:[array1 valueForKey:@"firstname"]];
		
		[searchArray addObjectsFromArray:array];
	}
    
	for (NSString *sTemp in searchArray)
	{
		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
		if (titleResultsRange.length > 0)
            
        [filterdAray addObject:sTemp];
        //NSLog(@"%@",filterdAray);
	}

     searchArray = nil;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
