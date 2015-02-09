//
//	ZBGLColorViewController.m
//	Bunt
//
//	Created by zonble on 2009/3/3.
//

#import "ZBGLColorViewController.h"
#import "ZBSettingKeys.h"

@interface ZBGLColorViewController ()
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *glColor3fView;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *glColor3fvView;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *glColor4fView;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *glColor4fvView;
@end

@implementation ZBGLColorViewController

- (void)loadNib
{
	[super loadNib];
	BOOL loaded = [NSBundle loadNibNamed:@"ZBGLColorViewController" owner:self];
	NSAssert((loaded == YES), @"NIB did not load");
	[_glColor3fView setTitle:@"glColor3f"];
	[_glColor3fvView setTitle:@"glColor3fv"];
	[_glColor4fView setTitle:@"glColor4f"];
	[_glColor4fvView setTitle:@"glColor4fv"];
}
- (void)updateWithColor:(NSColor *)color
{
	[super updateWithColor:color];
	NSColor *rgbColor = [color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];

	BOOL isSwift = [[NSUserDefaults standardUserDefaults] integerForKey:buntPreferredLanguage];

	if (isSwift) {
		[_glColor3fView setText:[NSString stringWithFormat:@"glColor3f(%1.2f, %1.2f, %1.2f)", [rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent]]];
		[_glColor3fvView setText:[NSString stringWithFormat:@"var color :[GLfloat] = [%1.2f, %1.2f, %1.2f]\nglColor3fv(color)", [rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent]]];
		[_glColor4fView setText:[NSString stringWithFormat:@"glColor4f(%1.2f, %1.2f, %1.2f, %1.2f)", [rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]]];
		[_glColor4fvView setText:[NSString stringWithFormat:@"var color :[GLfloat] = [%1.2f, %1.2f, %1.2f, %1.2f]\nglColor4fv(color)", [rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]]];
	}
	else {
		[_glColor3fView setText:[NSString stringWithFormat:@"glColor3f(%1.2f, %1.2f, %1.2f);", [rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent]]];
		[_glColor3fvView setText:[NSString stringWithFormat:@"glFloat color[3] = {%1.2f, %1.2f, %1.2f};\nglColor3fv(color);", [rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent]]];
		[_glColor4fView setText:[NSString stringWithFormat:@"glColor4f(%1.2f, %1.2f, %1.2f, %1.2f);", [rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]]];
		[_glColor4fvView setText:[NSString stringWithFormat:@"glFloat color[4] = {%1.2f, %1.2f, %1.2f, %1.2f};\nglColor4fv(color);", [rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]]];
	}
}

@end
