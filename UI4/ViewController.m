//
//  ViewController.m
//  UI4
//
//  Created by bytedance on 2021/2/9.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>


@interface ViewController () <UICollectionViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UISwitch *mySwitch;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    
    
}


- (void)initView {
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.mySwitch];
    [self.view addSubview:self.label];
    
    [self.scrollView addSubview:self.imageView1];
    [self.scrollView addSubview:self.imageView2];
    [self.scrollView addSubview:self.imageView3];
    [self.view addSubview:self.pageControl];
    
    self.pageControl.frame = CGRectMake(0, 580, self.scrollView.bounds.size.width, 20);
    
    self.imageView1.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    self.imageView2.frame = CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    self.imageView3.frame = CGRectMake(self.scrollView.bounds.size.width * 2, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 50, 725, 100, 50)];
        _label.text = @"自动轮播";
        _label.textAlignment = UITextAlignmentCenter;
    }
    return _label;
}

- (UISwitch *)mySwitch {
    if (!_mySwitch) {
        _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 25, 700, 50, 50)];
        [_mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _mySwitch;
}

- (NSTimer *)timer {
    if (!_timer) {
        __weak typeof(self) wSelf = self;
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (wSelf.pageControl.currentPage == 2) {
                wSelf.pageControl.currentPage = 0;
            } else {
                ++wSelf.pageControl.currentPage;
            }
            CGFloat currentX = wSelf.scrollView.bounds.size.width * wSelf.pageControl.currentPage;
            [wSelf.scrollView setContentOffset:CGPointMake(currentX, 0)];
        }];
    }
    return _timer;
}


- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        [_pageControl addTarget:self action:@selector(clickPageControl) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    }
    return _imageView1;
}

- (UIImageView *)imageView2 {
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]];
    }
    return _imageView2;
}

- (UIImageView *)imageView3 {
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3"]];
    }
    return _imageView3;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 400)];
        _scrollView.backgroundColor = [UIColor yellowColor];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.layer.masksToBounds = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, _scrollView.bounds.size.height);
    }
    return _scrollView;
}

- (void)clickPageControl {
    CGFloat currentX = self.scrollView.bounds.size.width * self.pageControl.currentPage;
    [self.scrollView setContentOffset:CGPointMake(currentX, 0)];
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentX = scrollView.contentOffset.x;
    
    self.pageControl.currentPage = currentX / self.scrollView.bounds.size.width;
}

#pragma mark - Action
- (IBAction)switchAction:(UISwitch *)st {
    if (st.on == YES) {
        [self.timer setFireDate:[NSDate distantPast]];
    } else {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

@end
