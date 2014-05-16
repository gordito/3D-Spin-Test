//
//  TestViewController.h
//  ViewTest1
//
//  Created by Robin Kochauf on 2014-05-16.
//  Copyright (c) 2014 En Appstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController
{
    float velocityX,touchX,angleX;
    IBOutlet UIView *touchView,*aniView;
}
@property (nonatomic,retain)IBOutlet UIView *touchView,*aniView;
@end
