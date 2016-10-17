//
//  SLAppDelegate.h
//  SheetLab
//
//  Created by Peter Clark on 1/19/13.
//  Copyright (c) 2013 myself. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SLAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)openDocument:(id)sender;

@end
