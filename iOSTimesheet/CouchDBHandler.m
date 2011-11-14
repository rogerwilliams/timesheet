//
//  CouchDBHandler.m
//  iOSTimesheet
//
//  Created by Roger Williams on 9/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import "CouchDBHandler.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "Constants.h"

@implementation CouchDBHandler

@synthesize databaseName;

- (id) initWithDatabaseName:(NSString *) pDatabaseName {
    self = [super init];
    if (self){
        self.databaseName = pDatabaseName;
    }
    return self;
}

- (int)send: (NSString*)method toPath: (NSString*)relativePath body: (NSData*)body ifMatch:(NSString *)ifMatch fullResponse: (NSDictionary **) fullResponse eTag: (NSString **)eTag contentType:(NSString *) contentType error: (NSError **) error {
  //    NSLog(@"%@ %@", method, relativePath);
	NSURL* serverURL = [NSURL URLWithString:@"http://127.0.0.1:5984"];
  NSURL* url = [NSURL URLWithString: [[NSString stringWithFormat:@"%@/%@",
                                       self.databaseName,relativePath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] relativeToURL:serverURL];
  NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
  request.HTTPMethod = method;
  if (body) {
    request.HTTPBody = body;
    [request addValue: contentType forHTTPHeaderField: @"Content-Type"];
  }
	if (ifMatch)
		[request addValue: ifMatch forHTTPHeaderField: @"If-Match"];
	
  NSHTTPURLResponse* response = nil;
	
  NSData* responseBody = [NSURLConnection sendSynchronousRequest: request
                                               returningResponse: &response error: error];
	*eTag = [[response allHeaderFields] objectForKey:@"Etag"] ;
	*eTag = [*eTag stringByReplacingOccurrencesOfString:@"\"" withString:@""];
	
  NSAssert(responseBody != nil && response != nil, @"Request to <%@> failed: %@");
  int statusCode = ((NSHTTPURLResponse*)response).statusCode;
	
	*fullResponse = [[CJSONDeserializer deserializer] deserializeAsDictionary:responseBody error:error];
	return statusCode;
}

- (BOOL) deleteObject:(NSDictionary *) objectToBeDeleted error:(NSError **)error{
    NSString *id = [objectToBeDeleted objectForKey:kPropId];
    
    NSString *deletePath = [NSString stringWithFormat:@"%@/%@",self.databaseName,
                            id];
    
    NSString *eTag;
    NSDictionary *fullResponse;
    
    int statusCode=[self send: @"HEAD" toPath: deletePath body: nil ifMatch:nil fullResponse:&fullResponse eTag:&eTag contentType:nil error:error];
    if (statusCode==200){
        statusCode=[self send: @"DELETE" toPath: deletePath body:nil ifMatch:eTag fullResponse:&fullResponse eTag:&eTag contentType:nil error:error];
        if (statusCode!=200) {
            NSLog(@"Error could not delete couch document %@",deletePath);
            return NO;
        } else {
            return YES;
        }
    } else {
        NSLog(@"Can't find couch document %@ to delete",id);
        return NO;
    }
}

- (BOOL) insertObject:(NSDictionary *) objectToBeInserted error: (NSError **) error{
  NSString *id = [objectToBeInserted objectForKey:kPropId];
  NSString *httpMethod;
  NSString *path;
  NSString *eTag;
  NSDictionary *fullResponse;
  if (id == nil) {
    httpMethod = @"POST";
    path=@"";
  } else {
    httpMethod = @"PUT";
    path = id;
  }
  NSData *objectData = [[CJSONSerializer serializer] serializeDictionary:objectToBeInserted error:error];
  int statusCode=[self send: httpMethod toPath: path body:objectData ifMatch:nil fullResponse:&fullResponse eTag:&eTag contentType:@"application/json" error:error];
  if (statusCode!=201) {
  	DLog(@"Insert failed %d.",statusCode);
  	return NO;
  } else {
    return YES;
  }
}

@end
