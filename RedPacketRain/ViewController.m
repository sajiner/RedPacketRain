//
//  ViewController.m
//  RedPacketRain
//
//  Created by 张鑫 on 2018/1/8.
//  Copyright © 2018年 张鑫. All rights reserved.
//

#import "ViewController.h"
#import "BYRedPacketView.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define SNOW_IMAGENAME         @"snow"
#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%20 + 10

@interface ViewController ()
{
    NSMutableArray *_imagesArray;
}
@property (nonatomic, strong) BYRedPacketView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redView = [[BYRedPacketView alloc] initWithFrame:self.view.bounds];
    self.redView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.redView];
}


static int i = 0;
- (void)makeSnow
{
    i = i + 1;
    if ([_imagesArray count] > 0) {
        UIImageView *imageView = [_imagesArray objectAtIndex:0];
        imageView.tag = i;
        [_imagesArray removeObjectAtIndex:0];
        [self snowFall:imageView];
    }
    
}

- (void)snowFall:(UIImageView *)aImageView
{
    [UIView beginAnimations:[NSString stringWithFormat:@"%li",(long)aImageView.tag] context:nil];
    [UIView setAnimationDuration:6];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake(aImageView.frame.origin.x, Main_Screen_Height, aImageView.frame.size.width, aImageView.frame.size.height);
//    NSLog(@"%@",aImageView);
    [UIView commitAnimations];
}

- (void)addImage
{
}


//- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
//{
//    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:[animationID intValue]];
//    float x = IMAGE_WIDTH;
//    imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
//    [_imagesArray addObject:imageView];
//}

@end
