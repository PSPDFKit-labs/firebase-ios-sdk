/*
 * Copyright 2019 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "GDTUploadCoordinator+Testing.h"

#import <objc/runtime.h>

#import "GDTRegistrar.h"
#import "GDTStorage.h"
#import "GDTUploadCoordinator_Private.h"

@implementation GDTUploadCoordinator (Testing)

- (void)reset {
  [self.targetToNextUploadTimes removeAllObjects];
  [self.targetToInFlightEventSet removeAllObjects];
  [self.forcedUploadQueue removeAllObjects];
  self.storage = [GDTStorage sharedInstance];
  self.registrar = [GDTRegistrar sharedInstance];
}

- (void)stopTimer {
  dispatch_source_cancel(self.timer);
}

- (void)setTimerInterval:(uint64_t)timerInterval {
  [self setValue:@(timerInterval) forKey:@"_timerInterval"];
  dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, timerInterval, self.timerLeeway);
}

- (void)setTimerLeeway:(uint64_t)timerLeeway {
  [self setValue:@(timerLeeway) forKey:@"_timerLeeway"];
  dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, self.timerInterval, timerLeeway);
}

@end