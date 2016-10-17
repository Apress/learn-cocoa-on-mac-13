//
//  WATAppDelegate.m
//  WhatAboutThatFile
//
//  Created by Jack on 3/19/13.
//  Copyright (c) 2013 LearnCocoa. All rights reserved.
//

#import "WATAppDelegate.h"

@implementation WATAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)chooseFile:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setResolvesAliases:NO];
    [openPanel setAllowsMultipleSelection:NO];
    if ([openPanel runModal] == NSFileHandlingPanelOKButton) {
        self.chosenEncoding = 0;
        self.fileURL = [openPanel URL];
        NSError *fileError;
        self.fileWrapper = [[NSFileWrapper alloc] initWithURL:self.fileURL
                                                      options:0
                                                        error:&fileError];
        if (!self.fileWrapper) {
            NSRunAlertPanel(@"Couldn't access file",
                            [fileError localizedDescription], nil, nil, nil);
        }
    }
}






+ (NSSet *)keyPathsForValuesAffectingFilename {
    return [NSSet setWithObjects:@"fileURL", @"fileWrapper", nil];
}
- (NSString *)filename {
    return [self.fileWrapper filename];
}

+ (NSSet *)keyPathsForValuesAffectingFileIcon {
    return [NSSet setWithObjects:@"fileURL", @"fileWrapper", nil];
}
- (NSImage *)fileIcon {
    return [self.fileWrapper icon];
}






+ (NSSet *)keyPathsForValuesAffectingOpensAppName {
    return [NSSet setWithObjects:@"fileURL", @"fileWrapper", nil];
}
- (NSString *)opensAppName {
    NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
    NSString *appName = nil;
    [workspace getInfoForFile:self.fileURL.path application:&appName type:NULL];
    return appName;
}
+ (NSSet *)keyPathsForValuesAffectingOpensAppIcon {
    return [NSSet setWithObjects:@"fileURL", @"fileWrapper", nil];
}
- (NSImage *)opensAppIcon {
    NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
    NSString *appName = nil;
    [workspace getInfoForFile:self.fileURL.path application:&appName type:NULL];
    return appName ? [workspace iconForFile:appName] : nil;
}





+ (NSSet *)keyPathsForValuesAffectingFileAttributes {
    return [NSSet setWithObjects:@"fileURL", @"fileWrapper", nil];
}
- (NSDictionary *)fileAttributes {
    return [self.fileWrapper fileAttributes];
}





- (NSDictionary *)encodingNames {
    static NSDictionary *encodingNames = nil;
    if (!encodingNames) {
        encodingNames = @{@"1" : @"NSASCIIStringEncoding",
                          @"2" : @"NSNEXTSTEPStringEncoding",
                          @"3" : @"NSJapaneseEUCStringEncoding",
                          @"4" : @"NSUTF8StringEncoding",
                          @"5" : @"NSISOLatin1StringEncoding",
                          @"6" : @"NSSymbolStringEncoding",
                          @"7" : @"NSNonLossyASCIIStringEncoding",
                          @"8" : @"NSShiftJISStringEncoding",
                          @"9" : @"NSISOLatin2StringEncoding",
                          @"10" : @"NSUnicodeStringEncoding",
                          @"11" : @"NSWindowsCP1251StringEncoding",
                          @"12" : @"NSWindowsCP1252StringEncoding",
                          @"13" : @"NSWindowsCP1253StringEncoding",
                          @"14" : @"NSWindowsCP1254StringEncoding",
                          @"15" : @"NSWindowsCP1250StringEncoding",
                          @"21" : @"NSISO2022JPStringEncoding",
                          @"30" : @"NSMacOSRomanStringEncoding",
                          @"2415919360" : @"NSUTF16BigEndianStringEncoding",
                          @"2483028224" : @"NSUTF16LittleEndianStringEncoding",
                          @"2348810496" : @"NSUTF32StringEncoding",
                          @"2550137088" : @"NSUTF32BigEndianStringEncoding",
                          @"2617245952" : @"NSUTF32LittleEndianStringEncoding"};
    }
    return encodingNames;
}





+ (NSSet *)keyPathsForValuesAffectingStringEncodingName {
    return [NSSet setWithObjects:@"fileURL", @"fileWrapper",
            @"chosenEncoding", nil];
}
- (NSString *)stringEncodingName {
    if (!self.fileURL) return nil;
    if (self.chosenEncoding != 0) {
        return [[self encodingNames] objectForKey:
                @(self.chosenEncoding).stringValue];
    } else {
        NSStringEncoding encoding = 0;
        NSError *err = nil;
        [NSString stringWithContentsOfFile:self.fileURL.path
                              usedEncoding:&encoding error:&err];
        if (encoding==0) {
            return @"No encoding detected.  Perhaps a binary file?";
        }
        return [[self encodingNames] objectForKey:
                @(self.chosenEncoding).stringValue];
    }
}
- (void)setStringEncodingName:(NSString *)name {
    NSString *key = [[[self encodingNames] allKeysForObject:name]
                     lastObject];
    self.chosenEncoding = [key longLongValue];
}





+ (NSSet *)keyPathsForValuesAffectingFileStringValue {
    return [NSSet setWithObjects:@"fileURL", @"fileWrapper",
            @"chosenEncoding", nil];
}
- (NSString *)fileStringValue {
    if (!self.fileURL) return nil;
    NSError *err = nil;
    NSString *value = nil;
    if (self.chosenEncoding != 0) {
        value = [NSString stringWithContentsOfFile:self.fileURL.path
                                          encoding:self.chosenEncoding error:&err];
    } else {
        NSStringEncoding encoding = 0;
        value = [NSString stringWithContentsOfFile:self.fileURL.path
                                      usedEncoding:&encoding error:&err];
    }
    if (err)  {
        if ([err code]==NSFileReadInapplicableStringEncodingError &&
            [[err domain] isEqual:NSCocoaErrorDomain]) {
            NSRunAlertPanel(@"Invalid string encoding",
                            [err localizedDescription], nil, nil, nil);
        }
        NSLog(@"encountered error: %@", err);
    }
    return value;
}


@end
