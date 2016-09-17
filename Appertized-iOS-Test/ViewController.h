//
//  ViewController.h
//  Appertized-iOS-Test
//
//  Created by Peter Hall on 13/09/2016.
//  Copyright © 2016 Peter Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UIViewController<NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>


@property(nonatomic, weak)IBOutlet UITableView*tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property(nonatomic, weak) IBOutlet UIButton*showMore;
@property(nonatomic, weak) IBOutlet UIBarButtonItem*sort;
@property (weak, nonatomic) IBOutlet UIPickerView *sortPicker;

-(IBAction)showMore:(id)sender;
-(IBAction)sortList:(id)sender;

@end

