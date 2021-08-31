#!/usr/bin/env python

import time
import redis

host="redis"
# Uncomment next two lines if you do not have Kube-DNS working.
import os
redis_service_host = os.getenv("REDIS_SERVICE_HOST")

redisClient = redis.StrictRedis(host=redis_service_host, password="password", port=6379, db=0) 

while(True):
    print(redisClient.lpop('test-queue'))
    time.sleep(5)