#include <string.h>
#include "smack.h"

#define EXT_LEN 3

int ends_in_dotpc (const char *str)
{
  int len = strlen (str);
 
  if (len > EXT_LEN &&
      str[len - 3] == '.' &&
      str[len - 2] == 'p' &&
      str[len - 1] == 'c')
    return 1;
  else
    return 0;
}
