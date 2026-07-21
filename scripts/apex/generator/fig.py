"""Extract a page sub-region from a CERMAT PDF into a compact, clean SVG.

Re-emits exact vector geometry (lines, beziers, rects) + text labels from
get_drawings()/get_text() so figures stay faithful but tiny (no font bloat),
and contain no apostrophes or backslashes (Apex-literal safe).
"""
import fitz


def _fmt(v):
    # integer coordinates keep the SVG compact; figures are ~200-460 units
    # wide so rounding to whole units is visually lossless
    return str(int(round(v)))


def region_svg(pdf, page_index, rect, pad=4, drop_fill_black_rects=False):
    d = fitz.open(pdf)
    pg = d[page_index]
    R = fitz.Rect(*rect)

    def inside(r):
        return r.x1 > R.x0 and r.x0 < R.x1 and r.y1 > R.y0 and r.y0 < R.y1

    draws = [p for p in pg.get_drawings() if inside(p["rect"])]
    # text spans
    spans = []
    for blk in pg.get_text("dict")["blocks"]:
        for ln in blk.get("lines", []):
            for sp in ln["spans"]:
                bb = fitz.Rect(sp["bbox"])
                cx, cy = (bb.x0 + bb.x1) / 2, (bb.y0 + bb.y1) / 2
                if R.x0 <= cx <= R.x1 and R.y0 <= cy <= R.y1 and sp["text"].strip():
                    spans.append((cx, bb.y1 - 1, sp["text"].strip(), sp["size"]))

    # bbox of actual content
    xs0 = [p["rect"].x0 for p in draws] + [s[0] - 3 for s in spans]
    ys0 = [p["rect"].y0 for p in draws] + [s[1] - 8 for s in spans]
    xs1 = [p["rect"].x1 for p in draws] + [s[0] + 6 * len(s[2]) for s in spans]
    ys1 = [p["rect"].y1 for p in draws] + [s[1] + 2 for s in spans]
    if not xs0:
        return None
    minx, miny = min(xs0) - pad, min(ys0) - pad
    maxx, maxy = max(xs1) + pad, max(ys1) + pad
    W, H = maxx - minx, maxy - miny

    def X(v):
        return _fmt(v - minx)

    def Y(v):
        return _fmt(v - miny)

    out = []
    out.append(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %s %s">'
        % (_fmt(W), _fmt(H))
    )
    # group path data by identical style so many same-styled segments
    # (gridlines, ticks) collapse into a single <path> element
    from collections import OrderedDict
    grouped = OrderedDict()
    for p in draws:
        items = p["items"]
        fill = p.get("fill")
        color = p.get("color")
        w = p.get("width") or 0.8

        def close_enough(a, b):
            return abs(a.x - b.x) < 0.2 and abs(a.y - b.y) < 0.2

        # Chain consecutive segments into continuous subpaths so filled
        # polygons are actually closed (a new M only starts when a segment
        # does not continue from the current point).
        segs = []
        cur = None
        for it in items:
            t = it[0]
            if t == "l":
                a, b = it[1], it[2]
                if cur is None or not close_enough(a, cur):
                    segs.append("M%s %s" % (X(a.x), Y(a.y)))
                segs.append("L%s %s" % (X(b.x), Y(b.y)))
                cur = b
            elif t == "c":
                a, b, c, e = it[1], it[2], it[3], it[4]
                if cur is None or not close_enough(a, cur):
                    segs.append("M%s %s" % (X(a.x), Y(a.y)))
                segs.append(
                    "C%s %s %s %s %s %s"
                    % (X(b.x), Y(b.y), X(c.x), Y(c.y), X(e.x), Y(e.y))
                )
                cur = e
            elif t == "re":
                r = it[1]
                segs.append(
                    "M%s %sL%s %sL%s %sL%s %sZ"
                    % (X(r.x0), Y(r.y0), X(r.x1), Y(r.y0),
                       X(r.x1), Y(r.y1), X(r.x0), Y(r.y1))
                )
                cur = None
            elif t == "qu":
                q = it[1]
                pts = [q.ul, q.ur, q.lr, q.ll]
                segs.append(
                    "M" + "L".join("%s %s" % (X(pt.x), Y(pt.y)) for pt in pts) + "Z"
                )
                cur = None
        if not segs:
            continue
        if fill is not None and not segs[-1].endswith("Z"):
            segs.append("Z")

        def rgb(c):
            return "#%02x%02x%02x" % tuple(int(round(x * 255)) for x in c)

        style = []
        style.append("fill:%s" % (rgb(fill) if fill is not None else "none"))
        if color is not None:
            style.append("stroke:%s;stroke-width:%s" % (rgb(color), _fmt(max(w, 0.6))))
        elif fill is None:
            style.append("stroke:#000;stroke-width:%s" % _fmt(max(w, 0.6)))
        st = ";".join(style)
        d_str = "".join(segs)
        # filled shapes must stay separate (merging would union fills wrongly);
        # only merge stroke-only (fill:none) paths that share a style
        key = st if fill is None else "%s#%d" % (st, id(p) + len(grouped))
        if key in grouped:
            grouped[key][0] += d_str
        else:
            grouped[key] = [d_str, st]
    for d_str, st in grouped.values():
        out.append('<path d="%s" style="%s"/>' % (d_str, st))
    for cx, by, txt, size in spans:
        t = txt.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
        out.append(
            '<text x="%s" y="%s" font-size="%s" fill="#000" text-anchor="middle" font-family="sans-serif">%s</text>'
            % (X(cx), Y(by), _fmt(size), t)
        )
    out.append("</svg>")
    return "".join(out)


if __name__ == "__main__":
    import sys, cairosvg
    svg = region_svg(*eval(sys.argv[1]))
    name = sys.argv[2]
    open("work/%s.svg" % name, "w").write(svg)
    cairosvg.svg2png(bytestring=svg.encode(), write_to="work/%s.png" % name,
                     output_width=500, background_color="white")
    print("%s : svg=%d chars" % (name, len(svg)))


def auto_rect(pdf, page_index, y_hint=None, pad=6):
    """Heuristic: bounding box of the figure (densest cluster of vector paths
    that are not full-width frame/separator lines). y_hint=(y0,y1) restricts
    the search band. Returns (x0,y0,x1,y1) or None."""
    d = fitz.open(pdf)
    pg = d[page_index]
    segs = []
    for p in pg.get_drawings():
        r = p["rect"]
        w, h = r.x1 - r.x0, r.y1 - r.y0
        if w > 360 and h < 3:      # horizontal separator / frame edge
            continue
        if h > 360 and w < 3:      # vertical frame edge
            continue
        if w > 420 and h > 300:    # the big outer "výchozí text" box
            continue
        if y_hint and (r.y0 < y_hint[0] or r.y1 > y_hint[1]):
            continue
        segs.append(r)
    if not segs:
        return None
    # cluster by y proximity: pick the band with most paths
    segs.sort(key=lambda r: r.y0)
    best = segs
    x0 = min(r.x0 for r in best) - pad
    y0 = min(r.y0 for r in best) - pad
    x1 = max(r.x1 for r in best) + pad
    y1 = max(r.y1 for r in best) + pad
    return (round(x0), round(y0), round(x1), round(y1))
