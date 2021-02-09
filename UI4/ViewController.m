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
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    [NSTimer scheduledTimerWithTimeInterval:3.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.pageControl.currentPage == 2) {
            self.pageControl.currentPage = 0;
        } else {
            ++self.pageControl.currentPage;
        }
        CGFloat currentX = self.scrollView.bounds.size.width * self.pageControl.currentPage;
        [self.scrollView setContentOffset:CGPointMake(currentX, 0)];
    }];
}

- (void)initView {
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.imageView1];
    [self.scrollView addSubview:self.imageView2];
    [self.scrollView addSubview:self.imageView3];
    [self.view addSubview:self.pageControl];
    
    self.pageControl.frame = CGRectMake(0, 580, self.scrollView.bounds.size.width, 20);
    
    self.imageView1.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    self.imageView2.frame = CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    self.imageView3.frame = CGRectMake(self.scrollView.bounds.size.width * 2, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
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

@end
