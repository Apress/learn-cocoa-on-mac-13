//
//  WLNotSoEasyWindowController.m
//  WindowLab
//
//  Created by Peter Clark on 1/12/13.
//  Copyright (c) 2013 myself. All rights reserved.
//

#import "WLNotSoEasyWindowController.h"

@interface WLNotSoEasyWindowController ()

@end

@implementation WLNotSoEasyWindowController

- init {
    if ((self = [super initWithWindowNibName:@"WLNotSoEasyWindowController"])) {
        [self window];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)beep:(id)sender
{
    NSBeep();
}

@end
