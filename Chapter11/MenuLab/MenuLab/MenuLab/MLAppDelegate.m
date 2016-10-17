//
//  MLAppDelegate.m
//  MenuLab
//
//  Created by Peter Clark on 1/13/13.
//  Copyright (c) 2013 myself. All rights reserved.
//

#import "MLAppDelegate.h"

@implementation MLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)toggleTurbo:(id)sender {
    self.turbo = !self.turbo;
}

@end
