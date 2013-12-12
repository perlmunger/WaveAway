//
//  MLViewController.m
//  WaveAway
//
//  Created by Matt Long on 12/12/13.
//  Copyright (c) 2013 Matt Long. All rights reserved.
//

#import "MLViewController.h"

@interface MLViewController ()

@end

@implementation MLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addWavesToView];
    [self addAnimationsToLayers];
}

- (void)addWavesToView
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 300.0f, 300.0f);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    for (NSInteger i = 0; i < 10; ++i) {
        CAShapeLayer *waveLayer = [CAShapeLayer layer];
        waveLayer.bounds = rect;
        waveLayer.position = CGPointMake(300.0f, 100.0f);
        waveLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
        waveLayer.fillColor = [[UIColor clearColor] CGColor];
        waveLayer.lineWidth = 5.0f;
        waveLayer.path = circlePath.CGPath;
        
        // Translate on the y axis to shift all the layers down while
        // we're creating them. Could do this with the position value as well
        // but this is a little cleaner.
        waveLayer.transform = CATransform3DMakeTranslation(0.0f, i*25, 0.0f);
        
        // strokeStart begins at 3:00. You would need to transform (rotate)
        // the layer 90 deg CCW to have it start at 12:00
        waveLayer.strokeStart = 0.25 - ((i+1) * 0.01f);
        waveLayer.strokeEnd = 0.25 + ((i+1) * 0.01f);
        
        [self.view.layer addSublayer:waveLayer];
    }
}

- (void)addAnimationsToLayers
{
    NSInteger timeOffset = 10;
    for (CALayer *layer in self.view.layer.sublayers) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
        animation.duration = 10.0f;

        // Stagger the animations so they don't begin until the
        // desired time in each
        animation.timeOffset = timeOffset--;
        animation.toValue = (id)[[UIColor lightGrayColor] CGColor];
        animation.fromValue = (id)[[UIColor darkGrayColor] CGColor];
        
        // Repeat forever
        animation.repeatCount = HUGE_VALF;
        
        // Run it at 10x. You can adjust this to taste.
        animation.speed = 10;
        
        // Add to the layer to start the animation
        [layer addAnimation:animation forKey:@"strokeColor"];
    }
    
}

@end
