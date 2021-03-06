/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLQuerySongDetailsEndPointApi.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   songDetailsEndPointApi/v1
// Description:
//   This is an API
// Classes:
//   GTLQuerySongDetailsEndPointApi (3 custom class methods, 11 custom properties)

#import "GTLQuerySongDetailsEndPointApi.h"

#import "GTLSongDetailsEndPointApiCollectionResponseSongDetailsBean.h"
#import "GTLSongDetailsEndPointApiSongDetailsBean.h"

@implementation GTLQuerySongDetailsEndPointApi

@dynamic aarohana, after, avarohana, category, details, duration, fields,
         pictureUrl, ragam, title, videoUrl;

#pragma mark - Service level methods
// These create a GTLQuerySongDetailsEndPointApi object.

+ (instancetype)queryForCreateSongDetailsWithAarohana:(NSString *)aarohana
                                            avarohana:(NSString *)avarohana
                                             category:(NSString *)category
                                              details:(NSString *)details
                                             duration:(double)duration
                                           pictureUrl:(NSString *)pictureUrl
                                             videoUrl:(NSString *)videoUrl
                                                ragam:(NSString *)ragam
                                                title:(NSString *)title {
  NSString *methodName = @"songDetailsEndPointApi.createSongDetails";
  GTLQuerySongDetailsEndPointApi *query = [self queryWithMethodName:methodName];
  query.aarohana = aarohana;
  query.avarohana = avarohana;
  query.category = category;
  query.details = details;
  query.duration = duration;
  query.pictureUrl = pictureUrl;
  query.videoUrl = videoUrl;
  query.ragam = ragam;
  query.title = title;
  query.expectedObjectClass = [GTLSongDetailsEndPointApiSongDetailsBean class];
  return query;
}

+ (instancetype)queryForGetAllSongsDetailsWithAfter:(long long)after {
  NSString *methodName = @"songDetailsEndPointApi.getAllSongsDetails";
  GTLQuerySongDetailsEndPointApi *query = [self queryWithMethodName:methodName];
  query.after = after;
  query.expectedObjectClass = [GTLSongDetailsEndPointApiCollectionResponseSongDetailsBean class];
  return query;
}

+ (instancetype)queryForGetSongDetailsWithTitle:(NSString *)title
                                       category:(NSString *)category
                                          ragam:(NSString *)ragam {
  NSString *methodName = @"songDetailsEndPointApi.getSongDetails";
  GTLQuerySongDetailsEndPointApi *query = [self queryWithMethodName:methodName];
  query.title = title;
  query.category = category;
  query.ragam = ragam;
  query.expectedObjectClass = [GTLSongDetailsEndPointApiSongDetailsBean class];
  return query;
}

@end
