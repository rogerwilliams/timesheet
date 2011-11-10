//
//  CouchFetchRequest.h
//  iOSTimesheet
//
//  Created by Roger Williams on 10/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouchFetchRequest : NSObject

- (id) initWithViewName: (NSString *) viewName;

@property (readonly,nonatomic,retain) NSString *viewName;
@property (nonatomic,retain) NSArray *startKey;
@property (nonatomic,retain) NSArray *endKey;

@end


