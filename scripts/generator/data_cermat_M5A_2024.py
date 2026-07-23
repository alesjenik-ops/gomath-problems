# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2024, MATEMATIKA 5A, osmilete obory (5. rocnik).
# Kod testu: M5PAD24C0T01. 14 uloh; po rozdeleni izolovanych poduloh 18 uloh.
# Zdroj odpovedi: klic spravnych reseni (KSR).

# ---- SVG obrazky (bez apostrofu a zpetnych lomitek) ----

# uloha 2: svisle scitani s hvezdickami (17*4 + *847 = 8*11, * = 6)
SVG2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" font-family="monospace" font-size="26">
<text x="200" y="50" text-anchor="end">1 7 * 4</text>
<text x="40" y="95" text-anchor="start">+</text>
<text x="200" y="95" text-anchor="end">* 8 4 7</text>
<line x1="45" y1="110" x2="200" y2="110" stroke="#000" stroke-width="2"/>
<text x="200" y="150" text-anchor="end">8 * 1 1</text>
</svg>"""

# uloha 3: souctovy trojuhelnik (7, seda, seda / _, _ / 25)
SVG3 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 250 160" font-family="sans-serif">
<rect x="20" y="20" width="70" height="40" fill="none" stroke="#000"/>
<text x="55" y="46" font-size="18" text-anchor="middle">7</text>
<rect x="90" y="20" width="70" height="40" fill="#bdbdbd" stroke="#000"/>
<rect x="160" y="20" width="70" height="40" fill="#bdbdbd" stroke="#000"/>
<rect x="55" y="60" width="70" height="40" fill="none" stroke="#000"/>
<rect x="125" y="60" width="70" height="40" fill="none" stroke="#000"/>
<rect x="90" y="100" width="70" height="40" fill="none" stroke="#000"/>
<text x="125" y="126" font-size="18" text-anchor="middle">25</text>
</svg>"""

# uloha 6: ciselna osa, 12 shodnych useku, X, 44, Y, 110
def _numline():
    x0, step, n, y = 40, 40, 12, 80
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 150" font-family="sans-serif">']
    s.append(f'<line x1="{x0-10}" y1="{y}" x2="{x0+n*step+10}" y2="{y}" stroke="#000" stroke-width="1.5"/>')
    for i in range(n+1):
        xi = x0 + i*step
        s.append(f'<line x1="{xi}" y1="{y-11}" x2="{xi}" y2="{y+11}" stroke="#000" stroke-width="1.5"/>')
    for i, t in {2: 'X', 4: '44', 7: 'Y', 10: '110'}.items():
        xi = x0 + i*step
        s.append(f'<text x="{xi}" y="{y+34}" font-size="16" text-anchor="middle">{t}</text>')
    s.append('</svg>')
    return "".join(s)
SVG6 = _numline()

# uloha 7: primka p a mimo ni body A, S
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="40" y1="250" x2="420" y2="120" stroke="#000" stroke-width="1.5"/>
<text x="52" y="272" font-size="16" font-style="italic">p</text>
<text x="285" y="150" font-size="15" text-anchor="middle">x</text>
<text x="285" y="168" font-size="15" font-style="italic" text-anchor="middle">S</text>
<text x="190" y="262" font-size="15" text-anchor="middle">x</text>
<text x="190" y="280" font-size="15" font-style="italic" text-anchor="middle">A</text>
</svg>"""

# uloha 8: ctvercova sit se dvema obrazci A (obsah 11) a B (schematicky)
def _grid8():
    ox, oy, cell, cols, rows = 20, 20, 28, 10, 8
    px = lambda c: ox + c*cell
    py = lambda r: oy + r*cell
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 270" font-family="sans-serif">']
    for i in range(cols+1):
        s.append(f'<line x1="{px(i)}" y1="{oy}" x2="{px(i)}" y2="{py(rows)}" stroke="#bbb"/>')
    for j in range(rows+1):
        s.append(f'<line x1="{ox}" y1="{py(j)}" x2="{px(cols)}" y2="{py(j)}" stroke="#bbb"/>')
    A = [(1, 1), (3, 1), (3, 2), (4, 2), (4, 5), (1, 5)]
    s.append('<polygon points="' + " ".join(f'{px(c)},{py(r)}' for c, r in A) + '" fill="none" stroke="#000" stroke-width="2.5"/>')
    s.append(f'<text x="{px(2)}" y="{py(1)+22}" font-size="16" text-anchor="middle">A</text>')
    Bp = [(5, 6), (6, 5), (8, 6), (8, 8), (5, 8)]
    s.append('<polygon points="' + " ".join(f'{px(c)},{py(r)}' for c, r in Bp) + '" fill="none" stroke="#000" stroke-width="2.5"/>')
    s.append(f'<text x="{px(6)}" y="{py(7)+6}" font-size="16" text-anchor="middle">B</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _grid8()

# uloha 10: pet ctvercu s uhloprickami, vybarveny trojuhelnik a sipka (schematicky)
def _logic10():
    size, y, gap, x0 = 74, 30, 24, 20
    cfgs = [('L', 'up'), ('B', 'down'), ('LB', 'down'), ('TL', 'left'), ('TR', 'right')]
    labels = ['A', 'B', 'C', 'D', 'E']
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 150" font-family="sans-serif">']
    for i, (shade, arrow) in enumerate(cfgs):
        x = x0 + i*(size+gap)
        cx, cy = x+size/2, y+size/2
        tri = {'T': f'{x},{y} {x+size},{y} {cx},{cy}',
               'R': f'{x+size},{y} {x+size},{y+size} {cx},{cy}',
               'B': f'{x},{y+size} {x+size},{y+size} {cx},{cy}',
               'L': f'{x},{y} {x},{y+size} {cx},{cy}'}
        for ch in shade:
            s.append(f'<polygon points="{tri[ch]}" fill="#b8b8b8"/>')
        s.append(f'<rect x="{x}" y="{y}" width="{size}" height="{size}" fill="none" stroke="#000"/>')
        s.append(f'<line x1="{x}" y1="{y}" x2="{x+size}" y2="{y+size}" stroke="#000"/>')
        s.append(f'<line x1="{x+size}" y1="{y}" x2="{x}" y2="{y+size}" stroke="#000"/>')
        ar = {'up': f'{cx},{cy-20} {cx-8},{cy-6} {cx+8},{cy-6}',
              'down': f'{cx},{cy+20} {cx-8},{cy+6} {cx+8},{cy+6}',
              'left': f'{cx-20},{cy} {cx-6},{cy-8} {cx-6},{cy+8}',
              'right': f'{cx+20},{cy} {cx+6},{cy-8} {cx+6},{cy+8}'}
        s.append(f'<polygon points="{ar[arrow]}" fill="#fff" stroke="#000"/>')
        s.append(f'<text x="{cx}" y="{y+size+16}" font-size="13" text-anchor="middle">{labels[i]})</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _logic10()

# uloha 11: sestiuhelnik ABCDEF rozdeleny na 6 shodnych trojuhelniku, 2 tmave
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 260" font-family="sans-serif">
<polygon points="170,90 290,90 340,150 290,210 170,210 120,150" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="230,150 120,150 170,210" fill="#000"/>
<polygon points="230,150 170,210 290,210" fill="#000"/>
<line x1="170" y1="210" x2="290" y2="90" stroke="#000"/>
<line x1="290" y1="210" x2="170" y2="90" stroke="#000"/>
<line x1="340" y1="150" x2="120" y2="150" stroke="#000"/>
<text x="158" y="228" font-size="14" font-style="italic">A</text>
<text x="292" y="228" font-size="14" font-style="italic">B</text>
<text x="346" y="154" font-size="14" font-style="italic">C</text>
<text x="292" y="86" font-size="14" font-style="italic">D</text>
<text x="156" y="86" font-size="14" font-style="italic">E</text>
<text x="102" y="154" font-size="14" font-style="italic">F</text>
<text x="150" y="128" font-size="13" font-style="italic">a</text>
<text x="304" y="128" font-size="13" font-style="italic">a</text>
<text x="248" y="186" font-size="13" font-style="italic" fill="#fff">a</text>
</svg>"""

# uloha 12: sloupcovy graf prirustku/ubytku obyvatel (Lidov, Damov, Panov, 2019-2022)
def _popgraph():
    years = ['2019', '2020', '2021', '2022']
    L = [10, 5, -5, 5]; D = [-5, -10, 10, 5]; P = [-10, 5, 10, 10]
    y0, unit, bw = 170, 8, 24
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 330" font-family="sans-serif">']
    s.append('<defs><pattern id="hatch" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><line x1="0" y1="0" x2="0" y2="6" stroke="#333" stroke-width="1.6"/></pattern></defs>')
    s.append(f'<line x1="60" y1="{y0-125}" x2="60" y2="{y0+125}" stroke="#000"/>')
    s.append(f'<line x1="60" y1="{y0}" x2="520" y2="{y0}" stroke="#000"/>')
    for v in [5, 10, 15]:
        for yy in (y0 - v*unit, y0 + v*unit):
            s.append(f'<line x1="56" y1="{yy}" x2="60" y2="{yy}" stroke="#000"/><text x="52" y="{yy+4}" font-size="11" text-anchor="end">{v}</text>')
    gx = 90
    for gi in range(4):
        vals = [L[gi], D[gi], P[gi]]
        fills = ['#eeeeee', 'url(#hatch)', '#8a8a8a']
        bx = gx
        for vi, v in enumerate(vals):
            h = abs(v)*unit
            ytop = y0 - h if v > 0 else y0
            s.append(f'<rect x="{bx}" y="{ytop}" width="{bw}" height="{h}" fill="{fills[vi]}" stroke="#000"/>')
            bx += bw + 4
        s.append(f'<text x="{gx+40}" y="{y0+145}" font-size="12" text-anchor="middle">{years[gi]}</text>')
        gx += 3*bw + 8 + 26
    s.append(f'<text x="22" y="{y0-72}" font-size="11" text-anchor="middle" transform="rotate(-90 22 {y0-72})">prirustek</text>')
    s.append(f'<text x="22" y="{y0+72}" font-size="11" text-anchor="middle" transform="rotate(-90 22 {y0+72})">ubytek</text>')
    for li, (nm, fl) in enumerate([('Lidov', '#eeeeee'), ('Damov', 'url(#hatch)'), ('Panov', '#8a8a8a')]):
        yy = 25 + li*20
        s.append(f'<rect x="430" y="{yy}" width="14" height="14" fill="{fl}" stroke="#000"/><text x="450" y="{yy+12}" font-size="12">{nm}</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _popgraph()

# uloha 14: pyramida s patry (schematicky), stridani cernych a bilych schodu
def _pyramid():
    yb, yt, n = 190, 40, 5
    exl = lambda y: 60 + (110-60)*(yb-y)/(yb-yt)
    exr = lambda y: 300 - (300-250)*(yb-y)/(yb-yt)
    dy = (yb-yt)/n
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 230" font-family="sans-serif">']
    s.append('<polygon points="60,190 300,190 250,40 110,40" fill="none" stroke="#000"/>')
    for i in range(1, n):
        y = yb - i*dy
        s.append(f'<line x1="{exl(y):.0f}" y1="{y:.0f}" x2="{exr(y):.0f}" y2="{y:.0f}" stroke="#999"/>')
    for i in range(n):
        ym = yb - i*dy - dy/2
        s.append(f'<text x="305" y="{ym+4:.0f}" font-size="12">{i+1}.</text>')
        col = '#000' if i % 2 == 0 else '#fff'
        xl = exl(ym)
        s.append(f'<rect x="{xl-6:.0f}" y="{ym-6:.0f}" width="12" height="12" fill="{col}" stroke="#000"/>')
    s.append('<text x="180" y="215" font-size="12" text-anchor="middle">schematicky nakres pyramidy</text>')
    s.append('</svg>')
    return "".join(s)
SVG14 = _pyramid()

B = ['zs1']  # 5. rocnik ZS (prijimacky na osmilete obory)

PROBLEMS = [
    {'name': 'CERMAT M5A 2024 - uloha 1.1', 'zad': ['Vypocitejte: $5\\cdot 115+(232+21\\cdot 8):(5+60:3)=$'], 'opts': None, 'ln': 2,
     'sol': ['$5\\cdot 115=575$; $232+21\\cdot 8=232+168=400$; $5+60:3=5+20=25$; $400:25=16$; celkem $575+16=591$.'],
     'ans': '$591$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 1.2', 'zad': ['Vypocitejte: $(128+16:4-32):(30+5\\cdot 13-9\\cdot 5)-1=$'], 'opts': None, 'ln': 2,
     'sol': ['$128+16:4-32=128+4-32=100$; $30+5\\cdot 13-9\\cdot 5=30+65-45=50$; $100:50=2$; $2-1=1$.'],
     'ans': '$1$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 2', 'zad': [
        'Najdete a napiste jednu cislici, kterou lze nahradit vsechny hvezdicky tak, aby vypocet byl spravny (viz obrazek).',
        'Do zaznamoveho archu uvedte pouze chybejici cislici.'],
     'opts': None, 'ln': 2, 'svg': SVG2, 'fn': 'scitani.svg',
     'alt': 'Svisle scitani dvou ctyrciferných cisel s hvezdickami na miste chybejicich cislic.', 'cap': 'Scitani s chybejicimi cislicemi',
     'sol': ['Hvezdicky nahradime cislici $6$: $1764+6847=8611$. Soucet i oba scitance pak souhlasi.'],
     'ans': '$6$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B+['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 3', 'zad': [
        'V souctovem trojuhelniku plati, ze soucet dvou cisel, ktera jsou v radku vedle sebe, je vzdy zapsan o radek nize do ramecku, ktery s temito obema cisly sousedi. Napriklad z cisel $1$, $2$, $3$ vznikne v dalsim radku $3$ a $5$ a nakonec $8$.',
        'V souctovem trojuhelniku na obrazku patri do obou sedych poli stejne cislo.',
        'Jake cislo musi byt v obou sedych polich?'],
     'opts': None, 'ln': 2, 'svg': SVG3, 'fn': 'souctovy-trojuhelnik.svg',
     'alt': 'Souctovy trojuhelnik: horni radek 7 a dve seda pole, prostredni radek dve prazdna pole, dole cislo 25.', 'cap': 'Souctovy trojuhelnik',
     'sol': ['Oznacme hledane cislo $x$. V prvnim radku jsou cisla $7$, $x$, $x$. Ve druhem radku vzniknou $7+x$ a $2x$, ve tretim radku pak $(7+x)+2x=7+3x$. Plati $7+3x=25$, tedy $3x=18$ a $x=6$.'],
     'ans': '$6$', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B+['aritmetika', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 4.1', 'zad': [
        'Zuzanka koupila darek a krabicku, do ktere ho chtela zabalit. Celkova cena za darek i krabicku byla $84$ Kc. Darek byl o $72$ Kc drazsi nez krabicka.',
        'Kolikrat je darek drazsi nez krabicka?'],
     'opts': None, 'ln': 2,
     'sol': ['Krabicka stoji $k$, darek $k+72$. Plati $k+(k+72)=84$, tedy $2k=12$ a $k=6$ Kc. Darek stoji $78$ Kc. Pomer $78:6=13$.'],
     'ans': '$13$krat', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},
    {'name': 'CERMAT M5A 2024 - uloha 4.2', 'zad': [
        'Lukas ma svuj ucet, na ktery mu maminka pravidelne posila kapesne a on sam si tam uklada vsechny sve nasetrene penize. K narozeninam dostal od babicky $500$ Kc. Ty pouzil na koupi knizky, ktera stala $186$ Kc, a zbyle penize si ulozil na ucet. Pote mu na ucet maminka poslala kapesne $150$ Kc a Lukas druhy den z uctu vybral $263$ Kc na darek pro tatinka. Na uctu mu pak zbylo $470$ Kc.',
        'Kolik penez mel Lukas na uctu pred narozeninami, pokud k jinym pohybum na uctu nedoslo?'],
     'opts': None, 'ln': 2,
     'sol': ['Na ucet pribylo $500-186=314$ Kc a $150$ Kc, ubylo $263$ Kc. Pred narozeninami mel $x$; $x+314+150-263=470$, tedy $x+201=470$ a $x=269$ Kc.'],
     'ans': '$269$ Kc', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B+['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},
    {'name': 'CERMAT M5A 2024 - uloha 4.3', 'zad': [
        'V utery rano meli v obchode bednu plnou jablek. Dopoledne z jablek v teto bedne prodali jednu petinu a do konce dne jeste $20$ kusu. Pote jim na druhy den v bedne zustaly dve petiny jablek.',
        'Kolik jablek bylo v utery rano v plne bedne?'],
     'opts': None, 'ln': 2,
     'sol': ['Celkem $x$ jablek. Prodali $\\frac{1}{5}x$ a dalsich $20$, zbyly $\\frac{2}{5}x$. Tedy $x-\\frac{1}{5}x-20=\\frac{2}{5}x$, odtud $\\frac{2}{5}x=20$ a $x=50$.'],
     'ans': '$50$ jablek', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2024 - uloha 5.1', 'zad': [
        'Doplnte do ramecku takove cislo, aby platila rovnost.',
        '$1$ hodina $+$ $20$ minut $=$ ____ sekund'],
     'opts': None, 'ln': 2,
     'sol': ['$1$ hodina $+$ $20$ minut $=80$ minut. Protoze $1$ minuta $=60$ sekund, je to $80\\cdot 60=4800$ sekund.'],
     'ans': '$4800$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 5.2', 'zad': [
        'Doplnte do ramecku takove cislo, aby platila rovnost.',
        '$\\frac{1}{2}$ metru $+$ ____ milimetru $=$ $1$ metr $-$ $26$ centimetru'],
     'opts': None, 'ln': 2,
     'sol': ['Prava strana: $1$ m $-$ $26$ cm $=100$ cm $-$ $26$ cm $=74$ cm $=740$ mm. Vlevo $\\frac{1}{2}$ m $=500$ mm. Doplnime $740-500=240$ mm.'],
     'ans': '$240$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 6', 'zad': [
        'Na ciselne ose je vyznaceno $12$ shodnych useku, cisla $44$ a $110$ a neznama cisla $X$ a $Y$ (viz obrazek).',
        '6.1 Urcete neznama cisla $X$ a $Y$.',
        '6.2 Na ciselne ose vyznacte nulu.'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'ciselna-osa.svg',
     'alt': 'Ciselna osa s 12 shodnymi useky; vyznacena jsou cisla X, 44, Y a 110.', 'cap': 'Ciselna osa (schematicky nakres)',
     'sol': ['Mezi cisly $44$ a $110$ lezi $6$ useku, jeden usek odpovida $(110-44):6=11$. $X$ lezi o $2$ useky vlevo od $44$: $X=44-2\\cdot 11=22$. $Y$ lezi o $3$ useky vpravo od $44$: $Y=44+3\\cdot 11=77$.',
            '6.2 Nula je o $2$ useky vlevo od cisla $X=22$, tj. na levem krajnim dilku osy ($22-2\\cdot 11=0$).'],
     'ans': '6.1: $X=22$, $Y=77$; 6.2: nula lezi o dva useky vlevo od $X$ (na levem konci osy)',
     'pts': 4, 'mins': 4, 'diff': '3',
     'codes': B+['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 7 (konstrukce)', 'zad': [
        'V rovine lezi primka $p$ a mimo ni body $A$ a $S$ (viz obrazek). Bod $A$ je vrchol obdelniku $ABCD$. Bod $S$ je stred strany $AB$ tohoto obdelniku. Na primce $p$ lezi bod $Q$, stred nektere ze sousednich stran strany $AB$ tohoto obdelniku.',
        '7.1 Sestrojte vrchol $B$.',
        '7.2 Na primce $p$ najdete a popiste stred $Q$ dalsi strany obdelniku, sestrojte a popiste vrcholy $C$ a $D$ a obdelnik $ABCD$ narysujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'primka-p-body-AS.svg',
     'alt': 'Primka p a mimo ni body A a S.', 'cap': 'Vychozi obrazek k uloze 7',
     'sol': ['7.1 Bod $S$ je stred strany $AB$, proto $B$ je obrazem bodu $A$ ve stredove soumernosti se stredem $S$: lezi na poloprimce $AS$ tak, ze $|SB|=|SA|$.',
            '7.2 Strany $AD$ a $BC$ jsou kolme k $AB$. Stred $Q$ jedne z nich lezi na primce $p$. Sestrojime kolmici k $AB$ v bode $A$ (resp. v bode $B$); jeji prusecik s primkou $p$ je bod $Q$. Vrchol $D$ (resp. $C$) dopocteme tak, aby $Q$ byl stred strany $AD$ (resp. $BC$), tj. $|AD|=2|AQ|$. Uloha ma dve reseni.'],
     'ans': 'Dve reseni: $B$ je obraz $A$ ve stredove soumernosti podle $S$; $Q$ je prusecik primky $p$ s kolmici k $AB$ v bode $A$, resp. v bode $B$; obdelnik $ABCD$ se dvema polohami $C$, $D$ - viz obrazek v klici.',
     'pts': 6, 'mins': 10, 'diff': '4',
     'codes': B+['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 8', 'zad': [
        'Ve ctvercove siti jsou nakresleny dva obrazce $A$ a $B$, jejichz vrcholy lezi v mrizovych bodech. Kazdy ctverecek ctvercove site ma stranu delky $1$ cm a obsah $1$ cm2 (viz obrazek).',
        'Rozhodnete o kazdem z tvrzeni 8.1-8.3, zda je pravdive (A), ci nikoli (N).',
        '8.1 Obsahy obou obrazcu si jsou rovny.',
        '8.2 Obsah obrazce $A$ je $11$ cm2.',
        '8.3 Obvod obrazce $B$ je $16$ cm.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'obrazce-AB.svg',
     'alt': 'Ctvercova sit se dvema obrazci A a B, jejich vrcholy lezi v mrizovych bodech.', 'cap': 'Obrazce A a B ve ctvercove siti (schematicky nakres)',
     'sol': ['8.1 Obsah obrazce $A$ je $11$ cm2, obsah obrazce $B$ je jiny, obsahy si tedy nejsou rovny -> Ne.',
            '8.2 Obrazec $A$ pokryva plochu $11$ cm2 -> Ano.',
            '8.3 Obvod obrazce $B$ neni $16$ cm -> Ne.'],
     'ans': '8.1: Ne; 8.2: Ano; 8.3: Ne', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B+['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 9', 'zad': [
        'Tereza a jeji kamaradka Nikola pisi novorocni prani. Vsechna prani maji stejny text a kazda z divek pise stalou rychlosti. Tereza za kazdych $5$ minut napise $14$ novorocenek, zatimco Nikola $10$.',
        'Za jak dlouho spolecne napisi $120$ novorocnich prani?'],
     'opts': ['A) za $24$ minut', 'B) za $25$ minut', 'C) za $30$ minut', 'D) za $32$ minut', 'E) za jiny pocet minut'], 'ln': 0,
     'sol': ['Za $5$ minut napisi spolecne $14+10=24$ prani. $120:24=5$, potrebuji tedy $5\\cdot 5=25$ minut.'],
     'ans': 'B) za $25$ minut', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2024 - uloha 10', 'zad': [
        'Ctverce A-E jsou rozdeleny uhloprickami na ctyri trojuhelniky; v kazdem je jeden trojuhelnik vybarveny a je v nem sipka (viz obrazek).',
        'Ktery z uvedenych obrazku (A-E) logicky nepatri mezi ostatni?'],
     'opts': ['A) obrazek A', 'B) obrazek B', 'C) obrazek C', 'D) obrazek D', 'E) obrazek E'], 'ln': 0,
     'svg': SVG10, 'fn': 'ctverce-sipky.svg',
     'alt': 'Pet ctvercu rozdelenych uhloprickami s vybarvenym trojuhelnikem a sipkou.', 'cap': 'Obrazky A-E (schematicky nakres, orientace dle testoveho sesitu)',
     'sol': ['Porovnanim vzajemne polohy vybarveneho trojuhelniku a sipky v jednotlivych ctvercich zjistime, ze pravidlu nevyhovuje obrazek $C$.'],
     'ans': 'C) obrazek C', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B+['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 11', 'zad': [
        'Mame sestiuhelnik $ABCDEF$, ktery lze useckami $AD$, $BE$ a $CF$ rozdelit na sest shodnych rovnoramennych trojuhelniku. Body $A$, $B$, $D$ a $E$ lezi ve vrcholech obdelniku. Obsah tmave casti sestiuhelniku je $112$ cm2 (viz obrazek).',
        'Jaky je obsah bile casti sestiuhelniku?'],
     'opts': ['A) $28$ cm2', 'B) $112$ cm2', 'C) $196$ cm2', 'D) $224$ cm2', 'E) jiny obsah'], 'ln': 0,
     'svg': SVG11, 'fn': 'sestiuhelnik.svg',
     'alt': 'Sestiuhelnik ABCDEF rozdeleny na sest shodnych trojuhelniku, dva z nich jsou tmave.', 'cap': 'Sestiuhelnik rozdeleny na sest shodnych trojuhelniku',
     'sol': ['Sestiuhelnik tvori $6$ shodnych trojuhelniku. Tmava cast jsou $2$ trojuhelniky o obsahu $112$ cm2, jeden trojuhelnik ma tedy $56$ cm2. Bilou cast tvori zbyle $4$ trojuhelniky: $4\\cdot 56=224$ cm2.'],
     'ans': 'D) $224$ cm2', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B+['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2024 - uloha 12', 'zad': [
        'Graf znazornuje prirustek a ubytek obyvatel v obcich Lidov, Damov a Panov v letech 2019-2022 (viz obrazek).',
        '12.1 Jak se zmenil pocet obyvatel v Panove behem roku 2021? (A) Ubylo $5$ obyvatel; (B) Ubylo $10$ obyvatel; (C) Pocet obyvatel se nezmenil; (D) Pribylo $5$ obyvatel; (E) Pribylo $10$ obyvatel.',
        '12.2 Jestlize na pocatku ctyrleteho obdobi $1$. ledna $2019$ zilo v Lidove $300$ obyvatel, kolik obyvatel zilo ve stejne obci po trech letech $31$. prosince $2021$? (A) $290$; (B) $295$; (C) $305$; (D) $310$; (E) $315$.',
        '12.3 Jak se zmenil pocet obyvatel v Damove za vsechny ctyri roky dohromady? (A) Ubylo $5$ obyvatel; (B) Pocet obyvatel se nezmenil; (C) Pribylo $5$ obyvatel; (D) Pribylo $15$ obyvatel; (E) Jiny vysledek.'],
     'opts': None, 'ln': 0, 'svg': SVG12, 'fn': 'graf-obyvatel.svg',
     'alt': 'Sloupcovy graf prirustku a ubytku obyvatel obci Lidov, Damov a Panov v letech 2019 az 2022.', 'cap': 'Prirustek a ubytek obyvatel (2019-2022)',
     'sol': ['12.1 Panov ma v roce $2021$ sloupec $+10$, pribylo tedy $10$ obyvatel -> E.',
            '12.2 Lidov: $2019$ pribylo $10$, $2020$ pribylo $5$, $2021$ ubylo $5$. $300+10+5-5=310$ -> D.',
            '12.3 Damov: $2019$ $-5$, $2020$ $-10$, $2021$ $+10$, $2022$ $+5$; celkem $-5-10+10+5=0$, pocet se nezmenil -> B.'],
     'ans': '12.1: E (pribylo $10$ obyvatel); 12.2: D ($310$); 12.3: B (pocet obyvatel se nezmenil)',
     'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B+['statistika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2024 - uloha 13', 'zad': [
        'Pan Josef jel autem z Heraltic do Trebice stalou rychlosti a cesta mu trvala $24$ minut. V $7{:}08$ byl v jedne tretine cesty. V polovine cesty projel pres zeleznicni prejezd.',
        'Ke kazde poduloze (13.1-13.3) priradte spravny vysledek (A-F).',
        '13.1 V kolik hodin pan Josef vyjel?',
        '13.2 V kolik hodin prejel pan Josef zeleznicni prejezd?',
        '13.3 V kolik hodin by pan Josef prijel, kdyby vyjel o $6$ minut pozdeji?'],
     'opts': ['A) $7{:}30$', 'B) $7{:}24$', 'C) $7{:}12$', 'D) $7{:}08$', 'E) $7{:}00$', 'F) $6{:}52$'], 'ln': 0,
     'sol': ['Tretina cesty je $24:3=8$ minut. V $7{:}08$ ujel $8$ minut, vyjel tedy v $7{:}00$ -> 13.1: E.',
            'Polovina cesty je $12$ minut, prejezd projel v $7{:}00+12$ min $=7{:}12$ -> 13.2: C.',
            'Kdyby vyjel v $7{:}06$, prijel by v $7{:}06+24$ min $=7{:}30$ -> 13.3: A.'],
     'ans': '13.1: E ($7{:}00$); 13.2: C ($7{:}12$); 13.3: A ($7{:}30$)',
     'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B+['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2024 - uloha 14', 'zad': [
        'Pyramida postavena z kostek stavebnice muze mit libovolny pocet pater. Kazde patro pyramidy ma stejnou vysku. Do prvniho, druheho a kazdeho dalsiho patra vede vzdy stejny pocet schodu. Zdola do prvniho patra vedou vzdy cerne schody, do druheho patra bile schody a takto se rovnez ve vyssich patrech obe barvy schodu pravidelne stridaji. Napriklad pyramida na obr. 1 ma $6$ cernych a $4$ bile schody, pyramida na obr. 2 ma $6$ cernych a $3$ bile schody (viz obrazek).',
        '14.1 Pyramida s $8$ patry ma celkem $48$ cernych schodu. Kolik schodu vede do prvniho patra?',
        '14.2 Pyramida se $7$ patry ma celkem $84$ bilych schodu. Jaky je celkovy pocet schodu v pyramide?',
        '14.3 V pyramide s $90$ schody ma $27$. schod stejnou barvu jako $30$. schod, ale jinou barvu nez $33$. schod. Jaky je nejvetsi mozny pocet pater v teto pyramide?'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'pyramida.svg',
     'alt': 'Schematicky nakres pyramidy s patry a se schody, ktere pravidelne stridaji cernou a bilou barvu.', 'cap': 'Pyramida s patry (schematicky nakres)',
     'sol': ['Do kazdeho patra vede stejny pocet schodu, oznacme jej $s$; licha patra jsou cerna, suda bila.',
            '14.1 Mezi $8$ patry jsou $4$ cerna (1., 3., 5., 7.): $4s=48$, tedy $s=12$ schodu do prvniho patra.',
            '14.2 Mezi $7$ patry jsou $3$ bila (2., 4., 6.): $3s=84$, tedy $s=28$. Celkem $7\\cdot 28=196$ schodu.',
            '14.3 Celkem $90$ schodu, $s$ deli $90$ a pocet pater je $90:s$; nejvetsi pocet pater znamena nejmensi $s$. Pro $s=5$ lezi $27$. i $30$. schod v $6$. patre (bile) a $33$. schod v $7$. patre (cerne), podminka plati; delitele $1$, $2$, $3$ ji nesplni. Nejvetsi pocet pater je $90:5=18$.'],
     'ans': '14.1: $12$; 14.2: $196$; 14.3: $18$', 'pts': 6, 'mins': 8, 'diff': '4',
     'codes': B+['posloupnosti', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PAD24C0T01'
    gen.YEAR = 2024

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP nazev: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Neparovy $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakazany znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrazek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'uloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
