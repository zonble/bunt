//
//  ZBGLColorViewController.h
//  Bunt
//
//  Created by zonble on 2009/3/3.
//

#import <Cocoa/Cocoa.h>
#import "ZBViewController.h"

@interface ZBGLColorViewController : ZBViewController 
{
	IBOutlet ZBSourceCodeView *_glColor3fView;
	IBOutlet ZBSourceCodeView *_glColor3fvView;	
	IBOutlet ZBSourceCodeView *_glColor4fView;
	IBOutlet ZBSourceCodeView *_glColor4fvView;		
}

@end
