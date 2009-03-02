//
//  ZBNSColorViewController.h
//  Bunt
//
//  Created by zonble on 2009/3/3.
//  Copyright 2009 Lithoglyph Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZBViewController.h"

@interface ZBNSColorViewController : ZBViewController 
{
	IBOutlet NSMatrix *_matrix;
	IBOutlet ZBSourceCodeView *_hsbView;
	IBOutlet ZBSourceCodeView *_rgbView;
	IBOutlet ZBSourceCodeView *_cmykView;	
}

@end
