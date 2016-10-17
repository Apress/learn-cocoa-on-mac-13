//
//  ButtonsAppDelegate.h
//  Chapter4
//
//  Created by Peter Clark on 1/26/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ButtonsAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *label;
- (IBAction)buttonPressed:(id)sender;

@end
