//
//  ZBUIColorViewController.m
//  Bunt
//
//  Created by zonble on 2009/3/3.
//

#import "ZBUIColorViewController.h"


@implementation ZBUIColorViewController

- (void)loadNib
{
	[super loadNib];
	BOOL loaded = [NSBundle loadNibNamed:@"ZBUIColorViewController" owner:self];
	NSAssert((loaded == YES), @"NIB did not load");	
	[_classHSBView setTitle:@"HSB"];
	[_classRGBView setTitle:@"RGB"];
	[_instanceHSBView setTitle:@"HSB"];
	[_instanceRGBView setTitle:@"RGB"];	
}
- (void)updateWithColor:(NSColor *)color
{
	[super updateWithColor:color];
	
	NSColor *rgbColor = [color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	NSString *classHSBString = [NSString stringWithFormat:@"[UIColor colorWithHue:%1.2f saturation:%1.2f brightness:%1.2f alpha:%1.2f]", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
	NSString *classRGBString = [NSString stringWithFormat:@"[UIColor colorWithRed:%1.2f green:%1.2f blue:%1.2f alpha:%1.2f]",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
	NSString *instanceHSBString = [NSString stringWithFormat:@"[[UIColor alloc] initWithHue:%1.2f saturation:%1.2f brightness:%1.2f alpha:%1.2f]", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
	NSString *instanceRGBString = [NSString stringWithFormat:@"[[UIColor alloc] initWithRed:%1.2f green:%1.2f blue:%1.2f alpha:%1.2f]",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
	
	[_classHSBView setText:classHSBString];
	[_classRGBView setText:classRGBString];	
	[_instanceHSBView setText:instanceHSBString];
	[_instanceRGBView setText:instanceRGBString];
}


@end
