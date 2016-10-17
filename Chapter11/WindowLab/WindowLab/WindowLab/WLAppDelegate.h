//
//  WLAppDelegate.h
//  WindowLab
//
//  Created by Peter Clark on 1/11/13.
//  Copyright (c) 2013 myself. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WLAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *title;
@property (strong) NSMutableArray *subWindows;

- (IBAction)showColorPanel:(id)sender;
- (IBAction)showFontPanel:(id)sender;
- (IBAction)loadEasyWindow:(id)sender;
- (IBAction)loadNotSoEasyWindow:(id)sender;
- (IBAction)runModalAlerts:(id)sender;
- (IBAction)copyFile:(id)sender;

@end
