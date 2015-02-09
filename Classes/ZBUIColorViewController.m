//
//	ZBUIColorViewController.m
//	Bunt
//
//	Created by zonble on 2009/3/3.
//

#import "ZBUIColorViewController.h"
#import "ZBSettingKeys.h"

@interface ZBUIColorViewController()
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *classHSBView;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *classRGBView;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *instanceHSBView;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *instanceRGBView;
@end

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
	NSString *classHSBString = nil;
	NSString *classRGBString = nil;
	NSString *instanceHSBString = nil;
	NSString *instanceRGBString = nil;

	BOOL isSwift = [[NSUserDefaults standardUserDefaults] integerForKey:buntPreferredLanguage];

	if (isSwift) {
		classHSBString = [NSString stringWithFormat:@"UIColor(hue: %1.2f, saturation: %1.2f, brightness: %1.2f, alpha: %1.2f)", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
		classRGBString = [NSString stringWithFormat:@"UIColor(red: %1.2f, green: %1.2f, blue: %1.2f, alpha: %1.2f)",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
		instanceHSBString = [NSString stringWithFormat:@"UIColor(hue: %1.2f, saturation: %1.2f, brightness: %1.2f, alpha: %1.2f)", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
		instanceRGBString = [NSString stringWithFormat:@"UIColor(red: %1.2f, green: %1.2f, blue: %1.2f, alpha: %1.2f)",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
	}
	else {
		classHSBString = [NSString stringWithFormat:@"[UIColor colorWithHue:%1.2f saturation:%1.2f brightness:%1.2f alpha:%1.2f]", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
		classRGBString = [NSString stringWithFormat:@"[UIColor colorWithRed:%1.2f green:%1.2f blue:%1.2f alpha:%1.2f]",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
		instanceHSBString = [NSString stringWithFormat:@"[[UIColor alloc] initWithHue:%1.2f saturation:%1.2f brightness:%1.2f alpha:%1.2f]", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
		instanceRGBString = [NSString stringWithFormat:@"[[UIColor alloc] initWithRed:%1.2f green:%1.2f blue:%1.2f alpha:%1.2f]",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
	}

	[_classHSBView setText:classHSBString];
	[_classRGBView setText:classRGBString];
	[_instanceHSBView setText:instanceHSBString];
	[_instanceRGBView setText:instanceRGBString];
}

@end
