//
//  ZBViewController.m
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import "ZBViewController.h"


@implementation ZBViewController

- (id)init
{
	self = [super init];
	if (self != nil) {
		[self loadNib];
	}
	return self;
}
- (void)loadNib
{
	
}
- (NSView *)view
{
	return _view;
}

@end
