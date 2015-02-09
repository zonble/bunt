//
//	ZBMainWindowController.m
//	Bunt
//
//	Created by zonble on 2009/3/3.
//

#import "ZBMainWindowController.h"
#import "ZBNSColorViewController.h"
#import "ZBUIColorViewController.h"
#import "ZBCGColorViewController.h"
#import "ZBGLColorViewController.h"
#import "ZBSettingsViewController.h"
#import "ZBSettingKeys.h"

static NSString *const colorWellIdentifier = @"Color Well";
static NSString *const nscolorIdentifier = @"NSColor";
static NSString *const uicolorIdentifier = @"UIColor";
static NSString *const cgcolorIdentifier = @"CGColor";
static NSString *const glcolorIdentifier = @"GLColor";
static NSString *const settingIdentifier = @"Settings";

@interface ZBMainWindowController ()
@property (strong, nonatomic) ZBNSColorViewController *nsColorController;
@property (strong, nonatomic) ZBUIColorViewController *uiColorController;
@property (strong, nonatomic) ZBCGColorViewController *cgColorController;
@property (strong, nonatomic) ZBGLColorViewController *glColorController;
@property (strong, nonatomic) ZBSettingsViewController *settingController;
@end

@interface ZBMainWindowController (Toolbar) <NSToolbarDelegate>
@end

@interface ZBMainWindowController (Window) <NSWindowDelegate>
@end

@implementation ZBMainWindowController

- (void)awakeFromNib
{
	_nsColorController = [[ZBNSColorViewController alloc] init];
	_uiColorController = [[ZBUIColorViewController alloc] init];
	_cgColorController = [[ZBCGColorViewController alloc] init];
	_glColorController = [[ZBGLColorViewController alloc] init];
	_settingController = [[ZBSettingsViewController alloc] init];

	NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"toolbar"];
	[toolbar setDelegate:self];
	[toolbar setVisible:YES];
	[toolbar setSizeMode:NSToolbarSizeModeRegular];
	[toolbar setAllowsUserCustomization:NO];
	[toolbar setAutosavesConfiguration:NO];
	[[self window] setToolbar:toolbar];

	NSStatusBar *bar = [NSStatusBar systemStatusBar];

	_statusBarItem = [bar statusItemWithLength:NSVariableStatusItemLength];

	[_statusBarItem setImage:[NSImage imageNamed:@"Bunt32"]];
	[_statusBarItem setAlternateImage:[NSImage imageNamed:@"Bunt32w"]];
	[_statusBarItem setHighlightMode:YES];
	[_statusBarItem setMenu:_statusMenu];

	NSString *lastUsedToolbarItem = [[NSUserDefaults standardUserDefaults] objectForKey:buntLastUsedToolbarItem];
	if (!lastUsedToolbarItem || ![lastUsedToolbarItem length]) {
		lastUsedToolbarItem = nscolorIdentifier;
	}

	[toolbar setSelectedItemIdentifier:lastUsedToolbarItem];
	[self setContentViewWithIdentifier:lastUsedToolbarItem];
	[self changeColorAction:nil];

	NSScreen *mainScreen = [NSScreen mainScreen];
	NSRect screenFrame = [mainScreen visibleFrame];
	CGFloat x = NSMaxX(screenFrame) - [[self window] frame].size.width - 10;
	CGFloat y = NSMaxY(screenFrame) - 20;
	[[self window] setFrameTopLeftPoint:NSMakePoint(x, y)];
	[[self window] setDelegate:self];
}
- (NSColor *)currentColor
{
	return [_colorWell color];
}

#pragma mark Interface Builder Actions.

- (void)setContentViewWithIdentifier:(NSString *)identifier
{
	NSDictionary *map = @{
	  nscolorIdentifier: _nsColorController,
	  uicolorIdentifier: _uiColorController,
	  cgcolorIdentifier: _cgColorController,
	  glcolorIdentifier: _glColorController,
	  settingIdentifier: _settingController};
	NSView *view = [map[identifier] view];

	if (view) {
		[[NSUserDefaults standardUserDefaults] setObject:identifier forKey:buntLastUsedToolbarItem];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[self setContentViewWithView:view];
	}
}
- (void)setContentViewWithView:(NSView *)view
{
	NSArray *array = [NSArray arrayWithArray:[[[self window] contentView] subviews]];
	NSEnumerator *e = [array objectEnumerator];
	NSView *subview = nil;
	while (subview = [e nextObject]) {
		if ([subview superview]) {
			[subview removeFromSuperview];
		}
	}
	NSRect windowFrame = [[self window] frame];
	windowFrame.origin.y = NSMaxY(windowFrame) - 70 - [view bounds].size.height;
	windowFrame.size.height = [view bounds].size.height + 70;
	windowFrame.size.width = 360;
	[[self window] setFrame:windowFrame display:YES animate:YES];
	[[[self window] contentView] addSubview:view];
}
- (IBAction)toggleViewAction:(id)sender
{
	NSString *identifier = [(NSToolbarItem *)sender itemIdentifier];
	[self setContentViewWithIdentifier:identifier];
}
- (IBAction)changeColorAction:(id)sender
{
	NSColor *color = [_colorWell color];
	for (ZBViewController *controller in @[_nsColorController, _uiColorController, _cgColorController, _glColorController]) {
		[controller updateWithColor:color];
	}
}
- (IBAction)openHomepageURLAction:(id)sender
{
	NSURL *URL = [NSURL URLWithString:@"http://wiki.github.com/zonble/bunt"];
	[[NSWorkspace sharedWorkspace] openURL:URL];
}

@end

@implementation ZBMainWindowController (Toolbar)


- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	if ([itemIdentifier isEqualToString:colorWellIdentifier]) {
		NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
		[item setLabel:NSLocalizedString(itemIdentifier, @"")];
		[item setImage:nil];
		[item setView:_colorWell];
		[item setMaxSize:[_colorWell bounds].size];
		[item setMinSize:[_colorWell bounds].size];
		return item;
	}

	NSDictionary *map = @{nscolorIdentifier: @"NSColorItem",
						  uicolorIdentifier: @"UIColorItem",
						  cgcolorIdentifier: @"CGColorItem",
						  glcolorIdentifier: @"GLColorItem",
						  settingIdentifier: NSImageNameActionTemplate};

	if (![[map allKeys] containsObject:itemIdentifier]) {
		return nil;
	}

	NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
	[item setLabel:itemIdentifier];
	[item setTarget:self];
	[item setAction:@selector(toggleViewAction:)];
	[item setImage:[NSImage imageNamed:map[itemIdentifier]]];
	return item;
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar
{
	return @[colorWellIdentifier, NSToolbarSeparatorItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier, nscolorIdentifier, uicolorIdentifier, cgcolorIdentifier, glcolorIdentifier, settingIdentifier];
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar
{
	return @[colorWellIdentifier, NSToolbarSeparatorItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier, nscolorIdentifier, uicolorIdentifier, cgcolorIdentifier, glcolorIdentifier, settingIdentifier];
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar
{
	return @[nscolorIdentifier, uicolorIdentifier, cgcolorIdentifier, glcolorIdentifier, settingIdentifier];
}

@end

@implementation ZBMainWindowController (Window)

- (void)windowWillClose:(NSNotification *)notification
{
	[[NSColorPanel sharedColorPanel] orderOut:self];
}

@end
