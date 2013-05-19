//
//  MasterViewController.h
//  Gilligizer
//
//  Created by Paul Pilone on 4/22/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)segmentedControlValueChanged:(id)sender;

@end
