#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

void read_from_pipe (int file) {
  FILE *stream;
  int c;
  stream = fdopen (file, "r");

  /* Read chars from the pipe and echo them to stdout. */
  while ((c = fgetc (stream)) != EOF)
    putchar (c);
  fclose (stream);
}

void write_to_pipe (int file) {
  FILE *stream;
  stream = fdopen (file, "w");

  /* Write some random text to the pipe. */
  fprintf (stream, "hello, world!\n");
  fprintf (stream, "goodbye, world!\n");
  fclose (stream);
}

int main (void) {
  pid_t pid;
  int mypipe[2];

  /* Create the pipe. */
  if (pipe (mypipe)) {
      fprintf (stderr, "Pipe failed.\n");
      return EXIT_FAILURE;
  }

  /* Create the child process. */
  pid = fork ();

  if (pid > (pid_t) 0) {
      /* This is the parent process */
      close (mypipe[0]);  /* Close unused read end */
      write_to_pipe (mypipe[1]);
      return EXIT_SUCCESS;
  } else if (pid == (pid_t) 0) {
      /* This is the child process */
      close (mypipe[1]);  /* Close unused write end */
      read_from_pipe (mypipe[0]);
      return EXIT_SUCCESS;
  } else {
      /* The fork failed. */
      fprintf (stderr, "Fork failed.\n");
      return EXIT_FAILURE;
  }
}
