//
//  NUSEvent.h
//  Newcastle Undead Society
//
//  Created by jl on 5/06/2014.
//  Copyright (c) 2014 Josh Lapham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUSEvent : NSObject

@property (nonatomic, strong) NSString *eventYear;
@property (nonatomic, strong) NSString *eventContent;
@property (nonatomic, strong) NSString *eventImageUrl;
@property (nonatomic, strong) NSString *eventMapImageUrl;
@property (nonatomic, strong) NSArray *eventGalleryImageUrls;
@property (nonatomic, strong) NSArray *eventTimes;
@property (nonatomic) BOOL isPastEvent;

// Init method
- (id)initWithYear:(NSString *)yearValue
        andContent:(NSString *)contentValue
       andImageUrl:(NSString *)imageUrlValue
andGalleryImageUrls:(NSArray *)galleryImageUrlsValue
          andTimes:(NSArray *)eventTimesValue
    andIsPastEvent:(BOOL)pastEventOrNot;

@end
