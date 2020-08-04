#include "smack.h"

struct _GString
{
  char  *str;
  int len;
};

typedef struct _GString GString;

char demonic_char();

int zero()
{return 0;}

GString*
g_string_append_c_inline (GString *gstring,
                          char    c)
{
  //c = demonic_char();
  if (zero())
    gstring->str = gstring;
  gstring->str[0] = c;
  gstring->str[0] = 1;
  return gstring;
}

