//
//  CMColorBlendView.m
//  ColorMix
//
//  Created by Jack on 1/17/13.
//  Copyright (c) 2013 Rebisoft. All rights reserved.
//

#import "CMColorBlendView.h"

static CGColorRef genericRGBWithNSColor (NSColor *color) {
    CGColorRef cgColor = NULL;
    
    NSColorSpace *nsColorSpace = [NSColorSpace genericRGBColorSpace];
    NSColor *deviceRGBColor = [color colorUsingColorSpace: nsColorSpace];
    if (deviceRGBColor != nil) {
        CGFloat components[4];
        [deviceRGBColor getRed: &components[0] green: &components[1]
                          blue: &components[2] alpha: &components[3]];
        
        cgColor = CGColorCreate([nsColorSpace CGColorSpace], components);
    }
    
    return cgColor;
}

@implementation CMColorBlendView

- (void)setBlendMode:(CGBlendMode)bm {
    if (_blendMode != bm) {
        _blendMode = bm;
        [self setNeedsDisplay:YES];
    }
}
- (void)setColor1:(NSColor *)c {
    if (![c isEqual:_color1]) {
        _color1 = c;
        [self setNeedsDisplay:YES];
    }
}
- (void)setColor2:(NSColor *)c {
    if (![c isEqual:_color2]) {
        _color2 = c;
        [self setNeedsDisplay:YES];
    }
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    if (!self.color1 || !self.color2) return;
    
    CGColorRef cgColor1 = genericRGBWithNSColor(self.color1);
    CGColorRef cgColor2 = genericRGBWithNSColor(self.color2);
    
    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSaveGState(myContext);
    
    CGContextSetFillColorWithColor(myContext, cgColor1);
    CGContextSetBlendMode(myContext, kCGBlendModeNormal);
    CGContextFillRect(myContext, NSRectToCGRect(dirtyRect));
    
    CGContextSetFillColorWithColor(myContext, cgColor2);
    CGContextSetBlendMode(myContext, self.blendMode);
    CGContextFillRect(myContext, NSRectToCGRect(dirtyRect));
    
    CGContextRestoreGState(myContext);
    
    CGColorRelease(cgColor1);
    CGColorRelease(cgColor2);
}

@end
