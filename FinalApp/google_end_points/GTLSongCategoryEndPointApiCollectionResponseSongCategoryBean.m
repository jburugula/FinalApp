/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLSongCategoryEndPointApiCollectionResponseSongCategoryBean.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   songCategoryEndPointApi/v1
// Description:
//   This is an API
// Classes:
//   GTLSongCategoryEndPointApiCollectionResponseSongCategoryBean (0 custom class methods, 2 custom properties)

#import "GTLSongCategoryEndPointApiCollectionResponseSongCategoryBean.h"

#import "GTLSongCategoryEndPointApiSongCategoryBean.h"

// ----------------------------------------------------------------------------
//
//   GTLSongCategoryEndPointApiCollectionResponseSongCategoryBean
//

@implementation GTLSongCategoryEndPointApiCollectionResponseSongCategoryBean
@dynamic items, nextPageToken;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"items" : [GTLSongCategoryEndPointApiSongCategoryBean class]
  };
  return map;
}

@end