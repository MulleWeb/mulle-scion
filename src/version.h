#ifndef mulle_scion_version_h__
#define mulle_scion_version_h__

/*
 *  version:  major, minor, patch
 */
#define MULLE_SCION_VERSION  ((1859 << 20) | (1 << 8) | 6)


static inline unsigned int   mulle_scion_get_version_major( void)
{
   return( MULLE_SCION_VERSION >> 20);
}


static inline unsigned int   mulle_scion_get_version_minor( void)
{
   return( (MULLE_SCION_VERSION >> 8) & 0xFFF);
}


static inline unsigned int   mulle_scion_get_version_patch( void)
{
   return( MULLE_SCION_VERSION & 0xFF);
}

#endif
