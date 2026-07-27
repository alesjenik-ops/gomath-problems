# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2017, MATEMATIKA 5 B (osmileté obory, 5. ročník),
# 2. řádný termín. Kód testu: M5PBD17C0T02. 14 úloh (po rozdělení izolovaných poduúloh 15 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR) + vyplněný záznamový arch (VZA).

import math

# ---- SVG obrázky (bez ' a \) ----

# úloha 4: plánek běžecké trati B – Stánek – A – Start, vzdálenost B–A = 18 km
SVG4 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 180" font-family="sans-serif">
<line x1="40" y1="90" x2="580" y2="90" stroke="#000" stroke-width="2"/>
<line x1="90" y1="80" x2="90" y2="100" stroke="#000" stroke-width="2"/>
<line x1="230" y1="80" x2="230" y2="100" stroke="#000" stroke-width="2"/>
<line x1="360" y1="80" x2="360" y2="100" stroke="#000" stroke-width="2"/>
<line x1="470" y1="80" x2="470" y2="100" stroke="#000" stroke-width="2"/>
<text x="90" y="70" font-size="16" text-anchor="middle" font-weight="bold">B</text>
<text x="230" y="70" font-size="16" text-anchor="middle" font-weight="bold">Stánek</text>
<text x="360" y="70" font-size="16" text-anchor="middle" font-weight="bold">A</text>
<text x="470" y="70" font-size="16" text-anchor="middle" font-weight="bold">Start</text>
<path d="M90 118 L90 135 L360 135 L360 118" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="225" y="160" font-size="15" text-anchor="middle">18 km</text>
</svg>"""

# úloha 7: bod S a přímka p procházející bodem N (výchozí obrázek pro konstrukci)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 360" font-family="sans-serif">
<line x1="120" y1="80" x2="380" y2="320" stroke="#000" stroke-width="2"/>
<text x="132" y="112" font-size="17" font-style="italic">p</text>
<circle cx="250" cy="200" r="3" fill="#000"/>
<text x="236" y="220" font-size="16" font-style="italic">N</text>
<text x="330" y="176" font-size="15">×</text>
<text x="345" y="174" font-size="16" font-style="italic">S</text>
</svg>"""

# úloha 9: pět čtvercových sítí (1–5), dvojice útvarů a vodorovná osa souměrnosti o (schematicky)
def _sym():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif">']
    s.append('<line x1="20" y1="105" x2="540" y2="105" stroke="#000" stroke-width="1.5"/>')
    s.append('<text x="545" y="110" font-size="13" font-style="italic">o</text>')
    for i in range(5):
        x = 30 + i * 104
        s.append(f'<rect x="{x}" y="20" width="90" height="170" fill="none" stroke="#bbb"/>')
        s.append(f'<text x="{x+45}" y="16" font-size="13" text-anchor="middle">{i+1}</text>')
        s.append(f'<polygon points="{x+22},38 {x+58},38 {x+58},54 {x+38},54 {x+38},86 {x+22},86" fill="#cccccc" stroke="#666"/>')
        s.append(f'<polygon points="{x+22},172 {x+58},172 {x+58},156 {x+38},156 {x+38},124 {x+22},124" fill="#cccccc" stroke="#666"/>')
    s.append('</svg>')
    return "".join(s)
SVG9 = _sym()

# úloha 10: kruhový diagram aktivit (lezení 19, plavání 26, kino, fotbal, cyklistika)
def _pie():
    cx, cy, r = 215, 205, 120
    segs = [('kino', 31, None), ('fotbal', 16, None), ('plavání', 26, '26 dětí'),
            ('cyklistika', 8, None), ('lezení', 19, '19 dětí')]
    total = sum(v for _, v, _ in segs)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 430" font-family="sans-serif">']
    s.append('<text x="230" y="26" font-size="18" text-anchor="middle" font-weight="bold">AKTIVITY</text>')
    ang = -90.0
    for label, v, cnt in segs:
        a0 = ang
        a1 = ang + 360.0 * v / total
        ang = a1
        x0 = cx + r * math.cos(math.radians(a0)); y0 = cy + r * math.sin(math.radians(a0))
        x1 = cx + r * math.cos(math.radians(a1)); y1 = cy + r * math.sin(math.radians(a1))
        large = 1 if (a1 - a0) > 180 else 0
        s.append(f'<path d="M {cx} {cy} L {x0:.1f} {y0:.1f} A {r} {r} 0 {large} 1 {x1:.1f} {y1:.1f} Z" fill="none" stroke="#000" stroke-width="1.5"/>')
        mid = math.radians((a0 + a1) / 2)
        lx = cx + (r + 28) * math.cos(mid); ly = cy + (r + 28) * math.sin(mid)
        s.append(f'<text x="{lx:.1f}" y="{ly:.1f}" font-size="13" text-anchor="middle">{label}</text>')
        if cnt:
            s.append(f'<text x="{lx:.1f}" y="{ly+15:.1f}" font-size="11" text-anchor="middle">{cnt}</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _pie()

# úloha 11: tři trpaslíci s šedými trojúhelníkovými čepicemi A, B, C ve čtvercové síti (schematicky)
def _caps():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 260" font-family="sans-serif">']
    for gx in range(0, 561, 40):
        s.append(f'<line x1="{gx}" y1="20" x2="{gx}" y2="240" stroke="#eaeaea"/>')
    for gy in range(20, 241, 40):
        s.append(f'<line x1="0" y1="{gy}" x2="560" y2="{gy}" stroke="#eaeaea"/>')
    s.append('<polygon points="80,200 200,200 140,120" fill="#cfcfcf" stroke="#555"/><text x="140" y="188" font-size="16" text-anchor="middle">A</text>')
    s.append('<polygon points="250,200 330,200 300,90" fill="#cfcfcf" stroke="#555"/><text x="291" y="150" font-size="16" text-anchor="middle">B</text>')
    s.append('<polygon points="380,200 500,200 500,120" fill="#cfcfcf" stroke="#555"/><text x="448" y="188" font-size="16" text-anchor="middle">C</text>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _caps()

# úloha 13: čtyři díly stavebnice a pět staveb z krychliček (prostorové – schematická poznámka)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif">
<text x="280" y="55" font-size="13" text-anchor="middle">Čtyři díly stavebnice (1 až 4 kostky) a pět staveb z krychliček.</text>
<text x="280" y="80" font-size="11" text-anchor="middle" fill="#666">Prostorové stavby nelze věrně přenést do SVG; posuzuje se podle originálu.</text>
</svg>"""

# úloha 14: šedý čtverec s vepsaným pootočeným bílým čtvercem (úseky 1 cm a 2 cm)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 240" font-family="sans-serif">
<rect x="45" y="45" width="150" height="150" fill="#cccccc" stroke="#000" stroke-width="1.5"/>
<polygon points="95,45 195,95 145,195 45,145" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<text x="70" y="38" font-size="14" text-anchor="middle">1</text>
<text x="145" y="38" font-size="14" text-anchor="middle">2</text>
<text x="34" y="80" font-size="14" text-anchor="middle">2</text>
<text x="34" y="165" font-size="14" text-anchor="middle">1</text>
<text x="206" y="150" font-size="14" text-anchor="middle">2</text>
<text x="120" y="214" font-size="14" text-anchor="middle">1</text>
</svg>"""

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 se v taxonomii nepoužívá

PROBLEMS = [
    {'name': 'CERMAT M5B 2017 – úloha 1.1',
     'zad': ['Vypočtěte: $200\\cdot 4\\cdot 60 + 60 - 60\\cdot 2\\cdot 400 =$'],
     'opts': None, 'ln': 2,
     'sol': ['$200\\cdot 4\\cdot 60 = 48\\,000$ a $60\\cdot 2\\cdot 400 = 48\\,000$, tedy $48\\,000 + 60 - 48\\,000 = 60$.'],
     'ans': '$60$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2017 – úloha 1.2',
     'zad': ['Vypočtěte: $51 + 51 + 7\\cdot 51 + 51 =$'],
     'opts': None, 'ln': 2,
     'sol': ['$51\\cdot(1+1+7+1) = 51\\cdot 10 = 510$.'],
     'ans': '$510$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2017 – úloha 2',
     'zad': ['V zápisu výpočtu chybí u dvou čísel poslední číslice. Doplňte číslice tak, aby obě dělení vyšla beze zbytku, a příklad vypočtěte:',
             '$136\\square : 11 + 229\\square : 11 =$',
             'Do záznamového archu opište příklad s oběma doplněnými číslicemi a výsledek, dílčí výpočty neopisujte.'],
     'opts': None, 'ln': 2,
     'sol': ['Poslední číslice doplníme tak, aby čísla byla dělitelná 11: jediné možnosti jsou $1364$ a $2299$. Pak $1364:11 = 124$ a $2299:11 = 209$, součet $124 + 209 = 333$.'],
     'ans': '$1364:11 + 2299:11 = 333$', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2017 – úloha 3',
     'zad': ['Medvědí dvojice jí jablka stále stejným tempem. Medvěd sní za stejnou dobu dvakrát více jablek než medvědice. Medvědice spořádá 5 jablek za 40 sekund.',
             '3.1 Určete, za kolik sekund sní medvěd jedno jablko.',
             '3.2 Určete, kolik jablek sní medvědice za 4 minuty.'],
     'opts': None, 'ln': 2,
     'sol': ['3.1 Medvědice sní 1 jablko za $40:5 = 8$ sekund. Medvěd jí dvakrát rychleji, jedno jablko sní za $8:2 = 4$ sekundy.',
             '3.2 4 minuty $= 240$ sekund; medvědice sní 5 jablek za 40 s, tedy za 240 s sní $\\frac{240}{40}\\cdot 5 = 30$ jablek.'],
     'ans': '3.1: za $4$ sekundy; 3.2: $30$ jablek', 'pts': 4, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2017 – úloha 4',
     'zad': ['Na plánku lyžařské běžecké trati je vyznačeno místo startu, stanoviště $A$, $B$ a stánek (viz obrázek). V pořadí zleva jsou $B$, stánek, $A$, start; vzdálenost stanovišť $B$ a $A$ je $18$ km.',
             'Start je od stanoviště $B$ třikrát dále než od stanoviště $A$. Stánek je o $4$ km blíž ke stanovišti $A$ než ke stanovišti $B$.',
             '4.1 Určete v km vzdálenost startu od stanoviště $B$.',
             '4.2 Určete v km vzdálenost stánku od stanoviště $A$.'],
     'opts': None, 'ln': 2, 'svg': SVG4, 'fn': 'trat.svg',
     'alt': 'Přímka se stanovišti B, stánek, A a start; vzdálenost B až A je 18 km.',
     'cap': 'Plánek běžecké trati',
     'sol': ['4.1 Start je za stanovištěm $A$. Označíme vzdálenost startu od $A$ jako $x$. Pak $3x = 18 + x$, tedy $x = 9$ km a vzdálenost startu od $B$ je $18 + 9 = 27$ km.',
             '4.2 Vzdálenosti stánku od $B$ a od $A$ dávají dohromady $18$ km a liší se o $4$ km. Kratší z nich (ke stanovišti $A$) je $(18 - 4):2 = 7$ km.'],
     'ans': '4.1: $27$ km; 4.2: $7$ km', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2017 – úloha 5',
     'zad': ['Tři stejně těžké bedny váží tolik jako pět stejných krabic. Nejtěžší náklad, který se smí převážet ve výtahu, váží tolik jako 35 krabic.',
             '5.1 Určete největší počet beden, které se smí naložit do prázdného výtahu.',
             '5.2 Určete největší počet krabic, které se smí do výtahu přidat k 6 bednám.'],
     'opts': None, 'ln': 2,
     'sol': ['5.1 Jedna bedna váží jako $\\frac{5}{3}$ krabice. Do výtahu (nejvýše 35 krabic) se vejde $35:\\frac{5}{3} = 35\\cdot\\frac{3}{5} = 21$ beden.',
             '5.2 Šest beden váží jako $6\\cdot\\frac{5}{3} = 10$ krabic. K nim lze přidat ještě $35 - 10 = 25$ krabic.'],
     'ans': '5.1: $21$ beden; 5.2: $25$ krabic', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2017 – úloha 6',
     'zad': ['Tři tyče dlouhé 112 cm, 72 cm a 56 cm byly beze zbytku rozřezány na stejně dlouhé špalíčky. Vzniklo tak 60 špalíčků. Ze všech těchto špalíčků děti postavily 12 stejně vysokých sloupků.',
             '6.1 Určete v cm délku jednoho špalíčku.',
             '6.2 Určete, z kolika špalíčků se skládá jeden sloupek.',
             '6.3 Určete v cm výšku jednoho sloupku.',
             '6.4 Určete počet špalíčků, které vznikly rozřezáním nejkratší tyčky.'],
     'opts': None, 'ln': 4,
     'sol': ['6.1 Celková délka tyčí je $112 + 72 + 56 = 240$ cm, špalíčků je 60, jeden měří $240:60 = 4$ cm (délka 4 cm dělí beze zbytku 112, 72 i 56).',
             '6.2 Na 12 sloupků připadá $60:12 = 5$ špalíčků na jeden sloupek.',
             '6.3 Výška sloupku je $5\\cdot 4 = 20$ cm.',
             '6.4 Nejkratší tyč (56 cm) dá $56:4 = 14$ špalíčků.'],
     'ans': '6.1: $4$ cm; 6.2: $5$ špalíčků; 6.3: $20$ cm; 6.4: $14$ špalíčků',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2017 – úloha 7',
     'zad': ['V rovině leží bod $S$ a přímka $p$, která prochází bodem $N$ (viz obrázek). Úlohu rýsujte přímo do záznamového archu.',
             '7.1 Sestrojte kružnici $k$ se středem $S$, která prochází bodem $N$. Další průsečík kružnice $k$ a přímky $p$ označte $K$.',
             '7.2 Body $K$, $N$ jsou dva ze čtyř vrcholů obdélníku $KLMN$. Všechny vrcholy tohoto obdélníku leží na kružnici $k$. Sestrojte chybějící vrcholy $L$, $M$ a obdélník narýsujte.',
             '7.3 Body $M$, $N$ jsou vrcholy trojúhelníku $MNO$, který má stejně dlouhé strany $MN$ a $NO$. Chybějící vrchol $O$ leží na polopřímce $SN$. Sestrojte bod $O$ a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'bod-primka.svg',
     'alt': 'Bod S a přímka p procházející bodem N.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['7.1 Kružnice $k$ má střed $S$ a poloměr $|SN|$; její druhý průsečík s přímkou $p$ je bod $K$.',
             '7.2 Obdélník vepsaný do kružnice má úhlopříčky procházející jejím středem, proto je $M$ obrazem $K$ a $L$ obrazem $N$ ve středové souměrnosti se středem $S$ (oba leží na $k$).',
             '7.3 Bod $O$ leží na polopřímce $SN$ za bodem $N$ tak, že $|NO| = |MN|$; trojúhelník $MNO$ je rovnoramenný. Náčrt viz klíč.'],
     'ans': 'Konstrukce: kružnice $k$ se středem $S$ a poloměrem $|SN|$, průsečík $K$ na přímce $p$; obdélník $KLMN$ vepsaný do $k$ ($M$, $L$ jsou obrazy $K$, $N$ ve středové souměrnosti podle $S$); bod $O$ na polopřímce $SN$ s $|NO| = |MN|$. Viz obrázek v klíči.',
     'pts': 6, 'mins': 12, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2017 – úloha 8',
     'zad': ['Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
             '8.1 Vzdálenost $32$ cm je 4krát větší než vzdálenost $128$ mm.',
             '8.2 Vzdálenost $128$ mm je 4krát větší než vzdálenost $32$ cm.',
             '8.3 Čtverec se stranou délky $6$ cm je možné rozdělit na $9$ čtverců se stranou délky $20$ mm.'],
     'opts': None, 'ln': 0,
     'sol': ['8.1 $128$ mm $= 12{,}8$ cm; $4\\cdot 12{,}8 = 51{,}2$ cm, což není $32$ cm. Nepravda (Ne).',
             '8.2 $128$ mm $= 12{,}8$ cm je menší než $32$ cm, nemůže tedy být 4krát větší. Nepravda (Ne).',
             '8.3 $20$ mm $= 2$ cm; čtverec $6\\times 6$ cm lze rozdělit na mřížku $3\\times 3$ čtverců se stranou $2$ cm, tj. na $9$ čtverců. Pravda (Ano).'],
     'ans': '8.1: Ne; 8.2: Ne; 8.3: Ano', 'pts': 4, 'mins': 5, 'diff': '2',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2017 – úloha 9',
     'zad': ['Ve kterém z pěti obrázků je dvojice útvarů souměrná podle vyznačené osy souměrnosti $o$? (Obrázky 1–5 viz zadání.)'],
     'opts': ['A) jen v obrázku 1', 'B) jen v obrázku 2', 'C) ve dvou z pěti obrázků',
              'D) ve třech z pěti obrázků', 'E) ve čtyřech z pěti obrázků'],
     'ln': 0, 'svg': SVG9, 'fn': 'osy.svg',
     'alt': 'Pět čtvercových sítí (1 až 5), v každé dvojice útvarů a vodorovná osa souměrnosti o.',
     'cap': 'Obrázky 1 až 5 k úloze 9 (schematicky)',
     'sol': ['Osová souměrnost podle vodorovné osy $o$ nastává, když je horní útvar zrcadlovým obrazem dolního. Této podmínce vyhovuje pouze obrázek 1.'],
     'ans': 'A) jen v obrázku 1', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2017 – úloha 10',
     'zad': ['Každé ze 100 dětí uvedlo jednu aktivitu, kterou má ze všech nabízených nejraději. Výsledky jsou v diagramu: lezení 19 dětí, plavání 26 dětí.',
             'Lezení, nebo kino má nejraději polovina všech dětí. Dětí, které mají nejraději fotbal, je dvakrát více než těch, které mají nejraději cyklistiku.',
             'Kolik dětí má nejraději fotbal?'],
     'opts': ['A) 12 dětí', 'B) 14 dětí', 'C) 16 dětí', 'D) 18 dětí', 'E) 20 dětí'],
     'ln': 0, 'svg': SVG10, 'fn': 'aktivity.svg',
     'alt': 'Kruhový diagram aktivit: lezení 19, plavání 26, kino, fotbal, cyklistika.',
     'cap': 'Diagram oblíbených aktivit',
     'sol': ['Lezení a kino dohromady $50$ dětí, tedy kino $50 - 19 = 31$. Na cyklistiku a fotbal zbývá $100 - 19 - 31 - 26 = 24$. Fotbal je dvojnásobek cyklistiky: $c + 2c = 24$, $c = 8$, fotbal $= 16$ dětí.'],
     'ans': 'C) 16 dětí', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2017 – úloha 11',
     'zad': ['Ve čtvercové síti jsou zakresleni tři trpaslíci se šedými čepicemi $A$, $B$, $C$ (viz obrázek).',
             'Která ze zakreslených čepic pokrývá na obrázku největší část plochy?'],
     'opts': ['A) čepice A', 'B) čepice B', 'C) čepice C',
              'D) dvě ze tří čepic pokrývají stejně velké části plochy, jedna pokrývá menší část',
              'E) čepice A, B i C pokrývají stejně velké části plochy'],
     'ln': 0, 'svg': SVG11, 'fn': 'cepice.svg',
     'alt': 'Tři trpaslíci se šedými trojúhelníkovými čepicemi A, B, C ve čtvercové síti.',
     'cap': 'Čepice A, B, C ve čtvercové síti (schematicky)',
     'sol': ['Obsah každé trojúhelníkové čepice určíme ze čtvercové sítě (např. jako polovinu opsaného obdélníku). Všechny tři čepice mají stejný obsah.'],
     'ans': 'E) čepice A, B i C pokrývají stejně velké části plochy', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2017 – úloha 12',
     'zad': ['Letos do taneční skupiny přibylo 6 dívek a 6 chlapců. Oproti předešlému roku se tak počet dívek zvýšil o polovinu a počet chlapců na dvojnásobek.',
             'Kolik dětí je letos v taneční skupině?'],
     'opts': ['A) méně než 20 dětí', 'B) 20 dětí', 'C) 25 dětí', 'D) 30 dětí', 'E) jiný počet dětí'],
     'ln': 0,
     'sol': ['Dívky: $d + 6 = 1{,}5\\,d$, tedy $d = 12$ (loni), letos $18$. Chlapci: $ch + 6 = 2\\,ch$, tedy $ch = 6$ (loni), letos $12$. Celkem letos $18 + 12 = 30$ dětí.'],
     'ans': 'D) 30 dětí', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2017 – úloha 13',
     'zad': ['Čtyři různé díly stavebnice jsou složené z 1–4 kostek (první díl 1 kostka, druhý díl 2 kostky, třetí díl 3 kostky ve tvaru L, čtvrtý díl 4 kostky). Z těchto dílů lze několika způsoby postavit pět zobrazených staveb (viz obrázek).',
             'Vyberte všechny stavby, které splňují danou podmínku (13.1–13.3), a uveďte jejich počet (A–F).',
             '13.1 Stavbu je možné postavit jen z druhých dílů stavebnice.',
             '13.2 Ve stavbě je možné použít čtvrtý díl stavebnice.',
             '13.3 Ve stavbě je možné použít dvakrát třetí díl stavebnice (a případně i jiné díly).'],
     'opts': ['A) pět staveb', 'B) čtyři stavby', 'C) tři stavby', 'D) dvě stavby',
              'E) jedna stavba', 'F) žádná stavba'],
     'ln': 0, 'svg': SVG13, 'fn': 'stavebnice.svg',
     'alt': 'Čtyři díly stavebnice z 1 až 4 kostek a pět staveb z nich složených.',
     'cap': 'Díly stavebnice a pět staveb (viz testový sešit)',
     'sol': ['13.1 Jen z dvojkostkových dílů (druhých dílů) lze složit čtyři z pěti staveb → B.',
             '13.2 Čtyřkostkový čtvrtý díl lze použít u dvou staveb → D.',
             '13.3 Dvakrát třetí díl (dvě L-trojkostky) lze použít u tří staveb → C.'],
     'ans': '13.1: B (čtyři stavby); 13.2: D (dvě stavby); 13.3: C (tři stavby)',
     'pts': 5, 'mins': 5, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2017 – úloha 14',
     'zad': ['Uvnitř šedého čtverce je umístěn bílý čtverec. Vrcholy bílého čtverce rozdělují každou stranu šedého čtverce na dva úseky dlouhé 1 cm a 2 cm (viz obrázek).',
             'Obdobným způsobem se umístí větší počet stejných bílých čtverců v řadě do šedého obdélníku. S přibývajícím počtem bílých čtverců se mění délky stran šedého obdélníku. Rozměry jsou v cm.',
             '14.1 Určete délky stran šedého obdélníku se dvěma bílými čtverci.',
             '14.2 Určete délky stran šedého obdélníku s pěti bílými čtverci.',
             '14.3 Delší strana šedého obdélníku měří 85 cm. Určete délku kratší strany tohoto obdélníku.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'ctverce.svg',
     'alt': 'Šedý čtverec s vepsaným pootočeným bílým čtvercem; vrcholy dělí strany na úseky 1 cm a 2 cm.',
     'cap': 'Šedý čtverec s bílým čtvercem (rozměry v cm)',
     'sol': ['S jedním bílým čtvercem je šedý útvar čtverec $3\\times 3$ cm. Každý další bílý čtverec prodlouží delší stranu o $2$ cm; pro $n$ bílých čtverců je kratší strana $n + 2$ cm a delší strana $2n + 1$ cm.',
             '14.1 Pro $n = 2$: kratší strana $4$ cm, delší strana $5$ cm.',
             '14.2 Pro $n = 5$: kratší strana $7$ cm, delší strana $11$ cm.',
             '14.3 Z $2n + 1 = 85$ je $n = 42$, kratší strana $n + 2 = 44$ cm.'],
     'ans': '14.1: $4$ cm, $5$ cm; 14.2: $7$ cm, $11$ cm; 14.3: $44$ cm',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PBD17C0T02'
    gen.YEAR = 2017

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
    total_pts = sum(p['pts'] for p in PROBLEMS)
    print('Validace OK:', len(PROBLEMS), 'úloh; součet bodů:', total_pts)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5B-2017')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
