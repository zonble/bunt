//
//  ZBSourceCodeView.m
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import "ZBSourceCodeView.h"


@implementation ZBSourceCodeView

- (void) dealloc
{
	[_copyButton release];
	[_titleLabel release];
	[_sourceCodeTextField release];
	[super dealloc];
}

- (void)_init
{
	[self setAutoresizingMask: NSViewWidthSizable];
	_copyButton = [[NSButton alloc] initWithFrame:NSMakeRect(NSMaxX([self bounds]) - 70, NSMaxY([self bounds]) - 20, 70, 19)];
	[_copyButton setButtonType:NSMomentaryLightButton];
	[_copyButton setBezelStyle:NSRoundRectBezelStyle];
	[_copyButton setAutoresizingMask:NSViewMinXMargin];
	[_copyButton setFont:[NSFont systemFontOfSize:[NSFont labelFontSize]]];
	[_copyButton setTitle:@"Copy"];
	[_copyButton setTarget:self];
	[_copyButton setAction:@selector(copyTextAction:)];
	[self addSubview:_copyButton];
	
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
- (id)initWithCoder:aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
		[self _init];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame 
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
	NSArray *types = [NSArray arrayWithObjects: NSStringPboardType, NSRTFPboardType, nil];
	[pasteboard declareTypes:types owner:self];
	[pasteboard setString:[_sourceCodeTextField stringValue] forType:NSStringPboardType];
	NSAttributedString *attrString = [_sourceCodeTextField attributedStringValue];
	NSRange wholeStringRange = NSMakeRange(0, [attrString length]);
	NSData *rtfdData = [attrString RTFDFromRange:wholeStringRange documentAttributes:nil];
	[pasteboard setData:rtfdData forType:NSRTFDPboardType];
}
@end
