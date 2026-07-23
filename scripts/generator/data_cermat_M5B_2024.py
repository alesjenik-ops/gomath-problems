# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2024, MATEMATIKA 5B (osmileté obory, 5. ročník).
# Kód testu: M5PBD24C0T02. 14 úloh (po rozdělení nezávislých poduúloh 18 úloh), 50 bodů.
# Zdroj odpovědí: klíč správných řešení (KLIC_5B_2024). Ověřeno vlastním výpočtem.

import math

# ---- SVG obrázky (bez ' a \) ----

# úloha 3: řetězec rámečků a šipek s operacemi (x, +2, *3, -6, :3, *6 -> 12)
def _arrows():
    ops = ["+2", "·3", "−6", ":3", "·6"]
    boxes = ["x", "", "", "", "", "12"]
    bw = 62; bh = 46; gap = 44; oy = 56
    x = 18
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 130" font-family="sans-serif">']
    for i, b in enumerate(boxes):
        s.append(f'<rect x="{x}" y="{oy}" width="{bw}" height="{bh}" fill="none" stroke="#000"/>')
        style = ' font-style="italic"' if b == "x" else ''
        s.append(f'<text x="{x+bw/2:.0f}" y="{oy+bh/2+6:.0f}" font-size="16" text-anchor="middle"{style}>{b}</text>')
        x += bw
        if i < len(ops):
            s.append(f'<line x1="{x}" y1="{oy+bh/2:.0f}" x2="{x+gap}" y2="{oy+bh/2:.0f}" stroke="#000"/>')
            s.append(f'<polygon points="{x+gap},{oy+bh/2:.0f} {x+gap-9},{oy+bh/2-5:.0f} {x+gap-9},{oy+bh/2+5:.0f}" fill="#000"/>')
            s.append(f'<text x="{x+gap/2:.0f}" y="{oy-8:.0f}" font-size="14" text-anchor="middle">{ops[i]}</text>')
            x += gap
    s.append('</svg>')
    return "".join(s)
SVG3 = _arrows()

# úloha 6: tyč rozdělená na 10 stejných úseků; značka 1 u 3. dílku (39 cm), značka A u 6. dílku
def _rod():
    n = 10; seg = 48; ox = 40; oy = 66; h = 34
    W = ox * 2 + n * seg
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} 150" font-family="sans-serif">']
    s.append(f'<rect x="{ox}" y="{oy}" width="{n*seg}" height="{h}" fill="#c9c9c9" stroke="#000"/>')
    for i in range(1, n):
        xx = ox + i * seg
        s.append(f'<line x1="{xx}" y1="{oy}" x2="{xx}" y2="{oy+h}" stroke="#000"/>')
    for pos, top, bot in ((3, "1.", "39 cm"), (6, "2.", "A")):
        mx = ox + pos * seg
        s.append(f'<line x1="{mx}" y1="{oy-12}" x2="{mx}" y2="{oy+h+12}" stroke="#000" stroke-width="2"/>')
        s.append(f'<text x="{mx}" y="{oy-18}" font-size="14" text-anchor="middle">{top}</text>')
        s.append(f'<text x="{mx}" y="{oy+h+28}" font-size="14" text-anchor="middle">{bot}</text>')
    s.append('</svg>')
    return "".join(s)
SVG6 = _rod()

# úloha 7: výchozí obrázek – body A, E, F
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 380" font-family="sans-serif">
<rect x="10" y="10" width="440" height="360" fill="none" stroke="#bbb"/>
<text x="230" y="34" font-size="13" text-anchor="middle">Jsou dany body A, E, F.</text>
<text x="232" y="152" font-size="16" text-anchor="middle">×</text><text x="242" y="146" font-size="15" font-style="italic">E</text>
<text x="150" y="260" font-size="16" text-anchor="middle">×</text><text x="146" y="278" font-size="15" font-style="italic">A</text>
<text x="300" y="270" font-size="16" text-anchor="middle">×</text><text x="296" y="288" font-size="15" font-style="italic">F</text>
</svg>"""

# úloha 8: skupinový sloupcový graf – sport, počítač, učení (pondělí–neděle)
def _bars():
    days = [("pondělí", 1, 1.5, 1), ("úterý", 1, 1.5, 1), ("středa", 2, 2, 2),
            ("čtvrtek", 1, 3, 2), ("pátek", 1, 3, 2), ("sobota", 2, 2, 1), ("neděle", 2, 2, 1)]
    ticks = [(0, "0"), (0.5, "0,5"), (1, "1"), (1.5, "1,5"), (2, "2"), (2.5, "2,5"), (3, "3"), (3.5, "3,5")]
    x0, y0 = 60, 300; unit = 70; bw = 15; g = 6; grpgap = 26
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 360" font-family="sans-serif">']
    for val, lab in ticks:
        y = y0 - val * unit
        s.append(f'<line x1="{x0}" y1="{y:.0f}" x2="660" y2="{y:.0f}" stroke="#ddd"/>')
        s.append(f'<text x="{x0-8}" y="{y+4:.0f}" font-size="11" text-anchor="end">{lab}</text>')
    s.append(f'<line x1="{x0}" y1="20" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="660" y2="{y0}" stroke="#000"/>')
    s.append(f'<text x="18" y="170" font-size="11" text-anchor="middle" transform="rotate(-90 18 170)">počet hodin za den</text>')
    x = x0 + 16
    for name, sp, pc, uc in days:
        gx = x
        for val, col in ((sp, "#9a9a9a"), (pc, "#dcdcdc"), (uc, "#555")):
            hh = val * unit
            s.append(f'<rect x="{x}" y="{y0-hh:.0f}" width="{bw}" height="{hh:.0f}" fill="{col}" stroke="#000"/>')
            x += bw + g
        cx = (gx + x - g) / 2
        s.append(f'<text x="{cx:.0f}" y="{y0+16}" font-size="10" text-anchor="middle">{name}</text>')
        x += grpgap
    lx = 560
    for i, (col, lab) in enumerate([("#9a9a9a", "sport"), ("#dcdcdc", "počítač"), ("#555", "učení")]):
        yy = 38 + i * 18
        s.append(f'<rect x="{lx}" y="{yy}" width="12" height="12" fill="{col}" stroke="#000"/><text x="{lx+18}" y="{yy+10}" font-size="12">{lab}</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _bars()

# úloha 10: dřevěná krychle 4x4x4 natřená ze všech stran, rozřezaná na 64 krychliček (schematicky)
def _cube():
    ox, oy = 45, 95; L = 200; dx, dy = 52, -42; n = 4; c = L / n
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 330 300" font-family="sans-serif">']
    s.append(f'<rect x="{ox}" y="{oy}" width="{L}" height="{L}" fill="none" stroke="#000"/>')
    for i in range(1, n):
        s.append(f'<line x1="{ox+i*c:.0f}" y1="{oy}" x2="{ox+i*c:.0f}" y2="{oy+L}" stroke="#000"/>')
        s.append(f'<line x1="{ox}" y1="{oy+i*c:.0f}" x2="{ox+L}" y2="{oy+i*c:.0f}" stroke="#000"/>')
    s.append(f'<polygon points="{ox},{oy} {ox+L},{oy} {ox+L+dx},{oy+dy} {ox+dx},{oy+dy}" fill="none" stroke="#000"/>')
    for i in range(1, n):
        s.append(f'<line x1="{ox+i*c:.0f}" y1="{oy}" x2="{ox+i*c+dx:.0f}" y2="{oy+dy}" stroke="#000"/>')
        s.append(f'<line x1="{ox+dx*i/n:.0f}" y1="{oy+dy*i/n:.0f}" x2="{ox+L+dx*i/n:.0f}" y2="{oy+dy*i/n:.0f}" stroke="#000"/>')
    s.append(f'<polygon points="{ox+L},{oy} {ox+L+dx},{oy+dy} {ox+L+dx},{oy+dy+L} {ox+L},{oy+L}" fill="none" stroke="#000"/>')
    for i in range(1, n):
        s.append(f'<line x1="{ox+L}" y1="{oy+i*c:.0f}" x2="{ox+L+dx}" y2="{oy+i*c+dy:.0f}" stroke="#000"/>')
        s.append(f'<line x1="{ox+L+dx*i/n:.0f}" y1="{oy+dy*i/n:.0f}" x2="{ox+L+dx*i/n:.0f}" y2="{oy+dy*i/n+L:.0f}" stroke="#000"/>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _cube()

# úloha 11: kruhový diagram – 10 shodných dílků; známky 1(1), 2(2), 3(4), 4(2), 5(1)
def _pie():
    cx, cy, r = 165, 150, 120
    groups = [("1", 1, "#e8e8e8"), ("2", 2, "#ffffff"), ("3", 4, "#8f8f8f"), ("4", 2, "#cfcfcf"), ("5", 1, "#bcbcbc")]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 300" font-family="sans-serif">']
    start = -90.0; idx = 0
    for lab, parts, col in groups:
        a0 = math.radians(start + idx * 36)
        a1 = math.radians(start + (idx + parts) * 36)
        x0 = cx + r * math.cos(a0); y0 = cy + r * math.sin(a0)
        x1 = cx + r * math.cos(a1); y1 = cy + r * math.sin(a1)
        large = 1 if parts * 36 > 180 else 0
        s.append(f'<path d="M {cx} {cy} L {x0:.1f} {y0:.1f} A {r} {r} 0 {large} 1 {x1:.1f} {y1:.1f} Z" fill="{col}" stroke="#000"/>')
        am = math.radians(start + (idx + parts / 2) * 36)
        lxp = cx + 0.62 * r * math.cos(am); lyp = cy + 0.62 * r * math.sin(am)
        s.append(f'<text x="{lxp:.1f}" y="{lyp+5:.1f}" font-size="15" text-anchor="middle" font-weight="bold">{lab}</text>')
        idx += parts
    for k in range(10):
        a = math.radians(start + k * 36)
        s.append(f'<line x1="{cx}" y1="{cy}" x2="{cx+r*math.cos(a):.1f}" y2="{cy+r*math.sin(a):.1f}" stroke="#000" stroke-width="0.7"/>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _pie()

# úloha 13: čtvercová síť 10x9, obdélník ABDF a trojúhelníky BCJ, EGH (schematicky, obsahy dle klíče)
def _grid13():
    ox, oy = 30, 18; c = 32; W = 10; H = 9
    def px(gx): return ox + gx * c
    def py(gy): return oy + (H - gy) * c
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+W*c} {oy*2+H*c+8}" font-family="sans-serif">']
    for i in range(W + 1):
        s.append(f'<line x1="{px(i)}" y1="{py(0)}" x2="{px(i)}" y2="{py(H)}" stroke="#ddd"/>')
    for j in range(H + 1):
        s.append(f'<line x1="{px(0)}" y1="{py(j)}" x2="{px(W)}" y2="{py(j)}" stroke="#ddd"/>')
    s.append(f'<polygon points="{px(0)},{py(0)} {px(10)},{py(0)} {px(10)},{py(9)} {px(0)},{py(9)}" fill="none" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="{px(10)},{py(0)} {px(10)},{py(6)} {px(7)},{py(3)}" fill="none" stroke="#000" stroke-width="1.6"/>')
    s.append(f'<polygon points="{px(3)},{py(9)} {px(0)},{py(7)} {px(2)},{py(2)}" fill="none" stroke="#000" stroke-width="1.6"/>')
    labels = [("A", 0, 0, -6, 14), ("B", 10, 0, 4, 14), ("D", 10, 9, 4, -3), ("F", 0, 9, -11, -3),
              ("C", 10, 6, 6, 4), ("J", 7, 3, 5, -3), ("E", 3, 9, -2, -3), ("G", 0, 7, -12, 4), ("H", 2, 2, -3, 15)]
    for name, gx, gy, ax, ay in labels:
        s.append(f'<text x="{px(gx)+ax}" y="{py(gy)+ay}" font-size="13" font-style="italic">{name}</text>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _grid13()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté); kód r5 v taxonomii není

PROBLEMS = [
    {'name': 'CERMAT M5B 2024 – úloha 1.1', 'zad': ['Vypočítejte: $25+3\\cdot(75-2\\cdot 25)-(25-5)\\cdot 2-25=$'],
     'opts': None, 'ln': 2,
     'sol': ['$75-2\\cdot 25=25$, $3\\cdot 25=75$, $(25-5)\\cdot 2=40$. Celkem $25+75-40-25=35$.'],
     'ans': '$35$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2024 – úloha 1.2', 'zad': ['Vypočítejte: $6\\cdot 7+(50+50:5):(28:7)+3\\cdot 8=$'],
     'opts': None, 'ln': 2,
     'sol': ['$50:5=10$, $50+10=60$, $28:7=4$, $60:4=15$. Dále $6\\cdot 7=42$, $3\\cdot 8=24$. Celkem $42+15+24=81$.'],
     'ans': '$81$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2024 – úloha 2', 'zad': [
        'Najděte a napište jednu číslici, kterou lze nahradit všechny hvězdičky tak, aby písemné odčítání bylo správné. Všechny hvězdičky nahradíte stejnou číslicí. Do záznamového archu uveďte pouze chybějící číslici.',
        '$\\ast\\,4\\,5\\,\\ast \\;-\\; 1\\,\\ast\\,\\ast\\,4 \\;=\\; 2\\,119$'],
     'opts': None, 'ln': 2,
     'sol': ['Hvězdičky nahradíme číslicí $3$: $3453-1334=2119$. Chybějící číslice je $3$.'],
     'ans': '$3$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2024 – úloha 3', 'zad': [
        'Provedeme-li postupně všechny početní operace uvedené nad šipkami, výsledné číslo bude 12 (viz obrázek).',
        'Vypočítejte neznámé číslo $x$ z prvního rámečku.'],
     'opts': None, 'ln': 2, 'svg': SVG3, 'fn': 'sipky.svg',
     'alt': 'Řetězec rámečků a šipek: x, potom +2, krát 3, minus 6, děleno 3, krát 6, výsledek 12.',
     'cap': 'Schéma postupných operací',
     'sol': ['Postupujeme od výsledku zpět: $12:6=2$, $2\\cdot 3=6$, $6+6=12$, $12:3=4$, $4-2=2$. Tedy $x=2$. Kontrola: $2+2=4$, $4\\cdot 3=12$, $12-6=6$, $6:3=2$, $2\\cdot 6=12$.'],
     'ans': '$x=2$', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2024 – úloha 4.1', 'zad': [
        'Ve škole, kde je celkem 750 žáků, koupila paní učitelka každému svému žákovi v 5. B stejné tričko. Pokud počet těchto triček vynásobíme 5, dostaneme stejné číslo, jako když počet všech žáků školy vydělíme 6.',
        'Kolik žáků je v 5. B?'],
     'opts': None, 'ln': 2,
     'sol': ['Počet triček je roven počtu žáků v 5. B. Platí $5\\cdot(\\text{počet žáků 5. B})=750:6=125$, tedy počet žáků $=125:5=25$.'],
     'ans': '$25$ žáků', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2024 – úloha 4.2', 'zad': [
        'Za 6 stejných židlí a dvě stejná křesla zaplatí rodina 23 200 Kč. Křeslo je o 400 Kč dražší než židle.',
        'Kolik stojí jedna židle?'],
     'opts': None, 'ln': 2,
     'sol': ['Židle stojí $z$, křeslo $z+400$. Platí $6z+2\\cdot(z+400)=23\\,200$, tj. $8z+800=23\\,200$, $8z=22\\,400$, $z=2\\,800$ Kč.'],
     'ans': '$2\\,800$ Kč', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M5B 2024 – úloha 4.3', 'zad': [
        'Do nákladního automobilu ráno naložili pracovníci přepravní firmy stejné balíky se zbožím. Prvnímu zákazníkovi pak z nákladního automobilu vydali jednu šestinu balíků. Druhému zákazníkovi vydali 30 balíků a na třetího zákazníka jim v nákladním automobilu zbyla druhá polovina nákladu.',
        'Kolik celkem balíků bylo ráno naloženo do nákladního automobilu?'],
     'opts': None, 'ln': 2,
     'sol': ['Celkem $c$ balíků. Prvnímu $\\frac{c}{6}$, třetímu (druhá polovina) $\\frac{c}{2}$, druhému $30$. Platí $\\frac{c}{6}+30+\\frac{c}{2}=c$, odtud $\\frac{c}{3}=30$, $c=90$ balíků. Rozvezeno bylo $15$, $30$ a $45$ balíků.'],
     'ans': '$90$ balíků', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2024 – úloha 5.1', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '$\\square$ sekund $-\\;\\frac{1}{4}$ hodiny $=25$ minut'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{1}{4}$ hodiny $=15$ minut. Hledaný počet sekund odpovídá $25+15=40$ minutám, tj. $40\\cdot 60=2\\,400$ sekund.'],
     'ans': '$2\\,400$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2024 – úloha 5.2', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '$\\square$ milimetrů $+\\;1$ metr $=\\frac{1}{5}$ metru $+\\;96$ centimetrů'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{1}{5}$ metru $=20$ cm, pravá strana je $20+96=116$ cm $=1\\,160$ mm. Protože $1$ metr $=1\\,000$ mm, doplníme $1\\,160-1\\,000=160$ milimetrů.'],
     'ans': '$160$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2024 – úloha 6', 'zad': [
        'Tyč je rozdělena na 10 stejných úseků. Na tyči jsou vyznačeny dvě značky. První je 39 cm od levého okraje tyče a druhá je označena písmenem A (viz obrázek).',
        '6.1 Jak dlouhá je tyč?',
        '6.2 V jaké vzdálenosti od pravého okraje tyče je značka A?'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'tyc.svg',
     'alt': 'Tyč rozdělená na 10 stejných dílků; první značka je u 3. dílku (39 cm), druhá značka A je u 6. dílku.',
     'cap': 'Tyč se dvěma značkami',
     'sol': ['První značka je u 3. dílku, tedy $3$ dílky $=39$ cm a jeden dílek $=13$ cm.',
             '6.1 Tyč má $10$ dílků: $10\\cdot 13=130$ cm.',
             '6.2 Značka A je u 6. dílku, od pravého okraje zbývají $4$ dílky: $4\\cdot 13=52$ cm.'],
     'ans': '6.1: $130$ cm; 6.2: $52$ cm', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2024 – úloha 7 (konstrukce)', 'zad': [
        'Jsou dány body $A$, $E$, $F$ (viz obrázek).',
        '7.1 Narýsujte úsečku $EF$. Sestrojte přímku $p$ procházející bodem $A$, která je kolmá na úsečku $EF$. Průsečík úsečky $EF$ a přímky $p$ označte písmenem $Y$.',
        '7.2 Na úsečce $EF$ vyznačte bod $B$, který má od bodu $A$ stejnou vzdálenost, jakou má bod $Y$ od bodu $E$.',
        '7.3 Sestrojte čtverec $ABCD$ tak, aby bod $Y$ neležel uvnitř čtverce $ABCD$.',
        '7.4 Do stejného obrázku narýsujte rovnoramenný trojúhelník $FGE$ tak, aby rameny trojúhelníku byly úsečky $EF$ a $EG$ a zároveň bod $G$ ležel na polopřímce $AY$.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'body-AEF.svg',
     'alt': 'Tři body A, E, F v rovině: E nahoře uprostřed, A vlevo dole, F vpravo od bodu A.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['7.1 Bod $Y$ je pata kolmice $p$ vedené z bodu $A$ na úsečku $EF$.',
             '7.2 Na úsečce $EF$ vyznačíme bod $B$ tak, že $|AB|=|EY|$.',
             '7.3 Nad stranou $AB$ sestrojíme čtverec $ABCD$ na tu polorovinu, aby bod $Y$ neležel uvnitř čtverce.',
             '7.4 Na polopřímce $AY$ najdeme bod $G$ tak, že $|EG|=|EF|$; trojúhelník $FGE$ je rovnoramenný s rameny $EF$ a $EG$.'],
     'ans': 'Konstrukce (viz náčrt v klíči): $Y$ = pata kolmice $p$ z $A$ na $EF$; $B$ na $EF$ s $|AB|=|EY|$; čtverec $ABCD$ tak, aby $Y$ nebyl uvnitř; bod $G$ na polopřímce $AY$ s $|EG|=|EF|$ a rovnoramenný trojúhelník $FGE$.',
     'pts': 6, 'mins': 12, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2024 – úloha 8', 'zad': [
        'Graf znázorňuje, kolik hodin denně se Petr věnuje třem vybraným aktivitám – sportu, počítači a učení (viz obrázek).',
        'Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
        '8.1 Petr tráví týdně na počítači o polovinu více času, než kolik času týdně věnuje sportu.',
        '8.2 Petr týdně věnuje více času učení než sportu.',
        '8.3 Aby Petr týdně trávil učením stejnou dobu jako na počítači, musel by se týdně učit o pět hodin déle.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'graf-aktivity.svg',
     'alt': 'Skupinový sloupcový graf hodin denně (sport, počítač, učení) pro pondělí až neděli.',
     'cap': 'Schematický nákres grafu (týdenní součty: sport 10 h, počítač 15 h, učení 10 h)',
     'sol': ['Týdenní součty: sport $10$ h, počítač $15$ h, učení $10$ h.',
             '8.1 $15=10+\\frac{10}{2}$, tj. o polovinu více → Ano (A).',
             '8.2 Učení $10$ h není více než sport $10$ h → Ne (N).',
             '8.3 $15-10=5$, učení by muselo být o $5$ h delší → Ano (A).'],
     'ans': '8.1: Ano (A); 8.2: Ne (N); 8.3: Ano (A)', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2024 – úloha 9', 'zad': [
        'Lukáš a Pepa trhají jablka, která dávají do stejných beden. Každý z hochů pracuje stálým tempem. Za každou hodinu Pepa naplní jablky 5 beden a Lukáš 3 bedny.',
        'Za jak dlouho oba chlapci společně naplní jablky 64 beden?'],
     'opts': ['A) za 240 minut', 'B) za 360 minut', 'C) za 480 minut', 'D) za 840 minut', 'E) jiný výsledek'],
     'ln': 0,
     'sol': ['Společně naplní za hodinu $5+3=8$ beden. $64:8=8$ hodin $=480$ minut → C.'],
     'ans': 'C) za 480 minut', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2024 – úloha 10', 'zad': [
        'Dřevěná krychle byla natřena modrou barvou ze všech šesti stran. Poté byla rozřezána na 64 stejných krychliček (řezy jsou naznačeny na obrázku).',
        'Kolik celkem takto vzniklých krychliček nemá žádnou stranu modrou?'],
     'opts': ['A) více než 8', 'B) 8', 'C) 4', 'D) 0', 'E) jiný počet'],
     'ln': 0, 'svg': SVG10, 'fn': 'krychle.svg',
     'alt': 'Krychle rozdělená řezy na 4 krát 4 krát 4 malých krychliček (schematický nákres).',
     'cap': 'Schematický nákres krychle 4 krát 4 krát 4',
     'sol': ['$64=4\\cdot 4\\cdot 4$. Krychličky bez modré strany tvoří vnitřní krychli o hraně $2$: $2\\cdot 2\\cdot 2=8$ krychliček → B.'],
     'ans': 'B) 8', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2024 – úloha 11', 'zad': [
        'Kruhový diagram, který je rozdělen na 10 shodných částí, znázorňuje výsledky písemné práce z matematiky, kterou psali všichni žáci z devátého ročníku. Známky 1, 3 a 4 mělo celkem 56 žáků (viz obrázek).',
        'Kolik žáků celkem je v devátém ročníku?'],
     'opts': ['A) 140', 'B) 112', 'C) 93', 'D) 80', 'E) jiný počet'],
     'ln': 0, 'svg': SVG11, 'fn': 'kruhovy-diagram.svg',
     'alt': 'Kruhový diagram rozdělený na 10 shodných dílků: známka 1 (1 dílek), 2 (2 dílky), 3 (4 dílky), 4 (2 dílky), 5 (1 dílek).',
     'cap': 'Výsledky písemné práce (10 shodných dílků)',
     'sol': ['Diagram má $10$ shodných dílků. Známky $1$, $3$ a $4$ zabírají $1+4+2=7$ dílků a odpovídají $56$ žákům, tj. jeden dílek $=56:7=8$ žáků. Celkem $10\\cdot 8=80$ žáků → D.'],
     'ans': 'D) 80', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2024 – úloha 12', 'zad': [
        'Čerpadlo, které trvale čerpá vodu stejnou rychlostí, naplní vodou 3 stejné prázdné nádrže za 2 hodiny.',
        '12.1 Za jak dlouho jediné takové čerpadlo naplní 12 takových prázdných nádrží?',
        '12.2 Jak dlouho by se 12 takových prázdných nádrží plnilo vodou, pokud by se po naplnění šesti prázdných nádrží přidalo k prvnímu čerpadlu ještě druhé úplně stejné čerpadlo?',
        '12.3 Jak dlouho by se 15 takových prázdných nádrží plnilo vodou dvěma takovými úplně stejnými čerpadly?'],
     'opts': ['12.1: A) za 4 hodiny; B) za 6 hodin; C) za 8 hodin; D) za 10 hodin; E) za 12 hodin',
              '12.2: A) 1 hodinu; B) 2 hodiny; C) 4 hodiny; D) 6 hodin; E) 8 hodin',
              '12.3: A) 1 hodinu; B) 2 hodiny; C) 3 hodiny; D) 4 hodiny; E) 5 hodin'],
     'ln': 0,
     'sol': ['Jedno čerpadlo naplní $3$ nádrže za $2$ h, tj. $1{,}5$ nádrže za hodinu.',
             '12.1 $12:1{,}5=8$ hodin → C.',
             '12.2 Prvních $6$ nádrží jedno čerpadlo za $6:1{,}5=4$ h, dalších $6$ nádrží dvě čerpadla ($3$ nádrže/h) za $2$ h; celkem $6$ hodin → D.',
             '12.3 Dvě čerpadla naplní $3$ nádrže za hodinu, $15:3=5$ hodin → E.'],
     'ans': '12.1: C) za 8 hodin; 12.2: D) 6 hodin; 12.3: E) 5 hodin', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2024 – úloha 13', 'zad': [
        'Ve čtvercové síti je nakreslen obdélník $ABDF$, v němž jsou zakresleny trojúhelníky $BCJ$ a $EGH$. Vrcholy všech útvarů leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky 1 cm a obsah 1 cm² (viz obrázek).',
        'Ke každé podúloze (13.1–13.3) přiřaďte správný výsledek (A–F).',
        '13.1 Jaký je obsah trojúhelníku $BCJ$ v cm²?',
        '13.2 Jaký je obsah trojúhelníku $EGH$ v cm²?',
        '13.3 Jakým číslem musíme vynásobit obsah trojúhelníku $BCJ$, abychom dostali obsah obdélníku $ABDF$?'],
     'opts': ['A) 6', 'B) 7', 'C) 8,5', 'D) 9', 'E) 9,5', 'F) 10'],
     'ln': 0, 'svg': SVG13, 'fn': 'sit-obdelnik.svg',
     'alt': 'Čtvercová síť s obdélníkem ABDF a dvěma trojúhelníky BCJ a EGH; vrcholy v mřížových bodech.',
     'cap': 'Schematický nákres (obsahy dle klíče)',
     'sol': ['Obsahy počítáme v mřížce ($1$ čtvereček $=1$ cm²).',
             '13.1 Trojúhelník $BCJ$ má obsah $9$ cm² → D.',
             '13.2 Trojúhelník $EGH$ má obsah $9{,}5$ cm² → E.',
             '13.3 Obdélník $ABDF$ má obsah $90$ cm²; $90:9=10$ → F.'],
     'ans': '13.1: D) 9; 13.2: E) 9,5; 13.3: F) 10', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2024 – úloha 14', 'zad': [
        'V pohádkovém království žil král. Když král slavil své 20. narozeniny, narodili se víla a skřítek. Víla i skřítek stárli pomaleji než král. Král stárnul 6krát rychleji než víla a 8krát rychleji než skřítek. Své první narozeniny tak víla oslavila v den, kdy od jejího narození král zestárl přesně o 6 let. Skřítek pak slavil své první narozeniny až o dva roky později. Uvažujte, že den oslavy narozenin vždy odpovídá příslušnému dni narození.',
        '14.1 O kolik let zestárl král v období mezi oslavou 3. narozenin víly a 4. narozenin skřítka?',
        '14.2 Kolikrát od svého narození oslavil skřítek své narozeniny do doby, než víla oslavila své desáté narozeniny?',
        '14.3 Jednou za určité období oslavila víla i skřítek narozeniny v jeden den. Král předal království svému synovi právě v den, kdy víla a skřítek slavili v jeden den narozeniny už potřetí. Kolik let bylo v tento den králi?'],
     'opts': None, 'ln': 3,
     'sol': ['Král stárne $6\\times$ rychleji než víla a $8\\times$ rychleji než skřítek; oba se narodili, když bylo králi $20$ let. Uplyne-li v králově čase $t$ let, má víla $\\frac{t}{6}$ a skřítek $\\frac{t}{8}$ let.',
             '14.1 3. narozeniny víly: $t=18$; 4. narozeniny skřítka: $t=32$; král zestárl o $32-18=14$ let.',
             '14.2 10. narozeniny víly: $t=60$; skřítek má $60:8=7{,}5$ roku, oslavil tedy narozeniny $7$krát.',
             '14.3 Společné narozeniny nastanou při $t=24,48,72,\\dots$ (násobky $24$); potřetí při $t=72$, králi je $20+72=92$ let.'],
     'ans': '14.1: o 14 let; 14.2: 7krát; 14.3: 92 let', 'pts': 6, 'mins': 10, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PBD24C0T02'
    gen.YEAR = 2024

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5B-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
