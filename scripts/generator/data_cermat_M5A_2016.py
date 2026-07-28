# -*- coding: utf-8 -*-
# CERMAT – Přijímací zkoušky 2016, MATEMATIKA 5 (osmileté obory), pilotní ročník, jeden termín.
# Kód testu: M5PZD16C0T01. 16 úloh v testu (po rozdělení izolovaných poduúloh 17 úloh), 50 bodů.
# Zdroj odpovědí: klíč správných řešení (KSR) + záznamový arch (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 7: výchozí obrázek – přímka o s bodem C, mimo ni bod B
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 360" font-family="sans-serif">
<rect x="6" y="6" width="508" height="348" fill="none" stroke="#999"/>
<line x1="40" y1="320" x2="452" y2="108" stroke="#000" stroke-width="2"/>
<text x="462" y="104" font-size="17" font-style="italic">o</text>
<text x="140" y="264" font-size="16" text-anchor="middle">x</text>
<text x="140" y="292" font-size="17" font-style="italic" text-anchor="middle">C</text>
<text x="300" y="156" font-size="16" text-anchor="middle">x</text>
<text x="316" y="148" font-size="17" font-style="italic">B</text>
</svg>"""

# úloha 8: obrazec ze 2 rovnostranných a 2 rovnoramenných trojúhelníků (schematicky, v poměru stran)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 195" font-family="sans-serif">
<polygon points="25,125 97,125 61,63" fill="#ffffff" stroke="#000" stroke-width="2"/>
<polygon points="61,63 97,125 200,24" fill="#111111" stroke="#000" stroke-width="2"/>
<polygon points="97,125 236,163 200,24" fill="#b9b9b9" stroke="#000" stroke-width="2"/>
<polygon points="200,24 236,163 488,24" fill="#ffffff" stroke="#000" stroke-width="2"/>
<text x="55" y="143" font-size="16" font-style="italic">a</text>
<text x="150" y="158" font-size="16" font-style="italic">b</text>
<text x="352" y="82" font-size="16" font-style="italic">c</text>
</svg>"""


# úloha 10: obdélník ABCD ve čtvercové síti 6x3, oddělené trojúhelníky AFD a BCE
def _rect10():
    cell = 46
    ox, oy = 50, 40
    W, H = 6, 3
    x1, y1 = ox + W * cell, oy + H * cell
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 390 220" font-family="sans-serif">']
    s.append(f'<polygon points="{ox},{y1} {ox+cell},{oy} {ox},{oy}" fill="#d0d0d0"/>')
    s.append(f'<polygon points="{x1},{y1} {x1},{oy} {ox+4*cell},{oy}" fill="#d0d0d0"/>')
    for i in range(W + 1):
        s.append(f'<line x1="{ox+i*cell}" y1="{oy}" x2="{ox+i*cell}" y2="{y1}" stroke="#999"/>')
    for j in range(H + 1):
        s.append(f'<line x1="{ox}" y1="{oy+j*cell}" x2="{x1}" y2="{oy+j*cell}" stroke="#999"/>')
    s.append(f'<rect x="{ox}" y="{oy}" width="{W*cell}" height="{H*cell}" fill="none" stroke="#000" stroke-width="3"/>')
    s.append(f'<line x1="{ox}" y1="{y1}" x2="{ox+cell}" y2="{oy}" stroke="#000" stroke-width="3"/>')
    s.append(f'<line x1="{ox+4*cell}" y1="{oy}" x2="{x1}" y2="{y1}" stroke="#000" stroke-width="3"/>')
    lab = [('D', ox - 6, oy - 8), ('F', ox + cell - 6, oy - 8), ('E', ox + 4 * cell - 6, oy - 8),
           ('C', x1 + 4, oy - 8), ('A', ox - 14, y1 + 18), ('B', x1 + 6, y1 + 18)]
    for t, x, y in lab:
        s.append(f'<text x="{x}" y="{y}" font-size="16" font-style="italic">{t}</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _rect10()


# úloha 12: sloupcový graf sběru papíru (bez číselné osy – měřítko se dopočítává ze zadání)
def _graf12():
    data = [('K', 6, 2, 10), ('L', 8, 4, 8), ('M', 6, 6, 6), ('N', 2, 8, 2), ('O', 2, 10, 6)]
    x0, y0 = 78, 252
    u = 18.0
    bw, gap = 19, 20
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 320" font-family="sans-serif">']
    s.append('<text x="270" y="26" font-size="17" font-weight="bold" text-anchor="middle">Sběr papíru</text>')
    s.append('<text x="26" y="150" font-size="13" text-anchor="middle" transform="rotate(-90 26 150)">hmotnost papíru v tunách</text>')
    for v in range(2, 13, 2):
        y = y0 - v * u
        s.append(f'<line x1="{x0}" y1="{y}" x2="465" y2="{y}" stroke="#bbb"/>')
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000" stroke-width="2"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="465" y2="{y0}" stroke="#000" stroke-width="2"/>')
    x = x0 + gap
    for name, a, b, c in data:
        for val, col in ((a, '#ffffff'), (b, '#c9c9c9'), (c, '#6b6b6b')):
            h = val * u
            s.append(f'<rect x="{x}" y="{y0-h}" width="{bw}" height="{h}" fill="{col}" stroke="#000"/>')
            x += bw
        s.append(f'<text x="{x-3*bw/2}" y="{y0+20}" font-size="14" text-anchor="middle">{name}</text>')
        x += gap
    leg = [('2013', '#ffffff'), ('2014', '#c9c9c9'), ('2015', '#6b6b6b')]
    ly = 80
    for t, col in leg:
        s.append(f'<rect x="480" y="{ly}" width="14" height="14" fill="{col}" stroke="#000"/>')
        s.append(f'<text x="500" y="{ly+12}" font-size="13">{t}</text>')
        ly += 26
    s.append('</svg>')
    return "".join(s)
SVG12 = _graf12()


# úlohy 13 a 14: Lukášova dvoupatrová stavba a Emina část stavby (schematický nákres z krychliček)
def _kostky():
    W, H, D = 26, 30, 9
    luk0 = [(c, p) for c in range(5) for p in range(5) if (c, p) not in ((0, 0), (4, 0), (0, 4), (4, 4))]
    luk1 = [(2, 1), (1, 2), (2, 2), (3, 2), (2, 3)]
    ema0 = [(c, p) for c in range(3) for p in range(3) if (c, p) != (2, 0)]
    ema1 = [(0, 1), (0, 2), (1, 2)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 260" font-family="sans-serif">',
         '<g fill="#ffffff" stroke="#000" stroke-linejoin="round">']

    def draw(cubes, X0, Y0):
        have = set(cubes)
        cubes.sort(key=lambda t: (-t[1], t[2], t[0]))
        for c, p, l in cubes:
            x = X0 + c * W + p * D
            y = Y0 - l * H - p * D
            s.append(f'<path d="M{x} {y}h{W}v{H}h-{W}z"/>')
            if (c, p, l + 1) not in have:
                s.append(f'<path d="M{x} {y}l{D}-{D}h{W}l-{D} {D}z"/>')
            if (c + 1, p, l) not in have:
                s.append(f'<path d="M{x+W} {y}l{D}-{D}v{H}l-{D} {D}z" fill="#c8c8c8"/>')

    draw([(c, p, 0) for c, p in luk0] + [(c, p, 1) for c, p in luk1], 18, 196)
    draw([(c, p, 0) for c, p in ema0] + [(c, p, 1) for c, p in ema1], 258, 196)
    s.append('</g>')
    s.append('<text x="110" y="240" font-size="14" text-anchor="middle">Lukášova stavba</text>')
    s.append('<text x="315" y="240" font-size="14" text-anchor="middle">Emina stavba</text>')
    s.append('</svg>')
    return "".join(s)
SVGK = _kostky()


# úloha 16: čtverec 5x5 tmavých čtverečků na obou úhlopříčkách (9 tmavých čtverečků)
def _ctverec16():
    n, cell, ox, oy = 5, 40, 20, 20
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 240" font-family="sans-serif">']
    dark = set([(i, i) for i in range(n)] + [(i, n - 1 - i) for i in range(n)])
    for i, j in sorted(dark):
        s.append(f'<rect x="{ox+i*cell}" y="{oy+j*cell}" width="{cell}" height="{cell}" fill="#b9b9b9" stroke="#555"/>')
    s.append(f'<rect x="{ox}" y="{oy}" width="{n*cell}" height="{n*cell}" fill="none" stroke="#000" stroke-width="3"/>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _ctverec16()


B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 v taxonomii není

PROBLEMS = [
    {'name': 'CERMAT M5A 2016 – úloha 1', 'zad': ['Vypočtěte: $80-15\\cdot 5-5:5=$'], 'opts': None, 'ln': 2,
     'sol': ['Nejprve násobení a dělení: $15\\cdot 5=75$, $5:5=1$.',
             'Potom zleva doprava: $80-75-1=4$.'],
     'ans': '$4$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 2', 'zad': [
        'Vypočtěte, kolikrát je třeba k číslu $750$ přičíst číslo $10$, abychom získali číslo $7\\,500$.'],
     'opts': None, 'ln': 2,
     'sol': ['Musíme přidat $7\\,500-750=6\\,750$.',
             'Přičítáme po deseti: $6\\,750:10=675$.'],
     'ans': '$675$krát', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 3.1', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '$(60-24):4=(60-24:4):\\square$'],
     'opts': None, 'ln': 2,
     'sol': ['Levá strana: $(60-24):4=36:4=9$.',
             'Pravá strana: $(60-24:4)=(60-6)=54$, tedy $54:\\square=9$.',
             'Odtud $\\square=54:9=6$.'],
     'ans': '$6$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 3.2', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '$10+12\\cdot 3=10+(12\\cdot 3)+\\square$'],
     'opts': None, 'ln': 2,
     'sol': ['Levá strana: $10+36=46$.',
             'Pravá strana: $10+36+\\square=46+\\square$.',
             'Obě strany se rovnají, tedy $\\square=0$.'],
     'ans': '$0$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 4', 'zad': [
        'Nahraďte každou hvězdičku ($*$) takovou číslicí, aby byl součin co nejmenší. Zapište celý výpočet (oba činitele i součin).',
        'Čtyřciferné číslo $*\\,*\\,*\\,*$ násobíme dvěma a dostaneme pěticiferný součin ve tvaru $1\\,*\\,*\\,5\\,2$.'],
     'opts': None, 'ln': 3,
     'sol': ['Součin má tvar $1\\,*\\,*\\,5\\,2$, nejmenší možný takový součin je $10\\,052$.',
             'Ověření: $10\\,052:2=5\\,026$ je čtyřciferné číslo, tedy zápis vychází.',
             'Výpočet: $5\\,026\\cdot 2=10\\,052$.'],
     'ans': '$5\\,026\\cdot 2=10\\,052$', 'pts': 3, 'mins': 4, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 5', 'zad': [
        'Na talíři bylo 12 koláčů. Dan z nich snědl třetinu. Eva snědla stejný počet koláčů jako Dan, ale vzala si je z mísy. Počet koláčů na míse se tak zmenšil o pětinu.',
        '5.1 Vypočtěte, kolik koláčů zbylo na talíři.',
        '5.2 Vypočtěte, kolik koláčů bylo v míse, než je Eva začala jíst.'],
     'opts': None, 'ln': 3,
     'sol': ['5.1 Dan snědl $12:3=4$ koláče, na talíři zbylo $12-4=8$ koláčů.',
             '5.2 Eva snědla také $4$ koláče a to byla pětina obsahu mísy, tedy v míse bylo $4\\cdot 5=20$ koláčů.'],
     'ans': '5.1: $8$ koláčů; 5.2: $20$ koláčů', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2016 – úloha 6', 'zad': [
        'Na trase Bor–Raná jezdí proti sobě dva vlaky. Při každé cestě oba vlaky vyjíždějí ve stejnou dobu a potkávají se pravidelně v polovině doby jízdy.',
        'Hodiny nyní ukazují 18:05 a naposledy se oba vlaky potkaly před čtvrt hodinou. Vlak do Rané přijede v 18:10.',
        '6.1 Zapište, v kolik hodin se oba vlaky naposledy potkaly.',
        '6.2 Vypočtěte, jak dlouho trvá cesta vlakem z Boru do Rané.'],
     'opts': None, 'ln': 3,
     'sol': ['6.1 Čtvrt hodiny je $15$ minut, tedy $18{:}05-15$ minut $=17{:}50$.',
             '6.2 Od setkání v $17{:}50$ do příjezdu v $18{:}10$ uplyne $20$ minut, což je druhá polovina jízdy.',
             'Celá cesta tedy trvá $2\\cdot 20=40$ minut.'],
     'ans': '6.1: v 17:50; 6.2: $40$ minut', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2016 – úloha 7 (konstrukce)', 'zad': [
        'Na přímce $o$ leží bod $C$, mimo ni bod $B$ (viz obrázek).',
        '7.1 Narýsujte přímku $p$, která prochází bodem $B$ a je kolmá k přímce $o$. Průsečík přímek $o$, $p$ označte $S$.',
        '7.2 Přímka $o$ rozděluje rovnoramenný trojúhelník $ABC$ na dvě shodné části. Sestrojte chybějící vrchol $A$ trojúhelníku $ABC$ a trojúhelník narýsujte.',
        '7.3 Trojúhelník $ABC$ leží uvnitř čtverce $BCDE$. Sestrojte dva chybějící vrcholy $D$, $E$ čtverce $BCDE$ a čtverec narýsujte.',
        '7.4 Sestrojte přímku $m$, která prochází bodem $B$ a je rovnoběžná s přímkou $AC$.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'primka-o-bod-B.svg',
     'alt': 'Výchozí obrázek: přímka o s vyznačeným bodem C a bod B ležící mimo přímku o.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['7.1 Kolmici $p$ vedeme bodem $B$ k přímce $o$; její průsečík s $o$ je bod $S$.',
             '7.2 Přímka $o$ je osou souměrnosti rovnoramenného trojúhelníku $ABC$ (vrchol $C$ na ní leží). Vrchol $A$ je proto obrazem bodu $B$ v osové souměrnosti podle $o$: leží na přímce $p$ tak, že $|SA|=|SB|$ a body $A$, $B$ jsou na opačných stranách přímky $o$.',
             '7.3 Nad stranou $BC$ sestrojíme čtverec $BCDE$ na té straně, kde leží bod $A$: v bodech $B$ a $C$ vztyčíme kolmice k $BC$ a naneseme na ně délku $|BC|$; získáme vrcholy $D$ (u $C$) a $E$ (u $B$).',
             '7.4 Bodem $B$ vedeme rovnoběžku $m$ s přímkou $AC$.'],
     'ans': 'Konstrukce: $p\\perp o$ bodem $B$, průsečík $S$; $A$ je obraz bodu $B$ v osové souměrnosti podle $o$ (leží na $p$, $|SA|=|SB|$); čtverec $BCDE$ nad stranou $BC$ na straně bodu $A$; přímka $m$ bodem $B$ rovnoběžná s $AC$ – viz obrázek v klíči.',
     'pts': 6, 'mins': 10, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 8', 'zad': [
        'Obrazec je vytvořen ze 2 rovnostranných a 2 rovnoramenných trojúhelníků.',
        'Obvod šedého trojúhelníku je 18 cm. O délkách vyznačených stran $a$, $b$, $c$ víme, že $b$ je polovinou $c$ a dvojnásobkem $a$.',
        '8.1 Vypočítejte obvod černého trojúhelníku.',
        '8.2 Vypočítejte obvod celého obrazce.'],
     'opts': None, 'ln': 3, 'svg': SVG8, 'fn': 'obrazec-trojuhelniky.svg',
     'alt': 'Obrazec ze čtyř trojúhelníků: malý bílý se stranou a, černý, šedý se stranou b a velký bílý se stranou c.',
     'cap': 'Schematický nákres obrazce',
     'sol': ['Šedý trojúhelník je rovnostranný se stranou $b$, tedy $3b=18$ a $b=6$ cm.',
             'Odtud $a=\\frac{b}{2}=3$ cm a $c=2b=12$ cm.',
             '8.1 Černý trojúhelník je rovnoramenný se stranami $b$, $b$, $a$: obvod $=6+6+3=15$ cm.',
             '8.2 Obvod obrazce tvoří dvakrát úsečka délky $a$, dvakrát délky $b$ a dvakrát délky $c$: $2\\cdot 3+2\\cdot 6+2\\cdot 12=42$ cm.'],
     'ans': '8.1: $15$ cm; 8.2: $42$ cm', 'pts': 3, 'mins': 5, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 9', 'zad': [
        'Rozhodněte o každém tvrzení (9.1–9.3), zda je pravdivé (A), či nikoli (N).',
        '9.1 Čtvrtina jednoho kg je 250 g.',
        '9.2 400 m je možné rozdělit na 1 000 stejných dílů délky 40 cm.',
        '9.3 Čtyři čtverce o obsahu 25 cm$^2$ mají dohromady obsah 1 m$^2$.'],
     'opts': None, 'ln': 0,
     'sol': ['9.1 $1$ kg $=1\\,000$ g, čtvrtina je $1\\,000:4=250$ g. Tvrzení platí.',
             '9.2 $1\\,000\\cdot 40$ cm $=40\\,000$ cm $=400$ m. Tvrzení platí.',
             '9.3 $4\\cdot 25=100$ cm$^2$, ale $1$ m$^2=10\\,000$ cm$^2$. Tvrzení neplatí.'],
     'ans': '9.1: Ano; 9.2: Ano; 9.3: Ne', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 10', 'zad': [
        'Oddělením dvou trojúhelníků $AFD$ a $BCE$ z obdélníku $ABCD$ vznikne bílý obrazec $ABEF$. Všechny uvedené body jsou v mřížových bodech čtvercové sítě (viz obrázek).',
        'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).',
        '10.1 Obsah trojúhelníku $AFD$ je 2krát menší než obsah trojúhelníku $BCE$.',
        '10.2 Obsah bílého obrazce $ABEF$ je 9krát větší než obsah trojúhelníku $AFD$.',
        '10.3 Obvod bílého obrazce $ABEF$ je stejný jako součet obvodů trojúhelníků $AFD$ a $BCE$.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'obdelnik-ABCD.svg',
     'alt': 'Obdélník ABCD ve čtvercové síti 6 krát 3 s oddělenými trojúhelníky AFD a BCE.',
     'cap': 'Obdélník $ABCD$ ve čtvercové síti',
     'sol': ['Jeden čtvereček sítě má obsah $1$; obdélník má rozměry $6$ a $3$, tedy obsah $18$.',
             '10.1 $S_{AFD}=\\frac{1\\cdot 3}{2}=1{,}5$ a $S_{BCE}=\\frac{2\\cdot 3}{2}=3$; opravdu $1{,}5=3:2$. Tvrzení platí.',
             '10.2 $S_{ABEF}=18-1{,}5-3=13{,}5$ a $13{,}5=9\\cdot 1{,}5$. Tvrzení platí.',
             '10.3 Obvod $ABEF$ je $|AB|+|BE|+|EF|+|FA|=6+3+|BE|+|FA|$. Obvod $AFD$ je $3+1+|FA|$ a obvod $BCE$ je $3+2+|BE|$, dohromady $9+|FA|+|BE|$. Obě hodnoty se rovnají. Tvrzení platí.'],
     'ans': '10.1: Ano; 10.2: Ano; 10.3: Ano', 'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 11', 'zad': [
        'Na knižní veletrh šli tři kamarádi. Dva z nich měli vstup za plnou cenu a jeden za poloviční cenu. Na veletrhu si všichni tři koupili stejnou knihu.',
        'Jedna kniha a jeden vstup za plnou cenu stály celkem 250 Kč, další dvě knihy a oba zbývající vstupy 470 Kč.',
        'Kolik korun stála jedna kniha?'],
     'opts': ['A) méně než 190 Kč', 'B) 190 Kč', 'C) 200 Kč', 'D) 210 Kč', 'E) více než 210 Kč'],
     'ln': 0,
     'sol': ['Označme $k$ cenu knihy a $v$ cenu plného vstupu. Platí $k+v=250$ a $2k+v+\\frac{v}{2}=470$.',
             'Z první rovnice $v=250-k$; dosazením: $2k+1{,}5\\cdot(250-k)=470$, tedy $0{,}5k+375=470$.',
             'Odtud $0{,}5k=95$ a $k=190$ Kč.'],
     'ans': 'B) 190 Kč', 'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2016 – úloha 12', 'zad': [
        'Školy K, L, M, N a O v letech 2013–2015 soutěžily ve sběru papíru. V roce 2014 nasbíralo všech pět škol dohromady 30 tun papíru (viz graf).',
        'Vítězem soutěže se stala škola, která za 3 roky nasbírala nejvíce papíru.',
        'Kolik tun papíru nasbírala za 3 roky vítězná škola?'],
     'opts': ['A) méně než 10 tun', 'B) 10 tun', 'C) 18 tun', 'D) 20 tun', 'E) více než 20 tun'],
     'ln': 0, 'svg': SVG12, 'fn': 'graf-sber-papiru.svg',
     'alt': 'Sloupcový graf sběru papíru pěti škol K až O v letech 2013, 2014 a 2015 bez číselné osy.',
     'cap': 'Sběr papíru (hmotnost v tunách)',
     'sol': ['V roce 2014 odpovídají sloupce dílkům $1+2+3+4+5=15$, dohromady $30$ tun, jeden dílek je tedy $2$ tuny.',
             'Součty za tři roky: K $=6+2+10=18$ t, L $=8+4+8=20$ t, M $=6+6+6=18$ t, N $=2+8+2=12$ t, O $=2+10+6=18$ t.',
             'Nejvíce nasbírala škola L, a to $20$ tun.'],
     'ans': 'D) 20 tun', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['statistika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2016 – úloha 13', 'zad': [
        'Lukáš si postavil z kostek pravidelnou dvoupatrovou stavbu. Ema si v rohu místnosti postavila jen část této stavby (viz obrázek).',
        'O kolik kostek se obě stavby liší?'],
     'opts': ['A) méně než o 15', 'B) o 15', 'C) o 16', 'D) o 17', 'E) více než o 17'],
     'ln': 0, 'svg': SVGK, 'fn': 'stavby-z-kostek.svg',
     'alt': 'Dvě stavby z krychlových kostek: Lukášova dvoupatrová stavba a menší Emina stavba v rohu místnosti.',
     'cap': 'Schematický nákres obou staveb',
     'sol': ['Lukášova stavba: dolní patro je čtverec $5\\times 5$ bez čtyř rohových kostek, tj. $25-4=21$ kostek; horní patro tvoří kříž z $5$ kostek. Celkem $21+5=26$ kostek.',
             'Emina stavba: dolní patro tvoří roh $3\\times 3$ bez jedné kostky, tj. $8$ kostek; nahoře jsou $3$ kostky. Celkem $11$ kostek.',
             'Stavby se liší o $26-11=15$ kostek.'],
     'ans': 'B) o 15', 'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 14', 'zad': [
        'Lukáš si postavil z kostek pravidelnou dvoupatrovou stavbu. Ema si v rohu místnosti postavila jen část této stavby (viz obrázek).',
        'Jaký nejmenší počet kostek potřebuje Ema k doplnění své stavby na krychli?'],
     'opts': ['A) 7', 'B) 11', 'C) 16', 'D) 17', 'E) jiný počet'],
     'ln': 0, 'svg': SVGK, 'fn': 'stavby-z-kostek.svg',
     'alt': 'Dvě stavby z krychlových kostek: Lukášova dvoupatrová stavba a menší Emina stavba v rohu místnosti.',
     'cap': 'Schematický nákres obou staveb',
     'sol': ['Emina stavba má $8$ kostek v dolním patře a $3$ kostky v horním patře, tedy $11$ kostek.',
             'Vejde se do krychle o hraně $3$ kostky, což je nejmenší možná krychle; ta má $3\\cdot 3\\cdot 3=27$ kostek.',
             'Ema tedy potřebuje doplnit $27-11=16$ kostek.'],
     'ans': 'C) 16', 'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5A 2016 – úloha 15', 'zad': [
        'Adéla přečetla 20 stran knihy, Dana 40 stran a Petr 60 stran.',
        'V nedokončené větě (15.1–15.3) doplňte chybějící část (A–F) tak, aby vzniklo pravdivé tvrzení.',
        '15.1 Adéla přečetla…',
        '15.2 Dana přečetla…',
        '15.3 Petr přečetl…'],
     'opts': ['A) o polovinu více než Dana.', 'B) o třetinu více než Dana.', 'C) o polovinu více než Adéla.',
              'D) o třetinu méně než Petr.', 'E) pětinu toho, co přečetly zbývající dvě děti dohromady.',
              'F) třetinu toho, co přečetly zbývající dvě děti dohromady.'],
     'ln': 0,
     'sol': ['15.1 Dana a Petr přečetli dohromady $40+60=100$ stran a $20$ je pětina ze $100$ → E.',
             '15.2 Třetina z Petrových $60$ stran je $20$; $60-20=40$ → D.',
             '15.3 Polovina z Daniných $40$ stran je $20$; $40+20=60$ → A.'],
     'ans': '15.1: E; 15.2: D; 15.3: A', 'pts': 6, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5A 2016 – úloha 16', 'zad': [
        'Ve čtverci jsou obě úhlopříčky překryty tmavými čtverečky s délkou strany 4 cm podobně jako na obrázku. Zbytek plochy čtverce je bílý.',
        '16.1 Vypočtěte délku strany čtverce, který má celkem 9 tmavých čtverečků.',
        '16.2 Vypočtěte délku strany čtverce, který má celkem 29 tmavých čtverečků.',
        '16.3 Vypočtěte celkový počet tmavých čtverečků, je-li délka strany čtverce 140 cm.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'ctverec-uhlopricky.svg',
     'alt': 'Čtverec rozdělený na 5 krát 5 čtverečků, na obou úhlopříčkách je 9 tmavých čtverečků.',
     'cap': 'Schematický nákres (čtverec s 9 tmavými čtverečky)',
     'sol': ['Je-li strana čtverce složena z $n$ čtverečků, leží na každé úhlopříčce $n$ tmavých čtverečků a pro liché $n$ mají jeden společný (prostřední). Celkem je tedy $2n-1$ tmavých čtverečků.',
             '16.1 $2n-1=9$ dává $n=5$, strana měří $5\\cdot 4=20$ cm.',
             '16.2 $2n-1=29$ dává $n=15$, strana měří $15\\cdot 4=60$ cm.',
             '16.3 $140:4=35$ čtverečků na straně, tedy $2\\cdot 35-1=69$ tmavých čtverečků.'],
     'ans': '16.1: $20$ cm; 16.2: $60$ cm; 16.3: $69$ čtverečků', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PZD16C0T01'
    gen.YEAR = 2016

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
    pts = sum(p['pts'] for p in PROBLEMS)
    if pts != 50: errors.append(f'Součet bodů {pts} != 50')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, bodů celkem:', pts)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2016')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
