//
//  ZBSourceCodeView.h
//  Bunt
//
//  Created by zonble on 2009/3/3.
//

#import <Cocoa/Cocoa.h>
#import "ZBSourceCodeTextField.h"

@interface ZBSourceCodeView : NSView 
{
	NSButton *_copyButton;
	NSTextField *_titleLabel;
	ZBSourceCodeTextField *_sourceCodeTextField;
}

- (IBAction)copyTextAction:(id)sender;
- (void)setTitle:(NSString *)title;
- (void)setText:(NSString *)text;
@end
