#include "smack.h"

struct _GString
{
  char  *str;
  int len;
  int allocated_len;
};

typedef struct _GString GString;

char demonic_char();

GString*
g_string_append_c_inline (GString *gstring,
                          char    c)
{
  c = demonic_char();
  if (gstring->len + 1 < gstring->allocated_len)
    {
      gstring->str[gstring->len++] = c;
      gstring->str[gstring->len] = 0;
    }
  else
    // comment out the following line gets rid of the bug
    g_string_insert_c (gstring, -1, c);
  return gstring;
}

