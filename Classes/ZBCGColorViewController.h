//
//  ZBCGColorViewController.h
//  Bunt
//
//  Created by zonble on 2009/3/3.
//

#import <Cocoa/Cocoa.h>
#import "ZBViewController.h"

@interface ZBCGColorViewController : ZBViewController
{
	IBOutlet ZBSourceCodeView *_colorCreateView;
	IBOutlet ZBSourceCodeView *_colorCreateGenericRGBView;	
	IBOutlet ZBSourceCodeView *_colorCreateGenericCMYKView;	
	IBOutlet NSMatrix *_matrix;
}

@end
