//
//  CECurveView.h
//  CurveEdit
//
//  Created by Peter Clark on 2/24/13.
//  Copyright (c) 2013 Learn Cocoa. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CECurveView : NSView {
    NSRect myBounds;
}

@property (assign, nonatomic) CGFloat cp1X;
@property (assign, nonatomic) CGFloat cp1Y;
@property (assign, nonatomic) CGFloat cp2X;
@property (assign, nonatomic) CGFloat cp2Y;
@property (assign) BOOL draggingCp1;
@property (assign) BOOL draggingCp2;

@end
