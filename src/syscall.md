# Nachos System Call Interface

## Error Handling

One of the broken things about Nachos is that it does not provide a
clean way to return system call errors to a user process. For example,
Unix kernels return system call error codes in a designated register,
and the system call stubs (e.g., in the standard C library or in
start.s ) move them into a program variable, e.g., the global variable
errno for C programs. We are not bothering with this in Nachos. What
is important is that you detect the error and reject the request with
no bad side effects and without crashing the kernel. I recommend that
you report errors by returning a 0 or -1 value where possible, instead
of returning a value that could be interpreted as a valid result. If
there is no clean way to notify the user process of a system call
error it is acceptable to simply return from the call and just let the
user process struggle forward.


## Process Management

```
SpaceId Exec(char *executable, int pipectrl)
```

**need update** Create a user process by creating a new address space,
initializing it from the executable program file, and starting a new
thread (via Thread::Fork ) to run within it. To start execution of the
child process, the kernel sets up the CPU state for the new process
and then calls Machine::Run to start the machine simulator executing
the specified program's instructions in the context of the newly
created address space. Note that Nachos Exec combines the Unix fork
and exec system calls: Exec both creates a new process (like Unix fork
) and executes a specified program within its context (like Unix exec
).

Exec returns a unique SpaceId identifying the child user process. The
SpaceId can be passed as an argument to other system calls (e.g., Join
) to identify the process, thus it must be unique among all currently
existing processes. However, your kernel should be able to recycle
SpaceId values so that it does not run out of them. By convention, the
SpaceId 0 will be used to indicate an error.

The pipectrl parameter is discussed in Pipes. User programs not using
pipes should always pass zero in pipectrl . Don't worry about this
parameter for Lab 4; save it for Lab 5.

---

```
void Exit(int status)
```

A user process calls Exit to indicate that it is finished and ready to
terminate. The user program may call Exit explicitly, or it may simply
return from main , since the common runtime library routine (in
start.s ) that calls main to start the program also calls Exit when
main returns. The kernel handles an Exit system call by destroying the
process data structures and thread(s), reclaiming any memory assigned
to the process, and arranging to return the exit status value as the
result of the Join on this process, if any. Note that other processes
are not affected: do not confuse Exit with Halt .

**Note**: if you are implementing threads (Threads), then Exit
destroys the calling thread rather than the entire process/address
space. The process and its address space are destroyed only when the
last thread calls Exit , or if one of its threads generates a fatal
exception.

**Warning**: the Exit system call should never return; it should
always destroy the calling thread. Returning from Exit may cause your
Nachos system to mysteriously shut down. To see why, look at the
startup instruction sequence in test/start.s .

---

```
int Join(SpaceId joineeId)
```

This is called by a process (the joiner) to wait for the termination
of the process (the joinee) whose SpaceId is given by the joineeId
argument. If the joinee is still active, then Join blocks until the
joinee exits. When the joinee has exited, Join returns the joinee's
exit status to the joiner. To simplify the implementation, impose the
following limitations on Join : the joiner must be the parent of the
joinee, and each joinee may be joined on at most once. Nachos Join is
basically equivalent to the Unix wait system call.


## Files and I/O

```
void Create(char *filename)
```

Create an empty file named filename . Note this differs from the
corresponding Unix call, which would also open the file for writing.
User programs must issue a separate Open call to open the newly
created file for writing.

---

```
OpenFileId Open(char *filename)
```

Open the file named filename and return an OpenFileId to be used as a
handle for the file in subsequent Read or Write calls. Each process is
to have a set of OpenFileIds associated with its state and the
necessary bookkeeping to map them into the file system's internal way
of identifying open files. This call differs from Unix in that it does
not specify any access mode (open for writing, open for reading, etc.)

---

```
void Write(char *buffer, int size, OpenFileId id)
```

Write size bytes of the data in the buffer to the open file identified by id.

---

```
int Read(char *buffer, int size, OpenFileId id)
```

Try to read size bytes into the user buffer . Return the number of
bytes actually read, which may be less than the number of bytes
requested, e.g., if there are fewer than size bytes available.

---

```
void Close(OpenFileId id)
```

Clean up the "bookkeeping" data structures representing the open file.

## Pipe

The Exec system call includes a pipectrl argument as defined in
Process Management. This argument is used to direct the optional
binding of OpenFileIds 0 (stdin) and 1 (stdout) to pipes rather than
the console. This allows a process to create strings of child
processes joined by a pipeline. A pipeline is a sequence of pipes,
each with one reader and one writer. The first process in the pipeline
has stdin bound to the console and stdout bound to the pipeline input.
Processes in the middle of the pipeline have both stdin and stdout
bound to pipes. The process at the end of the pipe writes its stdout
to the console.

The Nachos interface for creating pipes is much simpler and less
flexible than Unix. A parent process can use nonzero values of the
pipectrl argument to direct that its children are to be strung out in
a pipeline in the order in which they are created. A pipectrl value of
1 indicates that the process is the first process in the pipeline. A
pipectrl value of 2 indicates a process in the middle of the pipeline;
stdin is bound to the output of the preceding child, and stdout is
bound to the input of the next child process to be created. A pipectrl
value of 3 indicates that the process is at the end of the pipeline.

To handle these pipectrl values, the kernel must keep a list of all
children of each process in the order that they are created.

Pipes are implemented as producer/consumer bounded buffers with a
maximum buffer size of N bytes. If a process writes to a pipe that is
full, the Write call blocks until the pipe has drained sufficiently to
allow the write to continue. If a process reads from a pipe that is
empty, the Read call blocks until the sending process exits or writes
data into the pipe. If a process at either end of a pipe exits, the
pipe is said to be broken : reads from a broken pipe drain the pipe
and then stop returning data, and writes to a broken pipe silently
discard the data written.

## Threads

Thread support may be implemented for extra credit in Labs 4-5. Nachos
systems with thread support should define the semantics of Exit in the
following way. Exit indicates that the calling thread is finished; if
the calling thread is the last thread in the process then it causes
the entire process to exit (e.g., wake up joiner if any). The status
value reported by the last thread in the process to call Exit shall be
deemed the exit status of the process, to be returned as the result
from Join .

---

```
void Fork(void(*function)())
```

Creates a new thread of control executing in the calling user process
address space. The function argument is a procedure pointer, a
user-space virtual address: the new thread will begin executing at
this address in the same address space as the thread calling Fork .
The new thread must have its own user stack in the user address space,
separate from all other threads. It must be able to make system calls
and block independently of other threads in the same process.

---

```
void Yield()
```

Called within a user program to yield the CPU. Yield triggers a
Thread::Yield within Nachos, allowing some other ready thread to run.
