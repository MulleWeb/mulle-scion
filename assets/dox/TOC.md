# mulle-scion Library Documentation for AI

## 1. Introduction & Purpose

**mulle-scion** is the C implementation of the Scion template engine, providing core template parsing and rendering functionality. The Objective-C wrapper (MulleScion) builds on this C library, but mulle-scion can also be used directly in C/C++ projects.

This library is particularly useful for:
- Template rendering in C/C++ projects
- Embedding templating in C codebases
- Building custom template-based tools
- High-performance template processing

## 2. Key Concepts & Design Philosophy

- **Pure C**: No Objective-C dependencies
- **Embedded**: Designed for embedding in C projects
- **Efficient**: Minimal allocations, streaming output
- **Standard**: Django/Jinja2-inspired syntax

## 3. Core API & Data Structures

### Parser

- `scion_parser_t *scion_parser_new()`
  - Create new template parser

- `void scion_parser_parse(scion_parser_t *parser, const char *template)`
  - Parse template string

- `char *scion_parser_render(scion_parser_t *parser, scion_context_t *context)`
  - Render template with context

### Context

- `scion_context_t *scion_context_new()`
  - Create new template context

- `void scion_context_set_string(scion_context_t *ctx, const char *key, const char *value)`
  - Set string variable

- `void scion_context_set_number(scion_context_t *ctx, const char *key, double value)`
  - Set numeric variable

## 4. Performance Characteristics

- **Parsing**: O(n) single pass
- **Rendering**: O(n + m) where n = template, m = context
- **Memory**: Minimal allocation overhead

## 5. Integration Examples

### Example 1: Simple Template
```c
scion_parser_t *parser = scion_parser_new();
scion_context_t *ctx = scion_context_new();

scion_context_set_string(ctx, "name", "Alice");
const char *template = "Hello {{ name }}!";

char *result = scion_parser_render(parser, template, ctx);
printf("%s\n", result);
free(result);

scion_context_free(ctx);
scion_parser_free(parser);
```

### Example 2: Loop Template
```c
scion_parser_t *parser = scion_parser_new();
scion_context_t *ctx = scion_context_new();

const char *template = "{% for i in items %}{{ i }}{% endfor %}";
char *result = scion_parser_render(parser, template, ctx);
```

## 6. Dependencies

- Standard C library
- No external dependencies

## 7. Standards & References

- Based on Django template syntax
- Jinja2 inspiration

## 8. Version Information

mulle-scion version macro: `MULLE_SCION_VERSION`
