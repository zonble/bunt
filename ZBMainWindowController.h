//
//  ZBMainWindowController.h
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZBNSColorViewController.h"
#import "ZBUIColorViewController.h"
#import "ZBCGColorViewController.h"
#import "ZBGLColorViewController.h"

#define buntLastUsedToolbarItem @"buntLastUsedToolbarItem"

@interface ZBMainWindowController : NSWindowController 
{
	IBOutlet NSColorWell *_colorWell;
	IBOutlet NSMenu *_statusMenu;
	
	ZBNSColorViewController *_nsColorController;
	ZBUIColorViewController *_uiColorController;
	ZBCGColorViewController *_cgColorController;
	ZBGLColorViewController *_glColorController;
	
	NSStatusItem *_statusBarItem;
}

- (NSColor *)currentColor;
- (void)setContentViewWithIdentifier:(NSString *)identifier;
- (void)setContentViewWithView:(NSView *)view;

- (IBAction)toggleViewAction:(id)sender;
- (IBAction)changeColorAction:(id)sender;
- (IBAction)openHomepageURLAction:(id)sender;

@end
