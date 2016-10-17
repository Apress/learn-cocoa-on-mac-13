//
//  MLAppDelegate.h
//  MenuLab
//
//  Created by Peter Clark on 1/13/13.
//  Copyright (c) 2013 myself. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MLAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) BOOL turbo;

- (IBAction)toggleTurbo:(id)sender;

@end
