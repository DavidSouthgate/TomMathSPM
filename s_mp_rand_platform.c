#include "Vendor/tommath_private.h"
#ifdef S_MP_RAND_PLATFORM_C

#if !defined(S_READ_WINCSP_C) && !defined(MP_NO_DEV_URANDOM)
#define S_READ_URANDOM_C
#ifndef MP_DEV_URANDOM
#define MP_DEV_URANDOM "/dev/urandom"
#endif
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>

static mp_err s_read_urandom(void *p, size_t n)
{
   int fd;
   char *q = (char *)p;

   do {
      fd = open(MP_DEV_URANDOM, O_RDONLY);
   } while ((fd == -1) && (errno == EINTR));
   if (fd == -1) return MP_ERR;

   while (n > 0u) {
      ssize_t ret = read(fd, q, n);
      if (ret < 0) {
         if (errno == EINTR) {
            continue;
         }
         close(fd);
         return MP_ERR;
      }
      q += ret;
      n -= (size_t)ret;
   }

   close(fd);
   return MP_OKAY;
}
#endif

mp_err s_read_urandom(void *p, size_t n);

mp_err s_mp_rand_platform(void *p, size_t n)
{
   mp_err err = MP_ERR;
   if ((err != MP_OKAY) && MP_HAS(S_READ_URANDOM))    err = s_read_urandom(p, n);
   return err;
}

#endif
