//
//  ZBViewController.h
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ZBViewController : NSObject 
{
	IBOutlet NSView *_view;
}

- (void)loadNib;
- (NSView *)view;

@end
