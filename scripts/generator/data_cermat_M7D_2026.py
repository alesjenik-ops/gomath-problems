# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2026, MATEMATIKA 7D (šestileté obory, 7. ročník),
# 2. náhradní termín. Kód testu: M7PDD26C0T04. 16 úloh (po rozdělení izolovaných
# poduúloh 17 úloh). Zdroj odpovědí: klíč správných řešení (KSR) + ověřeno podle VZA.

# ---- SVG obrázky (bez ' a \) ----

# úloha 6: krychle ABCDEFGH, středy M (hrany AB), N (hrany FG); tři šedé lichoběžníky
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 300" font-family="sans-serif">
<polygon points="200,240 250,240 250,140 150,140" fill="#b8b8b8" stroke="#000"/>
<polygon points="250,240 310,200 280,120 250,140" fill="#b8b8b8" stroke="#000"/>
<polygon points="210,100 150,140 250,140 280,120" fill="#b8b8b8" stroke="#000"/>
<line x1="150" y1="240" x2="250" y2="240" stroke="#000"/>
<line x1="250" y1="240" x2="250" y2="140" stroke="#000"/>
<line x1="250" y1="140" x2="150" y2="140" stroke="#000"/>
<line x1="150" y1="140" x2="150" y2="240" stroke="#000"/>
<line x1="150" y1="240" x2="210" y2="200" stroke="#000" stroke-dasharray="4 3"/>
<line x1="210" y1="200" x2="310" y2="200" stroke="#000"/>
<line x1="310" y1="200" x2="250" y2="240" stroke="#000"/>
<line x1="310" y1="200" x2="310" y2="100" stroke="#000"/>
<line x1="250" y1="140" x2="310" y2="100" stroke="#000"/>
<line x1="310" y1="100" x2="210" y2="100" stroke="#000"/>
<line x1="210" y1="100" x2="150" y2="140" stroke="#000"/>
<line x1="210" y1="100" x2="210" y2="200" stroke="#000" stroke-dasharray="4 3"/>
<text x="138" y="256" font-size="14" font-style="italic">A</text>
<text x="252" y="256" font-size="14" font-style="italic">B</text>
<text x="316" y="200" font-size="14" font-style="italic">C</text>
<text x="196" y="214" font-size="14" font-style="italic">D</text>
<text x="136" y="140" font-size="14" font-style="italic">E</text>
<text x="252" y="136" font-size="14" font-style="italic">F</text>
<text x="316" y="98" font-size="14" font-style="italic">G</text>
<text x="196" y="98" font-size="14" font-style="italic">H</text>
<text x="196" y="256" font-size="13" font-style="italic">M</text>
<text x="284" y="118" font-size="13" font-style="italic">N</text>
</svg>"""

# úloha 7: čtyřúhelník BCDE = lichoběžník ACDE + trojúhelník ABC (E, A, B na jedné přímce)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 275" font-family="sans-serif">
<polygon points="415,220 190,70 40,145 40,220" fill="none" stroke="#000" stroke-width="2"/>
<line x1="190" y1="70" x2="190" y2="220" stroke="#000" stroke-width="2"/>
<polyline points="40,220 52,220 52,208 40,208" fill="none" stroke="#000"/>
<polyline points="190,220 202,220 202,208 190,208" fill="none" stroke="#000"/>
<text x="184" y="62" font-size="15" font-style="italic">C</text>
<text x="26" y="145" font-size="15" font-style="italic">D</text>
<text x="26" y="232" font-size="15" font-style="italic">E</text>
<text x="186" y="238" font-size="15" font-style="italic">A</text>
<text x="418" y="228" font-size="15" font-style="italic">B</text>
<text x="200" y="150" font-size="13">6 cm</text>
<text x="8" y="188" font-size="13">3 cm</text>
<line x1="40" y1="248" x2="415" y2="248" stroke="#444"/>
<polygon points="40,248 48,244 48,252" fill="#444"/>
<polygon points="415,248 407,244 407,252" fill="#444"/>
<text x="212" y="266" font-size="13" text-anchor="middle">15 cm</text>
</svg>"""

# úloha 8: přímka p a body B, D (výchozí obrázek)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 380" font-family="sans-serif">
<rect x="10" y="10" width="460" height="360" fill="none" stroke="#ccc"/>
<line x1="150" y1="40" x2="360" y2="340" stroke="#000" stroke-width="2"/>
<text x="138" y="46" font-size="16" font-style="italic">p</text>
<text x="416" y="158" font-size="15" font-style="italic">D</text>
<text x="412" y="174" font-size="15">×</text>
<text x="416" y="286" font-size="15" font-style="italic">B</text>
<text x="412" y="302" font-size="15">×</text>
</svg>"""

# úloha 9: body D, S, U (výchozí obrázek)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 340" font-family="sans-serif">
<rect x="10" y="10" width="540" height="320" fill="none" stroke="#ccc"/>
<text x="176" y="108" font-size="15" font-style="italic">D</text>
<text x="174" y="124" font-size="15">×</text>
<text x="286" y="250" font-size="15" font-style="italic">S</text>
<text x="284" y="236" font-size="15">×</text>
<text x="498" y="176" font-size="15" font-style="italic">U</text>
<text x="496" y="192" font-size="15">×</text>
</svg>"""

# úloha 10: sloupcový graf výšek (13 let 163, 16 let 171, 17 let 173; ostatní chybí)
def _heights():
    data = [('12 let', None), ('13 let', 163), ('14 let', None),
            ('15 let', None), ('16 let', 171), ('17 let', 173)]
    x0, y0 = 70, 250; base = 158; sc = 10; bw = 46; gap = 20
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="70" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="490" y2="{y0}" stroke="#000"/>')
    for v in range(base, 175, 2):
        y = y0 - (v - base) * sc
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="490" y2="{y}" stroke="#ccc"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    x = x0 + gap
    for name, val in data:
        if val is not None:
            h = (val - base) * sc
            s.append(f'<rect x="{x}" y="{y0-h}" width="{bw}" height="{h}" fill="#c9c9c9" stroke="#000"/>')
        s.append(f'<text x="{x+bw/2}" y="{y0+16}" font-size="11" text-anchor="middle">{name}</text>')
        x += bw + gap
    s.append(f'<text x="26" y="160" font-size="12" text-anchor="middle" transform="rotate(-90 26 160)">Výška v cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _heights()

# úloha 14: síť hranolu – podstavy kosočtverce, boční stěny čtverce (schematicky)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 240" font-family="sans-serif">
<rect x="90" y="95" width="240" height="50" fill="none" stroke="#000"/>
<line x1="150" y1="95" x2="150" y2="145" stroke="#000" stroke-dasharray="5 4"/>
<line x1="210" y1="95" x2="210" y2="145" stroke="#000" stroke-dasharray="5 4"/>
<line x1="270" y1="95" x2="270" y2="145" stroke="#000" stroke-dasharray="5 4"/>
<polygon points="150,95 210,95 180,45 120,45" fill="none" stroke="#000"/>
<polygon points="150,145 210,145 240,195 180,195" fill="none" stroke="#000"/>
<polygon points="90,95 90,145 60,120" fill="none" stroke="#000"/>
<polygon points="330,95 330,145 360,120" fill="none" stroke="#000"/>
</svg>"""

# úloha 15: tabulka počtů účastníků kurzů (chybějící údaje prázdné)
def _table15():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 180" font-family="sans-serif">']
    xs = [20, 150, 250, 350, 450]
    ys = [20, 50, 80, 110, 140, 170]
    for x in xs:
        s.append(f'<line x1="{x}" y1="20" x2="{x}" y2="170" stroke="#000"/>')
    for y in ys:
        x1 = 150 if y == 20 else 20
        s.append(f'<line x1="{x1}" y1="{y}" x2="450" y2="{y}" stroke="#000"/>')
    s.append('<line x1="20" y1="20" x2="20" y2="170" stroke="#000"/>')
    s.append('<text x="30" y="60" font-size="13">Kurz</text>')
    s.append('<text x="300" y="40" font-size="13" text-anchor="middle">Počet účastníků</text>')
    s.append('<text x="200" y="70" font-size="12" text-anchor="middle">Chlapci</text>')
    s.append('<text x="300" y="70" font-size="12" text-anchor="middle">Dívky</text>')
    s.append('<text x="400" y="70" font-size="12" text-anchor="middle">Celkem</text>')
    s.append('<text x="30" y="100" font-size="12">Vodácký</text>')
    s.append('<text x="400" y="100" font-size="12" text-anchor="middle">28</text>')
    s.append('<text x="30" y="130" font-size="12">Turistický</text>')
    s.append('<text x="400" y="130" font-size="12" text-anchor="middle">30</text>')
    s.append('<text x="30" y="160" font-size="12">Cyklistický</text>')
    s.append('<text x="200" y="160" font-size="12" text-anchor="middle">14</text>')
    s.append('</svg>')
    return "".join(s)
SVG15 = _table15()

B = ['zs2', 'r7']  # šestileté obory, 7. ročník ZŠ

PROBLEMS = [
    {'name': 'CERMAT M7D 2026 – úloha 1',
     'zad': ['Filip se učil házet oštěpem. Délka jeho prvního hodu byla $7$ m. Každý další hod byl o desetinu delší než předchozí hod.',
             'Vypočtěte, o kolik cm byl Filipův třetí hod delší než první.'],
     'opts': None, 'ln': 2,
     'sol': ['Druhý hod $7\\cdot 1{,}1=7{,}7$ m, třetí hod $7{,}7\\cdot 1{,}1=8{,}47$ m. Rozdíl $8{,}47-7=1{,}47$ m $=147$ cm.'],
     'ans': 'o $147$ cm', 'pts': 1, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2026 – úloha 2.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{7}{2}-\\frac{1}{6}\\right):\\left(12-6\\cdot\\frac{3}{4}\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\frac{7}{2}-\\frac{1}{6}=\\frac{21-1}{6}=\\frac{20}{6}=\\frac{10}{3}$; $12-6\\cdot\\frac{3}{4}=12-\\frac{9}{2}=\\frac{15}{2}$.',
             '$\\frac{10}{3}:\\frac{15}{2}=\\frac{10}{3}\\cdot\\frac{2}{15}=\\frac{20}{45}=\\frac{4}{9}$.'],
     'ans': '$\\frac{4}{9}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2026 – úloha 2.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\left(2-\\frac{7}{8}\\right)\\cdot 2}{\\frac{7}{5}-5}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel $\\left(2-\\frac{7}{8}\\right)\\cdot 2=\\frac{9}{8}\\cdot 2=\\frac{18}{8}$; jmenovatel $\\frac{7}{5}-5=-\\frac{18}{5}$.',
             '$\\frac{18}{8}:\\left(-\\frac{18}{5}\\right)=\\frac{18}{8}\\cdot\\left(-\\frac{5}{18}\\right)=-\\frac{5}{8}$.'],
     'ans': '$-\\frac{5}{8}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2026 – úloha 3',
     'zad': ['Pozemek má tvar obdélníku, jehož jedna strana je o třetinu delší než sousední strana. Bára obešla celý pozemek po jeho obvodu stejně dlouhými kroky, přitom delší stranu pozemku přešla $120$ kroky.',
             '3.1 Vypočtěte, kolika kroky obešla Bára celý pozemek po jeho obvodu.',
             '3.2 Jeden Bářin krok měří $65$ cm. Vypočtěte, o kolik cm se liší délky sousedních stran pozemku.'],
     'opts': None, 'ln': 3,
     'sol': ['3.1 Delší strana $=120$ kroků $=\\frac{4}{3}$ kratší strany, tedy kratší $=120\\cdot\\frac{3}{4}=90$ kroků. Obvod $=2\\cdot(120+90)=420$ kroků.',
             '3.2 Rozdíl stran $=120-90=30$ kroků; $30\\cdot 65=1\\,950$ cm.'],
     'ans': '3.1: $420$ kroků; 3.2: o $1\\,950$ cm', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2026 – úloha 4',
     'zad': ['V parku běží dva běžci trasu dlouhou $8$ km. Žádný z nich svou rychlost běhu nemění. Rychlejší běžec uběhne celou trasu za $40$ minut. Přitom rychlejší běžec uběhne $3$ km za čas, za který pomalejší běžec uběhne $2\\,500$ m.',
             '4.1 Vypočtěte v minutách, za jaký čas uběhne rychlejší běžec $3$ km.',
             '4.2 Vypočtěte v minutách, za jaký čas uběhne pomalejší běžec celou trasu.'],
     'opts': None, 'ln': 3,
     'sol': ['4.1 Rychlejší běžec: $8$ km za $40$ min, tj. $1$ km za $5$ min; $3$ km za $15$ min.',
             '4.2 Za $15$ min uběhne pomalejší $2\\,500$ m, tj. $1$ km za $6$ min; $8$ km za $48$ min.'],
     'ans': '4.1: $15$ minut; 4.2: $48$ minut', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'fyzika']},

    {'name': 'CERMAT M7D 2026 – úloha 5',
     'zad': ['Spolek daroval na školní akci velké a malé balíčky sušenek. Malý balíček obsahuje $6$ sušenek a velký balíček $10$ sušenek. Ve všech darovaných balíčcích bylo celkem $264$ sušenek.',
             '5.1 Dopoledne se na akci rozdalo $15$ balíčků sušenek. Velkých balíčků se dopoledne rozdalo o polovinu více než malých. Vypočtěte, kolik sušenek bylo v balíčcích, které zbyly na odpoledne.',
             '5.2 Všech darovaných balíčků bylo dohromady $32$. Vypočtěte, kolik z darovaných balíčků bylo velkých.'],
     'opts': None, 'ln': 3,
     'sol': ['5.1 Dopoledne: malých $m$, velkých $1{,}5m$, dohromady $2{,}5m=15\\Rightarrow m=6$, velkých $9$. Rozdáno $6\\cdot 6+9\\cdot 10=126$ sušenek; zbylo $264-126=138$ sušenek.',
             '5.2 $m+v=32$ a $6m+10v=264$; dosazením $6(32-v)+10v=264\\Rightarrow 4v=72\\Rightarrow v=18$ velkých balíčků.'],
     'ans': '5.1: $138$ sušenek; 5.2: $18$ velkých balíčků', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2026 – úloha 6',
     'zad': ['Na bílé krychli $ABCDEFGH$ jsme vyznačili středy $M$, $N$ hran $AB$ a $FG$. Na třech stěnách krychle jsme zakreslili šedé pravoúhlé lichoběžníky $MBFE$, $BCNF$ a $HEFN$ (viz obrázek). Ostatní stěny krychle zůstaly celé bílé.',
             '6.1 Zapište zlomkem v základním tvaru, jakou část plochy přední stěny tvoří šedý lichoběžník $MBFE$.',
             '6.2 Na povrchu celé krychle je část plochy šedá a část bílá. Určete poměr obsahu šedé plochy ku obsahu bílé plochy. Poměr zapište v základním tvaru.'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'krychle-lichobezniky.svg',
     'alt': 'Krychle ABCDEFGH se středy M hrany AB a N hrany FG a třemi šedými lichoběžníky MBFE, BCNF, HEFN.',
     'cap': 'Schematický nákres krychle se šedými lichoběžníky',
     'sol': ['6.1 Přední stěna $ABFE$ (jednotkový čtverec). Lichoběžník $MBFE$ má rovnoběžné strany $MB=\\frac{1}{2}$ a $EF=1$, výšku $1$: obsah $\\frac{\\frac{1}{2}+1}{2}\\cdot 1=\\frac{3}{4}$ stěny.',
             '6.2 Každý ze tří lichoběžníků má obsah $\\frac{3}{4}$ stěny, šedá celkem $3\\cdot\\frac{3}{4}=\\frac{9}{4}$; povrch krychle $=6$ stěn, bílá $6-\\frac{9}{4}=\\frac{15}{4}$. Poměr šedá : bílá $=\\frac{9}{4}:\\frac{15}{4}=3:5$.'],
     'ans': '6.1: $\\frac{3}{4}$; 6.2: $3:5$', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2026 – úloha 7',
     'zad': ['Čtyřúhelník $BCDE$ je složen z pravoúhlého lichoběžníku $ACDE$ a pravoúhlého trojúhelníku $ABC$. Lichoběžník $ACDE$ a trojúhelník $ABC$ mají stejný obsah. V lichoběžníku $ACDE$ má základna $AC$ délku $6$ cm a základna $DE$ délku $3$ cm. Délka úsečky $BE$ je $15$ cm.',
             '7.1 Vypočtěte, jaký je poměr délky úsečky $AE$ ku délce úsečky $AB$.',
             '7.2 Vypočtěte v cm² obsah čtyřúhelníku $BCDE$.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'ctyruhelnik-BCDE.svg',
     'alt': 'Čtyřúhelník BCDE složený z pravoúhlého lichoběžníku ACDE a pravoúhlého trojúhelníku ABC; AC = 6 cm, DE = 3 cm, EB = 15 cm.',
     'cap': 'Schematický nákres čtyřúhelníku BCDE',
     'sol': ['7.1 Obsah lichoběžníku $S_1=\\frac{3+6}{2}\\cdot|AE|=4{,}5\\cdot|AE|$; obsah trojúhelníku $S_2=\\frac{6}{2}\\cdot|AB|=3\\cdot|AB|$. Z $S_1=S_2$ plyne $|AE|:|AB|=3:4{,}5=2:3$.',
             '7.2 $BE=AE+AB=15$ cm se dělí v poměru $2:3$ (5 dílů), díl $=3$ cm, tedy $|AB|=9$ cm. $S_2=\\frac{6\\cdot 9}{2}=27$ cm² a $S_1=S_2=27$ cm². Obsah $BCDE=S_1+S_2=54$ cm².'],
     'ans': '7.1: $2:3$; 7.2: $54$ cm²', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2026 – úloha 8 (konstrukce)',
     'zad': ['V rovině leží přímka $p$ a body $B$, $D$ (viz obrázek). Body $B$, $D$ jsou vrcholy čtverce $BCDE$. Vrchol $C$ tohoto čtverce má od přímky $p$ větší vzdálenost než bod $B$.',
             '8.1 Sestrojte vrcholy $C$, $E$ čtverce $BCDE$, označte je písmeny a čtverec narýsujte.',
             '8.2 Body $B$, $C$, $D$ jsou zároveň vrcholy lichoběžníku $ABCD$. Vrchol $A$ tohoto lichoběžníku leží na přímce $p$. Sestrojte vrchol $A$ lichoběžníku $ABCD$, označte ho písmenem a lichoběžník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'primka-p-body-BD.svg',
     'alt': 'Přímka p a body B, D ležící v rovině vpravo od přímky.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['8.1 $B$ a $D$ jsou protější vrcholy (úhlopříčka) čtverce. Střed $S$ je střed úsečky $BD$; vrcholy $C$, $E$ leží na ose úsečky $BD$ ve vzdálenosti $\\frac{1}{2}|BD|$ od $S$. Z obou průsečíků je $C$ ten vzdálenější od přímky $p$, druhý je $E$.',
             '8.2 Vrchol $A$ leží na přímce $p$ a doplňuje $B$, $C$, $D$ na lichoběžník (jedna dvojice stran je rovnoběžná). Vede k dvěma řešením $A_1$, $A_2$ (viz náčrt v klíči).'],
     'ans': 'Čtverec $BCDE$ nad úhlopříčkou $BD$ ($C$, $E$ na ose úsečky $BD$, $C$ dál od přímky $p$); lichoběžník $ABCD$ s vrcholem $A$ na přímce $p$ má dvě řešení $A_1$, $A_2$ – viz náčrt v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2026 – úloha 9 (konstrukce)',
     'zad': ['V rovině leží body $D$, $S$, $U$ (viz obrázek). Bod $D$ je vrchol obdélníku $ABCD$. Bod $S$ je střed kružnice $k$, na níž leží všechny vrcholy tohoto obdélníku. Bodem $U$ prochází přímka $u$, na které leží vrcholy $A$, $C$ obdélníku $ABCD$.',
             'Sestrojte kružnici $k$ a vrcholy $A$, $B$, $C$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-D-S-U.svg',
     'alt': 'Body D, S a U ležící v rovině.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Kružnice $k$ má střed $S$ a poloměr $|SD|$. Úhlopříčka $AC$ prochází středem $S$, proto přímka $u$ prochází body $U$ a $S$; její průsečíky s kružnicí $k$ jsou vrcholy $A$ a $C$. Vrchol $B$ je obrazem $D$ ve středové souměrnosti se středem $S$ (bod $B$ leží na kružnici $k$ naproti $D$).'],
     'ans': 'Kružnice $k$ se středem $S$ a poloměrem $|SD|$; $A$, $C$ jsou průsečíky přímky $US$ s kružnicí $k$; $B$ je bod souměrný s $D$ podle středu $S$ – viz náčrt v klíči.',
     'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2026 – úloha 10',
     'zad': ['Pavle je $17$ let. Od $12$ let si vždy v den narozenin zapisuje svou výšku v celých cm. V grafu jsou zaznamenány tři z těchto zapsaných výšek, zbývající tři údaje chybí. Během tří let od $12$. do $15$. narozenin povyrostla Pavla každým rokem o stejný počet cm. Pavlina výška v den jejích $16$. narozenin je aritmetickým průměrem výšek zapsaných ve dnech $15$. a $17$. narozenin.',
             'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), nebo nepravdivé (N).',
             '10.1 Od $15$. do $17$. narozenin vyrostla Pavla celkem o $5$ cm.',
             '10.2 V den $14$. narozenin měřila Pavla $167$ cm.',
             '10.3 Aritmetický průměr všech šesti výšek, které si Pavla zapsala, je $167$ cm.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'graf-vyska.svg',
     'alt': 'Sloupcový graf výšek v cm od 12 do 17 let; zapsané hodnoty 13 let 163 cm, 16 let 171 cm, 17 let 173 cm, ostatní chybí.',
     'cap': 'Zapsané výšky Pavly (cm)',
     'sol': ['Výška v $16$ letech $=171=\\frac{v_{15}+173}{2}\\Rightarrow v_{15}=169$. Od $12$ do $15$ stejný přírůstek $d$: $v_{15}-v_{13}=2d=169-163=6\\Rightarrow d=3$. Výšky: $160,163,166,169,171,173$.',
             '10.1 Od $15$ do $17$: $173-169=4$ cm, ne $5$ → Ne.',
             '10.2 V $14$ letech $166$ cm, ne $167$ → Ne.',
             '10.3 Průměr $\\frac{160+163+166+169+171+173}{6}=\\frac{1002}{6}=167$ cm → Ano.'],
     'ans': '10.1: Ne; 10.2: Ne; 10.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2026 – úloha 11',
     'zad': ['Děti, které se účastnily soutěže, se měly rozdělit do stejně početných skupin. Když se rozdělily do trojic, jedno z dětí zbylo. Když se však rozdělily do pětic, nikdo nezbyl. Počet dětmi vytvořených pětic byl o $9$ menší než počet trojic.',
             'Kolik pětic děti vytvořily?'],
     'opts': ['A) $11$ pětic', 'B) $12$ pětic', 'C) $13$ pětic', 'D) $14$ pětic', 'E) jiný počet pětic'],
     'ln': 0,
     'sol': ['Nechť je $p$ pětic (počet dětí $5p$) a $t$ trojic. Platí $5p=3t+1$ a $p=t-9$, tedy $t=p+9$. Dosazením $5p=3(p+9)+1\\Rightarrow 2p=28\\Rightarrow p=14$ (dětí $70$; $70=3\\cdot 23+1$).'],
     'ans': 'D) $14$ pětic', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2026 – úloha 12',
     'zad': ['Pepa na modelářském kroužku pracoval bez odpočinku po celou dobu. První pětinu celkové doby tvořil model letadla a čtvrtinu zbývající doby pomáhal kamarádovi. Pak až do konce kroužku barvil vytvořené modely letadel, což mu zabralo přesně $60$ minut.',
             'Kolik minut pracoval Pepa na modelářském kroužku?'],
     'opts': ['A) méně než $75$ minut', 'B) $75$ minut', 'C) $100$ minut', 'D) $120$ minut', 'E) více než $120$ minut'],
     'ln': 0,
     'sol': ['Celková doba $T$. Model letadla $\\frac{1}{5}T$, pomoc kamarádovi $\\frac{1}{4}\\cdot\\frac{4}{5}T=\\frac{1}{5}T$. Barvení $=T-\\frac{1}{5}T-\\frac{1}{5}T=\\frac{3}{5}T=60$ min $\\Rightarrow T=100$ min.'],
     'ans': 'C) $100$ minut', 'pts': 2, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2026 – úloha 13',
     'zad': ['Květa si koupila čtyřdílný román. První díl románu byl o $30\\,\\%$ levnější než druhý díl a třetí díl byl o $30\\,\\%$ dražší než druhý díl. Čtvrtý díl stojí běžně $680$ korun, ale Květa ho sehnala v akci za $40\\,\\%$ běžné ceny, a tak za něj zaplatila stejně jako za první a třetí díl dohromady.',
             'Kolik korun stál druhý díl románu?'],
     'opts': ['A) $172$ korun', 'B) $170$ korun', 'C) $160$ korun', 'D) $142$ korun', 'E) $136$ korun'],
     'ln': 0,
     'sol': ['Druhý díl $x$. První $0{,}7x$, třetí $1{,}3x$, dohromady $2x$. Čtvrtý díl v akci $0{,}4\\cdot 680=272$ Kč $=2x\\Rightarrow x=136$ Kč.'],
     'ans': 'E) $136$ korun', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7D 2026 – úloha 14',
     'zad': ['Na obrázku je síť hranolu, který má podstavy tvaru kosočtverce a boční stěny tvaru čtverce. Obsah jedné podstavy je $15$ cm². Součet délek všech hran hranolu je $60$ cm.',
             'Jaký je objem hranolu?'],
     'opts': ['A) $60$ cm³', 'B) $75$ cm³', 'C) $90$ cm³', 'D) $105$ cm³', 'E) jiný objem'],
     'ln': 0, 'svg': SVG14, 'fn': 'sit-hranolu.svg',
     'alt': 'Síť hranolu s podstavami tvaru kosočtverce a bočními stěnami tvaru čtverce (schematicky).',
     'cap': 'Schematický nákres sítě hranolu',
     'sol': ['Boční stěny jsou čtverce, proto výška hranolu $=$ hraně podstavy $a$. Hranol má $12$ hran stejné délky $a$: $12a=60\\Rightarrow a=5$ cm. Objem $=$ obsah podstavy $\\times$ výška $=15\\cdot 5=75$ cm³.'],
     'ans': 'B) $75$ cm³', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2026 – úloha 15',
     'zad': ['Tabulka udává počty žáků gymnázia, kteří se zúčastnili jednotlivých sportovních kurzů. Některé údaje v tabulce chybí. Vodácký kurz má celkem $28$ účastníků, turistický kurz $30$ účastníků a cyklistického kurzu se zúčastnilo $14$ chlapců (viz tabulka).',
             'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 Z celkového počtu účastníků vodáckého kurzu bylo $75\\,\\%$ chlapců. Kolik dívek se zúčastnilo vodáckého kurzu?',
             '15.2 Turistického kurzu se zúčastnilo o $50\\,\\%$ více dívek než chlapců. O kolik méně chlapců než dívek se zúčastnilo turistického kurzu?',
             '15.3 Na cyklistický kurz se přihlásilo $16$ dívek. Některé z nich se však tohoto kurzu nezúčastnily. Dívky tak nakonec tvořily pouze $44\\,\\%$ účastníků cyklistického kurzu. Kolik dívek přihlášených na cyklistický kurz se kurzu nezúčastnilo?'],
     'opts': ['A) $5$', 'B) $6$', 'C) $7$', 'D) $8$', 'E) $9$', 'F) jiný počet'],
     'ln': 0, 'svg': SVG15, 'fn': 'tabulka-kurzy.svg',
     'alt': 'Tabulka počtů účastníků kurzů: vodácký celkem 28, turistický celkem 30, cyklistický chlapci 14; ostatní údaje chybí.',
     'cap': 'Počty účastníků sportovních kurzů',
     'sol': ['15.1 Chlapci $75\\,\\%$, dívky $25\\,\\%$ z $28$: $\\frac{28}{4}=7$ dívek → C.',
             '15.2 Dívky $=1{,}5\\cdot$ chlapci, dohromady $30$: chlapci $12$, dívky $18$; rozdíl $6$ → B.',
             '15.3 Chlapci $14=56\\,\\%$ účastníků, celkem $\\frac{14}{0{,}56}=25$; dívek účastnilo $25-14=11$; z $16$ přihlášených se nezúčastnilo $16-11=5$ → A.'],
     'ans': '15.1: C ($7$ dívek); 15.2: B (o $6$ méně); 15.3: A ($5$ dívek)', 'pts': 6, 'mins': 9, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2026 – úloha 16',
     'zad': ['Vědomostní hra má $10$ kol. Hráč má na začátku hry celkem $10$ žetonů a postupně může odpovědět na $5$ lehčích a na $5$ těžších otázek. V každém kole si může koupit pouze $1$ otázku a zaplatí za ni $1$ žeton. Pokud hráč kolo vynechá (otázku si nekoupí), žeton mu zůstane. Za správnou odpověď na lehčí otázku získá hráč $2$ žetony, za správnou odpověď na těžší otázku $3$ žetony. Za chybnou odpověď žádný žeton nezíská. (Např. hráč, který $3$ kola vynechal a ze $7$ zakoupených otázek správně odpověděl pouze na $1$ lehčí, měl na konci hry celkem $5$ žetonů.)',
             '16.1 Určete, kolik nejvíce žetonů může mít hráč na konci hry.',
             '16.2 Hráč vynechal pouze $1$ kolo a ve zbývajících kolech získal za odpovědi na lehčí otázky o $3$ žetony více než za odpovědi na těžší otázky. Určete, kolik žetonů měl hráč na konci hry.',
             '16.3 Hráč měl na konci hry $10$ žetonů a přitom měl největší možný počet chybných odpovědí s tímto výsledkem. Určete, kolikrát v této hře správně odpověděl na lehčí otázku. Uveďte všechna řešení.'],
     'opts': None, 'ln': 3,
     'sol': ['16.1 Koupí všech $10$ otázek (zaplatí $10$ žetonů) a odpoví správně: $5\\cdot 2+5\\cdot 3=25$. Celkem $10-10+25=25$ žetonů.',
             '16.2 Koupil $9$ otázek; správné lehčí $e$ ($2e$ žet.), správné těžší $h$ ($3h$ žet.), $2e-3h=3$. Jediné řešení v mezích $e=3$, $h=1$. Konec $=10-9+2\\cdot 3+3\\cdot 1=10$ žetonů.',
             '16.3 Konec $10\\Rightarrow$ počet koupených $=2e+3h$. Chybných $=(2e+3h)-e-h=e+2h$; maximum $6$ dosáhnou dvě možnosti: $e=0,h=3$ a $e=2,h=2$. Lehčích správně tedy $0$, nebo $2$.'],
     'ans': '16.1: $25$ žetonů; 16.2: $10$ žetonů; 16.3: ani jednou; dvakrát', 'pts': 4, 'mins': 9, 'diff': '4',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PDD26C0T04'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7D-2026')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
