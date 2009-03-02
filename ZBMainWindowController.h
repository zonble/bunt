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

@interface ZBMainWindowController : NSWindowController 
{
	IBOutlet NSColorWell *_colorWell;
	
	ZBNSColorViewController *_nsColorController;
	ZBUIColorViewController *_uiColorController;
	ZBCGColorViewController *_cgColorController;
	ZBGLColorViewController *_glColorController;
}

- (NSColor *)currentColor;
- (void)setContentViewWithView:(NSView *)view;
- (IBAction)toggleViewAction:(id)sender;

@end
