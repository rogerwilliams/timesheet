//
//  TSDetailViewController.h
//  iOSTimesheet
//
//  Created by Roger Williams on 2/11/11.
//  Copyright (c) 2011 UXC Professional Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSDetailTableDelegate.h"

@interface TSDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong,nonatomic)  TSDetailTableDelegate * tableDelegate;

@property (strong,nonatomic) IBOutlet UITableView * tableview;

@end
