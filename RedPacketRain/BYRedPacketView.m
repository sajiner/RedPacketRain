//
//  BYRedPacketView.m
//  RedPacketRain
//
//  Created by 张鑫 on 2018/1/8.
//  Copyright © 2018年 张鑫. All rights reserved.
//

#import "BYRedPacketView.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define SNOW_IMAGENAME         @"snow"
#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%20 + 10

#define kClockDec 0.3

@interface BYRedPacketView()

@property (nonatomic, strong) NSMutableArray *contentArr;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation BYRedPacketView
#pragma mark - public
- (void)stopRedPocketRain {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
            obj = nil;
        }];
    }
}

#pragma mark - event response
- (void)click: (UIButton *)btn {
    
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    for (int i = 0; i < 20; ++ i) {
        BYRedPacketItemView *imageView = [[BYRedPacketItemView alloc] init];
        imageView.backgroundColor = [UIColor redColor];
        [imageView.imagebtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
        [self addSubview:imageView];
        [self.contentArr addObject:imageView];
    }
    
    [self timer];
}

static int i = 0;
- (void)makeRedPacketRain {
    i = i + 1;
    if ([_contentArr count] > 0) {
        BYRedPacketItemView *imageView = [_contentArr objectAtIndex:0];
        imageView.tag = i;
        [_contentArr removeObjectAtIndex:0];
        [self snowFall:imageView];
    }
}

- (void)snowFall:(BYRedPacketItemView *)aImageView
{
    [UIView beginAnimations:[NSString stringWithFormat:@"%li",(long)aImageView.tag] context:nil];
    [UIView setAnimationDuration:6];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake(aImageView.frame.origin.x, Main_Screen_Height, aImageView.frame.size.width, aImageView.frame.size.height);
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    BYRedPacketItemView *imageView = (BYRedPacketItemView *)[self viewWithTag:[animationID intValue]];
    float x = IMAGE_WIDTH;
    imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
    [self.contentArr addObject:imageView];
}

#pragma mark - lazy
- (NSMutableArray *)contentArr {
    if (!_contentArr) {
        _contentArr = [NSMutableArray array];
    }
    return _contentArr;
}

- (NSTimer *)timer {
    if (!_timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:kClockDec target:self selector:@selector(makeRedPacketRain) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}

@end

@implementation BYRedPacketItemView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.imagebtn];
}

- (UIButton *)imagebtn {
    if (!_imagebtn) {
        _imagebtn = [[UIButton alloc] initWithFrame:self.bounds];
        [_imagebtn setBackgroundImage: [UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    }
    return _imagebtn;
}

@end
