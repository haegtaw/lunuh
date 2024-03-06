#include "grep_s21.h"

int main(int argc, char *argv[]) {
  char get_opt;
  int error = 0, count_moldes = 0;
  regex_t moldd[MAX_MOLDES];

  while (!error && (get_opt = getopt(argc, argv, ":e:ivclnhsf:o")) != -1) {
    switch (get_opt) {
      case 'f':
        options.f = 1;
        if ((error = readfile_moldes(moldd, &count_moldes, optarg)))
          printf("%s: No such file or directory\n", optarg);
        break;
      case 'e':
        options.e = 1;
        regcomp(&moldd[count_moldes++], optarg,
                options.i ? REG_ICASE : REG_EXTENDED);
        break;
      case 'i':
        options.i = 1;
        break;
      case 'v':
        options.v = 1;
        break;
      case 'c':
        options.c = 1;
        break;
      case 'l':
        options.l = 1;
        break;
      case 'n':
        options.n = 1;
        break;
      case 'h':
        options.h = 1;
        break;
      case 's':
        options.s = 1;
        break;
      case 'o':
        options.o = 1;
        break;
      default:
        error = 1;
        break;
    }
  }

  if (!error && (optind + 1 - (options.f || options.e)) < argc) {
    if (!(options.f || options.e))
      regcomp(&moldd[count_moldes++], argv[optind++],
              options.i ? REG_ICASE : REG_EXTENDED);
    if (optind == argc - 1) options.h = 1;
    while (optind < argc) {
      if (print_matches(moldd, count_moldes, argv[optind]) && !options.s)
        printf("%s: No such file or directory\n", argv[optind]);
      optind++;
    }
  } else
    printf("Error!");

  free_moldes(moldd, count_moldes);

  return 0;
}

int print_matches(regex_t *moldd, int count_moldes, char *filename) {
  int result, offset, line_count = 0, match_count = 0;
  char line[MAX_LINE_LENGTH];
  FILE *f = fopen(filename, "r");

  !f ? (result = 0) : (result = 1);

  while (result && feof(f) == 0 && fgets(line, MAX_LINE_LENGTH, f)) {
    int match = 0;
    int line_len;
    line_len = strlen(line);
    line_count++;
    for (int i = 0; i < count_moldes; i++) {
      offset = 0;
      regmatch_t regmatch;
      while (!regexec(&moldd[i], &line[offset], 1, &regmatch, 0)) {
        if (options.o && !options.v && !options.c && !options.l) {
          if (!offset && !options.h) printf("%s:", filename);
          if (!offset && options.n) printf("%d:", line_count);
          while (regmatch.rm_so < regmatch.rm_eo) {
            printf("%c", line[offset + regmatch.rm_so]);
            regmatch.rm_so++;
          }
          printf("\n");
        }
        match = 1;
        offset += regmatch.rm_eo;
      }
    }
    if (options.v) match = !match;

    match_count += match;

    if (match && !options.c && !options.l && (!options.o || options.v)) {
      if (!options.h) printf("%s:", filename);
      if (options.n) printf("%d:", line_count);
      for (int i = 0; i < line_len && line[i] != '\n'; i++)
        printf("%c", line[i]);
      printf("\n");
    }
  }

  if (options.c) {
    if (!options.h) printf("%s:", filename);
    if (options.l) match_count = 1;
    printf("%d\n", match_count);
  }

  if (options.l)
    if (match_count > 0) printf("%s\n", filename);

  if (result) fclose(f);

  return !result;
}

void free_moldes(regex_t *moldd, int count) {
  for (int i = 0; i < count; i++) regfree(&moldd[i]);
}

int readfile_moldes(regex_t *moldd, int *count_moldes, char *filename) {
  int result;
  char line[MAX_LINE_LENGTH];
  FILE *f = fopen(filename, "r");

  !f ? (result = 0) : (result = 1);

  while (result && feof(f) == 0 && fgets(line, MAX_LINE_LENGTH, f)) {
    int line_len;
    line_len = strlen(line);

    if (line[line_len - 1] == '\n') line[line_len - 1] = '\0';

    regcomp(&moldd[(*count_moldes)++], line,
            options.i ? REG_ICASE : REG_EXTENDED);
  }

  if (result) fclose(f);

  return !result;
}