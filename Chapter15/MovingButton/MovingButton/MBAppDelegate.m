//
//  MBAppDelegate.m
//  MovingButton
//
//  Created by Peter Clark on 2/25/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import "MBAppDelegate.h"
#import "CECurveView.h"

@implementation MBAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)move:(id)sender
{
    NSRect senderFrame = [sender frame];
    NSRect superBounds = [[sender superview] bounds];
    CABasicAnimation *a = [CABasicAnimation
                           animationWithKeyPath:@"position"];
    a.fromValue = [NSValue valueWithPoint:senderFrame.origin];
    senderFrame.origin.x = (superBounds.size.width -
                            senderFrame.size.width)*drand48();
    senderFrame.origin.y = (superBounds.size.height -
                            senderFrame.size.height)*drand48();
    
    // configure the animation
    a.toValue = [NSValue valueWithPoint:senderFrame.origin];
    a.duration = 3.0;
    
    // first timing function:
    //a.timingFunction = [CAMediaTimingFunction functionWithName:
    //                    kCAMediaTimingFunctionEaseInEaseOut];

    // spiffier timing function:
    a.timingFunction = [CAMediaTimingFunction
                        functionWithControlPoints:self.curveView.cp1X
                        :self.curveView.cp1Y
                        :self.curveView.cp2X
                        :self.curveView.cp2Y];
    
    NSLog(@"cp1:(%f, %f)   cp2:(%f, %f)", self.curveView.cp1X, self.curveView.cp1Y, self.curveView.cp2X, self.curveView.cp2Y);
    
    // add it to the layer
    [[sender layer] addAnimation:a forKey:@"position"];

    // [[sender animator] setFrame:senderFrame];
    [sender setFrame:senderFrame];
}

@end
