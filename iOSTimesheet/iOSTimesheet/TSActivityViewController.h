//
//  TSActivityViewController.h
//  iOSTimesheet
//
//  Created by Roger Williams on 8/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSActivityViewController : UITableViewController <UITextFieldDelegate>


@property (nonatomic, retain, readonly) UITextField	*textFieldNormal;
@property (nonatomic, retain, readonly) UITextField	*textFieldRounded;
@property (nonatomic, retain, readonly) UITextField	*textFieldSecure;
@property (nonatomic, retain, readonly) UITextField	*textFieldLeftView;

@property (nonatomic, retain) NSArray *dataSourceArray;

@end
