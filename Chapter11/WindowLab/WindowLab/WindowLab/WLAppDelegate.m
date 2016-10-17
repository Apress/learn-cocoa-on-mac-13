//
//  WLAppDelegate.m
//  WindowLab
//
//  Created by Peter Clark on 1/11/13.
//  Copyright (c) 2013 myself. All rights reserved.
//

#import "WLAppDelegate.h"
#import "WLNotSoEasyWindowController.h"

@implementation WLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.subWindows = [[NSMutableArray alloc] init];
}

- (IBAction)showColorPanel:(id)sender {
    // create the color panel
    NSColorPanel *panel = [NSColorPanel sharedColorPanel];
    // bring the color panel to the front of the screen
    [panel orderFront:nil];
}

- (IBAction)showFontPanel:(id)sender {
    NSFontPanel *panel = [NSFontPanel sharedFontPanel];
    NSFontManager *manager = [NSFontManager sharedFontManager];
    [manager setSelectedFont:[self.title font] isMultiple:NO];
    [panel orderFront:nil];
}

- (IBAction)loadEasyWindow:(id)sender {
    NSWindowController *easyController = [[NSWindowController alloc]
                                    initWithWindowNibName:@"EasyWindow"];
    
    // need to hold onto a reference to this object.
    [self.subWindows addObject:easyController];
    [easyController window]; // trigger the loading of the nib file
    [easyController showWindow:self];
}

- (IBAction)loadNotSoEasyWindow:(id)sender {
    WLNotSoEasyWindowController *notSoEasyController = [[WLNotSoEasyWindowController alloc] init];
    [self.subWindows addObject:notSoEasyController];
}

- (IBAction)runModalAlerts:(id)sender {
    NSRunCriticalAlertPanel(@"Basic Usage", @"This is a plain alert panel.", nil, nil, nil);
    NSRunAlertPanel(@"Three Buttons", @"We can set button titles:",
                    @"Really?", @"Oh, how delightful!", @"Whatever.");
    NSRunAlertPanel(@"Formatting Strings", @"We can also do some formatting, %@ %@",
                    nil, nil, nil, @"putting values for insertion at the end,", @"after the three button values.");
    switch (NSRunAlertPanel(@"Noticing The Selection",
                            @"And of course, we can detect which button is clicked.",
                            @"Default", @"Alternate", @"Other")) {
        case NSAlertDefaultReturn:
            NSRunInformationalAlertPanel(@"Result:", @"You pressed the default button",
                                         nil, nil, nil);
            break;
        case NSAlertAlternateReturn:
            NSRunInformationalAlertPanel(@"Result:", @"You pressed the alternate button",
                                         nil, nil, nil);
            break;
        case NSAlertOtherReturn:
            NSRunInformationalAlertPanel(@"Result:", @"You pressed the other button", 
                                         nil, nil, nil);
            break;
        default:
            break;
    } 
}

- (IBAction)copyFile:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setTitle:@"Select file to copy:"];
    
    if ([openPanel runModal] == NSOKButton) {
        // get the first (and only) selected filename
        NSURL *openPath = [[openPanel URLs] objectAtIndex:0];
        // pull out just the filename, without directory path
        NSString *openFilename = [openPath lastPathComponent];
        
        NSSavePanel *savePanel = [NSSavePanel savePanel];
        
        [savePanel setTitle:@"Enter destination filename:"];
        [savePanel setNameFieldStringValue:openFilename];
        
        // run the save panel in its default directory, with the opened filename
        // as a suggestion.
        if ([savePanel runModal] == NSOKButton) {
            NSURL *savePath = [savePanel URL];
            NSString *message = [NSString stringWithFormat:
                                 @"You've opened this file:\n\n%@\n\nand saved it here:\n\n%@\n\n",
                                 openPath, savePath];
            NSRunAlertPanel(@"Copying file (not really)", message, nil, nil, nil);
        }
    }
}


- (void)changeFont:(id)sender {
    // here, 'sender' is the shared NSFontManager instance
    NSFont *oldFont = [self.title font];
    NSFont *newFont = [sender convertFont:oldFont];
    [self.title setFont:newFont];
}

- (void)changeColor:(id)sender {
    // in this method, the "sender" parameter is the NSColorPanel
    // itself.  We just ask it for its color, and pass it along to
    // the "title" object.
    [self.title setTextColor:[sender color]];
}

@end
