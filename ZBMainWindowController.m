//
//  ZBMainWindowController.m
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import "ZBMainWindowController.h"

static NSString *colorWellIdentifier = @"Color Well";
static NSString *nscolorIdentifier = @"NSColor";
static NSString *uicolorIdentifier = @"UIColor";
static NSString *cgcolorIdentifier = @"CGColor";
static NSString *glcolorIdentifier = @"GLColor";

@implementation ZBMainWindowController

- (void)dealloc
{
	[_nsColorController release];
	[_uiColorController release];
	[_cgColorController release];
	[_glColorController release];
	[_statusBarItem release];
	[super dealloc];
}

- (void)awakeFromNib
{
	NSLog(@"awakeFromNib");
	
	_nsColorController = [[ZBNSColorViewController alloc] init];
	_uiColorController = [[ZBUIColorViewController alloc] init];
	_cgColorController = [[ZBCGColorViewController alloc] init];
	_glColorController = [[ZBGLColorViewController alloc] init];
	
	NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"toolbar"];
	[toolbar autorelease];
	[toolbar setDelegate:self];
	[toolbar setVisible:YES];
	[toolbar setSizeMode:NSToolbarSizeModeRegular];
	[toolbar setAllowsUserCustomization:NO];
	[toolbar setAutosavesConfiguration:NO];
	[[self window] setToolbar:toolbar];
	
	NSStatusBar *bar = [NSStatusBar systemStatusBar];
	
    _statusBarItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    [_statusBarItem retain];
	
	[_statusBarItem setTitle: NSLocalizedString(@"Bunt",@"")];
    [_statusBarItem setHighlightMode:YES];
    [_statusBarItem setMenu:_statusMenu];
	
	NSString *lastUsedToolbarItem = [[NSUserDefaults standardUserDefaults] objectForKey:buntLastUsedToolbarItem];
	if (!lastUsedToolbarItem || ![lastUsedToolbarItem length]) {
		lastUsedToolbarItem = nscolorIdentifier;
	}
	
	[toolbar setSelectedItemIdentifier:lastUsedToolbarItem];
	[self setContentViewWithIdentifier:lastUsedToolbarItem];
	[self changeColorAction:_colorWell];
	
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
	NSView *view = nil;
	if ([identifier isEqualToString:nscolorIdentifier]) {
		view = [_nsColorController view];
	}
	else if ([identifier isEqualToString:uicolorIdentifier]) {
		view = [_uiColorController view];
	}
	else if ([identifier isEqualToString:cgcolorIdentifier]) {
		view = [_cgColorController view];
	}
	else if ([identifier isEqualToString:glcolorIdentifier]) {
		view = [_glColorController view];
	}
	
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
	windowFrame.size.width = [view bounds].size.width;
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
	NSColor *color = [(NSColorWell *)sender color];
	[_nsColorController updateWithColor:color];
	[_uiColorController updateWithColor:color];
	[_cgColorController updateWithColor:color];
	[_glColorController updateWithColor:color];
}
- (IBAction)openHomepageURLAction:(id)sender
{
	NSURL *URL = [NSURL URLWithString:@"http://wiki.github.com/zonble/bunt"];
	[[NSWorkspace sharedWorkspace] openURL:URL];
}

#pragma mark -
#pragma mark NSWindow Delegate Methods.
- (void)windowWillClose:(NSNotification *)notification
{
	[[NSColorPanel sharedColorPanel] orderOut:self];
}

#pragma mark NSToolbar Delegate Methods.

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	if ([itemIdentifier isEqualToString:colorWellIdentifier]) {
		NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
		[item autorelease];
		[item setLabel:itemIdentifier];
		[item setImage:nil];
		[item setView:_colorWell];
		[item setMaxSize:[_colorWell bounds].size];
		[item setMinSize:[_colorWell bounds].size];
		return item;
	}	
	else if ([itemIdentifier isEqualToString:nscolorIdentifier]) {
		NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
		[item autorelease];
		[item setLabel:itemIdentifier];
		[item setImage:nil];
		[item setTarget:self];
		[item setAction:@selector(toggleViewAction:)];
		[item setImage:[NSImage imageNamed:@"NSColorItem"]];
		return item;
	}
	else if ([itemIdentifier isEqualToString:uicolorIdentifier]) {
		NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
		[item autorelease];
		[item setLabel:itemIdentifier];
		[item setImage:nil];
		[item setTarget:self];
		[item setAction:@selector(toggleViewAction:)];
		[item setImage:[NSImage imageNamed:@"UIColorItem"]];
		return item;
	}
	else if ([itemIdentifier isEqualToString:cgcolorIdentifier]) {
		NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
		[item autorelease];
		[item setLabel:itemIdentifier];
		[item setImage:nil];
		[item setTarget:self];
		[item setAction:@selector(toggleViewAction:)];
		[item setImage:[NSImage imageNamed:@"CGColorItem"]];
		return item;
	}
	else if ([itemIdentifier isEqualToString:glcolorIdentifier]) {
		NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
		[item autorelease];
		[item setLabel:itemIdentifier];
		[item setImage:nil];
		[item setTarget:self];
		[item setAction:@selector(toggleViewAction:)];
		[item setImage:[NSImage imageNamed:@"GLColorItem"]];
		return item;
	}
	
	return nil;	
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar
{
	return [NSArray arrayWithObjects:colorWellIdentifier, NSToolbarSeparatorItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier, nscolorIdentifier, uicolorIdentifier, cgcolorIdentifier, glcolorIdentifier, nil];
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar
{
	return [NSArray arrayWithObjects:colorWellIdentifier, NSToolbarSeparatorItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier, nscolorIdentifier, uicolorIdentifier, cgcolorIdentifier, glcolorIdentifier, nil];	
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar
{
	return [NSArray arrayWithObjects:nscolorIdentifier, uicolorIdentifier, cgcolorIdentifier, glcolorIdentifier, nil];
}

@end
