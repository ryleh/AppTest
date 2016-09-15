//
//  ViewController.m
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import "ViewController.h"
#import "UserInfoCell.h"
#import "User.h"
#import "DataManager.h"
#import "JsonDataSource.h"
#import "Picture.h"


const static int COUNT = 10;

@interface ViewController ()
{
    NSUInteger _dataCount;
    int _resultsCount;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _resultsCount = COUNT;
    [self initializeFetchedResultsController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* 
    shows more data in the table. If more data is available in database shows that but if no more records available it requests more to be loaded in from the external data source. Reloads the table and sets the show more button to hidden
 */
-(IBAction)showMore:(id)sender
{
    if (_resultsCount >= _dataCount)
    {
        _resultsCount+=COUNT;
            JsonDataSource *data = [[JsonDataSource alloc]init];
            DataManager *manager = [[DataManager alloc] initWithDataSource:data andContext:_managedObjectContext];
            NSArray* users = [manager getRandomUsers:COUNT];
            [manager saveData:users];
        [self.fetchedResultsController.fetchRequest setFetchLimit:_resultsCount];
            [self getEntityCount];
    }

    else
    {
        _resultsCount+=COUNT;
        [self.fetchedResultsController.fetchRequest setFetchLimit:_resultsCount];
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        [self.tableView reloadData];
    }

    [self.showMore setHidden:true];
}

#pragma mark fetch results

/*
 sets up a fetch controller and requests data for users
 */
- (void)initializeFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    NSSortDescriptor *lastNameSort = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    
    [request setSortDescriptors:@[lastNameSort]];
    [request setFetchLimit:_resultsCount];
    
    NSFetchedResultsController *fetchedController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [self setFetchedResultsController:fetchedController];
    [[self fetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    [self getEntityCount];

    
}

-(void)getEntityCount
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    fetchRequest.resultType = NSCountResultType;
    NSError *fetchError = nil;
    _dataCount = [_managedObjectContext countForFetchRequest:fetchRequest error:&fetchError];
    if (_dataCount == NSNotFound) {
        NSLog(@"Fetch error: %@", fetchError);
    }
    NSLog(@"entity count is %lu", (unsigned long)_dataCount);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id< NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}


- (void)configureCell:(UserInfoCell *)cell atIndexPath:(NSIndexPath*)indexPath
{
     NSManagedObject *user = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    cell.name.text = [user valueForKey:@"name"];
    cell.gender.text = [user valueForKey:@"gender"];
    Picture *pic = [user valueForKey:@"picUser"];
    NSURL *url = [NSURL URLWithString:pic.small];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    [cell.imageView setImage:img];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoCell *cell = (UserInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"UserInfoCell" forIndexPath:indexPath];
    // Set up the cell
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

/*
    checks if scroll is at the end of the table and if so it sets the show more button to visible
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    
    CGFloat contentYoffset = scrollView.contentOffset.y;
    
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    
    if(distanceFromBottom <= height)
    {
        [self.showMore setHidden:false];
    }

}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
  //  [[self tableView] beginUpdates];
    [self.tableView beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[[self tableView] cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {

   
    //[self.tableView reloadData];
    [self.tableView endUpdates];
}



@end