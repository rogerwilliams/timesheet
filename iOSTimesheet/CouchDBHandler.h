//
//  CouchDBHandler.h
//  iOSTimesheet
//
//  Created by Roger Williams on 9/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouchDBHandler : NSObject

- (int)send: (NSString*)method toPath: (NSString*)relativePath body: (NSData*)body ifMatch:(NSString *)ifMatch
    fullResponse: (NSDictionary **) fullResponse eTag: (NSString **)eTag contentType:(NSString *) contentType;
@end