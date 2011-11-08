//
//  TSDetailViewController.h
//  iOSTimesheet
//
//  Created by Roger Williams on 2/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class CouchDBHandler;

@interface TSDetailViewController : UITableViewController <UISplitViewControllerDelegate,NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) CouchDBHandler *couchDBHandler;

@end
