

#import "TSActivityViewController.h"
#import "Constants.h"

#define kTextFieldWidth	260.0

static NSString *kSectionTitleKey = @"sectionTitleKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kViewKey = @"viewKey";

const NSInteger kViewTag = 1;


@interface TSActivityViewController()
- (UITextField *) makeTextField;
@end;

@implementation TSActivityViewController

@synthesize  dataSourceArray,timeStamp,activityCode;

- (id)initWithNibNameTimeStampandActivityCode:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
        timestamp:(NSDate *) timestamp activitycode:(NSString *) activitycode
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        timeStamp = timestamp;
        [timeStamp retain];
        activityCode = activitycode;
        [activityCode retain];
    }
	
    return self;
}

- (void)dealloc
{	
	[dataSourceArray release];
    [timeStamp release];
    [activityCode release];
	
	[super dealloc];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.dataSourceArray = [NSArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"MondayHours", kSectionTitleKey,
                             @"Hours for Monday", kSourceKey,
                             [self makeTextField], kViewKey,
							 nil],
                            
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"TuesdayHours", kSectionTitleKey,
                             @"Hours for Tuesday", kSourceKey,
                             [self makeTextField], kViewKey,
							 nil],
                            
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"WednesdayHours", kSectionTitleKey,
                             @"Hours for Wednesday", kSourceKey,
                             [self makeTextField], kViewKey,
							 nil],
                            
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"ThursdayHours", kSectionTitleKey,
                             @"Hours for Thursday", kSourceKey,
                             [self makeTextField], kViewKey,
							 nil],
                            
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"FridayHours", kSectionTitleKey,
                             @"Hours for Friday", kSourceKey,
                             [self makeTextField], kViewKey,
							 nil],
                            
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"SaturdayHours", kSectionTitleKey,
                             @"Hours for Saturday", kSourceKey,
                             [self makeTextField], kViewKey,
							 nil],
                            
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"SundayHours", kSectionTitleKey,
                             @"Hours for Sunday", kSourceKey,
                             [self makeTextField], kViewKey,
							 nil],
							nil];
	
	self.title = NSLocalizedString(activityCode, @"");
	
	// we aren't editing any fields yet, it will be in edit when the user touches an edit field
	self.editing = NO;
}

// called after the view controller's view is released and set to nil.
// For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.
// So release any properties that are loaded in viewDidLoad or can be recreated lazily.
//
- (void)viewDidUnload
{
	[super viewDidUnload];
	
	// release the controls and set them nil in case they were ever created
	// note: we can't use "self.xxx = nil" since they are read only properties
	//
    
    
	
	self.dataSourceArray = nil;
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.dataSourceArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[self.dataSourceArray objectAtIndex: section] valueForKey:kSectionTitleKey];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

// to determine specific row height for each cell, override this.
// In this example, each row is determined by its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return ([indexPath row] == 0) ? 50.0 : 22.0;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	NSUInteger row = [indexPath row];
	if (row == 0)
	{
		static NSString *kCellTextField_ID = @"CellTextField_ID";
		cell = [tableView dequeueReusableCellWithIdentifier:kCellTextField_ID];
		if (cell == nil)
		{
			// a new cell needs to be created
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
										   reuseIdentifier:kCellTextField_ID] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		else
		{
			// a cell is being recycled, remove the old edit field (if it contains one of our tagged edit fields)
			UIView *viewToCheck = nil;
			viewToCheck = [cell.contentView viewWithTag:kViewTag];
			if (viewToCheck)
				[viewToCheck removeFromSuperview];
		}
		
		UITextField *textField = [[self.dataSourceArray objectAtIndex: indexPath.section] valueForKey:kViewKey];
		[cell.contentView addSubview:textField];
	}
//	else /* (row == 1) */
//	{
//		static NSString *kSourceCell_ID = @"SourceCell_ID";
//		cell = [tableView dequeueReusableCellWithIdentifier:kSourceCell_ID];
//		if (cell == nil)
//		{
//			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//										   reuseIdentifier:kSourceCell_ID] autorelease];
//			cell.selectionStyle = UITableViewCellSelectionStyleNone;
//			
//            cell.textLabel.textAlignment = UITextAlignmentCenter;
//            cell.textLabel.textColor = [UIColor grayColor];
//			cell.textLabel.highlightedTextColor = [UIColor blackColor];
//            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
//		}
//		
//		cell.textLabel.text = [[self.dataSourceArray objectAtIndex: indexPath.section] valueForKey:kSourceKey];
//	}
	
    return cell;
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}


#pragma mark -
#pragma mark Text Fields

- (UITextField *)makeTextField
{
    CGRect frame = CGRectMake(kLeftMargin, 8.0, kTextFieldWidth, kTextFieldHeight);
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    
    textField.borderStyle = UITextBorderStyleBezel;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:17.0];
    textField.placeholder = @"<enter text>";
    textField.backgroundColor = [UIColor whiteColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
    
    textField.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
    
    textField.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
    
    textField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
    
    // Add an accessibility label that describes what the text field is for.
    [textField setAccessibilityLabel:NSLocalizedString(@"NormalTextField", @"")];
    [textField autorelease];
	return textField;
}


@end

