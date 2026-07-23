# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2023, MATEMATIKA 9B (čtyřleté obory, 9. ročník).
# Kód testu: M9PBD23C0T02. 16 úloh (po rozdělení nezávislých poduúloh 21 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR).

# ---- SVG obrázky (bez ' a \) ----

# úloha 8: dort tvaru rotačního válce na kruhovém tácu, svislý řez (schematicky)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 210" font-family="sans-serif">
<ellipse cx="160" cy="165" rx="140" ry="28" fill="#e6e6e6" stroke="#000" stroke-width="1.4"/>
<path d="M 60 95 L 60 130 A 100 24 0 0 0 260 130 L 260 95" fill="#f4f4f4" stroke="#000" stroke-width="1.4"/>
<ellipse cx="160" cy="95" rx="100" ry="24" fill="#fbfbfb" stroke="#000" stroke-width="1.4"/>
<rect x="152" y="95" width="16" height="35" fill="#c4c4c4"/>
<line x1="160" y1="71" x2="160" y2="154" stroke="#000" stroke-width="1.2" stroke-dasharray="4 3"/>
<text x="160" y="40" font-size="12" text-anchor="middle">dort tvaru rotačního válce</text>
<text x="288" y="205" font-size="11" text-anchor="middle">tác</text>
</svg>"""

# úloha 9: úsečka AB a bod S (výchozí obrázek)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif">
<rect x="4" y="4" width="452" height="242" fill="none" stroke="#bbb"/>
<line x1="90" y1="205" x2="390" y2="150" stroke="#000" stroke-width="1.8"/>
<line x1="85" y1="199" x2="95" y2="211" stroke="#000"/>
<line x1="385" y1="144" x2="395" y2="156" stroke="#000"/>
<text x="84" y="228" font-size="15" font-style="italic">A</text>
<text x="393" y="146" font-size="15" font-style="italic">B</text>
<text x="200" y="118" font-size="15">×</text>
<text x="211" y="118" font-size="15" font-style="italic">S</text>
</svg>"""

# úloha 10: kružnice k se středem S, bod C na kružnici, bod Q uvnitř (výchozí obrázek)
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 320" font-family="sans-serif">
<rect x="4" y="4" width="352" height="312" fill="none" stroke="#bbb"/>
<circle cx="180" cy="165" r="135" fill="none" stroke="#000" stroke-width="2"/>
<line x1="176" y1="26" x2="184" y2="40" stroke="#000"/>
<text x="172" y="24" font-size="15" font-style="italic">C</text>
<text x="176" y="170" font-size="15">×</text>
<text x="184" y="184" font-size="15" font-style="italic">S</text>
<text x="236" y="140" font-size="15">×</text>
<text x="244" y="154" font-size="15" font-style="italic">Q</text>
<text x="300" y="272" font-size="15" font-style="italic">k</text>
</svg>"""

# úloha 11: obdélník 8x3 ze 4 shodných trojúhelníků a kosočtverec (schematicky)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 170" font-family="sans-serif">
<rect x="30" y="35" width="200" height="75" fill="none" stroke="#000" stroke-width="1.8"/>
<line x1="130" y1="35" x2="130" y2="110" stroke="#000" stroke-width="1.2"/>
<line x1="30" y1="35" x2="130" y2="110" stroke="#000" stroke-width="1.2"/>
<line x1="130" y1="110" x2="230" y2="35" stroke="#000" stroke-width="1.2"/>
<text x="130" y="130" font-size="13" text-anchor="middle">8 cm</text>
<text x="238" y="78" font-size="13">3 cm</text>
<polygon points="330,72 410,25 490,72 410,119" fill="none" stroke="#000" stroke-width="1.8"/>
<line x1="330" y1="72" x2="490" y2="72" stroke="#000" stroke-width="1.2"/>
<line x1="410" y1="25" x2="410" y2="119" stroke="#000" stroke-width="1.2"/>
</svg>"""

# úloha 12: rovnoramenný trojúhelník ABC se základnou AB, rovnoběžka bodem S, úhly (schematicky)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 190" font-family="sans-serif">
<polygon points="60,150 280,45 300,150" fill="none" stroke="#000" stroke-width="1.8"/>
<line x1="30" y1="97" x2="360" y2="97" stroke="#000" stroke-width="1.4"/>
<text x="276" y="38" font-size="14" font-style="italic">B</text>
<text x="46" y="164" font-size="14" font-style="italic">C</text>
<text x="304" y="166" font-size="14" font-style="italic">A</text>
<text x="290" y="92" font-size="14" font-style="italic">S</text>
<text x="262" y="70" font-size="12">80°</text>
<text x="92" y="146" font-size="14" font-style="italic">ω</text>
<text x="248" y="116" font-size="14" font-style="italic">φ</text>
<text x="346" y="92" font-size="12">∥</text>
<text x="346" y="146" font-size="12">∥</text>
</svg>"""

# úloha 13: trojboký hranol položený na boční stěně, základna 24 cm a výška v (schematicky)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 170" font-family="sans-serif">
<polygon points="40,120 280,120 160,90" fill="none" stroke="#000" stroke-width="1.6"/>
<polygon points="70,100 310,100 190,70" fill="none" stroke="#000" stroke-width="1.6"/>
<line x1="40" y1="120" x2="70" y2="100" stroke="#000" stroke-width="1.6"/>
<line x1="280" y1="120" x2="310" y2="100" stroke="#000" stroke-width="1.6"/>
<line x1="160" y1="90" x2="190" y2="70" stroke="#000" stroke-width="1.6"/>
<line x1="160" y1="120" x2="160" y2="90" stroke="#000" stroke-width="1" stroke-dasharray="4 3"/>
<text x="150" y="138" font-size="12" text-anchor="middle">24 cm</text>
<text x="166" y="110" font-size="12" font-style="italic">v</text>
</svg>"""

# úloha 16: obrazce ve čtvercové síti (1., 2. a 3. obrazec) – diagonální růst
def _obrazce16():
    cell = 16; H = 6
    lines = []; rects = []; texts = []
    def grid(ox, oy, lights, darks, label):
        for i in range(H+1):
            lines.append(f'<line x1="{ox+i*cell}" y1="{oy}" x2="{ox+i*cell}" y2="{oy+H*cell}"/>')
            lines.append(f'<line x1="{ox}" y1="{oy+i*cell}" x2="{ox+H*cell}" y2="{oy+i*cell}"/>')
        for (cx, cy) in darks:
            rects.append(f'<rect x="{ox+(cx+3)*cell}" y="{oy+(cy+3)*cell}" width="{cell}" height="{cell}" fill="#6f6f6f"/>')
        for (cx, cy) in lights:
            rects.append(f'<rect x="{ox+(cx+3)*cell}" y="{oy+(cy+3)*cell}" width="{cell}" height="{cell}" fill="#d8d8d8"/>')
        texts.append(f'<text x="{ox+H*cell//2}" y="{oy+H*cell+16}">{label}</text>')
    L1 = [(0,0)]; D1 = []
    L2 = [(0,0)]; D2 = [(1,1),(1,-1),(-1,1),(-1,-1)]
    L3 = [(0,0),(2,0),(-2,0),(0,2),(0,-2),(2,2),(2,-2),(-2,2),(-2,-2)]
    D3 = [(1,1),(1,-1),(-1,1),(-1,-1)]
    W = H*cell
    grid(10, 15, L1, D1, "1. obrazec"); grid(10+W+36, 15, L2, D2, "2. obrazec"); grid(10+2*(W+36), 15, L3, D3, "3. obrazec")
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {3*W+2*36+20} 160" font-family="sans-serif">'
            + '<g stroke="#ccc" stroke-width="0.8">' + "".join(lines) + '</g>'
            + '<g stroke="#000" stroke-width="1.2">' + "".join(rects) + '</g>'
            + '<g font-size="12" text-anchor="middle">' + "".join(texts) + '</g></svg>')
SVG16 = _obrazce16()

# ---- Úlohy ----

B = ['zs2', 'r9']  # 9. ročník ZŠ (čtyřleté obory)

PROBLEMS = [
    {'name': 'CERMAT M9B 2023 – úloha 1', 'zad': [
        'Vypočtěte:',
        '$\\sqrt{(-5)^2}-3^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\sqrt{(-5)^2}=\\sqrt{25}=5$, tedy $5-3^2=5-9=-4$.'],
     'ans': '$-4$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 2', 'zad': [
        'Třídenní lyžařská permanentka je o $150\\,\\%$ dražší než jednodenní permanentka. Jednodenní permanentka stojí $600$ korun.',
        '2.1 Vypočtěte, kolikrát více se zaplatí za třídenní permanentku než za jednodenní permanentku.',
        '2.2 Vypočtěte, o kolik korun jsou 3 jednodenní permanentky dražší než 1 třídenní permanentka.'],
     'opts': None, 'ln': 4,
     'sol': ['2.1 Třídenní permanentka je o $150\\,\\%$ dražší, stojí tedy $600\\cdot(1+1{,}5)=600\\cdot 2{,}5=1\\,500$ korun. Je proto $1\\,500:600=2{,}5$krát dražší.',
             '2.2 Tři jednodenní permanentky stojí $3\\cdot 600=1\\,800$ korun, jedna třídenní stojí $1\\,500$ korun. Rozdíl je $1\\,800-1\\,500=300$ korun.'],
     'ans': '2.1: $2{,}5$krát; 2.2: o $300$ korun', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M9B 2023 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
        '$\\frac{1}{3}\\cdot\\frac{1}{2}-\\frac{8}{9}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{1}{3}\\cdot\\frac{1}{2}=\\frac{1}{6}$; $\\frac{1}{6}-\\frac{8}{9}=\\frac{3}{18}-\\frac{16}{18}=-\\frac{13}{18}$.'],
     'ans': '$-\\frac{13}{18}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
        '$\\left(2-\\frac{5}{6}\\right):\\frac{5}{3}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$2-\\frac{5}{6}=\\frac{12-5}{6}=\\frac{7}{6}$; $\\frac{7}{6}:\\frac{5}{3}=\\frac{7}{6}\\cdot\\frac{3}{5}=\\frac{21}{30}=\\frac{7}{10}$.'],
     'ans': '$\\frac{7}{10}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 3.3', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$\\frac{\\frac{2}{3}+\\frac{2}{7}}{\\left(\\frac{9}{14}+\\frac{3}{2}\\right)\\cdot 2}=$'],
     'opts': None, 'ln': 4,
     'sol': ['Čitatel: $\\frac{2}{3}+\\frac{2}{7}=\\frac{14+6}{21}=\\frac{20}{21}$. Jmenovatel: $\\frac{9}{14}+\\frac{3}{2}=\\frac{9+21}{14}=\\frac{30}{14}=\\frac{15}{7}$, po vynásobení dvěma $\\frac{30}{7}$. Podíl: $\\frac{20}{21}:\\frac{30}{7}=\\frac{20}{21}\\cdot\\frac{7}{30}=\\frac{140}{630}=\\frac{2}{9}$.'],
     'ans': '$\\frac{2}{9}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 4.1', 'zad': [
        'Upravte a rozložte na součin vytknutím:',
        '$x\\cdot(y-3)+3\\cdot(x-2y)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$x\\cdot(y-3)+3\\cdot(x-2y)=xy-3x+3x-6y=xy-6y=y\\cdot(x-6)$.'],
     'ans': '$y\\cdot(x-6)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 4.2', 'zad': [
        'Určete pomocí vzorce nejjednodušší výraz, kterým je třeba vynásobit výraz $3a-2^2$, abychom získali výraz $9a^2-16$.'],
     'opts': None, 'ln': 2,
     'sol': ['Platí $9a^2-16=(3a)^2-4^2=(3a-4)\\cdot(3a+4)$ a $3a-2^2=3a-4$. Hledaný výraz je tedy $3a+4$.'],
     'ans': '$3a+4$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 4.3', 'zad': [
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky). Uveďte celý postup řešení.',
        '$(3n+2)^2-n\\cdot(3n+4)+(2n-n)\\cdot n=$'],
     'opts': None, 'ln': 4,
     'sol': ['$(3n+2)^2=9n^2+12n+4$; $n\\cdot(3n+4)=3n^2+4n$; $(2n-n)\\cdot n=n\\cdot n=n^2$. Celkem $9n^2+12n+4-(3n^2+4n)+n^2=7n^2+8n+4$.'],
     'ans': '$7n^2+8n+4$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 5.1', 'zad': [
        'Řešte rovnici. Uveďte celý postup řešení.',
        '$2+0{,}5\\cdot(x-3)=0{,}4\\cdot(1{,}5x+2)$'],
     'opts': None, 'ln': 4,
     'sol': ['$2+0{,}5x-1{,}5=0{,}6x+0{,}8$, tj. $0{,}5x+0{,}5=0{,}6x+0{,}8$. Odtud $0{,}5-0{,}8=0{,}6x-0{,}5x$, tedy $-0{,}3=0{,}1x$ a $x=-3$.'],
     'ans': '$x=-3$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 5.2', 'zad': [
        'Řešte rovnici. Uveďte celý postup řešení.',
        '$3\\cdot\\frac{2y-1}{6}=\\frac{3y+2}{8}+\\frac{3}{4}\\cdot\\frac{y-1}{6}$'],
     'opts': None, 'ln': 4,
     'sol': ['Levá strana: $3\\cdot\\frac{2y-1}{6}=\\frac{2y-1}{2}$. Pravá strana: $\\frac{3y+2}{8}+\\frac{3(y-1)}{24}=\\frac{3y+2}{8}+\\frac{y-1}{8}=\\frac{4y+1}{8}$. Z rovnice $\\frac{2y-1}{2}=\\frac{4y+1}{8}$ po vynásobení osmi plyne $4(2y-1)=4y+1$, tj. $8y-4=4y+1$, $4y=5$, $y=\\frac{5}{4}$.'],
     'ans': '$y=\\frac{5}{4}$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 6', 'zad': [
        'V chatě za polárním kruhem jsou připraveny zásoby masa pro 12člennou expedici přesně na 30 dní. Každý člen expedice spotřebuje za den z připravených zásob stejné množství masa.',
        '6.1 Vypočtěte, za kolik dní by 12členná expedice spotřebovala pět šestin připravených zásob masa.',
        '6.2 Vypočtěte, kolikačlenná expedice by všechny připravené zásoby masa spotřebovala za 45 dní.',
        '6.3 Dvě expedice společně spotřebovaly všechny připravené zásoby masa. První expedice pobývala na chatě 4 dny. Druhá expedice měla dvakrát více členů než první a pobývala na chatě 8 dní. Vypočtěte, kolik členů měla první expedice.'],
     'opts': None, 'ln': 4,
     'sol': ['Celkové zásoby odpovídají $12\\cdot 30=360$ člověkodnům.',
             '6.1 Pět šestin zásob je $\\frac{5}{6}\\cdot 360=300$ člověkodnů; 12členná expedice je spotřebuje za $300:12=25$ dní.',
             '6.2 Za 45 dní spotřebuje všechny zásoby expedice o počtu $360:45=8$ členů.',
             '6.3 Označme počet členů první expedice $p$. Platí $4\\cdot p+8\\cdot 2p=360$, tj. $20p=360$, tedy $p=18$ členů (druhá expedice měla 36 členů).'],
     'ans': '6.1: za $25$ dní; 6.2: $8$členná expedice; 6.3: $18$ členů', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2023 – úloha 7', 'zad': [
        'Ondrovi trvá cesta do práce autobusem dvakrát déle než rychlíkem. Osobním vlakem mu trvá cesta do práce o čtvrtinu déle než autobusem. Dobu Ondrovy cesty do práce autobusem označíme $x$.',
        '7.1 Vyjádřete výrazem s proměnnou $x$, jak dlouho trvá Ondrovi cesta do práce rychlíkem.',
        '7.2 Vyjádřete výrazem s proměnnou $x$, jak dlouho trvá Ondrovi cesta do práce osobním vlakem.',
        '7.3 Cesta do práce trvá Ondrovi rychlíkem o 15 minut méně než osobním vlakem. Vypočtěte, kolik minut trvá Ondrovi cesta do práce autobusem.'],
     'opts': None, 'ln': 3,
     'sol': ['7.1 Autobusem trvá cesta dvakrát déle než rychlíkem, proto rychlíkem trvá $\\frac{1}{2}x$.',
             '7.2 Osobním vlakem trvá cesta o čtvrtinu déle než autobusem: $x+\\frac{1}{4}x=\\frac{5}{4}x$.',
             '7.3 Z podmínky $\\frac{5}{4}x-\\frac{1}{2}x=15$ plyne $\\frac{3}{4}x=15$, tedy $x=20$ minut.'],
     'ans': '7.1: $\\frac{1}{2}x$; 7.2: $\\frac{5}{4}x$; 7.3: $20$ minut', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2023 – úloha 8', 'zad': [
        'Dort tvaru rotačního válce leží na kruhovém tácu. Průměr podstavy dortu je větší než výška dortu, ale menší než průměr tácu. Dort jsme rozdělili svislým řezem na dvě stejné poloviny.',
        '8.1 Tác má tvar kruhu o průměru $d$ a obsahu $\\pi\\cdot 144$ cm$^2$. Vypočtěte v cm průměr $d$ tácu.',
        '8.2 Plocha řezu dortu má obsah $200$ cm$^2$ a tvoří ji obdélník, který lze rozdělit na dva čtverce. Vypočtěte v cm$^3$ objem celého dortu. Výsledek zaokrouhlete na desítky cm$^3$.'],
     'opts': None, 'ln': 4, 'svg': SVG8, 'fn': 'dort-valec.svg',
     'alt': 'Dort tvaru rotačního válce na kruhovém tácu, se svislým řezem procházejícím středem.',
     'cap': 'Schematický nákres dortu na tácu',
     'sol': ['8.1 Z $\\pi r^2=\\pi\\cdot 144$ plyne $r^2=144$, tedy $r=12$ cm a průměr $d=24$ cm.',
             '8.2 Obdélníkový řez lze rozdělit na dva čtverce, takže jeho delší strana (průměr dortu) je dvojnásobkem kratší strany (výšky dortu $v$): obsah $2v\\cdot v=200$, tj. $v^2=100$, $v=10$ cm. Průměr dortu je $20$ cm, poloměr $10$ cm. Objem $V=\\pi\\cdot 10^2\\cdot 10=1\\,000\\pi\\doteq 3\\,140$ cm$^3$.'],
     'ans': '8.1: $d=24$ cm; 8.2: přibližně $3\\,140$ cm$^3$', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2023 – úloha 9 (konstrukce)', 'zad': [
        'V rovině leží úsečka $AB$ a bod $S$ (viz obrázek). Úsečka $AB$ je základna rovnoramenného lichoběžníku $ABCD$. Bod $S$ je střed ramene $AD$ tohoto lichoběžníku.',
        'Sestrojte vrcholy $C$, $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'usecka-ab-bod-s.svg',
     'alt': 'Úsečka AB (A vlevo dole, B vpravo nahoře) a bod S nad úsečkou.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Bod $S$ je střed ramene $AD$, proto je vrchol $D$ obrazem bodu $A$ ve středové souměrnosti se středem $S$ (na polopřímce $AS$ platí $|AS|=|SD|$). Lichoběžník je rovnoramenný se základnou $AB$, má tedy osu souměrnosti totožnou s osou úsečky $AB$; vrchol $C$ je obrazem vrcholu $D$ v této osové souměrnosti (přímka $CD$ je rovnoběžná s $AB$). Čtyřúhelník $ABCD$ je hledaný lichoběžník.'],
     'ans': 'Konstrukce lichoběžníku $ABCD$: $D$ je obraz bodu $A$ ve středové souměrnosti se středem $S$, vrchol $C$ je obraz $D$ v osové souměrnosti podle osy úsečky $AB$ (viz nákres v klíči).',
     'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 10 (konstrukce)', 'zad': [
        'V rovině leží body $C$, $Q$ a kružnice $k$ se středem $S$, která prochází bodem $C$ (viz obrázek). Bod $C$ je vrchol trojúhelníku $ABC$ s pravým úhlem při vrcholu $C$. Na kružnici $k$ leží také zbývající dva vrcholy $A$, $B$ tohoto trojúhelníku a bodem $Q$ prochází jedna jeho strana.',
        'Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'kruznice-c-q.svg',
     'alt': 'Kružnice k se středem S, bod C na kružnici nahoře a bod Q uvnitř kružnice.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Protože je úhel při vrcholu $C$ pravý a všechny tři vrcholy leží na kružnici $k$, je přepona $AB$ průměrem kružnice $k$ (Thaletova věta) a prochází středem $S$. Podle toho, která strana prochází bodem $Q$, dostáváme dvě řešení: (1) bodem $Q$ prochází přepona $AB$ – sestrojíme přímku $SQ$, jejíž průsečíky s kružnicí $k$ jsou vrcholy $A$ a $B$; (2) bodem $Q$ prochází odvěsna – sestrojíme přímku $CQ$, jejíž druhý průsečík s kružnicí $k$ je jeden vrchol a druhý vrchol je s ním souměrný podle středu $S$ (druhý konec průměru).'],
     'ans': 'Dvě řešení: přepona $AB$ je průměr kružnice $k$ procházející středem $S$. Buď bodem $Q$ prochází přepona ($A$, $B$ jsou průsečíky přímky $SQ$ s $k$), nebo odvěsna (jeden vrchol je druhý průsečík přímky $CQ$ s $k$, druhý vrchol je jeho obraz ve středové souměrnosti podle $S$) – viz nákres v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 11', 'zad': [
        'Obdélník se stranami délek 8 cm a 3 cm se skládá ze čtyř shodných trojúhelníků (viz obrázek). Přemístěním trojúhelníků vznikl kosočtverec.',
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
        '11.1 Obsah kosočtverce je větší než obsah obdélníku.',
        '11.2 Strana kosočtverce měří 5 cm.',
        '11.3 Výška kosočtverce měří 4,8 cm.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'obdelnik-kosoctverec.svg',
     'alt': 'Obdélník se stranami 8 cm a 3 cm rozdělený na čtyři shodné trojúhelníky a kosočtverec s vyznačenými úhlopříčkami.',
     'cap': 'Schematický nákres obdélníku a kosočtverce',
     'sol': ['11.1 Kosočtverec vznikl pouze přemístěním trojúhelníků z obdélníku, obsah se tedy zachovává ($8\\cdot 3=24$ cm$^2$) a není větší – tvrzení není pravdivé (N).',
             '11.2 Každý ze čtyř shodných pravoúhlých trojúhelníků má odvěsny $4$ cm a $3$ cm, přepona (a tedy strana kosočtverce) měří $\\sqrt{4^2+3^2}=5$ cm – pravdivé (A).',
             '11.3 Ze vztahu obsah $=$ strana $\\cdot$ výška plyne $5\\cdot v=24$, tedy $v=4{,}8$ cm – pravdivé (A).'],
     'ans': '11.1: N; 11.2: A; 11.3: A', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 12', 'zad': [
        'V rovině leží rovnoramenný trojúhelník $ABC$ se základnou $AB$. Bod $S$ je střed základny $AB$ a prochází jím rovnoběžka s přímkou $AC$ (viz obrázek). U vrcholu $B$ je vyznačen úhel $80^\\circ$, u vrcholu $C$ úhel $\\omega$ a u bodu $S$ úhel $\\varphi$.',
        'Jaký je součet $\\varphi+\\omega$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) $150^\\circ$', 'B) $155^\\circ$', 'C) $160^\\circ$', 'D) $165^\\circ$', 'E) $170^\\circ$'],
     'ln': 0, 'svg': SVG12, 'fn': 'trojuhelnik-uhly.svg',
     'alt': 'Rovnoramenný trojúhelník ABC se základnou AB, rovnoběžka s AC vedená středem S základny; vyznačené úhly 80 stupňů u B, omega u C a fí u S.',
     'cap': 'Schematický nákres k úloze 12',
     'sol': ['Trojúhelník je rovnoramenný se základnou $AB$, proto jsou úhly při základně shodné: $\\angle CAB=\\angle CBA=80^\\circ$ a $\\angle ACB=180^\\circ-2\\cdot 80^\\circ=20^\\circ$. Úsečka $CS$ je osou souměrnosti (těžnice k základně), půlí tedy úhel při vrcholu $C$ a je kolmá k $AB$. Z rovnoběžnosti přímky vedené bodem $S$ s přímkou $AC$ a z uvedených vztahů vychází $\\varphi=10^\\circ$ a $\\omega=160^\\circ$, tedy $\\varphi+\\omega=170^\\circ$.'],
     'ans': 'E) $170^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 13', 'zad': [
        'Trojboký hranol je položen na jedné boční stěně (viz obrázek). Podstavu hranolu tvoří rovnoramenný trojúhelník, který má základnu délky 24 cm a obsah 60 cm$^2$. Velikost $v$ výšky na základnu tohoto trojúhelníku je stejná jako délka nejkratší hrany hranolu.',
        'Jaký je objem trojbokého hranolu?'],
     'opts': ['A) $150$ cm$^3$', 'B) $200$ cm$^3$', 'C) $300$ cm$^3$', 'D) $370$ cm$^3$', 'E) jiný objem'],
     'ln': 0, 'svg': SVG13, 'fn': 'trojboky-hranol.svg',
     'alt': 'Trojboký hranol položený na boční stěně; podstava je rovnoramenný trojúhelník se základnou 24 cm a výškou v.',
     'cap': 'Schematický nákres trojbokého hranolu',
     'sol': ['Z obsahu podstavy $\\frac{1}{2}\\cdot 24\\cdot v=60$ plyne $v=5$ cm. Nejkratší hrana hranolu (jeho délka) je tedy $5$ cm. Objem $V=S_{podstavy}\\cdot v=60\\cdot 5=300$ cm$^3$.'],
     'ans': 'C) $300$ cm$^3$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2023 – úloha 14', 'zad': [
        'Košíkář prodal během prvních dvou dnů velikonočních trhů všechny upletené pomlázky. První den prodal pětinu všech upletených pomlázek. Druhý den prodal o 180 pomlázek více než první den.',
        'Kolik pomlázek prodal košíkář první den velikonočních trhů?'],
     'opts': ['A) $60$ pomlázek', 'B) $45$ pomlázek', 'C) $36$ pomlázek', 'D) $30$ pomlázek', 'E) jiný počet pomlázek'],
     'ln': 0,
     'sol': ['Označme počet všech pomlázek $x$. První den prodal $\\frac{1}{5}x$, druhý den zbylé $\\frac{4}{5}x$. Z podmínky $\\frac{4}{5}x=\\frac{1}{5}x+180$ plyne $\\frac{3}{5}x=180$, tedy $x=300$. První den prodal $\\frac{1}{5}\\cdot 300=60$ pomlázek.'],
     'ans': 'A) $60$ pomlázek', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2023 – úloha 15', 'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Letos má skautský oddíl 60 členů, což je o 20 členů více než loni. O kolik procent má letos skautský oddíl více členů než loni?',
        '15.2 Během výletu Jakub utratil tři pětiny kapesného. Tři čtvrtiny z této utracené částky použil k nákupu turistické známky. Kolik procent z kapesného utratil Jakub za turistickou známku?',
        '15.3 Na třídenním festivalu se první a druhý den prodal stejný počet vstupenek. Třetí den se prodalo o třetinu více vstupenek než druhý den. Kolik procent všech vstupenek prodaných během festivalu se prodalo třetí den?'],
     'opts': ['A) méně než $40\\,\\%$', 'B) $40\\,\\%$', 'C) $45\\,\\%$', 'D) $50\\,\\%$', 'E) $55\\,\\%$', 'F) více než $55\\,\\%$'],
     'ln': 0,
     'sol': ['15.1 Loni měl oddíl $60-20=40$ členů, nárůst o $20$ z $40$ je $\\frac{20}{40}=50\\,\\%$ (D).',
             '15.2 Za známku utratil $\\frac{3}{4}$ ze $\\frac{3}{5}$ kapesného, tj. $\\frac{3}{4}\\cdot\\frac{3}{5}=\\frac{9}{20}=45\\,\\%$ (C).',
             '15.3 Označme počet vstupenek prodaných první a druhý den $a$, třetí den $\\frac{4}{3}a$. Celkem $a+a+\\frac{4}{3}a=\\frac{10}{3}a$; třetí den tvoří $\\frac{4/3\\cdot a}{10/3\\cdot a}=\\frac{4}{10}=40\\,\\%$ (B).'],
     'ans': '15.1: D ($50\\,\\%$); 15.2: C ($45\\,\\%$); 15.3: B ($40\\,\\%$)', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2023 – úloha 16', 'zad': [
        'Vybarvováním některých prázdných polí čtvercové sítě postupně vytváříme obrazce (viz obrázek). Prvním obrazcem je jedno světle vybarvené pole čtvercové sítě. Každý další obrazec vytvoříme z předchozího tak, že vybarvíme všechna prázdná pole, která mají s předchozím obrazcem společné pouze vrcholy. Tato nově vybarvená pole jsou u sudých obrazců tmavá a u lichých obrazců světlá. Druhý obrazec jsme vytvořili z prvního vybarvením 4 dalších polí tmavou barvou. Třetí obrazec má celkem 13 polí (9 světlých a 4 tmavá).',
        '16.1 Určete, vybarvením kolika dalších polí jsme z 8. obrazce vytvořili 9. obrazec.',
        '16.2 Určete, o kolik se liší počet tmavých a světlých polí v 10. obrazci.',
        '16.3 Určete, kolik světlých polí může mít obrazec, který má 400 tmavých polí. Najděte všechna řešení.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'obrazce-sit.svg',
     'alt': 'První, druhý a třetí obrazec ve čtvercové síti: 1 světlé pole; 5 polí (1 světlé a 4 tmavá v úhlopříčných rozích); 13 polí (9 světlých a 4 tmavá).',
     'cap': 'Obrazce ve čtvercové síti (1., 2. a 3. obrazec)',
     'sol': ['Počet polí $n$-tého obrazce je $2n^2-2n+1$ (postupně $1, 5, 13, \\ldots$); přechodem od $(n-1)$-tého k $n$-tému obrazci přibude $4(n-1)$ polí.',
             '16.1 Z 8. na 9. obrazec přibude $4\\cdot(9-1)=32$ polí.',
             '16.2 Tmavá pole přibývají jen u sudých obrazců; pro sudé $n$ je jejich počet $n^2$. V 10. obrazci je $10^2=100$ tmavých polí a $181-100=81$ světlých polí, liší se tedy o $100-81=19$.',
             '16.3 Počet tmavých polí je $400$ pro dva obrazce: pro sudý $n=20$ (tmavých $n^2=400$) a pro lichý $n=21$ (tmavých $(n-1)^2=400$). Počet světlých polí je pak $(n-1)^2=361$ (pro $n=20$), resp. $n^2=441$ (pro $n=21$).'],
     'ans': '16.1: $32$ polí; 16.2: o $19$; 16.3: $361$ nebo $441$ světlých polí', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PBD23C0T02'
    gen.YEAR = 2023

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9B-2023')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
