//
//  ZBSettingsViewController.m
//  Bunt
//
//  Created by zonble on 2/9/15.
//
//

#import "ZBSettingsViewController.h"
#import "ZBMainWindowController.h"
#import "ZBSettingKeys.h"

@interface ZBSettingsViewController ()
@property (weak, nonatomic) IBOutlet NSMatrix *matrix;
@end

@implementation ZBSettingsViewController

- (void)loadNib
{
	[super loadNib];
	BOOL loaded = [[NSBundle mainBundle] loadNibNamed:@"ZBSettingsViewController" owner:self topLevelObjects:nil];
	NSAssert((loaded == YES), @"NIB did not load");

	NSInteger lang = [[NSUserDefaults standardUserDefaults] integerForKey:buntPreferredLanguage];
	[self.matrix selectCellAtRow:lang column:0];
}

- (IBAction)chnagePreferredLanguage:(id)sender
{
	NSInteger selectedRow = self.matrix.selectedRow;
	[[NSUserDefaults standardUserDefaults] setInteger:selectedRow forKey:buntPreferredLanguage];
	[[NSUserDefaults standardUserDefaults] synchronize];

	ZBMainWindowController *mainController = (ZBMainWindowController *)[NSApp delegate];
	[mainController changeColorAction:sender];
}

@end
