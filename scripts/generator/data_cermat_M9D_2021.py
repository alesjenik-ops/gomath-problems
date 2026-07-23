# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2021, MATEMATIKA 9 D, 2. náhradní termín.
# Kód testu: M9PDD21C0T04. 16 úloh (po rozdělení izolovaných podúloh 21 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR); ověřeno vůči zadání (TS) a VZA.
# Čtyřleté obory, 9. ročník ZŠ. SVG bez apostrofů a zpětných lomítek.

import math

# ---------- SVG obrázky (bez ' a \) ----------

# úloha 8: pravoúhlý lichoběžník ABCD (AB=15, CD=10, AD=12, pravý úhel u A)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 320" font-family="sans-serif">
<polygon points="70,270 280,270 210,102 70,102" fill="#eef3ef" stroke="#000" stroke-width="2"/>
<rect x="70" y="256" width="14" height="14" fill="none" stroke="#000" stroke-width="1"/>
<text x="62" y="290" font-size="15" font-weight="bold" text-anchor="end">A</text>
<text x="286" y="290" font-size="15" font-weight="bold">B</text>
<text x="214" y="98" font-size="15" font-weight="bold">C</text>
<text x="54" y="100" font-size="15" font-weight="bold" text-anchor="end">D</text>
<text x="175" y="291" font-size="14" text-anchor="middle">15 cm</text>
<text x="140" y="92" font-size="14" text-anchor="middle">10 cm</text>
<text x="44" y="192" font-size="14" text-anchor="middle">12 cm</text>
</svg>"""

# úloha 9: výchozí obrázek – úsečka LM a bod U
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 400" font-family="sans-serif">
<line x1="340" y1="100" x2="388" y2="335" stroke="#000" stroke-width="2.5"/>
<text x="348" y="97" font-size="16" font-weight="bold">M</text>
<text x="396" y="342" font-size="16" font-weight="bold">L</text>
<text x="243" y="219" font-size="16">×</text>
<text x="247" y="235" font-size="14" font-style="italic">U</text>
</svg>"""

# úloha 10: výchozí obrázek – body A, S
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 400" font-family="sans-serif">
<text x="296" y="171" font-size="16">×</text>
<text x="304" y="161" font-size="14" font-weight="bold">S</text>
<text x="210" y="321" font-size="16">×</text>
<text x="205" y="339" font-size="14" font-weight="bold" text-anchor="end">A</text>
</svg>"""

# úloha 12: dvě dvojice rovnoběžek, úhly 62°, 66° a hledaný φ
def _u12():
    def seg(x1, y1, x2, y2, w=2):
        return f'<line x1="{x1:.1f}" y1="{y1:.1f}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="#000" stroke-width="{w}"/>'
    def ticks(x1, y1, x2, y2, ts):
        dx, dy = x2 - x1, y2 - y1
        L = math.hypot(dx, dy)
        ux, uy = dx / L, dy / L
        nx, ny = -uy, ux
        out = []
        for t in ts:
            px, py = x1 + ux * L * t, y1 + uy * L * t
            out.append(seg(px - nx * 7, py - ny * 7, px + nx * 7, py + ny * 7, 1.6))
        return out
    T1 = (100, 80, 300, 430)     # transverzála vlevo (rovnoběžná s T2)
    T2 = (350, 80, 525, 430)     # transverzála vpravo
    H1 = (40, 120, 420, 175)     # horní přímka (nerovnoběžná, úhel 62°)
    H2 = (150, 250, 605, 250)    # přímka s úhlem φ (rovnoběžná s H3)
    H3 = (110, 380, 565, 380)    # přímka s úhlem 66°
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 470" font-family="sans-serif">']
    for L in (T1, T2, H1, H2, H3):
        s.append(seg(*L))
    for L in (T1, T2):
        s += ticks(*L, [0.30, 0.36])
    for L in (H2, H3):
        s += ticks(*L, [0.82, 0.88])
    s.append('<text x="138" y="162" font-size="17">62°</text>')
    s.append('<text x="291" y="372" font-size="17">66°</text>')
    s.append('<text x="404" y="240" font-size="18" font-style="italic">φ</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _u12()

# úloha 13: stavba ze tří spojených kvádrů (šířky 3, hloubka 4, výšky 6, 7, 5)
def _stavba():
    ox, oy, s = 110, 410, 22
    dvx, dvy = 52, -40  # oblique posun pro hloubku 4 cm
    def poly(pts, fill):
        p = " ".join(f"{x:.0f},{y:.0f}" for x, y in pts)
        return f'<polygon points="{p}" fill="{fill}" stroke="#000" stroke-width="2"/>'
    def line(x1, y1, x2, y2, w=1):
        return f'<line x1="{x1:.0f}" y1="{y1:.0f}" x2="{x2:.0f}" y2="{y2:.0f}" stroke="#000" stroke-width="{w}"/>'
    xb = [ox + c * s for c in (0, 3, 6, 9)]   # 110,176,242,308
    tops = [oy - h * s for h in (6, 7, 5)]     # 278,256,300
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 470" font-family="sans-serif">']
    # horní stěny (parallelogramy)
    for i in range(3):
        xl, xr, ty = xb[i], xb[i + 1], tops[i]
        out.append(poly([(xl, ty), (xr, ty), (xr + dvx, ty + dvy), (xl + dvx, ty + dvy)], "#f0f0f0"))
    # pravá stěna nejpravějšího kvádru
    out.append(poly([(xb[3], oy), (xb[3], tops[2]), (xb[3] + dvx, tops[2] + dvy), (xb[3] + dvx, oy + dvy)], "#dcdcdc"))
    # odkrytá pravá stěna prostředního kvádru (schod nad pravým)
    y5 = oy - 5 * s
    out.append(poly([(xb[2], y5), (xb[2], tops[1]), (xb[2] + dvx, tops[1] + dvy), (xb[2] + dvx, y5 + dvy)], "#dcdcdc"))
    # čelní stěny
    for i in range(3):
        out.append(poly([(xb[i], tops[i]), (xb[i + 1], tops[i]), (xb[i + 1], oy), (xb[i], oy)], "#ffffff"))
    # kóty
    out.append(line(96, oy, 96, tops[0]))
    out.append('<text x="88" y="348" font-size="15" text-anchor="end">6</text>')
    out.append(line(xb[3] + dvx + 8, tops[2] + dvy, xb[3] + dvx + 8, oy + dvy))
    out.append(f'<text x="{xb[3]+dvx+14:.0f}" y="320" font-size="15">5</text>')
    out.append(line(xb[2] + dvx + 8, tops[1] + dvy, xb[2] + dvx + 8, y5 + dvy))
    out.append(f'<text x="{xb[2]+dvx+14:.0f}" y="252" font-size="15">2</text>')
    out.append('<text x="132" y="252" font-size="15">4</text>')
    for i in range(3):
        xm = (xb[i] + xb[i + 1]) / 2
        out.append(f'<text x="{xm:.0f}" y="432" font-size="15" text-anchor="middle">3</text>')
    out.append('<text x="235" y="205" font-size="15" text-anchor="middle" font-style="italic">Stavba</text>')
    out.append('</svg>')
    return "".join(out)
SVG13 = _stavba()

# úloha 15.2: obdélník 5x4 ve čtvercové síti s tmavým mnohoúhelníkem
def _sit():
    cell, ox, oy, W, H = 34, 20, 20, 5, 4
    def px(c): return ox + c * cell
    def py(r): return oy + r * cell
    verts = [(2, 0), (5, 1), (5, 4), (3, 4), (2.5, 3), (1, 4), (0, 4), (0, 3)]
    pts = " ".join(f"{px(c):.0f},{py(r):.0f}" for c, r in verts)
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+W*cell} {oy*2+H*cell}" font-family="sans-serif">']
    s.append(f'<polygon points="{pts}" fill="#b9b9b9"/>')
    for i in range(W + 1):
        s.append(f'<line x1="{px(i)}" y1="{py(0)}" x2="{px(i)}" y2="{py(H)}" stroke="#999" stroke-width="1"/>')
    for j in range(H + 1):
        s.append(f'<line x1="{px(0)}" y1="{py(j)}" x2="{px(W)}" y2="{py(j)}" stroke="#999" stroke-width="1"/>')
    s.append(f'<polygon points="{pts}" fill="none" stroke="#000" stroke-width="2.5"/>')
    s.append(f'<rect x="{px(0)}" y="{py(0)}" width="{W*cell}" height="{H*cell}" fill="none" stroke="#000" stroke-width="2.5"/>')
    s.append('</svg>')
    return "".join(s)
SVG15 = _sit()

# ---------- Úlohy ----------

B = ['zs2', 'r9']  # 9. ročník ZŠ, čtyřleté obory

PROBLEMS = [
    {'name': 'CERMAT M9D 2021 – úloha 1', 'zad': [
        'Vypočtěte: $\\dfrac{0{,}25}{0{,}025} : 0{,}2 =$'], 'opts': None, 'ln': 2,
     'sol': ['$\\dfrac{0{,}25}{0{,}025}=10$, potom $10 : 0{,}2 = 50$.'],
     'ans': '$50$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 2.1', 'zad': [
        'Řeka Labe protéká pouze dvěma státy a délka celého jejího toku je $1\\,094$ km. V Německu je tok Labe o $352$ km delší než v České republice.',
        'Vypočtěte délku toku Labe v Německu.'], 'opts': None, 'ln': 2,
     'sol': ['Délku v ČR označme $x$ km. Pak $x+(x+352)=1\\,094$, tedy $2x=742$ a $x=371$. V Německu je $371+352=723$ km.'],
     'ans': '$723$ km', 'pts': 1, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9D 2021 – úloha 2.2', 'zad': [
        'Zahrada měla výměru $1\\,799$ m². Při stavbě nového plotu se posunutím sloupků výměra zahrady zvětšila o $250$ dm².',
        'Vypočtěte v m² novou výměru zahrady.'], 'opts': None, 'ln': 2,
     'sol': ['$250$ dm² $=2{,}5$ m². Nová výměra je $1\\,799+2{,}5=1\\,801{,}5$ m².'],
     'ans': '$1\\,801{,}5$ m²', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9D 2021 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\left(\\dfrac{5}{8}-\\dfrac{5}{12}\\right)\\cdot 4 - 2\\cdot\\left(\\dfrac{3}{4}-\\dfrac{2}{3}\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\dfrac{5}{8}-\\dfrac{5}{12}=\\dfrac{15-10}{24}=\\dfrac{5}{24}$, po vynásobení čtyřmi $\\dfrac{5}{6}$. Dále $2\\cdot\\left(\\dfrac{3}{4}-\\dfrac{2}{3}\\right)=2\\cdot\\dfrac{1}{12}=\\dfrac{1}{6}$. Výsledek $\\dfrac{5}{6}-\\dfrac{1}{6}=\\dfrac{4}{6}=\\dfrac{2}{3}$.'],
     'ans': '$\\dfrac{2}{3}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\dfrac{\\left(\\dfrac{27}{10}\\cdot\\dfrac{5}{9}-4\\right):3}{5}=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\dfrac{27}{10}\\cdot\\dfrac{5}{9}=\\dfrac{3}{2}$; $\\dfrac{3}{2}-4=-\\dfrac{5}{2}$; $\\left(-\\dfrac{5}{2}\\right):3=-\\dfrac{5}{6}$; a nakonec $\\left(-\\dfrac{5}{6}\\right):5=-\\dfrac{1}{6}$.'],
     'ans': '$-\\dfrac{1}{6}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 4.1', 'zad': [
        'Z daného výrazu vytkněte $(-3x)$:',
        '$-6x^2-3x+9xy=$'], 'opts': None, 'ln': 2,
     'sol': ['$-6x^2-3x+9xy=(-3x)\\cdot(2x+1-3y)$.'],
     'ans': '$(-3x)\\cdot(2x+1-3y)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 4.2', 'zad': [
        'Doplňte do rámečků chybějící čísla tak, aby platila rovnost:',
        '$(\\square\\cdot a-\\square\\cdot b)^2=\\square\\cdot a^2-56ab+(4\\cdot b)^2$',
        'Uveďte všechna tři čísla doplněná do rámečků.'], 'opts': None, 'ln': 2,
     'sol': ['Z $(4\\cdot b)^2$ plyne druhé číslo $4$. Prostřední člen $-2\\cdot p\\cdot 4\\cdot ab=-56ab$ dává $p=7$; první člen je pak $p^2 a^2=49a^2$. Platí $(7a-4b)^2=49a^2-56ab+16b^2$, čísla jsou $7$, $4$, $49$.'],
     'ans': '$7$; $4$; $49$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 4.3', 'zad': [
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky):',
        '$(5-y)(5+y)+3\\cdot(y^2-10)-(2y-3)\\cdot y=$'], 'opts': None, 'ln': 3,
     'sol': ['$(5-y)(5+y)=25-y^2$; $3\\cdot(y^2-10)=3y^2-30$; $(2y-3)\\cdot y=2y^2-3y$. Celkem $25-y^2+3y^2-30-2y^2+3y=3y-5$.'],
     'ans': '$3y-5$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 5.1', 'zad': [
        'Řešte rovnici:',
        '$2{,}5\\cdot(2-3x)=\\dfrac{5x+10}{2}$'], 'opts': None, 'ln': 3,
     'sol': ['$5-7{,}5x=\\dfrac{5x+10}{2}$; po vynásobení dvěma $10-15x=5x+10$; odtud $-20x=0$, tedy $x=0$.'],
     'ans': '$x=0$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 5.2', 'zad': [
        'Řešte rovnici:',
        '$\\dfrac{5}{3}\\cdot(y-1)+\\dfrac{5}{6}\\cdot(11-2y)-\\dfrac{3}{4}\\cdot y=0$'], 'opts': None, 'ln': 3,
     'sol': ['Vynásobením dvanácti: $20(y-1)+10(11-2y)-9y=0$; $20y-20+110-20y-9y=0$; $-9y+90=0$, tedy $y=10$.'],
     'ans': '$y=10$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 6', 'zad': [
        'Na trati závodila $3$ autíčka. První autíčko ujelo závod za $1$ minutu a $42$ sekund. Druhé autíčko ujelo závod za dobu o třetinu kratší než první autíčko. První autíčko ujelo závod za dobu o třetinu kratší než třetí autíčko.',
        'Vypočtěte v minutách a sekundách, za jakou dobu ujelo závod',
        '6.1 druhé autíčko,',
        '6.2 třetí autíčko.'], 'opts': None, 'ln': 3,
     'sol': ['První autíčko: $1$ min $42$ s $=102$ s.',
             '6.1 Druhé autíčko je o třetinu kratší: $102-\\dfrac{1}{3}\\cdot 102=68$ s $=1$ min $8$ s.',
             '6.2 První je o třetinu kratší než třetí, tedy $102=\\dfrac{2}{3}\\cdot t_3$, odtud $t_3=153$ s $=2$ min $33$ s.'],
     'ans': '6.1: $1$ min $8$ s; 6.2: $2$ min $33$ s', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9D 2021 – úloha 7', 'zad': [
        'V bílé krabičce jsou jen bílé kuličky, v zelené jen zelené a v modré jen modré. Bílých kuliček je $12$ a modrých $60$. Do bílé krabičky přendáme ze zelené a modré krabičky tolik kuliček, aby byl ve všech třech krabičkách stejný počet kuliček. Ze zelené krabičky přitom musíme přendat o $9$ kuliček více než z modré krabičky.',
        '7.1 Určete počet všech zelených kuliček.',
        '7.2 Vypočtěte, kolik kuliček zůstane v modré krabičce.',
        '7.3 Vypočtěte, kolik zelených kuliček přendáme do bílé krabičky.'], 'opts': None, 'ln': 3,
     'sol': ['Po přendání má každá krabička stejný počet $t$. Z modré (mělo $60$) přendáme $60-t$; do bílé (mělo $12$) přidáme celkem $t-12$ kuliček, přičemž zelených o $9$ více než modrých. Tedy $(60-t)+\\big((60-t)+9\\big)=t-12$, odkud $t=47$.',
             '7.2 V modré krabičce zůstane $t=47$ kuliček.',
             '7.3 Modrých přendáme $60-47=13$, zelených o $9$ více, tj. $22$.',
             '7.1 Všech zelených bylo $47+22=69$.'],
     'ans': '7.1: $69$ zelených; 7.2: $47$; 7.3: $22$ zelených', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9D 2021 – úloha 8', 'zad': [
        'V pravoúhlém lichoběžníku $ABCD$ se základnou $AB$ platí: $|AB|=15$ cm, $|CD|=10$ cm, $|AD|=12$ cm, $|\\angle BAD|=90^\\circ$ (viz obrázek).',
        'Vypočtěte',
        '8.1 v cm² obsah lichoběžníku $ABCD$,',
        '8.2 v cm obvod lichoběžníku $ABCD$.'], 'opts': None, 'ln': 3,
     'svg': SVG8, 'fn': 'lichobeznik.svg',
     'alt': 'Pravoúhlý lichoběžník ABCD se základnou AB délky 15 cm, kratší základnou CD délky 10 cm a ramenem AD délky 12 cm kolmým k základnám.',
     'cap': 'Pravoúhlý lichoběžník ABCD',
     'sol': ['8.1 Rameno $AD=12$ cm je výška. Obsah $=\\dfrac{|AB|+|CD|}{2}\\cdot v=\\dfrac{15+10}{2}\\cdot 12=150$ cm².',
             '8.2 Vodorovný rozdíl základen je $15-10=5$ cm, výška $12$ cm, tedy $|BC|=\\sqrt{5^2+12^2}=13$ cm. Obvod $=15+13+10+12=50$ cm.'],
     'ans': '8.1: $150$ cm²; 8.2: $50$ cm', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 9', 'zad': [
        'V rovině leží úsečka $LM$ a bod $U$ (viz obrázek).',
        'Úsečka $LM$ je strana rovnoramenného trojúhelníku $KLM$. V tomto trojúhelníku je každé z obou ramen dvakrát delší než základna. Bod $U$ leží uvnitř trojúhelníku $KLM$.',
        'Sestrojte vrchol $K$ trojúhelníku $KLM$, označte jej písmenem a trojúhelník narýsujte. Najděte všechna $3$ řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'usecka-LM-U.svg',
     'alt': 'Úsečka LM (M nahoře, L dole vpravo) a bod U ležící vlevo od ní.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Základnou rovnoramenného trojúhelníku může být kterákoli z jeho tří stran, proto vznikají tři řešení: (K1) $LM$ je základna a $|KL|=|KM|=2\\cdot|LM|$ – vrchol $K$ leží na ose úsečky $LM$; (K2) $LM$ je rameno, základnou je $KL$ ($|LM|=|KM|=2\\cdot|KL|$); (K3) $LM$ je rameno, základnou je $KM$ ($|LM|=|KL|=2\\cdot|KM|$). Poloha $K$ se volí tak, aby bod $U$ ležel uvnitř trojúhelníku.'],
     'ans': 'Tři řešení $K_1$, $K_2$, $K_3$: rovnoramenný trojúhelník $KLM$ s rameny dvakrát delšími než základna, podle volby základny $LM$, $KL$, resp. $KM$ – viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 10', 'zad': [
        'V rovině leží body $A$, $S$ (viz obrázek).',
        'Bod $A$ je vrchol obdélníku $ABCD$ a bod $S$ je střed tohoto obdélníku. Vrchol $C$ má od vrcholu $D$ i od středu $S$ stejnou vzdálenost, tedy $|CD|=|CS|$.',
        'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'body-A-S.svg',
     'alt': 'Body A a S v rovině; bod S leží nad bodem A.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Střed $S$ je střed úhlopříčky $AC$, proto je $C$ obrazem $A$ ve středové souměrnosti se středem $S$ (tím je $C$ určen a $|SC|=|SA|$). Dále $|SC|=|SD|=|SA|$ (polovina úhlopříčky). Podmínka $|CD|=|CS|$ znamená, že trojúhelník $SCD$ je rovnostranný, tedy $|\\angle CSD|=60^\\circ$; tím sestrojíme $D$ a bod $B$ jako obraz $D$ podle $S$. Úloha má dvě souměrná řešení.'],
     'ans': 'Dvě řešení: $C$ je souměrné s $A$ podle středu $S$ ($|AC|=2|AS|$), vrcholy $D$, $B$ leží na druhé úhlopříčce vedené bodem $S$ tak, že trojúhelník $SCD$ je rovnostranný ($|CD|=|CS|$) – obdélníky $AB_1CD_1$ a $AB_2CD_2$ viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 11', 'zad': [
        'Číslo $A$ může být kterékoli celé číslo větší než $9$. Číslo $B$ je o $3$ větší než číslo $A$. Číslo $C$ je dvojnásobkem čísla $B$.',
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (Ano), či nikoli (Ne).',
        '11.1 Číslo, které je výsledkem výpočtu $A+B+C$, může být sudé.',
        '11.2 Číslo, které je výsledkem výpočtu $A\\cdot B+C$, musí být vždy sudé.',
        '11.3 Číslo, které je výsledkem výpočtu $A+B-C$, musí být vždy záporné.'], 'opts': None, 'ln': 0,
     'sol': ['Platí $B=A+3$ a $C=2B=2A+6$.',
             '11.1 $A+B+C=4A+9$ je vždy liché, sudé být nemůže → Ne.',
             '11.2 $A\\cdot B+C=A^2+5A+6=(A+2)(A+3)$ je součin dvou po sobě jdoucích čísel, tedy vždy sudé → Ano.',
             '11.3 $A+B-C=-3$ je vždy záporné → Ano.'],
     'ans': '11.1: Ne; 11.2: Ano; 11.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 12', 'zad': [
        'Na obrázku jsou přímky; shodnými značkami jsou vyznačeny dvojice navzájem rovnoběžných přímek. Velikosti úhlů neměřte, ale vypočtěte.',
        'Jaká je velikost úhlu $\\varphi$?'],
     'opts': ['A) $128^\\circ$', 'B) $126^\\circ$', 'C) $118^\\circ$', 'D) $114^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG12, 'fn': 'uhly-rovnobezky.svg',
     'alt': 'Soustava přímek se dvěma dvojicemi rovnoběžek (vyznačenými shodnými značkami); jsou vyznačeny úhly 62°, 66° a hledaný úhel φ.',
     'cap': 'Výchozí obrázek k úloze 12',
     'sol': ['Přímky svírající úhel $\\varphi$ jsou rovnoběžné s přímkami, které svírají úhel $66^\\circ$ (shodné značky). Úhel $\\varphi$ a úhel $66^\\circ$ jsou proto úhly přilehlé a jejich součet je $180^\\circ$, takže $\\varphi=180^\\circ-66^\\circ=114^\\circ$. Úhel $62^\\circ$ náleží přímce, která s ostatními rovnoběžná není, a k výpočtu jej nepotřebujeme.'],
     'ans': 'D) $114^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 13', 'zad': [
        'Všechny díly stavebnice jsou pravidelné čtyřboké hranoly s rozměry $1$ cm $\\times$ $1$ cm $\\times$ $2$ cm. Ve stavbě, která má podobu tří spojených kvádrů, jsou jednotlivé díly naskládány bez mezer tak, aby stavba obsahovala co největší počet stojících dílů. Stojící díl má dole čtvercovou stěnu, ležící díl nikoli. Rozměry v obrázku jsou v cm.',
        'Kolik ležících dílů stavba obsahuje?'],
     'opts': ['A) $0$', 'B) $6$', 'C) $12$', 'D) $18$', 'E) $24$'],
     'ln': 0, 'svg': SVG13, 'fn': 'stavba-kvadry.svg',
     'alt': 'Stavba ze tří spojených kvádrů o společné hloubce 4 cm a šířkách po 3 cm; výšky zleva doprava jsou 6 cm, 7 cm a 5 cm.',
     'cap': 'Stavba ze tří spojených kvádrů (rozměry v cm)',
     'sol': ['Každý ze tří kvádrů má půdorys $3\\times 4$ (obsah $12$ čtverečních cm) a výšku po řadě $6$, $7$ a $5$ cm. Stojící díl je vysoký $2$ cm, proto zaplní svislý sloupec jen do sudé výšky. Levý kvádr má výšku $6$ cm (sudou) – je celý ze stojících dílů. Prostřední ($7$ cm) a pravý ($5$ cm) mají lichou výšku, takže jejich horní vrstva $1$ cm musí být z ležících dílů. Taková vrstva má obsah $3\\times 4=12$ čtverečků a jeden ležící díl ($2\\times 1$) pokryje $2$ čtverečky, tj. $6$ ležících dílů na kvádr. Celkem $6+6=12$.'],
     'ans': 'C) $12$', 'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 14', 'zad': [
        'Ve třídě je o polovinu více chlapců než děvčat.',
        'Které z následujících tvrzení je pravdivé?'],
     'opts': ['A) Chlapci tvoří tři pětiny žáků třídy.', 'B) Děvčata tvoří $33$ % žáků třídy.',
              'C) Počet žáků třídy je trojnásobkem počtu děvčat.', 'D) Počet dívek ve třídě je o polovinu menší než počet chlapců.',
              'E) Žádné z výše uvedených tvrzení není pravdivé.'], 'ln': 0,
     'sol': ['Počet děvčat označme $2k$; chlapců je o polovinu více, tj. $3k$, žáků celkem $5k$. Chlapci tvoří $\\dfrac{3k}{5k}=\\dfrac{3}{5}$ (tři pětiny) – tvrzení A je pravdivé. Děvčata tvoří $40$ %, počet žáků je $2{,}5$násobek počtu děvčat a dívek je o třetinu méně než chlapců, takže ostatní tvrzení neplatí.'],
     'ans': 'A) Chlapci tvoří tři pětiny žáků třídy.', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9D 2021 – úloha 15', 'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 V lednu navštívilo výstavu $350$ lidí, v únoru $420$ lidí. O kolik procent byla návštěvnost v únoru vyšší než v lednu?',
        '15.2 Obdélník i tmavý obrazec zakreslený v obdélníku mají všechny vrcholy v mřížových bodech čtvercové sítě (viz obrázek). O kolik procent je obsah tmavého obrazce menší než obsah obdélníku?',
        '15.3 Věra měla naspořeno $1\\,000$ korun. Nejprve si za $20$ % úspor koupila tričko a potom $20$ % ze zbývajících peněz utratila za knížku. O kolik procent bylo tričko dražší než knížka?'],
     'opts': ['A) o $0$ %', 'B) o $20$ %', 'C) o $25$ %', 'D) o $30$ %', 'E) o $35$ %', 'F) o jiný počet procent'],
     'ln': 0, 'svg': SVG15, 'fn': 'sit-obrazec.svg',
     'alt': 'Obdélník 5 krát 4 ve čtvercové síti s tmavým mnohoúhelníkem s vrcholy v mřížových bodech (schéma k úloze 15.2).',
     'cap': 'Obrázek k úloze 15.2',
     'sol': ['15.1 $\\dfrac{420-350}{350}=\\dfrac{70}{350}=20$ % → B.',
             '15.2 Obdélník má $5\\cdot 4=20$ čtverečků, tmavý obrazec $13$ čtverečků; je menší o $20-13=7$ čtverečků, tj. o $\\dfrac{7}{20}=35$ % → E.',
             '15.3 Tričko: $20$ % z $1\\,000=200$ Kč, zbývá $800$ Kč. Knížka: $20$ % z $800=160$ Kč. Tričko je dražší o $\\dfrac{200-160}{160}=\\dfrac{40}{160}=25$ % → C.'],
     'ans': '15.1: B (o $20$ %); 15.2: E (o $35$ %); 15.3: C (o $25$ %)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9D 2021 – úloha 16', 'zad': [
        'Do řady po sobě jdoucích kladných celých čísel přidáme za každé číslo dělitelné třemi toto číslo ještě jednou. Nová řada tak všechna čísla dělitelná třemi obsahuje dvakrát. V nové řadě je na $1.$ až $17.$ místě těchto $17$ čísel: $1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11, 12, 12, 13, \\ldots$',
        'Určete,',
        '16.1 na kolikátém místě nové řady je číslo $100$,',
        '16.2 které číslo je na $100.$ místě nové řady,',
        '16.3 na kolika místech nové řady je mezi čísly $1$ až $101$ uvedeno sudé číslo.'], 'opts': None, 'ln': 3,
     'sol': ['Do čísla $n$ (včetně) je v nové řadě $n$ čísel a k tomu tolik navíc, kolik je mezi nimi násobků tří, tj. celkem $n+\\left\\lfloor\\dfrac{n}{3}\\right\\rfloor$ míst.',
             '16.1 Číslo $100$ není dělitelné třemi, jeho místo je $100+\\left\\lfloor\\dfrac{99}{3}\\right\\rfloor=100+33=133$. Je na $133.$ místě.',
             '16.2 Hledáme $n$ s $n+\\left\\lfloor\\dfrac{n}{3}\\right\\rfloor=100$. Pro $n=75$ je $75+25=100$; číslo $75$ je dělitelné třemi (stojí na $99.$ a $100.$ místě), na $100.$ místě je tedy $75$.',
             '16.3 Sudých čísel mezi $1$ a $101$ je $50$ (čísla $2,4,\\ldots,100$). Z nich je $16$ dělitelných třemi (násobky šesti $6,12,\\ldots,96$) a ta jsou v řadě dvakrát. Sudé číslo je proto na $50+16=66$ místech.'],
     'ans': '16.1: na $133.$ místě; 16.2: $75$; 16.3: na $66$ místech', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PDD21C0T04'
    gen.YEAR = 2021

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9D-2021')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
