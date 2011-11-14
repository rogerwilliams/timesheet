// these are the various screen placement constants used across most the UIViewControllers

// padding for margins

// for general screen
#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			6.0

#define kTextFieldHeight		30.0

#pragma mark View names

#define kViewTimesheetByUser    @"appviews/timesheetByUser"

#pragma  mark Document types

#define kTypeTimesheet    @"timesheet"

#pragma mark Document properties

#define kPropId           @"id"
#define kPropType         @"type"
#define kProptimestamp    @"timestamp"

#pragma mark Debug
//#define DEBUG 1
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif