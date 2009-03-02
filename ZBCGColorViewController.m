//
//  ZBCGColorViewController.m
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import "ZBCGColorViewController.h"


@implementation ZBCGColorViewController

- (void)loadNib
{
	[super loadNib];
	BOOL loaded = [NSBundle loadNibNamed:@"ZBCGColorViewController" owner:self];
	NSAssert((loaded == YES), @"NIB did not load");	
}


@end
