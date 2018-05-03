How to catch it?
Killing process will not get you far. I would rather recommend stop so you can inspect what is going on. By running

kill -TERM 17757

You will kill the process (notice PID column value for sync_supers may have changed since. Instead of killing immediately try doing

kill -STOP 17757

Then inspect procfs for this process ID

ls -al /proc/17757/

It will be informative to see cwd line; it says from which dir this process was started Examine also

cat /proc/17757/cmdline

To see how process was started

And also possibly interesting info in

ls -la /proc/17757/fd

Which will tell you if any files are opened by process.

If you want to interactively snoop on what process is doing, you can attach to it with system call tracer strace like this

strace -p 17757

However if process is stopped, you would not see much since it's stopped, so this may be something to consider before doing anything to the process.
