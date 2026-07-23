# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2018, MATEMATIKA 5 B (osmilete obory, 5. rocnik),
# 2. radny termin. Kod testu: M5PBD18C0T02. 14 uloh (po rozdeleni izolovanych poduloh 19 uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR). VZA je prazdna sablona zaznamoveho archu.

# ---- SVG obrazky (bez ' a \) ----

# uloha 4: dve rovnice s houskami (kruhy) a topinkami (zaoblene ctverce)
def _housky():
    def houska(cx, cy):
        r = 21
        return (f'<circle cx="{cx}" cy="{cy}" r="{r}" fill="#dcdcdc" stroke="#000" stroke-width="1.4"/>'
                f'<path d="M {cx-11} {cy} C {cx-6} {cy-9}, {cx+6} {cy-9}, {cx+11} {cy}" fill="none" stroke="#666" stroke-width="1"/>'
                f'<path d="M {cx-11} {cy} C {cx-6} {cy+9}, {cx+6} {cy+9}, {cx+11} {cy}" fill="none" stroke="#666" stroke-width="1"/>'
                f'<line x1="{cx}" y1="{cy-r+3}" x2="{cx}" y2="{cy+r-3}" stroke="#666" stroke-width="1"/>')
    def topinka(x, y):
        return f'<rect x="{x}" y="{y}" width="42" height="42" rx="7" fill="#ffffff" stroke="#000" stroke-width="1.4"/>'
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 200" font-family="sans-serif">']
    # radek 1: 2 housky = 10 g + 2 topinky
    s.append(houska(52, 52) + houska(102, 52))
    s.append('<text x="150" y="60" font-size="22">=</text>')
    s.append('<text x="185" y="60" font-size="20">10 g</text>')
    s.append('<text x="248" y="60" font-size="22">+</text>')
    s.append(topinka(278, 31) + topinka(328, 31))
    # radek 2: 1 houska + 2 topinky = 110 g
    s.append(houska(52, 150))
    s.append('<text x="90" y="158" font-size="22">+</text>')
    s.append(topinka(120, 129) + topinka(170, 129))
    s.append('<text x="228" y="158" font-size="22">=</text>')
    s.append('<text x="264" y="158" font-size="20">110 g</text>')
    s.append('</svg>')
    return "".join(s)
SVG4 = _housky()

# uloha 7: vychozi obrazek - body A, F, G
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 340" font-family="sans-serif">
<rect x="6" y="6" width="468" height="328" fill="none" stroke="#ccc"/>
<text x="178" y="90" font-size="16" text-anchor="middle">×</text>
<text x="178" y="80" font-size="16" font-style="italic" text-anchor="middle">G</text>
<text x="355" y="182" font-size="16" text-anchor="middle">×</text>
<text x="362" y="198" font-size="16" font-style="italic">F</text>
<text x="168" y="236" font-size="16" text-anchor="middle">×</text>
<text x="168" y="252" font-size="16" font-style="italic" text-anchor="middle">A</text>
</svg>"""

# uloha 8: ctvercova sit 10x10, dva bile obrazce A, B s vrcholy v mrizovych bodech
def _grid8():
    u = 26; ox = 22; oy = 18; W = 10; H = 10
    def X(c): return ox + c * u
    def Y(c): return oy + c * u
    def poly(pts):
        p = " ".join(f"{X(a)},{Y(b)}" for a, b in pts)
        return f'<polygon points="{p}" fill="#ffffff" stroke="#000" stroke-width="2"/>'
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 306" font-family="sans-serif">']
    s.append('<g stroke="#8a8a8a" stroke-width="0.7">')
    for i in range(W + 1):
        s.append(f'<line x1="{X(i)}" y1="{Y(0)}" x2="{X(i)}" y2="{Y(H)}"/>')
    for j in range(H + 1):
        s.append(f'<line x1="{X(0)}" y1="{Y(j)}" x2="{X(W)}" y2="{Y(j)}"/>')
    s.append('</g>')
    # obrazec A (obsah 13 cm2) - protahly ctyruhelnik s dlouhym cipem vlevo dole
    s.append(poly([(3, 1), (5, 1), (4, 5), (0, 7)]))
    # obrazec B (stejny obsah, kompaktnejsi) - naklonene rovnobeznikovity ctyruhelnik
    s.append(poly([(7, 3), (9, 3), (8, 8), (6, 8)]))
    s.append(f'<text x="{X(3)}" y="{Y(3)}" font-size="15" font-weight="bold">A</text>')
    s.append(f'<text x="{X(7.4)}" y="{Y(5.6)}" font-size="15" font-weight="bold">B</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _grid8()

# ulohy 11-12: krychle 5x5x5 se svislymi, predozadnimi a bocnimi otvory (schematicky)
def _cube():
    ox, oy, cell = 150, 300, 34
    dzx, dzy = 22, -16
    def P(x, y, z):
        return (ox + x * cell + z * dzx, oy - y * cell + z * dzy)
    def line(a, b):
        return f'<line x1="{a[0]:.0f}" y1="{a[1]:.0f}" x2="{b[0]:.0f}" y2="{b[1]:.0f}"/>'
    def quad(pts, fill):
        p = " ".join(f"{x:.0f},{y:.0f}" for x, y in pts)
        return f'<polygon points="{p}" fill="{fill}" stroke="#000" stroke-width="0.8"/>'
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 360" font-family="sans-serif">']
    # tmave otvory - horni stena (svisle otvory): (x,z)
    s.append('<g>')
    for (x, z) in ((1, 1), (2, 3), (3, 2)):
        s.append(quad([P(x, 5, z), P(x + 1, 5, z), P(x + 1, 5, z + 1), P(x, 5, z + 1)], "#5a5a5a"))
    # predni stena (predozadni otvory): (x,y)
    for (x, y) in ((1, 2), (2, 1), (3, 3)):
        s.append(quad([P(x, y, 0), P(x + 1, y, 0), P(x + 1, y + 1, 0), P(x, y + 1, 0)], "#5a5a5a"))
    # prava stena (bocni otvory): (y,z)
    for (y, z) in ((1, 1), (2, 3), (3, 2)):
        s.append(quad([P(5, y, z), P(5, y + 1, z), P(5, y + 1, z + 1), P(5, y, z + 1)], "#5a5a5a"))
    s.append('</g>')
    s.append('<g stroke="#000" stroke-width="0.8">')
    for i in range(6):
        s.append(line(P(i, 0, 0), P(i, 5, 0)))
        s.append(line(P(0, i, 0), P(5, i, 0)))
        s.append(line(P(i, 5, 0), P(i, 5, 5)))
        s.append(line(P(0, 5, i), P(5, 5, i)))
        s.append(line(P(5, i, 0), P(5, i, 5)))
        s.append(line(P(5, 0, i), P(5, 5, i)))
    s.append('</g>')
    s.append('<g stroke="#000" stroke-width="1.8" fill="none">')
    s.append(quad([P(0, 0, 0), P(5, 0, 0), P(5, 5, 0), P(0, 5, 0)], "none"))
    s.append('</g>')
    # popisky fazi
    s.append('<g font-size="14">')
    s.append('<text x="250" y="30" text-anchor="middle">1. fáze</text>')
    s.append('<line x1="250" y1="36" x2="250" y2="72" stroke="#000"/><polygon points="250,78 246,68 254,68" fill="#000"/>')
    s.append('<text x="430" y="150" font-size="14">3. fáze</text>')
    s.append('<line x1="428" y1="146" x2="390" y2="146" stroke="#000"/><polygon points="384,146 394,142 394,150" fill="#000"/>')
    s.append('<text x="70" y="345" font-size="14">2. fáze</text>')
    s.append('<line x1="110" y1="330" x2="150" y2="300" stroke="#000"/><polygon points="155,296 145,299 150,306" fill="#000"/>')
    s.append('</g></svg>')
    return "".join(s)
SVG_CUBE = _cube()

# uloha 13: tabulka sberu papiru (divky / chlapci / celkem x 5.A / 5.B / 5.C)
def _tab13():
    x0, y0, cw, ch = 20, 20, 100, 40
    cols = ["", "dívky", "chlapci", "celkem"]
    rows = ["", "5. A", "5. B", "5. C"]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 190" font-family="sans-serif">']
    s.append('<g stroke="#000" stroke-width="1.2" fill="none">')
    for r in range(5):
        s.append(f'<line x1="{x0}" y1="{y0 + r * ch}" x2="{x0 + 4 * cw}" y2="{y0 + r * ch}"/>')
    for c in range(5):
        s.append(f'<line x1="{x0 + c * cw}" y1="{y0}" x2="{x0 + c * cw}" y2="{y0 + 4 * ch}"/>')
    s.append('</g><g font-size="15" text-anchor="middle">')
    for c in range(1, 4):
        s.append(f'<text x="{x0 + c * cw + cw / 2:.0f}" y="{y0 + 25}">{cols[c]}</text>')
    for r in range(1, 4):
        s.append(f'<text x="{x0 + cw / 2:.0f}" y="{y0 + r * ch + 25}">{rows[r]}</text>')
    s.append(f'<text x="{x0 + 3 * cw + cw / 2:.0f}" y="{y0 + 2 * ch + 25}">480 kg</text>')
    s.append('</g></svg>')
    return "".join(s)
SVG13 = _tab13()

# uloha 14: rostouci obdelniky 2, 6, 12, 20 (sedy spodni radek, bily pravy sloupec)
def _grow():
    u = 15; ybase = 95
    xs = 24
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 390 120" font-family="sans-serif">']
    tops = [2, 6, 12, 20]
    rights = [None, 2, 3, 4]
    for k, n in enumerate((1, 2, 3, 4)):
        w = (n + 1) * u; h = n * u
        x = xs; y = ybase - h
        s.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="#ffffff"/>')
        # spodni sedy radek
        s.append(f'<rect x="{x}" y="{ybase - u}" width="{w}" height="{u}" fill="#cfcfcf"/>')
        s.append('<g stroke="#000" stroke-width="0.9">')
        for i in range(n + 2):
            s.append(f'<line x1="{x + i * u}" y1="{y}" x2="{x + i * u}" y2="{ybase}"/>')
        for j in range(n + 1):
            s.append(f'<line x1="{x}" y1="{y + j * u}" x2="{x + w}" y2="{y + j * u}"/>')
        s.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="none" stroke="#000" stroke-width="1.4"/>')
        s.append('</g>')
        s.append(f'<text x="{x + w / 2:.0f}" y="{y - 6}" font-size="12" text-anchor="middle">{tops[k]}</text>')
        if rights[k]:
            s.append(f'<text x="{x + w + 8}" y="{ybase - h / 2 + 4:.0f}" font-size="12">{rights[k]}</text>')
        xs += w + 26
    s.append(f'<text x="{xs + 4}" y="{ybase - 12}" font-size="18">…</text>')
    s.append('</svg>')
    return "".join(s)
SVG14 = _grow()


B = ['zs1']  # 5. rocnik ZS (prijimacky na osmilete obory); kod r5 v taxonomii neni

PROBLEMS = [
    {'name': 'CERMAT M5B 2018 – úloha 1.1',
     'zad': ['Vypočtěte: $16 \\cdot (100 + 20 + 3) - (3 + 20 + 100) \\cdot 10 + 6 \\cdot (3 + 20 + 100) - (100 + 20 + 3) \\cdot 0 =$'],
     'opts': None, 'ln': 2,
     'sol': ['Ve všech součinech vystupuje číslo $100 + 20 + 3 = 123$. Výraz je $123 \\cdot 16 - 123 \\cdot 10 + 123 \\cdot 6 - 123 \\cdot 0 = 123 \\cdot (16 - 10 + 6) = 123 \\cdot 12 = 1\\,476$.'],
     'ans': '$1\\,476$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 1.2',
     'zad': ['Vypočtěte: $8\\,000 : [400 : (200 : 8)] =$'],
     'opts': None, 'ln': 2,
     'sol': ['Postupně zevnitř: $200 : 8 = 25$, pak $400 : 25 = 16$ a nakonec $8\\,000 : 16 = 500$.'],
     'ans': '$500$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 2.1',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:',
             '$\\frac{1}{4}$ hodiny $+\\ 300$ sekund $=\\ \\square\\ $ minut'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{1}{4}$ hodiny $= 15$ minut a $300$ sekund $= 5$ minut; dohromady $15 + 5 = 20$ minut.'],
     'ans': '$20$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 2.2',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:',
             '$\\frac{1}{2}$ km $=\\ \\square\\ \\cdot\\ 20$ m'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{1}{2}$ km $= 500$ m; protože $500 : 20 = 25$, je $\\frac{1}{2}$ km $= 25 \\cdot 20$ m.'],
     'ans': '$25$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 2.3',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:',
             '$1\\,500$ mm $+\\ \\square\\ $ cm $=\\ 15$ m'],
     'opts': None, 'ln': 2,
     'sol': ['$1\\,500$ mm $= 150$ cm a $15$ m $= 1\\,500$ cm; do rámečku patří $1\\,500 - 150 = 1\\,350$ cm.'],
     'ans': '$1\\,350$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 3',
     'zad': ['Jana si nahrála na několik CD všechny lekce němčiny, a to postupně od první lekce do poslední. Jednotlivá CD zaplňovala rovněž v pořadí od prvního do posledního CD. Na každém CD je stejný počet lekcí – nejméně $5$, ale nejvíce $10$. Jen jediná dvojice ze čtyř lekcí $11$, $13$, $31$ a $33$ je nahrána na stejném CD.',
             'Určete, kolik lekcí může být na jednom CD. Uveďte všechna možná řešení.'],
     'opts': None, 'ln': 2,
     'sol': ['Je-li na každém CD $n$ lekcí, leží lekce číslo $k$ na CD s pořadím $\\lceil k : n \\rceil$. Pro $n = 6$ jsou lekce $11$ a $13$ na 2. a 3. CD, ale lekce $31$ a $33$ jsou obě na 6. CD – jediná společná dvojice. Pro $n = 8$ jsou lekce $11$ a $13$ obě na 2. CD, zatímco $31$ a $33$ na 4. a 5. CD – opět jediná dvojice. Pro $n = 5, 7, 9, 10$ vyjdou pokaždé dvě společné dvojice, což zadání nevyhovuje.'],
     'ans': '$6$ lekcí; $8$ lekcí', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2018 – úloha 4',
     'zad': ['Dvě housky váží o $10$ gramů více než dvě topinky. Jedna houska a dvě topinky váží celkem $110$ gramů (viz obrázek).',
             '4.1 Vypočtěte, o kolik gramů méně váží jedna topinka než jedna houska.',
             '4.2 Vypočtěte, kolik gramů váží tři topinky.',
             '4.3 Vypočtěte, kolik gramů váží jedna houska.'],
     'opts': None, 'ln': 3, 'svg': SVG4, 'fn': 'housky-topinky.svg',
     'alt': 'Dvě rovnice s obrázky: dvě housky se rovnají 10 g a dvěma topinkám; jedna houska a dvě topinky se rovnají 110 g.',
     'cap': 'Vztahy mezi hmotnostmi housek a topinek',
     'sol': ['Ze vztahu dvě housky $= 10$ g $+$ dvě topinky plyne, že dvě housky váží o $10$ g více než dvě topinky, tedy jedna houska o $5$ g více než jedna topinka.',
             '4.1 Jedna topinka váží o $5$ g méně než jedna houska.',
             '4.2 Dosadíme do vztahu houska $+$ dvě topinky $= 110$ g. Protože houska $=$ topinka $+ 5$ g, je $3 \\cdot$ topinka $+ 5 = 110$, takže tři topinky váží $105$ g.',
             '4.3 Jedna topinka váží $105 : 3 = 35$ g, jedna houska tedy $35 + 5 = 40$ g.'],
     'ans': '4.1: o $5$ g; 4.2: $105$ g; 4.3: $40$ g', 'pts': 5, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2018 – úloha 5',
     'zad': ['Maminka rozložila všechny upečené koláče na dva talíře, na oba talíře dala stejný počet koláčů. Jarda z prvního talíře $5$ koláčů snědl a potom na něj přendal $3$ koláče z druhého talíře. Emilka pak z talíře s větším počtem koláčů odebrala třetinu koláčů a dala si je do krabičky. Odnesla si tak v krabičce celkem $5$ koláčů.',
             '5.1 Určete počet všech upečených koláčů (tj. na obou talířích dohromady).',
             '5.2 Určete počet koláčů, které zbyly na druhém talíři.'],
     'opts': None, 'ln': 2,
     'sol': ['Na každém talíři bylo na začátku $n$ koláčů. Na prvním talíři po snědení $5$ koláčů a přidání $3$ koláčů zůstalo $n - 2$, na druhém $n - 3$. Talíř s větším počtem je první ($n - 2$). Emilka z něj odebrala třetinu: $\\frac{n - 2}{3} = 5$, odtud $n - 2 = 15$ a $n = 17$.',
             '5.1 Celkem bylo upečeno $2 \\cdot 17 = 34$ koláčů.',
             '5.2 Na druhém talíři zbylo $n - 3 = 17 - 3 = 14$ koláčů.'],
     'ans': '5.1: $34$ koláčů; 5.2: $14$ koláčů', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2018 – úloha 6',
     'zad': ['Část plochy hladiny rybníka je znečištěná. Za každý den ($24$ hodin) se velikost znečištěné plochy zdvojnásobí.',
             '6.1 Vypočtěte, kolikrát se zvětší velikost znečištěné plochy za dva dny.',
             '6.2 Vypočtěte, kolikrát menší byla velikost znečištěné plochy před třemi dny.',
             '6.3 Znečištěná plocha pokrývá osminu plochy hladiny rybníka. Vypočtěte, za kolik dnů se znečištěná plocha rozšíří na celou plochu hladiny rybníka.'],
     'opts': None, 'ln': 3,
     'sol': ['6.1 Za jeden den se plocha zdvojnásobí, za dva dny se tedy zvětší $2 \\cdot 2 = 4$krát.',
             '6.2 Každý den zpět je plocha poloviční, před třemi dny byla $2 \\cdot 2 \\cdot 2 = 8$krát menší.',
             '6.3 Z osminy: za $1$ den čtvrtina, za $2$ dny polovina a za $3$ dny celá plocha. Znečištění pokryje celou hladinu za $3$ dny.'],
     'ans': '6.1: $4$krát; 6.2: $8$krát; 6.3: $3$ dny', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2018 – úloha 7.1 (konstrukce)',
     'zad': ['V rovině leží body $A$, $F$, $G$ (viz obrázek). Bod $A$ je vrchol čtverce $ABCD$. Na polopřímce $AF$ leží vrchol $B$ tohoto čtverce a uvnitř strany $CD$ tohoto čtverce leží bod $G$.',
             'Sestrojte chybějící vrcholy $B$, $C$, $D$ čtverce $ABCD$, označte je písmeny a čtverec narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'body-AFG.svg',
     'alt': 'Body A, F, G v rovině: G nahoře uprostřed, F vpravo, A dole vlevo.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['Strana $AB$ leží na polopřímce $AF$, protější strana $CD$ je s ní rovnoběžná a prochází bodem $G$. Bodem $G$ vedeme rovnoběžku s $AF$ (přímku strany $CD$). V bodě $A$ vztyčíme kolmici k $AF$; její průsečík s touto rovnoběžkou je vrchol $D$ a délka $|AD|$ je stranou čtverce. Na polopřímce $AF$ naneseme $|AB| = |AD|$ (vrchol $B$) a v bodě $B$ vztyčíme kolmici k $AF$, jejíž průsečík s rovnoběžkou je vrchol $C$. Bod $G$ leží uvnitř strany $CD$.'],
     'ans': 'Čtverec $ABCD$ se stranou $AB$ na polopřímce $AF$; délka strany je rovna vzdálenosti bodu $G$ od přímky $AF$ (vrchol $D$ je pata kolmice k $AF$ v bodě $A$ na rovnoběžce s $AF$ vedené bodem $G$) – viz nákres v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 7.2 (konstrukce)',
     'zad': ['V rovině leží body $A$, $F$, $G$ a je sestrojen čtverec $ABCD$ z úlohy 7.1 (viz obrázek).',
             'Na úsečce $AD$ sestrojte a označte bod $E$, který je vrcholem rovnoramenného trojúhelníku $EFG$ se základnou $EG$, a trojúhelník $EFG$ narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'body-AFG.svg',
     'alt': 'Body A, F, G v rovině: G nahoře uprostřed, F vpravo, A dole vlevo.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['Trojúhelník $EFG$ je rovnoramenný se základnou $EG$, takže ramena $FE$ a $FG$ jsou shodná: $|FE| = |FG|$. Bod $E$ proto leží na kružnici se středem $F$ a poloměrem $|FG|$; jeho poloha je dána průsečíkem této kružnice s úsečkou $AD$. Poté trojúhelník $EFG$ narýsujeme.'],
     'ans': 'Bod $E$ je průsečík úsečky $AD$ s kružnicí se středem $F$ a poloměrem $|FG|$ (pak $|FE| = |FG|$); trojúhelník $EFG$ má základnu $EG$ – viz nákres v klíči.',
     'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 7.3 (konstrukce)',
     'zad': ['V rovině leží body $A$, $F$, $G$ a je sestrojen trojúhelník $EFG$ z úlohy 7.2 (viz obrázek).',
             'Sestrojte a označte přímku $o$, která prochází bodem $F$ a je kolmá k přímce $EG$.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'body-AFG.svg',
     'alt': 'Body A, F, G v rovině: G nahoře uprostřed, F vpravo, A dole vlevo.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['Přímka $o$ je kolmice k přímce $EG$ vedená bodem $F$. Sestrojíme ji standardní konstrukcí kolmice z bodu $F$ k přímce $EG$.'],
     'ans': 'Přímka $o$ prochází bodem $F$ a je kolmá k přímce $EG$ – viz nákres v klíči.',
     'pts': 1, 'mins': 3, 'diff': '2',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 8',
     'zad': ['Čtvercová síť je tvořena čtverečky s délkou strany $1$ cm a obsahem $1$ cm². Ve čtvercové síti jsou zakresleny bílé obrazce $A$, $B$ s vrcholy v mřížových bodech (viz obrázek).',
             'Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).',
             '8.1 Obsah obrazce $A$ je stejný jako obsah obrazce $B$.',
             '8.2 Obsah obrazce $A$ je větší než $12$ cm².',
             '8.3 Obvod obrazce $A$ je větší než obvod obrazce $B$.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'ctvercova-sit-AB.svg',
     'alt': 'Čtvercová síť s dvěma bílými čtyřúhelníky A a B; A je protáhlý s dlouhým cípem, B je kompaktnější rovnoběžník.',
     'cap': 'Bílé obrazce A a B ve čtvercové síti (1 čtvereček = 1 cm²)',
     'sol': ['Obsahy obou obrazců určíme pomocí mřížových bodů (např. doplněním do obdélníku a odečtením trojúhelníků). Obrazec $A$ má obsah $13$ cm² a obrazec $B$ rovněž $13$ cm².',
             '8.1 Obsahy obou obrazců jsou stejné ($13$ cm²) → Ano.',
             '8.2 Obsah obrazce $A$ je $13$ cm², což je více než $12$ cm² → Ano.',
             '8.3 Obrazec $A$ je protáhlejší a jeho strany jsou delší než u kompaktnějšího obrazce $B$, proto má obrazec $A$ větší obvod → Ano.'],
     'ans': '8.1: Ano; 8.2: Ano; 8.3: Ano', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 9',
     'zad': ['Teta při práci spotřebuje jedno klubko provázku během každých $20$ minut. Teta pracovala $2$ hodiny a první hodinu současně s ní pracoval ještě strýc. Dohromady tak za $2$ hodiny spotřebovali $10$ klubek provázku.',
             'Kolik klubek spotřeboval za první hodinu práce samotný strýc?'],
     'opts': ['A) o 1 klubko víc než za stejnou dobu teta',
              'B) stejný počet klubek jako za stejnou dobu teta',
              'C) ani jedno klubko',
              'D) o 1 klubko méně než za stejnou dobu teta',
              'E) o 2 klubka méně než za stejnou dobu teta'], 'ln': 0,
     'sol': ['Teta spotřebuje $1$ klubko za $20$ minut, tedy za $2$ hodiny ($120$ minut) spotřebuje $6$ klubek. Strýc pracoval jen první hodinu, a tak zbývající $10 - 6 = 4$ klubka spotřeboval on. Za stejnou dobu (první hodinu, $60$ minut) spotřebuje teta $3$ klubka. Strýc tedy spotřeboval o $1$ klubko více než teta.'],
     'ans': 'A) o 1 klubko víc než za stejnou dobu teta', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2018 – úloha 10',
     'zad': ['Jan, Petr a Alena česali třešně. Do každého košíku načesali $3$ kg třešní. Každý z chlapců naplnil o polovinu větší počet košíků než Alena. Do večera načesali všichni tři dohromady $72$ kg třešní.',
             'Kolik košíků načesala Alena?'],
     'opts': ['A) méně než 4', 'B) 4', 'C) 5', 'D) 6', 'E) více než 6'], 'ln': 0,
     'sol': ['Celkem naplnili $72 : 3 = 24$ košíků. Alena naplnila $a$ košíků, každý chlapec o polovinu více, tj. $1{,}5a$. Dohromady $a + 2 \\cdot 1{,}5a = 4a = 24$, odtud $a = 6$.'],
     'ans': 'D) 6', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2018 – úloha 11',
     'zad': ['V krychli slepené ze $125$ krychliček (po $5$ v každé řadě) se vytvoří $9$ otvorů skrz naskrz (ústí každého otvoru je vyznačeno tmavě). V první fázi se vytvoří svislé otvory tak, že se vytlačí celkem $15$ krychliček ze tří svislých sloupců. Ve druhé fázi se prorazí tři otvory směřující zepředu dozadu. Ve třetí fázi se vytlačí poslední krychličky tak, aby vznikly tři otvory směřující zprava doleva (viz obrázek).',
             'Kolik krychliček se vytlačí ve $2$. fázi?'],
     'opts': ['A) méně než 11', 'B) 11', 'C) 12', 'D) 13', 'E) více než 13'], 'ln': 0,
     'svg': SVG_CUBE, 'fn': 'krychle-otvory.svg',
     'alt': 'Schematická krychle 5 krát 5 krát 5 se svislými, předozadními a bočními otvory; ústí otvorů jsou vyznačena tmavě, u stěn jsou popisky 1., 2. a 3. fáze.',
     'cap': 'Krychle se třemi směry otvorů (schematicky)',
     'sol': ['Ve druhé fázi se prorazí tři vodorovné otvory (zepředu dozadu), každý tvořený $5$ krychličkami, tj. dohromady $15$ krychliček. Čtyři z těchto krychliček však už byly vytlačeny v první fázi (leží v místech, kde se předozadní otvory kříží se svislými otvory), takže se nově vytlačí jen $15 - 4 = 11$ krychliček.'],
     'ans': 'B) 11', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 12',
     'zad': ['V krychli slepené ze $125$ krychliček (po $5$ v každé řadě) se vytvoří $9$ otvorů skrz naskrz. V první fázi se vytlačí $15$ krychliček (tři svislé otvory), ve druhé fázi tři otvory zepředu dozadu a ve třetí fázi tři otvory zprava doleva (viz obrázek).',
             'Kolik krychliček zbyde v krychli po vytvoření všech $9$ otvorů?'],
     'opts': ['A) 87', 'B) 88', 'C) 89', 'D) 90', 'E) jiný počet krychliček'], 'ln': 0,
     'svg': SVG_CUBE, 'fn': 'krychle-otvory.svg',
     'alt': 'Schematická krychle 5 krát 5 krát 5 se svislými, předozadními a bočními otvory; ústí otvorů jsou vyznačena tmavě, u stěn jsou popisky 1., 2. a 3. fáze.',
     'cap': 'Krychle se třemi směry otvorů (schematicky)',
     'sol': ['V první fázi se vytlačí $15$ krychliček, ve druhé $11$ (viz úloha 11) a ve třetí zbývajících $10$ nových krychliček (ostatní už byly vytlačeny v místech křížení otvorů). Celkem se odebere $15 + 11 + 10 = 36$ krychliček, takže v krychli zbyde $125 - 36 = 89$ krychliček.'],
     'ans': 'C) 89', 'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2018 – úloha 13',
     'zad': ['Páté třídy (5. A, 5. B a 5. C) uspořádaly sběr papíru (viz tabulka). V 5. A dívky nasbíraly o $30$ kg papíru více než chlapci, a to o pětinu více než chlapci. V 5. B nasbírali žáci celkem $480$ kg papíru, přičemž dívky nasbíraly dvakrát více než chlapci. V 5. C je celkem $27$ žáků, každý žák přinesl stejné množství papíru; chlapců je o $3$ více než dívek, proto chlapci nasbírali celkem o $72$ kg papíru více než dívky.',
             'Přiřaďte ke každé otázce (13.1–13.3) odpovídající odpověď (A–F).',
             '13.1 Kolik kg papíru nasbírali žáci 5. A celkem?',
             '13.2 Kolik kg papíru nasbíraly dívky 5. B?',
             '13.3 Kolik kg papíru nasbírali chlapci 5. C?'],
     'opts': ['A) méně než 320 kg', 'B) 320 kg', 'C) 330 kg', 'D) 350 kg', 'E) 360 kg', 'F) jiný počet kg'], 'ln': 0,
     'svg': SVG13, 'fn': 'tabulka-sber.svg',
     'alt': 'Tabulka se sloupci dívky, chlapci, celkem a řádky 5. A, 5. B, 5. C; vyplněná je jen buňka celkem u 5. B hodnotou 480 kg.',
     'cap': 'Tabulka sběru papíru',
     'sol': ['13.1 V 5. A je $30$ kg pětinou toho, co nasbírali chlapci, takže chlapci nasbírali $150$ kg a dívky $180$ kg; celkem $330$ kg → C.',
             '13.2 V 5. B je poměr dívky : chlapci roven $2 : 1$, tedy chlapci nasbírali $\\frac{480}{3} = 160$ kg a dívky $320$ kg → B.',
             '13.3 V 5. C je $12$ dívek a $15$ chlapců. Rozdíl $3$ žáků odpovídá $72$ kg, takže jeden žák přinesl $24$ kg; chlapci nasbírali $15 \\cdot 24 = 360$ kg → E.'],
     'ans': '13.1: C (330 kg); 13.2: B (320 kg); 13.3: E (360 kg)', 'pts': 5, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2018 – úloha 14',
     'zad': ['Ze stejně velkých čtverečků se podle jednotného pravidla sestavují obdélníky. První obdélník obsahuje $2$ čtverečky. Každý další obdélník vznikne tak, že se k předchozímu přidá nejprve dole jedna řada tmavých čtverečků a poté vpravo jeden sloupec bílých čtverečků. Číslo nahoře nad obdélníkem udává počet všech čtverečků v obdélníku, číslo vpravo udává počet bílých čtverečků v nejdelším z přidaných sloupců (viz obrázek).',
             '14.1 Obdélník obsahuje celkem $110$ čtverečků. Určete počet bílých čtverečků v nejdelším z přidaných sloupců.',
             '14.2 Nejdelší z přidaných sloupců obsahuje $20$ bílých čtverečků. Určete počet všech čtverečků v obdélníku.',
             '14.3 Počet čtverečků v obdélníku je větší než $900$, ale menší než $1\\,000$. Určete přesný počet čtverečků v obdélníku. Najděte všechna možná řešení.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'obdelniky.svg',
     'alt': 'Čtyři rostoucí obdélníky s 2, 6, 12 a 20 čtverečky; spodní řada je tmavá, pravý sloupec bílý, nad každým je počet čtverečků a vpravo počet přidaných bílých čtverečků.',
     'cap': 'První čtyři obdélníky rostoucí posloupnosti',
     'sol': ['$n$-tý obdélník má rozměr $(n + 1)$ krát $n$ čtverečků, takže obsahuje $n \\cdot (n + 1)$ čtverečků; číslo vpravo (počet bílých čtverečků v nejdelším přidaném sloupci) je rovno $n$.',
             '14.1 $n \\cdot (n + 1) = 110 = 10 \\cdot 11$, tedy $n = 10$; hledaný počet bílých čtverečků je $10$.',
             '14.2 Je $n = 20$, počet všech čtverečků je $20 \\cdot 21 = 420$.',
             '14.3 Hledáme $n \\cdot (n + 1)$ mezi $900$ a $1\\,000$: $30 \\cdot 31 = 930$ a $31 \\cdot 32 = 992$. Obě hodnoty vyhovují.'],
     'ans': '14.1: $10$; 14.2: $420$; 14.3: $930$ a $992$', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PBD18C0T02'
    gen.YEAR = 2018

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set(); total_pts = 0
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M5B' not in p['name']: errors.append('Název bez M5B: ' + p['name'])
        total_pts += p['pts']
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if total_pts != 50: errors.append(f'Součet bodů != 50: {total_pts}')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, součet bodů', total_pts)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5B-2018')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
