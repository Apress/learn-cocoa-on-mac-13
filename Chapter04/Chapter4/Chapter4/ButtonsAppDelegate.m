//
//  ButtonsAppDelegate.m
//  Chapter4
//
//  Created by Peter Clark on 1/26/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import "ButtonsAppDelegate.h"

@implementation ButtonsAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)buttonPressed:(id)sender {
    NSString *title = [sender title];
    NSString *labelText = [NSString stringWithFormat:@"%@ button pressed.", title];
    [self.label setStringValue:labelText];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}
@end
