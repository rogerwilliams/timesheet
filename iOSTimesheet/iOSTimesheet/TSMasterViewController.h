//
//  TSMasterViewController.h
//  iOSTimesheet
//
//  Created by Roger Williams on 2/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CouchFetchedResultsController.h"

@class TSDetailViewController;
@class CouchDBHandler;
@class CouchFetchedResultsController;
@protocol CouchFetchedResultsControllerDelegate;


@interface TSMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate,CouchFetchedResultsControllerDelegate>

@property (strong, nonatomic) TSDetailViewController *detailViewController;

@property (strong, nonatomic) CouchFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) CouchDBHandler *couchDBHandler;
@property (strong, nonatomic) NSFetchedResultsController *couchFetchResultController;

@end
