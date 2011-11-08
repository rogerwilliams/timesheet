//
//  TSAppDelegate.h
//  iOSTimesheet
//
//  Created by Roger Williams on 2/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouchDBHandler.h"

@interface TSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) CouchDBHandler *couchDBHandler;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) UISplitViewController *splitViewController;

@end
