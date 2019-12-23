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

#ifndef FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_UTIL_BACKGROUND_QUEUE_H_
#define FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_UTIL_BACKGROUND_QUEUE_H_

#include <thread>  // NOLINT(build/c++11)

namespace firebase {
namespace firestore {
namespace util {

class Executor;

class BackgroundQueue {
 public:
  explicit BackgroundQueue(Executor* executor);

  void Execute(std::function<void()>&& operation);

  void AwaitAll();

 private:
  Executor* executor_ = nullptr;
  int pending_tasks_ = 0;
  std::mutex mutex_;
  std::condition_variable done_;
};

}  // namespace util
}  // namespace firestore
}  // namespace firebase

#endif  // FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_UTIL_BACKGROUND_QUEUE_H_
