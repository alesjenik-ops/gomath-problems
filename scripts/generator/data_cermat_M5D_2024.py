# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2024, MATEMATIKA 5D (osmilete obory, 5. rocnik), 1. termin.
# Kod testu: M5PDD24C0T04. 14 uloh, 50 bodu.
# Po rozdeleni izolovanych poduloh: 18 uloh.
# Zdroj odpovedi: klic spravnych reseni (KSR) - MATEMATIKA 5D, kod M5PDD24C0T04.

import math

# ---------------- SVG obrazky (bez apostrofu a zpetnych lomitek) ----------------

# uloha 3: retezec ramecku s operacemi ...3, :2, -6, ...12, -8 -> 28
def _flow3():
    labels = ['·3', ':2', '-6', '·12', '-8']
    xs = [20, 130, 240, 350, 460, 570]
    texts = ['x', '', '', '', '', '28']
    bw, bh, y = 60, 44, 33
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 110" font-family="sans-serif">']
    for i, x in enumerate(xs):
        s.append(f'<rect x="{x}" y="{y}" width="{bw}" height="{bh}" fill="none" stroke="#000"/>')
        if texts[i]:
            st = ' font-style="italic"' if texts[i] == 'x' else ''
            s.append(f'<text x="{x+bw/2}" y="{y+28}" font-size="18" text-anchor="middle"{st}>{texts[i]}</text>')
    for i, lab in enumerate(labels):
        x1 = xs[i] + bw; x2 = xs[i+1]; ym = y + bh/2
        s.append(f'<line x1="{x1}" y1="{ym}" x2="{x2}" y2="{ym}" stroke="#000"/>')
        s.append(f'<polygon points="{x2},{ym} {x2-8},{ym-4} {x2-8},{ym+4}" fill="#000"/>')
        s.append(f'<text x="{(x1+x2)/2}" y="{ym-8}" font-size="14" text-anchor="middle">{lab}</text>')
    s.append('</svg>')
    return "".join(s)
SVG3 = _flow3()

# uloha 6: pruh 10 dilku + obdelnik vymezeny dilky (nahore a dole 3, po stranach 2)
def _rect6():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 235" font-family="sans-serif">']
    ox, oy, pl, pt = 25, 22, 27, 14
    for i in range(10):
        s.append(f'<rect x="{ox+i*pl}" y="{oy}" width="{pl}" height="{pt}" fill="#c9c9c9" stroke="#000"/>')
    s.append(f'<text x="{ox+5*pl}" y="{oy-6}" font-size="11" text-anchor="middle">pruh: 10 stejnych dilku</text>')
    bx, by, L, T = 75, 75, 50, 18
    for i in range(3):
        s.append(f'<rect x="{bx+i*L}" y="{by}" width="{L}" height="{T}" fill="#c9c9c9" stroke="#000"/>')
        s.append(f'<rect x="{bx+i*L}" y="{by+2*L+T}" width="{L}" height="{T}" fill="#c9c9c9" stroke="#000"/>')
    for i in range(2):
        s.append(f'<rect x="{bx}" y="{by+T+i*L}" width="{T}" height="{L}" fill="#c9c9c9" stroke="#000"/>')
        s.append(f'<rect x="{bx+3*L-T}" y="{by+T+i*L}" width="{T}" height="{L}" fill="#c9c9c9" stroke="#000"/>')
    s.append(f'<text x="{bx+1.5*L}" y="{by-6}" font-size="11" text-anchor="middle">delsi strana = 51 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG6 = _rect6()

# uloha 7: vychozi body D, C (nahore) a A (pod D) - rovnoramenny pravouhly trojuhelnik, pravy uhel u D
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 330" font-family="sans-serif">
<text x="52" y="42" font-size="16" font-style="italic">D</text>
<text x="60" y="60" font-size="16" text-anchor="middle">×</text>
<text x="300" y="42" font-size="16" font-style="italic">C</text>
<text x="300" y="60" font-size="16" text-anchor="middle">×</text>
<text x="52" y="306" font-size="16" font-style="italic">A</text>
<text x="60" y="292" font-size="16" text-anchor="middle">×</text>
</svg>"""

# uloha 8: ctvercova sit 5x4, obdelnik ABCD, tmavy obrazec (schematicky)
def _grid8():
    ox, oy, c, W, H = 20, 20, 34, 5, 4
    gray = [(1, 0), (3, 0), (0, 1), (3, 1), (4, 1), (2, 2), (1, 3), (3, 3), (2, 1)]
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+W*c} {oy*2+H*c}" font-family="sans-serif">']
    for (cx, cy) in gray:
        s.append(f'<rect x="{ox+cx*c}" y="{oy+cy*c}" width="{c}" height="{c}" fill="#9a9a9a"/>')
    for i in range(W+1):
        s.append(f'<line x1="{ox+i*c}" y1="{oy}" x2="{ox+i*c}" y2="{oy+H*c}" stroke="#777"/>')
    for j in range(H+1):
        s.append(f'<line x1="{ox}" y1="{oy+j*c}" x2="{ox+W*c}" y2="{oy+j*c}" stroke="#777"/>')
    s.append(f'<rect x="{ox}" y="{oy}" width="{W*c}" height="{H*c}" fill="none" stroke="#000" stroke-width="2.5"/>')
    s.append(f'<text x="{ox+4}" y="{oy+15}" font-size="13" font-style="italic">D</text>')
    s.append(f'<text x="{ox+W*c-13}" y="{oy+15}" font-size="13" font-style="italic">C</text>')
    s.append(f'<text x="{ox+4}" y="{oy+H*c-5}" font-size="13" font-style="italic">A</text>')
    s.append(f'<text x="{ox+W*c-13}" y="{oy+H*c-5}" font-size="13" font-style="italic">B</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _grid8()

# uloha 10: vizualni logicka uloha - schematicka poznamka
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 120" font-family="sans-serif">
<text x="280" y="52" font-size="13" text-anchor="middle">Pet obrazku A-E slozenych z obdelniku a ctverecku s teckami (viz testovy sesit).</text>
<text x="280" y="80" font-size="11" text-anchor="middle" fill="#666">Vizualni logickou ulohu nelze verne prenest do SVG; posuzuje se podle originalu.</text>
</svg>"""

# uloha 11: kruhovy diagram - jablka 5, hrusky 3, cibule 1, mrkev 1 (10 dilu)
def _pie11():
    cx, cy, r = 170, 150, 110
    parts = [('jablka: 5 dilu', 5, '#9a9a9a'), ('hrusky: 3 dily', 3, '#c9c9c9'),
             ('cibule: 1 dil', 1, '#e6e6e6'), ('mrkev: 1 dil', 1, '#f4f4f4')]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">']
    ang = -90.0
    for label, val, col in parts:
        a2 = ang + val/10*360
        x1 = cx + r*math.cos(math.radians(ang)); y1 = cy + r*math.sin(math.radians(ang))
        x2 = cx + r*math.cos(math.radians(a2)); y2 = cy + r*math.sin(math.radians(a2))
        large = 1 if (a2-ang) > 180 else 0
        s.append(f'<path d="M {cx} {cy} L {x1:.1f} {y1:.1f} A {r} {r} 0 {large} 1 {x2:.1f} {y2:.1f} Z" fill="{col}" stroke="#000"/>')
        ang = a2
    for i, (label, val, col) in enumerate(parts):
        yy = 60 + i*26
        s.append(f'<rect x="310" y="{yy}" width="16" height="16" fill="{col}" stroke="#000"/>')
        s.append(f'<text x="332" y="{yy+13}" font-size="13">{label}</text>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _pie11()

# uloha 13: sloupcovy graf - denni sber (jablka, hrusky, hroznove vino)
def _bars13():
    data = [('pondeli', 100, 150, 50), ('utery', 100, 100, 100), ('streda', 75, 175, 100),
            ('ctvrtek', 100, 125, 100), ('patek', 50, 200, 150), ('sobota', 0, 0, 300), ('nedele', 0, 0, 325)]
    x0, y0, sc, bw, grp = 55, 300, 270/350, 13, 10
    cols = ['#cccccc', '#888888', '#333333']
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 335" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="600" y2="{y0}" stroke="#000"/>')
    for v in range(0, 351, 50):
        yy = y0 - v*sc
        s.append(f'<line x1="{x0-4}" y1="{yy:.1f}" x2="{x0}" y2="{yy:.1f}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{yy+4:.1f}" font-size="10" text-anchor="end">{v}</text>')
    x = x0 + 16
    for name, j, h, v in data:
        for idx, val in enumerate((j, h, v)):
            if val > 0:
                bh = val*sc
                s.append(f'<rect x="{x+idx*bw}" y="{y0-bh:.1f}" width="{bw}" height="{bh:.1f}" fill="{cols[idx]}" stroke="#000"/>')
        s.append(f'<text x="{x+1.5*bw}" y="{y0+14}" font-size="10" text-anchor="middle">{name}</text>')
        x += 3*bw + grp
    for i, (nm, col) in enumerate([('jablka', '#cccccc'), ('hrusky', '#888888'), ('hroznove vino', '#333333')]):
        yy = 40 + i*20
        s.append(f'<rect x="470" y="{yy}" width="14" height="14" fill="{col}" stroke="#000"/>')
        s.append(f'<text x="489" y="{yy+12}" font-size="11">{nm}</text>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _bars13()

B = ['zs1']  # 5. rocnik ZS (prijimacky na osmilete); kod r5 v taxonomii neni

PROBLEMS = [
    {'name': 'CERMAT M5D 2024 – úloha 1.1', 'zad': ['Vypočítejte: $336+336:6-45=$'], 'opts': None, 'ln': 2,
     'sol': ['Podle pořadí operací: $336:6=56$, tedy $336+56-45=347$.'], 'ans': '$347$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 1.2', 'zad': ['Vypočítejte: $(725-25\\cdot 8+500):(75:3)=$'], 'opts': None, 'ln': 2,
     'sol': ['V závorkách: $725-200+500=1025$ a $75:3=25$. Tedy $1025:25=41$.'], 'ans': '$41$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 2', 'zad': [
        'Najděte a napište jednu číslici, kterou lze nahradit všechny hvězdičky tak, aby výpočet byl správný. Jde o písemné odčítání, kde menšenec má tvar *45*, menšitel má tvar 1**4 a výsledek je $2\\,119$ (všechny hvězdičky nahraďte toutéž číslicí).',
        'Do záznamového archu uveďte pouze chybějící číslici.'],
     'opts': None, 'ln': 2,
     'sol': ['Označme hledanou číslici $c$. Menšenec je $1001c+450$, menšitel $1\\,004+110c$. Z rovnice $(1001c+450)-(1\\,004+110c)=2\\,119$ plyne $891c=2\\,673$, tedy $c=3$. Kontrola: $3\\,453-1\\,334=2\\,119$.'],
     'ans': 'číslice $3$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B+['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 3', 'zad': [
        'Provedeme-li postupně všechny početní operace uvedené nad šipkami (viz obrázek), výsledné číslo bude $28$.',
        'Vypočítejte neznámé číslo $x$ z prvního rámečku.',
        'Do záznamového archu uveďte pouze neznámé číslo $x$.'],
     'opts': None, 'ln': 2, 'svg': SVG3, 'fn': 'schema-sipky.svg',
     'alt': 'Řetězec rámečků: x, poté operace krát 3, děleno 2, minus 6, krát 12, minus 8, výsledek 28.',
     'cap': 'Výchozí obrázek k úloze 3',
     'sol': ['Postupujeme od konce zpět: $28+8=36$; $36:12=3$; $3+6=9$; $9\\cdot 2=18$; $18:3=6$. Tedy $x=6$. Kontrola: $6\\cdot 3=18$, $18:2=9$, $9-6=3$, $3\\cdot 12=36$, $36-8=28$.'],
     'ans': '$x=6$', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 4.1', 'zad': [
        'Řešte slovní úlohu. Sourozenci Ondra, Pavel a Šárka dohromady ušetřili $750$ Kč. Pokud částku, kterou našetřila Šárka, vynásobíme $5$, dostaneme stejnou částku, jako když celou našetřenou částku vydělíme počtem sourozenců.',
        'Kolik peněz našetřila Šárka?'],
     'opts': None, 'ln': 3,
     'sol': ['Celá částka vydělená počtem sourozenců je $750:3=250$ Kč. Platí $5\\cdot S=250$, kde $S$ je Šárčina částka, tedy $S=250:5=50$ Kč.'],
     'ans': '$50$ Kč', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5D 2024 – úloha 4.2', 'zad': [
        'Řešte slovní úlohu. Jana měla čokoládu, kterou lze rozdělit na $32$ stejných dílků. Rozdělila se o ni s Petrem a Kamilem a celou ji snědli. Tři osminy čokolády snědl Petr. Jana snědla o třetinu méně dílků než Petr.',
        'Kolik dílků čokolády snědl Kamil?'],
     'opts': None, 'ln': 3,
     'sol': ['Petr snědl $\\frac{3}{8}\\cdot 32=12$ dílků. Jana snědla o třetinu méně: $12-\\frac{1}{3}\\cdot 12=12-4=8$ dílků. Kamil snědl zbytek: $32-12-8=12$ dílků.'],
     'ans': '$12$ dílků', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5D 2024 – úloha 4.3', 'zad': [
        'Řešte slovní úlohu. Jaký je součet tří čísel, je-li první číslo $82$, druhé číslo je o $7$ menší než první a třetí číslo je součtem prvního a druhého?'],
     'opts': None, 'ln': 3,
     'sol': ['Druhé číslo: $82-7=75$. Třetí číslo: $82+75=157$. Součet: $82+75+157=314$.'],
     'ans': '$314$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 5.1', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost: $\\frac{1}{3}$ hodiny $-\\frac{1}{6}$ hodiny $=$ ____ sekund.'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{1}{3}$ hodiny $=1\\,200$ s, $\\frac{1}{6}$ hodiny $=600$ s. Rozdíl je $1\\,200-600=600$ sekund.'],
     'ans': '$600$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 5.2', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost: $1$ metr $-\\frac{1}{4}$ metru $=$ ____ centimetrů $+\\,250$ milimetrů.'],
     'opts': None, 'ln': 2,
     'sol': ['$1$ m $-\\frac{1}{4}$ m $=\\frac{3}{4}$ m $=75$ cm. Protože $250$ mm $=25$ cm, do rámečku patří $75-25=50$ centimetrů.'],
     'ans': '$50$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 6', 'zad': [
        'Pruh papíru byl rozstříhán na $10$ stejných dílků. Rozstříhané dílky byly nalepeny na papír podle obrázku tak, že vymezily obdélník. Delší strana obdélníku je dlouhá $51$ cm.',
        '6.1 Kolik cm měří kratší strana vymezeného obdélníku?',
        '6.2 Kolik cm měřil pruh papíru před rozstříháním?'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'pruh-obdelnik.svg',
     'alt': 'Pruh papíru rozstříhaný na deset stejných dílků a obdélník vymezený těmito dílky (nahoře a dole po třech, po stranách po dvou).',
     'cap': 'Výchozí obrázek k úloze 6 (schematický nákres)',
     'sol': ['Delší stranu tvoří $3$ dílky, jeden dílek tedy měří $51:3=17$ cm.',
             '6.1 Kratší stranu tvoří $2$ dílky: $2\\cdot 17=34$ cm.',
             '6.2 Pruh měl $10$ dílků: $10\\cdot 17=170$ cm.'],
     'ans': '6.1: $34$ cm; 6.2: $170$ cm', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B+['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 7 (konstrukce)', 'zad': [
        'Jsou dány body $A$, $C$ a $D$, které tvoří vrcholy rovnoramenného pravoúhlého trojúhelníku s rameny $AD$ a $DC$ a s pravým úhlem při vrcholu $D$ (viz obrázek).',
        '7.1 Sestrojte čtverec $ABCD$.',
        '7.2 Narýsujte přímku $p$, která prochází body $B$ a $D$. Na přímce $p$ vyznačte bod $X$, který je ve stejné vzdálenosti od bodu $B$ jako bod $D$. Na polopřímce $CB$ vyznačte bod $Y$, který je ve stejné vzdálenosti od bodu $B$ jako bod $X$. Najděte všechny body $X$ a $Y$, které odpovídají zadání.',
        '7.3 Sestrojte trojúhelník $XYB$. Narýsujte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'body-DCA.svg',
     'alt': 'Body D a C nahoře vedle sebe a bod A pod bodem D; tvoří rovnoramenný pravoúhlý trojúhelník s pravým úhlem u D.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['7.1 Čtvrtý vrchol $B$ doplníme tak, aby $ABCD$ byl čtverec, tj. úsečka $AB$ je rovnoběžná s $DC$ a úsečka $CB$ s $DA$.',
             '7.2 Přímka $p$ je přímka $BD$. Na $p$ leží dva body ve vzdálenosti $|BD|$ od $B$: bod $X_2=D$ a bod $X_1$ na opačné straně od $B$. Bod $Y$ leží na polopřímce $CB$ ve vzdálenosti $|BD|$ od $B$ (za bodem $B$).',
             '7.3 Vzniknou dva trojúhelníky $X_1YB$ a $X_2YB$ (kde $X_2=D$).'],
     'ans': 'Čtverec $ABCD$ (čtvrtý vrchol $B$); přímka $p=BD$; body $X_1$, $X_2=D$ na $p$ ve vzdálenosti $|BD|$ od $B$; bod $Y$ na polopřímce $CB$ ve vzdálenosti $|BD|$ od $B$; dvě řešení trojúhelníku $XYB$ – viz nákres v klíči.',
     'pts': 6, 'mins': 12, 'diff': '3',
     'codes': B+['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 8', 'zad': [
        'Ve čtvercové síti je nakreslen obdélník $ABCD$ s vrcholy v mřížových bodech. Tento obdélník lze rozstříhat na $20$ shodných čtverců. Obvod tohoto obdélníku je $54$ cm. V síti je vyznačen tmavý obrazec (viz obrázek).',
        'Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (Ano), či nikoli (Ne).',
        '8.1 Obsah obdélníku $ABCD$ je $180$ cm².',
        '8.2 Obvod tmavého obrazce je $69$ cm.',
        '8.3 Obsah tmavého obrazce je $90$ cm².'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'sit-obdelnik.svg',
     'alt': 'Čtvercová síť s obdélníkem ABCD (5 krát 4 čtverečky) a tmavým obrazcem uvnitř.',
     'cap': 'Schematický nákres (přesné rozmístění tmavých čtverečků viz testový sešit)',
     'sol': ['Obdélník má $20$ čtverečků uspořádaných $5\\times 4$. Z obvodu: $2\\cdot(5+4)\\cdot s=54$, tedy strana čtverečku $s=3$ cm a obsah jednoho čtverečku $9$ cm².',
             '8.1 Obsah obdélníku $=20\\cdot 9=180$ cm² → Ano.',
             '8.2 Obvod obrazce v síti je vždy sudý počet stran čtverečku, tj. násobek $6$ cm. $69$ cm není násobek $6$ cm, obvod tedy nemůže být $69$ cm → Ne.',
             '8.3 Tmavý obrazec netvoří $10$ čtverečků, jeho obsah proto není $90$ cm² → Ne.'],
     'ans': '8.1: Ano; 8.2: Ne; 8.3: Ne', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B+['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 9', 'zad': [
        'Jedno balení stavebnice obsahuje $180$ kostek. Jedna desetina těchto kostek je modrá a jedna devítina červená.',
        'Kolik takových balení kostek musíme koupit, abychom dohromady měli $190$ modrých a červených kostek?'],
     'opts': ['A) $1$', 'B) $3$', 'C) $5$', 'D) $10$', 'E) jiný výsledek'], 'ln': 0,
     'sol': ['V jednom balení je modrých $180:10=18$ a červených $180:9=20$, dohromady $38$ modrých a červených. Potřebujeme $190:38=5$ balení.'],
     'ans': 'C) $5$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5D 2024 – úloha 10', 'zad': [
        'Který z uvedených obrázků (A–E) logicky nepatří mezi ostatní? (Obrázky A–E viz testový sešit.)'],
     'opts': ['A) obrázek A', 'B) obrázek B', 'C) obrázek C', 'D) obrázek D', 'E) obrázek E'], 'ln': 0,
     'svg': SVG10, 'fn': 'obrazky-A-E.svg',
     'alt': 'Pět obrázků A až E složených z obdélníků a čtverečků s tečkami.',
     'cap': 'Výchozí obrázek k úloze 10 (schematická poznámka)',
     'sol': ['Porovnáním obrázků nepatří mezi ostatní obrázek $B$.'],
     'ans': 'B) obrázek B', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B+['planimetrie', 'porozumeni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5D 2024 – úloha 11', 'zad': [
        'Kruhový diagram znázorňuje prodej vybraného ovoce a zeleniny za uplynulý týden (jablka $5$ dílů, hrušky $3$ díly, cibule $1$ díl, mrkev $1$ díl). Cibule a hrušek se dohromady prodalo $76$ kg.',
        'Kolik kilogramů ovoce (jablek a hrušek) se za uplynulý týden celkem prodalo?'],
     'opts': ['A) $152$', 'B) $95$', 'C) $57$', 'D) $38$', 'E) jiný počet'], 'ln': 0,
     'svg': SVG11, 'fn': 'kruhovy-diagram.svg',
     'alt': 'Kruhový diagram rozdělený na 10 dílů: jablka 5 dílů, hrušky 3 díly, cibule 1 díl, mrkev 1 díl.',
     'cap': 'Prodej ovoce a zeleniny (kruhový diagram)',
     'sol': ['Cibule ($1$ díl) a hrušky ($3$ díly) tvoří $4$ díly $=76$ kg, tedy $1$ díl $=19$ kg. Jablka a hrušky ($5+3=8$ dílů): $8\\cdot 19=152$ kg.'],
     'ans': 'A) $152$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B+['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5D 2024 – úloha 12', 'zad': [
        'Dělník pracuje stále stejným tempem a vyrobí $1\\,200$ součástek za $3$ hodiny.',
        '12.1 Za jak dlouho vyrobí dělník $4\\,000$ těchto součástek? (A) za $8$ hodin; (B) za $9$ hodin; (C) za $10$ hodin; (D) za $11$ hodin; (E) za $12$ hodin.',
        '12.2 Za jak dlouho by bylo vyrobeno $12\\,000$ těchto součástek, pokud by první polovinu součástek vyráběl dělník sám a druhou polovinu ve spolupráci s kolegou, který pracuje stejným tempem jako on? (A) za $7{,}5$ hodiny; (B) za $10$ hodin; (C) za $15$ hodin; (D) za $17{,}5$ hodiny; (E) za $22{,}5$ hodiny.',
        '12.3 Kolik součástek vyrobí dva dělníci za $9$ hodin za předpokladu, že druhý dělník pracuje také stále stejným, ale polovičním tempem? (A) $1\\,800$; (B) $3\\,600$; (C) $4\\,000$; (D) $5\\,400$; (E) $7\\,200$.'],
     'opts': None, 'ln': 0,
     'sol': ['Dělník vyrobí $1\\,200:3=400$ součástek za hodinu.',
             '12.1 $4\\,000:400=10$ hodin → C.',
             '12.2 První polovina $6\\,000$ dělník sám: $6\\,000:400=15$ h; druhá polovina $6\\,000$ dva dělníci ($800$/h): $6\\,000:800=7{,}5$ h; celkem $15+7{,}5=22{,}5$ h → E.',
             '12.3 První dělník $9\\cdot 400=3\\,600$, druhý (poloviční tempo $200$/h) $9\\cdot 200=1\\,800$; celkem $3\\,600+1\\,800=5\\,400$ → D.'],
     'ans': '12.1: C) za $10$ hodin; 12.2: E) za $22{,}5$ hodiny; 12.3: D) $5\\,400$ součástek', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5D 2024 – úloha 13', 'zad': [
        'Pepa byl týden na brigádě. Graf znázorňuje, kolik nasbíral denně kilogramů jablek, hrušek a hroznového vína.',
        'Rozhodněte o každém z tvrzení 13.1–13.3, zda je pravdivé (Ano), či nikoli (Ne).',
        '13.1 Kdyby Pepa nasbíral za celý týden o $25$ kg více jablek, nasbíral by za tento týden stejně jablek jako hrušek.',
        '13.2 Z daných druhů ovoce Pepa za uvedený týden nasbíral nejvíce hroznového vína.',
        '13.3 Jedna devítina hroznového vína, které za daný týden Pepa nasbíral, je rovna jedné šestině hrušek, které za daný týden Pepa nasbíral.'],
     'opts': None, 'ln': 0, 'svg': SVG13, 'fn': 'graf-brigada.svg',
     'alt': 'Sloupcový graf denního sběru jablek, hrušek a hroznového vína od pondělí do neděle.',
     'cap': 'Denní sběr ovoce (kg) – schematická reprodukce grafu',
     'sol': ['Týdenní součty: jablka $425$ kg, hrušky $750$ kg, hroznové víno $1\\,125$ kg.',
             '13.1 Jablek by muselo být o $750-425=325$ kg více, ne o $25$ kg → Ne.',
             '13.2 Nejvíce je hroznového vína ($1\\,125$ kg) → Ano.',
             '13.3 $\\frac{1}{9}\\cdot 1\\,125=125$ a $\\frac{1}{6}\\cdot 750=125$, hodnoty jsou stejné → Ano.'],
     'ans': '13.1: Ne; 13.2: Ano; 13.3: Ano', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B+['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5D 2024 – úloha 14', 'zad': [
        'Standa se rozhodl, že bude prodávat domácí vajíčka. Koupil $99$ slepic, za které zaplatil $12\\,000$ Kč. Slepice snášely vajíčka takto: každá třetí slepice snášela vajíčko každý den ráno, každá druhá slepice ze zbývajících snášela vajíčko každý druhý den ráno a zbylé slepice snášely vajíčko každý třetí den ráno. Standa sesbíral každé odpoledne všechna snesená vajíčka a prodával jedno za $3$ Kč.',
        '14.1 Kolik vajíček sesbíral Standa za prvních šest dní?',
        '14.2 Kolik peněz Standa utržil za vajíčka, pokud prodal všechna vajíčka snesená za prvních $30$ dní?',
        '14.3 Po čtyřiceti dvou dnech musel Standa slepice prodat. Prodal je dohromady za $6\\,000$ Kč. Kolik peněz Standa utržil za slepice a vajíčka za celou dobu (za $42$ dní), pokud prodal všechna vajíčka, která slepice za $42$ dní snesly?'],
     'opts': None, 'ln': 3,
     'sol': ['Slepice se dělí na tři skupiny po $33$: skupina A ($33$ slepic) snáší každý den, skupina B ($33$) každý druhý den, skupina C ($33$) každý třetí den.',
             '14.1 Za $6$ dní: A $33\\cdot 6=198$, B $33\\cdot 3=99$, C $33\\cdot 2=66$; celkem $198+99+66=363$ vajíček.',
             '14.2 Za $30$ dní: A $33\\cdot 30=990$, B $33\\cdot 15=495$, C $33\\cdot 10=330$; celkem $1\\,815$ vajíček, tržba $1\\,815\\cdot 3=5\\,445$ Kč.',
             '14.3 Za $42$ dní: A $33\\cdot 42=1\\,386$, B $33\\cdot 21=693$, C $33\\cdot 14=462$; celkem $2\\,541$ vajíček, za ně $2\\,541\\cdot 3=7\\,623$ Kč. Se slepicemi: $7\\,623+6\\,000=13\\,623$ Kč.'],
     'ans': '14.1: $363$ vajíček; 14.2: $5\\,445$ Kč; 14.3: $13\\,623$ Kč', 'pts': 6, 'mins': 10, 'diff': '3',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PDD24C0T04'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5D-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
