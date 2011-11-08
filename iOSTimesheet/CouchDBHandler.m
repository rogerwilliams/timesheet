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

@implementation CouchDBHandler

- (int)send: (NSString*)method toPath: (NSString*)relativePath body: (NSData*)body ifMatch:(NSString *)ifMatch
fullResponse: (NSDictionary **) fullResponse eTag: (NSString **)eTag contentType:(NSString *) contentType {
    //    NSLog(@"%@ %@", method, relativePath);
	NSURL* serverURL = [NSURL URLWithString:@"http://127.0.0.1:5984"];
    NSURL* url = [NSURL URLWithString: [relativePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] relativeToURL:serverURL];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = method;
    if (body) {
        request.HTTPBody = body;
        [request addValue: contentType forHTTPHeaderField: @"Content-Type"];
    }
	if (ifMatch)
		[request addValue: ifMatch forHTTPHeaderField: @"If-Match"];
	
    NSHTTPURLResponse* response = nil;
    NSError* error = nil;
	
    NSData* responseBody = [NSURLConnection sendSynchronousRequest: request
												 returningResponse: &response error: &error];
	*eTag = [[response allHeaderFields] objectForKey:@"Etag"] ;
	*eTag = [*eTag stringByReplacingOccurrencesOfString:@"\"" withString:@""];
	
    NSAssert(responseBody != nil && response != nil,
             @"Request to <%@> failed: %@");
    int statusCode = ((NSHTTPURLResponse*)response).statusCode;
	
	*fullResponse = [[CJSONDeserializer deserializer] deserializeAsDictionary:responseBody error:&error];
	return statusCode;
}

@end
