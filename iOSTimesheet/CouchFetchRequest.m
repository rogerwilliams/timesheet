//
//  CouchFetchRequest.m
//  iOSTimesheet
//
//  Created by Roger Williams on 10/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import "CouchFetchRequest.h"

@implementation CouchFetchRequest

@synthesize viewName=_viewName;
@synthesize startKey=_startKey;
@synthesize endKey=_endKey;
@synthesize fetchBatchSize=_fetchBatchSize;
@synthesize sortAscending;

- (id) initWithViewName: (NSString *) viewName {
    self = [super init];
    if (self) {
        _viewName=viewName;
        [viewName retain];
    }
    return self;
}



@end
