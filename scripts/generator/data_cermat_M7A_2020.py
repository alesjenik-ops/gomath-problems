# -*- coding: utf-8 -*-
# CERMAT – Přijímací zkoušky 2020, MATEMATIKA 7 (šestileté obory, 7. ročník), varianta A, řádný termín.
# Kód testu: M7PAD20C0T01. 16 úloh v testu; po rozdělení nezávislých podúloh 19 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR); struktura ověřena záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 7: kolmý čtyřboký hranol s kosočtvercovou podstavou, výška 10 cm (schematicky)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 300" font-family="sans-serif">
<polygon points="120,55 190,30 260,55 190,80" fill="#eeeeee" stroke="#000" stroke-width="2"/>
<line x1="120" y1="55" x2="120" y2="245" stroke="#000" stroke-width="2"/>
<line x1="260" y1="55" x2="260" y2="245" stroke="#000" stroke-width="2"/>
<line x1="190" y1="80" x2="190" y2="270" stroke="#000" stroke-width="2"/>
<line x1="190" y1="30" x2="190" y2="220" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<polyline points="120,245 190,270 260,245" fill="none" stroke="#000" stroke-width="2"/>
<polyline points="120,245 190,220 260,245" fill="none" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="92" y1="55" x2="92" y2="245" stroke="#000" stroke-width="1"/>
<polygon points="92,55 88,66 96,66" fill="#000"/>
<polygon points="92,245 88,234 96,234" fill="#000"/>
<text x="52" y="155" font-size="15">10 cm</text>
</svg>"""

# úloha 8: výchozí obrázek – polopřímka XY a bod A
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="60" y1="252" x2="420" y2="108" stroke="#000" stroke-width="2"/>
<polygon points="420,108 402,110 410,124" fill="#000"/>
<line x1="60" y1="252" x2="66" y2="240" stroke="#000" stroke-width="2"/>
<text x="48" y="270" font-size="16" font-style="italic">X</text>
<line x1="238" y1="180" x2="246" y2="167" stroke="#000" stroke-width="2"/>
<text x="250" y="182" font-size="16" font-style="italic">Y</text>
<text x="226" y="246" font-size="16">×</text>
<text x="228" y="266" font-size="16" font-style="italic">A</text>
</svg>"""

# úloha 9: výchozí obrázek – přímka p a polopřímka AX
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="40" y1="150" x2="430" y2="238" stroke="#000" stroke-width="2"/>
<text x="436" y="246" font-size="16" font-style="italic">p</text>
<line x1="150" y1="292" x2="300" y2="66" stroke="#000" stroke-width="2"/>
<polygon points="300,66 292,80 305,78" fill="#000"/>
<text x="144" y="308" font-size="16" font-style="italic">A</text>
<text x="306" y="70" font-size="16" font-style="italic">X</text>
<line x1="234" y1="180" x2="244" y2="185" stroke="#000" stroke-width="2"/>
</svg>"""

# úloha 10: čtvercová síť 12x6, obrazce A (obsah 6) a B (obsah 7); vrcholy z originálu
def _grid10():
    cell = 30; ox, oy = 26, 20; W, H = 12, 6
    def px(c, r): return ox + c * cell, oy + r * cell
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+W*cell} {oy*2+H*cell+16}" font-family="sans-serif">']
    for i in range(W + 1):
        x = ox + i * cell
        s.append(f'<line x1="{x}" y1="{oy}" x2="{x}" y2="{oy+H*cell}" stroke="#bbb" stroke-width="1"/>')
    for j in range(H + 1):
        y = oy + j * cell
        s.append(f'<line x1="{ox}" y1="{y}" x2="{ox+W*cell}" y2="{y}" stroke="#bbb" stroke-width="1"/>')
    A = [(1, 1), (4, 1), (4, 4), (2, 5), (3, 3)]
    B = [(10, 1), (11, 2), (11, 3), (8, 3), (8, 4), (7, 4), (6, 3)]
    ap = " ".join(f'{px(c,r)[0]},{px(c,r)[1]}' for c, r in A)
    bp = " ".join(f'{px(c,r)[0]},{px(c,r)[1]}' for c, r in B)
    s.append(f'<polygon points="{ap}" fill="#9a9a9a" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="{bp}" fill="#9a9a9a" stroke="#000" stroke-width="2"/>')
    s.append(f'<text x="{ox+3*cell-4}" y="{oy+2*cell+18}" font-size="16" font-weight="bold">A</text>')
    s.append(f'<text x="{ox+9*cell-4}" y="{oy+2*cell+18}" font-size="16" font-weight="bold">B</text>')
    s.append(f'<text x="{ox}" y="{oy+H*cell+14}" font-size="12">strana čtverečku 1 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _grid10()

# úloha 11: dvě rovnoběžky proťaté dvěma příčkami; úhly 118°, 142°, α (schematicky)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 330" font-family="sans-serif">
<line x1="40" y1="110" x2="490" y2="110" stroke="#000" stroke-width="2"/>
<line x1="40" y1="270" x2="490" y2="270" stroke="#000" stroke-width="2"/>
<line x1="445" y1="102" x2="453" y2="118" stroke="#000" stroke-width="2"/>
<line x1="455" y1="102" x2="463" y2="118" stroke="#000" stroke-width="2"/>
<line x1="445" y1="262" x2="453" y2="278" stroke="#000" stroke-width="2"/>
<line x1="455" y1="262" x2="463" y2="278" stroke="#000" stroke-width="2"/>
<line x1="240" y1="30" x2="132" y2="318" stroke="#000" stroke-width="2"/>
<line x1="410" y1="36" x2="250" y2="300" stroke="#000" stroke-width="2"/>
<text x="150" y="98" font-size="17">118°</text>
<text x="92" y="258" font-size="17">142°</text>
<text x="372" y="134" font-size="18">α</text>
</svg>"""

# úlohy 12–13: skládaný/skupinový sloupcový graf (7. A, 7. B), body 0–3, jeden údaj chybí (?)
def _graf():
    cats = [('0 bodů', 3, 5), ('1 bod', 10, 4), ('2 body', 8, 9), ('3 body', 4, None)]
    x0, y0 = 60, 250; unit = 16; bw = 26; grp = 92
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 320" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="470" y2="{y0}" stroke="#000"/>')
    for v in range(0, 13, 2):
        y = y0 - v * unit
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-9}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    s.append(f'<text x="26" y="150" font-size="12" text-anchor="middle" transform="rotate(-90 26 150)">Počet žáků</text>')
    x = x0 + 26
    for name, a, b in cats:
        s.append(f'<rect x="{x}" y="{y0-a*unit}" width="{bw}" height="{a*unit}" fill="#666" stroke="#000"/>')
        if b is not None:
            s.append(f'<rect x="{x+bw}" y="{y0-b*unit}" width="{bw}" height="{b*unit}" fill="#cfcfcf" stroke="#000"/>')
        else:
            s.append(f'<rect x="{x+bw}" y="{y0-6*unit}" width="{bw}" height="{6*unit}" fill="none" stroke="#888" stroke-dasharray="4 4"/>')
            s.append(f'<text x="{x+bw+bw/2}" y="{y0-6*unit-6}" font-size="16" text-anchor="middle">?</text>')
        s.append(f'<text x="{x+bw}" y="{y0+16}" font-size="11" text-anchor="middle">{name}</text>')
        x += grp
    s.append('<rect x="392" y="60" width="13" height="13" fill="#666" stroke="#000"/><text x="410" y="71" font-size="12">7. A</text>')
    s.append('<rect x="392" y="80" width="13" height="13" fill="#cfcfcf" stroke="#000"/><text x="410" y="91" font-size="12">7. B</text>')
    s.append('</svg>')
    return "".join(s)
SVG_GRAF = _graf()

# úloha 16: obrazce ze sirek – 1., 2., 3. obrazec (schematicky), úhlopříčka v každém druhém čtverci
def _sirky():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 170" font-family="sans-serif">']
    sc = 26
    def fig(x0, y0, n, label):
        out = [f'<text x="{x0 + n*sc/2}" y="{y0-8}" font-size="12" text-anchor="middle">{label}</text>']
        out.append(f'<polygon points="{x0},{y0} {x0-sc*0.7:.0f},{y0+sc/2:.0f} {x0},{y0+sc}" fill="none" stroke="#000" stroke-width="1.5"/>')
        for k in range(n):
            xk = x0 + k * sc
            out.append(f'<rect x="{xk}" y="{y0}" width="{sc}" height="{sc}" fill="none" stroke="#000" stroke-width="1.5"/>')
            if (k + 1) % 2 == 0:
                out.append(f'<line x1="{xk}" y1="{y0}" x2="{xk+sc}" y2="{y0+sc}" stroke="#000" stroke-width="1.5"/>')
        xr = x0 + n * sc
        out.append(f'<polygon points="{xr},{y0} {xr+sc*0.7:.0f},{y0+sc/2:.0f} {xr},{y0+sc}" fill="none" stroke="#000" stroke-width="1.5"/>')
        return "".join(out)
    s.append(fig(70, 40, 1, '1. obrazec'))
    s.append(fig(230, 40, 2, '2. obrazec'))
    s.append(fig(400, 40, 3, '3. obrazec'))
    s.append('<text x="70" y="150" font-size="11" fill="#555">Uvnitř každého druhého čtverce je jedna sirka.</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _sirky()

# ---- Úlohy ----

B = ['zs2', 'r7']   # základní vzdělávání, 7. ročník (šestileté obory)
NP = 'CERMAT M7A 2020 – úloha '

PROBLEMS = [
    {'name': NP + '1', 'zad': ['Pětina neznámého čísla je $5$.', 'Vypočtěte pětinásobek neznámého čísla.'],
     'opts': None, 'ln': 2,
     'sol': ['Neznámé číslo $x$: $x:5=5\\Rightarrow x=25$. Pětinásobek: $5\\cdot 25=125$.'],
     'ans': '$125$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': NP + '2.1', 'zad': ['Vypočtěte:', '$5\\cdot(-3\\cdot 2)-21:(1-0{,}7)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$5\\cdot(-6)-21:0{,}3=-30-70=-100$.'],
     'ans': '$-100$', 'pts': 2, 'mins': 2, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': NP + '2.2', 'zad': ['Vypočtěte:', '$\\frac{1}{0{,}01}:10-0{,}2\\cdot 50=$'],
     'opts': None, 'ln': 2,
     'sol': ['$100:10-10=10-10=0$.'],
     'ans': '$0$', 'pts': 1, 'mins': 2, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': NP + '3.1', 'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
        '$\\left(\\frac{5}{6}-\\frac{3}{8}\\right)-\\left(2-\\frac{11}{12}\\right)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{5}{6}-\\frac{3}{8}=\\frac{20-9}{24}=\\frac{11}{24}$; $\\;2-\\frac{11}{12}=\\frac{13}{12}=\\frac{26}{24}$. Rozdíl $\\frac{11}{24}-\\frac{26}{24}=-\\frac{15}{24}=-\\frac{5}{8}$.'],
     'ans': '$-\\frac{5}{8}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': NP + '3.2', 'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
        '$\\frac{2\\cdot\\frac{5}{6}-\\frac{1}{3}}{10}=$'],
     'opts': None, 'ln': 2,
     'sol': ['Čitatel: $2\\cdot\\frac{5}{6}-\\frac{1}{3}=\\frac{5}{3}-\\frac{1}{3}=\\frac{4}{3}$. Celý zlomek: $\\frac{4}{3}:10=\\frac{4}{30}=\\frac{2}{15}$.'],
     'ans': '$\\frac{2}{15}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': NP + '4.1', 'zad': ['Sjezdovka je o polovinu delší než lanovka. Jejich délky se liší o čtvrt kilometru.',
        'Vypočtěte v metrech délku sjezdovky.'],
     'opts': None, 'ln': 2,
     'sol': ['Délka lanovky $l$, sjezdovka $1{,}5\\,l$. Rozdíl $0{,}5\\,l=250$ m $\\Rightarrow l=500$ m. Sjezdovka $1{,}5\\cdot 500=750$ m.'],
     'ans': '$750$ m', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': NP + '4.2', 'zad': ['Objem sudu je $1{,}1$ m³, objem kbelíku je $5\\,700$ cm³.',
        'Ze sudu zcela naplněného vodou jsme odebrali $10$ plných kbelíků vody.',
        'Vypočtěte, kolik litrů vody zbylo v sudu.'],
     'opts': None, 'ln': 2,
     'sol': ['Sud $1{,}1$ m³ $=1\\,100$ litrů. Kbelík $5\\,700$ cm³ $=5{,}7$ litru, $10$ kbelíků $=57$ litrů. Zbylo $1\\,100-57=1\\,043$ litrů.'],
     'ans': '$1\\,043$ litrů', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': NP + '5', 'zad': [
        'Každý ze tří spolužáků měl zapsat co nejvíce hlavních měst evropských států. Adam zapsal $12$ hlavních měst, stejně jako Bětka, ale Eliška jich zapsala jen $6$. Mezi všemi zapsanými hlavními městy byla $2$ města zapsána třikrát, $7$ měst dvakrát a ostatní jen jedenkrát.',
        'Vypočtěte,',
        '5.1 kolik hlavních měst bylo zapsáno jen jedenkrát,',
        '5.2 kolik různých hlavních měst bylo celkem zapsáno.'],
     'opts': None, 'ln': 2,
     'sol': ['Celkem bylo zapsáno $12+12+6=30$ měst (včetně opakování).',
             '5.1 Vícekrát zapsaná: $2$ města třikrát ($6$ zápisů) a $7$ měst dvakrát ($14$ zápisů), celkem $20$ zápisů. Jen jedenkrát: $30-20=10$ měst.',
             '5.2 Různých měst je $2+7+10=19$.'],
     'ans': '5.1: $10$ hlavních měst; 5.2: $19$ různých hlavních měst', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': NP + '6', 'zad': [
        'Děti koupily mamince k narozeninám růže, bonboniéru, ozdobnou záložku a knihu, vše celkem za $340$ korun. Růže s bonboniérou stály celkem $210$ korun. Růže byly o třetinu dražší než bonboniéra. Samotná kniha byla o $100$ korun dražší než ozdobná záložka.',
        'Vypočtěte,',
        '6.1 kolik korun zaplatily děti za růže,',
        '6.2 kolik korun stála ozdobná záložka.'],
     'opts': None, 'ln': 3,
     'sol': ['6.1 Bonboniéra $b$, růže $\\frac{4}{3}b$. Součet $\\frac{4}{3}b+b=\\frac{7}{3}b=210\\Rightarrow b=90$ korun; růže $210-90=120$ korun.',
             '6.2 Kniha se záložkou stály $340-210=130$ korun. Záložka $z$, kniha $z+100$: $2z+100=130\\Rightarrow z=15$ korun.'],
     'ans': '6.1: $120$ korun; 6.2: $15$ korun', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': NP + '7', 'zad': [
        'Podstavou kolmého čtyřbokého hranolu je kosočtverec. Výška hranolu je $10$ cm a povrch hranolu je $360$ cm². Obsah pláště hranolu je sedmkrát větší než obsah jedné podstavy.',
        'Vypočtěte',
        '7.1 v cm² obsah pláště hranolu,',
        '7.2 v cm součet délek všech $12$ hran hranolu.'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'hranol.svg',
     'alt': 'Schematický nákres kolmého čtyřbokého hranolu s kosočtvercovou podstavou a vyznačenou výškou 10 cm.',
     'cap': 'Kolmý hranol s kosočtvercovou podstavou (výška 10 cm)',
     'sol': ['7.1 Povrch $S=2S_p+S_{pl}$ a $S_{pl}=7S_p$, tedy $9S_p=360\\Rightarrow S_p=40$ cm²; plášť $S_{pl}=7\\cdot 40=280$ cm².',
             '7.2 Plášť $=o\\cdot v$, kde $o$ je obvod podstavy: $o\\cdot 10=280\\Rightarrow o=28$ cm. Kosočtverec má $4$ shodné strany, tedy $a=7$ cm. Součet hran $=8\\cdot 7+4\\cdot 10=56+40=96$ cm.'],
     'ans': '7.1: $280$ cm²; 7.2: $96$ cm', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': NP + '8', 'zad': [
        'V rovině leží polopřímka $XY$ a bod $A$ (viz obrázek).',
        'Bod $A$ je vrchol obdélníku $ABCD$. Jiné dva vrcholy tohoto obdélníku leží na polopřímce $XY$ a délka strany $AB$ je $7$ cm.',
        'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'poloprimka-xy-a.svg',
     'alt': 'Polopřímka XY směřující z bodu X vzhůru vpravo přes bod Y a bod A vyznačený křížkem pod ní.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['Bod $B$ leží na polopřímce $XY$ ve vzdálenosti $|AB|=7$ cm od bodu $A$ — sestrojíme jej jako průsečík kružnice $k(A;7$ cm$)$ s polopřímkou $XY$ (dva průsečíky $B_1$, $B_2$). Vrchol $D$ je průsečík polopřímky $XY$ s kolmicí k $AB$ vedenou bodem $A$; čtvrtý vrchol dopočteme jako $C=B+D-A$. Úloha má dvě řešení: obdélníky $AB_1C_1D_1$ a $AB_2C_2D_2$.'],
     'ans': 'Dvě řešení. Bod $B$ je průsečík kružnice $k(A;7$ cm$)$ s polopřímkou $XY$, vrcholy $C$, $D$ dopočteme kolmostí (obdélníky $AB_1C_1D_1$ a $AB_2C_2D_2$) — viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': NP + '9', 'zad': [
        'V rovině leží přímka $p$ a polopřímka $AX$ (viz obrázek).',
        'Bod $A$ je vrchol rovnostranného trojúhelníku $ABC$. Jeden ze zbývajících vrcholů $B$, $C$ leží na polopřímce $AX$ a druhý na přímce $p$. Polopřímka $AX$ tvoří jedno rameno vnitřního úhlu $\\alpha$ trojúhelníku $ABC$.',
        '9.1 Sestrojte druhé rameno úhlu $\\alpha$ rovnostranného trojúhelníku $ABC$.',
        '9.2 Sestrojte trojúhelník $ABC$ a jeho vrcholy označte písmeny. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-p-poloprimka-ax.svg',
     'alt': 'Přímka p a polopřímka AX vycházející z bodu A; obě se protínají.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Vnitřní úhel rovnostranného trojúhelníku má $60^\\circ$. Druhé rameno úhlu $\\alpha$ sestrojíme otočením polopřímky $AX$ kolem bodu $A$ o $60^\\circ$ (na obě strany, tedy dvě polohy). Vrchol na přímce $p$ získáme jako průsečík příslušného ramene s přímkou $p$; druhý vrchol leží na polopřímce $AX$ ve stejné vzdálenosti od $A$ (kružnice se středem $A$). Úloha má dvě řešení: trojúhelníky $AB_1C_1$ a $AB_2C_2$.'],
     'ans': 'Dvě řešení. Druhé rameno úhlu $\\alpha=60^\\circ$ vznikne otočením polopřímky $AX$ kolem $A$ o $60^\\circ$; vrcholy $B$, $C$ leží na polopřímce $AX$ a na přímce $p$ (trojúhelníky $AB_1C_1$ a $AB_2C_2$) — viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': NP + '10', 'zad': [
        'Ve čtvercové síti jsou zakresleny dva tmavé obrazce $A$, $B$. Vrcholy obou obrazců leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky $1$ cm.',
        'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).',
        '10.1 Obsah obrazce $A$ je $7$ cm².',
        '10.2 Obsah obrazce $B$ je o $1$ cm² větší než obsah obrazce $A$.',
        '10.3 Obvod obrazce $B$ je stejný jako obvod obrazce $A$.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'ctvercova-sit-ab.svg',
     'alt': 'Čtvercová síť se dvěma tmavými mnohoúhelníky A a B; vrcholy leží v mřížových bodech, strana čtverečku je 1 cm.',
     'cap': 'Dva obrazce ve čtvercové síti (čtvereček 1 cm)',
     'sol': ['Obsahy určíme rozdělením na trojúhelníky (nebo Pickovou větou): obrazec $A$ má obsah $6$ cm², obrazec $B$ má obsah $7$ cm².',
             '10.1 Obsah $A$ je $6$ cm², nikoli $7$ cm² → N.',
             '10.2 $7-6=1$ cm², obrazec $B$ je o $1$ cm² větší → A.',
             '10.3 Oba obvody jsou $6+2\\sqrt{2}+2\\sqrt{5}$ cm (přibližně $13{,}3$ cm), tedy stejné → A.'],
     'ans': '10.1: N; 10.2: A; 10.3: A', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': NP + '11', 'zad': [
        'Na obrázku jsou dvě rovnoběžky (označené shodnými značkami) proťaté dvěma příčkami. Jsou vyznačeny úhly $118^\\circ$ a $142^\\circ$ a hledaný úhel $\\alpha$.',
        'Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) menší než $80^\\circ$', 'B) $80^\\circ$', 'C) $90^\\circ$', 'D) $100^\\circ$', 'E) větší než $100^\\circ$'],
     'ln': 0, 'svg': SVG11, 'fn': 'uhly-rovnobezky.svg',
     'alt': 'Dvě rovnoběžky proťaté dvěma příčkami; vyznačené úhly 118° a 142° a hledaný úhel alfa.',
     'cap': 'Výchozí obrázek k úloze 11',
     'sol': ['Doplňkové úhly k vyznačeným jsou $180^\\circ-118^\\circ=62^\\circ$ a $180^\\circ-142^\\circ=38^\\circ$. Díky rovnoběžkám jsou to vnitřní úhly trojúhelníku, jehož třetí vrchol leží v průsečíku obou příček. Třetí úhel má velikost $180^\\circ-62^\\circ-38^\\circ=80^\\circ$ a úhel $\\alpha$ je s ním shodný (souhlasný přes rovnoběžky). Proto $\\alpha=80^\\circ$.'],
     'ans': 'B) $80^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': NP + '12', 'zad': [
        'Všichni žáci tříd 7. A a 7. B se zúčastnili soutěže, v níž mohl každý získat $0$ až $3$ body. V grafu jsou počty žáků, kteří získali daný počet bodů; jeden údaj (počet žáků 7. B se $3$ body) chybí.',
        'Kolik procent žáků 7. A získalo v soutěži méně než $2$ body?'],
     'opts': ['A) $13\\,\\%$', 'B) $21\\,\\%$', 'C) $32\\,\\%$', 'D) $52\\,\\%$', 'E) jiný počet procent'],
     'ln': 0, 'svg': SVG_GRAF, 'fn': 'graf-body-12.svg',
     'alt': 'Skupinový sloupcový graf počtu žáků tříd 7. A a 7. B podle získaných bodů (0 až 3); údaj pro 7. B se 3 body chybí.',
     'cap': 'Počty žáků podle získaných bodů',
     'sol': ['Třída 7. A: $0$ bodů $3$ žáci, $1$ bod $10$, $2$ body $8$, $3$ body $4$; celkem $25$ žáků. Méně než $2$ body (tj. $0$ nebo $1$ bod) má $3+10=13$ žáků. Podíl $\\frac{13}{25}=0{,}52=52\\,\\%$.'],
     'ans': 'D) $52\\,\\%$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': NP + '13', 'zad': [
        'Všichni žáci tříd 7. A a 7. B se zúčastnili soutěže, v níž mohl každý získat $0$ až $3$ body. V grafu jsou počty žáků, kteří získali daný počet bodů; počet žáků 7. B se $3$ body chybí.',
        'Žáci 7. A získali v soutěži celkem o $2$ body méně než žáci 7. B. Kolik žáků chodí do třídy 7. B?'],
     'opts': ['A) méně než $24$ žáků', 'B) $24$ žáků', 'C) $25$ žáků', 'D) $26$ žáků', 'E) více než $26$ žáků'],
     'ln': 0, 'svg': SVG_GRAF, 'fn': 'graf-body-13.svg',
     'alt': 'Skupinový sloupcový graf počtu žáků tříd 7. A a 7. B podle získaných bodů (0 až 3); údaj pro 7. B se 3 body chybí.',
     'cap': 'Počty žáků podle získaných bodů',
     'sol': ['Body 7. A: $1\\cdot 10+2\\cdot 8+3\\cdot 4=10+16+12=38$. Body 7. B jsou o $2$ více, tedy $40$. Známé body 7. B: $1\\cdot 4+2\\cdot 9=22$; pro žáky se $3$ body platí $3x=40-22=18\\Rightarrow x=6$. Počet žáků 7. B: $5+4+9+6=24$.'],
     'ans': 'B) $24$ žáků', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': NP + '14', 'zad': [
        'Adéla a Hana dostaly stejnou knihu. Hana přečetla z knihy denně $10$ stran. Adéla přečetla celou knihu za $8$ dní a každý den z ní přečetla o polovinu více stran než Hana.',
        'Za kolik dní přečetla celou knihu Hana?'],
     'opts': ['A) za méně než $10$ dní', 'B) za $10$ dní', 'C) za $12$ dní', 'D) za $15$ dní', 'E) za více než $15$ dní'],
     'ln': 0,
     'sol': ['Adéla čte denně $10+5=15$ stran, za $8$ dní přečte $15\\cdot 8=120$ stran — to je celá kniha. Hana čte $10$ stran denně, potřebuje $120:10=12$ dní.'],
     'ans': 'C) za $12$ dní', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': NP + '15', 'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Farmář z loňské úrody obilí $20\\,\\%$ uskladnil a zbývajících $200$ tun prodal. Kolik tun činila loňská úroda obilí?',
        '15.2 Farmář letos koupil $300$ tun krmiva, což je o $25\\,\\%$ více, než koupil loni. Kolik tun krmiva koupil loni?',
        '15.3 Farmář z loňské úrody kukuřice prodal $10\\,\\%$ velkoodběrateli a třetinu zbytku maloodběratelům. Zbývajících $270$ tun kukuřice uskladnil. Kolik tun z loňské úrody kukuřice prodal?'],
     'opts': ['A) $180$ tun', 'B) $200$ tun', 'C) $210$ tun', 'D) $240$ tun', 'E) $250$ tun', 'F) jiný počet tun'],
     'ln': 0,
     'sol': ['15.1 Prodaných $200$ tun je $80\\,\\%$ úrody: $200:0{,}8=250$ tun → E.',
             '15.2 $300$ tun je $125\\,\\%$ loňského množství: $300:1{,}25=240$ tun → D.',
             '15.3 Velkoodběrateli $10\\,\\%$, ze zbytku ($90\\,\\%$) třetina, tj. $30\\,\\%$, maloodběratelům. Uskladněno $270$ tun $=60\\,\\%$ úrody, tedy úroda $450$ tun. Prodáno $10\\,\\%+30\\,\\%=40\\,\\%$ ze $450=180$ tun → A.'],
     'ans': '15.1: E ($250$ tun); 15.2: D ($240$ tun); 15.3: A ($180$ tun)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': NP + '16', 'zad': [
        'Všechny obrazce sestavené ze sirek splňují pravidla: každý obrazec začíná a končí trojúhelníkem; v prvním obrazci je jeden čtverec a v každém následujícím obrazci přibude další čtverec; uvnitř každého druhého čtverce je jedna sirka. Tedy 1. obrazec je sestaven z $8$ sirek, 2. obrazec z $12$ sirek atd.',
        'Určete,',
        '16.1 o kolik sirek má 7. obrazec více než 4. obrazec,',
        '16.2 z kolika sirek je sestaven 20. obrazec,',
        '16.3 kolikátý obrazec je sestaven ze $148$ sirek.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'sirky-obrazce.svg',
     'alt': 'Obrazce ze sirek: vlevo a vpravo trojúhelník, uprostřed řada čtverců; v každém druhém čtverci úhlopříčná sirka. Zobrazen 1., 2. a 3. obrazec.',
     'cap': '1., 2. a 3. obrazec ze sirek',
     'sol': ['Počet sirek $n$-tého obrazce: obvod řady $n$ čtverců a dvou koncových trojúhelníků dá $3n+5$ sirek a uvnitř přibude $\\left\\lfloor\\frac{n}{2}\\right\\rfloor$ sirek. Celkem $S(n)=3n+5+\\left\\lfloor\\frac{n}{2}\\right\\rfloor$ (kontrola: $S(1)=8$, $S(2)=12$).',
             '16.1 $S(7)=21+5+3=29$, $S(4)=12+5+2=19$; rozdíl $29-19=10$ sirek.',
             '16.2 $S(20)=60+5+10=75$ sirek.',
             '16.3 Pro liché $n$ je $S(n)=\\frac{7n+9}{2}=148\\Rightarrow 7n=287\\Rightarrow n=41$. Ze $148$ sirek je sestaven 41. obrazec.'],
     'ans': '16.1: o $10$ sirek; 16.2: $75$ sirek; 16.3: 41. obrazec', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PAD20C0T01'
    gen.YEAR = 2020

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M7A' not in p['name']: errors.append('Název bez M7A: ' + p['name'])
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
    print('Součet bodů:', sum(p['pts'] for p in PROBLEMS))
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2020')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
