/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLQueryUserEndPointApi.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   userEndPointApi/v1
// Description:
//   This is an API
// Classes:
//   GTLQueryUserEndPointApi (2 custom class methods, 3 custom properties)

#import "GTLQueryUserEndPointApi.h"

#import "GTLUserEndPointApiUserBean.h"

@implementation GTLQueryUserEndPointApi

@dynamic displayName, email, fields;

#pragma mark - Service level methods
// These create a GTLQueryUserEndPointApi object.

+ (instancetype)queryForCreateUserWithDisplayName:(NSString *)displayName
                                            email:(NSString *)email {
  NSString *methodName = @"userEndPointApi.createUser";
  GTLQueryUserEndPointApi *query = [self queryWithMethodName:methodName];
  query.displayName = displayName;
  query.email = email;
  query.expectedObjectClass = [GTLUserEndPointApiUserBean class];
  return query;
}

+ (instancetype)queryForGetUserWithEmail:(NSString *)email {
  NSString *methodName = @"userEndPointApi.getUser";
  GTLQueryUserEndPointApi *query = [self queryWithMethodName:methodName];
  query.email = email;
  query.expectedObjectClass = [GTLUserEndPointApiUserBean class];
  return query;
}

@end
