//
//  ZYWSideView.h
//  ZYWQQ
//
//  Created by Devil on 16/2/23.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYWSideViewDelegate <NSObject>

- (void)didSideViewLeftBtnEvent:(NSInteger) btnTag;

@end

@interface ZYWSideView : UIView
@property (nonatomic) id <ZYWSideViewDelegate>delegate;
@end
