# -*- coding: utf-8 -*-
# CERMAT - Prijimacky nanecisto 2026, MATEMATIKA 9 (ctyrlete obory, 9. rocnik).
# Kod testu: M9PND26C0T01. 16 uloh, 50 bodu (5 uzavrenych, 11 otevrenych).
# Po rozdeleni nezavislych poduloh ("Vypoctete"/uprava vyrazu/rovnice) -> 21 uloh.
# Zdroj odpovedi: klic spravnych reseni (KSR).

# ---- SVG obrazky (bez ' a \) ----

# uloha 8: trojuhelnikova sit - utvary A, B, C (schematicka poznamka)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 120" font-family="sans-serif">
<text x="260" y="45" font-size="13" text-anchor="middle">Tri utvary A, B, C z tmavych rovnostrannych trojuhelniku v trojuhelnikove siti (viz testovy sesit).</text>
<text x="260" y="80" font-size="11" text-anchor="middle" fill="#666">Trojuhelnikovou sit nelze verne prenest do SVG; posuzuje se podle originalu.</text>
</svg>"""

# uloha 9: bod E a primka p
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 240" font-family="sans-serif">
<line x1="60" y1="185" x2="410" y2="120" stroke="#000" stroke-width="2"/>
<text x="70" y="205" font-size="16" font-style="italic">p</text>
<text x="252" y="95" font-size="16" font-style="italic">E</text>
<text x="247" y="112" font-size="16">x</text>
</svg>"""

# uloha 10: body A, B, M
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif">
<text x="170" y="150" font-size="16">x</text><text x="166" y="138" font-size="16" font-style="italic">M</text>
<text x="410" y="140" font-size="16">x</text><text x="408" y="128" font-size="16" font-style="italic">B</text>
<text x="250" y="235" font-size="16">x</text><text x="248" y="255" font-size="16" font-style="italic">A</text>
</svg>"""

# uloha 11: skupinovy sloupcovy graf (Adam, Ben, Cyril; sobota tmava, nedele svetla)
# hodnoty v dilcich osy: Adam (2,4), Ben (5,3), Cyril (3,7)
def _graf():
    unit = 28; base = 290; x0 = 70; bw = 26; gap = 8; grp = 60
    data = [('Adam', 2, 4), ('Ben', 5, 3), ('Cyril', 3, 7)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 340" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="40" x2="{x0}" y2="{base}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{base}" x2="490" y2="{base}" stroke="#000"/>')
    for i in range(1, 8):
        y = base - i * unit
        s.append(f'<line x1="{x0}" y1="{y}" x2="480" y2="{y}" stroke="#e0e0e0"/>')
    s.append(f'<text x="{x0-8}" y="{base+4}" font-size="12" text-anchor="end">0</text>')
    x = x0 + 40
    for name, so, ne in data:
        hs = so * unit; hn = ne * unit
        s.append(f'<rect x="{x}" y="{base-hs}" width="{bw}" height="{hs}" fill="#555" stroke="#000"/>')
        s.append(f'<rect x="{x+bw+gap}" y="{base-hn}" width="{bw}" height="{hn}" fill="#d8d8d8" stroke="#000"/>')
        s.append(f'<text x="{x+bw+gap//2}" y="{base+18}" font-size="13" text-anchor="middle">{name}</text>')
        x += grp + bw + gap + 18
    s.append('<text x="24" y="175" font-size="12" text-anchor="middle" transform="rotate(-90 24 175)">Ujeta vzdalenost v km</text>')
    s.append('<rect x="150" y="315" width="12" height="12" fill="#555" stroke="#000"/><text x="168" y="325" font-size="12">Sobota</text>')
    s.append('<rect x="250" y="315" width="12" height="12" fill="#d8d8d8" stroke="#000"/><text x="268" y="325" font-size="12">Nedele</text>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _graf()

# uloha 12: kvadr s pulvalcovou prohlubni (schematicky)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" font-family="sans-serif">
<polygon points="40,70 180,70 230,40 90,40" fill="#e6e6e6" stroke="#000"/>
<polygon points="40,70 40,160 180,160 180,70" fill="#d0d0d0" stroke="#000"/>
<polygon points="180,70 230,40 230,130 180,160" fill="#bcbcbc" stroke="#000"/>
<path d="M85 70 a25 22 0 0 0 50 0" fill="#f2f2f2" stroke="#000"/>
<line x1="110" y1="70" x2="110" y2="108" stroke="#000" stroke-dasharray="2 3"/>
<text x="14" y="120" font-size="12">2 cm</text>
<text x="100" y="178" font-size="12">2 cm</text>
<text x="194" y="140" font-size="12">4 cm</text>
<text x="116" y="98" font-size="12">1 cm</text>
</svg>"""

# uloha 13: pravouhly trojuhelnik ABC (pravy uhel u C, AC=16, AB=20)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 220" font-family="sans-serif">
<polygon points="60,180 320,180 250,60" fill="none" stroke="#000" stroke-width="2"/>
<path d="M238 72 L248 85 L259 77" fill="none" stroke="#000" stroke-width="1"/>
<text x="46" y="196" font-size="15" font-style="italic">A</text>
<text x="326" y="196" font-size="15" font-style="italic">B</text>
<text x="250" y="52" font-size="15" font-style="italic">C</text>
<text x="132" y="112" font-size="13">16 cm</text>
<text x="178" y="198" font-size="13">20 cm</text>
</svg>"""

# uloha 14: kosoctverec ABCD, uhlopricky, stred S, X stred BC, uhel 20 stupnu
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif">
<polygon points="120,210 300,210 360,90 180,90" fill="none" stroke="#000" stroke-width="2"/>
<line x1="120" y1="210" x2="360" y2="90" stroke="#000"/>
<line x1="300" y1="210" x2="180" y2="90" stroke="#000"/>
<line x1="240" y1="150" x2="330" y2="150" stroke="#000"/>
<circle cx="240" cy="150" r="2.5" fill="#000"/>
<circle cx="330" cy="150" r="2.5" fill="#000"/>
<text x="106" y="224" font-size="14" font-style="italic">A</text>
<text x="300" y="228" font-size="14" font-style="italic">B</text>
<text x="366" y="86" font-size="14" font-style="italic">C</text>
<text x="162" y="86" font-size="14" font-style="italic">D</text>
<text x="226" y="166" font-size="13" font-style="italic">S</text>
<text x="337" y="150" font-size="13" font-style="italic">X</text>
<text x="270" y="140" font-size="12">20 st.</text>
<text x="196" y="114" font-size="13" font-style="italic">f</text>
</svg>"""

# uloha 16: rostouci pravouhle trojuhelniky se spolecnym vrcholem A (schematicky)
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 220" font-family="sans-serif">
<line x1="40" y1="180" x2="430" y2="180" stroke="#000"/>
<line x1="40" y1="180" x2="410" y2="42" stroke="#000"/>
<polygon points="40,180 250,180 250,102" fill="#dcdcdc" stroke="#000"/>
<line x1="310" y1="180" x2="310" y2="80" stroke="#000"/>
<line x1="360" y1="180" x2="360" y2="61" stroke="#000"/>
<text x="34" y="196" font-size="13" font-style="italic">A</text>
<text x="245" y="196" font-size="13" font-style="italic">B</text>
<text x="302" y="196" font-size="12" font-style="italic">B1</text>
<text x="352" y="196" font-size="12" font-style="italic">B2</text>
<text x="256" y="100" font-size="13" font-style="italic">C</text>
<text x="316" y="78" font-size="12" font-style="italic">C1</text>
<text x="366" y="58" font-size="12" font-style="italic">C2</text>
<text x="120" y="150" font-size="12">13 cm</text>
<text x="140" y="196" font-size="12">12 cm</text>
<text x="258" y="148" font-size="12">5 cm</text>
<text x="382" y="70" font-size="16">...</text>
</svg>"""

B = ['zs2', 'r9']  # 9. rocnik ZS (prijimacky na ctyrlete obory)

PROBLEMS = [
    {'name': 'CERMAT M9 nanečisto 2026 – úloha 1',
     'zad': ['Vypočtěte druhou mocninu součtu prvního, druhého a třetího nejmenšího prvočísla.'],
     'opts': None, 'ln': 2,
     'sol': ['První tři nejmenší prvočísla jsou $2$, $3$, $5$. Součet je $2+3+5=10$, jeho druhá mocnina je $10^2=100$.'],
     'ans': '$100$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 2.1',
     'zad': ['Vypočtěte: $-5\\cdot 5+(-12)^2-13^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$-25+144-169=-50$.'],
     'ans': '$-50$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 2.2',
     'zad': ['Vypočtěte: $\\sqrt{1-0{,}8^2}:6=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\sqrt{1-0{,}64}:6=\\sqrt{0{,}36}:6=0{,}6:6=0{,}1$.'],
     'ans': '$0{,}1$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
             '$-\\frac{5}{24}+\\frac{5}{24}\\cdot\\frac{7}{3}=$'],
     'opts': None, 'ln': 2,
     'sol': ['Nejprve násobení: $\\frac{5}{24}\\cdot\\frac{7}{3}=\\frac{35}{72}$. Pak $-\\frac{15}{72}+\\frac{35}{72}=\\frac{20}{72}=\\frac{5}{18}$.'],
     'ans': '$\\frac{5}{18}$', 'pts': 1, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru (uveďte celý postup řešení):',
             '$\\frac{\\left(\\frac{125}{21}\\cdot\\frac{7}{25}-9\\right):4}{11}=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\frac{125}{21}\\cdot\\frac{7}{25}=\\frac{5}{3}$; $\\frac{5}{3}-9=-\\frac{22}{3}$; $-\\frac{22}{3}:4=-\\frac{22}{12}=-\\frac{11}{6}$; $-\\frac{11}{6}:11=-\\frac{1}{6}$.'],
     'ans': '$-\\frac{1}{6}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 4.1',
     'zad': ['Upravte a rozložte na součin vytknutím:', '$3y\\cdot(x+3y)-y=$'],
     'opts': None, 'ln': 2,
     'sol': ['$3xy+9y^2-y=y\\cdot(3x+9y-1)$.'],
     'ans': '$y\\cdot(3x+9y-1)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 4.2',
     'zad': ['Upravte a rozložte na součin užitím vzorce:', '$n\\cdot(9n-1)+n-4=$'],
     'opts': None, 'ln': 2,
     'sol': ['$9n^2-n+n-4=9n^2-4=(3n)^2-2^2=(3n-2)(3n+2)$.'],
     'ans': '$(3n-2)(3n+2)$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 4.3',
     'zad': ['Upravte na co nejjednodušší tvar bez závorek (uveďte celý postup řešení):',
             '$4\\cdot(2x\\cdot x-x)-3+(2x+1)(3-4x)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$4(2x^2-x)=8x^2-4x$; $(2x+1)(3-4x)=-8x^2+2x+3$. Součet: $8x^2-4x-3-8x^2+2x+3=-2x$.'],
     'ans': '$-2x$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 5.1',
     'zad': ['Řešte rovnici (uveďte celý postup řešení):',
             '$3\\cdot\\left(4-\\frac{3}{4}x\\right)+x=1-\\frac{5}{4}x$'],
     'opts': None, 'ln': 3,
     'sol': ['Levá strana: $12-\\frac{9}{4}x+x=12-\\frac{5}{4}x$. Rovnice $12-\\frac{5}{4}x=1-\\frac{5}{4}x$ vede na $12=1$, což neplatí. Rovnice nemá řešení.'],
     'ans': 'Rovnice nemá řešení.', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 5.2',
     'zad': ['Řešte soustavu rovnic (uveďte celý postup řešení):', '$2x-y=7$', '$x-2y=11$'],
     'opts': None, 'ln': 3,
     'sol': ['Z první rovnice $y=2x-7$. Dosazením: $x-2(2x-7)=11\\Rightarrow -3x+14=11\\Rightarrow x=1$. Pak $y=2\\cdot 1-7=-5$.'],
     'ans': '$x=1$; $y=-5$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 6',
     'zad': ['Klára si v řemeslné pekárně koupila několik tukových rohlíků a několik celozrnných housek. Dvě celozrnné housky stojí o 6 korun více než tři tukové rohlíky. Cenu jedné celozrnné housky v korunách označíme $h$.',
             '6.1 Vyjádřete výrazem s proměnnou $h$, kolik korun stojí tři tukové rohlíky.',
             '6.2 Vyjádřete výrazem s proměnnou $h$, kolik korun stojí jeden tukový rohlík.',
             '6.3 Klára zaplatila za 6 tukových rohlíků a 6 celozrnných housek celkem 78 korun. Vypočtěte, kolik korun stojí jedna celozrnná houska.'],
     'opts': None, 'ln': 4,
     'sol': ['6.1 Dvě housky stojí $2h$, tři rohlíky o 6 korun méně: tři rohlíky stojí $2h-6$ korun.',
             '6.2 Jeden rohlík stojí $\\frac{2h-6}{3}$ korun.',
             '6.3 $6\\cdot\\frac{2h-6}{3}+6h=78\\Rightarrow 2(2h-6)+6h=78\\Rightarrow 10h-12=78\\Rightarrow h=9$. Houska stojí 9 korun.'],
     'ans': '6.1: $2h-6$; 6.2: $\\frac{2h-6}{3}$; 6.3: $9$ korun', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 7',
     'zad': ['Naši zakázku vyrábí několik automatů. Automaty vždy pracují společně stálým a navzájem stejným tempem. Kdyby pracovalo 12 automatů, vyrobí naši zakázku přesně za 60 hodin.',
             '7.1 Vypočtěte, za kolik hodin vyrobí naši zakázku 20 automatů.',
             '7.2 Vyjádřete zlomkem v základním tvaru, jakou část naší zakázky vyrobí 5 automatů za 24 hodin.',
             '7.3 Čtvrtinu naší zakázky vyrobilo 15 automatů, zbytek zakázky dokončilo 18 automatů. Vypočtěte, kolik hodin trvala výroba celé naší zakázky.'],
     'opts': None, 'ln': 4,
     'sol': ['Celková práce je $12\\cdot 60=720$ automatohodin.',
             '7.1 $720:20=36$ hodin.',
             '7.2 $5\\cdot 24=120$ automatohodin, tj. $\\frac{120}{720}=\\frac{1}{6}$ zakázky.',
             '7.3 Čtvrtina $=180$ automatohodin, $180:15=12$ hodin; zbytek $540$ automatohodin, $540:18=30$ hodin. Celkem $12+30=42$ hodin.'],
     'ans': '7.1: $36$ hodin; 7.2: $\\frac{1}{6}$ zakázky; 7.3: $42$ hodin', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 8',
     'zad': ['Trojúhelníková síť se skládá z rovnostranných trojúhelníků. V této síti jsou z tmavých trojúhelníků složeny tři útvary A, B, C (viz testový sešit). V každém útvaru buď přesuneme, nebo odebereme vždy pouze jeden tmavý trojúhelník tak, aby vznikl osově souměrný nebo středově souměrný útvar. V jednotlivých útvarech je každý tmavý trojúhelník označen číslem. Například z útvaru A vznikne osově souměrný útvar odebráním trojúhelníku 9.',
             '8.1 Určete číslo trojúhelníku, jehož odebráním vznikne z útvaru B osově souměrný útvar.',
             '8.2 Určete číslo trojúhelníku, jehož přesunutím vznikne z útvaru C středově souměrný útvar. Najděte všechna řešení.'],
     'opts': None, 'ln': 2, 'svg': SVG8, 'fn': 'sit-utvary.svg',
     'alt': 'Tři útvary A, B, C složené z tmavých rovnostranných trojúhelníků v trojúhelníkové síti (schematická poznámka).',
     'cap': 'Útvary A, B, C – viz testový sešit',
     'sol': ['8.1 Odebráním trojúhelníku číslo 5 se z útvaru B stane osově souměrný útvar.',
             '8.2 Přesunutím trojúhelníku číslo 3 nebo číslo 14 vznikne z útvaru C středově souměrný útvar.'],
     'ans': '8.1: $5$; 8.2: $3$ a $14$', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 9 (konstrukce)',
     'zad': ['V rovině leží bod $E$ a přímka $p$ (viz obrázek).',
             'Bod $E$ je vrchol pravidelného šestiúhelníku $ABCDEF$. Na přímce $p$ leží vrcholy $D$, $F$ tohoto šestiúhelníku.',
             'Sestrojte vrcholy $A$, $B$, $C$, $D$, $F$ pravidelného šestiúhelníku $ABCDEF$, označte je písmeny a šestiúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'bod-E-primka-p.svg',
     'alt': 'Bod E označený křížkem a mírně stoupající přímka p pod ním.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Vrcholy $D$ a $F$ sousedí s vrcholem $E$, leží na přímce $p$ a platí $|ED|=|EF|$ (strana šestiúhelníku), vnitřní úhel při vrcholu $E$ je $120^\\circ$. Pata kolmice $M$ z bodu $E$ na přímku $p$ je střed úsečky $DF$; přitom $|EM|$ je polovina strany, takže strana $=2\\cdot|EM|$ a body $D$, $F$ naneseme na $p$ ve vzdálenosti $|EM|\\cdot\\sqrt{3}$ od $M$. Střed šestiúhelníku $S$ leží na kolmici pod $M$ ve vzdálenosti $|EM|$; opíšeme kružnici se středem $S$ a poloměrem $|SE|$ a doplníme vrcholy $A$, $B$, $C$.'],
     'ans': 'Konstrukce pravidelného šestiúhelníku $ABCDEF$: vrcholy $D$, $F$ na přímce $p$ souměrně kolem paty kolmice z $E$, střed $S$ a opsaná kružnice, doplnění vrcholů $A$, $B$, $C$ (viz obrázek v klíči).',
     'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 10 (konstrukce)',
     'zad': ['V rovině leží body $A$, $B$, $M$ (viz obrázek).',
             'Úsečka $AB$ je strana rovnoběžníku $ABCD$. Na přímce $BM$ leží vrchol $D$ tohoto rovnoběžníku. Úhlopříčka $AC$ rovnoběžníku $ABCD$ má délku 6 cm.',
             '10.1 Sestrojte střed $S$ rovnoběžníku $ABCD$ a označte ho písmenem.',
             '10.2 Sestrojte vrcholy $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'body-A-B-M.svg',
     'alt': 'Tři body A, B, M označené křížky v rovině.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Střed $S$ je společný střed úhlopříček, tedy střed úsečky $AC$, proto $|AS|=3$ cm. Zároveň $S$ je střed úsečky $BD$; protože $D$ leží na přímce $BM$, leží i $S$ na přímce $BM$. Bod $S$ je tedy průsečík přímky $BM$ s kružnicí se středem $A$ a poloměrem 3 cm — vzniknou dvě polohy $S_1$, $S_2$. Vrchol $C$ je obrazem bodu $A$ ve středové souměrnosti podle $S$, vrchol $D$ obrazem bodu $B$. Úloha má dvě řešení.'],
     'ans': 'Dvě řešení. Střed $S$ je průsečík přímky $BM$ s kružnicí se středem $A$ a poloměrem $3$ cm; $C$ a $D$ jsou obrazy bodů $A$ a $B$ ve středové souměrnosti podle $S$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 11',
     'zad': ['Graf udává délky tréninkových tras tří cyklistů (Adam, Ben, Cyril) během dvou víkendových dní; tmavé sloupce jsou sobota, světlé neděle. Všechny díly na svislé ose jsou stejné. Za celý víkend ujel Adam o 45 km méně než Ben.',
             'Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
             '11.1 Vzdálenosti, které za celý víkend ujeli Adam, Ben a Cyril (v tomto pořadí), jsou v poměru $3:4:5$.',
             '11.2 V neděli ujel Cyril o 40 % delší trasu než Adam.',
             '11.3 Ben ujel v sobotu méně než 100 km.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'graf-cykliste.svg',
     'alt': 'Skupinový sloupcový graf ujetých vzdáleností Adama, Bena a Cyrila v sobotu a v neděli.',
     'cap': 'Ujeté vzdálenosti (díly svislé osy jsou stejné)',
     'sol': ['V dílech osy: Adam $2+4=6$, Ben $5+3=8$, Cyril $3+7=10$.',
             '11.1 $6:8:10=3:4:5$ — pravda (A).',
             'Rozdíl Ben a Adam je $8-6=2$ díly $=45$ km, tedy $1$ díl $=22{,}5$ km (Adam $135$ km, Ben $180$ km, Cyril $225$ km).',
             '11.2 Cyril v neděli $7$ dílů, Adam v neděli $4$ díly; $7=1{,}75\\cdot 4$, tj. o $75$ % více, ne o $40$ % — nepravda (N).',
             '11.3 Ben v sobotu $5$ dílů $=112{,}5$ km, což není méně než $100$ km — nepravda (N).'],
     'ans': '11.1: Ano; 11.2: Ne; 11.3: Ne', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 12',
     'zad': ['V kvádru o rozměrech 2 cm, 4 cm a 2 cm byla vytvořena prohlubeň vyříznutím poloviny válce s podstavou o poloměru 1 cm (viz obrázek).',
             'Jaký je objem tělesa s prohlubní? Ve výpočtu použijte $\\pi\\doteq 3{,}14$.'],
     'opts': ['A) $3{,}44$ cm³', 'B) $9{,}72$ cm³', 'C) $10{,}72$ cm³', 'D) $12{,}56$ cm³', 'E) jiný objem'],
     'ln': 0, 'svg': SVG12, 'fn': 'kvadr-prohluben.svg',
     'alt': 'Kvádr 2 cm krát 4 cm krát 2 cm s půlválcovou prohlubní o poloměru 1 cm podél delší hrany.',
     'cap': 'Schematický nákres tělesa s prohlubní',
     'sol': ['Objem kvádru $2\\cdot 4\\cdot 2=16$ cm³. Odebraný půlválec má poloměr $1$ cm a délku $4$ cm: $\\frac{1}{2}\\pi r^2\\cdot 4=\\frac{1}{2}\\cdot 3{,}14\\cdot 1\\cdot 4=6{,}28$ cm³. Těleso s prohlubní: $16-6{,}28=9{,}72$ cm³.'],
     'ans': 'B) $9{,}72$ cm³', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 13',
     'zad': ['V pravoúhlém trojúhelníku $ABC$ s pravým úhlem u vrcholu $C$ má odvěsna $AC$ délku 16 cm a přepona $AB$ délku 20 cm.',
             'Jaký je obsah trojúhelníku $ABC$?'],
     'opts': ['A) $96$ cm²', 'B) $104$ cm²', 'C) $112$ cm²', 'D) $120$ cm²', 'E) více než $120$ cm²'],
     'ln': 0, 'svg': SVG13, 'fn': 'trojuhelnik-ABC.svg',
     'alt': 'Pravoúhlý trojúhelník ABC s pravým úhlem u vrcholu C, odvěsnou AC 16 cm a přeponou AB 20 cm.',
     'cap': 'Pravoúhlý trojúhelník ABC',
     'sol': ['Druhá odvěsna $BC=\\sqrt{20^2-16^2}=\\sqrt{400-256}=\\sqrt{144}=12$ cm. Obsah $=\\frac{1}{2}\\cdot 16\\cdot 12=96$ cm².'],
     'ans': 'A) $96$ cm²', 'pts': 2, 'mins': 4, 'diff': '2',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 14',
     'zad': ['Je dán kosočtverec $ABCD$ se středem $S$. Bod $X$ je střed strany $BC$ tohoto kosočtverce. Velikost úhlu $CSX$ je $20^\\circ$ (viz obrázek).',
             'Jaká je velikost $\\varphi$ úhlu $ADB$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) méně než $40^\\circ$', 'B) $40^\\circ$', 'C) $50^\\circ$', 'D) $60^\\circ$', 'E) $70^\\circ$'],
     'ln': 0, 'svg': SVG14, 'fn': 'kosoctverec-ABCD.svg',
     'alt': 'Kosočtverec ABCD s úhlopříčkami protínajícími se ve středu S, bodem X ve středu strany BC a vyznačeným úhlem 20 stupňů.',
     'cap': 'Schematický nákres kosočtverce (obrázek je ilustrativní)',
     'sol': ['Úhlopříčky kosočtverce jsou kolmé, trojúhelník $BSC$ je pravoúhlý s pravým úhlem u $S$. Bod $X$ je střed přepony $BC$, proto $|XS|=|XC|$ a trojúhelník $XSC$ je rovnoramenný: úhel $SCX$ = úhel $XSC=20^\\circ$. Tedy úhel $ACB=20^\\circ$ a úhel $BCD=2\\cdot 20^\\circ=40^\\circ$. V trojúhelníku $BCD$ je úhel $DBC=90^\\circ-20^\\circ=70^\\circ$ a úhel $BCD=40^\\circ$, takže úhel $BDC=70^\\circ$. Úhlopříčka $DB$ půlí úhel $ADC$, proto $\\varphi=$ úhel $ADB=$ úhel $BDC=70^\\circ$.'],
     'ans': 'E) $70^\\circ$', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 Stejné sýry se prodávají v menších baleních po dvou sýrech a ve větších baleních po třech sýrech. Menší balení stojí 100 korun, větší balení 123 korun. O kolik procent je jeden sýr ve větším balení levnější než jeden sýr v menším balení?',
             '15.2 V půjčovně se za půjčení každé lodě platí jednotná cena za každý den. Sportovní klub vybral peníze na půjčení 10 lodí na 5 dní. Z vybraných peněz klub dosud utratil jen část, a to za půjčení 2 lodí na 4 dny. Kolik procent vybraných peněz klub dosud utratil?',
             '15.3 Vítek šetří na nákup lyží. Našetřené peníze mu nyní vystačí buď na 92 % ceny loňského modelu lyží, nebo na 80 % ceny letošního modelu lyží. Loňský model lyží stojí 10 tisíc korun. O kolik procent je letošní model lyží dražší než loňský?'],
     'opts': ['A) méně než $15$ %', 'B) $15$ %', 'C) $16$ %', 'D) $18$ %', 'E) $19$ %', 'F) více než $19$ %'],
     'ln': 0,
     'sol': ['15.1 Menší balení: $1$ sýr $=100:2=50$ Kč; větší: $1$ sýr $=123:3=41$ Kč. Rozdíl $\\frac{50-41}{50}=0{,}18=18$ % → D.',
             '15.2 Vybráno na $10\\cdot 5=50$ loďodní, utraceno za $2\\cdot 4=8$ loďodní. $\\frac{8}{50}=0{,}16=16$ % → C.',
             '15.3 Peníze $=0{,}92\\cdot 10\\,000=9200$ Kč, což je $80$ % ceny letošního: letošní $=9200:0{,}8=11\\,500$ Kč. Nárůst $\\frac{11\\,500-10\\,000}{10\\,000}=15$ % → B.'],
     'ans': '15.1: D ($18$ %); 15.2: C ($16$ %); 15.3: B ($15$ %)', 'pts': 6, 'mins': 9, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M9 nanečisto 2026 – úloha 16',
     'zad': ['Na začátku promítání je na plátně zobrazen šedý pravoúhlý trojúhelník $ABC$ s odvěsnami 5 cm a 12 cm a přeponou 13 cm. V každém kroku se objeví nový větší pravoúhlý trojúhelník s vrcholem $A$ a přeponou na polopřímce $AC$; jeho delší odvěsna leží na polopřímce $AB$ a je vždy o 2 cm delší než v předchozím trojúhelníku. Poměr délek obou odvěsen je ve všech trojúhelnících stejný. V 1. kroku se objeví trojúhelník $AB_1C_1$, ve 2. kroku $AB_2C_2$ atd.',
             '16.1 Určete, v kolikátém kroku se objeví trojúhelník, v němž se délky obou odvěsen liší o 14 cm.',
             '16.2 Určete, kolik cm měří kratší odvěsna $B_{60}C_{60}$ trojúhelníku $AB_{60}C_{60}$, který se objeví v 60. kroku.',
             '16.3 Určete, v kolikátém kroku se objeví trojúhelník, jehož kratší odvěsna bude naposledy měřit méně než 300 cm.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'trojuhelniky-promitani.svg',
     'alt': 'Rostoucí pravoúhlé trojúhelníky se společným vrcholem A; přepony na jedné polopřímce, delší odvěsny na druhé.',
     'cap': 'Schematický nákres promítaných trojúhelníků',
     'sol': ['Delší odvěsna v $k$-tém kroku je $12+2k$ cm, kratší je $\\frac{5}{12}$ delší, tj. $\\frac{5}{12}(12+2k)$ cm.',
             '16.1 Rozdíl odvěsen $(12+2k)\\left(1-\\frac{5}{12}\\right)=\\frac{7}{12}(12+2k)=14\\Rightarrow 12+2k=24\\Rightarrow k=6$. V 6. kroku.',
             '16.2 Delší $=12+2\\cdot 60=132$ cm, kratší $=\\frac{5}{12}\\cdot 132=55$ cm.',
             '16.3 $\\frac{5}{12}(12+2k)<300\\Rightarrow 12+2k<720\\Rightarrow k<354$. Naposledy pro $k=353$ (kratší $\\doteq 299{,}2$ cm). V 353. kroku.'],
     'ans': '16.1: v 6. kroku; 16.2: $55$ cm; 16.3: v 353. kroku', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['posloupnosti', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PND26C0T01'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9NN-2026')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
