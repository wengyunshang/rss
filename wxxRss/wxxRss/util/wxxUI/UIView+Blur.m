//
//  UIView+Blur.m
//  zhouzhe
//
//  Created by libohao on 14-10-16.
//  Copyright (c) 2014年 zhouzhe. All rights reserved.
//

#import "UIView+Blur.h"
#import "UIImage+ImageEffects.h"

@implementation UIView (Blur)


// 使用上下文截图,并使用指定的区域裁剪,模板代码
- (UIImage*)screenShot:(UIImage*)image
{
//    UIImage* image;
    // 将要被截图的view
    // 背景图片 总的大小
    CGSize size = self.frame.size;
    UIGraphicsBeginImageContext(size);
    // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    // 裁剪的关键代码,要裁剪的矩形范围
    CGRect rect = CGRectMake(0, 0, size.width, size.height  );
    //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
    [self drawViewHierarchyInRect:rect  afterScreenUpdates:NO];
    // 从上下文中,取出UIImage
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    // 添加截取好的图片到图片View里面
    image = snapshot;
    
    // 千万记得,结束上下文(移除栈顶上下文)
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage*)image:(UIImage*)image{
    
    image = [[self screenShot:image] applyDarkEffect];
    
    return image;
}

//-(void)blurScreen:(BOOL)enable
//{
//    if (enable) {
//        UIImageView* blurImgView = [[UIImageView alloc]initWithFrame:self.bounds];
//        UIImage* img = [[self screenShot] applyDarkEffect];
//        blurImgView.image = img;
//        [self addSubview:blurImgView];
//        [self bringSubviewToFront:blurImgView];
//        blurImgView.tag =10000;
//    }else{
//        UIView* view = [self viewWithTag:10000];
//        view.hidden = YES;
//        [view removeFromSuperview];
//    }
//    
//    
//}
-(void)blurScreenBlackToSearch:(BOOL)enable
{
    if (enable) {
        //实现模糊效果
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        visualEffectView.frame = self.bounds;
        visualEffectView.alpha = 1.0;
        [self addSubview:visualEffectView];
//        UIToolbar *blurView = [[UIToolbar alloc] initWithFrame:CGRectZero];
//        blurView.frame = self.bounds;
////        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        blurView.barStyle = UIBarStyleBlackOpaque;
////        blurView.translucent = YES;
//        blurView.alpha = 0.1;
//        [self addSubview:blurView];
//        blurView.tag =10000;
////            CATransform3D transform = CATransform3DIdentity;
////            transform.m34 = -0.001;
////            transform = CATransform3DRotate(transform, 0 , 0.0f, 0.0f, 0.0f);
////            transform = CATransform3DMakeTranslation(0,0,-100);
////            blurView.layer.transform = transform;
//        [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
//            blurView.alpha = 1.0;
//        } completion:^(BOOL finished) {
//        }];
        
    }else{
        UIView* view = [self viewWithTag:10000];
        
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
            view.alpha = 0.0;
        } completion:^(BOOL finished) {
            view.hidden = YES;
            [view removeFromSuperview];
        }];
        
        
    }
}

-(void)blurBlueScreen:(BOOL)enable
{
    if (enable) {
        //实现模糊效果
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        visualEffectView.frame = self.bounds;
        visualEffectView.alpha = 1.0;
        [self addSubview:visualEffectView];
//        UIToolbar *blurView = [[UIToolbar alloc] initWithFrame:CGRectZero];
//        blurView.frame = self.bounds;
//        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        blurView.barStyle = UIBarStyleDefault;
//        blurView.backgroundColor = [UIColor colorWithRed:41/255.0 green:158/255.0 blue:242/255.0 alpha:1.0];
//        blurView.translucent = YES;
//        blurView.alpha = 0.8;
//        [self addSubview:blurView];
//        blurView.tag =10000;
//        
//        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
//            blurView.alpha = 1.0;
//        } completion:^(BOOL finished) {
//        }];
        
    }else{
        UIView* view = [self viewWithTag:10000];
        
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
            view.alpha = 0.0;
        } completion:^(BOOL finished) {
            view.hidden = YES;
            [view removeFromSuperview];
        }];
        
        
    }
}

-(void)blurScreen:(BOOL)enable alp:(float)alp
{
    if (enable) {
        //实现模糊效果
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        visualEffectView.frame = self.bounds;
        visualEffectView.alpha = 1.0;
        [self addSubview:visualEffectView];
//        UIToolbar *blurView = [[UIToolbar alloc] initWithFrame:CGRectZero];
//        blurView.frame = self.bounds;
//        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        blurView.barStyle = UIBarStyleDefault;
//        blurView.translucent = YES;
//        blurView.alpha = 0.8;
//        [self addSubview:blurView];
//        blurView.tag =10000;
//        
//        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
//            blurView.alpha = alp;
//        } completion:^(BOOL finished) {
//        }];
        
    }else{
        UIView* view = [self viewWithTag:10000];
        
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
            view.alpha = 0.0;
        } completion:^(BOOL finished) {
            view.hidden = YES;
            [view removeFromSuperview];
        }];
        
        
    }
}

-(void)blurScreen:(BOOL)enable
{
    if (enable) {
//        UIToolbar *blurView = [[UIToolbar alloc] initWithFrame:CGRectZero];
//        blurView.frame = self.bounds;
//        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        blurView.barStyle = UIBarStyleDefault;
//        blurView.translucent = YES;
//        blurView.alpha = 0.8;
//        [self addSubview:blurView];
//        blurView.tag =10000;
//        
//        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
//            blurView.alpha = 1.0;
//        } completion:^(BOOL finished) {
//        }];
        
        //实现模糊效果
//        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//        visualEffectView.frame = self.view.bounds;
//        visualEffectView.alpha = 1.0;
//        [self.view addSubview:visualEffectView];
        //实现模糊效果
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        visualEffectView.frame = CGRectMake(0, 0, UIBounds.size.width, 40);
        visualEffectView.alpha = 1;
        [self addSubview:visualEffectView];
        
    }else{
        UIView* view = [self viewWithTag:10000];
        
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
            view.alpha = 0.0;
        } completion:^(BOOL finished) {
            view.hidden = YES;
            [view removeFromSuperview];
        }];
        
        
    }
}


@end
