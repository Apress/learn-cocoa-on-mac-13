//
//  SWAppDelegate.h
//  SlowWorker
//
//  Created by Jack on 1/22/13.
//  Copyright (c) 2013 Rebisoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SWAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *startButton;
@property (assign) IBOutlet NSTextView *resultsTextView;
@property (assign) BOOL isWorking;

- (IBAction)doWork:(id)sender;

@end
