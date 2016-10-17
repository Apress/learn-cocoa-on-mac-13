//
//  CMColorBlendView.h
//  ColorMix
//
//  Created by Jack on 1/17/13.
//  Copyright (c) 2013 Rebisoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CMColorBlendView : NSView

@property (strong, nonatomic) NSColor *color1;
@property (strong, nonatomic) NSColor *color2;
@property (assign, nonatomic) CGBlendMode blendMode;

@end
