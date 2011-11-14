//
//  CouchFetchResultsController.m
//  iOSTimesheet
//
//  Created by Roger Williams on 10/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import "CouchFetchedResultsController.h"
#import "CouchFetchRequest.h"
#import "CouchDBHandler.h"
#import "Constants.h"

NSArray *fetchResults;

@implementation CouchFetchedResultsController

@synthesize couchDBHandler=_couchDBHandler;
@synthesize couchFetchRequest=_couchFetchRequest;
@synthesize delegate;

- (id) initWithCouchRequest: (CouchFetchRequest *) couchFetchReq 
        CouchDBHandler : (CouchDBHandler *) couchDBHandler {
  NSAssert(couchDBHandler,@"CouchDB handler is null and cannot be");
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
    //Downloaded successfully
    NSDictionary *fullResponse;
    
    NSArray * viewParts = [self.couchFetchRequest.viewName componentsSeparatedByString:@"/"];
    NSString *designDoc = [viewParts objectAtIndex:0];
    NSString *viewName = [viewParts objectAtIndex:1];
    NSString *syncView = [NSString stringWithFormat:@"_design/%@/_view/%@",
                          designDoc,viewName];
    NSString *eTag = nil;
    int statusCode = [self.couchDBHandler send: @"GET" toPath: syncView body: nil ifMatch:nil fullResponse:&fullResponse eTag:&eTag contentType:nil error:error];
    if (statusCode==200){
        fetchResults = [fullResponse objectForKey:@"rows"];
      DLog(@"Fetch complete %d rows",[fetchResults count]);
      return YES;
    } else {
      NSLog(@"fetch failed %d",statusCode);
      return NO;
    }
}

- (NSArray *) sections {
    return fetchResults;
}

- (NSDictionary *) objectAtIndexPath:(NSIndexPath *)indexPath{
  int rowPosition = [indexPath indexAtPosition:1];
  NSDictionary * theRow =  [fetchResults objectAtIndex:rowPosition];
  return [theRow objectForKey:@"value"];
}

@end
