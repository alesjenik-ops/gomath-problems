# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2021, MATEMATIKA 5A, 1. řádný termín.
# Kód testu: M5PAD21C0T01. 14 úloh (po rozdělení izolovaných poduúloh 17 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 3: výchozí tabulka časů závodu (h:min:s), některé buňky prázdné
def _svg3():
    labels = ['Závodník', 'Čas při startu', 'Čas v cíli', 'Výsledný čas']
    data = [
        ['A', 'B', 'C', 'D', 'E', 'F'],
        ['9:20:00', '9:20:30', '9:21:00', '9:21:30', '9:22:00', '9:22:30'],
        ['9:43:15', '9:43:05', '9:43:25', '9:43:20', '', ''],
        ['0:23:15', '', '0:22:25', '', '0:23:05', '0:22:30'],
    ]
    lw, cw, rh, ox, oy = 132, 80, 34, 8, 8
    tw = lw + 6 * cw
    W, H = ox * 2 + tw, oy * 2 + 4 * rh
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif">']
    for r in range(5):
        y = oy + r * rh
        s.append(f'<line x1="{ox}" y1="{y}" x2="{ox+tw}" y2="{y}" stroke="#000"/>')
    for x in [ox, ox + lw] + [ox + lw + (i + 1) * cw for i in range(6)]:
        s.append(f'<line x1="{x}" y1="{oy}" x2="{x}" y2="{oy+4*rh}" stroke="#000"/>')
    for r in range(4):
        y = oy + r * rh + rh / 2 + 4
        s.append(f'<text x="{ox+8}" y="{y}" font-size="13">{labels[r]}</text>')
        for c in range(6):
            v = data[r][c]
            if v:
                s.append(f'<text x="{ox+lw+c*cw+cw/2}" y="{y}" font-size="12" text-anchor="middle">{v}</text>')
    s.append('</svg>')
    return ''.join(s)
SVG3 = _svg3()

# úloha 6: zdrojový čtverec + obrazec A a obrazec B (schematický nákres schodů)
SVG6 = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 210" font-family="sans-serif">'
        '<rect x="20" y="50" width="70" height="70" fill="none" stroke="#000"/>'
        '<line x1="20" y1="50" x2="90" y2="120" stroke="#888" stroke-dasharray="3 4"/>'
        '<line x1="90" y1="50" x2="20" y2="120" stroke="#888" stroke-dasharray="3 4"/>'
        '<text x="55" y="140" font-size="12" text-anchor="middle">6 cm</text>'
        '<text x="205" y="38" font-size="13" text-anchor="middle">Obrazec A</text>'
        '<polygon points="150,55 185,55 185,90 220,90 220,125 255,125 255,160 150,160" fill="none" stroke="#000"/>'
        '<line x1="150" y1="55" x2="255" y2="160" stroke="#999"/>'
        '<text x="450" y="38" font-size="13" text-anchor="middle">Obrazec B</text>'
        '<polygon points="360,55 500,55 500,175 465,175 465,140 430,140 430,105 395,105 395,70 360,70" fill="none" stroke="#000"/>'
        '<line x1="360" y1="55" x2="500" y2="175" stroke="#999"/>'
        '<line x1="514" y1="55" x2="514" y2="175" stroke="#000"/>'
        '<text x="530" y="115" font-size="11" transform="rotate(90 530 115)" text-anchor="middle">nejdelší svislá strana</text>'
        '</svg>')

# úloha 7.1: bod A na přímce p, body K, L
SVG7_1 = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 300" font-family="sans-serif">'
          '<line x1="40" y1="250" x2="610" y2="95" stroke="#000" stroke-width="2"/>'
          '<text x="28" y="262" font-size="15" font-style="italic">p</text>'
          '<line x1="150" y1="223" x2="163" y2="214" stroke="#000" stroke-width="2"/>'
          '<text x="150" y="240" font-size="14" font-style="italic">A</text>'
          '<text x="255" y="152" font-size="14" font-style="italic">L</text>'
          '<text x="252" y="168" font-size="14" text-anchor="middle">×</text>'
          '<text x="470" y="120" font-size="14" font-style="italic">K</text>'
          '<text x="470" y="136" font-size="14" text-anchor="middle">×</text>'
          '</svg>')

# úloha 7.2: lomená čára BCDEFG (koncové body B a G s příčkou)
SVG7_2 = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 470" font-family="sans-serif">'
          '<polyline points="430,95 210,150 130,360 410,430 650,255 380,270" fill="none" stroke="#000" stroke-width="2"/>'
          '<line x1="422" y1="86" x2="438" y2="104" stroke="#000" stroke-width="2"/>'
          '<line x1="372" y1="261" x2="388" y2="279" stroke="#000" stroke-width="2"/>'
          '<text x="440" y="92" font-size="15" font-style="italic">B</text>'
          '<text x="186" y="146" font-size="15" font-style="italic">C</text>'
          '<text x="108" y="366" font-size="15" font-style="italic">D</text>'
          '<text x="406" y="452" font-size="15" font-style="italic">E</text>'
          '<text x="658" y="252" font-size="15" font-style="italic">F</text>'
          '<text x="366" y="292" font-size="15" font-style="italic">G</text>'
          '</svg>')

# úloha 8: definiční pravidla hodnot znaků ve hře
SVG8 = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 130" font-family="sans-serif">'
        '<text x="20" y="48" font-size="26">★ = ○ ○ ○</text>'
        '<text x="20" y="100" font-size="26">□ ○ = ★ ★</text>'
        '</svg>')

# úloha 9: tabulka částí hmotnosti panáčka + schematický panáček
def _svg9():
    rows = [('Čepice', '1/12', ''), ('Hlava', '1/6', ''), ('1 ruka', '1/12', ''),
            ('Trup', '1/4', ''), ('Nohy', '1/3', '72 gramů')]
    hdr = ['Dílek', 'Část hmotn.', 'Hmotnost']
    c0, c1, c2, rh, ox, oy = 110, 120, 100, 38, 8, 8
    tw = c0 + c1 + c2
    W, H = 490, oy * 2 + 6 * rh
    cxs = [ox + c0 / 2, ox + c0 + c1 / 2, ox + c0 + c1 + c2 / 2]
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif">']
    for r in range(7):
        y = oy + r * rh
        s.append(f'<line x1="{ox}" y1="{y}" x2="{ox+tw}" y2="{y}" stroke="#000"/>')
    for x in [ox, ox + c0, ox + c0 + c1, ox + tw]:
        s.append(f'<line x1="{x}" y1="{oy}" x2="{x}" y2="{oy+6*rh}" stroke="#000"/>')
    ytxt = oy + rh / 2 + 4
    for c in range(3):
        s.append(f'<text x="{cxs[c]}" y="{ytxt}" font-size="12" text-anchor="middle" font-weight="bold">{hdr[c]}</text>')
    for i, (a, b, d) in enumerate(rows):
        y = oy + (i + 1) * rh + rh / 2 + 4
        for c, v in enumerate((a, b, d)):
            if v:
                s.append(f'<text x="{cxs[c]}" y="{y}" font-size="12" text-anchor="middle">{v}</text>')
    # schematický panáček
    s.append('<rect x="407" y="26" width="26" height="8" fill="#cccccc" stroke="#000"/>')
    s.append('<circle cx="420" cy="48" r="15" fill="none" stroke="#000"/>')
    s.append('<rect x="405" y="63" width="30" height="45" fill="#cccccc" stroke="#000"/>')
    s.append('<line x1="405" y1="72" x2="375" y2="98" stroke="#000"/>')
    s.append('<line x1="435" y1="72" x2="465" y2="98" stroke="#000"/>')
    s.append('<line x1="412" y1="108" x2="402" y2="150" stroke="#000"/>')
    s.append('<line x1="428" y1="108" x2="438" y2="150" stroke="#000"/>')
    s.append('</svg>')
    return ''.join(s)
SVG9 = _svg9()

# úlohy 11 a 12: skládaný sloupcový graf prodeje (mikiny bílé dole, trička šedá nahoře)
def _svg11():
    x0, y0, k, bw = 64, 300, 8, 58
    top = y0 - 32 * k
    bars = [('A', 12, 4), ('B', 10, 20), ('C', 20, 6)]
    xs = [110, 200, 290]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 340" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="{top}" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="430" y2="{y0}" stroke="#000"/>')
    for v in range(0, 33, 4):
        y = y0 - v * k
        if v > 0:
            s.append(f'<line x1="{x0}" y1="{y}" x2="410" y2="{y}" stroke="#dddddd"/>')
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    s.append('<text x="18" y="170" font-size="12" text-anchor="middle" transform="rotate(-90 18 170)">Počet prodaných kusů</text>')
    for (lab, mik, tri), x in zip(bars, xs):
        hm, ht = mik * k, tri * k
        s.append(f'<rect x="{x}" y="{y0-hm}" width="{bw}" height="{hm}" fill="#ffffff" stroke="#000"/>')
        s.append(f'<rect x="{x}" y="{y0-hm-ht}" width="{bw}" height="{ht}" fill="#a9a9a9" stroke="#000"/>')
        s.append(f'<text x="{x+bw/2}" y="{y0+16}" font-size="12" text-anchor="middle">{lab}</text>')
    s.append('<text x="200" y="332" font-size="12" text-anchor="middle">Obchod</text>')
    s.append('<rect x="360" y="70" width="14" height="14" fill="#a9a9a9" stroke="#000"/><text x="380" y="82" font-size="12">Trička</text>')
    s.append('<rect x="360" y="92" width="14" height="14" fill="#ffffff" stroke="#000"/><text x="380" y="104" font-size="12">Mikiny</text>')
    s.append('</svg>')
    return ''.join(s)
SVG11 = _svg11()

# úloha 13: prostorová stavba – schematická poznámka
SVG13 = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 130" font-family="sans-serif">'
         '<text x="310" y="42" font-size="13" text-anchor="middle">Prostorová stavba z 16 krychliček – VZOR a Václavova stavba (viz testový sešit).</text>'
         '<text x="310" y="72" font-size="13" text-anchor="middle">Na viditelné stěny se píší čísla: zepředu 1, zezadu 2, zprava 3, zleva 4, shora 5.</text>'
         '<text x="310" y="100" font-size="11" text-anchor="middle" fill="#666">Prostorové těleso nelze věrně přenést do SVG; posuzuje se podle originálu.</text>'
         '</svg>')

# úloha 14: puntíky v 1.–5. obrazci (soustředné čtvercové rámečky)
def _dots(n):
    if n <= 0:
        return []
    if n == 1:
        return [(0, 0)]
    m = n - 1
    pts = [(i, j) for i in range(-m, m + 1) for j in range(-m, m + 1) if abs(i) == m or abs(j) == m]
    pts += _dots(n - 2)
    return pts
def _svg14():
    step, cy = 8, 90
    cx = 30
    labels = ['1.', '2.', '3.', '4.', '5.']
    dots, texts = [], []
    for n in range(1, 6):
        m = n - 1
        halfw = m * step
        centerx = cx + halfw
        for (i, j) in _dots(n):
            dots.append(f'<circle cx="{centerx+i*step}" cy="{cy+j*step}" r="2"/>')
        texts.append(f'<text x="{centerx}" y="{cy-halfw-12}">{labels[n-1]}</text>')
        cx = centerx + halfw + step * 2 + 12
    return ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 330 175">'
            '<g fill="#000">' + ''.join(dots) + '</g>'
            '<g font-family="sans-serif" font-size="12" text-anchor="middle">' + ''.join(texts) + '</g></svg>')
SVG14 = _svg14()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté); kód r5 v taxonomii není

PROBLEMS = [
    {'name': 'CERMAT M5A 2021 – úloha 1.1', 'zad': ['Vypočtěte: $(576+384):(48:4)=$'], 'opts': None, 'ln': 2,
     'sol': ['$(576+384):(48:4)=960:12=80$.'], 'ans': '$80$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2021 – úloha 1.2', 'zad': ['Vypočtěte: $980+20\\cdot(130+2\\cdot 70-60)=$'], 'opts': None, 'ln': 2,
     'sol': ['$980+20\\cdot(130+140-60)=980+20\\cdot 210=980+4\\,200=5\\,180$.'], 'ans': '$5\\,180$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2021 – úloha 2.1', 'zad': [
        'Když neznámé číslo vynásobíme třemi, dostaneme stejné číslo, jako když vydělíme třemi číslo $234$.',
        'Určete neznámé číslo.'], 'opts': None, 'ln': 2,
     'sol': ['Trojnásobek hledaného čísla se rovná $234:3=78$. Hledané číslo je proto $78:3=26$.'],
     'ans': '$26$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2021 – úloha 2.2', 'zad': [
        'Dědeček přivezl na trh plný kbelík borůvek a ráno z nich jednu šestinu prodal. Když odpoledne prodal dalších $12$ litrů borůvek, ještě mu jedna šestina kbelíku borůvek zbyla.',
        'Vypočtěte, kolik litrů borůvek zbylo v kbelíku.'], 'opts': None, 'ln': 2,
     'sol': ['Ráno prodal $\\frac{1}{6}$ kbelíku a $\\frac{1}{6}$ mu zbyla; oněch $12$ litrů proto tvoří $\\frac{4}{6}=\\frac{2}{3}$ kbelíku. Celý kbelík má $12:\\frac{2}{3}=18$ litrů, zbylo $\\frac{1}{6}$ z $18$, tj. $3$ litry.'],
     'ans': '$3$ litry', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2021 – úloha 3', 'zad': [
        'Závod mladších žáků v běhu na lyžích absolvovalo $6$ závodníků (A–F). První závodník vyběhl na trať v $9$ hodin $20$ minut, další vybíhali v půlminutových intervalech. Zvítězil závodník, který strávil na trati nejkratší dobu, tedy má nejlepší výsledný čas. (Všechny časy v tabulce jsou ve tvaru h:min:s.)',
        '3.1 Vypočtěte výsledný čas vítěze závodu (v minutách a sekundách).',
        '3.2 Určete, na kolikátém místě se umístil závodník, který proběhl cílem jako první.',
        '3.3 Uveďte písmena všech závodníků, kteří proběhli cílem později než závodník D.'],
     'opts': None, 'ln': 3, 'svg': SVG3, 'fn': 'zavod-tabulka.svg',
     'alt': 'Tabulka časů závodníků A až F: čas při startu, čas v cíli a výsledný čas; některé buňky jsou prázdné.',
     'cap': 'Časy závodníků (h:min:s)',
     'sol': ['Výsledný čas = čas v cíli - čas při startu. Doplněné výsledné časy: A 23:15, B 22:35, C 22:25, D 21:50, E 23:05, F 22:30.',
             '3.1 Nejkratší čas má D: 9:43:20 - 9:21:30 = 21 min 50 s.',
             '3.2 Cílem proběhl jako první B (čas v cíli 9:43:05); jeho výsledný čas 22:35 je čtvrtý nejlepší, umístil se na 4. místě.',
             '3.3 Později než D (9:43:20) proběhli cílem C (9:43:25), F (9:45:00) a E (9:45:05).'],
     'ans': '3.1: $21$ min $50$ s; 3.2: na 4. místě; 3.3: C, E, F', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2021 – úloha 4', 'zad': [
        'V cukrárně mají zabaleno celkem $80$ zákusků buď na táccích po $2$ zákuscích, nebo v krabičkách po $3$ zákuscích. Počet tácků se zákusky je o $10$ větší než počet krabiček se zákusky.',
        '4.1 Určete počet všech krabiček se zákusky.',
        '4.2 Určete celkový počet zákusků na táccích.'], 'opts': None, 'ln': 2,
     'sol': ['Počet krabiček $k$, počet tácků $k+10$. Zákusky: $3k+2(k+10)=80$, tj. $5k+20=80$, $5k=60$, $k=12$.',
             '4.1 Krabiček se zákusky je $12$.',
             '4.2 Tácků je $12+10=22$, na nich je $2\\cdot 22=44$ zákusků.'],
     'ans': '4.1: $12$ krabiček; 4.2: $44$ zákusků', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2021 – úloha 5', 'zad': [
        'Na pódiu má tančit stejný počet chlapců a dívek. Při tanci všichni tančící vytvoří několik velkých a několik malých kroužků. V každém velkém kroužku bude sedm chlapců a jedna dívka, v každém malém kroužku budou čtyři dívky.',
        '5.1 Určete nejmenší možný počet všech tančících (chlapců i dívek) na pódiu.',
        '5.2 Určete nejmenší možný počet malých kroužků.'], 'opts': None, 'ln': 2,
     'sol': ['Při $v$ velkých a $m$ malých kroužcích je chlapců $7v$ a dívek $v+4m$. Rovnost $7v=v+4m$ dává $3v=2m$.',
             '5.1 Nejmenší řešení je $v=2$, $m=3$: chlapců $14$, dívek $14$, celkem $28$ tančících.',
             '5.2 Malých kroužků jsou $3$.'],
     'ans': '5.1: $28$ tančících; 5.2: $3$ malé kroužky', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2021 – úloha 6', 'zad': [
        'Na vytvoření každého obrazce použijeme beze zbytku dva čtverce o straně délky $6$ cm. Čtverce rozstříháme a ze všech získaných dílů sestavíme obrazec, jehož strany (úsečky po obvodu) mají pouze dvě různé délky. (Čtverec o straně délky $6$ cm má obsah $36$ cm².)',
        '6.1 Vypočtěte v cm obvod obrazce A.',
        '6.2 Vypočtěte, kolik cm měří nejdelší svislá strana obrazce B.',
        '6.3 Určete, o kolik cm² se liší obsahy obrazců A, B.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'obrazce-ctverce.svg',
     'alt': 'Zdrojový čtverec o straně 6 cm a dva schodovité obrazce A a B sestavené ze dvou takových čtverců.',
     'cap': 'Schematický nákres (obsah čtverce 36 cm²)',
     'sol': ['Oba obrazce vzniknou z týchž dvou čtverců o obsahu $36$ cm², proto mají stejný obsah $2\\cdot 36=72$ cm².',
             '6.1 Součtem délek stran (mají jen dvě různé délky) vyjde obvod obrazce A $54$ cm.',
             '6.2 Nejdelší svislá strana obrazce B měří $8$ cm.',
             '6.3 Obsahy obou obrazců jsou stejné, liší se o $0$ cm².'],
     'ans': '6.1: $54$ cm; 6.2: $8$ cm; 6.3: o $0$ cm²', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2021 – úloha 7.1 (konstrukce)', 'zad': [
        'V rovině leží body $A$, $K$, $L$. Bodem $A$ prochází přímka $p$ (viz obrázek).',
        'Bod $A$ je vrchol obdélníku $ABCD$. Na přímce $p$ leží ještě jeden vrchol tohoto obdélníku. Bod $K$ leží uvnitř jedné strany obdélníku $ABCD$ a bod $L$ uvnitř sousední strany.',
        'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_1, 'fn': 'bod-A-primka-p.svg',
     'alt': 'Přímka p procházející bodem A a dva body K a L nad přímkou.', 'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Jeden z vrcholů sousedících s $A$ leží na přímce $p$, proto jedna strana obdélníku leží na $p$. Vrcholy $B$, $C$, $D$ sestrojíme tak, aby $ABCD$ byl obdélník, jehož dvě sousední strany procházejí danými body $K$ a $L$. Úloha má dvě řešení.'],
     'ans': 'Konstrukce obdélníku $ABCD$ s jednou stranou na přímce $p$ a stranami procházejícími body $K$, $L$; dvě řešení $AB_1C_1D_1$ a $AB_2C_2D_2$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2021 – úloha 7.2 (konstrukce)', 'zad': [
        'V rovině leží lomená čára $BCDEFG$ (viz obrázek).',
        'Body $B$, $C$ jsou vrcholy trojúhelníku $ABC$. Vrchol $A$ tohoto trojúhelníku leží na lomené čáře $BCDEFG$. Délka strany $AC$ je stejná jako délka úsečky $EF$.',
        'Sestrojte vrchol $A$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_2, 'fn': 'lomena-cara-BCDEFG.svg',
     'alt': 'Lomená čára s vrcholy B, C, D, E, F, G; koncové body B a G jsou označeny příčkou.', 'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Vrchol $A$ leží na lomené čáře $BCDEFG$ a zároveň platí $|AC|=|EF|$. Sestrojíme kružnici se středem $C$ a poloměrem $|EF|$; její průsečíky s lomenou čárou jsou hledané vrcholy $A_1$ a $A_2$. Úloha má dvě řešení.'],
     'ans': 'Průsečíky kružnice se středem $C$ a poloměrem $|EF|$ s lomenou čárou $BCDEFG$ dávají vrcholy $A_1$, $A_2$ trojúhelníku $ABC$ (dvě řešení, viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2021 – úloha 8', 'zad': [
        'V počítačové hře jsou tři znaky: hvězdička, kolečko a čtvereček. Jedna hvězdička má hodnotu tří koleček. Čtvereček a kolečko mají dohromady hodnotu dvou hvězdiček.',
        'Rozhodněte o každé z následujících rovností (8.1–8.3), zda platí (A), či nikoli (N).',
        '8.1 ★ □ □ = ★ ★ ★ ★',
        '8.2 ★ ★ ★ ★ ★ = □ □ □',
        '8.3 ★ ★ ○ = □ ★'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'znaky-hra.svg',
     'alt': 'Dvě pravidla: hvězdička se rovná třem kolečkům; čtvereček a kolečko se rovnají dvěma hvězdičkám.',
     'cap': 'Hodnoty znaků ve hře',
     'sol': ['Hodnoty (v kolečkách): hvězdička $=3$, kolečko $=1$, čtvereček $=5$ (protože čtvereček $+$ kolečko $=2$ hvězdičky $=6$).',
             '8.1 Vlevo $3+5+5=13$, vpravo $4\\cdot 3=12$; $13\\ne 12$, neplatí → N.',
             '8.2 Vlevo $5\\cdot 3=15$, vpravo $3\\cdot 5=15$; rovnost platí → A.',
             '8.3 Vlevo $3+3+1=7$, vpravo $5+3=8$; $7\\ne 8$, neplatí → N.'],
     'ans': '8.1: Ne; 8.2: Ano; 8.3: Ne', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2021 – úloha 9', 'zad': [
        'Panáček se rozloží na $6$ dílků – čepici, hlavu, každou ruku zvlášť, trup a nohy. Tabulka udává, jakou část hmotnosti panáčka tvoří jednotlivé dílky. (Např. nohy váží $72$ gramů a tvoří jednu třetinu hmotnosti panáčka.)',
        'O kolik gramů je trup panáčka těžší než čepice?'],
     'opts': ['A) o méně než 18 gramů', 'B) o 18 gramů', 'C) o 27 gramů', 'D) o 36 gramů', 'E) o 54 gramů'], 'ln': 0,
     'svg': SVG9, 'fn': 'panacek-tabulka.svg',
     'alt': 'Tabulka dílků panáčka s částmi hmotnosti (čepice 1/12, hlava 1/6, ruka 1/12, trup 1/4, nohy 1/3, nohy 72 gramů) a schematický panáček.',
     'cap': 'Části hmotnosti panáčka',
     'sol': ['Nohy tvoří $\\frac{1}{3}$ hmotnosti a váží $72$ g, celý panáček váží $72\\cdot 3=216$ g.',
             'Trup $\\frac{1}{4}\\cdot 216=54$ g, čepice $\\frac{1}{12}\\cdot 216=18$ g. Rozdíl $54-18=36$ g.'],
     'ans': 'D) o 36 gramů', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2021 – úloha 10', 'zad': [
        'Karla, Zora a Olda postupně zametli $1$ km dlouhý chodník. První část chodníku zametla Karla, Zora pak zametla dvakrát delší část než Karla a Olda zametl ještě o $100$ metrů delší část chodníku než Zora. (Každou část chodníku zametala pouze jedna osoba.)',
        'Kolik metrů chodníku zametl Olda?'],
     'opts': ['A) 460 metrů', 'B) 500 metrů', 'C) 540 metrů', 'D) 550 metrů', 'E) jiný počet metrů'], 'ln': 0,
     'sol': ['Karla $x$, Zora $2x$, Olda $2x+100$; dohromady $1000$ m: $x+2x+2x+100=1000$, tj. $5x=900$, $x=180$. Olda: $2\\cdot 180+100=460$ m.'],
     'ans': 'A) 460 metrů', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2021 – úloha 11', 'zad': [
        'Stejná trička a stejné mikiny se prodávaly ve $3$ různých obchodech (A–C) za různé ceny. Graf udává počty prodaných kusů (mikiny bílé, trička šedé).',
        'Z ceníku: cena jednoho trička v obchodě B je $180$ Kč; za prodaná trička utržili v A $1\\,000$ Kč; cena jedné mikiny v A je $500$ Kč; za prodané mikiny utržili v A $6\\,000$ Kč a v C $7\\,200$ Kč. (Ostatní údaje tabulky nejsou zadány.)',
        'Tričko se v obchodě C prodávalo o $40$ Kč levněji než v obchodě A. V obchodě B utržili za prodaná trička dohromady tolik korun jako za prodané mikiny.',
        'Kolik korun utržili v obchodě C za všechna prodaná trička?'],
     'opts': ['A) $960$ Kč', 'B) $1\\,050$ Kč', 'C) $1\\,260$ Kč', 'D) $1\\,740$ Kč', 'E) více než $1\\,740$ Kč'], 'ln': 0,
     'svg': SVG11, 'fn': 'graf-tricka-mikiny.svg',
     'alt': 'Skládaný sloupcový graf počtu prodaných kusů v obchodech A, B, C: A mikiny 12 a trička 4, B mikiny 10 a trička 20, C mikiny 20 a trička 6.',
     'cap': 'Počet prodaných kusů v obchodech A–C',
     'sol': ['V obchodě A se prodala $4$ trička za $1\\,000$ Kč, cena trička v A je tedy $250$ Kč. V obchodě C bylo tričko o $40$ Kč levnější, tj. $210$ Kč. Z grafu se v C prodalo $6$ triček, tržba $6\\cdot 210=1\\,260$ Kč.'],
     'ans': 'C) $1\\,260$ Kč', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2021 – úloha 12', 'zad': [
        'Stejná trička a stejné mikiny se prodávaly ve $3$ různých obchodech (A–C) za různé ceny. Graf udává počty prodaných kusů (mikiny bílé, trička šedé).',
        'Z ceníku: cena jednoho trička v obchodě B je $180$ Kč; za prodaná trička utržili v A $1\\,000$ Kč; cena jedné mikiny v A je $500$ Kč; za prodané mikiny utržili v A $6\\,000$ Kč a v C $7\\,200$ Kč. (Ostatní údaje tabulky nejsou zadány.)',
        'Tričko se v obchodě C prodávalo o $40$ Kč levněji než v obchodě A. V obchodě B utržili za prodaná trička dohromady tolik korun jako za prodané mikiny.',
        'O kolik korun se lišila cena jedné mikiny v obchodech B a C?'],
     'opts': ['A) o $20$ Kč', 'B) o $40$ Kč', 'C) o $60$ Kč', 'D) o $90$ Kč', 'E) ceny se nelišily'], 'ln': 0,
     'svg': SVG11, 'fn': 'graf-tricka-mikiny.svg',
     'alt': 'Skládaný sloupcový graf počtu prodaných kusů v obchodech A, B, C: A mikiny 12 a trička 4, B mikiny 10 a trička 20, C mikiny 20 a trička 6.',
     'cap': 'Počet prodaných kusů v obchodech A–C',
     'sol': ['Cena mikiny v C: $20$ mikin za $7\\,200$ Kč, tj. $360$ Kč. V obchodě B se prodalo $20$ triček po $180$ Kč za $3\\,600$ Kč; stejnou částku utržili za $10$ mikin, cena mikiny v B je také $360$ Kč. Ceny mikin v B i C se tedy nelišily.'],
     'ans': 'E) ceny se nelišily', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2021 – úloha 13', 'zad': [
        'Na podložce postavíme stavbu ze stejných krychliček. Na stěny viditelné při pohledu zepředu píšeme číslo $1$, na stěny viditelné zezadu číslo $2$, na stěny viditelné zprava číslo $3$, na stěny viditelné zleva číslo $4$ a na stěny viditelné shora číslo $5$. Na ostatní stěny žádná čísla nezapisujeme. Václav postavil na podložce stavbu ze $16$ stejných krychliček a zapsal čísla podle tohoto pravidla.',
        'Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).',
        '13.1 Jaký je součet všech zapsaných čísel $5$ (pohled shora)?',
        '13.2 Jaký je součet všech zapsaných čísel $3$ (pohled zprava)?',
        '13.3 O kolik se liší součet všech zapsaných čísel $4$ (pohled zleva) od součtu všech zapsaných čísel $1$ (pohled zepředu)?'],
     'opts': ['A) $30$', 'B) $33$', 'C) $34$', 'D) $38$', 'E) $39$', 'F) jiný počet'], 'ln': 0,
     'svg': SVG13, 'fn': 'stavba-krychlicky.svg',
     'alt': 'Schematická poznámka k prostorové stavbě ze 16 krychliček a pravidlům zápisu čísel na viditelné stěny.',
     'cap': 'Schematický nákres (prostorová stavba – viz testový sešit)',
     'sol': ['Součet zapsaných čísel dané hodnoty je roven této hodnotě vynásobené počtem příslušných viditelných stěn stavby ze $16$ krychliček.',
             '13.1 Součet čísel $5$ (pohled shora) je $30$ → A.',
             '13.2 Součet čísel $3$ (pohled zprava) je $33$ → B.',
             '13.3 Součet čísel $4$ (zleva) se od součtu čísel $1$ (zepředu) liší o $34$ → C.'],
     'ans': '13.1: A ($30$); 13.2: B ($33$); 13.3: C (o $34$)', 'pts': 5, 'mins': 7, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2021 – úloha 14', 'zad': [
        'První obrazec tvoří jediný puntík. V dalších obrazcích jsou puntíky uspořádány ve čtvercích. Strana hraničního čtverce u druhého obrazce obsahuje $3$ puntíky a u každého následujícího obrazce má vždy o $2$ puntíky více. Počínaje třetím obrazcem vidíme uvnitř hraničního čtverce vždy celý obrazec, který má pořadové číslo o $2$ menší.',
        '14.1 Určete, kolik puntíků obsahuje jedna strana hraničního čtverce $10.$ obrazce.',
        '14.2 Určete, o kolik se liší počty puntíků v $9.$ a $11.$ obrazci.',
        '14.3 Určete, u kolikátého obrazce se počty puntíků v okolních dvou obrazcích liší o $120$ (okolními rozumíme obrazec těsně před a těsně za hledaným obrazcem).'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'puntiky-obrazce.svg',
     'alt': 'První až pátý obrazec: puntíky v soustředných čtvercových rámečcích (1, 8, 17, 32 a 49 puntíků).',
     'cap': '1. až 5. obrazec',
     'sol': ['Strana hraničního čtverce $n$-tého obrazce má $2n-1$ puntíků. Od $3.$ obrazce je počet puntíků roven hraničnímu čtverci plus obrazec o dvě menší: $1, 8, 17, 32, 49, \\dots$',
             '14.1 Strana $10.$ obrazce: $2\\cdot 10-1=19$ puntíků.',
             '14.2 $11.$ obrazec má $241$, $9.$ obrazec $161$ puntíků; rozdíl $241-161=80$.',
             '14.3 Rozdíl počtů v obrazcích $n+1$ a $n-1$ je $8n$; z $8n=120$ plyne $n=15$, tedy u $15.$ obrazce.'],
     'ans': '14.1: $19$ puntíků; 14.2: o $80$ puntíků; 14.3: u $15.$ obrazce', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PAD21C0T01'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2021')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
