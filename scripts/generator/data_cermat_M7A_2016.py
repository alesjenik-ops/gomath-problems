# -*- coding: utf-8 -*-
# CERMAT – Přijímací zkoušky 2016 (pilotní ročník), MATEMATIKA 7 (šestileté obory, 7. ročník), jeden termín.
# Kód testu: M7PZD16C0T01. 17 úloh v testu (po rozdělení nezávislých podúloh 3.1/3.2 a 4.1/4.2
# celkem 19 záznamů), 50 bodů.
# Zdroj odpovědí: klíč správných řešení (KSR) + záznamový arch (VZA).

import math

# ---- SVG obrázky (bez ' a \ ) ----

_ARR = ('<defs><marker id="sip" markerWidth="9" markerHeight="9" refX="8" refY="3" orient="auto">'
        '<path d="M0,0 L8,3 L0,6 z" fill="#000"/></marker></defs>')


# úloha 5: schéma rozdělení 75 žáků (dívky : chlapci = 8 : 7; 7. A, 7. B, 7. C)
def _schema5():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 350" font-family="sans-serif">', _ARR]
    ov = ('<ellipse cx="{}" cy="{}" rx="{}" ry="24" fill="#fff" stroke="#000" stroke-width="2"/>')
    s.append(ov.format(180, 72, 56))
    s.append(ov.format(380, 72, 56))
    s.append('<text x="180" y="34" font-size="18" text-anchor="middle" font-weight="bold">dívky</text>')
    s.append('<text x="380" y="34" font-size="18" text-anchor="middle" font-weight="bold">chlapci</text>')
    s.append('<text x="280" y="72" font-size="16" text-anchor="middle">8 : 7</text>')
    s.append(ov.format(280, 172, 52))
    s.append('<text x="280" y="178" font-size="16" text-anchor="middle">75 žáků</text>')
    for x2, y2 in ((208, 92), (352, 92)):
        s.append('<line x1="280" y1="150" x2="{}" y2="{}" stroke="#000" stroke-width="2" marker-end="url(#sip)"/>'.format(x2, y2))
    s.append('<text x="150" y="212" font-size="15" text-anchor="middle">z nich 1/3</text>')
    for cx, lx, lab in ((120, 120, "7. A"), (280, 232, "7. B"), (440, 440, "7. C")):
        s.append(ov.format(cx, 296, 52))
        s.append('<text x="{}" y="256" font-size="18" text-anchor="middle" font-weight="bold">{}</text>'.format(lx, lab))
    for x2, y2 in ((150, 276), (280, 268), (410, 276)):
        s.append('<line x1="280" y1="196" x2="{}" y2="{}" stroke="#000" stroke-width="2" marker-end="url(#sip)"/>'.format(x2, y2))
    s.append('<line x1="388" y1="306" x2="336" y2="306" stroke="#000" stroke-width="2" marker-end="url(#sip)"/>')
    s.append('<text x="362" y="332" font-size="15" text-anchor="middle">+ 4</text>')
    s.append('</svg>')
    return "".join(s)


SVG5 = _schema5()


# úloha 9: těleso slepené ze dvou shodných kvádrů 3 x 3 x 5 cm
def _teleso():
    dx, dy = 38, -28
    A = (60, 170); Bp = (60, 70); C = (120, 70); D = (120, 110); E = (220, 110); F = (220, 170)
    pts = [A, Bp, C, D, E, F]
    bk = [(p[0] + dx, p[1] + dy) for p in pts]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 210" font-family="sans-serif">']
    s.append('<polygon points="{}" fill="#f2f2f2" stroke="#000" stroke-width="2"/>'.format(
        " ".join("{},{}".format(p[0], p[1]) for p in pts)))
    s.append('<polyline points="{}" fill="none" stroke="#000" stroke-width="2"/>'.format(
        " ".join("{},{}".format(p[0], p[1]) for p in bk[1:])))
    for i in (1, 2, 3, 4, 5):
        s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#000" stroke-width="2"/>'.format(
            pts[i][0], pts[i][1], bk[i][0], bk[i][1]))
    s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#888" stroke-width="1.5" stroke-dasharray="5,4"/>'.format(
        A[0], A[1], bk[0][0], bk[0][1]))
    s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#888" stroke-width="1.5" stroke-dasharray="5,4"/>'.format(
        bk[0][0], bk[0][1], bk[1][0], bk[1][1]))
    s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#888" stroke-width="1.5" stroke-dasharray="5,4"/>'.format(
        bk[0][0], bk[0][1], bk[5][0], bk[5][1]))
    s.append('<text x="46" y="126" font-size="14" text-anchor="end">5 cm</text>')
    s.append('<text x="176" y="104" font-size="14" text-anchor="middle">5 cm</text>')
    s.append('<text x="266" y="146" font-size="14">3 cm</text>')
    s.append('<text x="240" y="186" font-size="14">3 cm</text>')
    s.append('<text x="140" y="192" font-size="14" text-anchor="middle">8 cm</text>')
    s.append('</svg>')
    return "".join(s)


SVG9 = _teleso()

# úloha 10: přímka AB a bod U mimo ni
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 280" font-family="sans-serif">
<line x1="40" y1="80" x2="470" y2="230" stroke="#000" stroke-width="2"/>
<line x1="99" y1="112" x2="121" y2="96" stroke="#000" stroke-width="2"/>
<line x1="379" y1="212" x2="401" y2="196" stroke="#000" stroke-width="2"/>
<text x="104" y="130" font-size="17" font-style="italic">A</text>
<text x="384" y="230" font-size="17" font-style="italic">B</text>
<text x="326" y="146" font-size="17" font-style="italic">U</text>
<text x="324" y="164" font-size="16">×</text>
</svg>"""


# úloha 12: obdélník ABCD 6 x 3 na čtvercové síti, oddělené trojúhelníky AFD a BCE
def _sit12():
    c = 40; ox, oy = 60, 40; W, H = 6, 3
    D = (ox, oy); C = (ox + W * c, oy); A = (ox, oy + H * c); Bp = (ox + W * c, oy + H * c)
    F = (ox + c, oy); E = (ox + 4 * c, oy)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 230" font-family="sans-serif">']
    s.append('<polygon points="{},{} {},{} {},{}" fill="#c9c9c9"/>'.format(A[0], A[1], F[0], F[1], D[0], D[1]))
    s.append('<polygon points="{},{} {},{} {},{}" fill="#c9c9c9"/>'.format(Bp[0], Bp[1], C[0], C[1], E[0], E[1]))
    for i in range(W + 1):
        s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#999" stroke-width="1"/>'.format(
            ox + i * c, oy, ox + i * c, oy + H * c))
    for j in range(H + 1):
        s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#999" stroke-width="1"/>'.format(
            ox, oy + j * c, ox + W * c, oy + j * c))
    s.append('<rect x="{}" y="{}" width="{}" height="{}" fill="none" stroke="#000" stroke-width="2"/>'.format(
        ox, oy, W * c, H * c))
    s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#000" stroke-width="2"/>'.format(A[0], A[1], F[0], F[1]))
    s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#000" stroke-width="2"/>'.format(E[0], E[1], Bp[0], Bp[1]))
    lab = [(D, "D", -10, -10), (F, "F", -4, -10), (E, "E", -4, -10), (C, "C", 4, -10),
           (A, "A", -14, 22), (Bp, "B", 6, 22)]
    for p, t, ddx, ddy in lab:
        s.append('<text x="{}" y="{}" font-size="17" font-style="italic">{}</text>'.format(p[0] + ddx, p[1] + ddy, t))
    s.append('</svg>')
    return "".join(s)


SVG12 = _sit12()


# úloha 13: trojúhelník ABC rozdělený na dva rovnoramenné trojúhelníky
def _troj13():
    A = (60.0, 220.0); Bp = (480.0, 220.0); C = (149.0, 37.0); D = (264.0, 220.0)

    def uni(p, q):
        vx, vy = q[0] - p[0], q[1] - p[1]
        d = math.hypot(vx, vy)
        return (vx / d, vy / d)

    def arc(v, p1, p2, r):
        u1 = uni(v, p1); u2 = uni(v, p2)
        a1 = math.atan2(u1[1], u1[0]); a2 = math.atan2(u2[1], u2[0])
        dd = (a2 - a1) % (2 * math.pi)
        sw = 1 if dd < math.pi else 0
        x1 = v[0] + r * math.cos(a1); y1 = v[1] + r * math.sin(a1)
        x2 = v[0] + r * math.cos(a2); y2 = v[1] + r * math.sin(a2)
        return '<path d="M {:.1f},{:.1f} A {},{} 0 0 {} {:.1f},{:.1f}" fill="none" stroke="#000" stroke-width="1.6"/>'.format(
            x1, y1, r, r, sw, x2, y2)

    def lbl(v, p1, p2, r, txt, sz=16):
        u1 = uni(v, p1); u2 = uni(v, p2)
        mx, my = u1[0] + u2[0], u1[1] + u2[1]
        d = math.hypot(mx, my)
        x = v[0] + r * mx / d; y = v[1] + r * my / d + 5
        return '<text x="{:.1f}" y="{:.1f}" font-size="{}" text-anchor="middle">{}</text>'.format(x, y, sz, txt)

    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 262" font-family="sans-serif">']
    for p, q in ((A, Bp), (A, C), (C, Bp), (C, D)):
        s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#000" stroke-width="2"/>'.format(
            p[0], p[1], q[0], q[1]))
    s.append(arc(A, Bp, C, 44) + lbl(A, Bp, C, 62, "α"))
    s.append(arc(Bp, C, A, 44) + lbl(Bp, C, A, 64, "29°", 15))
    s.append(arc(C, A, D, 36) + lbl(C, A, D, 52, "φ"))
    s.append(arc(C, D, Bp, 30) + lbl(C, D, Bp, 48, "29°", 15))
    s.append(arc(D, C, Bp, 34) + lbl(D, C, Bp, 50, "φ"))
    s.append('<text x="143" y="26" font-size="17" font-style="italic">C</text>')
    s.append('<text x="40" y="240" font-size="17" font-style="italic">A</text>')
    s.append('<text x="492" y="234" font-size="17" font-style="italic">B</text>')
    s.append('</svg>')
    return "".join(s)


SVG13 = _troj13()


# úloha 15: sloupcový graf vývoje ceny výrobku (120, 100, 80, 60 Kč)
def _graf15():
    vals = [(120, "1. čtvrtletí"), (100, "2. čtvrtletí"), (80, "3. čtvrtletí"), (60, "4. čtvrtletí")]
    y0 = 262; k = 220.0 / 120.0; x0 = 96
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 310" font-family="sans-serif">']
    s.append('<text x="300" y="26" font-size="18" text-anchor="middle" font-weight="bold">Vývoj cen výrobku</text>')
    for v in range(0, 121, 20):
        y = y0 - v * k
        s.append('<line x1="{}" y1="{:.0f}" x2="510" y2="{:.0f}" stroke="#bbb" stroke-width="1"/>'.format(x0, y, y))
        s.append('<text x="{}" y="{:.0f}" font-size="14" text-anchor="end">{}</text>'.format(x0 - 10, y + 5, v))
    s.append('<text x="46" y="{}" font-size="15">Kč</text>'.format(y0 - 105))
    s.append('<line x1="{}" y1="40" x2="{}" y2="{}" stroke="#000" stroke-width="1.5"/>'.format(x0, x0, y0))
    s.append('<line x1="{}" y1="{}" x2="510" y2="{}" stroke="#000" stroke-width="1.5"/>'.format(x0, y0, y0))
    cx = x0 + 50
    for v, lab in vals:
        h = v * k
        s.append('<rect x="{:.0f}" y="{:.0f}" width="60" height="{:.0f}" fill="#a3a3a3" stroke="#000" stroke-width="1.5"/>'.format(
            cx - 30, y0 - h, h))
        s.append('<text x="{}" y="{}" font-size="14" text-anchor="middle">{}</text>'.format(cx, y0 + 24, lab))
        cx += 104
    s.append('</svg>')
    return "".join(s)


SVG15 = _graf15()


# úloha 17: čtverce s tmavými čtverečky (strana 4 cm) na obou úhlopříčkách
def _ctverce17():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 264" font-family="sans-serif">']
    c = 22; ox, oy = 30, 76; n = 5
    for i in range(n):
        for j in set([i, n - 1 - i]):
            s.append('<rect x="{}" y="{}" width="{}" height="{}" fill="#bdbdbd"/>'.format(ox + j * c, oy + i * c, c, c))
    for i in range(n + 1):
        s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#666" stroke-width="1"/>'.format(
            ox + i * c, oy, ox + i * c, oy + n * c))
        s.append('<line x1="{}" y1="{}" x2="{}" y2="{}" stroke="#666" stroke-width="1"/>'.format(
            ox, oy + i * c, ox + n * c, oy + i * c))
    s.append('<rect x="{}" y="{}" width="{}" height="{}" fill="none" stroke="#000" stroke-width="2"/>'.format(
        ox, oy, n * c, n * c))
    c2 = 20; ox2, oy2 = 250, 22; m = 11
    for i in (0, 1, 2, 5, 8, 9, 10):
        for j in set([i, m - 1 - i]):
            s.append('<rect x="{}" y="{}" width="{}" height="{}" fill="#bdbdbd" stroke="#555" stroke-width="1"/>'.format(
                ox2 + j * c2, oy2 + i * c2, c2, c2))
    for i in (3, 4, 6, 7):
        for j in set([i, m - 1 - i]):
            s.append('<circle cx="{}" cy="{}" r="2.5" fill="#333"/>'.format(
                ox2 + j * c2 + c2 / 2, oy2 + i * c2 + c2 / 2))
    s.append('<rect x="{}" y="{}" width="{}" height="{}" fill="none" stroke="#000" stroke-width="2"/>'.format(
        ox2, oy2, m * c2, m * c2))
    s.append('</svg>')
    return "".join(s)


SVG17 = _ctverce17()

B = ['zs2', 'r7']

PROBLEMS = [
    {'name': 'CERMAT M7A 2016 – úloha 1', 'zad': [
        'Vypočtěte:', '$0{,}01\\cdot 1000+10\\cdot\\frac{1}{0{,}1}=$'], 'opts': None, 'ln': 2,
     'sol': ['$0{,}01\\cdot 1000=10$ a $\\frac{1}{0{,}1}=10$.', 'Celkem $10+10\\cdot 10=10+100=110$.'],
     'ans': '$110$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 2', 'zad': [
        'Vypočtěte, kolikrát je třeba k číslu $820$ přičíst číslo $10$, abychom získali číslo $8\\,200$.'],
     'opts': None, 'ln': 2,
     'sol': ['Přičíst je třeba celkem $8\\,200-820=7\\,380$.', 'Počet přičtení: $7\\,380:10=738$.'],
     'ans': '$738$krát', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek uveďte zlomkem v základním tvaru. Uveďte postup řešení.',
        '$0{,}2\\cdot\\left(\\frac{1}{9}+\\frac{7}{12}\\right)-\\frac{1}{4}=$'], 'opts': None, 'ln': 5,
     'sol': ['V závorce: $\\frac{1}{9}+\\frac{7}{12}=\\frac{4}{36}+\\frac{21}{36}=\\frac{25}{36}$.',
             'Součin: $0{,}2\\cdot\\frac{25}{36}=\\frac{1}{5}\\cdot\\frac{25}{36}=\\frac{5}{36}$.',
             'Rozdíl: $\\frac{5}{36}-\\frac{1}{4}=\\frac{5}{36}-\\frac{9}{36}=-\\frac{4}{36}=-\\frac{1}{9}$.'],
     'ans': '$-\\frac{1}{9}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek uveďte zlomkem v základním tvaru. Uveďte postup řešení.',
        '$\\frac{\\frac{1}{2}-\\left(\\frac{2}{3}-\\frac{5}{6}\\right)}{\\frac{1}{2}}=$'], 'opts': None, 'ln': 5,
     'sol': ['V závorce: $\\frac{2}{3}-\\frac{5}{6}=\\frac{4}{6}-\\frac{5}{6}=-\\frac{1}{6}$.',
             'Čitatel: $\\frac{1}{2}-\\left(-\\frac{1}{6}\\right)=\\frac{3}{6}+\\frac{1}{6}=\\frac{4}{6}=\\frac{2}{3}$.',
             'Podíl: $\\frac{2}{3}:\\frac{1}{2}=\\frac{2}{3}\\cdot 2=\\frac{4}{3}$.'],
     'ans': '$\\frac{4}{3}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 4.1', 'zad': [
        'Zapište převrácené číslo k číslu $2\\frac{1}{3}$.'], 'opts': None, 'ln': 2,
     'sol': ['Smíšené číslo převedeme na zlomek: $2\\frac{1}{3}=\\frac{7}{3}$.',
             'Převrácené číslo vznikne záměnou čitatele a jmenovatele: $\\frac{3}{7}$.'],
     'ans': '$\\frac{3}{7}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 4.2', 'zad': [
        'Vypočtěte číslo, které musíme odečíst od čísla $2\\frac{1}{3}$, abychom dostali číslo opačné k číslu $2\\frac{1}{3}$.'],
     'opts': None, 'ln': 2,
     'sol': ['$2\\frac{1}{3}=\\frac{7}{3}$, číslo opačné je $-\\frac{7}{3}$.',
             'Hledáme $x$ tak, aby $\\frac{7}{3}-x=-\\frac{7}{3}$, tedy $x=\\frac{7}{3}+\\frac{7}{3}=\\frac{14}{3}$.'],
     'ans': '$\\frac{14}{3}$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 5', 'zad': [
        'Ve třech sedmých třídách je celkem 75 žáků. Počty dívek a chlapců jsou v poměru $8:7$. Počet žáků třídy 7. A tvoří třetinu všech žáků sedmých tříd. Ve třídě 7. B je o čtyři žáky více než ve třídě 7. C.',
        'Vypočtěte:', '5.1 celkový počet chlapců v 7. třídách;', '5.2 počet žáků v 7. C.'],
     'opts': None, 'ln': 3, 'svg': SVG5, 'fn': 'schema-zaci.svg',
     'alt': 'Schéma: 75 žáků se dělí na dívky a chlapce v poměru 8 ku 7 a na třídy 7. A, 7. B a 7. C, přičemž 7. A tvoří třetinu a 7. B má o 4 žáky více než 7. C.',
     'cap': 'Schéma rozdělení 75 žáků sedmých tříd',
     'sol': ['5.1 Poměr $8:7$ znamená $8+7=15$ dílů, na jeden díl připadá $75:15=5$ žáků. Chlapců je $7\\cdot 5=35$.',
             '5.2 Ve 7. A je $75:3=25$ žáků, ve 7. B a 7. C dohromady $75-25=50$ žáků.',
             'Je-li ve 7. C $x$ žáků, pak $x+(x+4)=50$, tedy $2x=46$ a $x=23$.'],
     'ans': '5.1: $35$ chlapců; 5.2: $23$ žáků', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2016 – úloha 6', 'zad': [
        'Na lanové dráze jezdí mezi horní a dolní stanicí dvě kabiny proti sobě. Z obou míst vyjíždějí kabiny ve stejném okamžiku a míjejí se pravidelně v polovině doby jízdy.',
        'Hodiny ukazují 16:38 a kabiny se minuly před 3 minutami. Do stanic přijedou v 16:40, tam setrvají 5 minut a pak je čeká poslední jízda zpět.',
        '6.1 Vypočtěte, jak dlouho trvá jízda kabiny mezi horní a dolní stanicí.',
        '6.2 Určete přesný čas, kdy se kabiny minou při jízdě zpět.'], 'opts': None, 'ln': 3,
     'sol': ['6.1 Kabiny se minuly v $16{:}38-3$ min, tedy v 16:35. Do stanic přijedou v 16:40, druhá polovina jízdy tak trvá 5 minut. Celá jízda trvá $2\\cdot 5=10$ minut.',
             '6.2 Zpět vyjedou v $16{:}40+5$ min $=16{:}45$. Minou se v polovině jízdy, tj. po 5 minutách – v 16:50.'],
     'ans': '6.1: $10$ minut; 6.2: v 16:50', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2016 – úloha 7', 'zad': [
        'Karel stavěl věže z kostek. Když na každou věž použil 6 kostek, žádná kostka mu nezbyla. Když vše zboural a na každou novou věž použil 8 kostek, také mu žádná kostka nezbyla.',
        'Karel stavěl z více než 60 a méně než ze 100 kostek.',
        'Vypočtěte, z kolika kostek mohl Karel stavět. Uveďte všechny možnosti.'], 'opts': None, 'ln': 3,
     'sol': ['Počet kostek musí být dělitelný 6 i 8, je to tedy násobek nejmenšího společného násobku čísel 6 a 8, tj. násobek čísla $24$.',
             'Násobky čísla 24 větší než 60 a menší než 100 jsou $72$ a $96$.'],
     'ans': '$72$ kostek; $96$ kostek', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2016 – úloha 8', 'zad': [
        'Cesta na nádraží po silnici je dlouhá 1 500 m a Mirkovi trvala 20 minut. Nyní Mirek chodí lesní pěšinou, a cestu si tak zkrátil o 225 m.',
        'Mirek chodí stále stejně rychle. Délka každého jeho kroku je $\\frac{3}{4}$ metru.',
        'Uveďte postup řešení.',
        '8.1 Vypočtěte, o kolik kroků si Mirek zkrátil cestu na nádraží.',
        '8.2 Vypočtěte, o kolik minut si Mirek zkrátil cestu na nádraží.'], 'opts': None, 'ln': 4,
     'sol': ['8.1 Počet kroků na 225 m: $225:\\frac{3}{4}=225\\cdot\\frac{4}{3}=300$ kroků.',
             '8.2 Mirek ujde za minutu $1\\,500:20=75$ metrů, tedy $225:75=3$ minuty.'],
     'ans': '8.1: o $300$ kroků; 8.2: o $3$ minuty', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2016 – úloha 9', 'zad': [
        'Těleso je slepeno ze dvou shodných kvádrů s délkami hran 3 cm, 3 cm a 5 cm (viz obrázek).',
        'Uveďte postup řešení.',
        '9.1 Vypočtěte v cm³ objem slepeného tělesa.',
        '9.2 Vypočtěte v cm² povrch slepeného tělesa.'], 'opts': None, 'ln': 4,
     'svg': SVG9, 'fn': 'teleso-kvadry.svg',
     'alt': 'Těleso slepené ze dvou shodných kvádrů 3 krát 3 krát 5 cm; stojící kvádr je vysoký 5 cm, ležící kvádr je vysoký 3 cm, celková délka je 8 cm a hloubka 3 cm.',
     'cap': 'Těleso slepené ze dvou shodných kvádrů',
     'sol': ['9.1 Objem jednoho kvádru je $3\\cdot 3\\cdot 5=45$ cm³, objem tělesa je $2\\cdot 45=90$ cm³.',
             '9.2 Povrch jednoho kvádru: $2\\cdot(3\\cdot 3+3\\cdot 5+3\\cdot 5)=2\\cdot 39=78$ cm², oba dohromady $156$ cm².',
             'Slepením se skryjí dvě čtvercové plochy o obsahu $3\\cdot 3=9$ cm², proto $S=156-2\\cdot 9=138$ cm².'],
     'ans': '9.1: $90$ cm³; 9.2: $138$ cm²', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 10 (konstrukce)', 'zad': [
        'V rovině leží přímka $AB$ a mimo ni bod $U$ (viz obrázek).',
        '10.1 Sestrojte chybějící vrchol $C$ trojúhelníku $ABC$, jestliže velikost úhlu $ABC$ je $\\beta=70^\\circ$, strana $BC$ má délku 8 cm a bod $U$ leží uvnitř trojúhelníku $ABC$. Trojúhelník $ABC$ narýsujte.',
        '10.2 Sestrojte osu úsečky $AB$ a označte ji $o$.',
        '10.3 Sestrojte chybějící vrchol $D$ rovnoramenného lichoběžníku $ABCD$ se základnami $AB$, $CD$ a lichoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'primka-ab-bod-u.svg',
     'alt': 'Přímka procházející body A a B a bod U ležící mimo tuto přímku.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['10.1 V bodě $B$ naneseme od polopřímky $BA$ úhel velikosti $70^\\circ$ do poloroviny, v níž leží bod $U$. Na jeho rameni naneseme $|BC|=8$ cm a získáme vrchol $C$; narýsujeme trojúhelník $ABC$.',
             '10.2 Osa $o$ úsečky $AB$ je kolmice k $AB$ procházející jejím středem.',
             '10.3 Rovnoramenný lichoběžník se základnami $AB$ a $CD$ je osově souměrný podle osy $o$, proto vrchol $D$ je obrazem vrcholu $C$ v souměrnosti podle $o$. Doplníme lichoběžník $ABCD$.'],
     'ans': 'Konstrukce podle klíče: $C$ leží na rameni úhlu $ABC=70^\\circ$ ve vzdálenosti 8 cm od $B$ v polorovině s bodem $U$; $o$ je osa úsečky $AB$; $D$ je obraz bodu $C$ v osové souměrnosti podle $o$ (viz obrázek v klíči).',
     'pts': 5, 'mins': 10, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 11', 'zad': [
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
        '11.1 75 g je 3krát více než $\\frac{1}{4}$ kg.',
        '11.2 450 sekund je 2krát méně než čtvrt hodiny.',
        '11.3 Obrazec, který lze rozdělit na 4 čtverce se stranou délky 50 cm, má obsah 1 m².'],
     'opts': None, 'ln': 0,
     'sol': ['11.1 $\\frac{1}{4}$ kg $=250$ g, 3krát více je $750$ g, nikoli 75 g – tvrzení není pravdivé.',
             '11.2 Čtvrt hodiny $=900$ s, 2krát méně je $900:2=450$ s – tvrzení je pravdivé.',
             '11.3 Čtverec se stranou 50 cm má obsah $0{,}5\\cdot 0{,}5=0{,}25$ m², čtyři takové mají $4\\cdot 0{,}25=1$ m² – tvrzení je pravdivé.'],
     'ans': '11.1: Ne; 11.2: Ano; 11.3: Ano', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 12', 'zad': [
        'Oddělením dvou trojúhelníků $AFD$ a $BCE$ z obdélníku $ABCD$ vznikne bílý obrazec $ABEF$. Obsah trojúhelníku $BCE$ je 3 cm². Všechny uvedené body jsou v mřížových bodech čtvercové sítě (viz obrázek).',
        'Rozhodněte o každém z následujících tvrzení (12.1–12.3), zda je pravdivé (A), či nikoli (N).',
        '12.1 Obsah trojúhelníku $AFD$ je 2 cm².',
        '12.2 Obsah bílého obrazce $ABEF$ je $13{,}5$ cm².',
        '12.3 Obvod bílého obrazce $ABEF$ je stejný jako součet obvodů trojúhelníků $AFD$ a $BCE$.'],
     'opts': None, 'ln': 0, 'svg': SVG12, 'fn': 'obdelnik-sit.svg',
     'alt': 'Obdélník ABCD o rozměrech 6 krát 3 čtverečky na čtvercové síti; body F a E leží na straně DC, oddělené trojúhelníky AFD a BCE jsou šedé, obrazec ABEF je bílý.',
     'cap': 'Obdélník ABCD na čtvercové síti s oddělenými trojúhelníky',
     'sol': ['Obdélník má rozměry $6\\times 3$ čtverečky. Trojúhelník $BCE$ zabírá $\\frac{2\\cdot 3}{2}=3$ čtverečky a má obsah 3 cm², jeden čtvereček má tedy obsah 1 cm².',
             '12.1 Trojúhelník $AFD$ má obsah $\\frac{1\\cdot 3}{2}=1{,}5$ cm², nikoli 2 cm² – tvrzení není pravdivé.',
             '12.2 $6\\cdot 3-1{,}5-3=13{,}5$ cm² – tvrzení je pravdivé.',
             '12.3 Obvod $ABEF$ je $6+\\sqrt{13}+3+\\sqrt{10}$; obvod $AFD$ je $3+1+\\sqrt{10}$ a obvod $BCE$ je $3+2+\\sqrt{13}$, součet je $9+\\sqrt{10}+\\sqrt{13}$ – hodnoty jsou stejné, tvrzení je pravdivé.'],
     'ans': '12.1: Ne; 12.2: Ano; 12.3: Ano', 'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 13', 'zad': [
        'Trojúhelník $ABC$ je rozdělen na dva rovnoramenné trojúhelníky (viz obrázek).',
        'Jaká je velikost úhlu $\\alpha$? Úhel $\\alpha$ neměřte, ale vypočtěte.'],
     'opts': ['A) $48^\\circ$', 'B) $52^\\circ$', 'C) $58^\\circ$', 'D) $64^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG13, 'fn': 'trojuhelnik-uhly.svg',
     'alt': 'Trojúhelník ABC rozdělený úsečkou z vrcholu C na dva rovnoramenné trojúhelníky; u vrcholu A je úhel alfa, u C jsou úhly fí a 29 stupňů, u dělicího bodu je úhel fí a u B je 29 stupňů.',
     'cap': 'Trojúhelník ABC rozdělený na dva rovnoramenné trojúhelníky',
     'sol': ['Označme $D$ bod, v němž dělicí úsečka protíná stranu $AB$.',
             'V trojúhelníku $DCB$ jsou úhly u vrcholů $C$ i $B$ rovny $29^\\circ$, proto $|\\angle CDB|=180^\\circ-2\\cdot 29^\\circ=122^\\circ$ a vedlejší úhel $|\\angle ADC|=58^\\circ$, tedy $\\varphi=58^\\circ$.',
             'V trojúhelníku $ACD$ je $|\\angle ACD|=|\\angle ADC|=58^\\circ$, proto $\\alpha=180^\\circ-2\\cdot 58^\\circ=64^\\circ$.'],
     'ans': 'D) $64^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2016 – úloha 14', 'zad': [
        'Při vydatném dešti napršelo na záhon o rozloze jeden metr čtvereční 30 litrů vody. Toto množství vody by naplnilo $2{,}5$ kbelíku.',
        'Jaký je objem jednoho kbelíku?'],
     'opts': ['A) $0{,}012$ m³', 'B) $0{,}075$ m³', 'C) $7{,}5$ m³', 'D) $12$ m³', 'E) jiný objem'], 'ln': 0,
     'sol': ['Objem jednoho kbelíku je $30:2{,}5=12$ litrů.',
             '$12$ litrů $=12$ dm³ $=0{,}012$ m³.'],
     'ans': 'A) $0{,}012$ m³', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2016 – úloha 15', 'zad': [
        'V prvním čtvrtletí byla cena výrobku 120 Kč. Během roku se cena výrobku třikrát snížila, a to vždy na přelomu čtvrtletí. Vývoj ceny zachycuje graf.',
        'Kdy došlo ke snížení předchozí ceny výrobku o 20 %?'],
     'opts': ['A) ani jednou', 'B) na přelomu 1. a 2. čtvrtletí', 'C) na přelomu 2. a 3. čtvrtletí',
              'D) na přelomu 3. a 4. čtvrtletí', 'E) pokaždé'], 'ln': 0,
     'svg': SVG15, 'fn': 'graf-ceny.svg',
     'alt': 'Sloupcový graf Vývoj cen výrobku: 1. čtvrtletí 120 Kč, 2. čtvrtletí 100 Kč, 3. čtvrtletí 80 Kč, 4. čtvrtletí 60 Kč.',
     'cap': 'Vývoj cen výrobku v jednotlivých čtvrtletích (Kč)',
     'sol': ['Z grafu: 120 Kč, 100 Kč, 80 Kč, 60 Kč.',
             'Snížení ze 120 na 100 Kč je o $\\frac{20}{120}$, tj. přibližně $16{,}7$ %.',
             'Snížení ze 100 na 80 Kč je o $\\frac{20}{100}$, tj. přesně 20 %.',
             'Snížení z 80 na 60 Kč je o $\\frac{20}{80}$, tj. 25 %. O 20 % se cena snížila na přelomu 2. a 3. čtvrtletí.'],
     'ans': 'C) na přelomu 2. a 3. čtvrtletí', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['procenta', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2016 – úloha 16', 'zad': [
        'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).',
        '16.1 Petr utratil 30 % z 30 Kč. Kolik Kč mu zbylo?',
        '16.2 Zatím přišlo jen 12 dětí. Na zbývajících 60 % dětí se čeká. Na kolik dětí se čeká?',
        '16.3 Výrobek zdražený o tři čtvrtiny původní ceny stojí 28 Kč. Kolik Kč by stál výrobek zdražený jen o 50 % původní ceny?'],
     'opts': ['A) 14', 'B) 18', 'C) 20', 'D) 21', 'E) 24', 'F) jiný výsledek'], 'ln': 0,
     'sol': ['16.1 30 % z 30 Kč je 9 Kč, zbylo tedy $30-9=21$ Kč – možnost D.',
             '16.2 Přišlo 40 % dětí, tj. 12 dětí; celkem je $12:0{,}4=30$ dětí a čeká se na $30-12=18$ dětí – možnost B.',
             '16.3 Původní cena $x$ splňuje $1{,}75x=28$, tedy $x=16$ Kč. Po zdražení o 50 % by výrobek stál $1{,}5\\cdot 16=24$ Kč – možnost E.'],
     'ans': '16.1: D (21); 16.2: B (18); 16.3: E (24)', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2016 – úloha 17', 'zad': [
        'Ve čtverci jsou obě úhlopříčky překryty tmavými čtverečky s délkou strany 4 cm podobně jako na obrázku. Zbytek plochy čtverce je bílý.',
        'Uveďte postup řešení.',
        '17.1 Vypočtěte délku strany čtverce, který má celkem 9 tmavých čtverečků.',
        '17.2 Vypočtěte délku strany čtverce, který má celkem 69 tmavých čtverečků.',
        '17.3 Vypočtěte celkový počet tmavých čtverečků, je-li délka strany čtverce 884 cm.'],
     'opts': None, 'ln': 5, 'svg': SVG17, 'fn': 'ctverec-uhlopricky.svg',
     'alt': 'Dva čtverce, jejichž obě úhlopříčky jsou překryty tmavými čtverečky se stranou 4 cm; menší čtverec má 9 tmavých čtverečků, u většího je řada naznačena tečkami.',
     'cap': 'Čtverce s tmavými čtverečky na obou úhlopříčkách',
     'sol': ['Je-li strana čtverce $4n$ cm, leží na každé úhlopříčce $n$ tmavých čtverečků a prostřední čtvereček je oběma úhlopříčkám společný. Celkem je tmavých čtverečků $2n-1$.',
             '17.1 $2n-1=9$, tedy $n=5$ a strana čtverce je $5\\cdot 4=20$ cm.',
             '17.2 $2n-1=69$, tedy $n=35$ a strana čtverce je $35\\cdot 4=140$ cm.',
             '17.3 $884:4=221$, tmavých čtverečků je $2\\cdot 221-1=441$.'],
     'ans': '17.1: $20$ cm; 17.2: $140$ cm; 17.3: $441$ čtverečků', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PZD16C0T01'
    gen.YEAR = 2016

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M7A' not in p['name']: errors.append('Chybí M7A v názvu: ' + p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    body = sum(p['pts'] for p in PROBLEMS)
    if body != 50: errors.append(f'Součet bodů je {body}, má být 50')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, body celkem:', body)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2016')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
