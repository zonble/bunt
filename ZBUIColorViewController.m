//
//  ZBUIColorViewController.m
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import "ZBUIColorViewController.h"


@implementation ZBUIColorViewController

- (void)loadNib
{
	[super loadNib];
	BOOL loaded = [NSBundle loadNibNamed:@"ZBUIColorViewController" owner:self];
	NSAssert((loaded == YES), @"NIB did not load");	
}


@end
