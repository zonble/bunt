//
//	ZBViewController.h
//	Bunt
//
//	Created by zonble on 2009/3/3.
//

#import <Cocoa/Cocoa.h>
#import "ZBSourceCodeView.h"

@interface ZBViewController : NSObject
{
	IBOutlet NSView *_view;
}

- (void)loadNib;
- (void)updateWithColor:(NSColor *)color;
- (NSView *)view;

@end
