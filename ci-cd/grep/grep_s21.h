#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_MOLDES 1024
#define MAX_LINE_LENGTH 2048

typedef struct {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
} flags;

flags options = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

int print_matches(regex_t *moldd, int count_moldes, char *filename);
int readfile_moldes(regex_t *moldd, int *count_moldes, char *filename);
void free_moldes(regex_t *moldd, int count);