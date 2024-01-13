#ifndef mulle_scion_version_h__
#define mulle_scion_version_h__

/*
 *  version:  major, minor, patch
 */
#define MULLE__SCION_VERSION  ((1860UL << 20) | (0 << 8) | 2)


static inline unsigned int   mulle_scion_get_version_major( void)
{
   return( MULLE__SCION_VERSION >> 20);
}


static inline unsigned int   mulle_scion_get_version_minor( void)
{
   return( (MULLE__SCION_VERSION >> 8) & 0xFFF);
}


static inline unsigned int   mulle_scion_get_version_patch( void)
{
   return( MULLE__SCION_VERSION & 0xFF);
}

#endif
