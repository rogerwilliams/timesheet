//
//  TSMasterViewController.h
//  iOSTimesheet
//
//  Created by Roger Williams on 2/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSDetailViewController;

#import <CoreData/CoreData.h>

@interface TSMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) TSDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
