# laravel-swoole
A Laravel  starter using Docker and  Swoole HTTP Server


# Benchmarking Tool: <a href="https://github.com/wg/wrk">wrk</a>
``` 
wrk -t4 -c100 http://your.app
``` 
# Nginx with FPM
``` wrk -t4 -c10 http://your.app

Running 10s test @ http://your.app.local
  4 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     6.41ms    1.56ms  19.71ms   71.32%
    Req/Sec   312.99     28.71   373.00     72.00%
  12469 requests in 10.01s, 3.14MB read
Requests/sec:   1245.79
Transfer/sec:    321.12KB
```
# Swoole HTTP Server
``` 
wrk -t4 -c10 http://lumen-swoole.local:1215

Running 10s test @ http://your.app:1215
  4 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.39ms    4.88ms 105.21ms   94.55%
    Req/Sec     1.26k   197.13     1.85k    68.75%
  50248 requests in 10.02s, 10.88MB read
Requests/sec:   5016.94
Transfer/sec:      1.09MB
```
