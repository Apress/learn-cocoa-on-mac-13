//
//  CEAppDelegate.m
//  CurveEdit
//
//  Created by Peter Clark on 2/24/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import "CEAppDelegate.h"

@implementation CEAppDelegate

@synthesize curveView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // make the CurveView notice my changes
    [curveView bind:@"cp1X" toObject:self withKeyPath:@"cp1X"
            options:nil];
    [curveView bind:@"cp1Y" toObject:self withKeyPath:@"cp1Y"
            options:nil];
    [curveView bind:@"cp2X" toObject:self withKeyPath:@"cp2X"
            options:nil];
    [curveView bind:@"cp2Y" toObject:self withKeyPath:@"cp2Y"
            options:nil];
    // make me notice the CurveView's changes
    [self bind:@"cp1X" toObject:curveView withKeyPath:@"cp1X"
       options:nil];
    [self bind:@"cp1Y" toObject:curveView withKeyPath:@"cp1Y"
       options:nil];
    [self bind:@"cp2X" toObject:curveView withKeyPath:@"cp2X"
       options:nil];
    [self bind:@"cp2Y" toObject:curveView withKeyPath:@"cp2Y"
       options:nil];
    // set initial values
    self.cp1X = 0.5;
    self.cp1Y = 0.0;
    self.cp2X = 0.5;
    self.cp2Y = 1.0;
}

@end
