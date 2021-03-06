/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2016 Google Inc.
 */

//
//  GTLUserEndPointApiUserBean.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   userEndPointApi/v1
// Description:
//   This is an API
// Classes:
//   GTLUserEndPointApiUserBean (0 custom class methods, 7 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLUserEndPointApiUserBean
//

@interface GTLUserEndPointApiUserBean : GTLObject
@property (nonatomic, retain) GTLDateTime *creationDate;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *email;

// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (nonatomic, retain) NSNumber *identifier;  // longLongValue

@property (nonatomic, retain) NSNumber *subscriptionPaid;  // boolValue
@property (nonatomic, retain) GTLDateTime *subscriptionPaidDate;
@property (nonatomic, retain) GTLDateTime *updatedDate;
@end
