#ifndef SRC_S21_CAT_H_
#define SRC_S21_CAT_H_

#include <stdio.h>
#include <string.h>

#define false 0
#define true 1
int command_analyser(char *argv[], int *option);
int more_flags(int *option, char *argv);
int single_flag(int *option, char *argv);
int s21_mycat(char *argv[], int mainflag, const int *option);
void m_code(int c);

#endif  // SRC_CAT_S21_CAT_H_