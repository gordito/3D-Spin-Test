//
//  TestViewController.m
//  ViewTest1
//
//  Created by Robin Kochauf on 2014-05-16.
//  Copyright (c) 2014 En Appstudio. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

@synthesize touchView,aniView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568h"]] ];
        [self.view setBackgroundColor:[UIColor clearColor]];
        
        angleX = 0.0f;
        [NSThread detachNewThreadSelector:@selector(aniLoop) toTarget:self withObject:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:touch.view];
    if([touch.view.restorationIdentifier isEqualToString:@"tV"]){
        velocityX = 0;
        touchX = touchLocation.x;
    }
    
    NSLog(@"%f",velocityX);
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:touch.view];
    
    
    
    if([touch.view.restorationIdentifier isEqualToString:@"tV"])
    {
        angleX += (touchLocation.x-touchX);
        touchX = touchLocation.x;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:touch.view];
    
    velocityX += (touchLocation.x-touchX);
}


-(void)aniLoop {
    
    while(true)
    {
        if(velocityX!=0){
            
            velocityX *= 0.98;
            angleX += velocityX;
        }
        
        [self performSelectorOnMainThread:@selector(updateLayer) withObject:nil waitUntilDone:NO];
        [NSThread sleepForTimeInterval:0.02f];
    }
}

-(void) updateLayer{
    
    
    UIView *myView = aniView;//self.view;//[[self.view subviews] objectAtIndex:0];
    CALayer *layer = myView.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, angleX * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
