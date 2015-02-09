//
//	ZBViewController.h
//	Bunt
//
//	Created by zonble on 2009/3/3.
//

#import <Cocoa/Cocoa.h>
#import "ZBSourceCodeView.h"

@interface ZBViewController : NSObject

- (void)loadNib;
- (void)updateWithColor:(NSColor *)color;

@property (strong, nonatomic) IBOutlet NSView *view;
@end
