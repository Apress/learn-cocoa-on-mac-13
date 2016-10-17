//
//  FIAppDelegate.h
//  FlipIt
//
//  Created by Peter Clark on 2/27/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FIAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSBox *box;
@property (weak) IBOutlet NSTabView *tabView;

@property (weak) NSView *leftView;
@property (weak) NSView *rightView;
@property (weak) NSView *middleView;
@property (strong) NSArray *items;

@property NSInteger currentTabIndex;

- (IBAction)previous:(id)sender;
- (IBAction)next:(id)sender;

@end
