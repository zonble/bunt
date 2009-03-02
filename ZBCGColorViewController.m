//
//  ZBCGColorViewController.m
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import "ZBCGColorViewController.h"


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
	
	if ([[_matrix selectedCell] tag]) {
		NSColor *rgbColor = [color colorUsingColorSpaceName:NSDeviceRGBColorSpace];		
		createColorString = [NSString stringWithFormat:@"CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();\nconst CGFloat components[4] = {%1.2f, %1.2f, %1.2f, %1.2f};\nCGColorRef color = CGColorCreate(colorSpace, components);\nCGColorRelease(color);",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
	}
	else {
		NSColor *cmykColor = [color colorUsingColorSpaceName:NSDeviceCMYKColorSpace];
		createColorString = [NSString stringWithFormat:@"CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceCMYK();\nconst CGFloat components[5] = {%1.2f, %1.2f, %1.2f, %1.2f, %1.2f};\nCGColorRef color = CGColorCreate(colorSpace, components);\nCGColorRelease(color);", [cmykColor cyanComponent], [cmykColor magentaComponent], [cmykColor yellowComponent], [cmykColor blackComponent], [cmykColor alphaComponent]];		
	}
	[_colorCreateView setText:createColorString];
	
	

	
//	hsbString = [NSString stringWithFormat:@"[NSColor colorWithDeviceHue:%1.2f saturation:%1.2f brightness:%1.2f alpha:%1.2f]", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
//	rgbString = [NSString stringWithFormat:@"[NSColor colorWithDeviceRed:%1.2f green:%1.2f blue:%1.2f alpha:%1.2f]",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
//
//	
//	NSColor *cmykColor = [color colorUsingColorSpaceName:NSDeviceCMYKColorSpace];
}


@end
