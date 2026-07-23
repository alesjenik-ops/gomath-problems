# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2021, MATEMATIKA 9, čtyřleté obory (9. ročník).
# Varianta C (1. náhradní termín). Kód testu: M9PCD21C0T03. 16 úloh v testu.
# Izolované podúlohy bez sdíleného kontextu (3, 4, 5) rozděleny -> 20 samostatných úloh.
# Zdroj odpovědí: klíč správných řešení (KSR); ověřeno výpočtem.

import math

# ---- SVG obrázky (bez ' a \) ----

# úloha 8: nový útvar – čtverec 72x72 cm (4 sloupce po 18 cm x 9 řad po 8 cm)
# se čtyřmi odebranými rohovými dlaždicemi (18 cm x 8 cm). Měřítko 4 px/cm.
def _dlaz():
    ox, oy = 30, 20
    W = 288
    pts = "102,20 246,20 246,52 318,52 318,276 246,276 246,308 102,308 102,276 30,276 30,52 102,52"
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 350" font-family="sans-serif">']
    out.append(f'<rect x="{ox}" y="{oy}" width="{W}" height="{W}" fill="none" stroke="#aaa" stroke-width="1" stroke-dasharray="5 4"/>')
    out.append(f'<polygon points="{pts}" fill="#c9c9c9" stroke="#000" stroke-width="1.8"/>')
    for x in (102, 174, 246):
        out.append(f'<line x1="{x}" y1="52" x2="{x}" y2="276" stroke="#7a7a7a" stroke-width="0.7"/>')
    for y in range(52, 277, 32):
        out.append(f'<line x1="30" y1="{y}" x2="318" y2="{y}" stroke="#7a7a7a" stroke-width="0.7"/>')
    out.append('<text x="174" y="334" font-size="15" text-anchor="middle">72 cm</text>')
    out.append('<text x="34" y="16" font-size="12">dlaždice 18 cm × 8 cm</text>')
    out.append('</svg>')
    return "".join(out)
SVG8 = _dlaz()

# úloha 9: body A, B, M v rovině (výchozí obrázek)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 420" font-family="sans-serif">
<rect x="8" y="8" width="604" height="404" fill="none" stroke="#ccc"/>
<line x1="293" y1="73" x2="307" y2="87" stroke="#000" stroke-width="1.6"/>
<line x1="293" y1="87" x2="307" y2="73" stroke="#000" stroke-width="1.6"/>
<text x="300" y="66" font-size="16" font-style="italic">M</text>
<line x1="143" y1="293" x2="157" y2="307" stroke="#000" stroke-width="1.6"/>
<line x1="143" y1="307" x2="157" y2="293" stroke="#000" stroke-width="1.6"/>
<text x="132" y="330" font-size="16" font-style="italic">A</text>
<line x1="423" y1="373" x2="437" y2="387" stroke="#000" stroke-width="1.6"/>
<line x1="423" y1="387" x2="437" y2="373" stroke="#000" stroke-width="1.6"/>
<text x="444" y="392" font-size="16" font-style="italic">B</text>
</svg>"""

# úloha 10: body A, B, L v rovině (výchozí obrázek)
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 400" font-family="sans-serif">
<rect x="8" y="8" width="624" height="384" fill="none" stroke="#ccc"/>
<line x1="293" y1="233" x2="307" y2="247" stroke="#000" stroke-width="1.6"/>
<line x1="293" y1="247" x2="307" y2="233" stroke="#000" stroke-width="1.6"/>
<text x="297" y="266" font-size="16" font-style="italic">L</text>
<line x1="553" y1="213" x2="567" y2="227" stroke="#000" stroke-width="1.6"/>
<line x1="553" y1="227" x2="567" y2="213" stroke="#000" stroke-width="1.6"/>
<text x="572" y="232" font-size="16" font-style="italic">B</text>
<line x1="243" y1="333" x2="257" y2="347" stroke="#000" stroke-width="1.6"/>
<line x1="243" y1="347" x2="257" y2="333" stroke="#000" stroke-width="1.6"/>
<text x="244" y="368" font-size="16" font-style="italic">A</text>
</svg>"""

# úloha 11: schematická mapka dvou tras (snadná nad, náročná pod) S–K–C
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 240" font-family="sans-serif">
<path d="M70,150 C90,70 170,70 200,150 C230,70 320,70 360,150" fill="none" stroke="#000" stroke-width="1.7"/>
<path d="M70,150 C95,225 170,225 200,150 C245,225 320,225 360,150" fill="none" stroke="#000" stroke-width="1.5" stroke-dasharray="6 4"/>
<text x="82" y="52" font-size="13">Snadná trasa</text>
<text x="232" y="232" font-size="13">Náročná trasa</text>
<line x1="63" y1="143" x2="77" y2="157" stroke="#000" stroke-width="1.6"/>
<line x1="63" y1="157" x2="77" y2="143" stroke="#000" stroke-width="1.6"/>
<line x1="193" y1="143" x2="207" y2="157" stroke="#000" stroke-width="1.6"/>
<line x1="193" y1="157" x2="207" y2="143" stroke="#000" stroke-width="1.6"/>
<line x1="353" y1="143" x2="367" y2="157" stroke="#000" stroke-width="1.6"/>
<line x1="353" y1="157" x2="367" y2="143" stroke="#000" stroke-width="1.6"/>
<text x="55" y="176" font-size="15" font-style="italic">S</text>
<text x="196" y="139" font-size="15" font-style="italic">K</text>
<text x="366" y="176" font-size="15" font-style="italic">C</text>
</svg>"""

# úloha 12: čtyři přímky (dvě rovnoběžné s ryskami, dvě různoběžné), úhly α, 2α, 36°
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 360" font-family="sans-serif">
<line x1="70" y1="150" x2="400" y2="120" stroke="#000" stroke-width="1.8"/>
<line x1="100" y1="270" x2="410" y2="240" stroke="#000" stroke-width="1.8"/>
<line x1="110" y1="115" x2="360" y2="300" stroke="#000" stroke-width="1.8"/>
<line x1="130" y1="300" x2="390" y2="110" stroke="#000" stroke-width="1.8"/>
<line x1="346" y1="118" x2="356" y2="132" stroke="#000" stroke-width="1.5"/>
<line x1="358" y1="117" x2="368" y2="131" stroke="#000" stroke-width="1.5"/>
<line x1="356" y1="238" x2="366" y2="252" stroke="#000" stroke-width="1.5"/>
<line x1="368" y1="237" x2="378" y2="251" stroke="#000" stroke-width="1.5"/>
<text x="150" y="134" font-size="16" font-style="italic">α</text>
<text x="255" y="207" font-size="16" font-style="italic">2α</text>
<text x="150" y="256" font-size="16">36°</text>
</svg>"""

# úlohy 13–14: podstava (šestiúhelník ve čtverci 8x8, odvěsny 3 a 4 cm) + 3D šestiboký hranol
def _hranol():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif">']
    # podstava
    s.append('<text x="92" y="16" font-size="13" text-anchor="middle">Podstava hranolu</text>')
    s.append('<rect x="20" y="30" width="144" height="144" fill="#ededed" stroke="#999" stroke-width="1"/>')
    s.append('<polygon points="74,30 110,30 164,102 110,174 74,174 20,102" fill="#c9c9c9" stroke="#000" stroke-width="1.8"/>')
    s.append('<text x="137" y="24" font-size="13" text-anchor="middle">3 cm</text>')
    s.append('<text x="170" y="72" font-size="13">4 cm</text>')
    s.append('<text x="92" y="192" font-size="13" text-anchor="middle">8 cm</text>')
    # 3D hranol: přední šestiúhelník + zadní posunutý (hloubka = výška 8 cm)
    s.append('<polygon points="441,25 463,25 496,69 463,113 441,113 408,69" fill="#f2f2f2" stroke="#777" stroke-width="1.2"/>')
    for fx, fy, bx, by in [(415, 55, 463, 25), (448, 99, 496, 69), (415, 143, 463, 113), (393, 55, 441, 25)]:
        s.append(f'<line x1="{fx}" y1="{fy}" x2="{bx}" y2="{by}" stroke="#777" stroke-width="1.2"/>')
    s.append('<polygon points="393,55 415,55 448,99 415,143 393,143 360,99" fill="#c9c9c9" stroke="#000" stroke-width="1.8"/>')
    s.append('<text x="470" y="50" font-size="13">8 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG13_14 = _hranol()

# úloha 16: trojúhelníkový obrazec (třetí, 7 řad); tmavé šestiúhelníky (6 trojúhelníků kolem
# středového vrcholu) + bílé trojúhelníky. Řady číslovány zdola (řada 1 = dolní vrchol).
def _fig16():
    N = 7
    h = 0.8660254
    s = 44
    ox, oy = 30, 20
    def X(i, p):
        return int(round(ox + (i / 2.0 + p) * s))
    def Y(i):
        return int(round(oy + i * h * s))
    centers = {(5, 1), (3, 1), (3, 3), (1, 1), (1, 3), (1, 5)}
    def dark(verts):
        return any(v in centers for v in verts)
    tris = []
    for i in range(0, N):
        for p in range(0, 7 - i):
            tris.append([(i, p), (i, p + 1), (i + 1, p)])
        for q in range(0, 6 - i):
            tris.append([(i + 1, q), (i + 1, q + 1), (i, q + 1)])
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 310" font-family="sans-serif">',
           '<g stroke="#000" stroke-width="1.2" fill="#fff">']
    for verts in tris:
        pts = " ".join(f"{X(i, p)},{Y(i)}" for (i, p) in verts)
        if dark(verts):
            out.append(f'<polygon points="{pts}" fill="#c9c9c9"/>')
        else:
            out.append(f'<polygon points="{pts}"/>')
    out.append('</g></svg>')
    return "".join(out)
SVG16 = _fig16()

B = ['zs2', 'r9']

PROBLEMS = [
    {'name': 'CERMAT M9C 2021 – úloha 1',
     'zad': ['Zapište zlomkem v základním tvaru, jakou část litru tvoří $30\\,\\%$ ze čtvrtlitru.'],
     'opts': None, 'ln': 2,
     'sol': ['$30\\,\\%$ ze čtvrtlitru je $0{,}3\\cdot\\dfrac{1}{4}=\\dfrac{3}{10}\\cdot\\dfrac{1}{4}=\\dfrac{3}{40}$ litru.'],
     'ans': '$\\dfrac{3}{40}$ litru', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['procenta', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 2',
     'zad': ['Dvě rekreační plavkyně Jana s Květou byly společně plavat. Každá uplavala 25 bazénů. Obě začaly plavat současně a každá plavala svým stále stejným tempem. Jana uplavala 5 bazénů za 7 minut. Květa uplavala 10 bazénů za čtvrt hodiny.',
             '2.1 Vypočtěte, o kolik sekund se lišily časy obou plavkyň na první obrátce (tj. po uplavání prvního bazénu).',
             '2.2 Určete, za jak dlouho uplavala 25 bazénů Květa. (Čas uveďte v minutách a sekundách, např. 5 min 12 s.)'],
     'opts': None, 'ln': 3,
     'sol': ['2.1 Jana uplave 1 bazén za $\\dfrac{7}{5}=1{,}4$ min $=84$ s, Květa za $\\dfrac{15}{10}=1{,}5$ min $=90$ s. Časy se liší o $90-84=6$ s.',
             '2.2 Květa uplave 1 bazén za $90$ s, tedy 25 bazénů za $25\\cdot 90=2\\,250$ s $=37$ min $30$ s.'],
     'ans': '2.1: o $6$ s; 2.2: $37$ min $30$ s', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2021 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
             '$\\left(\\dfrac{3}{4}+\\dfrac{13}{6}\\right)\\cdot\\left(\\dfrac{2}{5}-1\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\dfrac{3}{4}+\\dfrac{13}{6}=\\dfrac{9}{12}+\\dfrac{26}{12}=\\dfrac{35}{12}$, $\\dfrac{2}{5}-1=-\\dfrac{3}{5}$. Součin $\\dfrac{35}{12}\\cdot\\left(-\\dfrac{3}{5}\\right)=-\\dfrac{105}{60}=-\\dfrac{7}{4}$.'],
     'ans': '$-\\dfrac{7}{4}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
             '$\\dfrac{\\frac{3}{5}\\cdot 2-4\\cdot\\frac{2}{7}}{2}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel $\\dfrac{3}{5}\\cdot 2-4\\cdot\\dfrac{2}{7}=\\dfrac{6}{5}-\\dfrac{8}{7}=\\dfrac{42-40}{35}=\\dfrac{2}{35}$. Dělením dvěma: $\\dfrac{2}{35}:2=\\dfrac{1}{35}$.'],
     'ans': '$\\dfrac{1}{35}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 4.1',
     'zad': ['Rozložte podle vzorce (výsledný výraz uveďte ve tvaru součinu).', '$(4\\cdot a)^{2}-81=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(4a)^{2}-81=(4a)^{2}-9^{2}=(4a-9)(4a+9)$.'],
     'ans': '$(4a-9)(4a+9)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 4.2',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky).', '$2\\cdot(3y-x)\\cdot(5-y)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(3y-x)(5-y)=15y-3y^{2}-5x+xy$. Po vynásobení dvěma: $2xy-6y^{2}-10x+30y$.'],
     'ans': '$2xy-6y^{2}-10x+30y$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 4.3',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky).', '$(4n+1)^{2}+3\\cdot(n-1)-(3n+n)\\cdot 2n=$'],
     'opts': None, 'ln': 3,
     'sol': ['$(4n+1)^{2}=16n^{2}+8n+1$, $3(n-1)=3n-3$, $(3n+n)\\cdot 2n=4n\\cdot 2n=8n^{2}$. Celkem $16n^{2}+8n+1+3n-3-8n^{2}=8n^{2}+11n-2$.'],
     'ans': '$8n^{2}+11n-2$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 5.1',
     'zad': ['Řešte rovnici:', '$0{,}4\\cdot 0{,}1x+0{,}32:0{,}1=0{,}2x$'],
     'opts': None, 'ln': 3,
     'sol': ['$0{,}04x+3{,}2=0{,}2x$. Odtud $3{,}2=0{,}16x$ a $x=20$.'],
     'ans': '$x=20$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 5.2',
     'zad': ['Řešte rovnici:', '$\\dfrac{y-4}{5}-\\dfrac{y}{10}=\\dfrac{3+y}{2}-2$'],
     'opts': None, 'ln': 3,
     'sol': ['Vynásobíme 10: $2(y-4)-y=5(3+y)-20$, tj. $2y-8-y=15+5y-20$. Po úpravě $y-8=5y-5$, $-3=4y$ a $y=-0{,}75$.'],
     'ans': '$y=-0{,}75$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 6',
     'zad': ['Do firmy, která si pronajala dvě prázdné dílny, přivezli stroje. Polovinu přivezených strojů umístili do první dílny a polovinu do druhé dílny. První den zprovoznili tři pětiny strojů umístěných v první dílně (a žádný stroj v druhé dílně). Druhý den zprovoznili tři čtvrtiny strojů umístěných v druhé dílně (a žádný další v první). Třetí den zprovoznili veškeré zbývající stroje v obou dílnách. Neznámá $x$ představuje celkový počet strojů přivezených do firmy.',
             '6.1 V závislosti na veličině $x$ vyjádřete, kolik strojů zprovoznili první den.',
             '6.2 V závislosti na veličině $x$ vyjádřete, kolik strojů zprovoznili třetí den v první dílně.',
             '6.3 Třetí den zprovoznili v obou dílnách dohromady 52 strojů. Vypočtěte celkový počet strojů přivezených do firmy.'],
     'opts': None, 'ln': 3,
     'sol': ['6.1 V první dílně je $\\dfrac{x}{2}$ strojů, první den zprovoznili $\\dfrac{3}{5}\\cdot\\dfrac{x}{2}=\\dfrac{3x}{10}$.',
             '6.2 Třetí den v první dílně zprovoznili zbytek $\\dfrac{x}{2}-\\dfrac{3x}{10}=\\dfrac{5x-3x}{10}=\\dfrac{x}{5}$.',
             '6.3 V druhé dílně zbylo $\\dfrac{x}{2}-\\dfrac{3}{4}\\cdot\\dfrac{x}{2}=\\dfrac{x}{8}$. Třetí den dohromady $\\dfrac{x}{5}+\\dfrac{x}{8}=\\dfrac{13x}{40}=52$, odtud $x=160$.'],
     'ans': '6.1: $\\dfrac{3x}{10}$; 6.2: $\\dfrac{x}{5}$; 6.3: $160$ strojů', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2021 – úloha 7',
     'zad': ['Brigádníci plní bedýnky ovocem. Za naplnění každé z prvních 10 bedýnek dostávají základní odměnu 40 korun za 1 bedýnku. Za naplnění každé další bedýnky dostanou vyšší odměnu: odměna za 11. až 15. bedýnku je o $25\\,\\%$ vyšší než základní odměna; počínaje 16. bedýnkou je odměna za každou bedýnku o $50\\,\\%$ vyšší než základní odměna.',
             '7.1 Vypočtěte, kolik korun si brigádník vydělá za naplnění 12 bedýnek.',
             '7.2 Vypočtěte, kolik nejméně bedýnek musí brigádník naplnit, aby si vydělal alespoň 1 000 korun.'],
     'opts': None, 'ln': 3,
     'sol': ['7.1 Prvních 10 bedýnek po 40 Kč $=400$ Kč. Odměna za 11.–15. bedýnku je $40\\cdot 1{,}25=50$ Kč. Za 12 bedýnek: $400+2\\cdot 50=500$ Kč.',
             '7.2 Za prvních 15 bedýnek $400+5\\cdot 50=650$ Kč. Od 16. bedýnky je odměna $40\\cdot 1{,}5=60$ Kč. Chybí $1\\,000-650=350$ Kč; při 60 Kč za bedýnku je potřeba 6 dalších ($5\\cdot 60=300<350$, $6\\cdot 60=360$). Celkem $15+6=21$ bedýnek.'],
     'ans': '7.1: $500$ korun; 7.2: $21$ bedýnek', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2021 – úloha 8',
     'zad': ['Z celých dlaždic tvaru obdélníku o rozměrech 18 cm a 8 cm je sestaven nejmenší možný čtverec. Z každého ze čtyř rohů tohoto čtverce odebereme po jedné dlaždici a dostaneme nový útvar. Jedna strana čtverce je rovnoběžná s delšími stranami všech dlaždic.',
             '8.1 Vypočtěte v cm délku strany sestaveného čtverce.',
             '8.2 Vypočtěte počet dlaždic v novém útvaru.',
             '8.3 Vypočtěte v cm obvod nového útvaru.'],
     'opts': None, 'ln': 3, 'svg': SVG8, 'fn': 'dlazdice.svg',
     'alt': 'Čtverec sestavený z obdélníkových dlaždic 18 cm × 8 cm se čtyřmi odebranými rohovými dlaždicemi.',
     'cap': 'Schematický nákres nového útvaru (rozměry dle zadání)',
     'sol': ['8.1 Strana čtverce musí být násobkem 18 cm i 8 cm; nejmenší je nejmenší společný násobek $\\mathrm{lcm}(18,8)=72$ cm.',
             '8.2 Čtverec obsahuje $\\dfrac{72}{18}\\cdot\\dfrac{72}{8}=4\\cdot 9=36$ dlaždic; po odebrání 4 rohových zbývá $36-4=32$ dlaždic.',
             '8.3 Odebráním rohové dlaždice se obvod nezmění (ubyté vnější strany nahradí stejně dlouhé vnitřní strany), proto $o=4\\cdot 72=288$ cm.'],
     'ans': '8.1: $72$ cm; 8.2: $32$ dlaždic; 8.3: $288$ cm', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2021 – úloha 9',
     'zad': ['V rovině leží body $A$, $B$, $M$ (viz obrázek).',
             'Body $A$, $B$ jsou vrcholy obdélníku $ABCD$. Bod $M$ leží na téže kružnici $k$ jako všechny vrcholy obdélníku $ABCD$.',
             '9.1 Sestrojte střed kružnice $k$ a označte ho písmenem $S$.',
             '9.2 Sestrojte vrcholy $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-abm.svg',
     'alt': 'Body A, B a M v rovině (A vlevo dole, B vpravo dole, M nahoře).',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Vrcholy obdélníku i bod $M$ leží na kružnici $k$. Střed $S$ je průsečíkem os úseček $AB$ a $BM$ (střed kružnice opsané trojúhelníku $ABM$); kružnice $k$ má střed $S$ a poloměr $|SA|$.',
             'Úhlopříčky obdélníku jsou průměry kružnice a procházejí středem $S$. Vrchol $C$ je průsečík přímky $AS$ s kružnicí $k$ (bod souměrný s $A$ podle $S$), vrchol $D$ je průsečík přímky $BS$ s kružnicí $k$ (bod souměrný s $B$ podle $S$). Úloha má jedno řešení.'],
     'ans': 'Střed $S$ je průsečík os úseček $AB$ a $BM$ (střed kružnice opsané); vrcholy $C$, $D$ jsou body souměrné s $A$, $B$ podle středu $S$ na kružnici $k$ – viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 10',
     'zad': ['V rovině leží body $A$, $B$, $L$ (viz obrázek).',
             'Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$. Osy vnitřních úhlů $BAC$ a $ABC$ tohoto trojúhelníku procházejí bodem $L$.',
             'Sestrojte vrchol $C$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'body-abl.svg',
     'alt': 'Body A, B a L v rovině (A dole, B vpravo, L uprostřed).',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Přímka $AL$ je osou úhlu $BAC$, přímka $BL$ je osou úhlu $ABC$. Polopřímku $AC$ získáme osovou souměrností polopřímky $AB$ podle přímky $AL$, polopřímku $BC$ osovou souměrností polopřímky $BA$ podle přímky $BL$. Vrchol $C$ je průsečíkem těchto dvou polopřímek. Úloha má jedno řešení.'],
     'ans': 'Vrchol $C$ je průsečík polopřímek $AC$ a $BC$, které vzniknou osovou souměrností polopřímek $AB$ a $BA$ podle přímek $AL$ a $BL$ (os úhlů) – viz obrázek v klíči.',
     'pts': 2, 'mins': 6, 'diff': '4',
     'codes': B + ['planimetrie', 'konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 11',
     'zad': ['Od startu $S$ do cíle $C$ vede jedna snadná cyklistická trasa údolími a druhá náročná přes kopce. Obě trasy se kříží v místě $K$. Po snadné trase ujedeme v první části od startu $S$ do místa $K$ 45 km, což je o polovinu více, než ujedeme v druhé části od místa $K$ do cíle $C$. Náročná trasa je dlouhá 45 km a její první část od startu $S$ do místa $K$ je o pětinu kratší než její druhá část od místa $K$ do cíle $C$.',
             'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (Ano), či nikoli (Ne).',
             '11.1 U snadné trasy je poměr délky první části ku délce druhé části $2:1$.',
             '11.2 Druhá část snadné trasy měří 30 km.',
             '11.3 Druhá část náročné trasy měří 25 km.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'trasy.svg',
     'alt': 'Schematická mapka: snadná trasa (plná) a náročná trasa (čárkovaná) mezi body S, K a C.',
     'cap': 'Schematický nákres obou tras',
     'sol': ['Snadná trasa: první část 45 km je o polovinu více než druhá část, tedy $45=1{,}5\\cdot d$ a druhá část $d=30$ km; poměr $45:30=3:2$.',
             '11.1 Poměr je $3:2$, nikoli $2:1$ → Ne.',
             '11.2 Druhá část snadné trasy měří $30$ km → Ano.',
             '11.3 Náročná trasa: druhá část $d$, první část $\\dfrac{4}{5}d$; celkem $\\dfrac{4}{5}d+d=\\dfrac{9}{5}d=45$, tedy $d=25$ km → Ano.'],
     'ans': '11.1: Ne; 11.2: Ano; 11.3: Ano', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2021 – úloha 12',
     'zad': ['V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (vyznačeny ryskami). Jsou vyznačeny úhly $\\alpha$, $2\\alpha$ a $36^\\circ$ (viz obrázek).',
             'Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) $18^\\circ$', 'B) $36^\\circ$', 'C) $44^\\circ$', 'D) $48^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG12, 'fn': 'ctyri-primky.svg',
     'alt': 'Čtyři přímky – dvě rovnoběžné s ryskami a dvě různoběžné; vyznačeny úhly α, 2α a 36°.',
     'cap': 'Schematický nákres k úloze 12',
     'sol': ['Obě různoběžky spolu s jednou z rovnoběžek tvoří trojúhelník. Díky rovnoběžnosti přímek se úhel $\\alpha$ přenese k této rovnoběžce, takže vnitřními úhly trojúhelníku jsou $\\alpha$, $2\\alpha$ a $36^\\circ$. Platí $\\alpha+2\\alpha+36^\\circ=180^\\circ$, tedy $3\\alpha=144^\\circ$ a $\\alpha=48^\\circ$.'],
     'ans': 'D) $48^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 13',
     'zad': ['Kolmý šestiboký hranol byl vytvořen opracováním krychle o hraně délky 8 cm. Podstava hranolu vznikne ze čtvercové stěny původní krychle oddělením 4 shodných pravoúhlých trojúhelníků s odvěsnami délek 3 cm a 4 cm. Výška hranolu je 8 cm (viz obrázek).',
             'Jaký je objem šestibokého hranolu?'],
     'opts': ['A) $128$ cm³', 'B) $320$ cm³', 'C) $416$ cm³', 'D) $488$ cm³', 'E) jiný objem'],
     'ln': 0, 'svg': SVG13_14, 'fn': 'sestiboky-hranol.svg',
     'alt': 'Podstava – šestiúhelník vzniklý ze čtverce 8×8 cm oddělením rohových trojúhelníků (odvěsny 3 a 4 cm) – a šestiboký hranol výšky 8 cm.',
     'cap': 'Podstava a šestiboký hranol (výška 8 cm)',
     'sol': ['Obsah podstavy: čtverec $8\\cdot 8=64$ cm² zmenšený o 4 trojúhelníky o obsahu $\\dfrac{3\\cdot 4}{2}=6$ cm², tj. $64-4\\cdot 6=40$ cm². Objem $V=S_{p}\\cdot v=40\\cdot 8=320$ cm³.'],
     'ans': 'B) $320$ cm³', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 14',
     'zad': ['Kolmý šestiboký hranol byl vytvořen opracováním krychle o hraně délky 8 cm. Podstava hranolu vznikne ze čtvercové stěny původní krychle oddělením 4 shodných pravoúhlých trojúhelníků s odvěsnami délek 3 cm a 4 cm. Výška hranolu je 8 cm (viz obrázek).',
             'Jaký je povrch šestibokého hranolu?'],
     'opts': ['A) $160$ cm²', 'B) $192$ cm²', 'C) $240$ cm²', 'D) $272$ cm²', 'E) $336$ cm²'],
     'ln': 0, 'svg': SVG13_14, 'fn': 'sestiboky-hranol.svg',
     'alt': 'Podstava – šestiúhelník vzniklý ze čtverce 8×8 cm oddělením rohových trojúhelníků (odvěsny 3 a 4 cm) – a šestiboký hranol výšky 8 cm.',
     'cap': 'Podstava a šestiboký hranol (výška 8 cm)',
     'sol': ['Obsah podstavy je $40$ cm². Přepona každého odděleného trojúhelníku má délku $\\sqrt{3^{2}+4^{2}}=5$ cm; obvod šestiúhelníkové podstavy tvoří čtyři přepony po 5 cm a dvě zbylé strany po 2 cm, tj. $4\\cdot 5+2\\cdot 2=24$ cm. Plášť $=24\\cdot 8=192$ cm². Povrch $=2\\cdot 40+192=272$ cm².'],
     'ans': 'D) $272$ cm²', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2021 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 V domově pro seniory je 120 klientů a 84 z nich bylo očkováno. Kolik procent klientů domova pro seniory nebylo očkováno?',
             '15.2 Vláďa má 40 kartiček. Roman má o čtvrtinu kartiček více než Vláďa. O kolik procent má Vláďa méně kartiček než Roman?',
             '15.3 Cena za víkendový pobyt činila 2 000 korun a zahrnovala pouze dopravu, ubytování a stravování. Cena dopravy tvořila čtvrtinu ceny pobytu, ubytování stálo 800 korun. Kolik procent ceny pobytu tvořila cena stravování?'],
     'opts': ['A) $20\\,\\%$', 'B) $25\\,\\%$', 'C) $30\\,\\%$', 'D) $33\\,\\%$', 'E) $35\\,\\%$', 'F) jiný počet procent'],
     'ln': 0,
     'sol': ['15.1 Neočkovaných je $120-84=36$, tj. $\\dfrac{36}{120}=0{,}3=30\\,\\%$ → C.',
             '15.2 Roman má $40\\cdot 1{,}25=50$ kartiček. Vláďa má o $\\dfrac{50-40}{50}=\\dfrac{10}{50}=20\\,\\%$ méně → A.',
             '15.3 Doprava $\\dfrac{1}{4}\\cdot 2\\,000=500$ Kč, ubytování 800 Kč, stravování $2\\,000-500-800=700$ Kč, tj. $\\dfrac{700}{2\\,000}=35\\,\\%$ → E.'],
     'ans': '15.1: C ($30\\,\\%$); 15.2: A ($20\\,\\%$); 15.3: E ($35\\,\\%$)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2021 – úloha 16',
     'zad': ['Trojúhelníkové obrazce se podle vzoru sestavují z tmavých šestiúhelníků a bílých trojúhelníků. Šestiúhelník se skládá ze 6 shodných tmavých trojúhelníků. Jednotlivé řady obrazce jsou očíslovány vždy od nejkratší (řada 1 u dolního vrcholu) po nejdelší. Na obrázku je třetí nejmenší obrazec se 7 řadami.',
             'Obrazec má 19 řad. Určete počet',
             '16.1 bílých trojúhelníků v 9. řadě,',
             '16.2 tmavých trojúhelníků v 16. řadě,',
             '16.3 tmavých šestiúhelníků v celém obrazci.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'obrazce.svg',
     'alt': 'Trojúhelníkový obrazec se 7 řadami: tmavé šestiúhelníky (po šesti trojúhelnících) a bílé trojúhelníky, řady číslovány zdola.',
     'cap': 'Trojúhelníkový obrazec se 7 řadami (třetí nejmenší)',
     'sol': ['Bílé trojúhelníky jsou jen v lichých řadách: v 1. řadě je 1, ve 3. řadě 2, v 5. řadě 3 – v každé další liché řadě o jeden více.',
             '16.1 Řada 9 je pátou lichou řadou, proto obsahuje $5$ bílých trojúhelníků.',
             'Tmavé trojúhelníky tvoří šestiúhelníky; v sudé řadě s číslem $2k$ je jich $3k$ (2. řada 3, 4. řada 6, 6. řada 9 …).',
             '16.2 Řada 16 $=2\\cdot 8$, tedy $3\\cdot 8=24$ tmavých trojúhelníků.',
             'Šestiúhelníky jsou uspořádány po dvojicích řad: v řadách 2–3 je 1, v řadách 4–5 jsou 2, …, v $k$-té dvojici řad $k$ šestiúhelníků. Obrazec s 19 řadami má 9 dvojic řad.',
             '16.3 Celkem $1+2+3+\\dots+9=45$ tmavých šestiúhelníků (což je $45\\cdot 6=270$ tmavých trojúhelníků).'],
     'ans': '16.1: $5$ bílých trojúhelníků; 16.2: $24$ tmavých trojúhelníků; 16.3: $45$ tmavých šestiúhelníků',
     'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PCD21C0T03'
    gen.YEAR = 2021

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9C-2021')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
