# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2019, MATEMATIKA 9 A (čtyřleté obory, 9. ročník), 1. řádný termín.
# Kód testu: M9PAD19C0T01. 16 úloh CERMAT (po rozdělení izolovaných "Vypočtěte/Zjednodušte/Řešte" podúloh 21 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR) M9PAD19C0T01; struktura ověřena v testovém sešitu (TS).

import math

# ---- SVG obrázky (bez ' a \) ----

# úloha 7: dvě dvojice ozubených koleček (šedé 15 z., bílá 24 z., černé < 24 z.)
def _gear(cx, cy, r, fill, label, txtcol):
    p = f'<circle cx="{cx}" cy="{cy}" r="{r}" fill="{fill}" stroke="#000" stroke-width="6" stroke-dasharray="7 5"/>'
    p += f'<circle cx="{cx}" cy="{cy}" r="{r-4}" fill="{fill}" stroke="#000" stroke-width="1"/>'
    if label:
        p += f'<text x="{cx}" y="{cy+5}" font-size="16" text-anchor="middle" fill="{txtcol}">{label}</text>'
    return p

SVG7 = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 210" font-family="sans-serif">'
        + _gear(95, 105, 36, '#bdbdbd', '15', '#000')
        + _gear(184, 105, 52, '#ffffff', '24', '#000')
        + '<text x="140" y="200" font-size="12" text-anchor="middle">1. dvojice</text>'
        + _gear(400, 105, 52, '#ffffff', '24', '#000')
        + _gear(490, 105, 38, '#333333', '', '#fff')
        + '<text x="450" y="200" font-size="12" text-anchor="middle">2. dvojice</text>'
        + '</svg>')

# úloha 8: úsečka AB (Iva, čárkovaně) a půlkružnice nad průměrem AB (Dan)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 230" font-family="sans-serif">
<line x1="60" y1="55" x2="300" y2="55" stroke="#000" stroke-width="2" stroke-dasharray="7 6"/>
<path d="M60 55 A120 120 0 0 0 300 55" fill="none" stroke="#000" stroke-width="2"/>
<circle cx="60" cy="55" r="3" fill="#000"/><circle cx="300" cy="55" r="3" fill="#000"/>
<text x="52" y="48" font-size="16" font-style="italic">A</text>
<text x="304" y="48" font-size="16" font-style="italic">B</text>
<line x1="178" y1="49" x2="182" y2="61" stroke="#000"/>
<line x1="350" y1="55" x2="390" y2="55" stroke="#000" stroke-width="2" stroke-dasharray="7 6"/>
<text x="398" y="60" font-size="13">Iva</text>
<line x1="350" y1="85" x2="390" y2="85" stroke="#000" stroke-width="2"/>
<text x="398" y="90" font-size="13">Dan</text>
</svg>"""

# úloha 9: přímka KL s body K, L
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 120" font-family="sans-serif">
<line x1="30" y1="70" x2="430" y2="70" stroke="#000" stroke-width="2"/>
<line x1="180" y1="63" x2="180" y2="77" stroke="#000" stroke-width="2"/>
<line x1="300" y1="63" x2="300" y2="77" stroke="#000" stroke-width="2"/>
<text x="176" y="95" font-size="16" font-style="italic">K</text>
<text x="296" y="95" font-size="16" font-style="italic">L</text>
</svg>"""

# úloha 10: přímka c a body B, D mimo ni
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 380" font-family="sans-serif">
<line x1="115" y1="115" x2="410" y2="185" stroke="#000" stroke-width="2"/>
<text x="120" y="105" font-size="16" font-style="italic">c</text>
<text x="150" y="235" font-size="16">×</text><text x="132" y="238" font-size="16" font-style="italic">D</text>
<text x="330" y="315" font-size="16">×</text><text x="348" y="320" font-size="16" font-style="italic">B</text>
</svg>"""

# úloha 11: tabulka (Dívky/Chlapci/Celkem; vyplněno pouze 9. A Celkem = 24)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 210" font-family="sans-serif">
<rect x="20" y="20" width="390" height="168" fill="none" stroke="#000"/>
<line x1="130" y1="20" x2="130" y2="188" stroke="#000"/>
<line x1="230" y1="20" x2="230" y2="188" stroke="#000"/>
<line x1="320" y1="20" x2="320" y2="188" stroke="#000"/>
<line x1="20" y1="62" x2="410" y2="62" stroke="#000"/>
<line x1="20" y1="104" x2="410" y2="104" stroke="#000"/>
<line x1="20" y1="146" x2="410" y2="146" stroke="#000"/>
<text x="180" y="47" font-size="14" text-anchor="middle">Dívky</text>
<text x="275" y="47" font-size="14" text-anchor="middle">Chlapci</text>
<text x="365" y="47" font-size="14" text-anchor="middle">Celkem</text>
<text x="75" y="89" font-size="14" text-anchor="middle">9. A</text>
<text x="75" y="131" font-size="14" text-anchor="middle">9. B</text>
<text x="75" y="173" font-size="14" text-anchor="middle">Celkem</text>
<text x="365" y="89" font-size="14" text-anchor="middle">24</text>
</svg>"""

# úloha 12: kosočtverec s trojúhelníkem; strana RM pokračuje přímo do B
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif">
<polygon points="110,55 365,45 300,165 45,175" fill="none" stroke="#000" stroke-width="2"/>
<line x1="45" y1="175" x2="248" y2="261" stroke="#000" stroke-width="2"/>
<line x1="300" y1="165" x2="248" y2="261" stroke="#000" stroke-width="2"/>
<text x="145" y="90" font-size="15">α + 24°</text>
<text x="300" y="200" font-size="14">68°</text>
<text x="240" y="250" font-size="15">α</text>
<line x1="235" y1="47" x2="240" y2="53" stroke="#000"/><line x1="240" y1="47" x2="245" y2="53" stroke="#000"/>
<line x1="330" y1="102" x2="337" y2="107" stroke="#000"/><line x1="335" y1="100" x2="342" y2="105" stroke="#000"/>
<line x1="170" y1="167" x2="177" y2="172" stroke="#000"/><line x1="175" y1="165" x2="182" y2="170" stroke="#000"/>
<line x1="75" y1="112" x2="82" y2="117" stroke="#000"/><line x1="80" y1="110" x2="87" y2="115" stroke="#000"/>
</svg>"""

# úloha 13: čtverec 17 cm rozdělený na šedý šestiúhelník a dva bílé trojúhelníky
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 340" font-family="sans-serif">
<rect x="60" y="30" width="270" height="270" fill="#ffffff" stroke="#000" stroke-width="2"/>
<polygon points="60,30 92,30 330,157 330,300 298,300 60,173" fill="#c9c9c9" stroke="#000" stroke-width="1.5"/>
<text x="66" y="22" font-size="13">2 cm</text>
<text x="215" y="22" font-size="13" text-anchor="middle">17 cm</text>
<text x="200" y="320" font-size="13" text-anchor="middle">17 cm</text>
</svg>"""

# úloha 14: krychle 3x3x3 z krychliček (hrana 2 cm), dvě krychličky odebrány (schematicky)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 300" font-family="sans-serif">
<polygon points="40,120 190,120 245,75 95,75" fill="#d9d9d9" stroke="#000"/>
<polygon points="190,120 245,75 245,225 190,270" fill="#bfbfbf" stroke="#000"/>
<rect x="40" y="120" width="150" height="150" fill="#ededed" stroke="#000"/>
<line x1="90" y1="120" x2="90" y2="270" stroke="#000"/>
<line x1="140" y1="120" x2="140" y2="270" stroke="#000"/>
<line x1="40" y1="170" x2="190" y2="170" stroke="#000"/>
<line x1="40" y1="220" x2="190" y2="220" stroke="#000"/>
<line x1="130" y1="120" x2="185" y2="75" stroke="#000"/>
<line x1="80" y1="120" x2="135" y2="75" stroke="#000"/>
<line x1="95" y1="75" x2="95" y2="225" stroke="#000" stroke-opacity="0"/>
<line x1="190" y1="170" x2="245" y2="125" stroke="#000"/>
<line x1="190" y1="220" x2="245" y2="175" stroke="#000"/>
<rect x="99" y="179" width="32" height="32" fill="#ffffff" stroke="#000"/>
<polygon points="245,75 245,125 210,110 210,60" fill="#ffffff" stroke="#000"/>
<text x="150" y="292" font-size="12" text-anchor="middle">nové těleso (2 krychličky odebrány)</text>
</svg>"""

# úloha 16: rozmístění žetonů na čtvercových deskách (3x3 a 5x5)
def _numgrid(ox, oy, cell, rows):
    n = len(rows); m = len(rows[0])
    p = [f'<rect x="{ox}" y="{oy}" width="{m*cell}" height="{n*cell}" fill="#ffffff" stroke="#000"/>']
    for i in range(1, n):
        y = oy + i * cell; p.append(f'<line x1="{ox}" y1="{y}" x2="{ox+m*cell}" y2="{y}" stroke="#000"/>')
    for j in range(1, m):
        x = ox + j * cell; p.append(f'<line x1="{x}" y1="{oy}" x2="{x}" y2="{oy+n*cell}" stroke="#000"/>')
    for i in range(n):
        for j in range(m):
            x = ox + j * cell + cell // 2; y = oy + i * cell + int(cell * 0.66)
            p.append(f'<text x="{x}" y="{y}" font-size="14" text-anchor="middle">{rows[i][j]}</text>')
    return "".join(p)

SVG16 = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 230" font-family="sans-serif">'
         + '<text x="85" y="30" font-size="13" text-anchor="middle">3 × 3 políčka</text>'
         + _numgrid(40, 45, 30, [[1,1,1],[1,2,1],[1,1,1]])
         + '<text x="320" y="30" font-size="13" text-anchor="middle">5 × 5 políček</text>'
         + _numgrid(250, 45, 30, [[1,1,1,1,1],[1,2,2,2,1],[1,2,3,2,1],[1,2,2,2,1],[1,1,1,1,1]])
         + '</svg>')

B = ['zs2', 'r9']  # 9. ročník ZŠ, čtyřleté obory (přijímačky M9)

PROBLEMS = [
    {'name': 'CERMAT M9A 2019 – úloha 1',
     'zad': ['Vypočtěte tři pětiny z dvojnásobku čísla $15$.'],
     'opts': None, 'ln': 2,
     'sol': ['Dvojnásobek čísla $15$ je $30$; tři pětiny z $30$ jsou $\\frac{3}{5}\\cdot 30 = 18$.'],
     'ans': '$18$', 'pts': 1, 'mins': 1, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 2.1',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:',
             '11 hodin 17 minut − 9 hodin 45 minut = ______ minut'],
     'opts': None, 'ln': 2,
     'sol': ['$11$ h $17$ min $= 677$ min, $9$ h $45$ min $= 585$ min. Rozdíl $677 - 585 = 92$ min (tj. $1$ h $32$ min).'],
     'ans': '$92$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 2.2',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:',
             '28 m² − ______ dm² = 2 300 dm² + 2 300 cm²'],
     'opts': None, 'ln': 2,
     'sol': ['$28$ m² $= 2\\,800$ dm². Dále $2\\,300$ cm² $= 23$ dm², takže pravá strana je $2\\,300 + 23 = 2\\,323$ dm². Z rovnosti $2\\,800 - x = 2\\,323$ plyne $x = 477$.'],
     'ans': '$477$', 'pts': 1, 'mins': 2, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
             '$(6-4)\\cdot\\frac{11}{8} + \\frac{9}{14}\\cdot\\frac{7}{6} =$'],
     'opts': None, 'ln': 3,
     'sol': ['$(6-4)\\cdot\\frac{11}{8} = 2\\cdot\\frac{11}{8} = \\frac{11}{4}$; $\\frac{9}{14}\\cdot\\frac{7}{6} = \\frac{63}{84} = \\frac{3}{4}$. Součet $\\frac{11}{4} + \\frac{3}{4} = \\frac{14}{4} = \\frac{7}{2}$.'],
     'ans': '$\\frac{7}{2}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
             '$\\dfrac{\\frac{2\\cdot 3}{6} - \\frac{4}{2\\cdot 3}}{\\frac{2+3}{6}} =$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\frac{2\\cdot 3}{6} - \\frac{4}{2\\cdot 3} = 1 - \\frac{2}{3} = \\frac{1}{3}$. Jmenovatel: $\\frac{2+3}{6} = \\frac{5}{6}$. Celý výraz $\\frac{1/3}{5/6} = \\frac{1}{3}\\cdot\\frac{6}{5} = \\frac{6}{15} = \\frac{2}{5}$.'],
     'ans': '$\\frac{2}{5}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 4.1',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky):', '$(3a-2)\\cdot(-2a) =$'],
     'opts': None, 'ln': 2,
     'sol': ['$(3a-2)\\cdot(-2a) = -6a^2 + 4a$.'],
     'ans': '$-6a^2 + 4a$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 4.2',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky):', '$(3x-4)^2 =$'],
     'opts': None, 'ln': 2,
     'sol': ['$(3x-4)^2 = (3x)^2 - 2\\cdot 3x\\cdot 4 + 4^2 = 9x^2 - 24x + 16$.'],
     'ans': '$9x^2 - 24x + 16$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 4.3',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky):',
             '$(2+n)\\cdot(3n-3) + (3n-n)\\cdot 2 - n\\cdot(3-5) =$'],
     'opts': None, 'ln': 3,
     'sol': ['$(2+n)(3n-3) = 3n^2 + 3n - 6$; $(3n-n)\\cdot 2 = 2n\\cdot 2 = 4n$; $-n\\cdot(3-5) = -n\\cdot(-2) = 2n$. Součet $3n^2 + 3n - 6 + 4n + 2n = 3n^2 + 9n - 6$.'],
     'ans': '$3n^2 + 9n - 6$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 5.1',
     'zad': ['Řešte rovnici:', '$0{,}6x - \\frac{1}{2} = 1{,}4x + 1{,}5$'],
     'opts': None, 'ln': 3,
     'sol': ['$0{,}6x - 0{,}5 = 1{,}4x + 1{,}5$; $-0{,}5 - 1{,}5 = 1{,}4x - 0{,}6x$; $-2 = 0{,}8x$; $x = -2{,}5$.'],
     'ans': '$x = -2{,}5$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 5.2',
     'zad': ['Řešte rovnici:', '$\\frac{3-2y}{3} = \\frac{1-2y}{4} + \\frac{y+3}{6}$'],
     'opts': None, 'ln': 4,
     'sol': ['Vynásobíme rovnici číslem $12$: $4(3-2y) = 3(1-2y) + 2(y+3)$; $12 - 8y = 3 - 6y + 2y + 6$; $12 - 8y = 9 - 4y$; $3 = 4y$; $y = \\frac{3}{4} = 0{,}75$.'],
     'ans': '$y = 0{,}75$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 6',
     'zad': ['Všichni chlapci atletického oddílu se seřadili do zástupu podle velikosti. Před Petrem stála jedna osmina celkového počtu chlapců. Hned za Petrem stál jeho bratr Radek a za Radkem ještě pět šestin celkového počtu chlapců. Neznámý celkový počet chlapců atletického oddílu označte $x$.',
             '6.1 V závislosti na veličině $x$ vyjádřete počet chlapců, kteří stáli před Petrem.',
             '6.2 V závislosti na veličině $x$ vyjádřete počet chlapců, kteří stáli za Petrem.',
             '6.3 Vypočtěte celkový počet chlapců atletického oddílu.'],
     'opts': None, 'ln': 4,
     'sol': ['6.1 Před Petrem stála jedna osmina všech chlapců, tj. $\\frac{x}{8}$.',
             '6.2 Za Petrem stál Radek (jeden chlapec) a dále pět šestin všech chlapců, tj. $\\frac{5x}{6} + 1$.',
             '6.3 Celkem: před Petrem $\\frac{x}{8}$, Petr $1$, za Petrem $\\frac{5x}{6} + 1$. Rovnice $\\frac{x}{8} + 1 + \\frac{5x}{6} + 1 = x$; $\\frac{x}{8} + \\frac{5x}{6} + 2 = x$; $\\frac{3x + 20x}{24} + 2 = x$; $x - \\frac{23x}{24} = 2$; $\\frac{x}{24} = 2$; $x = 48$.'],
     'ans': '6.1: $\\frac{x}{8}$; 6.2: $\\frac{5x}{6}+1$; 6.3: $48$ chlapců', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2019 – úloha 7',
     'zad': ['Na obrázku jsou sestaveny dvě různé dvojice ozubených koleček. Šedé kolečko má $15$ zubů a obě bílá kolečka $24$ zubů. Černé kolečko, které má méně zubů než bílé, se za každých $5$ sekund otočí třikrát.',
             '7.1 Pro první dvojici koleček (šedé a bílé) určete, kolikrát se musí otočit šedé kolečko, než se poprvé obě kolečka vrátí do výchozí polohy.',
             '7.2 Určete, kolikrát se černé kolečko otočí za $5$ minut.',
             '7.3 Ve druhé dvojici koleček (bílé a černé) se obě kolečka vrátí do výchozí polohy poprvé po dvou otáčkách bílého kolečka. Vypočtěte, kolik zubů má černé kolečko.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'kolecka.svg',
     'alt': 'Dvě dvojice ozubených koleček: šedé (15 zubů) s bílým (24 zubů) a bílé (24 zubů) s menším černým kolečkem.',
     'cap': 'Dvě dvojice ozubených koleček',
     'sol': ['7.1 Nejmenší společný násobek čísel $15$ a $24$ je $120$. Šedé kolečko se otočí $120:15 = 8$krát (bílé $120:24 = 5$krát).',
             '7.2 $5$ minut $= 300$ sekund $= 60$ pětisekundových úseků; za každý se černé kolečko otočí $3$krát, celkem $60\\cdot 3 = 180$krát.',
             '7.3 Dvě otáčky bílého kolečka odpovídají $2\\cdot 24 = 48$ zubům, což je nejmenší společný násobek počtů zubů obou koleček. Černé kolečko má méně než $24$ zubů a nejmenší společný násobek $24$ a jeho počtu zubů je $48$; to splňuje $16$ zubů (černé se přitom otočí $48:16 = 3$krát).'],
     'ans': '7.1: $8$krát; 7.2: $180$krát; 7.3: $16$ zubů', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2019 – úloha 8',
     'zad': ['Z místa $A$ do místa $B$ šla Iva přímou cestou dlouhou $2$ km. Dan šel z místa $A$ do místa $B$ vycházkovou trasou, která má tvar půlkružnice nad průměrem $AB$ (viz obrázek).',
             '8.1 Vypočtěte, kolikrát delší byla cesta Dana než cesta Ivy. (Výsledek zaokrouhlete na setiny.)',
             '8.2 Vypočtěte, o kolik kilometrů více ušel Dan než Iva. (Výsledek zaokrouhlete na setiny km.)'],
     'opts': None, 'ln': 4, 'svg': SVG8, 'fn': 'pulkruznice.svg',
     'alt': 'Body A a B spojené přímou úsečkou (Ivina cesta) a půlkružnicí nad průměrem AB (Danova cesta).',
     'cap': 'Přímá cesta a půlkružnice mezi A a B',
     'sol': ['Průměr půlkružnice je $|AB| = 2$ km, poloměr $r = 1$ km. Délka Danovy trasy (půlkružnice) je $\\pi r = \\pi \\approx 3{,}14$ km.',
             '8.1 Poměr délek $\\frac{\\pi r}{2} = \\frac{\\pi}{2} \\approx 1{,}57$; Danova cesta byla asi $1{,}57$krát delší.',
             '8.2 Rozdíl $\\pi - 2 \\approx 3{,}14 - 2 = 1{,}14$ km.'],
     'ans': '8.1: $1{,}57$krát; 8.2: o $1{,}14$ km', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2019 – úloha 9',
     'zad': ['V rovině leží přímka $KL$ (viz obrázek). Body $K$, $L$ jsou vrcholy trojúhelníku $KLM$. Velikost úhlu $LKM$ je $30^\\circ$. Vzdálenost bodu $L$ od bodu $K$ je stejná jako vzdálenost bodu $L$ od bodu $M$.',
             'Sestrojte jeden trojúhelník $KLM$.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-kl.svg',
     'alt': 'Vodorovná přímka KL se dvěma vyznačenými body K a L.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['V bodě $K$ sestrojíme rameno úhlu o velikosti $30^\\circ$ k přímce $KL$; vrchol $M$ leží na tomto rameni. Zároveň $|LM| = |LK|$, tedy $M$ leží na kružnici se středem $L$ a poloměrem $|LK|$. Průsečík ramene s touto kružnicí (různý od $K$) je vrchol $M$. Trojúhelník $KLM$ je rovnoramenný se základnou $KM$.'],
     'ans': 'Konstrukce: rameno úhlu $LKM = 30^\\circ$ v bodě $K$; vrchol $M$ je průsečík tohoto ramene s kružnicí se středem $L$ a poloměrem $|LK|$ (viz obrázek v klíči).',
     'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 10',
     'zad': ['V rovině leží přímka $c$ a mimo ni dva různé body $B$, $D$ (viz obrázek). Body $B$, $D$ jsou vrcholy obdélníku $ABCD$. Vrchol $C$ obdélníku $ABCD$ leží na přímce $c$.',
             '10.1 Sestrojte a označte písmenem chybějící vrchol $C$ obdélníku $ABCD$.',
             '10.2 Sestrojte a označte písmenem chybějící vrchol $A$ obdélníku $ABCD$ a obdélník narýsujte.',
             'Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'primka-c-bd.svg',
     'alt': 'Šikmá přímka c a pod ní dva body B a D vyznačené křížky.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Body $B$ a $D$ jsou protější vrcholy obdélníku, $BD$ je úhlopříčka. Střed $S$ úsečky $BD$ je i středem druhé úhlopříčky $AC$. Ve vrcholu $C$ je pravý úhel $BCD$, proto $C$ leží na Thaletově kružnici nad průměrem $BD$ (střed $S$, poloměr $\\frac{|BD|}{2}$). Průsečíky této kružnice s přímkou $c$ dávají vrcholy $C_1$, $C_2$. Vrchol $A$ získáme jako obraz bodu $C$ ve středové souměrnosti se středem $S$ ($A_1$, $A_2$). Úloha má dvě řešení.'],
     'ans': 'Střed $S$ úsečky $BD$; vrchol $C$ je průsečík přímky $c$ s Thaletovou kružnicí nad průměrem $BD$; vrchol $A$ je obraz $C$ ve středové souměrnosti se středem $S$. Dvě řešení (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 11',
     'zad': ['Škola má dvě deváté třídy (9. A a 9. B). V 9. A je třikrát více chlapců než dívek a celkem je v této třídě $24$ žáků. Počet všech žáků 9. B je o třetinu větší než počet všech žáků 9. A. V 9. B je poměr počtu dívek a počtu chlapců (v uvedeném pořadí) $3:5$ (viz tabulka).',
             'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
             '11.1 V 9. A je poměr počtu dívek a počtu chlapců (v uvedeném pořadí) $1:2$.',
             '11.2 Celkový počet dívek z obou 9. tříd je stejný jako počet chlapců v 9. A.',
             '11.3 V 9. B je počet dívek o $8$ menší než počet chlapců.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'tabulka-tridy.svg',
     'alt': 'Tabulka s hlavičkou Dívky, Chlapci, Celkem a řádky 9. A, 9. B, Celkem; vyplněno je pouze pole 9. A Celkem hodnotou 24.',
     'cap': 'Počty žáků ve třídách 9. A a 9. B',
     'sol': ['V 9. A: dívky $d$ a chlapci $3d$, $d + 3d = 24 \\Rightarrow d = 6$ dívek, $18$ chlapců. V 9. B: celkem $24 + \\frac{24}{3} = 32$ žáků; poměr $3:5$ (8 dílů) dává $12$ dívek a $20$ chlapců.',
             '11.1 Poměr v 9. A je $6:18 = 1:3$, nikoli $1:2$ → Ne.',
             '11.2 Dívek celkem $6 + 12 = 18$, chlapců v 9. A je $18$; jsou stejné → Ano.',
             '11.3 V 9. B je dívek $12$ a chlapců $20$, rozdíl $20 - 12 = 8$ → Ano.'],
     'ans': '11.1: Ne; 11.2: Ano; 11.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2019 – úloha 12',
     'zad': ['Na obrázku je kosočtverec (všechny čtyři strany jsou shodné) a k němu připojený trojúhelník; strana kosočtverce vycházející z pravého dolního vrcholu pokračuje přímo (v jedné přímce) do dolního vrcholu trojúhelníku. Jsou vyznačeny úhly $\\alpha + 24^\\circ$, $68^\\circ$ a $\\alpha$ (viz obrázek). Velikosti úhlů neměřte, ale vypočtěte.',
             'Jaká je velikost úhlu $\\alpha$?'],
     'opts': ['A) $88^\\circ$', 'B) $90^\\circ$', 'C) $92^\\circ$', 'D) $94^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG12, 'fn': 'kosoctverec-uhel.svg',
     'alt': 'Kosočtverec s vyznačeným úhlem alfa plus 24 stupňů u horního levého vrcholu; na jeho pravou stranu navazuje v přímce trojúhelník s úhly 68 stupňů a alfa.',
     'cap': 'Výchozí obrázek k úloze 12',
     'sol': ['V kosočtverci jsou protější úhly shodné, takže vnitřní úhel u pravého dolního vrcholu je rovněž $\\alpha + 24^\\circ$. Protože strana kosočtverce pokračuje odtud přímo do vrcholu trojúhelníku, jsou úhly $\\alpha + 24^\\circ$ a $68^\\circ$ vedlejší (doplňují se do $180^\\circ$): $(\\alpha + 24^\\circ) + 68^\\circ = 180^\\circ$, odtud $\\alpha = 88^\\circ$.'],
     'ans': 'A) $88^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 13',
     'zad': ['Čtverec se stranou délky $17$ cm je rozdělen na šedý šestiúhelník a dva shodné bílé trojúhelníky. Nejdelší strana bílého trojúhelníku má délku $17$ cm. Nejkratší strana šedého šestiúhelníku měří $2$ cm (viz obrázek).',
             'Jaký je obsah šedého šestiúhelníku?'],
     'opts': ['A) $127$ cm²', 'B) $144$ cm²', 'C) $169$ cm²', 'D) $177$ cm²', 'E) jiný obsah'],
     'ln': 0, 'svg': SVG13, 'fn': 'ctverec-sestiuhelnik.svg',
     'alt': 'Čtverec o straně 17 cm rozdělený na šedý šestiúhelník a dva shodné bílé pravoúhlé trojúhelníky v protějších rozích.',
     'cap': 'Čtverec rozdělený na šestiúhelník a dva trojúhelníky',
     'sol': ['Každý bílý trojúhelník je pravoúhlý s přeponou (nejdelší stranou) $17$ cm. Nejkratší strana šestiúhelníku $2$ cm je zbytek strany čtverce, takže delší odvěsna trojúhelníku je $17 - 2 = 15$ cm. Druhá odvěsna: $\\sqrt{17^2 - 15^2} = \\sqrt{64} = 8$ cm (trojúhelník $8$–$15$–$17$). Obsah jednoho trojúhelníku $\\frac{1}{2}\\cdot 15\\cdot 8 = 60$ cm². Obsah čtverce $17^2 = 289$ cm². Šedý šestiúhelník $289 - 2\\cdot 60 = 169$ cm².'],
     'ans': 'C) $169$ cm²', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 14',
     'zad': ['Krychle byla slepena z $27$ malých bílých krychliček o hraně délky $2$ cm. Dvě malé krychličky jsme odstranili (jednu z hrany a jednu ze středu stěny), a vzniklo tak nové těleso. Všechny dostupné plochy nového tělesa jsme obarvili na šedo (i zespodu) – viz obrázek.',
             'Jaký je celkový obsah šedých ploch nového tělesa?'],
     'opts': ['A) menší než $236$ cm²', 'B) $236$ cm²', 'C) $240$ cm²', 'D) $244$ cm²', 'E) větší než $244$ cm²'],
     'ln': 0, 'svg': SVG14, 'fn': 'krychle-teleso.svg',
     'alt': 'Krychle složená z 3 krát 3 krát 3 krychliček, ze které jsou odebrány dvě krychličky (jedna z hrany, jedna ze středu stěny); schematický nákres.',
     'cap': 'Nové těleso po odebrání dvou krychliček',
     'sol': ['Velká krychle má hranu $3\\cdot 2 = 6$ cm, její povrch je $6\\cdot 6^2 = 216$ cm². Jedna malá stěna má obsah $2\\cdot 2 = 4$ cm². Odebráním krychličky ze středu stěny (jedna její stěna byla na povrchu) se odkryje $5$ vnitřních stěn a jedna povrchová zmizí, tj. přibude $5\\cdot 4 - 4 = 16$ cm². Odebráním krychličky z hrany (dvě její stěny byly na povrchu) přibude $4\\cdot 4 - 2\\cdot 4 = 8$ cm². Celkem $216 + 16 + 8 = 240$ cm².'],
     'ans': 'C) $240$ cm²', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2019 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 Cena jedné židle se snížila o $25\\,\\%$ na $1\\,800$ korun. Kolik korun stála jedna židle před snížením ceny?',
             '15.2 Výrobek po zdražení o $20\\,\\%$ stojí $2\\,700$ korun. Kolik korun stál výrobek před zdražením?',
             '15.3 Jana na lyžařské brýle přispěla $40\\,\\%$, chybějících $900$ korun za lyžařské brýle doplatil strýc. Cena za lyžařské brýle tvořila $60\\,\\%$ celé útraty za nákup lyžařských doplňků. Kolik korun činila celá útrata za nákup lyžařských doplňků?'],
     'opts': ['A) $2\\,160$ korun', 'B) $2\\,250$ korun', 'C) $2\\,340$ korun', 'D) $2\\,400$ korun', 'E) $2\\,500$ korun', 'F) jiný počet korun'],
     'ln': 0,
     'sol': ['15.1 $1\\,800$ Kč odpovídá $75\\,\\%$ původní ceny; $100\\,\\% = \\frac{1\\,800}{0{,}75} = 2\\,400$ Kč → D.',
             '15.2 $2\\,700$ Kč odpovídá $120\\,\\%$ původní ceny; $100\\,\\% = \\frac{2\\,700}{1{,}2} = 2\\,250$ Kč → B.',
             '15.3 Strýc doplatil $60\\,\\%$ ceny brýlí $= 900$ Kč, takže brýle stály $\\frac{900}{0{,}6} = 1\\,500$ Kč. Brýle tvoří $60\\,\\%$ celé útraty, tedy útrata $= \\frac{1\\,500}{0{,}6} = 2\\,500$ Kč → E.'],
     'ans': '15.1: D ($2\\,400$ korun); 15.2: B ($2\\,250$ korun); 15.3: E ($2\\,500$ korun)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M9A 2019 – úloha 16',
     'zad': ['Na čtvercovou desku s lichým počtem políček rozmístíme žetony takto: v prvním kroku položíme na každé políčko po obvodu desky $1$ žeton; v každém dalším kroku vybereme všechna prázdná políčka bezprostředně sousedící s obsazenými a na každé z nich položíme o $1$ žeton více než v předchozím kroku. Největší počet žetonů tak bude na prostředním políčku desky. Viz obrázek – desky $3\\times 3$ a $5\\times 5$.',
             '16.1 Čtvercová deska má na prostředním políčku $9$ žetonů. Určete, kolik políček je v každé řadě této čtvercové desky.',
             '16.2 Žetony rozmístíme na čtvercovou desku, která má $9\\times 9$ políček. Určete počet všech políček, na nichž leží právě $2$ žetony.',
             '16.3 Žetony rozmístíme na dvě čtvercové desky, z nichž jedna má $9\\times 9$ políček a druhá $11\\times 11$ políček. Určete, o kolik více žetonů je na větší desce než na menší desce.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'zetony-desky.svg',
     'alt': 'Deska 3 krát 3 s hodnotami 1 po obvodu a 2 uprostřed a deska 5 krát 5 s hodnotami 1, 2 a 3 (uprostřed).',
     'cap': 'Rozmístění žetonů na deskách 3 krát 3 a 5 krát 5',
     'sol': ['Na desce $n\\times n$ ($n$ liché) má prostřední políčko $\\frac{n+1}{2}$ žetonů; políčka s hodnotou $k$ tvoří čtvercový prstenec o $4\\,(n - 2k + 1)$ políčkách (pro $k < \\frac{n+1}{2}$).',
             '16.1 $\\frac{n+1}{2} = 9 \\Rightarrow n = 17$; v každé řadě je $17$ políček.',
             '16.2 Na desce $9\\times 9$ mají hodnotu $2$ políčka druhého prstence: $4\\,(9 - 2\\cdot 2 + 1) = 4\\cdot 6 = 24$ políček.',
             '16.3 Celkový počet žetonů na desce $9\\times 9$ je $165$, na desce $11\\times 11$ je $286$; rozdíl $286 - 165 = 121$ žetonů.'],
     'ans': '16.1: $17$ políček; 16.2: $24$ políček; 16.3: o $121$ žetonů', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PAD19C0T01'
    gen.YEAR = 2019

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9A-2019')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
