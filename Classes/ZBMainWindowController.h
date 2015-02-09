//
//  ZBMainWindowController.h
//  Bunt
//
//  Created by zonble on 2009/3/3.
//

#import <Cocoa/Cocoa.h>
#import "ZBNSColorViewController.h"
#import "ZBUIColorViewController.h"
#import "ZBCGColorViewController.h"
#import "ZBGLColorViewController.h"

#define buntLastUsedToolbarItem @"buntLastUsedToolbarItem"

/*!
    @header ZBMainWindowController
    @abstract   The main controller class of the Bunt application.
    @discussion The header file defines the ZBMainWindowController class,
				which is the main window controller of the Bunt application.
*/

/*!
    @class
    @abstract    ZBMainWindowController
    @discussion  The main controller class of the Bunt project.
*/

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

/*!
    @method     currentColor
    @abstract   The NSColor object of the color in the color well.
*/
- (NSColor *)currentColor;
/*!
    @method     setContentViewWithIdentifier:
    @abstract   Sets the content of the main window with a specific view
				by specifying an identifier.
*/
- (void)setContentViewWithIdentifier:(NSString *)identifier;
/*!
	@method     setContentViewWithView:
	@abstract   Sets the content of the main window with a specific view.
*/
- (void)setContentViewWithView:(NSView *)view;

- (IBAction)toggleViewAction:(id)sender;
- (IBAction)changeColorAction:(id)sender;
- (IBAction)openHomepageURLAction:(id)sender;


//@property (strong, nonatomic) ZBNSColorViewController *nsColorController;
//@property (strong, nonatomic) ZBUIColorViewController *uiColorController;
//@property (strong, nonatomic) ZBCGColorViewController *cgColorController;
//@property (strong, nonatomic) ZBGLColorViewController *glColorController;
@end
