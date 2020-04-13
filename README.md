# mulle-scion

🌱 A modern template engine for Objective C

(written in an oldfashioned way)

This is the command-line tool for the  [MulleScion](//github.com/MulleWeb/MulleScion)
library. It also provides the documentation for the project in a
self-contained webserver.


Build Status | Release Version
-------------|-----------------------------------
[![Build Status](https://travis-ci.org/MulleWeb/MulleScion.svg?branch=release)](https://travis-ci.org/MulleWeb/MulleScion) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag/MulleWeb/MulleScion.svg) [![Build Status](https://travis-ci.org/MulleWeb/MulleScion.svg?branch=release)](https://travis-ci.org/MulleWeb/MulleScion)

> This is a fork of [mulle-kybernetik/MulleScion](//github.com/mulle-kybernetik/MulleScion)
> tailored for use in mulle-sde projects


## Usage

```
Usage:
   mulle-scion [options] <input> <datasource> [output] [arguments]

Options:
   -w       : start webserver for /usr/local/share/mulle-scion/dox
   -z       : write compressed archive to outputfile
   -Z       : write compressed keyed archive to outputfile (for IOS)

Input:
   -        : Read template from stdin
   template : a MulleScion template path or URL

Datasource:
   -        : Read data from stdin (only if input is not stdin already)
   args     : use arguments as datasource (see below)
   bundle   : a NSBundle. It's NSPrincipalClass will be used as the datasource
   plist    : a property list path or URL as datasource, see: plist(5)
   none     : empty datasource

Output:
   -        : Write result to stdout
   file     : Write result to file

Arguments:
   key=value: key/value pairs to be used as __ARGV__ contents
              (unless args as datasource was specified)

Examples:
   echo '***{{ VALUE }}***' | mulle-scion - args - VALUE="VfL Bochum 1848"
   echo '***{{ __ARGV__[ 0]}}***' | mulle-scion - none - "VfL Bochum 1848"
```


## About

MulleScion is **heavily** (very heavily) inspired by

[TWIG](//twig.sensiolabs.org/) "The flexible, fast, and secure template
engine for PHP"

*MulleScion* is fairly flexible, reasonably fast and can be made as
 secure as you wish.

* **Reasonably
Fast** :      *MulleScion* can compile templates into a compressed
               archive format. Loading such an archive ought to be lots faster
               than parsing (but because the parse is so fast, maybe isn't).
               A compiled template is read-only, you can use it many
               times to render different output from different input.

* **Secure** :   *MulleScion* has hooks so your application can ensure
               that untrusted template code doesn't have access to all of the
               applications data.

* **Flexible** :    There is the possibility of extending KVC and writing your
               own "builtin" fuctions. A template can (if allowed) execute
               arbitrary ObjC code. MulleScion has a powerful define like
               preprocessing capability and macros to expand your template
               vocabulary.

Here is a simple example, where ObjC code is embedded in a template:

``` twig
<html>
   <!-- rendered by {{ [[NSProcessInfo processInfo] processName] }} on
        {{ [NSDate date] }} -->
   <body>
     {% for item in [NSTimeZone knownTimeZoneNames] %}
         {% if item#.isFirst %}
         <table>
            <tr><th>TimeZone</th></tr>
         {% endif %}
            <tr><td>{{ item }}</td></tr>
         {% if item#.isLast %}
         </table>
         {% endif %}
      {% else %}
         Sorry, no timezone info available.
      {% endfor %}
   </body>
</html>
```

Using MulleScion the creation of a string from your
object using a template file is as easy as:

``` objective-c
   NSString  *output;

   output = [MulleScionTemplate descriptionWithTemplateFile:@"test.scion"
                                                 dataSource:self];
```

This is the general architecture of *MulleScion*

![](dox/MulleScionDataFlow.png "Data Flow Sketch")

*MulleScion* is happily used in a commercial project and has gone through
enough iterations to pronounce it "ready for production".


HTML PREPROCESSOR
=============
There is a companion project
[MulleScionHTMLPreprocessor](//github.com/MulleWeb/MulleScionHTMLPreprocessor)
that uses HTML like tags, to make the template easier to reformat in
HTML editors:

``` html
<html>
  <!-- rendered by {{ [[NSProcessInfo processInfo] processName] }} on
        {{ [NSDate date] }} -->
  <body>
    <for item in [NSTimeZone knownTimeZoneNames]>
      <if item#.isFirst>
        <table>
          <tr><th>TimeZone</th></tr>
      </if>
        <tr><td>{{ item }}</td></tr>
      <if item#.isLast>
        </table>
      </if>
    <else/>
      Sorry, no timezone info available.
    </for>
  </body>
</html>
```


Add
======

Use [mulle-sde](//github.com/mulle-sde) to add mulle-scion to your project:

```
mulle-sde dependency add --github MulleWeb mulle-scion
```


Install
=======

Use [mulle-sde](//github.com/mulle-sde) to build and install mulle-scion and
all its dependencies:

```
mulle-sde install --prefix /usr/local \
   https://github.com/MulleWeb/mulle-scion/archive/latest.tar.gz
```


DOCUMENTATION
=============

Virtually all the documentation is contained in example **.scion** templates
in the `dox` folder. For each command or feature there should be a separate
template file that documents it. **mulle-scion**, the command line utility,
contains  a small quickly hacked together webserver that can present the
documentation using *MulleScion* itself.


MulleScion is very similar to TWIG, so you can glean much of relevance from
<http://twig.sensiolabs.org>. If you see a feature in TWIG but don't see it in
the tests file, it's likely not there (but it's probably easily achieved some
other way (using a `define` or a `macro` or an ObjC category on **NSString**).


AUTHOR
=============
Coded by Nat!
2013-2020 Mulle kybernetiK

