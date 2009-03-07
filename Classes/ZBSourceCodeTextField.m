//
//  ZBSourceCodeTextField.m
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import "ZBSourceCodeTextField.h"


@implementation ZBSourceCodeTextField

- (NSImage *)textImage
{
	NSAttributedString *a = [self attributedStringValue];
	
	NSRect myRect = [self frame];
	NSRect imgRect = [a boundingRectWithSize:NSMakeSize(myRect.size.width + 20, 1600) options:NSStringDrawingUsesLineFragmentOrigin];
	imgRect.size.width = myRect.size.width;
	NSImage *image = [[[NSImage alloc] initWithSize:imgRect.size] autorelease];
	[image lockFocus];
	NSRect rect = NSMakeRect(0, 0, [image size].width, [image size].height);
	[a drawInRect:rect];
	[image unlockFocus];	
	return image;
}

- (void)mouseDragged:(NSEvent *)theEvent
{
	[super mouseDragged:theEvent];
//	NSLog(@"mouseDragged");
}
- (void)mouseUp:(NSEvent *)theEvent
{
	[super mouseDown:theEvent];	
	[super mouseUp:theEvent];
//	NSLog(@"mouseUp");	
}
- (void)mouseDown:(NSEvent *)theEvent
{
	NSImage *image = [self textImage];
	NSPoint p = NSMakePoint(0, [image size].height);
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
	NSArray *types = [NSArray arrayWithObjects: NSStringPboardType, nil];
	NSSize offset = NSMakeSize(0, 0);
	[pasteboard declareTypes:types owner:self];	
	[pasteboard setString:[self stringValue] forType:NSStringPboardType];
	NSAttributedString *attrString = [self attributedStringValue];
	NSRange wholeStringRange = NSMakeRange(0, [attrString length]);
	NSData *rtfdData = [attrString RTFDFromRange:wholeStringRange documentAttributes:nil];
	[pasteboard setData:rtfdData forType:NSRTFDPboardType];
	
	
	[self dragImage:image at:p offset:offset event:theEvent pasteboard:pasteboard source:self slideBack:YES];
}

@end
