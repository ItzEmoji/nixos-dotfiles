'use strict';

const BRACKET_PAIRS = { '{': '}', '(': ')', '[': ']' };
const CLOSERS = new Set(['}', ')', ']']);

function skipLineComment(text, i) {
  const nl = text.indexOf('\n', i);
  return nl === -1 ? text.length : nl + 1;
}

function skipBlockComment(text, i) {
  const end = text.indexOf('*/', i + 2);
  return end === -1 ? text.length : end + 2;
}

// Skip a Nix string literal starting at index i. Handles both "..." and
// ''...'' forms, including ${...} interpolation (recursively balanced) and
// the ''$ / ''' / ''\ escapes used inside indented strings.
function skipString(text, i) {
  if (text[i] === '"') {
    i++;
    while (i < text.length) {
      if (text[i] === '\\') { i += 2; continue; }
      if (text[i] === '"') return i + 1;
      if (text[i] === '$' && text[i + 1] === '{') {
        i = findMatchingClose(text, i + 1) + 1;
        continue;
      }
      i++;
    }
    return i;
  }
  // indented string: ''...''
  i += 2;
  while (i < text.length) {
    if (text[i] === "'" && text[i + 1] === "'") {
      const next = text[i + 2];
      if (next === '$' || next === "'" || next === '\\') { i += 3; continue; }
      return i + 2;
    }
    if (text[i] === '$' && text[i + 1] === '{') {
      i = findMatchingClose(text, i + 1) + 1;
      continue;
    }
    i++;
  }
  return i;
}

// text[openIndex] must be '{', '(', or '['. Returns the index of its
// matching closing bracket, skipping over comments and string literals.
function findMatchingClose(text, openIndex) {
  const stack = [BRACKET_PAIRS[text[openIndex]]];
  let i = openIndex + 1;
  while (i < text.length && stack.length > 0) {
    const ch = text[i];
    if (ch === '#') { i = skipLineComment(text, i); continue; }
    if (ch === '/' && text[i + 1] === '*') { i = skipBlockComment(text, i); continue; }
    if (ch === '"' || (ch === "'" && text[i + 1] === "'")) { i = skipString(text, i); continue; }
    if (ch === '{' || ch === '(' || ch === '[') { stack.push(BRACKET_PAIRS[ch]); i++; continue; }
    if (CLOSERS.has(ch)) { stack.pop(); i++; continue; }
    i++;
  }
  return i - 1;
}

function isWhitespace(ch) { return ch === ' ' || ch === '\t' || ch === '\n' || ch === '\r'; }

function skipWhitespaceAndComments(text, i) {
  while (i < text.length) {
    const ch = text[i];
    if (isWhitespace(ch)) { i++; continue; }
    if (ch === '#') { i = skipLineComment(text, i); continue; }
    if (ch === '/' && text[i + 1] === '*') { i = skipBlockComment(text, i); continue; }
    break;
  }
  return i;
}

function parseKeySegment(text, i) {
  i = skipWhitespaceAndComments(text, i);
  if (text[i] === '"') {
    const end = skipString(text, i);
    return { segment: text.slice(i, end), next: end };
  }
  const start = i;
  while (i < text.length && /[A-Za-z0-9_'-]/.test(text[i])) i++;
  return { segment: text.slice(start, i), next: i };
}

function parseKey(text, i) {
  const segments = [];
  let cur = i;
  while (true) {
    const { segment, next } = parseKeySegment(text, cur);
    if (!segment) break;
    segments.push(segment);
    cur = skipWhitespaceAndComments(text, next);
    if (text[cur] === '.') { cur++; continue; }
    break;
  }
  return { path: segments, next: cur };
}

function isWordBoundary(ch) {
  return ch === undefined || !/[A-Za-z0-9_'-]/.test(ch);
}

// Scans forward from `start` looking for `terminator` at "depth 0" — not
// inside brackets, strings/comments, AND not inside a `let ... in` binding
// section (a `let`'s own bindings can contain `;` characters that are NOT
// the statement terminator we're looking for, e.g. Rofi's
// `theme = let inherit (...) mkLiteral; in { ... };`). Tracks a `letDepth`
// counter alongside bracket-skipping so `;` only terminates once every
// opened `let` has been closed by its matching `in`.
//
// Also tracks a `withDepth` counter for the same reason: a `with EXPR;`
// prefix (e.g. `home.packages = with pkgs; [ btop jq ];`) has its own `;`
// separating the `with`-expression from the body, which is NOT the
// statement terminator either. Unlike `let ... in`, `with EXPR;` is closed
// by that very `;` rather than a keyword, so the first `;` seen while
// withDepth > 0 both closes the `with` clause (decrementing withDepth) and
// is consumed rather than treated as the terminator.
function scanValueToTerminator(text, start, terminator) {
  let j = start;
  let letDepth = 0;
  let withDepth = 0;
  while (j < text.length) {
    const ch = text[j];
    if (ch === '#') { j = skipLineComment(text, j); continue; }
    if (ch === '/' && text[j + 1] === '*') { j = skipBlockComment(text, j); continue; }
    if (ch === '"' || (ch === "'" && text[j + 1] === "'")) { j = skipString(text, j); continue; }
    if (ch === '{' || ch === '(' || ch === '[') { j = findMatchingClose(text, j) + 1; continue; }
    if (
      text.slice(j, j + 3) === 'let' &&
      isWordBoundary(text[j - 1]) &&
      isWordBoundary(text[j + 3])
    ) {
      letDepth++;
      j += 3;
      continue;
    }
    if (
      text.slice(j, j + 2) === 'in' &&
      isWordBoundary(text[j - 1]) &&
      isWordBoundary(text[j + 2]) &&
      letDepth > 0
    ) {
      letDepth--;
      j += 2;
      continue;
    }
    if (
      text.slice(j, j + 4) === 'with' &&
      isWordBoundary(text[j - 1]) &&
      isWordBoundary(text[j + 4])
    ) {
      withDepth++;
      j += 4;
      continue;
    }
    if (ch === ';' && withDepth > 0) {
      withDepth--;
      j++;
      continue;
    }
    if (ch === terminator && letDepth === 0) break;
    j++;
  }
  return j;
}

// Parses a sequence of `key = value;` statements out of `bodyText`. Stops
// as soon as it hits a statement it can't recognize as `key = value;` — most
// notably an `inherit foo;` / `inherit (pkg) foo bar;` statement, which has
// no `=`. Returns both the entries successfully parsed AND whatever
// non-whitespace text is left starting from the statement that broke
// parsing, so callers can surface it instead of silently losing it (see
// `extractConfigRows`, which turns non-empty `unparsed` into a visible blob
// row rather than dropping the rest of the attrset on the floor).
function parseAttrsetEntries(bodyText) {
  const entries = [];
  let i = 0;
  while (true) {
    i = skipWhitespaceAndComments(bodyText, i);
    if (i >= bodyText.length) return { entries, unparsed: '' };
    const stmtStart = i;
    const { path, next } = parseKey(bodyText, i);
    if (path.length === 0) {
      return { entries, unparsed: bodyText.slice(stmtStart).trim() };
    }
    let k = skipWhitespaceAndComments(bodyText, next);
    if (bodyText[k] !== '=') {
      return { entries, unparsed: bodyText.slice(stmtStart).trim() };
    }
    k++;
    const valueStart = skipWhitespaceAndComments(bodyText, k);
    const valueEnd = scanValueToTerminator(bodyText, valueStart, ';');
    const valueText = bodyText.slice(valueStart, valueEnd).trim();
    entries.push({ key: path.join('.'), valueText });
    i = valueEnd + 1;
  }
}

function valueIsAttrsetLiteral(valueText) {
  const trimmed = valueText.trim();
  if (!trimmed.startsWith('{')) return false;
  const close = findMatchingClose(trimmed, 0);
  return trimmed.slice(close + 1).trim() === '';
}

function collapseWhitespace(text) {
  return text.replace(/\s+/g, ' ').trim();
}

function extractConfigRows(bodyText, opts = {}) {
  const maxDepth = opts.maxDepth === undefined ? 4 : opts.maxDepth;
  const rows = [];
  function walk(text, prefix, depth) {
    const { entries, unparsed } = parseAttrsetEntries(text);
    for (const { key, valueText } of entries) {
      if (key === 'imports') continue;
      const path = prefix ? `${prefix}.${key}` : key;
      if (depth < maxDepth && valueIsAttrsetLiteral(valueText)) {
        const inner = valueText.trim();
        const close = findMatchingClose(inner, 0);
        walk(inner.slice(1, close), path, depth + 1);
      } else {
        rows.push({ path, value: collapseWhitespace(valueText) });
      }
    }
    // `parseAttrsetEntries` stopped early (e.g. hit an `inherit ...;`
    // statement it can't parse as `key = value;`). Rather than silently
    // dropping the remainder of this attrset, surface it as one visible
    // blob row so it still shows up in the generated table.
    if (unparsed) {
      const path = prefix ? `${prefix}.<unparsed>` : '<unparsed>';
      rows.push({ path, value: collapseWhitespace(unparsed) });
    }
  }
  walk(bodyText, '', 0);
  return rows;
}

// Unwraps leading `let <bindings> in <expr>` wrapping (the wrapper-module
// pattern of `{ args }: let confFile = ...; in { ... };`), returning the
// text after the top-level `in`. Returns the input unchanged if it doesn't
// start with `let` or the matching `in` can't be found.
function unwrapLetIn(text) {
  let t = text.trim();
  while (/^let(\s|#|\/\*|$)/.test(t)) {
    let i = 3;
    let nestedLetDepth = 0;
    let found = -1;
    while (i < t.length) {
      const ch = t[i];
      if (ch === '#') { i = skipLineComment(t, i); continue; }
      if (ch === '/' && t[i + 1] === '*') { i = skipBlockComment(t, i); continue; }
      if (ch === '"' || (ch === "'" && t[i + 1] === "'")) { i = skipString(t, i); continue; }
      if (ch === '{' || ch === '(' || ch === '[') { i = findMatchingClose(t, i) + 1; continue; }
      if (
        t.slice(i, i + 3) === 'let' &&
        isWordBoundary(t[i - 1]) &&
        isWordBoundary(t[i + 3])
      ) {
        nestedLetDepth++;
        i += 3;
        continue;
      }
      if (
        t.slice(i, i + 2) === 'in' &&
        isWordBoundary(t[i - 1]) &&
        isWordBoundary(t[i + 2])
      ) {
        if (nestedLetDepth > 0) { nestedLetDepth--; i += 2; continue; }
        found = i;
        break;
      }
      i++;
    }
    if (found === -1) return t;
    t = t.slice(found + 2).trim();
  }
  return t;
}

const REGISTRY_KEYS = ['nixosModules', 'homeManagerModules', 'wrappers'];

function findModuleAssignments(fileText) {
  const results = [];
  for (const registry of REGISTRY_KEYS) {
    const marker = `flake.${registry}.`;
    let searchFrom = 0;
    while (true) {
      const idx = fileText.indexOf(marker, searchFrom);
      if (idx === -1) break;
      const { segment: name, next: afterName } = parseKeySegment(fileText, idx + marker.length);
      let i = skipWhitespaceAndComments(fileText, afterName);
      if (fileText[i] !== '=') { searchFrom = idx + marker.length; continue; }
      i++;
      const rhsStart = skipWhitespaceAndComments(fileText, i);
      const rhsEnd = scanValueToTerminator(fileText, rhsStart, ';');
      const rhs = fileText.slice(rhsStart, rhsEnd).trim();
      // We recognize the standard `{ args }: { body }` module-lambda shape.
      // Anything else (e.g. a reference to an existing binding, a function
      // call, or some other expression) is NOT silently skipped — it's
      // still recorded, with `bodyText: null`, so a caller like
      // gen-configured-options.js can warn about it by name instead of the
      // registration just vanishing with no signal.
      let bodyText = null;
      if (rhs[0] === '{') {
        const argsClose = findMatchingClose(rhs, 0);
        const k = skipWhitespaceAndComments(rhs, argsClose + 1);
        if (rhs[k] === ':') {
          let body = rhs.slice(k + 1).trim();
          body = unwrapLetIn(body);
          if (body[0] === '{') {
            const bodyClose = findMatchingClose(body, 0);
            bodyText = body.slice(1, bodyClose);
          }
        }
      }
      results.push({ registry, name, bodyText });
      searchFrom = rhsEnd + 1;
    }
  }
  return results;
}

module.exports = {
  findMatchingClose,
  skipString,
  parseAttrsetEntries,
  extractConfigRows,
  findModuleAssignments,
};
