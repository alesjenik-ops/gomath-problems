# -*- coding: utf-8 -*-
# CERMAT – Přijímací zkoušky 2017, MATEMATIKA 5 A, 1. řádný termín.
# Kód testu: M5PAD17C0T01. 14 úloh (po rozdělení izolovaných poduúloh 15 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR) + záznamový arch (VZA). Celkem 50 bodů.

# ---- SVG obrázky (bez ' a \) ----

# úloha 6: dvě číselné osy – první se třemi stejnými díly (A, B, _, 36; sipka ".2"),
# druhá se čtyřmi stejnými díly (_, C, _, 50, D; sipka "+36")
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 200" font-family="sans-serif">
<line x1="30" y1="110" x2="325" y2="110" stroke="#000" stroke-width="2"/>
<path d="M80 98V122M130 98V122M180 98V122M230 98V122" stroke="#000" stroke-width="2"/>
<text x="80" y="84" font-size="19" text-anchor="middle">A</text>
<text x="130" y="84" font-size="19" text-anchor="middle">B</text>
<text x="230" y="84" font-size="19" text-anchor="middle">36</text>
<path d="M80 128 Q155 182 226 136" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="230,128 220,136 231,142" fill="#000"/>
<circle cx="155" cy="162" r="18" fill="#fff" stroke="#000" stroke-width="2"/>
<text x="155" y="169" font-size="17" text-anchor="middle" font-weight="bold">· 2</text>
<line x1="370" y1="110" x2="690" y2="110" stroke="#000" stroke-width="2"/>
<path d="M410 98V122M460 98V122M510 98V122M560 98V122M610 98V122" stroke="#000" stroke-width="2"/>
<text x="460" y="84" font-size="19" text-anchor="middle">C</text>
<text x="560" y="84" font-size="19" text-anchor="middle">50</text>
<text x="610" y="84" font-size="19" text-anchor="middle">D</text>
<path d="M410 128 Q510 190 606 136" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="610,128 600,136 611,142" fill="#000"/>
<circle cx="510" cy="168" r="22" fill="#fff" stroke="#000" stroke-width="2"/>
<text x="510" y="175" font-size="17" text-anchor="middle" font-weight="bold">+36</text>
</svg>"""

# úloha 7: dvě různoběžné přímky p, r a bod D
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 660 430" font-family="sans-serif">
<rect x="2" y="2" width="656" height="426" fill="none" stroke="#bbb"/>
<line x1="110" y1="70" x2="285" y2="365" stroke="#000" stroke-width="3"/>
<text x="86" y="98" font-size="21" font-style="italic">r</text>
<line x1="345" y1="410" x2="550" y2="85" stroke="#000" stroke-width="3"/>
<text x="558" y="82" font-size="21" font-style="italic">p</text>
<text x="190" y="56" font-size="21" font-style="italic">D</text>
<text x="200" y="82" font-size="20" text-anchor="middle">×</text>
</svg>"""


# úloha 8: čtvercová síť 13x5, tři tmavé obrazce A (3 cm2), B (2 cm2), C (5 cm2)
def _sit():
    c = 40; ox = 15; oy = 15; W = 13; H = 5
    P = lambda p: f"{ox + p[0] * c},{oy + p[1] * c}"
    A = [(1, 3), (2, 2), (4, 1), (4, 2), (3, 3)]
    B = [(6, 3), (6, 2), (8, 1), (8, 2)]
    C = [(10, 1), (10.5, 1.5), (11, 1), (12, 2), (11.5, 2.5), (12, 3),
         (11, 4), (10.5, 3.5), (10, 4), (9, 3), (9.5, 2.5), (9, 2)]
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+W*c} {oy*2+H*c}" font-family="sans-serif">']
    d = [f"M{ox+i*c} {oy}V{oy+H*c}" for i in range(W + 1)]
    d += [f"M{ox} {oy+j*c}H{ox+W*c}" for j in range(H + 1)]
    s.append(f'<path d="{"".join(d)}" stroke="#888" fill="none"/>')
    for pts in (A, B, C):
        s.append(f'<polygon points="{" ".join(P(p) for p in pts)}" fill="#dcdcdc" stroke="#000" stroke-width="3"/>')
    s.append(f'<rect x="{ox+10*c}" y="{oy+2*c}" width="{c}" height="{c}" fill="#fff" stroke="#000" stroke-width="3"/>')
    for lab, lx in (("A", 2.3), ("B", 6.3), ("C", 9.3)):
        s.append(f'<text x="{ox+lx*c}" y="{oy+1.45*c}" font-size="21" text-anchor="middle">{lab}</text>')
    s.append("</svg>")
    return "".join(s)
SVG8 = _sit()


# úlohy 11 a 12: pruhový graf – doma 9 dnů, na chatě 12 dnů, ostatní údaje chybí
def _graf():
    x0 = 128; x1 = 548; y0 = 20; rh = 26; u = (x1 - x0) / 28.0
    rows = [("doma", 9), ("na táboře", 0), ("u babičky", 0), ("u kamarádky", 0), ("na chatě", 12)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 570 205" font-family="sans-serif">']
    d = [f"M{x0+i*u:.0f} {y0}V{y0+5*rh}" for i in range(29)]
    d += [f"M{x0} {y0+j*rh}H{x1}" for j in range(6)]
    s.append(f'<path d="{"".join(d)}" stroke="#777" fill="none"/>')
    for i, (lab, v) in enumerate(rows):
        y = y0 + i * rh
        if v:
            s.append(f'<rect x="{x0}" y="{y+5}" width="{v*u:.0f}" height="{rh-10}" fill="#b5b5b5" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+19}" font-size="15" text-anchor="end">{lab}</text>')
    for v in range(0, 29, 2):
        s.append(f'<text x="{x0+v*u:.0f}" y="{y0+5*rh+18}" font-size="14" text-anchor="middle">{v}</text>')
    s.append(f'<text x="{(x0+x1)//2}" y="{y0+5*rh+42}" font-size="15" text-anchor="middle">počet dnů</text>')
    s.append("</svg>")
    return "".join(s)
SVG11 = _graf()


# úloha 13: těleso z 9 krychlí (kabinetní projekce) + nabídka obrazců A–F
def _teleso():
    cubes = [(0, 0, 1), (1, 0, 2), (1, 1, 2), (1, 0, 1), (1, 1, 1),
             (1, 1, 0), (1, 2, 0), (2, 2, 0), (2, 0, 2)]
    sz = 46; dp = 20; ox = 95; oy = 250
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 570" font-family="sans-serif">',
         '<g fill="#fff" stroke="#000" stroke-width="2">']
    for x, y, z in sorted(cubes, key=lambda t: (-t[1], t[2], t[0])):
        X = ox + x * sz + y * dp
        Y = oy - (z + 1) * sz - y * dp
        s.append(f'<polygon points="{X},{Y} {X+sz},{Y} {X+sz+dp},{Y-dp} {X+dp},{Y-dp}"/>')
        s.append(f'<polygon points="{X+sz},{Y} {X+sz+dp},{Y-dp} {X+sz+dp},{Y+sz-dp} {X+sz},{Y+sz}" fill="#d0d0d0"/>')
        s.append(f'<rect x="{X}" y="{Y}" width="{sz}" height="{sz}"/>')
    s.append('</g>')
    s.append('<path d="M180 20V66" stroke="#555" stroke-width="2"/><polygon points="180,74 174,60 186,60" fill="#555"/>')
    s.append('<text x="192" y="52" font-size="17">shora</text>')
    s.append('<text x="8" y="112" font-size="17">zepředu</text>')
    s.append('<path d="M52 120L118 158" stroke="#555" stroke-width="2"/><polygon points="126,163 112,161 118,151" fill="#555"/>')
    s.append('<text x="398" y="192" font-size="17">zprava</text>')
    s.append('<path d="M392 186L330 186" stroke="#555" stroke-width="2"/><polygon points="322,186 336,180 336,192" fill="#555"/>')
    opts = {
        "A": [(1, 0), (2, 0), (1, 1), (2, 1), (0, 2), (1, 2)],
        "B": [(2, 0), (1, 1), (2, 1), (0, 2), (1, 2)],
        "C": [(0, 0), (1, 0), (0, 1), (1, 1), (1, 2), (2, 2)],
        "D": [(0, 0), (1, 0), (2, 0), (1, 1), (2, 1), (0, 2), (1, 2)],
        "E": [(1, 0), (2, 0), (0, 1), (1, 1), (1, 2), (2, 2)],
        "F": [(1, 0), (2, 0), (1, 1), (0, 2), (1, 2), (2, 2)],
    }
    k = 30
    for i, lab in enumerate(opts):
        bx = 60 + (i % 3) * 180; by = 310 + (i // 3) * 130
        s.append(f'<text x="{bx-32}" y="{by+50}" font-size="18">{lab})</text>')
    s.append('<g fill="#b5b5b5" stroke="#000" stroke-width="2">')
    for i, cells in enumerate(opts.values()):
        bx = 60 + (i % 3) * 180; by = 310 + (i // 3) * 130
        for cx, cy in cells:
            s.append(f'<rect x="{bx+cx*k}" y="{by+cy*k}" width="{k}" height="{k}"/>')
    s.append("</g></svg>")
    return "".join(s)
SVG13 = _teleso()


B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 v taxonomii není

PROBLEMS = [
    {'name': 'CERMAT M5A 2017 – úloha 1.1', 'zad': ['Vypočtěte: $(112-112:7):6=$'], 'opts': None, 'ln': 2,
     'sol': ['Nejprve dělení v závorce: $112:7=16$, tedy $112-16=96$. Potom $96:6=16$.'],
     'ans': '$16$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2017 – úloha 1.2', 'zad': ['Vypočtěte: $9\\cdot 20-10\\cdot(6\\cdot 4-3\\cdot 8)=$'], 'opts': None, 'ln': 2,
     'sol': ['V závorce: $6\\cdot 4-3\\cdot 8=24-24=0$. Dále $9\\cdot 20-10\\cdot 0=180-0=180$.'],
     'ans': '$180$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2017 – úloha 2', 'zad': [
        'Neznámé číslo zvětšené o 4 stovky a 5 desítek je rovno číslu vytvořenému ze 4 tisíců a 5 jednotek.',
        '2.1 Vypočtěte neznámé číslo.',
        '2.2 Číslo vytvořené ze 4 tisíců a 5 jednotek zaokrouhlete na desítky.'],
     'opts': None, 'ln': 3,
     'sol': ['Číslo ze 4 tisíců a 5 jednotek je $4\\,005$. Zvětšení o 4 stovky a 5 desítek znamená přičtení $400+50=450$.',
             '2.1 Neznámé číslo $=4\\,005-450=3\\,555$.',
             '2.2 Číslo $4\\,005$ má na místě jednotek číslici 5, zaokrouhlujeme nahoru: $4\\,010$.'],
     'ans': '2.1: $3\\,555$; 2.2: $4\\,010$', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2017 – úloha 3', 'zad': [
        'Děti hledaly inspiraci v písničkách a sestavily úlohu: Babka s dědkem sbírali jablka. Babka nasbírala 35 jablek. Kdyby z nich dala pětinu dědkovi, měli by oba stejný počet jablek.',
        '3.1 Vypočtěte, kolik jablek by měla dát babka dědkovi, aby měli oba stejně.',
        '3.2 Vypočtěte, kolik jablek nasbíral dědek.'],
     'opts': None, 'ln': 3,
     'sol': ['3.1 Pětina z 35 je $35:5=7$ jablek.',
             '3.2 Po darování má babka $35-7=28$ jablek a dědek jich má stejně, tedy 28. Sedm jablek ale dostal od babky, sám tedy nasbíral $28-7=21$ jablek.'],
     'ans': '3.1: $7$ jablek; 3.2: $21$ jablek', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2017 – úloha 4', 'zad': [
        'Běžec udržuje stejné tempo. První kilometr uběhl za 3 minuty a 40 sekund. Určete v minutách a sekundách dobu, za kterou by měl uběhnout vzdálenost:',
        '4.1 $2$ km',
        '4.2 $1\\,600$ m',
        'Upozornění: Sekundy uvedené za minutami smí vyjadřovat pouze dobu kratší než minutu (např. zápis „7 min 110 s“ je nepřípustný).'],
     'opts': None, 'ln': 3,
     'sol': ['Jeden kilometr uběhne za $3$ min $40$ s $=220$ s.',
             '4.1 $2$ km: $2\\cdot 220=440$ s $=7$ min $20$ s.',
             '4.2 $1\\,600$ m $=1{,}6$ km: $220:5=44$ s na $200$ m, tedy $8\\cdot 44=352$ s $=5$ min $52$ s.'],
     'ans': '4.1: $7$ min $20$ s; 4.2: $5$ min $52$ s', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2017 – úloha 5', 'zad': [
        'Všech 29 žáků třídy je zapsáno v třídní knize podle abecedy.',
        '5.1 Počet žáků zapsaných před Pavlem je 3krát větší než počet žáků za ním. Vypočtěte, kolik žáků je zapsáno za Pavlem.',
        '5.2 Počet žáků zapsaných před Emou je o 6 menší než počet žáků za ní. Vypočtěte, na kolikátém místě je zapsána Ema.'],
     'opts': None, 'ln': 3,
     'sol': ['Kromě sledovaného žáka zbývá $29-1=28$ žáků.',
             '5.1 Je-li za Pavlem $x$ žáků, před ním $3x$: $x+3x=28$, tedy $4x=28$ a $x=7$.',
             '5.2 Je-li za Emou $y$ žáků, před ní $y-6$: $y+(y-6)=28$, tedy $2y=34$ a $y=17$. Před Emou je $11$ žáků, Ema je zapsána na 12. místě.'],
     'ans': '5.1: $7$ žáků; 5.2: na $12.$ místě', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2017 – úloha 6', 'zad': [
        'Na první číselné ose jsou vyznačeny tři stejně velké díly, na druhé ose čtyři. $A$, $B$, $C$, $D$ představují čtyři neznámá čísla. Šipka na první ose znamená, že číslo $A$ je nutné vynásobit dvěma, aby vzniklo číslo 36; šipka na druhé ose znamená, že k prvnímu vyznačenému číslu je nutné přičíst 36, aby vzniklo číslo $D$.',
        '6.1 Určete neznámá čísla $A$ a $B$.',
        '6.2 Určete neznámá čísla $C$ a $D$.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'ciselne-osy.svg',
     'alt': 'Dvě číselné osy: první se čtyřmi značkami A, B, prázdná, 36 a šipkou krát 2; druhá s pěti značkami, z nichž jsou popsány C, 50 a D, a šipkou plus 36.',
     'cap': 'Výchozí obrázek k úloze 6',
     'sol': ['6.1 Z šipky plyne $2A=36$, tedy $A=18$. Od $A$ k číslu 36 vedou tři stejné díly, jeden díl je $(36-18):3=6$. Proto $B=18+6=24$.',
             '6.2 Na druhé ose je $D$ o 36 větší než první značka. Mezi první značkou a $D$ jsou čtyři stejné díly, jeden díl je tedy $36:4=9$. Číslo 50 je předposlední značka, proto $D=50+9=59$ a $C$ je o dva díly menší než 50, tedy $C=50-18=32$.'],
     'ans': '6.1: $A=18$, $B=24$; 6.2: $C=32$, $D=59$', 'pts': 5, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2017 – úloha 7 (konstrukce)', 'zad': [
        'V rovině leží dvě různoběžné přímky $p$, $r$ a bod $D$ (viz obrázek).',
        'Bod $D$ je vrchol trojúhelníku $BCD$. Strana $BD$ leží na rovnoběžce s přímkou $r$. Strana $CD$ leží na kolmici k přímce $p$. Strana $BC$ leží na přímce $p$.',
        '7.1 Sestrojte trojúhelník $BCD$ a označte všechny jeho vrcholy.',
        '7.2 K bodům $B$, $C$, $D$ doplňte takový bod $A$, aby byl obrazec $ABCD$ obdélník. Obdélník $ABCD$ narýsujte.',
        '7.3 Sestrojte střed obdélníku $ABCD$ a označte jej $S$.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'primky-pr-bod-D.svg',
     'alt': 'Dvě různoběžné přímky p a r a bod D nad nimi.', 'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['7.1 Bodem $D$ vedeme rovnoběžku s přímkou $r$; její průsečík s přímkou $p$ je vrchol $B$. Bodem $D$ vedeme kolmici k přímce $p$; její pata na přímce $p$ je vrchol $C$. Trojúhelník $BCD$ má pravý úhel u vrcholu $C$.',
             '7.2 Protože $ABCD$ je obdélník, je $A$ obrazem bodu $D$ v posunutí o vektor $CB$ (tj. $AB$ je rovnoběžná s $DC$ a $AD$ s $BC$). Bod $A$ leží na rovnoběžce s $p$ vedené bodem $D$ a na rovnoběžce s $DC$ vedené bodem $B$.',
             '7.3 Střed $S$ je průsečík úhlopříček $AC$ a $BD$ (stačí sestrojit jednu úhlopříčku a její střed).'],
     'ans': 'Konstrukce podle klíče: $B$ je průsečík rovnoběžky s $r$ vedené bodem $D$ s přímkou $p$; $C$ je pata kolmice z $D$ na přímku $p$; $A$ doplníme tak, aby $ABCD$ byl obdélník; $S$ je průsečík úhlopříček $AC$ a $BD$.',
     'pts': 6, 'mins': 10, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2017 – úloha 8', 'zad': [
        'Ve čtvercové síti jsou umístěny tři tmavé obrazce $A$, $B$ a $C$. Obsah jednoho čtverečku ve čtvercové síti je $1$ cm². Krajní body úseček jsou v mřížových bodech.',
        'Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).',
        '8.1 Obsah obrazce $A$ je $4$ cm².',
        '8.2 Obsah obrazce $B$ je o $1$ cm² menší než obsah obrazce $A$.',
        '8.3 Obsah obrazce $C$ je $5$ cm².'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'ctvercova-sit.svg',
     'alt': 'Čtvercová síť 13 krát 5 se třemi tmavými obrazci: A je pětiúhelník, B rovnoběžník a C hvězdicový obrazec s bílým čtvercem uprostřed.',
     'cap': 'Výchozí obrázek k úloze 8 (schematický nákres)',
     'sol': ['8.1 Obrazec $A$ se dá rozdělit na trojúhelník a lichoběžník, jeho obsah je $3$ cm², nikoli $4$ cm² → Ne.',
             '8.2 Obrazec $B$ je rovnoběžník se základnou $2$ čtverečky a výškou $1$ čtvereček, tedy obsah $2$ cm². Platí $3-2=1$ → Ano.',
             '8.3 Obrazec $C$ leží ve čtverci $3\\times 3$ čtverečky; po odečtení čtyř rohových a čtyř zářezových trojúhelníků má vnější obrys obsah $6$ cm², bílý čtverec uprostřed má $1$ cm², takže tmavá část má $6-1=5$ cm² → Ano.'],
     'ans': '8.1: Ne; 8.2: Ano; 8.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2017 – úloha 9', 'zad': [
        'Chlapec trénoval střelbu na koš. Z prvních 12 pokusů se 9krát netrefil. Ve všech dalších pokusech byl s výjimkou jediného, předposledního hodu, úspěšný. Dosáhl tak přesně poloviční úspěšnosti (v polovině pokusů se trefil do koše).',
        'Kolikrát chlapec vystřelil na koš?'],
     'opts': ['A) méně než 22krát', 'B) 22krát', 'C) 23krát', 'D) více než 23krát',
              'E) Poloviční úspěšnosti nebylo možné dosáhnout.'], 'ln': 0,
     'sol': ['Z prvních 12 pokusů byly 3 úspěšné a 9 neúspěšných. Označme $n$ počet dalších pokusů; z nich byl neúspěšný právě jeden, takže úspěšných je $n-1$.',
             'Celkem: pokusů $12+n$, zásahů $3+(n-1)=n+2$, nezdarů $10$. Poloviční úspěšnost znamená, že zásahů je stejně jako nezdarů: $n+2=10$, tedy $n=8$.',
             'Chlapec vystřelil $12+8=20$krát, což je méně než 22krát.'],
     'ans': 'A) méně než 22krát', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2017 – úloha 10', 'zad': [
        'Děti si na výletě rozebraly 48 banánů. Některé děti si vzaly po jednom banánu, o 6 dětí méně si vzalo po dvou banánech a poslední, Anička, si jako jediná nevzala ani jeden banán.',
        'Kolik dětí bylo na výletě?'],
     'opts': ['A) méně než 35', 'B) 35', 'C) 36', 'D) 37', 'E) více než 37'], 'ln': 0,
     'sol': ['Nechť $x$ je počet dětí, které si vzaly jeden banán; po dvou banánech si vzalo $x-6$ dětí.',
             'Banánů je $x+2(x-6)=48$, tedy $3x-12=48$, $3x=60$ a $x=20$.',
             'Po dvou banánech si vzalo $14$ dětí. Celkem $20+14+1=35$ dětí (včetně Aničky).'],
     'ans': 'B) 35', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2017 – úloha 11', 'zad': [
        'Katka strávila prázdniny na několika místech. Nejprve byla doma. Na táboře strávila o třetinu více času než doma. U babičky byla o čtvrtinu kratší dobu než na táboře. Pak zůstala u kamarádky. Od ní odjela na chatu, kde pobývala o polovinu delší dobu než u kamarádky. V grafu je vyznačen tmavými pásy počet dnů strávených doma a na chatě, další údaje chybí.',
        'Kolik dnů strávila Katka u babičky?'],
     'opts': ['A) 6 dnů', 'B) 7 dnů', 'C) 8 dnů', 'D) 9 dnů', 'E) jiný počet dnů'], 'ln': 0,
     'svg': SVG11, 'fn': 'graf-prazdniny.svg',
     'alt': 'Pruhový graf s pěti řádky (doma, na táboře, u babičky, u kamarádky, na chatě); vyplněny jsou jen pásy doma 9 dnů a na chatě 12 dnů, osa je popsána po dvou dnech do 28.',
     'cap': 'Počet dnů strávených na jednotlivých místech',
     'sol': ['Z grafu: doma $9$ dnů. Na táboře o třetinu více: $9+9:3=9+3=12$ dnů.',
             'U babičky o čtvrtinu kratší dobu než na táboře: $12-12:4=12-3=9$ dnů.'],
     'ans': 'D) 9 dnů', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2017 – úloha 12', 'zad': [
        'Katka strávila prázdniny na několika místech. Nejprve byla doma. Na táboře strávila o třetinu více času než doma. U babičky byla o čtvrtinu kratší dobu než na táboře. Pak zůstala u kamarádky. Od ní odjela na chatu, kde pobývala o polovinu delší dobu než u kamarádky. V grafu je vyznačen tmavými pásy počet dnů strávených doma a na chatě, další údaje chybí.',
        'Kolik dnů strávila Katka u kamarádky?'],
     'opts': ['A) 6 dnů', 'B) 7 dnů', 'C) 8 dnů', 'D) 9 dnů', 'E) jiný počet dnů'], 'ln': 0,
     'svg': SVG11, 'fn': 'graf-prazdniny.svg',
     'alt': 'Pruhový graf s pěti řádky (doma, na táboře, u babičky, u kamarádky, na chatě); vyplněny jsou jen pásy doma 9 dnů a na chatě 12 dnů, osa je popsána po dvou dnech do 28.',
     'cap': 'Počet dnů strávených na jednotlivých místech',
     'sol': ['Z grafu: na chatě $12$ dnů. Doba na chatě je o polovinu delší než u kamarádky, tedy $12$ je jeden a půl násobek doby u kamarádky.',
             'Je-li u kamarádky $x$ dnů, platí $x+\\frac{x}{2}=12$, tj. $\\frac{3x}{2}=12$ a $x=8$ dnů.'],
     'ans': 'C) 8 dnů', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2017 – úloha 13', 'zad': [
        'Těleso na obrázku je slepeno z devíti stejně velkých krychlí. Směry pohledů shora, zepředu a zprava jsou vyznačeny šipkami.',
        'Každé situaci (13.1–13.3) přiřaďte odpovídající obrazec (A–F).',
        '13.1 pohled na těleso zepředu',
        '13.2 pohled na těleso shora',
        '13.3 pohled na těleso zprava'],
     'opts': None, 'ln': 3, 'svg': SVG13, 'fn': 'teleso-pohledy.svg',
     'alt': 'Těleso slepené z devíti krychlí se šipkami shora, zepředu a zprava a šest nabízených obrazců A až F složených z 5 až 7 čtverců.',
     'cap': 'Schematický nákres tělesa a nabídka obrazců A–F',
     'sol': ['Pohled zepředu tvoří šest čtverců uspořádaných do dvou horních vpravo, dvou prostředních vlevo a dvou spodních vpravo – obrazec E.',
             'Pohled shora tvoří šest čtverců: dva v horní řadě vpravo, jeden uprostřed a tři ve spodní řadě – obrazec F.',
             'Pohled zprava tvoří šest čtverců: čtverec $2\\times 2$ vlevo nahoře a dva čtverce vpravo dole – obrazec C.'],
     'ans': '13.1: E; 13.2: F; 13.3: C', 'pts': 5, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2017 – úloha 14', 'zad': [
        'Obrazovka monitoru je prázdná. Po zaznění zvukového signálu se každou sedmou sekundu objeví na obrazovce 4 nová kolečka. Každou jedenáctou sekundu naopak 3 kolečka z obrazovky zmizí. Pokud by měly obě akce proběhnout ve stejném okamžiku, počet koleček na obrazovce se nezmění.',
        '14.1 Určete počet koleček na obrazovce 1 minutu po zaznění zvukového signálu.',
        '14.2 Určete počet koleček na obrazovce 5 minut po zaznění zvukového signálu.'],
     'opts': None, 'ln': 3,
     'sol': ['Kolečka přibývají v sekundách dělitelných 7 a ubývají v sekundách dělitelných 11; v sekundách dělitelných $7\\cdot 11=77$ se počet nemění.',
             '14.1 Do 60 s: násobků 7 je 8 (7 až 56), násobků 11 je 5 (11 až 55), násobek 77 žádný. Počet $=8\\cdot 4-5\\cdot 3=32-15=17$.',
             '14.2 Do 300 s: násobků 7 je 42, násobků 11 je 27, násobků 77 jsou 3 (77, 154, 231). Účinných přírůstků $42-3=39$, úbytků $27-3=24$. Počet $=39\\cdot 4-24\\cdot 3=156-72=84$.'],
     'ans': '14.1: $17$ koleček; 14.2: $84$ koleček', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PAD17C0T01'
    gen.YEAR = 2017

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M5A' not in p['name']: errors.append('Chybí M5A: ' + p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    tot_pts = sum(p['pts'] for p in PROBLEMS)
    if tot_pts != 50: errors.append(f'Součet bodů je {tot_pts}, má být 50')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, body celkem:', tot_pts)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2017')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
