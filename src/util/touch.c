/* This is a very simple touch program for CircleMUD */

/* coneil@symantec.com */

#include <stdio.h>
#include <sys/utime.h>
#include <sys/types.h>

main(int argc, char *argv[])
{
  FILE *f;

  if (argc<=1) {
    puts("Touch 1.0 by Clayton O'Neill\n");
    puts("touch filename");
    exit(1);
  }
  if ((f=fopen(argv[1],"ab+"))==NULL) {
    printf("Could not open/create %s",argv[1]);
    exit(1);
  } else {
    fclose(f);
    if (_utime(argv[1],(struct utimbuf *)NULL)==-1) {
      perror("_utime failed");
      exit(1);
    }
  }
}
