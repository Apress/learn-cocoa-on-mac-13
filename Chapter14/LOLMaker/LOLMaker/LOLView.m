//
//  LOLView.m
//  LOLMaker
//
//  Created by Peter Clark on 2/9/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import "LOLView.h"

@implementation LOLView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

/*
- (void)drawRect:(NSRect)dirtyRect {
    NSRect srcImageRect = NSMakeRect(0, 0, [self.image size].width,
                                     [self.image size].height);
    [self.image drawAtPoint:[self bounds].origin fromRect:srcImageRect
                  operation:NSCompositeCopy fraction:1.0];
}
*/

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
    NSRect srcImageRect = NSMakeRect(0, 0, [self.image size].width,
                                     [self.image size].height);
    [self.image drawAtPoint:[self bounds].origin fromRect:srcImageRect
                  operation:NSCompositeCopy fraction:1.0];
    
    if (self.text != nil && [self.text length] > 0) {
        NSPoint textLocation = NSMakePoint(0,0);
        NSShadow *textShadow = [[NSShadow alloc] init];
        [textShadow setShadowOffset:NSMakeSize(0,0)];
        [textShadow setShadowColor:[NSColor blackColor]];
        [textShadow setShadowBlurRadius:10];
        NSMutableDictionary *textAttributes =
        [NSMutableDictionary dictionaryWithObjectsAndKeys:
         [NSFont fontWithName:@"Impact" size:40], NSFontAttributeName,
         [NSColor whiteColor], NSForegroundColorAttributeName,
         textShadow, NSShadowAttributeName,
         nil];
        
        // find the optimal size
        CGFloat fontSize;
        NSSize testSize = NSMakeSize(0, 0);
        for(fontSize=1; testSize.width < [self.image size].width; fontSize*=2)
        {
            [textAttributes setObject:[NSFont fontWithName:@"Impact"
                                                      size:fontSize]
                               forKey:NSFontAttributeName];
            testSize = [self.text sizeWithAttributes:textAttributes];
        }
        [textAttributes setObject:[NSFont fontWithName:@"Impact"
                                                  size:fontSize/4]
                           forKey:NSFontAttributeName];
        
        // and draw the text
        [self.text drawAtPoint:textLocation
                withAttributes:textAttributes];
    }
}


/*
- (void)setImage:(NSImage *)i {
    if (![i isEqual:_image]) {
        _image = i;
        [self setNeedsDisplay:YES];
    }
}
*/

- (void)setImage:(NSImage *)i {
    if (![i isEqual:_image]) {
        _image = i;
        if (i) {
            NSRect newImageFrame = NSMakeRect(0, 0, [i size].width,
                                              [i size].height);
            [self setFrame:newImageFrame];
        }
        [self setNeedsDisplay:YES];
    }
}

- (void)setText:(NSString *)t {
    if (![t isEqual:_text]) {
        _text = [t copy];
        [self setNeedsDisplay:YES];
    }
}

@end
