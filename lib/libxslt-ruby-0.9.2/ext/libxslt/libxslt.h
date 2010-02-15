/* $Id: libxslt.h 43 2007-12-07 12:38:59Z transami $ */

/* Please see the LICENSE file for copyright and distribution information */

#ifndef __RUBY_LIBXSLT_H__
#define __RUBY_LIBXSLT_H__

#include <ruby.h>
#include <rubyio.h>
#include <libxml/parser.h>
#include <libxml/debugXML.h>
#include <libxslt/extra.h>
#include <libxslt/xslt.h>
#include <libxslt/xsltInternals.h>
#include <libxslt/transform.h>
#include <libxslt/xsltutils.h>
#include <libexslt/exslt.h>

#include "ruby_xslt_stylesheet.h"

#include "version.h"

extern VALUE cLibXSLT;
extern VALUE cXSLT;
extern VALUE eXSLTError;

#endif
