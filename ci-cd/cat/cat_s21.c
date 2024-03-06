#include "cat_s21.h"

int main(int argc, char *argv[]) {
  /* параметр argc - кол-во арг в комстроке
  (целое >= 1, имя программы первое).
  параметр argv - указатель на массив указателей на строки */

  int option[6] = {false};
  int mainflag = command_analyser(argv, option);

  while (mainflag < argc) {
    s21_mycat(argv, mainflag, option);
    mainflag++;
  }
  return 0;
}

int s21_mycat(char *argv[], int mainflag, const int *option) {
  FILE *file = NULL;

  if ((file = fopen(argv[mainflag], "r+"))) {
    int c = 0;
    int n = 0;
    int new_line = true;
    int k = 1;

    while ((c = fgetc(file)) != EOF) {
      if (c == '\n' && new_line) {
        n++;
      } else {
        n = 0;
      }

      if (n == 0 && new_line && option[0]) {
        printf("%6d\t", k);
        k++;
      }  // b
      else if (new_line && option[2] && !option[0] &&
               !(option[3] == 1 && n >= 2)) {
        printf("%6d\t", k);
        k++;
      }  // n

      if (option[3] == 1) {
        if (n >= 2) {
          continue;
        }
      }  // s
      if (c == '\n') {
        new_line = true;
      } else {
        new_line = false;
      }

      if (option[1] == 1 && c == 10 && new_line) {
        printf("$\n");  // e
      } else if (option[4] == 1 && c == 9) {
        printf("^I");  // t
      } else if (option[5] == 1 && c >= 127) {
        m_code(c);
      } else {
        printf("%c", c);
      }
    }

    fclose(file);
  }

  else {
    fprintf(stderr, "File open failed: %s.\n", argv[mainflag]);
  }
  return 0;
}

void m_code(int c) {
  int s = c - 128;
  if (s <= 32 || s == 127) {
    s = s + 64;
    printf("M-^%c", s);
  } else {
    s = s - 128;
    printf("%c", s);
  }
}

int command_analyser(char *argv[], int *option) {
  int mainflag = 1;
  int er_flag = 0;
  while (argv[mainflag][0] == '-') {
    if (argv[mainflag][1] == '-') {
      er_flag = more_flags(option, argv[mainflag]);
    } else {
      er_flag = single_flag(option, argv[mainflag]);
    }
    mainflag++;
  }
  if (er_flag == 1) {
    mainflag = -1;
  }
  return mainflag;
}

int more_flags(int *option, char *argv) {
  int flag = 0;
  if (strcmp(argv, "--number-nonblank") == 0) {
    option[0] = true;
  } else if (strcmp(argv, "--number") == 0) {
    option[2] = true;
  } else if (strcmp(argv, "--squeeze-blank") == 0) {
    option[3] = true;
  } else {
    flag = 1;
  }
  return flag;
}

int single_flag(int *option, char *argv) {
  int flag = 0;
  for (size_t i = 0; i < strlen(argv); i++) {
    switch (argv[i]) {
      case 'b':
        option[0] = true;
        break;
      case 'e':
        option[1] = true;
        option[5] = true;
        break;
      case 'E':
        option[1] = true;
        break;
      case 'n':
        option[2] = true;
        break;
      case 's':
        option[3] = true;
        break;
      case 't':
        option[4] = true;
        option[5] = true;
        break;
      case 'T':
        option[4] = true;
        break;
      case '?':
        flag = 1;
        break;
    }
  }
  return flag;
}