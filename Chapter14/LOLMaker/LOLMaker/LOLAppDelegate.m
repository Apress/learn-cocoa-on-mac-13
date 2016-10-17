//
//  LOLAppDelegate.m
//  LOLMaker
//
//  Created by Peter Clark on 2/9/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import "LOLAppDelegate.h"

@implementation LOLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.lolView bind:@"image" toObject:self withKeyPath:@"image"
          options:nil];
    [self.lolView bind:@"text" toObject:self withKeyPath:@"text"
          options:nil];
}


@end
