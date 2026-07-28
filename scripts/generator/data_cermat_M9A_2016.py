# -*- coding: utf-8 -*-
# CERMAT – Přijímací zkoušky 2016 (pilotní ročník), MATEMATIKA 9 (čtyřleté obory, 9. ročník).
# Kód testu: M9PZD16C0T01. 17 úloh / 50 bodů (po rozdělení nezávislých podúloh 22 záznamů).
# Zdroj odpovědí: klíč správných řešení (KSR) + záznamový arch (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 8: domeček = čtverec (strana 10 cm) + pravoúhlý trojúhelník s odvěsnami 8 cm a 6 cm
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 360" font-family="sans-serif">
<g stroke="#000" stroke-width="2" fill="none">
<rect x="80" y="120" width="200" height="200"/>
<path d="M80,120 L208,24 L280,120"/>
</g>
<g stroke="#000" stroke-width="1" fill="none">
<path d="M197,32 L205,44 L216,35"/>
<line x1="90" y1="176" x2="270" y2="176"/>
<path d="M98,171 L88,176 L98,181"/>
<path d="M262,171 L272,176 L262,181"/>
</g>
<g font-size="15">
<text x="180" y="169" font-style="italic" text-anchor="middle">s</text>
<text x="104" y="66" font-size="14">8 cm</text>
<text x="252" y="62" font-size="14">6 cm</text>
</g>
</svg>"""

# úloha 9: přímka p, body M (pod přímkou) a L (nad přímkou)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 220" font-family="sans-serif">
<g stroke="#000" stroke-width="2">
<line x1="30" y1="70" x2="450" y2="175"/>
<line x1="334" y1="54" x2="346" y2="66"/><line x1="346" y1="54" x2="334" y2="66"/>
<line x1="244" y1="174" x2="256" y2="186"/><line x1="256" y1="174" x2="244" y2="186"/>
</g>
<g font-size="16" font-style="italic">
<text x="60" y="94">p</text><text x="356" y="56">L</text><text x="244" y="206">M</text>
</g>
</svg>"""

# úloha 10: přímka BD s vyznačenými body B a D
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 290" font-family="sans-serif">
<g stroke="#000" stroke-width="2">
<line x1="160" y1="30" x2="292" y2="262"/>
<line x1="172" y1="76" x2="196" y2="62"/>
<line x1="252" y1="222" x2="276" y2="208"/>
</g>
<g font-size="16" font-style="italic">
<text x="200" y="62">D</text><text x="282" y="206">B</text>
</g>
</svg>"""

# úloha 12: čtverec se středem S a vepsaný kruh o průměru 10 cm
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 220" font-family="sans-serif">
<rect x="40" y="20" width="180" height="180" fill="#b3b3b3" stroke="#000" stroke-width="2"/>
<circle cx="130" cy="110" r="90" fill="#ffffff" stroke="#000" stroke-width="2"/>
<line x1="66" y1="46" x2="194" y2="174" stroke="#000" stroke-width="2"/>
<g stroke="#000" stroke-width="2">
<line x1="122" y1="102" x2="138" y2="118"/><line x1="138" y1="102" x2="122" y2="118"/>
</g>
<g font-size="15">
<text x="108" y="126" font-style="italic">S</text>
<text x="140" y="80">10 cm</text>
</g>
</svg>"""

# úloha 13: dvě rovnoběžky proťaté dvěma různoběžkami se společným bodem na horní rovnoběžce
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 320" font-family="sans-serif">
<g stroke="#000" stroke-width="2" fill="none">
<line x1="150" y1="100" x2="480" y2="100"/>
<line x1="60" y1="250" x2="480" y2="250"/>
<line x1="165" y1="40" x2="103" y2="290"/>
<line x1="86" y1="52" x2="392" y2="282"/>
</g>
<g stroke="#000" stroke-width="2">
<line x1="428" y1="92" x2="428" y2="108"/><line x1="438" y1="92" x2="438" y2="108"/>
<line x1="428" y1="242" x2="428" y2="258"/><line x1="438" y1="242" x2="438" y2="258"/>
</g>
<g stroke="#000" stroke-width="1" fill="none">
<path d="M116,75 A42,42 0 0 0 140,141"/>
<path d="M143,129 A30,30 0 0 0 174,118"/>
<path d="M188,129 A48,48 0 0 0 198,100"/>
<path d="M121,215 A36,36 0 0 1 149,250"/>
<path d="M317,226 A40,40 0 0 0 309,250"/>
</g>
<g font-size="15" text-anchor="middle">
<text x="97" y="124">113°</text>
<text x="212" y="118">37°</text>
</g>
<g font-size="16" font-style="italic" text-anchor="middle">
<text x="163" y="146">γ</text><text x="148" y="228">α</text><text x="302" y="240">β</text>
</g>
</svg>"""

# úloha 14: kvádr ABCDEFGH se čtvercovou podstavou
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 340" font-family="sans-serif">
<g stroke="#000" stroke-width="2" fill="none">
<path d="M60,300 L240,300 L240,150 L60,150 Z"/>
<path d="M240,300 L310,240 L310,90 L240,150"/>
<path d="M60,150 L130,90 L310,90"/>
</g>
<g stroke="#000" stroke-width="1" fill="none" stroke-dasharray="6 4">
<path d="M60,300 L130,240 L310,240"/>
<line x1="130" y1="240" x2="130" y2="90"/>
</g>
<g font-size="15" font-style="italic">
<text x="46" y="318">A</text><text x="244" y="318">B</text><text x="318" y="244">C</text><text x="108" y="236">D</text>
<text x="42" y="148">E</text><text x="248" y="168">F</text><text x="318" y="86">G</text><text x="110" y="84">H</text>
</g>
</svg>"""


# úloha 17: sloupcový graf úspor (leden, únor; březen chybí)
def _graf17():
    data = [('Anna', 80, 60), ('Bára', 100, 40), ('Cilka', 20, 80)]
    y0 = 300; sc = 1.8; x0 = 70; bw = 30
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 360" font-family="sans-serif">']
    s.append('<text x="250" y="28" font-size="18" font-weight="bold" text-anchor="middle">Úspory</text>')
    for v in range(0, 141, 20):
        y = y0 - v * sc
        s.append(f'<line x1="{x0}" y1="{y}" x2="440" y2="{y}" stroke="#bbbbbb" stroke-width="1"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="12" text-anchor="end">{v}</text>')
    s.append(f'<line x1="{x0}" y1="40" x2="{x0}" y2="{y0}" stroke="#000" stroke-width="1"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="440" y2="{y0}" stroke="#000" stroke-width="1"/>')
    s.append('<text x="26" y="170" font-size="13">Kč</text>')
    gx = x0 + 20
    for name, led, uno in data:
        for i, (val, col) in enumerate(((led, '#1a1a1a'), (uno, '#d9d9d9'))):
            h = val * sc
            s.append(f'<rect x="{gx+i*(bw+2)}" y="{y0-h}" width="{bw}" height="{h}" fill="{col}" stroke="#000"/>')
        bx = gx + 2 * (bw + 2)
        s.append(f'<line x1="{bx}" y1="{y0-252}" x2="{bx}" y2="{y0}" stroke="#555555" stroke-dasharray="6 4"/>')
        s.append(f'<line x1="{bx+bw}" y1="{y0-252}" x2="{bx+bw}" y2="{y0}" stroke="#555555" stroke-dasharray="6 4"/>')
        s.append(f'<text x="{bx+bw/2}" y="{y0-160}" font-size="18" font-weight="bold" text-anchor="middle">?</text>')
        s.append(f'<text x="{gx+48}" y="{y0+20}" font-size="13" text-anchor="middle">{name}</text>')
        gx += 120
    s.append('<rect x="460" y="80" width="14" height="14" fill="#1a1a1a" stroke="#000"/><text x="480" y="92" font-size="13">leden</text>')
    s.append('<rect x="460" y="106" width="14" height="14" fill="#d9d9d9" stroke="#000"/><text x="480" y="118" font-size="13">únor</text>')
    s.append('<rect x="460" y="132" width="14" height="14" fill="none" stroke="#555555" stroke-dasharray="4 3"/><text x="480" y="144" font-size="13">březen</text>')
    s.append('</svg>')
    return "".join(s)


SVG17 = _graf17()

B = ['zs2', 'r9']

PROBLEMS = [
    {'name': 'CERMAT M9A 2016 – úloha 1', 'zad': [
        'Vypočtěte, kolikrát je rozdíl čísel $1{,}4$ a $0{,}7$ (v tomto pořadí) menší než jejich součet.'],
     'opts': None, 'ln': 2,
     'sol': ['Rozdíl: $1{,}4-0{,}7=0{,}7$. Součet: $1{,}4+0{,}7=2{,}1$.',
             '$2{,}1:0{,}7=3$.'],
     'ans': '$3$krát', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 2.1', 'zad': ['Vypočtěte: $0{,}5\\cdot 0{,}06-0{,}09:0{,}1=$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}5\\cdot 0{,}06=0{,}03$ a $0{,}09:0{,}1=0{,}9$.',
             '$0{,}03-0{,}9=-0{,}87$.'],
     'ans': '$-0{,}87$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 2.2',
     'zad': ['Vypočtěte: $\\left(9-\\sqrt{9}\\right)^2-\\left(\\sqrt{9}\\right)^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\sqrt{9}=3$, tedy $(9-3)^2-3^2$.',
             '$6^2-9=36-9=27$.'],
     'ans': '$27$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$\\frac{2-\\frac{3}{5}\\cdot\\frac{5}{2}}{2}=$'],
     'opts': None, 'ln': 4,
     'sol': ['V čitateli nejprve násobíme: $\\frac{3}{5}\\cdot\\frac{5}{2}=\\frac{3}{2}$.',
             'Čitatel je $2-\\frac{3}{2}=\\frac{1}{2}$.',
             '$\\frac{1}{2}:2=\\frac{1}{4}$.'],
     'ans': '$\\frac{1}{4}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$\\frac{3}{4}:\\frac{15}{2}-\\left(\\frac{3}{5}\\right)^2=$'],
     'opts': None, 'ln': 4,
     'sol': ['$\\frac{3}{4}:\\frac{15}{2}=\\frac{3}{4}\\cdot\\frac{2}{15}=\\frac{6}{60}=\\frac{1}{10}$.',
             '$\\left(\\frac{3}{5}\\right)^2=\\frac{9}{25}$.',
             '$\\frac{1}{10}-\\frac{9}{25}=\\frac{5}{50}-\\frac{18}{50}=-\\frac{13}{50}$.'],
     'ans': '$-\\frac{13}{50}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 4.1', 'zad': [
        'Zjednodušte. Výsledný výraz nesmí obsahovat závorky. Uveďte celý postup řešení.',
        '$(2x-3)^2+(12x-2x^2)=$'],
     'opts': None, 'ln': 4,
     'sol': ['$(2x-3)^2=4x^2-12x+9$.',
             '$4x^2-12x+9+12x-2x^2=2x^2+9$.'],
     'ans': '$2x^2+9$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 4.2', 'zad': [
        'Zjednodušte. Výsledný výraz nesmí obsahovat závorky. Uveďte celý postup řešení.',
        '$(2+y)(y-2)-2(y^2-1)=$'],
     'opts': None, 'ln': 4,
     'sol': ['$(2+y)(y-2)=y^2-4$ (rozdíl druhých mocnin).',
             '$y^2-4-2y^2+2=-y^2-2$.'],
     'ans': '$-y^2-2$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 5', 'zad': [
        'Řešte rovnici. Uveďte celý postup řešení (zkoušku nezapisujte).',
        '$\\frac{6+5x}{6}-\\frac{1}{3}=\\frac{10}{9}x+1$'],
     'opts': None, 'ln': 5,
     'sol': ['Rovnici vynásobíme číslem 18: $3(6+5x)-6=20x+18$.',
             '$18+15x-6=20x+18$, tedy $15x+12=20x+18$.',
             '$-6=5x$, tedy $x=-\\frac{6}{5}$.'],
     'ans': '$x=-\\frac{6}{5}$', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 6', 'zad': [
        'Farmář přivezl na trh brambory. Za první hodinu prodal dvě pětiny přivezených brambor, za druhou hodinu prodal pět šestin zbývajících brambor a během třetí hodiny doprodal posledních $40$ kg brambor.',
        '6.1 Vyjádřete zlomkem, jaká část přivezených brambor zbyla farmářovi po první hodině prodeje.',
        '6.2 Vypočtěte, kolik kilogramů brambor prodal farmář za druhou hodinu.',
        '6.3 Vypočtěte, kolik kilogramů brambor přivezl farmář na trh.'],
     'opts': None, 'ln': 3,
     'sol': ['6.1 Po první hodině zbylo $1-\\frac{2}{5}=\\frac{3}{5}$ přivezených brambor.',
             'Za druhou hodinu prodal $\\frac{5}{6}$ z $\\frac{3}{5}$, tedy $\\frac{5}{6}\\cdot\\frac{3}{5}=\\frac{1}{2}$ všech přivezených brambor.',
             'Po druhé hodině zbývá $\\frac{3}{5}-\\frac{1}{2}=\\frac{1}{10}$ přivezených brambor, což je $40$ kg.',
             '6.3 Celkem přivezl $40\\cdot 10=400$ kg brambor.',
             '6.2 Za druhou hodinu prodal $\\frac{1}{2}\\cdot 400=200$ kg brambor.'],
     'ans': '6.1: $\\frac{3}{5}$; 6.2: $200$ kg; 6.3: $400$ kg', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2016 – úloha 7.1', 'zad': ['Vypočtěte, kolikrát je menší $5$ dm² než $100$ m².'],
     'opts': None, 'ln': 2,
     'sol': ['$100$ m² $=1\\,000\\,000$ cm², $5$ dm² $=500$ cm².',
             '$1\\,000\\,000:500=2\\,000$.'],
     'ans': '$2\\,000$krát', 'pts': 1, 'mins': 2, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 7.2', 'zad': ['Vypočtěte, kolik cm³ je jedna desetina litru.'],
     'opts': None, 'ln': 2,
     'sol': ['$1$ litr $=1$ dm³ $=1\\,000$ cm³.',
             'Jedna desetina litru je $1\\,000:10=100$ cm³.'],
     'ans': '$100$ cm³', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 7.3', 'zad': ['Vyjádřete zlomkem, jakou část z $24$ hodin tvoří $80$ minut.'],
     'opts': None, 'ln': 2,
     'sol': ['$24$ hodin $=24\\cdot 60=1\\,440$ minut.',
             '$\\frac{80}{1\\,440}=\\frac{1}{18}$.'],
     'ans': '$\\frac{1}{18}$', 'pts': 1, 'mins': 2, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 8', 'zad': [
        'Domeček na obrázku je složen ze čtverce a pravoúhlého trojúhelníku. Navzájem kolmé strany trojúhelníku měří $6$ cm a $8$ cm. Přepona trojúhelníku je zároveň horní stranou čtverce.',
        '8.1 Vypočtěte obsah trojúhelníku.',
        '8.2 Vypočtěte šířku domečku ($s$).'],
     'opts': None, 'ln': 3, 'svg': SVG8, 'fn': 'domecek.svg',
     'alt': 'Domeček složený ze čtverce a pravoúhlého trojúhelníku s odvěsnami 8 cm a 6 cm; šířka domečku je označena s.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['8.1 Odvěsny jsou navzájem kolmé, proto $S=\\frac{6\\cdot 8}{2}=24$ cm².',
             '8.2 Šířka domečku $s$ je délka přepony trojúhelníku (a zároveň strany čtverce).',
             'Podle Pythagorovy věty $s=\\sqrt{6^2+8^2}=\\sqrt{36+64}=\\sqrt{100}=10$ cm.'],
     'ans': '8.1: $24$ cm²; 8.2: $10$ cm', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 9', 'zad': [
        'V rovině leží přímka $p$ a mimo ni dva různé body $M$, $L$ (viz obrázek).',
        'Na přímce $p$ sestrojte všechny takové body:',
        '9.1 $K$, aby velikost úhlu $KLM$ byla $60^\\circ$;',
        '9.2 $N$, aby vzdálenost bodů $M$, $N$ byla stejná jako vzdálenost bodů $M$, $L$.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-p-body-ml.svg',
     'alt': 'Přímka p a dva body M a L ležící mimo tuto přímku (bod L nad přímkou, bod M pod přímkou).',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['9.1 Sestrojíme polopřímku $LM$ a v bodě $L$ k ní naneseme úhel o velikosti $60^\\circ$.',
             'Hledaný bod $K$ je průsečík ramene tohoto úhlu s přímkou $p$.',
             '9.2 Sestrojíme kružnici se středem $M$ a poloměrem $|ML|$.',
             'Hledané body $N_1$, $N_2$ jsou průsečíky této kružnice s přímkou $p$ (dvě řešení).'],
     'ans': 'Bod $K$ je průsečík přímky $p$ s ramenem úhlu o velikosti $60^\\circ$ naneseného v bodě $L$ k polopřímce $LM$; body $N_1$, $N_2$ jsou průsečíky přímky $p$ s kružnicí se středem $M$ a poloměrem $|ML|$ (viz obrázek v klíči správných řešení).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 10', 'zad': [
        'V rovině leží přímka $BD$ (viz obrázek).',
        'Sestrojte chybějící vrcholy $A$, $C$ čtverce $ABCD$. Čtverec narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'primka-bd.svg',
     'alt': 'Přímka procházející dvěma vyznačenými body D a B.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Úsečka $BD$ je úhlopříčka čtverce $ABCD$.',
             'Úhlopříčky čtverce jsou shodné, navzájem kolmé a navzájem se půlí.',
             'Sestrojíme osu úsečky $BD$; ta protne $BD$ ve středu $S$.',
             'Na osu naneseme od bodu $S$ na obě strany vzdálenost $|SB|$ a získáme vrcholy $A$ a $C$.'],
     'ans': 'Vrcholy $A$, $C$ leží na ose úsečky $BD$ ve vzdálenosti $\\frac{|BD|}{2}$ od jejího středu $S$ (úhlopříčky čtverce jsou shodné, kolmé a půlí se) – viz obrázek v klíči správných řešení.',
     'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 11', 'zad': [
        'Stará fotografie tvaru obdélníku má délku $a=12$ cm a šířku $b=9$ cm. Při kopírování vznikla nová fotografie, jejíž rozměry jsou $1{,}5$krát větší než u staré fotografie.',
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (Ano), či nikoli (Ne).',
        '11.1 Šířka nové fotografie je stejná jako délka staré fotografie.',
        '11.2 Délky nové a staré fotografie jsou v poměru $3:2$.',
        '11.3 Délka a šířka nové fotografie jsou v poměru $4:3$.'],
     'opts': None, 'ln': 0,
     'sol': ['Nová fotografie má délku $1{,}5\\cdot 12=18$ cm a šířku $1{,}5\\cdot 9=13{,}5$ cm.',
             '11.1 Šířka nové fotografie je $13{,}5$ cm, délka staré je $12$ cm → Ne.',
             '11.2 $18:12=3:2$ → Ano.',
             '11.3 $18:13{,}5=180:135=4:3$ → Ano.'],
     'ans': '11.1: Ne; 11.2: Ano; 11.3: Ano', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2016 – úloha 12', 'zad': [
        'Ze čtverce se středem $S$ byl vystřižen kruh s největším možným poloměrem (viz obrázek). Obvod kruhu je $o=\\pi\\cdot 10$ cm.',
        'Rozhodněte o každém z následujících tvrzení (12.1–12.3), zda je pravdivé (Ano), či nikoli (Ne).',
        '12.1 Obsah kruhu je $\\pi\\cdot 25$ cm².',
        '12.2 Obsah čtverce je $400$ cm².',
        '12.3 Obvod čtverce je $40$ cm.'],
     'opts': None, 'ln': 0, 'svg': SVG12, 'fn': 'ctverec-kruh.svg',
     'alt': 'Čtverec se středem S a do něj vepsaný kruh s vyznačeným průměrem 10 cm.',
     'cap': 'Výchozí obrázek k úloze 12',
     'sol': ['Z $o=\\pi d$ a $o=\\pi\\cdot 10$ cm plyne průměr $d=10$ cm, tedy poloměr $r=5$ cm.',
             '12.1 $S=\\pi r^2=\\pi\\cdot 5^2=\\pi\\cdot 25$ cm² → Ano.',
             'Kruh má největší možný poloměr, proto strana čtverce je rovna průměru kruhu, tj. $10$ cm.',
             '12.2 Obsah čtverce je $10^2=100$ cm², nikoli $400$ cm² → Ne.',
             '12.3 Obvod čtverce je $4\\cdot 10=40$ cm → Ano.'],
     'ans': '12.1: Ano; 12.2: Ne; 12.3: Ano', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 13', 'zad': [
        'V obrázku jsou dvě rovnoběžky (označené dvojitými čárkami), které jsou proťaty dvěma různoběžkami procházejícími týmž bodem na horní rovnoběžce. U tohoto bodu jsou vyznačeny úhly o velikostech $113^\\circ$, $\\gamma$ a $37^\\circ$, u dolní rovnoběžky úhly $\\alpha$ a $\\beta$.',
        'Kolik je $\\alpha+\\beta$? Úhly neměřte.'],
     'opts': ['A) $104^\\circ$', 'B) $113^\\circ$', 'C) $142^\\circ$', 'D) $143^\\circ$', 'E) jiný výsledek'],
     'ln': 0, 'svg': SVG13, 'fn': 'uhly-rovnobezky.svg',
     'alt': 'Dvě rovnoběžné přímky proťaté dvěma různoběžkami se společným bodem na horní rovnoběžce; vyznačené úhly 113 stupňů, gama, 37 stupňů, alfa a beta.',
     'cap': 'Výchozí obrázek k úloze 13',
     'sol': ['Úhly $113^\\circ$ a $\\gamma$ jsou vedlejší (leží u jedné přímky), proto $\\gamma=180^\\circ-113^\\circ=67^\\circ$.',
             'Úhel $\\beta$ je střídavý s úhlem $37^\\circ$ (u rovnoběžek), tedy $\\beta=37^\\circ$.',
             'Úhel mezi strmější příčkou a horní rovnoběžkou je $\\gamma+37^\\circ=104^\\circ$; úhel $\\alpha$ je k němu přilehlý u druhé rovnoběžky, tedy $\\alpha=180^\\circ-104^\\circ=76^\\circ$.',
             '$\\alpha+\\beta=76^\\circ+37^\\circ=113^\\circ$.'],
     'ans': 'B) $113^\\circ$', 'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 14', 'zad': [
        'Kvádr $ABCDEFGH$ má čtvercovou podstavu o obsahu $25$ cm². Obsah boční stěny je o $5$ cm² větší než obsah podstavy.',
        'Jaký je objem kvádru?'],
     'opts': ['A) $125$ cm³', 'B) $150$ cm³', 'C) $170$ cm³', 'D) $175$ cm³', 'E) jiný objem'],
     'ln': 0, 'svg': SVG14, 'fn': 'kvadr.svg',
     'alt': 'Kvádr s vrcholy A, B, C, D dole a E, F, G, H nahoře.',
     'cap': 'Výchozí obrázek k úloze 14',
     'sol': ['Podstava je čtverec o obsahu $25$ cm², proto hrana podstavy je $a=\\sqrt{25}=5$ cm.',
             'Obsah boční stěny je $25+5=30$ cm², tedy $5\\cdot v=30$ a výška je $v=6$ cm.',
             '$V=S_p\\cdot v=25\\cdot 6=150$ cm³.'],
     'ans': 'B) $150$ cm³', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2016 – úloha 15', 'zad': [
        'Čtyři nepřetržitě pracující stroje uklidí společně halu za $24$ hodin. Všechny stroje jsou stejně výkonné. Když se použije o jeden stroj méně, doba úklidu haly se prodlouží.',
        'O kolik hodin se doba úklidu prodlouží?'],
     'opts': ['A) o $8$ hodin', 'B) o $6$ hodin', 'C) o $4$ hodiny', 'D) o $3$ hodiny', 'E) o $2$ hodiny'],
     'ln': 0,
     'sol': ['Celková práce odpovídá $4\\cdot 24=96$ strojohodinám.',
             'Tři stroje ji zvládnou za $96:3=32$ hodin (nepřímá úměrnost).',
             'Doba úklidu se prodlouží o $32-24=8$ hodin.'],
     'ans': 'A) o $8$ hodin', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2016 – úloha 16', 'zad': [
        'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).',
        '16.1 Kabát, který stál původně $2\\,100$ korun, byl zlevněn o $40\\,\\%$. Kolik korun stál po slevě?',
        '16.2 Bunda stála původně $2\\,000$ korun. Poté byla dvakrát zlevněna, vždy na $80\\,\\%$ předchozí ceny. Kolik korun stála po druhé slevě?',
        '16.3 Sako bylo zlevněno o $40\\,\\%$ na $1\\,860$ korun. Kolik korun činí sleva?'],
     'opts': ['A) méně než $1\\,200$ korun', 'B) $1\\,200$ korun', 'C) $1\\,240$ korun',
              'D) $1\\,260$ korun', 'E) $1\\,280$ korun', 'F) více než $1\\,280$ korun'],
     'ln': 0,
     'sol': ['16.1 Po slevě o $40\\,\\%$ zaplatíme $60\\,\\%$ ceny: $0{,}6\\cdot 2\\,100=1\\,260$ korun → D.',
             '16.2 $2\\,000\\cdot 0{,}8=1\\,600$ korun, poté $1\\,600\\cdot 0{,}8=1\\,280$ korun → E.',
             '16.3 Cena $1\\,860$ korun je $60\\,\\%$ původní ceny, původní cena je $1\\,860:0{,}6=3\\,100$ korun.',
             'Sleva činí $3\\,100-1\\,860=1\\,240$ korun → C.'],
     'ans': '16.1: D ($1\\,260$ korun); 16.2: E ($1\\,280$ korun); 16.3: C ($1\\,240$ korun)',
     'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2016 – úloha 17', 'zad': [
        'Anna, Bára a Cilka si v 1. čtvrtletí spořily peníze. Úspory za březen zapomněly zaznamenat do grafu. V lednu uspořila Anna $80$ Kč, Bára $100$ Kč a Cilka $20$ Kč, v únoru uspořila Anna $60$ Kč, Bára $40$ Kč a Cilka $80$ Kč.',
        'Lednové úspory Anny jsou aritmetickým průměrem jejích úspor za únor a březen.',
        'V březnu uspořila Cilka o polovinu více než Bára, ale za celé čtvrtletí uspořily obě dívky stejnou částku.',
        '17.1 Vypočtěte, kolik korun uspořila v březnu Anna.',
        '17.2 Vypočtěte, kolik korun uspořila v březnu Bára a kolik Cilka.'],
     'opts': None, 'ln': 5, 'svg': SVG17, 'fn': 'graf-uspory.svg',
     'alt': 'Sloupcový graf úspor Anny, Báry a Cilky za leden a únor v korunách; sloupce za březen chybí a jsou označeny otazníkem.',
     'cap': 'Úspory dívek v 1. čtvrtletí (v Kč), březen chybí',
     'sol': ['17.1 Označme březnovou úsporu Anny $b$: $80=\\frac{60+b}{2}$, tedy $60+b=160$ a $b=100$ Kč.',
             '17.2 Označme březnovou úsporu Báry $x$; Cilka uspořila $1{,}5x$.',
             'Za čtvrtletí Bára uspořila $100+40+x$ a Cilka $20+80+1{,}5x$.',
             '$140+x=100+1{,}5x$, tedy $0{,}5x=40$ a $x=80$ Kč.',
             'Cilka uspořila $1{,}5\\cdot 80=120$ Kč.'],
     'ans': '17.1: $100$ Kč; 17.2: Bára $80$ Kč, Cilka $120$ Kč', 'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PZD16C0T01'
    gen.YEAR = 2016

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if not p['name'].startswith('CERMAT M9A 2016 – úloha '): errors.append('Špatný prefix: ' + p['name'])
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9A-2016')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
