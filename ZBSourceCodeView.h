//
//  ZBSourceCodeView.h
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZBSourceCodeView : NSView 
{
	NSButton *_copyButton;
	NSTextField *_titleLabel;
	NSTextField *_sourceCodeTextField;
}

- (IBAction)copyTextAction:(id)sender;
- (void)setTitle:(NSString *)title;
- (void)setText:(NSString *)text;
@end
