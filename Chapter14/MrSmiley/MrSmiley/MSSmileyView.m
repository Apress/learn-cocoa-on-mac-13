//
//  MSSmileyView.m
//  MrSmiley
//
//  Created by Peter Clark on 2/9/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import "MSSmileyView.h"

@implementation MSSmileyView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.preferredBounds = NSMakeRect(0, 0, 100, 100);
        // [self setBounds:self.preferredBounds];
    }
    
    return self;
}

- (void)setFrameSize:(NSSize)newSize
{
    [super setFrameSize:newSize];
    [self setBounds:self.preferredBounds];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [NSGraphicsContext saveGraphicsState];
    
    NSRect bRect = CGRectInset([self bounds], 5, 5);
    NSBezierPath *border = [NSBezierPath bezierPathWithRoundedRect:bRect xRadius:5 yRadius:5];
    [[NSColor whiteColor] set];
    [border fill];
    
    [border setLineWidth:3];
    [[NSColor blackColor] set];
    [border stroke];
    
    NSRect hRect = CGRectInset([self bounds],20,20);
    NSBezierPath *head = [NSBezierPath bezierPathWithOvalInRect:hRect];
    NSGradient *faceGradient = [[NSGradient alloc]
                                initWithStartingColor:[NSColor whiteColor]
                                endingColor:[NSColor lightGrayColor]];
    [faceGradient drawInBezierPath:head angle:45];
    [head setLineWidth:3];
    [head stroke];
    
    NSBezierPath *features = [NSBezierPath bezierPath];
    [features moveToPoint:NSMakePoint(35, 30)];
    [features lineToPoint:NSMakePoint(65, 30)];
    [features moveToPoint:NSMakePoint(40, 40)];
    [features lineToPoint:NSMakePoint(40, 40)];
    [features moveToPoint:NSMakePoint(60, 40)];
    [features lineToPoint:NSMakePoint(60, 40)];
    [features setLineCapStyle:NSRoundLineCapStyle];
    [features setLineWidth:3];
    [features stroke];

    [NSGraphicsContext restoreGraphicsState];
}

@end
