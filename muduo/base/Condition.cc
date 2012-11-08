// Use of this source code is governed by a BSD-style license
// that can be found in the License file.
//
// Author: Shuo Chen (chenshuo at chenshuo dot com)

#include <muduo/base/Condition.h>

#include <errno.h>
#include <sys/time.h>

// returns true if time out, false otherwise.
bool muduo::Condition::waitForSeconds(int seconds)
{
  struct timeval tv;
  struct timespec abstime;
  gettimeofday(&tv, NULL);
  //clock_gettime(CLOCK_REALTIME, &abstime);
  abstime.tv_sec = tv.tv_sec+seconds;
  abstime.tv_nsec = tv.tv_usec*1000;
  return ETIMEDOUT == pthread_cond_timedwait(&pcond_, mutex_.getPthreadMutex(), &abstime);
}

