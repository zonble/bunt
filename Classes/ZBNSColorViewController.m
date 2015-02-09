//
//	ZBNSColorViewController.m
//	Bunt
//
//	Created by zonble on 2009/3/3.
//

#import "ZBNSColorViewController.h"
#import "ZBMainWindowController.h"
#import "ZBSettingKeys.h"

@interface ZBNSColorViewController ()
@property (weak, nonatomic) IBOutlet NSMatrix *matrix;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *hsbView;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *rgbView;
@property (weak, nonatomic) IBOutlet ZBSourceCodeView *cmykView;
@end

@implementation ZBNSColorViewController

- (void)loadNib
{
	[super loadNib];
	BOOL loaded = [[NSBundle mainBundle] loadNibNamed:@"ZBNSColorViewController" owner:self topLevelObjects:nil];
	NSAssert((loaded == YES), @"NIB did not load");

	[_hsbView setTitle:@"HSB"];
	[_rgbView setTitle:@"RGB"];
	[_cmykView setTitle:@"CMYK"];
}
- (void)updateWithColor:(NSColor *)color
{
	[super updateWithColor:color];
	NSInteger tag = [[_matrix selectedCell] tag];
	NSString *hsbString = nil;
	NSString *rgbString = nil;

	BOOL isSwift = [[NSUserDefaults standardUserDefaults] integerForKey:buntPreferredLanguage];

	if (isSwift) {
		if (tag) {
			// Use Calibrated RGB
			NSColor *rgbColor = [color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
			hsbString = [NSString stringWithFormat:@"NSColor(calibratedHue: %1.2f, saturation: %1.2f, brightness: %1.2f, alpha: %1.2f)", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
			rgbString = [NSString stringWithFormat:@"NSColor(calibratedRed: %1.2f, green: %1.2f, blue: %1.2f, alpha: %1.2f)",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
		}
		else {
			NSColor *rgbColor = [color colorUsingColorSpaceName:NSDeviceRGBColorSpace];
			hsbString = [NSString stringWithFormat:@"NSColor(deviceHue: %1.2f, saturation: %1.2f, brightness: %1.2f, alpha: %1.2f)", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
			rgbString = [NSString stringWithFormat:@"NSColor(deviceRed: %1.2f, green: %1.2f, blue: %1.2f, alpha: %1.2f)",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
		}
	}
	else {
		if (tag) {
			// Use Calibrated RGB
			NSColor *rgbColor = [color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
			hsbString = [NSString stringWithFormat:@"[NSColor colorWithCalibratedHue:%1.2f saturation:%1.2f brightness:%1.2f alpha:%1.2f]", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
			rgbString = [NSString stringWithFormat:@"[NSColor colorWithCalibratedRed:%1.2f green:%1.2f blue:%1.2f alpha:%1.2f]",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
		}
		else {
			NSColor *rgbColor = [color colorUsingColorSpaceName:NSDeviceRGBColorSpace];
			hsbString = [NSString stringWithFormat:@"[NSColor colorWithDeviceHue:%1.2f saturation:%1.2f brightness:%1.2f alpha:%1.2f]", [rgbColor hueComponent], [rgbColor saturationComponent], [rgbColor brightnessComponent], [rgbColor alphaComponent]];
			rgbString = [NSString stringWithFormat:@"[NSColor colorWithDeviceRed:%1.2f green:%1.2f blue:%1.2f alpha:%1.2f]",[rgbColor redComponent], [rgbColor greenComponent], [rgbColor blueComponent], [rgbColor alphaComponent]];
		}
	}


	[_hsbView setText:hsbString];
	[_rgbView setText:rgbString];

	NSColor *cmykColor = [color colorUsingColorSpaceName:NSDeviceCMYKColorSpace];
	NSString *cmykString = nil;
	if (isSwift) {
		cmykString = [NSString stringWithFormat:@"NSColor(deviceCyan: %1.2f, magenta: %1.2f, yellow: %1.2f, black: %1.2f, alpha: %1.2f)", [cmykColor cyanComponent], [cmykColor magentaComponent], [cmykColor yellowComponent], [cmykColor blackComponent], [cmykColor alphaComponent]];
	}
	else {
		cmykString = [NSString stringWithFormat:@"[NSColor colorWithDeviceCyan:%1.2f magenta:%1.2f yellow:%1.2f black:%1.2f alpha:%1.2f]", [cmykColor cyanComponent], [cmykColor magentaComponent], [cmykColor yellowComponent], [cmykColor blackComponent], [cmykColor alphaComponent]];
	}
	[_cmykView setText:cmykString];
}

- (IBAction)changeSettingAction:(id)sender
{
	ZBMainWindowController *controller = (ZBMainWindowController *)[[NSApplication sharedApplication] delegate];
	NSColor *color = [controller currentColor];
	[self updateWithColor:color];
}

@end
