//
//  LOLAppDelegate.h
//  LOLMaker
//
//  Created by Peter Clark on 2/9/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LOLView.h"

@interface LOLAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet LOLView *lolView;
@property (strong) NSImage *image;
@property (copy) NSString *text;

@end
