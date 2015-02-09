//
//	ZBCGColorViewController.m
//	Bunt
//
//	Created by zonble on 2009/3/3.
//

#import "ZBCGColorViewController.h"
#import "ZBSettingKeys.h"

@interface ZBCGColorViewController ()
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *colorCreateView;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *colorCreateGenericRGBView;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *colorCreateGenericCMYKView;
@property (weak, nonatomic) IBOutlet NSMatrix *matrix;
@end

@implementation ZBCGColorViewController

- (void)loadNib
{
	[super loadNib];
	BOOL loaded = [NSBundle loadNibNamed:@"ZBCGColorViewController" owner:self];
	NSAssert((loaded == YES), @"NIB did not load");
	[_colorCreateView setTitle:@"CGColorCreate"];
	[_colorCreateGenericRGBView setTitle:@"CGColorCreateGenericRGB"];
	[_colorCreateGenericCMYKView setTitle:@"CGColorCreateGenericCMYK"];
}
- (void)updateWithColor:(NSColor *)color
{
	[super updateWithColor:color];

	NSString *createColorString = nil;
	NSColor *rgbColor = nil;
	NSColor *cmykColor = [color colorUsingColorSpaceName:NSDeviceCMYKColorSpace];

	BOOL isSwift = [[NSUserDefaults standardUserDefaults] integerForKey:buntPreferredLanguage];

	if ([[_matrix selectedCell] tag]) {
		rgbColor = [color colorUsingColorSpaceName:NSDeviceRGBColorSpace];
		if (isSwift) {
			createColorString = [NSString stringWithFormat:@"var colorSpace = CGColorSpaceCreateDeviceRGB()\nvar components :[CGFloat] = [%1.2f, %1.2f, %1.2f, %1.2f]\nvar color = CGColorCreate(colorSpace, &components)",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];;
		}
		else {
			createColorString = [NSString stringWithFormat:@"CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();\nconst CGFloat components[4] = {%1.2f, %1.2f, %1.2f, %1.2f};\nCGColorRef color = CGColorCreate(colorSpace, components);\nCGColorRelease(color);",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
		}
	}
	else {
		if (isSwift) {
			createColorString = [NSString stringWithFormat:@"var colorSpace = CGColorSpaceCreateDeviceCMYK()\nvar components :[CGFloat] = [%1.2f, %1.2f, %1.2f, %1.2f, %1.2f]\nvar color = CGColorCreate(colorSpace, &components)", [cmykColor cyanComponent], [cmykColor magentaComponent], [cmykColor yellowComponent], [cmykColor blackComponent], [cmykColor alphaComponent]];
		}
		else {
			createColorString = [NSString stringWithFormat:@"CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceCMYK();\nconst CGFloat components[5] = {%1.2f, %1.2f, %1.2f, %1.2f, %1.2f};\nCGColorRef color = CGColorCreate(colorSpace, components);\nCGColorRelease(color);", [cmykColor cyanComponent], [cmykColor magentaComponent], [cmykColor yellowComponent], [cmykColor blackComponent], [cmykColor alphaComponent]];
		}
	}
	[_colorCreateView setText:createColorString];

	rgbColor = [color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	NSString *cgrgbString = [NSString stringWithFormat:@"CGColorRef color =CGColorCreateGenericRGB(%1.2f, %1.2f, %1.2f, %1.2f);\nCGColorRelease(color);",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
	[_colorCreateGenericRGBView setText:cgrgbString];
	NSString *cgcmykString = [NSString stringWithFormat:@"CGColorRef color =CGColorCreateGenericCMYK(%1.2f, %1.2f, %1.2f, %1.2f, %1.2f);\nCGColorRelease(color);", [cmykColor cyanComponent], [cmykColor magentaComponent], [cmykColor yellowComponent], [cmykColor blackComponent], [cmykColor alphaComponent]];
	[_colorCreateGenericCMYKView setText:cgcmykString];
}


@end
