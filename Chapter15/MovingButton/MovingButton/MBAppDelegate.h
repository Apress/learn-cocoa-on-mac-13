//
//  MBAppDelegate.h
//  MovingButton
//
//  Created by Peter Clark on 2/25/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
@class CECurveView;

@interface MBAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet CECurveView *curveView;

- (IBAction)move:(id)sender;

@end
