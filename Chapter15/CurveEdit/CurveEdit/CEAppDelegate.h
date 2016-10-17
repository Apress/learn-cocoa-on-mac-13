//
//  CEAppDelegate.h
//  CurveEdit
//
//  Created by Peter Clark on 2/24/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CECurveView.h"

@interface CEAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet CECurveView *curveView;

@property (assign) CGFloat cp1X;
@property (assign) CGFloat cp1Y;
@property (assign) CGFloat cp2X;
@property (assign) CGFloat cp2Y;

@end
