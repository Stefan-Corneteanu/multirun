# multirun
A bash script to be used as template for running tests. Can run tests multiple times and break on failure, making it suitable for flaky test analysis and reliability jobs

# Usage

```shell
./multirun.sh [-h] [-r <no_iterations>] [-b]
```
-h - prints the help menu, providing info about the flags, and exits
-b - break on failure
-r - number of times test runs are repeated. Must be a strictly positive integer else it fails (default is 1)
