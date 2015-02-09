//
//	ZBSourceCodeView.m
//	Bunt
//
//	Created by zonble on 2009/3/3.
//

#import "ZBSourceCodeView.h"

@interface ZBSourceCodeView ()
@property (strong, nonatomic) NSButton *doCopyButton;
@property (strong, nonatomic) NSTextField *titleLabel;
@property (strong, nonatomic) ZBSourceCodeTextField *sourceCodeTextField;
@end

@implementation ZBSourceCodeView

- (void)_init
{
	[self setAutoresizingMask: NSViewWidthSizable];
	_doCopyButton = [[NSButton alloc] initWithFrame:NSMakeRect(NSMaxX([self bounds]) - 70, NSMaxY([self bounds]) - 20, 70, 19)];
	[_doCopyButton setButtonType:NSMomentaryLightButton];
	[_doCopyButton setBezelStyle:NSRoundRectBezelStyle];
	[_doCopyButton setAutoresizingMask:NSViewMinXMargin];
	[_doCopyButton setFont:[NSFont systemFontOfSize:[NSFont labelFontSize]]];
	[_doCopyButton setTitle:NSLocalizedString(@"Copy", @"")];
	[_doCopyButton setTarget:self];
	[_doCopyButton setAction:@selector(copyTextAction:)];
	[self addSubview:_doCopyButton];

	_titleLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(NSMinX([self bounds]), NSMaxY([self bounds]) - 19, [self bounds].size.width - 100, 19)];
	[_titleLabel setFont:[NSFont systemFontOfSize:[NSFont systemFontSize]]];
	[_titleLabel setBackgroundColor:[NSColor controlColor]];
	[_titleLabel setEditable:NO];
	[_titleLabel setBezeled:NO];
	[_titleLabel setBordered:NO];
	[self addSubview:_titleLabel];

	_sourceCodeTextField = [[ZBSourceCodeTextField alloc] initWithFrame:NSMakeRect(NSMinX([self bounds]), NSMinY([self bounds]), [self bounds].size.width, [self bounds].size.height - 24)];
	[_sourceCodeTextField setEditable:NO];
	[_sourceCodeTextField setSelectable:YES];
	[_sourceCodeTextField setFocusRingType:NSFocusRingTypeNone];
	[_sourceCodeTextField setFont:[NSFont systemFontOfSize:10.0]];
	[_sourceCodeTextField setAutoresizingMask: NSViewWidthSizable | NSViewHeightSizable];
	[self addSubview:_sourceCodeTextField];
}

- (instancetype)initWithCoder:aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self _init];
	}
	return self;
}

- (instancetype)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self _init];
	}
	return self;
}

- (void)setTitle:(NSString *)title
{
	[_titleLabel setStringValue:title];
}

- (void)setText:(NSString *)text
{
	[_sourceCodeTextField setStringValue:text];
}

- (IBAction)copyTextAction:(id)sender
{
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
	NSArray *types = @[NSStringPboardType, NSRTFPboardType];
	[pasteboard declareTypes:types owner:self];
	[pasteboard setString:[_sourceCodeTextField stringValue] forType:NSStringPboardType];
	NSAttributedString *attrString = [_sourceCodeTextField attributedStringValue];
	NSRange wholeStringRange = NSMakeRange(0, [attrString length]);
	NSData *rtfdData = [attrString RTFDFromRange:wholeStringRange documentAttributes:nil];
	[pasteboard setData:rtfdData forType:NSRTFDPboardType];
}

@end
