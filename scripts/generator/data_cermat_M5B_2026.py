# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2026, MATEMATIKA 5B, 2. řádný termín.
# Kód testu: M5PBD26C0T02. 14 úloh (po rozdělení izolovaných poduúloh 15 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR) + vyplněný záznamový arch (VZA).

import math

# ---- SVG obrázky (bez ' a \) ----

# úloha 3: tabulka 3x3 symbolů + součty řádků (vpravo) a sloupců (dole)
def _table3():
    ox = 10; oy = 10; c = 46
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 210 210" font-family="sans-serif">']
    def rect(r, cc, fill):
        out.append(f'<rect x="{ox+cc*c}" y="{oy+r*c}" width="{c}" height="{c}" fill="{fill}" stroke="#000"/>')
    def ctext(r, cc, t):
        out.append(f'<text x="{ox+cc*c+c/2}" y="{oy+r*c+c/2+7}" font-size="20" text-anchor="middle">{t}</text>')
    def dot(r, cc):
        out.append(f'<circle cx="{ox+cc*c+c/2}" cy="{oy+r*c+c/2}" r="9" fill="#000"/>')
    def sq(r, cc):
        out.append(f'<rect x="{ox+cc*c+c/2-8}" y="{oy+r*c+c/2-8}" width="16" height="16" fill="#000"/>')
    for r in range(3):
        for cc in range(3):
            rect(r, cc, "#ffffff")
    for r in range(3):
        rect(r, 3, "#e2e2e2")
    for cc in range(3):
        rect(3, cc, "#e2e2e2")
    ctext(0, 0, "♥"); ctext(0, 1, "♣"); dot(0, 2)
    dot(1, 0); sq(1, 1); sq(1, 2)
    dot(2, 0); ctext(2, 1, "♣"); ctext(2, 2, "♣")
    ctext(0, 3, "4"); ctext(1, 3, "5"); ctext(2, 3, "?")
    ctext(3, 0, "?"); ctext(3, 1, "8"); ctext(3, 2, "6")
    out.append('</svg>')
    return "".join(out)
SVG3 = _table3()

# úloha 5: papírová rulička se stuhou (bílé a červené proužky po 6 cm) – schematicky
def _roll():
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 120" font-family="sans-serif">']
    out.append('<circle cx="52" cy="60" r="34" fill="#ededed" stroke="#000"/><circle cx="52" cy="60" r="9" fill="#fff" stroke="#000"/>')
    x = 86; y = 52; h = 16; w = 26
    for k in range(12):
        fill = "#ffffff" if k % 2 == 0 else "#b0b0b0"
        out.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{fill}" stroke="#000"/>')
        x += w
    out.append('<line x1="86" y1="45" x2="112" y2="45" stroke="#000"/><text x="90" y="40" font-size="11">6 cm</text>')
    out.append('<line x1="112" y1="86" x2="138" y2="86" stroke="#000"/><text x="116" y="100" font-size="11">6 cm</text>')
    out.append('<text x="360" y="66" font-size="11" fill="#666">…</text>')
    out.append('</svg>')
    return "".join(out)
SVG5 = _roll()

# úloha 6: dvě části čtvercové sítě – vlevo šestiúhelník ABCDEF, vpravo body K, L (schematicky)
def _grid6():
    c = 26; ox = 15; oy = 15; W = 6; H = 4
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 150" font-family="sans-serif">']
    def gridlines(bx):
        for i in range(W+1):
            out.append(f'<line x1="{bx+i*c}" y1="{oy}" x2="{bx+i*c}" y2="{oy+H*c}" stroke="#bbb"/>')
        for j in range(H+1):
            out.append(f'<line x1="{bx}" y1="{oy+j*c}" x2="{bx+W*c}" y2="{oy+j*c}" stroke="#bbb"/>')
    gridlines(ox)
    hx = [(2,4),(4,3),(4,1),(2,2),(1,1),(0,3)]
    pts = " ".join(f"{ox+gx*c},{oy+gy*c}" for gx, gy in hx)
    out.append(f'<polygon points="{pts}" fill="#dfe6ef" stroke="#000" stroke-width="2"/>')
    for (gx, gy), lb in zip(hx, ["A","B","C","D","E","F"]):
        out.append(f'<text x="{ox+gx*c-4}" y="{oy+gy*c-4}" font-size="12" font-style="italic">{lb}</text>')
    bx2 = ox + W*c + 55
    gridlines(bx2)
    for (gx, gy), lb in [((2,3),"K"), ((4,2),"L")]:
        cxp = bx2 + gx*c; cyp = oy + gy*c
        out.append(f'<text x="{cxp-4}" y="{cyp+5}" font-size="14">×</text><text x="{cxp+4}" y="{cyp+16}" font-size="12" font-style="italic">{lb}</text>')
    out.append('</svg>')
    return "".join(out)
SVG6 = _grid6()

# úloha 7.1: bod P a přímka AQ (body A, Q vyznačené na přímce)
SVG71 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 250" font-family="sans-serif">
<line x1="40" y1="145" x2="395" y2="216" stroke="#000" stroke-width="2"/>
<text x="248" y="82" font-size="15" text-anchor="middle">×</text><text x="256" y="78" font-size="14" font-style="italic">P</text>
<text x="120" y="167" font-size="15" text-anchor="middle">×</text><text x="106" y="182" font-size="14" font-style="italic">A</text>
<text x="300" y="203" font-size="15" text-anchor="middle">×</text><text x="306" y="218" font-size="14" font-style="italic">Q</text>
</svg>"""

# úloha 7.2: body L, S, T
SVG72 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 250" font-family="sans-serif">
<text x="120" y="72" font-size="15" text-anchor="middle">×</text><text x="128" y="68" font-size="14" font-style="italic">T</text>
<text x="215" y="152" font-size="15" text-anchor="middle">×</text><text x="223" y="148" font-size="14" font-style="italic">S</text>
<text x="248" y="207" font-size="15" text-anchor="middle">×</text><text x="256" y="203" font-size="14" font-style="italic">L</text>
</svg>"""

# úloha 8: kruhový diagram, 10 stejných dílů (Vybíjená 2, Stolní tenis 1, Atletika 3, Fotbal 4)
def _pie():
    cx = 110; cy = 110; R = 92
    segs = [("#4a4a4a", 2), ("url(#h8)", 1), ("#cfcfcf", 3), ("#ffffff", 4)]
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 230" font-family="sans-serif">']
    out.append('<defs><pattern id="h8" width="7" height="7" patternUnits="userSpaceOnUse"><rect width="7" height="7" fill="#fff"/><line x1="3.5" y1="0" x2="3.5" y2="7" stroke="#000"/></pattern></defs>')
    ang = -90.0
    for fill, cnt in segs:
        for _ in range(cnt):
            a0 = math.radians(ang); a1 = math.radians(ang + 36)
            x0 = cx + R*math.cos(a0); y0 = cy + R*math.sin(a0)
            x1 = cx + R*math.cos(a1); y1 = cy + R*math.sin(a1)
            out.append(f'<path d="M {cx} {cy} L {x0:.1f} {y0:.1f} A {R} {R} 0 0 1 {x1:.1f} {y1:.1f} Z" fill="{fill}" stroke="#000"/>')
            ang += 36
    ly = 58
    for fill, label in [("#4a4a4a","Vybíjená"), ("url(#h8)","Stolní tenis"), ("#cfcfcf","Atletika"), ("#ffffff","Fotbal")]:
        out.append(f'<rect x="225" y="{ly}" width="16" height="16" fill="{fill}" stroke="#000"/><text x="248" y="{ly+13}" font-size="13">{label}</text>')
        ly += 26
    out.append('</svg>')
    return "".join(out)
SVG8 = _pie()

# úloha 10: čtyři obrazce A–D ve čtvercové síti (osová souměrnost) – schematicky
def _fig10():
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 150" font-family="sans-serif">']
    for i, lb in enumerate(["A","B","C","D"]):
        bx = 20 + i*125
        out.append(f'<rect x="{bx}" y="20" width="100" height="100" fill="none" stroke="#ccc"/><text x="{bx+50}" y="140" font-size="14" text-anchor="middle">{lb}</text>')
    out.append('<polygon points="30,30 30,110 110,70" fill="none" stroke="#000"/><polygon points="110,30 110,110 30,70" fill="none" stroke="#000"/>')
    out.append('<circle cx="195" cy="70" r="46" fill="none" stroke="#000"/><polygon points="160,52 235,48 222,96 174,90" fill="none" stroke="#000"/>')
    out.append('<rect x="285" y="30" width="80" height="80" fill="none" stroke="#000"/><circle cx="315" cy="70" r="22" fill="none" stroke="#000"/><polygon points="325,48 365,30 365,110" fill="none" stroke="#000"/>')
    out.append('<rect x="410" y="30" width="80" height="80" fill="none" stroke="#000"/><circle cx="450" cy="70" r="30" fill="none" stroke="#000"/><line x1="410" y1="30" x2="490" y2="110" stroke="#000"/>')
    out.append('</svg>')
    return "".join(out)
SVG10 = _fig10()

# úlohy 11–12: záhon tvaru L (6 stejných čtverců + stejné obdélníkové mezery)
def _lshape():
    s = 48; g = 18; X0 = 30; Y0 = 15
    W = 5*s + 4*g; H = 2*s + g
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200" font-family="sans-serif">']
    def rect(x, y, w, h, fill):
        out.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{fill}"/>')
    rect(X0, Y0, s, s, "#d9d9d9")
    rect(X0, Y0+s, s, g, "#9a9a9a")
    yh = Y0 + s + g; x = X0
    for k in range(5):
        rect(x, yh, s, s, "#d9d9d9"); x += s
        if k < 4:
            rect(x, yh, g, s, "#9a9a9a"); x += g
    A = (X0, Y0); F = (X0+s, Y0); E = (X0+s, Y0+s+g); D = (X0+W, Y0+s+g); C = (X0+W, Y0+H); B = (X0, Y0+H)
    order = [A, B, C, D, E, F]
    pts = " ".join(f"{px},{py}" for px, py in order)
    out.append(f'<polygon points="{pts}" fill="none" stroke="#000" stroke-width="2"/>')
    lab = {"A": (A[0]-14, A[1]-5), "B": (B[0]-14, B[1]+16), "C": (C[0]+4, C[1]+16),
           "D": (D[0]+4, D[1]-5), "E": (E[0]+4, E[1]-5), "F": (F[0]-2, F[1]-5)}
    for lb, (lx, ly) in lab.items():
        out.append(f'<text x="{lx}" y="{ly}" font-size="13" font-style="italic">{lb}</text>')
    out.append('<text x="120" y="190" font-size="12">DEF = 550 cm,  ABC = 710 cm</text>')
    out.append('</svg>')
    return "".join(out)
SVG1112 = _lshape()

# úloha 13: krychle 3x3x3 ze 27 krychliček (šedé/bílé) – schematická poznámka
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 110" font-family="sans-serif">
<text x="280" y="48" font-size="13" text-anchor="middle">Krychle 3x3x3 z 27 krychliček (šedé a bílé); odstraněním zadní vrstvy vznikne kvádr 3x3x2.</text>
<text x="280" y="74" font-size="11" text-anchor="middle" fill="#666">Prostorové těleso nelze věrně přenést do SVG; posuzuje se podle testového sešitu.</text>
</svg>"""

# úloha 14: pravidla výměny dílů (schematicky)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 140" font-family="sans-serif">
<rect x="20" y="18" width="58" height="34" fill="#d9d9d9" stroke="#000"/><text x="92" y="40" font-size="13">1 deska = 4 prkna</text>
<rect x="20" y="62" width="58" height="20" fill="#d9d9d9" stroke="#000"/><text x="92" y="77" font-size="13">2 prkna = 5 tyčí</text>
<text x="20" y="115" font-size="13">1 kus ohrady = 3 prkna + 2 tyče</text>
</svg>"""

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté); kód r5 v taxonomii není

PROBLEMS = [
    {'name':'CERMAT M5B 2026 – úloha 1.1','zad':['Vypočtěte: $(2\\cdot 2\\,000 + 50\\cdot 50):10 =$'],'opts':None,'ln':2,
     'sol':['$(2\\cdot 2\\,000 + 50\\cdot 50):10 = (4\\,000+2\\,500):10 = 6\\,500:10 = 650$.'],
     'ans':'$650$','pts':2,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2026 – úloha 1.2','zad':['Vypočtěte: $2\\,010:(3\\cdot 15 - 45:3) - 28:7 =$'],'opts':None,'ln':2,
     'sol':['$2\\,010:(3\\cdot 15 - 45:3) - 28:7 = 2\\,010:(45-15) - 4 = 2\\,010:30 - 4 = 67 - 4 = 63$.'],
     'ans':'$63$','pts':2,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2026 – úloha 2','zad':[
        'Vypočtěte:',
        '2.1 kolikrát je jeden metr kratší než jedna desetina kilometru,',
        '2.2 o kolik gramů je půlkilogramové závaží těžší než 50gramové závaží,',
        '2.3 kolik nejvíce celých 25minutových dílů seriálu (přehrávaných původní rychlostí) lze zhlédnout za 3 hodiny.'],
     'opts':None,'ln':3,
     'sol':['2.1 Jedna desetina kilometru je $100$ m, jeden metr je tedy $100:1 = 100$krát kratší.',
            '2.2 $500\\text{ g} - 50\\text{ g} = 450$ g.',
            '2.3 $3$ hodiny $= 180$ minut, $180:25 = 7$ celých dílů (a zbývá $5$ minut).'],
     'ans':'2.1: 100krát; 2.2: o $450$ gramů; 2.3: $7$ dílů seriálu','pts':5,'mins':5,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5B 2026 – úloha 3','zad':[
        'Každému z celých čísel od 0 do 9 přiřadíme jiný symbol a některé z těchto symbolů umístíme do tabulky. V šedých polích tabulky je zapsán součet odpovídajících čísel v příslušném sloupci nebo řádku, dva součty chybí.',
        'Určete chybějící součet:',
        '3.1 v 1. sloupci dole,',
        '3.2 ve 3. řádku vpravo.'],
     'opts':None,'ln':2,'svg':SVG3,'fn':'tabulka-symboly.svg',
     'alt':'Tabulka 3 krát 3 se symboly srdce, kříž, kolečko, čtvereček; vpravo součty řádků 4 a 5, dole součty sloupců 8 a 6, dva součty chybí.',
     'cap':'Schematický nákres tabulky se symboly a součty',
     'sol':['Ze známých součtů plyne hodnota symbolů: kolečko $=1$, kříž $=3$, čtvereček $=2$, srdce $=0$.',
            '3.1 Součet v 1. sloupci dole: $0+1+1 = 2$.',
            '3.2 Součet ve 3. řádku vpravo: $1+3+3 = 7$.'],
     'ans':'3.1: $2$; 3.2: $7$','pts':3,'mins':5,'diff':'3',
     'codes':B+['aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2026 – úloha 4','zad':[
        'Na začátku ledna dostal Adam kapesné 1000 korun a utrácel z něj denně stejnou částku. Celé kapesné tak utratil již za 20 dní. Bořek dostal na začátku ledna kapesné 700 korun a kupoval si z něj každý den pouze noviny, a to vždy za stejnou cenu. Po 12 dnech od začátku ledna zbývala z kapesného oběma chlapcům stejná částka.',
        'Vypočtěte:',
        '4.1 kolik korun zbývalo Adamovi z kapesného po 12 dnech od začátku ledna,',
        '4.2 za kolik dnů od začátku ledna utratil Bořek celé své kapesné.'],
     'opts':None,'ln':2,
     'sol':['4.1 Adam utrácel $1\\,000:20 = 50$ korun denně, po 12 dnech mu zbývalo $1\\,000 - 12\\cdot 50 = 400$ korun.',
            '4.2 Bořkovi zbývalo po 12 dnech také $400$ korun, utratil tedy $700 - 400 = 300$ korun za 12 dní, tj. $25$ korun denně. Celé kapesné utratil za $700:25 = 28$ dní.'],
     'ans':'4.1: $400$ korun; 4.2: za $28$ dnů','pts':4,'mins':6,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','finance']},
    {'name':'CERMAT M5B 2026 – úloha 5','zad':[
        'Na papírové ruličce je navinuta stuha delší než 9 m. Na volném konci stuhy je bílý proužek délky 6 cm, následuje červený proužek délky 6 cm a dále se tyto proužky pravidelně střídají. Od volného konce jsme odměřili a odstřihli část stuhy délky 170 cm na pomlázku.',
        'Určete:',
        '5.1 kolik červených proužků je na odstřižené části stuhy na pomlázku,',
        '5.2 kolik cm měří první necelý proužek na volném konci stuhy navinuté na ruličce po odstřižení části stuhy na pomlázku.'],
     'opts':None,'ln':2,'svg':SVG5,'fn':'stuha-rulicka.svg',
     'alt':'Papírová rulička se stuhou, na níž se pravidelně střídají bílé a červené proužky po 6 cm.',
     'cap':'Schematický nákres ruličky se stuhou',
     'sol':['5.1 Proužky se střídají po 6 cm (bílý, červený, bílý, …), začínají bílým. $170:6 = 28$ celých proužků ($28\\cdot 6 = 168$ cm) a 2 cm z dalšího. Z 28 celých je 14 bílých a 14 červených.',
            '5.2 Odstřižením končíme uprostřed 29. proužku (bílého) po 2 cm; na ruličce zůstává jeho zbytek $6 - 2 = 4$ cm jako první necelý proužek na volném konci.'],
     'ans':'5.1: $14$ červených proužků; 5.2: $4$ cm','pts':3,'mins':5,'diff':'3',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5B 2026 – úloha 6','zad':[
        'Na obrázku jsou dvě části stejné čtvercové sítě. Každý její čtvereček má stranu délky 1 cm a obsah 1 cm². Vlevo je zakreslen šestiúhelník $ABCDEF$, jehož vrcholy leží v mřížových bodech sítě. Vpravo jsou vyznačeny dva mřížové body $K$ a $L$.',
        '6.1 Určete v cm² obsah šestiúhelníku $ABCDEF$.',
        '6.2 Body $K$, $L$ jsou vrcholy trojúhelníku $KLM$, který má obsah 5 cm². Najděte vrchol $M$ v některém z mřížových bodů a sestrojte trojúhelník $KLM$. Ze všech možných řešení zakreslete pouze jedno.'],
     'opts':None,'ln':2,'svg':SVG6,'fn':'sit-sestiuhelnik-KL.svg',
     'alt':'Vlevo šestiúhelník ABCDEF v mřížových bodech čtvercové sítě, vpravo dva mřížové body K a L.',
     'cap':'Schematický nákres (dvě části čtvercové sítě)',
     'sol':['6.1 Napočítáním čtverečků (např. Pickovou větou) vyjde obsah šestiúhelníku $ABCDEF$ roven $10$ cm².',
            '6.2 Trojúhelník $KLM$ má obsah $5$ cm². Vrchol $M$ leží v mřížovém bodě tak, aby výška z $M$ dala obsah $5$ cm²; takových poloh je více (viz klíč), zakreslí se jedna.'],
     'ans':'6.1: $10$ cm²; 6.2: trojúhelník $KLM$ s obsahem $5$ cm² (vrchol $M$ v mřížovém bodě, více řešení) – viz klíč','pts':4,'mins':7,'diff':'3',
     'codes':B+['planimetrie','vypocet','konstrukcni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2026 – úloha 7.1 (konstrukce)','zad':[
        'V rovině leží bod $P$ a přímka $AQ$ (viz obrázek).',
        'Bod $A$ je vrchol čtverce $ABCD$, jehož strana $AB$ leží na polopřímce $AQ$. Bodem $P$ prochází strana $CD$ tohoto čtverce.',
        'Sestrojte vrcholy $B$, $C$, $D$ čtverce $ABCD$, označte je písmeny a čtverec narýsujte.'],
     'opts':None,'ln':0,'svg':SVG71,'fn':'bod-P-primka-AQ.svg',
     'alt':'Bod P a přímka procházející body A a Q.','cap':'Výchozí obrázek k úloze 7.1',
     'sol':['Strana $CD$ je rovnoběžná s $AQ$ a prochází bodem $P$; sestrojíme přímku rovnoběžnou s $AQ$ procházející $P$. Vzdálenost mezi přímkou $AQ$ a touto rovnoběžkou je rovna straně čtverce. Bod $B$ leží na polopřímce $AQ$ v této vzdálenosti od $A$, vrcholy $D$ a $C$ doplníme kolmicemi k $AQ$ v bodech $A$ a $B$.'],
     'ans':'Konstrukce čtverce $ABCD$ (strana $AB$ na polopřímce $AQ$, strana $CD$ prochází bodem $P$) – viz obrázek v klíči.',
     'pts':3,'mins':6,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2026 – úloha 7.2 (konstrukce)','zad':[
        'V rovině leží body $L$, $S$, $T$ (viz obrázek).',
        'Bod $L$ je vrchol trojúhelníku $KLM$ a bod $S$ je střed strany $KL$ tohoto trojúhelníku. Vrchol $M$ leží na přímce $KT$. Strany $KL$ a $KM$ trojúhelníku $KLM$ mají stejnou délku.',
        'Sestrojte vrcholy $K$, $M$ trojúhelníku $KLM$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG72,'fn':'body-L-S-T.svg',
     'alt':'Body L, S a T v rovině.','cap':'Výchozí obrázek k úloze 7.2',
     'sol':['Bod $S$ je střed $KL$ a $L$ je dán, proto je $K$ souměrný obraz bodu $L$ podle bodu $S$ (bod $K$ leží na polopřímce opačné k $SL$ ve stejné vzdálenosti). Vrchol $M$ leží na přímce $KT$ a platí $|KM|=|KL|$; kružnice se středem $K$ a poloměrem $|KL|$ protne přímku $KT$ ve dvou bodech $M_1$, $M_2$. Existují dvě řešení.'],
     'ans':'Dvě řešení: bod $K$ je souměrný obraz $L$ podle $S$, bod $M$ leží na přímce $KT$ ve vzdálenosti $|KM|=|KL|$ od $K$ (polohy $M_1$, $M_2$) – viz klíč.',
     'pts':3,'mins':7,'diff':'4','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2026 – úloha 8','zad':[
        'Každý žák, který se zúčastnil sportovního dne, si vybral pouze jednu ze čtyř aktivit. Kruhový diagram je rozdělen na 10 stejně velkých dílů a znázorňuje, jaká část žáků si vybrala jednotlivé aktivity. Fotbal si vybralo o 16 žáků více než vybíjenou.',
        'Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
        '8.1 Fotbal si vybralo třikrát více žáků než stolní tenis.',
        '8.2 Atletiku si vybralo o třetinu méně žáků než fotbal.',
        '8.3 Sportovního dne se zúčastnilo celkem 80 žáků.'],
     'opts':None,'ln':0,'svg':SVG8,'fn':'diagram-sport.svg',
     'alt':'Kruhový diagram o 10 stejných dílech: vybíjená 2 díly, stolní tenis 1 díl, atletika 3 díly, fotbal 4 díly.',
     'cap':'Rozdělení žáků podle vybrané aktivity',
     'sol':['Z diagramu: vybíjená 2 díly, stolní tenis 1 díl, atletika 3 díly, fotbal 4 díly. Rozdíl fotbal $-$ vybíjená $= 2$ díly $= 16$ žáků, takže 1 díl $= 8$ žáků a celkem $10\\cdot 8 = 80$ žáků.',
            '8.1 Fotbal $32$ žáků, stolní tenis $8$ žáků; $3\\cdot 8 = 24 \\ne 32$ → Ne.',
            '8.2 Fotbal $32$; o třetinu méně je $32 - \\frac{32}{3} \\doteq 21{,}3$; atletika je $24$ → Ne.',
            '8.3 $10$ dílů po $8$ žácích $= 80$ žáků → Ano.'],
     'ans':'8.1: N; 8.2: N; 8.3: A','pts':4,'mins':6,'diff':'3',
     'codes':B+['statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5B 2026 – úloha 9','zad':[
        'Katka má stejný počet korunových, dvoukorunových, pětikorunových i desetikorunových mincí. Jiné peníze nemá. Celkem má 252 korun.',
        'Kolik mincí má Katka?'],
     'opts':['A) 18 mincí','B) 32 mincí','C) 48 mincí','D) 56 mincí','E) jiný počet mincí'],'ln':0,
     'sol':['Označíme $n$ počet mincí každého druhu. Hodnota $n\\cdot(1+2+5+10) = 18n = 252$, tedy $n = 14$. Celkem $4\\cdot 14 = 56$ mincí.'],
     'ans':'D) 56 mincí','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','finance']},
    {'name':'CERMAT M5B 2026 – úloha 10','zad':[
        'Ve čtvercové síti jsou zakresleny 4 obrazce označené písmeny A, B, C, D. V obrazcích má každá kružnice střed v mřížovém bodě a prochází čtyřmi mřížovými body. Všechny ostatní útvary mají vrcholy v mřížových bodech.',
        'Který z obrazců není osově souměrný?'],
     'opts':['A) obrazec A','B) obrazec B','C) obrazec C','D) obrazec D','E) Všechny obrazce A–D jsou osově souměrné.'],'ln':0,
     'svg':SVG10,'fn':'obrazce-osova.svg',
     'alt':'Čtyři obrazce A–D ve čtvercové síti: dvojice trojúhelníků, kružnice se čtyřúhelníkem, čtverec s kružnicí a trojúhelníkem, čtverec s kružnicí a úhlopříčkou.',
     'cap':'Schematický nákres obrazců A–D',
     'sol':['Obrazec B (kružnice s nesouměrně vepsaným čtyřúhelníkem) nemá žádnou osu souměrnosti; ostatní obrazce osu souměrnosti mají.'],
     'ans':'B) obrazec B','pts':2,'mins':3,'diff':'2',
     'codes':B+['planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2026 – úlohy 11 a 12','zad':[
        'Záhon ve tvaru písmene L tvoří obrazec $ABCDEF$. Obrazec je rozdělen na 6 stejných čtverců, mezi nimiž jsou mezery tvaru obdélníku (viz obrázek). Všechny tyto obdélníky jsou stejné. Lomená čára $DEF$ (úsečky $DE$ a $EF$) má délku 550 cm. Lomená čára $ABC$ (úsečky $AB$ a $BC$) má délku 710 cm.',
        '11 Jakou délku má úsečka $EF$?  A) 110 cm;  B) 118 cm;  C) 142 cm;  D) 160 cm;  E) jinou délku',
        '12 Jaký je obvod jednoho čtverce?  A) 160 cm;  B) 280 cm;  C) 320 cm;  D) 360 cm;  E) jiný obvod'],
     'opts':None,'ln':0,'svg':SVG1112,'fn':'zahon-L.svg',
     'alt':'Záhon tvaru L ze 6 stejných čtverců oddělených stejnými obdélníkovými mezerami, vrcholy A, B, C, D, E, F.',
     'cap':'Schematický nákres záhonu tvaru L',
     'sol':['Označíme stranu čtverce $s$ a šířku mezery $g$, celkovou výšku $H$ a šířku $W$. Platí $DEF = (W-s)+(H-s) = 550$ a $ABC = H+W = 710$. Odečtením: $2s = 160$, tedy $s = 80$ cm. Svislé rameno tvoří 2 čtverce (1 mezera): $H = 2s+g$; vodorovné rameno 5 čtverců (4 mezery): $W = 5s+4g$. Z $H+W = 7s+5g = 710$ plyne $g = 30$ cm.',
            '11 $EF = H - s = s + g = 80 + 30 = 110$ cm → A.',
            '12 Obvod jednoho čtverce $= 4s = 4\\cdot 80 = 320$ cm → C.'],
     'ans':'11: A) 110 cm; 12: C) 320 cm','pts':4,'mins':6,'diff':'3',
     'codes':B+['planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2026 – úloha 13','zad':[
        'Tomáš postavil krychli z 27 malých krychliček, z nichž některé jsou šedé a ostatní jsou bílé. Krychličky poskládal do krychle tak, že v každém ze tří pater je stejný počet šedých krychliček a žádné dvě šedé krychličky nejsou položeny na sobě. Potom z krychle odstranil zadní vrstvu malých krychliček a vytvořil tak kvádr.',
        'Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).',
        '13.1 Kolik bílých krychliček obsahovala krychle?',
        '13.2 Kolik bílých krychliček bylo v odstraněné zadní vrstvě krychle?',
        '13.3 Kolik šedých krychliček zůstalo v kvádru?'],
     'opts':['A) 5','B) 6','C) 8','D) 9','E) 12','F) jiný počet'],'ln':0,'svg':SVG13,'fn':'krychle-3x3.svg',
     'alt':'Krychle 3 krát 3 krát 3 ze 27 krychliček (šedé a bílé) a kvádr po odstranění zadní vrstvy (schematická poznámka).',
     'cap':'Prostorové těleso – viz testový sešit',
     'sol':['V kvádru (3x3x2) zůstalo 9 šedých krychliček (13.3 → D), v zadní vrstvě (3x3) bylo 6 bílých, tj. 3 šedé (13.2 → B). Celkem šedých $9+3 = 12$, tedy 4 v každém ze tří pater. Bílých v celé krychli je $27 - 12 = 15$ (13.1 → F, jiný počet).'],
     'ans':'13.1: F (15 bílých); 13.2: B (6 bílých); 13.3: D (9 šedých)','pts':5,'mins':6,'diff':'3',
     'codes':B+['stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2026 – úloha 14','zad':[
        'V počítačové hře se vyměňují desky, prkna a tyče pouze podle pravidel: jednu desku lze vyměnit za 4 prkna; libovolnou dvojici prken lze vyměnit za 5 tyčí. Z vyměněných dílů vytváříme ohradu: na 1 kus ohrady potřebujeme 3 prkna a 2 tyče. K dispozici máme pouze desky a postupně je měníme za díly k ohradě.',
        '14.1 Určete, kolik nejméně desek potřebujeme na 3 kusy ohrady.',
        '14.2 Celkem 6 desek použijeme k vytvoření co největšího počtu kusů ohrady. Určete, které nepoužité díly nám zbudou a v jakém počtu.',
        '14.3 Máme k dispozici 19 desek. Určete, kolik nejvíce kusů ohrady můžeme vytvořit.'],
     'opts':None,'ln':3,'svg':SVG14,'fn':'vymena-dilu.svg',
     'alt':'Schéma pravidel: 1 deska za 4 prkna, 2 prkna za 5 tyčí, 1 kus ohrady za 3 prkna a 2 tyče.',
     'cap':'Schematický nákres pravidel výměny',
     'sol':['14.1 Na 3 kusy potřebujeme $9$ prken a $6$ tyčí. Šest tyčí získáme ze dvou dvojic prken ($4$ prkna → $10$ tyčí). Celkem $9+4 = 13$ prken, tj. $\\lceil 13:4\\rceil = 4$ desky (3 desky dají jen 12 prken).',
            '14.2 Šest desek $= 24$ prken. Nejvíce lze vytvořit 6 kusů: $18$ prken na ohrady a $6$ prken vyměníme za $15$ tyčí (potřeba $12$). Zbudou $3$ tyče.',
            '14.3 Devatenáct desek $= 76$ prken. Lze vytvořit 20 kusů: $60$ prken na ohrady a $16$ prken vyměníme za $40$ tyčí (potřeba $40$).'],
     'ans':'14.1: 4 desky; 14.2: zbudou 3 tyče; 14.3: 20 kusů ohrady','pts':4,'mins':7,'diff':'4',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PBD26C0T02'
    gen.YEAR = 2026

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5B-2026')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
