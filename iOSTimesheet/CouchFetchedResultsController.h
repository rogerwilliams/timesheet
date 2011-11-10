//
//  CouchFetchResultsController.h
//  iOSTimesheet
//
//  Created by Roger Williams on 10/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CouchDBHandler.h"
//#import "CouchFetchRequest.h"

@protocol CouchFetchedResultsControllerDelegate;
@class CouchFetchRequest;
@class CouchDBHandler;


@interface CouchFetchedResultsController : NSObject

- (id) initWithCouchRequest: (CouchFetchRequest *) couchFetchReq 
        CouchDBHandler : (CouchDBHandler *) couchDBHandler;

- (BOOL) performFetch : (NSError **) error;

@property (readonly, strong, nonatomic) CouchDBHandler *couchDBHandler;
@property (readonly, strong, nonatomic) CouchFetchRequest *couchFetchRequest;
/* Delegate that is notified when the result set changes.
 */
@property (nonatomic, assign) id <CouchFetchedResultsControllerDelegate > delegate;

@end

@protocol CouchFetchedResultsControllerDelegate

enum {
	CouchFetchedResultsChangeInsert = 1,
	CouchFetchedResultsChangeDelete = 2,
	CouchFetchedResultsChangeMove = 3,
	CouchFetchedResultsChangeUpdate = 4
	
};
typedef NSUInteger CouchFetchedResultsChangeType;

/* Notifies the delegate that a fetched object has been changed due to an add, remove, move, or update. Enables NSFetchedResultsController change tracking.
 controller - controller instance that noticed the change on its fetched objects
 anObject - changed object
 indexPath - indexPath of changed object (nil for inserts)
 type - indicates if the change was an insert, delete, move, or update
 newIndexPath - the destination path for inserted or moved objects, nil otherwise
 
 Changes are reported with the following heuristics:
 
 On Adds and Removes, only the Added/Removed object is reported. It's assumed that all objects that come after the affected object are also moved, but these moves are not reported. 
 The Move object is reported when the changed attribute on the object is one of the sort descriptors used in the fetch request.  An update of the object is assumed in this case, but no separate update message is sent to the delegate.
 The Update object is reported when an object's state changes, and the changed attributes aren't part of the sort keys. 
 */
@optional
- (void)controller:(CouchFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(CouchFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath;

/* Notifies the delegate of added or removed sections.  Enables NSFetchedResultsController change tracking.
 
 controller - controller instance that noticed the change on its sections
 sectionInfo - changed section
 index - index of changed section
 type - indicates if the change was an insert or delete
 
 Changes on section info are reported before changes on fetchedObjects. 
 */
@optional
- (void)controller:(CouchFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(CouchFetchedResultsChangeType)type;

/* Notifies the delegate that section and object changes are about to be processed and notifications will be sent.  Enables NSFetchedResultsController change tracking.
 Clients utilizing a UITableView may prepare for a batch of updates by responding to this method with -beginUpdates
 */
@optional
- (void)controllerWillChangeContent:(CouchFetchedResultsController *)controller;

/* Notifies the delegate that all section and object changes have been sent. Enables NSFetchedResultsController change tracking.
 Providing an empty implementation will enable change tracking if you do not care about the individual callbacks.
 */
@optional
- (void)controllerDidChangeContent:(CouchFetchedResultsController *)controller;

/* Asks the delegate to return the corresponding section index entry for a given section name.	Does not enable NSFetchedResultsController change tracking.
 If this method isn't implemented by the delegate, the default implementation returns the capitalized first letter of the section name (seee NSFetchedResultsController sectionIndexTitleForSectionName:)
 Only needed if a section index is used.
 */
@optional
- (NSString *)controller:(CouchFetchedResultsController *)controller sectionIndexTitleForSectionName:(NSString *)sectionName __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_0);

@end

