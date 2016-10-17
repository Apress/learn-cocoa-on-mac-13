//
//  SLAppDelegate.m
//  SheetLab
//
//  Created by Peter Clark on 1/19/13.
//  Copyright (c) 2013 myself. All rights reserved.
//

#import "SLAppDelegate.h"

@implementation SLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)openDocument:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO];
    [panel setMessage:@"Please pick one file to import."];
    
    // Display the panel attached to the document's window.
    [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSArray* urls = [panel URLs];
            NSString *selectedFile = [[urls lastObject] lastPathComponent];
            // Set the window title to the filename of the selected file.
            [self.window setTitle:selectedFile];
        }
    }];
}

@end
