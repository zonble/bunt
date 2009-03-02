//
//  ZBNSColorViewController.m
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import "ZBNSColorViewController.h"


@implementation ZBNSColorViewController

- (void)loadNib
{
	[super loadNib];
	BOOL loaded = [NSBundle loadNibNamed:@"ZBNSColorViewController" owner:self];
	NSAssert((loaded == YES), @"NIB did not load");	
}


@end
