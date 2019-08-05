//
//  CXScanningCardVC.h
//  CXScanningIDCard
//
//  Created by 曹翔 on 2019/7/31.
//  Copyright © 2019 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ScanningCardDelegate <NSObject>

-(void)CXScanningCardFinishModel:(CXCardModel *)model;

@end

@interface CXScanningCardVC : UIViewController

@property (nonatomic,weak) id<ScanningCardDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
