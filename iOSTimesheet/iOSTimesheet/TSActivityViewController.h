//
//  TSActivityViewController.h
//  iOSTimesheet
//
//  Created by Roger Williams on 8/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSActivityViewController : UITableViewController <UITextFieldDelegate>


@property (nonatomic, retain) NSArray *dataSourceArray;
@property (nonatomic, retain, readonly) NSDate * timeStamp;
@property (nonatomic, retain, readonly) NSString * activityCode;


- (id)initWithNibNameTimeStampandActivityCode:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
                                             timestamp:(NSDate *) timestamp activitycode:(NSString *) activitycode;

@end
