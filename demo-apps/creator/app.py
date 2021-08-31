#!/usr/bin/env python

import time
import redis
import os

redis_service_host = os.getenv("REDIS_SERVICE_HOST")

redisClient = redis.StrictRedis(host=redis_service_host,password="password",port=6379, db=0) 

for x in range(100):
    redisClient.lpush('test-queue', "Sample work package {x}")
    time.sleep(1)