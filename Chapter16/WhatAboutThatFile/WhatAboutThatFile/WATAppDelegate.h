//
//  WATAppDelegate.h
//  WhatAboutThatFile
//
//  Created by Jack on 3/19/13.
//  Copyright (c) 2013 LearnCocoa. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WATAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (strong) NSFileWrapper *fileWrapper;
@property (strong) NSURL *fileURL;
@property (assign) NSStringEncoding chosenEncoding;

@property (readonly) NSDictionary *fileAttributes;
@property (readonly) NSString *filename;
@property (readonly) NSImage *fileIcon;
@property (readonly) NSImage *opensAppIcon;
@property (readonly) NSString *opensAppName;
@property (weak) NSString *stringEncodingName;
@property (readonly) NSString *fileStringValue;
@property (readonly) NSDictionary *encodingNames;

- (IBAction)chooseFile:(id)sender;

@end
