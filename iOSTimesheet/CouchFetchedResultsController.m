//
//  CouchFetchResultsController.m
//  iOSTimesheet
//
//  Created by Roger Williams on 10/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import "CouchFetchedResultsController.h"

@implementation CouchFetchedResultsController

@synthesize couchDBHandler=_couchDBHandler;
@synthesize couchFetchRequest=_couchFetchRequest;
@synthesize delegate;

- (id) initWithCouchRequest: (CouchFetchRequest *) couchFetchReq 
        CouchDBHandler : (CouchDBHandler *) couchDBHandler {
    self = [super init];
    if (self) {
        _couchDBHandler=couchDBHandler; 
        [_couchDBHandler retain];
        _couchFetchRequest=couchFetchReq;
        [_couchFetchRequest retain];
    }
    return self;
}

- (BOOL) performFetch : (NSError **) error {
    return YES;
    
}

@end
