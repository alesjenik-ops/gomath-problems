# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2025, MATEMATIKA 9C, 1. nahradni termin (ctyrlete obory).
# Kod testu: M9PCD25C0T03. 16 uloh (po rozdeleni nezavislych poduloh 20 uloh).
# Zdroj odpovedi: rozsireny klic spravnych reseni (KLIC).

import math

# ---- SVG obrazky (bez apostrofu a zpetnych lomitek) ----

# uloha 8: dlazdice (ctverec 20 cm) s ctvrtkruhem a malym kruhem; vpravo ctverice
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 220" font-family="sans-serif">
<rect x="40" y="30" width="120" height="120" fill="none" stroke="#000" stroke-width="2"/>
<path d="M40 30 L100 30 A60 60 0 0 1 40 90 Z" fill="#b9b9b9" stroke="#000"/>
<circle cx="110" cy="112" r="30" fill="#b9b9b9" stroke="#000"/>
<text x="100" y="172" font-size="12" text-anchor="middle">20 cm</text>
<text x="30" y="95" font-size="12" text-anchor="middle" transform="rotate(-90 30 95)">10 cm</text>
<text x="76" y="24" font-size="12" text-anchor="middle">10 cm</text>
<rect x="230" y="30" width="120" height="120" fill="none" stroke="#000" stroke-width="2"/>
<line x1="290" y1="30" x2="290" y2="150" stroke="#000"/>
<line x1="230" y1="90" x2="350" y2="90" stroke="#000"/>
<circle cx="290" cy="90" r="55" fill="#b9b9b9" stroke="#000"/>
<circle cx="250" cy="50" r="18" fill="#b9b9b9" stroke="#000"/>
<circle cx="330" cy="50" r="18" fill="#b9b9b9" stroke="#000"/>
<circle cx="250" cy="130" r="18" fill="#b9b9b9" stroke="#000"/>
<circle cx="330" cy="130" r="18" fill="#b9b9b9" stroke="#000"/>
<text x="290" y="172" font-size="12" text-anchor="middle">ctverice dlazdic</text>
</svg>"""

# uloha 9: body B, M a primka q
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="40" y1="150" x2="420" y2="150" stroke="#000" stroke-width="2"/>
<text x="428" y="156" font-size="16" font-style="italic">q</text>
<text x="240" y="98" font-size="14" text-anchor="middle">x</text>
<text x="240" y="86" font-size="15" font-style="italic" text-anchor="middle">M</text>
<text x="300" y="238" font-size="14" text-anchor="middle">x</text>
<text x="300" y="252" font-size="15" font-style="italic" text-anchor="middle">B</text>
</svg>"""

# uloha 10: body A, S a primka p
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="40" y1="70" x2="420" y2="70" stroke="#000" stroke-width="2"/>
<text x="428" y="76" font-size="16" font-style="italic">p</text>
<text x="250" y="146" font-size="15" font-style="italic" text-anchor="middle">S</text>
<text x="250" y="158" font-size="14" text-anchor="middle">x</text>
<text x="120" y="236" font-size="14" text-anchor="middle">x</text>
<text x="120" y="252" font-size="15" font-style="italic" text-anchor="middle">A</text>
</svg>"""

# uloha 11: skupinovy sloupcovy graf navstevnosti (deti / dospeli)
def _graf():
    data = [("Kveten", 30, 80), ("Cerven", 10, 60), ("Cervenec", 30, 70), ("Srpen", 50, 90), ("Zari", 40, 100)]
    y0 = 300; sc = 2.2
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 350" font-family="sans-serif">']
    s.append(f'<line x1="70" y1="50" x2="70" y2="{y0}" stroke="#000"/><line x1="70" y1="{y0}" x2="525" y2="{y0}" stroke="#000"/>')
    for v in range(0, 111, 10):
        y = y0 - v * sc
        s.append(f'<line x1="66" y1="{y:.1f}" x2="70" y2="{y:.1f}" stroke="#000"/><text x="62" y="{y+4:.1f}" font-size="10" text-anchor="end">{v}</text>')
    for i, (name, d, a) in enumerate(data):
        gx = 90 + i * 82
        hd = d * sc; ha = a * sc
        s.append(f'<rect x="{gx}" y="{y0-hd:.1f}" width="26" height="{hd:.1f}" fill="#555" stroke="#000"/>')
        s.append(f'<rect x="{gx+28}" y="{y0-ha:.1f}" width="26" height="{ha:.1f}" fill="#dcdcdc" stroke="#000"/>')
        s.append(f'<text x="{gx+27}" y="{y0+16}" font-size="11" text-anchor="middle">{name}</text>')
    s.append('<rect x="490" y="70" width="14" height="14" fill="#555" stroke="#000"/><text x="509" y="82" font-size="12">Deti</text>')
    s.append('<rect x="490" y="92" width="14" height="14" fill="#dcdcdc" stroke="#000"/><text x="509" y="104" font-size="12">Dospeli</text>')
    s.append('<text x="20" y="175" font-size="11" text-anchor="middle" transform="rotate(-90 20 175)">Pocet prodanych vstupenek</text>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _graf()

# uloha 12: uzavreny okruh z 5 useku (30, 35, 50, 100, ?)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 340" font-family="sans-serif">
<polygon points="40,20 130,20 130,125 280,125 40,305" fill="none" stroke="#000" stroke-width="2"/>
<polyline points="52,20 52,32 40,32" fill="none" stroke="#000"/>
<polyline points="118,20 118,32 130,32" fill="none" stroke="#000"/>
<polyline points="130,113 142,113 142,125" fill="none" stroke="#000"/>
<text x="85" y="14" font-size="14" text-anchor="middle">30</text>
<text x="140" y="78" font-size="14">35</text>
<text x="205" y="118" font-size="14" text-anchor="middle">50</text>
<text x="188" y="222" font-size="14">100</text>
<text x="26" y="168" font-size="16" font-style="italic">?</text>
</svg>"""

# uloha 13: krychle s petici sedych ctvercu na uhlopricce steny (schematicky)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif">
<polygon points="150,60 310,60 310,220 150,220" fill="#fff" stroke="#000" stroke-width="2"/>
<polygon points="150,60 210,20 370,20 310,60" fill="#fff" stroke="#000" stroke-width="2"/>
<polygon points="310,60 370,20 370,180 310,220" fill="#fff" stroke="#000" stroke-width="2"/>
<rect x="150" y="60" width="32" height="32" fill="#b9b9b9" stroke="#000"/>
<rect x="182" y="92" width="32" height="32" fill="#b9b9b9" stroke="#000"/>
<rect x="214" y="124" width="32" height="32" fill="#b9b9b9" stroke="#000"/>
<rect x="246" y="156" width="32" height="32" fill="#b9b9b9" stroke="#000"/>
<rect x="278" y="188" width="32" height="32" fill="#b9b9b9" stroke="#000"/>
<text x="210" y="248" font-size="12" text-anchor="middle">schematicky nakres (sede ctverce na kazde stene)</text>
</svg>"""

# uloha 14: obdelnik ABCD, bod X na CD, osy o1, o2, uhly 22, 62, alfa
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 320" font-family="sans-serif">
<rect x="70" y="60" width="400" height="190" fill="none" stroke="#000" stroke-width="2"/>
<line x1="70" y1="250" x2="300" y2="60" stroke="#000" stroke-width="1.5"/>
<line x1="300" y1="60" x2="470" y2="250" stroke="#000" stroke-width="1.5"/>
<line x1="70" y1="250" x2="470" y2="106" stroke="#000" stroke-width="1" stroke-dasharray="8 3 2 3"/>
<line x1="300" y1="60" x2="285" y2="300" stroke="#000" stroke-width="1" stroke-dasharray="8 3 2 3"/>
<text x="58" y="56" font-size="14" font-style="italic">D</text>
<text x="476" y="56" font-size="14" font-style="italic">C</text>
<text x="58" y="268" font-size="14" font-style="italic">A</text>
<text x="476" y="268" font-size="14" font-style="italic">B</text>
<text x="298" y="52" font-size="14" font-style="italic">X</text>
<text x="478" y="110" font-size="13" font-style="italic">o1</text>
<text x="270" y="315" font-size="13" font-style="italic">o2</text>
<text x="108" y="243" font-size="13">22°</text>
<text x="250" y="150" font-size="13">62°</text>
<text x="446" y="216" font-size="14">α</text>
</svg>"""

# uloha 16: tri obrazce - pravidelne sestiuhelniky z trojuhelniku (schematicky)
def _hex(cx, cy, R, n, label):
    verts = [(cx + R * math.cos(math.radians(60 * i - 90)), cy + R * math.sin(math.radians(60 * i - 90))) for i in range(6)]
    s = []
    for i in range(6):
        x1, y1 = verts[i]; x2, y2 = verts[(i + 1) % 6]
        fill = "#b9b9b9" if i % 2 == 0 else "#ffffff"
        s.append(f'<polygon points="{cx:.1f},{cy:.1f} {x1:.1f},{y1:.1f} {x2:.1f},{y2:.1f}" fill="{fill}" stroke="#000"/>')
    for k in range(1, n):
        r = R * k / n
        pts = " ".join(f"{cx + r * math.cos(math.radians(60 * i - 90)):.1f},{cy + r * math.sin(math.radians(60 * i - 90)):.1f}" for i in range(6))
        s.append(f'<polygon points="{pts}" fill="none" stroke="#000"/>')
    s.append(f'<text x="{cx:.0f}" y="{cy-R-8:.0f}" font-size="12" text-anchor="middle">{label}</text>')
    return "".join(s)
def _hexs():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 230" font-family="sans-serif">']
    s.append(_hex(90, 120, 40, 1, "1. obrazec"))
    s.append(_hex(240, 120, 62, 2, "2. obrazec"))
    s.append(_hex(410, 120, 84, 3, "3. obrazec"))
    s.append('<text x="520" y="128" font-size="22">…</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _hexs()

B = ['zs2', 'r9']  # 9. rocnik ZS (ctyrlete obory); stupen zs2, rocnik r9

PROBLEMS = [
    {'name': 'CERMAT M9C 2025 – úloha 1', 'zad': ['Určete, kolikrát více je $5$ kilogramů než $0{,}25$ gramu.'],
     'opts': None, 'ln': 2,
     'sol': ['$5$ kg $=5000$ g. Kolikrát více: $5000:0{,}25=20\\,000$.'],
     'ans': '$20\\,000$krát', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 2', 'zad': [
        'Druhá mocnina neznámého prvočísla je o $3$ menší než jiné prvočíslo.',
        'Určete větší z obou prvočísel.'],
     'opts': None, 'ln': 2,
     'sol': ['Hledáme prvočíslo $p$, pro které je i $p^2+3$ prvočíslo. Pro $p=2$ je $2^2+3=7$ (prvočíslo). Pro liché $p$ by $p^2+3$ bylo sudé číslo větší než $2$, tedy složené. Prvočísla jsou $2$ a $7$, větší je $7$.'],
     'ans': '$7$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\sqrt{10^2-19}}{\\sqrt{10^2}}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{\\sqrt{100-19}}{\\sqrt{100}}=\\frac{\\sqrt{81}}{10}=\\frac{9}{10}$.'],
     'ans': '$\\frac{9}{10}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\left(\\frac{3}{5}\\right)^2}{\\frac{27}{34}\\cdot\\left(\\frac{2}{3}-\\frac{3^2}{5}\\right)}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\left(\\frac{3}{5}\\right)^2=\\frac{9}{25}$. Jmenovatel: $\\frac{27}{34}\\cdot\\left(\\frac{2}{3}-\\frac{9}{5}\\right)=\\frac{27}{34}\\cdot\\left(-\\frac{17}{15}\\right)=-\\frac{9}{10}$.',
            'Podíl: $\\frac{9}{25}:\\left(-\\frac{9}{10}\\right)=\\frac{9}{25}\\cdot\\left(-\\frac{10}{9}\\right)=-\\frac{2}{5}$.'],
     'ans': '$-\\frac{2}{5}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 4.1', 'zad': [
        'Upravte a umocněte (výsledný výraz nesmí obsahovat závorky): $(4+8a-8)^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(4+8a-8)^2=(8a-4)^2=64a^2-64a+16$.'],
     'ans': '$64a^2-64a+16$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 4.2', 'zad': [
        'Upravte na co nejjednodušší tvar bez závorek: $(2-3x)\\cdot 2+(2x)^2-x\\cdot(-6)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(2-3x)\\cdot 2+(2x)^2-x\\cdot(-6)=4-6x+4x^2+6x=4x^2+4$.'],
     'ans': '$4x^2+4$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 4.3', 'zad': [
        'Upravte na co nejjednodušší tvar bez závorek: $(1-2n)\\cdot(1-2n+4n)-2n\\cdot(1-3n)+(3n-1)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$(1-2n)(1+2n)-2n(1-3n)+(3n-1)=(1-4n^2)-(2n-6n^2)+3n-1=2n^2+n$.'],
     'ans': '$2n^2+n$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 5.1', 'zad': [
        'Řešte rovnici: $5x+\\frac{2}{15}+\\frac{1}{15}x=\\frac{2}{3}x-\\frac{3}{5}$'],
     'opts': None, 'ln': 3,
     'sol': ['Vynásobíme $15$: $75x+2+x=10x-9$, tj. $76x+2=10x-9$. Odtud $66x=-11$, a proto $x=-\\frac{1}{6}$.'],
     'ans': '$x=-\\frac{1}{6}$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 5.2', 'zad': [
        'Řešte rovnici: $4-\\frac{7-3y}{5}=3+\\frac{7y-4}{10}$'],
     'opts': None, 'ln': 3,
     'sol': ['Vynásobíme $10$: $40-2(7-3y)=30+(7y-4)$, tj. $40-14+6y=30+7y-4$, a tedy $26+6y=26+7y$. Odtud $y=0$.'],
     'ans': '$y=0$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 6', 'zad': [
        'Do ložnice jsme přikoupili postel, noční stolek a skříň. Noční stolek byl o polovinu levnější než skříň, ale o třetinu dražší než postel. Cenu nočního stolku označíme $n$.',
        '6.1 Vyjádřete výrazem s proměnnou $n$ cenu skříně.',
        '6.2 Vyjádřete výrazem s proměnnou $n$ cenu postele.',
        '6.3 Za všechny tři kusy nábytku jsme zaplatili celkem $9\\,000$ korun. Vypočtěte, kolik korun stál noční stolek.'],
     'opts': None, 'ln': 4,
     'sol': ['6.1 Noční stolek je o polovinu levnější než skříň, tedy je poloviční: $n=\\frac{1}{2}\\cdot$ cena skříně. Cena skříně je $2n$.',
            '6.2 Noční stolek je o třetinu dražší než postel: $n=\\frac{4}{3}\\cdot$ cena postele. Cena postele je $\\frac{3}{4}n$.',
            '6.3 $n+2n+\\frac{3}{4}n=9\\,000$, tj. $\\frac{15}{4}n=9\\,000$, a proto $n=2\\,400$ korun.'],
     'ans': '6.1: $2n$; 6.2: $\\frac{3}{4}n$; 6.3: $2\\,400$ korun', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M9C 2025 – úloha 7', 'zad': [
        'Cyklista jel část své trasy po rovině, část klesal a zbytek trasy stoupal. Po rovině ujel třetinu délky celé trasy, a to průměrnou rychlostí $30$ km/h. Klesání bylo pětkrát kratší než celá trasa a cyklista ho sjížděl průměrnou rychlostí o $40\\,\\%$ vyšší, než jel po rovině. Stoupání bylo na $14$ km trasy a cyklista v něm měl průměrnou rychlost o polovinu nižší než při klesání.',
        '7.1 Vypočtěte v km/h průměrnou rychlost cyklisty při klesání.',
        '7.2 Vypočtěte v km délku celé cyklistovy trasy.',
        '7.3 Vypočtěte v minutách, jak dlouho cyklista na své trase stoupal.'],
     'opts': None, 'ln': 4,
     'sol': ['7.1 Rychlost při klesání je o $40\\,\\%$ vyšší než $30$ km/h: $30\\cdot 1{,}4=42$ km/h.',
            '7.2 Rovina je $\\frac{1}{3}$ trasy, klesání $\\frac{1}{5}$ trasy, stoupání $14$ km. Platí $L=\\frac{1}{3}L+\\frac{1}{5}L+14$, tj. $\\frac{7}{15}L=14$, a proto $L=30$ km.',
            '7.3 Rychlost při stoupání je o polovinu nižší než při klesání: $\\frac{42}{2}=21$ km/h. Doba: $\\frac{14}{21}$ h $=\\frac{2}{3}$ h $=40$ minut.'],
     'ans': '7.1: $42$ km/h; 7.2: $30$ km; 7.3: $40$ minut', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'fyzika']},

    {'name': 'CERMAT M9C 2025 – úloha 8', 'zad': [
        'Celá podlaha chodby je vydlážděna stejnými dlaždicemi tvaru čtverce se stranou délky $20$ cm. Každá dlaždice je ozdobena čtvrtkruhem a malým kruhem (viz obrázek vlevo). Dlaždice se pokládaly pravidelně ve čtveřicích (viz obrázek vpravo), přičemž se začalo v rohu chodby celou touto čtveřicí.',
        '8.1 Vypočtěte v cm² obsah jednoho malého kruhu. Výsledek zaokrouhlete na celé cm².',
        '8.2 Podlaha chodby má tvar obdélníku s rozměry $2$ m a $3{,}2$ m. (Dlaždice jsou položeny těsně vedle sebe, šířku spár zanedbáváme.) Určete, o kolik se liší počet malých a velkých kruhů na podlaze chodby.'],
     'opts': None, 'ln': 4, 'svg': SVG8, 'fn': 'dlazdice.svg',
     'alt': 'Dlaždice tvaru čtverce 20 cm se čtvrtkruhem o poloměru 10 cm a malým kruhem; vpravo čtveřice dlaždic s velkým kruhem uprostřed a čtyřmi malými kruhy.',
     'cap': 'Schematický nákres dlaždice a čtveřice',
     'sol': ['8.1 Malý kruh má poloměr $5$ cm, jeho obsah je $\\pi\\cdot 5^2=25\\pi\\doteq 79$ cm².',
            '8.2 Podlaha $200$ cm $\\times$ $320$ cm dá $10\\cdot 16=160$ dlaždic, tedy $160$ malých kruhů (jeden na dlaždici). Čtvrtkruhy se ve čtveřici skládají do velkých kruhů: čtveřic je $5\\cdot 8=40$, tedy $40$ velkých kruhů. Rozdíl je $160-40=120$.'],
     'ans': '8.1: $79$ cm²; 8.2: o $120$ (malých $160$, velkých $40$)', 'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2025 – úloha 9 (konstrukce)', 'zad': [
        'V rovině leží body $B$, $M$ a přímka $q$ (viz obrázek).',
        'Bod $B$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Úsečka $BM$ je jednou z výšek tohoto trojúhelníku a bod $M$ leží na straně $AC$. Na přímce $q$ leží vrchol $A$ trojúhelníku $ABC$.',
        'Sestrojte vrcholy $A$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-BM-q.svg',
     'alt': 'Vodorovná přímka q, bod M nad přímkou a bod B pod přímkou.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Výška $BM$ je kolmá na stranu $AC$, proto strana $AC$ leží na kolmici vedené bodem $M$ k přímce $BM$. Průsečík této kolmice s přímkou $q$ je vrchol $A$. Trojúhelník je rovnoramenný se základnou $AB$, tedy $|CA|=|CB|$; vrchol $C$ je průsečík přímky $AC$ s osou úsečky $AB$.'],
     'ans': 'Konstrukce trojúhelníku $ABC$: přímka $AC$ je kolmice k $BM$ v bodě $M$, $A$ je její průsečík s $q$, $C$ leží na $AC$ a na ose úsečky $AB$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 10 (konstrukce)', 'zad': [
        'V rovině leží body $A$, $S$ a přímka $p$ (viz obrázek).',
        'Bod $A$ je vrchol obdélníku $ABCD$, jehož vrchol $D$ leží na přímce $p$. Bod $S$ je střed strany $CD$ obdélníku $ABCD$.',
        'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'body-AS-p.svg',
     'alt': 'Vodorovná přímka p, bod S pod přímkou a bod A vlevo dole.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['V obdélníku je $AD\\perp DC$ a bod $S$ leží na straně $DC$, proto je úhel $ADS$ pravý. Vrchol $D$ tedy leží na Thaletově kružnici nad průměrem $AS$ a zároveň na přímce $p$ — to dává dvě polohy $D_1$, $D_2$. Vrchol $C$ získáme jako obraz bodu $D$ ve středové souměrnosti se středem $S$ (protože $S$ je střed $CD$). Vrchol $B$ doplníme tak, aby $ABCD$ byl obdélník. Úloha má dvě řešení.'],
     'ans': 'Dvě řešení: $D$ leží na přímce $p$ a na Thaletově kružnici nad průměrem $AS$; $C$ je souměrné s $D$ podle středu $S$, $B$ doplní obdélník (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 11', 'zad': [
        'Rodný dům slavného spisovatele je otevřen pouze v letní sezoně od května do září. V pokladně zaznamenávají počet prodaných vstupenek dětským a dospělým návštěvníkům. V grafu je uvedena návštěvnost v jedné sezoně.',
        'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
        '11.1 V prvních třech měsících sezony bylo mezi návštěvníky rodného domu třikrát více dospělých než dětí.',
        '11.2 Za celou sezonu bylo dospělých návštěvníků rodného domu průměrně $80$ za měsíc.',
        '11.3 Za celou sezonu tvořily děti $40\\,\\%$ všech návštěvníků rodného domu.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'graf-navstevnost.svg',
     'alt': 'Skupinový sloupcový graf prodaných vstupenek pro děti a dospělé za květen až září: děti 30, 10, 30, 50, 40; dospělí 80, 60, 70, 90, 100.',
     'cap': 'Návštěvnost v jedné sezoně (počet vstupenek)',
     'sol': ['11.1 První tři měsíce (květen, červen, červenec): dětí $30+10+30=70$, dospělých $80+60+70=210$; $210=3\\cdot 70$, tvrzení je pravdivé (A).',
            '11.2 Dospělí za celou sezonu: $80+60+70+90+100=400$, průměr $400:5=80$ za měsíc; pravdivé (A).',
            '11.3 Dětí celkem $30+10+30+50+40=160$, všech návštěvníků $160+400=560$; $\\frac{160}{560}\\doteq 28{,}6\\,\\%$, tedy ne $40\\,\\%$ — nepravdivé (N).'],
     'ans': '11.1: Ano; 11.2: Ano; 11.3: Ne', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2025 – úloha 12', 'zad': [
        'Na hřišti je podle plánku vymezen uzavřený okruh, v němž na sebe navazuje $5$ rovných úseků. Některé sousední úseky jsou na sebe kolmé (viz obrázek). Jirka prošel celý okruh stejně dlouhými kroky a do plánku si zaznamenal jejich počet na prvních čtyřech úsecích.',
        'Kolika kroky prošel Jirka poslední úsek okruhu?'],
     'opts': ['A) méně než $85$ kroky', 'B) $85$ kroky', 'C) $90$ kroky', 'D) $95$ kroky', 'E) $100$ kroky'],
     'ln': 0, 'svg': SVG12, 'fn': 'okruh.svg',
     'alt': 'Uzavřený pětiúhelníkový okruh s úseky 30, 35, 50, diagonálou 100 a neznámým posledním úsekem; tři pravé úhly.',
     'cap': 'Plánek okruhu (počty kroků na úsecích)',
     'sol': ['Vodorovná vzdálenost mezi konci diagonálního úseku je $30+50=80$ kroků. Diagonální úsek měří $100$ kroků, jeho svislá složka je proto $\\sqrt{100^2-80^2}=\\sqrt{3600}=60$ kroků. Poslední (svislý) úsek okruh uzavře, jeho délka je $35+60=95$ kroků.'],
     'ans': 'D) $95$ kroky', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2025 – úloha 13', 'zad': [
        'Na každé stěně krychle je vždy jedna úhlopříčka celá přelepena pěti shodnými šedými čtverci tak, že sousední čtverce mají právě jeden společný vrchol (viz obrázek). Nepolepená část každé stěny je bílá. Součet obsahů všech bílých nepolepených ploch na povrchu krychle je $480$ cm².',
        'Jakou délku má hrana krychle?'],
     'opts': ['A) méně než $10$ cm', 'B) $10$ cm', 'C) $12$ cm', 'D) $15$ cm', 'E) $20$ cm'],
     'ln': 0, 'svg': SVG13, 'fn': 'krychle.svg',
     'alt': 'Krychle, na přední stěně pět šedých čtverců rozmístěných po úhlopříčce jako schodiště.',
     'cap': 'Schematický nákres krychle',
     'sol': ['Pět šedých čtverců na úhlopříčce dělí stěnu jako políčka sítě $5\\times 5$; každý má stranu $\\frac{a}{5}$. Šedá plocha jedné stěny je $5\\cdot\\left(\\frac{a}{5}\\right)^2=\\frac{a^2}{5}$, bílá plocha stěny je $a^2-\\frac{a^2}{5}=\\frac{4}{5}a^2$. Na $6$ stěnách je bílé plochy $6\\cdot\\frac{4}{5}a^2=\\frac{24}{5}a^2=480$, odtud $a^2=100$ a $a=10$ cm.'],
     'ans': 'B) $10$ cm', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 14', 'zad': [
        'V obdélníku $ABCD$ leží na straně $CD$ bod $X$. Přímka $o_1$ je osa úhlu $BAX$ a přímka $o_2$ je osa úhlu $AXB$. Velikosti některých úhlů jsou vyznačeny v obrázku.',
        'Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte (obrázek je pouze ilustrativní).'],
     'opts': ['A) $22^\\circ$', 'B) $28^\\circ$', 'C) $34^\\circ$', 'D) $40^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG14, 'fn': 'obdelnik-uhly.svg',
     'alt': 'Obdélník ABCD, bod X na horní straně CD, úsečky AX a XB, osy o1 a o2; vyznačené úhly 22° u vrcholu A, 62° uvnitř a úhel alfa u vrcholu B.',
     'cap': 'Schematický nákres k úloze 14',
     'sol': ['Osy $o_1$, $o_2$ vnitřních úhlů trojúhelníku $ABX$ při vrcholech $A$ a $X$ se protínají v jednom bodě. Vyznačený úhel $62^\\circ$ je vnějším úhlem trojúhelníku, který tyto osy tvoří, a rovná se součtu polovin úhlů $BAX$ a $AXB$: $\\frac{|BAX|}{2}+\\frac{|AXB|}{2}=62^\\circ$ (přitom $\\frac{|BAX|}{2}=22^\\circ$). Proto $|BAX|+|AXB|=124^\\circ$ a vnitřní úhel $|ABX|=180^\\circ-124^\\circ=56^\\circ$. Úhel $ABC$ obdélníku měří $90^\\circ$, tedy $\\alpha=|XBC|=90^\\circ-56^\\circ=34^\\circ$.'],
     'ans': 'C) $34^\\circ$', 'pts': 2, 'mins': 6, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2025 – úloha 15', 'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Prázdný kbelík se zcela naplní přesně $50$ hrnky borůvek. Z plného kbelíku jsme odsypali $46\\,\\%$ borůvek. Kolik hrnků borůvek zbývá v kbelíku?',
        '15.2 Hrnčíři Petr, Radim, Slávek a Tomáš vyrobili dohromady $240$ hrnků. Petr vyrobil o polovinu méně hrnků než Radim. Slávek i Tomáš vyrobili každý o $25\\,\\%$ hrnků méně než Radim. O kolik hrnků více vyrobil Tomáš než Petr?',
        '15.3 Jitka s maminkou a babičkou trhaly na zahradě rybíz do stejně velkých hrnků. Maminka natrhala dvakrát více rybízu než Jitka. Babička natrhala o polovinu více rybízu než Jitka. Přitom babička natrhala o $2$ hrnky rybízu méně než maminka. Kolik hrnků rybízu natrhaly všechny tři dohromady?'],
     'opts': ['A) $18$ hrnků', 'B) $20$ hrnků', 'C) $21$ hrnků', 'D) $23$ hrnků', 'E) $25$ hrnků', 'F) více než $25$ hrnků'],
     'ln': 0,
     'sol': ['15.1 Zbývá $100\\,\\%-46\\,\\%=54\\,\\%$ z $50$ hrnků: $0{,}54\\cdot 50=27$ hrnků, tj. více než $25$ — možnost F.',
            '15.2 Nechť Radim vyrobil $R$. Petr $\\frac{R}{2}$, Slávek i Tomáš po $0{,}75R$. Součet $R+\\frac{R}{2}+0{,}75R+0{,}75R=3R=240$, tedy $R=80$. Petr $40$, Tomáš $60$; rozdíl $20$ hrnků — možnost B.',
            '15.3 Nechť Jitka natrhala $J$. Maminka $2J$, babička $1{,}5J$; přitom $1{,}5J=2J-2$, odtud $J=4$. Maminka $8$, babička $6$, celkem $4+8+6=18$ hrnků — možnost A.'],
     'ans': '15.1: F ($27$ hrnků); 15.2: B ($20$ hrnků); 15.3: A ($18$ hrnků)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2025 – úloha 16', 'zad': [
        'Vytváříme obrazce tvaru pravidelného šestiúhelníku složené z bílých a šedých shodných rovnostranných trojúhelníků. První obrazec se skládá ze $3$ bílých a $3$ šedých trojúhelníků a každý další obrazec vznikne přidáním jednoho pásu trojúhelníků okolo předchozího obrazce (viz obrázek).',
        '16.1 Vypočtěte, kolik trojúhelníků (bílých i šedých dohromady) obsahuje poslední přidaný pás 4. obrazce.',
        '16.2 Vypočtěte, kolik šedých trojúhelníků obsahuje celý 6. obrazec.',
        '16.3 Určete, kolikátý obrazec má v posledním přidaném pásu $225$ šedých trojúhelníků.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'sestiuhelniky.svg',
     'alt': 'První, druhý a třetí obrazec tvaru pravidelného šestiúhelníku složeného ze šedých a bílých trojúhelníků, každý další s jedním pásem navíc.',
     'cap': 'Schematický nákres 1., 2. a 3. obrazce',
     'sol': ['$n$-tý obrazec obsahuje celkem $6n^2$ trojúhelníků (pro $n=1$ je to $6$), z toho polovina, tedy $3n^2$, je šedých. Poslední přidaný pás $n$-tého obrazce má $6n^2-6(n-1)^2=6(2n-1)$ trojúhelníků, z toho $3(2n-1)$ šedých.',
            '16.1 Pás 4. obrazce: $6\\cdot(2\\cdot 4-1)=6\\cdot 7=42$ trojúhelníků.',
            '16.2 Celý 6. obrazec: šedých $3\\cdot 6^2=108$.',
            '16.3 $3(2n-1)=225\\Rightarrow 2n-1=75\\Rightarrow n=38$; jde o 38. obrazec.'],
     'ans': '16.1: $42$ trojúhelníků; 16.2: $108$ šedých trojúhelníků; 16.3: ve 38. obrazci', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PCD25C0T03'
    gen.YEAR = 2025

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9-2025C')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
