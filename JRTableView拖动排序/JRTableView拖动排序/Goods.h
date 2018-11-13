//
//  Goods.h
//  购物车表格删除
//
//  Created by jerei on 15-1-7.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *details;

-(id)initWithDic:(NSDictionary*)dic;
+(id)goodsWithDic:(NSDictionary*)dic;

@end
