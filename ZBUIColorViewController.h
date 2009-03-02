//
//  ZBUIColorViewController.h
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZBViewController.h"

@interface ZBUIColorViewController : ZBViewController 
{
	IBOutlet ZBSourceCodeView *_classHSBView;	
	IBOutlet ZBSourceCodeView *_classRGBView;
	IBOutlet ZBSourceCodeView *_instanceHSBView;	
	IBOutlet ZBSourceCodeView *_instanceRGBView;
}

@end
