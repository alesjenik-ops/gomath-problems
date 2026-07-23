# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2021, MATEMATIKA 7 (šestileté obory, 7. ročník),
# varianta B (2. řádný termín). Kód testu: M7PBD21C0T02.
# 16 úloh v sešitě; po rozdělení izolovaných výpočetních podúloh (3, 4) celkem 18 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno vyplněným záznamovým archem (VZA).

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

# úloha 2: číselná osa, 11 dílků (10 stejných mezer), C, A=1/4, B=0,75
def _osa():
    xs = [60 + i * 42 for i in range(11)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 150" font-family="sans-serif">']
    s.append('<line x1="40" y1="90" x2="505" y2="90" stroke="#000" stroke-width="2"/>')
    s.append('<polygon points="518,90 505,84 505,96" fill="#000"/>')
    for x in xs:
        s.append(f'<line x1="{x}" y1="81" x2="{x}" y2="99" stroke="#000" stroke-width="2"/>')
    s.append(f'<text x="{xs[1]}" y="66" font-size="16" text-anchor="middle" font-style="italic">C</text>')
    s.append(f'<text x="{xs[6]}" y="66" font-size="16" text-anchor="middle" font-style="italic">A</text>')
    s.append(f'<text x="{xs[10]}" y="66" font-size="16" text-anchor="middle" font-style="italic">B</text>')
    ax = xs[6]
    s.append(f'<text x="{ax}" y="118" font-size="14" text-anchor="middle">1</text>')
    s.append(f'<line x1="{ax-8}" y1="122" x2="{ax+8}" y2="122" stroke="#000"/>')
    s.append(f'<text x="{ax}" y="136" font-size="14" text-anchor="middle">4</text>')
    s.append(f'<text x="{xs[10]}" y="122" font-size="14" text-anchor="middle">0,75</text>')
    s.append('</svg>')
    return "".join(s)
SVG2 = _osa()

# úloha 6: tabulka bodů dvou tříd ve třech kolech
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 200" font-family="sans-serif">
<rect x="20" y="20" width="500" height="165" fill="none" stroke="#000"/>
<line x1="120" y1="20" x2="120" y2="185" stroke="#000"/>
<line x1="220" y1="50" x2="220" y2="185" stroke="#000"/>
<line x1="320" y1="50" x2="320" y2="185" stroke="#000"/>
<line x1="420" y1="20" x2="420" y2="185" stroke="#000"/>
<line x1="20" y1="80" x2="520" y2="80" stroke="#000"/>
<line x1="120" y1="50" x2="420" y2="50" stroke="#000"/>
<line x1="20" y1="115" x2="520" y2="115" stroke="#000"/>
<line x1="20" y1="150" x2="520" y2="150" stroke="#000"/>
<text x="70" y="55" font-size="12" text-anchor="middle">Trida</text>
<text x="270" y="40" font-size="12" text-anchor="middle">Pocet bodu ziskanych</text>
<text x="170" y="70" font-size="11" text-anchor="middle">v 1. kole</text>
<text x="270" y="70" font-size="11" text-anchor="middle">ve 2. kole</text>
<text x="370" y="70" font-size="11" text-anchor="middle">ve 3. kole</text>
<text x="470" y="50" font-size="12" text-anchor="middle">Soucet</text>
<text x="470" y="66" font-size="12" text-anchor="middle">bodu</text>
<text x="70" y="102" font-size="12" text-anchor="middle">7. A</text>
<text x="70" y="137" font-size="12" text-anchor="middle">7. B</text>
<text x="70" y="172" font-size="11" text-anchor="middle">Obe tridy</text>
<text x="270" y="102" font-size="12" text-anchor="middle">40</text>
<text x="470" y="137" font-size="12" text-anchor="middle">138</text>
</svg>"""

# úloha 7: dva obdélníky 2x6, jeden rozstřižen 3:1, a nový obrazec (tvar L)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 230" font-family="sans-serif">
<rect x="60" y="30" width="180" height="60" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="150" y="22" font-size="13" text-anchor="middle">6 cm</text>
<text x="48" y="64" font-size="13" text-anchor="end">2 cm</text>
<rect x="60" y="120" width="180" height="60" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="195" y1="120" x2="195" y2="180" stroke="#000" stroke-width="1.5"/>
<text x="48" y="154" font-size="13" text-anchor="end">2 cm</text>
<text x="370" y="40" font-size="13" text-anchor="middle" font-weight="bold">Novy obrazec</text>
<polygon points="310,190 430,190 430,60 390,60 390,150 310,150" fill="none" stroke="#000" stroke-width="1.5"/>
</svg>"""

# úloha 8: body D, K, L a přímka o (výchozí konstrukční obrázek)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif">
<rect x="8" y="8" width="464" height="304" fill="none" stroke="#ccc"/>
<line x1="70" y1="270" x2="420" y2="110" stroke="#000" stroke-width="2"/>
<text x="428" y="108" font-size="15" font-style="italic">o</text>
<line x1="112" y1="182" x2="128" y2="198" stroke="#000"/><line x1="128" y1="182" x2="112" y2="198" stroke="#000"/>
<text x="104" y="210" font-size="15" font-style="italic">D</text>
<line x1="242" y1="142" x2="258" y2="158" stroke="#000"/><line x1="258" y1="142" x2="242" y2="158" stroke="#000"/>
<text x="250" y="134" font-size="15" font-style="italic">K</text>
<line x1="342" y1="225" x2="358" y2="241" stroke="#000"/><line x1="358" y1="225" x2="342" y2="241" stroke="#000"/>
<text x="350" y="262" font-size="15" font-style="italic">L</text>
</svg>"""

# úloha 9: body C, S1, S2 (výchozí konstrukční obrázek)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif">
<rect x="8" y="8" width="444" height="264" fill="none" stroke="#ccc"/>
<line x1="122" y1="152" x2="138" y2="168" stroke="#000"/><line x1="138" y1="152" x2="122" y2="168" stroke="#000"/>
<text x="104" y="164" font-size="15" font-style="italic">C</text>
<line x1="292" y1="122" x2="308" y2="138" stroke="#000"/><line x1="308" y1="122" x2="292" y2="138" stroke="#000"/>
<text x="312" y="126" font-size="15" font-style="italic">S</text><text x="322" y="131" font-size="10">2</text>
<line x1="222" y1="182" x2="238" y2="198" stroke="#000"/><line x1="238" y1="182" x2="222" y2="198" stroke="#000"/>
<text x="212" y="212" font-size="15" font-style="italic">S</text><text x="222" y="217" font-size="10">1</text>
</svg>"""

# úloha 10: skupinový sloupcový graf (dívky/chlapci, Škola A/B)
def _graf10():
    x0, y0 = 70, 300
    sc = 1.75
    bw = 38
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 350" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="40" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="460" y2="{y0}" stroke="#000"/>')
    for v in range(0, 141, 20):
        y = y0 - v * sc
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    for name, cx, va, vb in [('Divky', 165, 90, 80), ('Chlapci', 330, 60, 120)]:
        ha = va * sc
        hb = vb * sc
        s.append(f'<rect x="{cx-bw}" y="{y0-ha}" width="{bw}" height="{ha}" fill="#1a1a1a" stroke="#000"/>')
        s.append(f'<rect x="{cx}" y="{y0-hb}" width="{bw}" height="{hb}" fill="#bdbdbd" stroke="#000"/>')
        s.append(f'<text x="{cx}" y="{y0+18}" font-size="13" text-anchor="middle">{name}</text>')
    s.append('<rect x="360" y="70" width="14" height="14" fill="#1a1a1a" stroke="#000"/><text x="380" y="82" font-size="12">Skola A</text>')
    s.append('<rect x="360" y="92" width="14" height="14" fill="#bdbdbd" stroke="#000"/><text x="380" y="104" font-size="12">Skola B</text>')
    s.append('<text x="22" y="170" font-size="12" text-anchor="middle" transform="rotate(-90 22 170)">Pocet deti</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _graf10()

# úlohy 12–13: síť kvádru (rozměry 2 x 2 x 5 cm) ve tvaru kříže
SVG_KVADR = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 260" font-family="sans-serif">
<rect x="60" y="110" width="36" height="36" fill="#d9d9d9" stroke="#000"/>
<rect x="96" y="110" width="90" height="36" fill="#d9d9d9" stroke="#000"/>
<rect x="186" y="110" width="36" height="36" fill="#d9d9d9" stroke="#000"/>
<rect x="222" y="110" width="90" height="36" fill="#d9d9d9" stroke="#000"/>
<rect x="186" y="20" width="36" height="90" fill="#d9d9d9" stroke="#000"/>
<rect x="186" y="146" width="36" height="90" fill="#d9d9d9" stroke="#000"/>
<text x="48" y="132" font-size="12" text-anchor="end">2 cm</text>
<text x="78" y="104" font-size="12" text-anchor="middle">2 cm</text>
<text x="141" y="104" font-size="12" text-anchor="middle">5 cm</text>
</svg>"""

# úloha 14: lichoběžník ABCD s úhlopříčkou DB a úsečkou z D, vyznačené úhly
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 340" font-family="sans-serif">
<polygon points="40,300 440,300 560,80 340,80" fill="none" stroke="#000" stroke-width="2"/>
<line x1="340" y1="80" x2="300" y2="300" stroke="#000" stroke-width="1.5"/>
<line x1="340" y1="80" x2="440" y2="300" stroke="#000" stroke-width="1.5"/>
<text x="28" y="316" font-size="15" font-style="italic">A</text>
<text x="436" y="318" font-size="15" font-style="italic">B</text>
<text x="566" y="76" font-size="15" font-style="italic">C</text>
<text x="330" y="72" font-size="15" font-style="italic">D</text>
<text x="90" y="292" font-size="14" font-style="italic">α</text>
<text x="316" y="150" font-size="14" font-style="italic">2α</text>
<text x="350" y="152" font-size="14" font-style="italic">γ</text>
<text x="386" y="122" font-size="14" font-style="italic">γ</text>
<text x="452" y="272" font-size="14" font-style="italic">γ</text>
<text x="532" y="112" font-size="14" font-style="italic">γ</text>
</svg>"""

# úloha 16: rozsvěcování žárovek (kratší lišta 4, delší lišta 6) v prvních 6 sekundách
def _zarovky():
    klit = {1: 1, 2: 2, 3: 3, 4: 4, 5: 3, 6: 2}
    dlit = {1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6}
    r = 7
    gap = 18
    colw = 118
    x0 = 24
    y_k = 60
    y_d = 94
    secs = [1, 2, 3, 4, 5, 6]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 740 118" font-family="sans-serif">']
    s.append('<g stroke="#000">')
    for i, t in enumerate(secs):
        cx = x0 + i * colw
        for j in range(4):
            fill = '#555' if j < klit[t] else '#fff'
            s.append(f'<circle cx="{cx+j*gap+gap}" cy="{y_k}" r="{r}" fill="{fill}"/>')
        for j in range(6):
            fill = '#555' if j < dlit[t] else '#fff'
            s.append(f'<circle cx="{cx+j*gap+gap}" cy="{y_d}" r="{r}" fill="{fill}"/>')
    s.append('</g>')
    for i, t in enumerate(secs):
        cx = x0 + i * colw
        s.append(f'<text x="{cx+3*gap}" y="26" font-size="12" text-anchor="middle">{t}. sekunda</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _zarovky()

# ---------- Úlohy ----------

B = ['zs2', 'r7']  # 7. ročník ZŠ / šestileté obory (přijímačky do 1. ročníku šestiletého gymnázia)

PROBLEMS = [
    {'name': 'CERMAT M7B 2021 – úloha 1',
     'zad': ['Vypočtěte: $0{,}012 : 0{,}4 + 0{,}2 \\cdot 0{,}2 =$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}012 : 0{,}4 = 0{,}03$; $0{,}2 \\cdot 0{,}2 = 0{,}04$; součet $0{,}03 + 0{,}04 = 0{,}07$.'],
     'ans': '$0{,}07$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 2',
     'zad': [
         'Na číselné ose je zobrazeno deset stejných dílků, číslo $A=\\frac{1}{4}$, číslo $B=0{,}75$ a neznámé číslo $C$ (viz obrázek).',
         '2.1 K odpovídajícímu bodu číselné osy zapište číslo $0$ a bod na ose zvýrazněte.',
         '2.2 Určete číslo $C$.'],
     'opts': None, 'ln': 3, 'svg': SVG2, 'fn': 'ciselna-osa.svg',
     'alt': 'Číselná osa s jedenácti dílky; vyznačené body C, A (rovno jedné čtvrtině) a B (rovno nula celá sedmdesát pět).',
     'cap': 'Číselná osa s body C, A, B',
     'sol': [
         '2.1 Jeden dílek má velikost $\\frac{1}{8}$ (od $A=\\frac{2}{8}$ k $B=\\frac{6}{8}$ jsou $4$ dílky). Číslo $0$ leží dva dílky vlevo od bodu $A$.',
         '2.2 Bod $C$ leží pět dílků vlevo od $A$: $C=\\frac{2}{8}-\\frac{5}{8}=-\\frac{3}{8}$.'],
     'ans': '2.1: číslo $0$ leží dva dílky vlevo od bodu $A$; 2.2: $C=-\\frac{3}{8}$',
     'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{9}{10}-\\frac{5}{4}+\\frac{1}{2}\\right)\\cdot 5 =$'],
     'opts': None, 'ln': 2,
     'sol': ['Společný jmenovatel $20$: $\\frac{18}{20}-\\frac{25}{20}+\\frac{10}{20}=\\frac{3}{20}$. Po vynásobení: $\\frac{3}{20}\\cdot 5=\\frac{15}{20}=\\frac{3}{4}$.'],
     'ans': '$\\frac{3}{4}$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{3}{4}\\cdot\\frac{8}{9}-1\\right):\\frac{5}{6} =$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{3}{4}\\cdot\\frac{8}{9}=\\frac{24}{36}=\\frac{2}{3}$; $\\frac{2}{3}-1=-\\frac{1}{3}$; $-\\frac{1}{3}:\\frac{5}{6}=-\\frac{1}{3}\\cdot\\frac{6}{5}=-\\frac{6}{15}=-\\frac{2}{5}$.'],
     'ans': '$-\\frac{2}{5}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 4.1',
     'zad': ['Obdélník o obsahu $2$ m² jsme rozdělili na osm shodných trojúhelníků. Vypočtěte v cm² obsah jednoho trojúhelníku.'],
     'opts': None, 'ln': 2,
     'sol': ['$2$ m² $=20\\,000$ cm². Jeden z osmi shodných trojúhelníků má obsah $20\\,000:8=2\\,500$ cm².'],
     'ans': '$2\\,500$ cm²', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 4.2',
     'zad': ['Při příjezdu na letiště bylo ohlášené zpoždění odletu letadla $1$ hodina a $50$ minut, ale nakonec bylo zpoždění šestkrát delší. Vypočtěte v hodinách, jaké bylo nakonec zpoždění odletu letadla.'],
     'opts': None, 'ln': 2,
     'sol': ['$1$ h $50$ min $=110$ min. Šestkrát delší: $6\\cdot 110=660$ min $=11$ hodin.'],
     'ans': '$11$ hodin', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2021 – úloha 5',
     'zad': [
         'V zelené krabičce jsou jen zelené kuličky, v bílé krabičce jen bílé kuličky a v modré krabičce jen modré kuličky. V těchto třech krabičkách je dohromady $180$ kuliček. Modrých kuliček je o $10$ více než bílých. Aby byl ve všech třech krabičkách stejný počet kuliček, ze zelené krabičky vyndáme $40$ kuliček a rozdělíme je do zbývajících dvou krabiček.',
         '5.1 Určete počet všech zelených kuliček.',
         '5.2 Určete, kolik zelených kuliček přendáme do bílé krabičky.',
         '5.3 Určete počet všech modrých kuliček.'],
     'opts': None, 'ln': 3,
     'sol': [
         '5.1 Ve všech třech krabičkách má nakonec být $180:3=60$ kuliček. Zelená měla o $40$ více, tj. $60+40=100$ kuliček.',
         '5.2 Bílých a modrých je dohromady $180-100=80$; z rovnice $b+(b+10)=80$ plyne $b=35$ bílých a $45$ modrých. Do bílé přendáme $60-35=25$ kuliček.',
         '5.3 Modrých kuliček je $45$.'],
     'ans': '5.1: $100$ zelených kuliček; 5.2: $25$ zelených kuliček; 5.3: $45$ modrých kuliček',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2021 – úloha 6',
     'zad': [
         'Třídy 7. A a 7. B se zúčastnily soutěže, která měla tři kola. V tabulce jsou uvedeny počty bodů, které třídy získaly v jednotlivých kolech soutěže, některé údaje však chybí.',
         '6.1 Třída 7. A získala v každém následujícím kole vždy o $25\\,\\%$ bodů více než v kole předchozím. Vypočtěte, kolik bodů v soutěži získaly dohromady obě třídy.',
         '6.2 Třída 7. B získala v 1. kole o $6$ bodů více než ve 2. kole a ve 3. kole dvakrát více bodů než ve 2. kole. Vypočtěte, kolik bodů získaly dohromady obě třídy ve 2. kole soutěže.'],
     'opts': None, 'ln': 4, 'svg': SVG6, 'fn': 'tabulka-soutez.svg',
     'alt': 'Tabulka bodů tříd 7. A a 7. B ve třech kolech; známé údaje jsou 40 bodů u 7. A ve 2. kole a součet 138 bodů u 7. B.',
     'cap': 'Počty bodů získaných v jednotlivých kolech',
     'sol': [
         '6.1 Třída 7. A ve 2. kole $40$ bodů; 1. kolo $40:1{,}25=32$, 3. kolo $40\\cdot 1{,}25=50$. Součet 7. A $=32+40+50=122$. Obě třídy $122+138=260$ bodů.',
         '6.2 Označme body 7. B ve 2. kole $y$: $(y+6)+y+2y=138$, tj. $4y+6=138$, $y=33$. Ve 2. kole obě třídy $40+33=73$ bodů.'],
     'ans': '6.1: $260$ bodů; 6.2: $73$ bodů', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['procenta', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2021 – úloha 7',
     'zad': [
         'Dva shodné obdélníky mají rozměry $2$ cm a $6$ cm. Jeden z obdélníků byl rozstřižen na dva nestejné obdélníkové díly. Poměr obsahů většího a menšího dílu je $3:1$. K sestavení nového obrazce se použil jeden celý obdélník a větší díl druhého obdélníku (viz obrázek).',
         '7.1 Vypočtěte v cm² obsah nového obrazce.',
         '7.2 Vypočtěte v cm obvod nového obrazce.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'novy-obrazec.svg',
     'alt': 'Dva obdélníky dva krát šest centimetrů, jeden rozstřižený v poměru tři ku jedné, a nový obrazec ve tvaru písmene L.',
     'cap': 'Obdélníky a nový obrazec',
     'sol': [
         '7.1 Obdélník má obsah $2\\cdot 6=12$ cm². Větší díl je $\\frac{3}{4}$ z $12$, tj. $9$ cm². Nový obrazec: $12+9=21$ cm².',
         '7.2 Větší díl má rozměry $2$ cm a $4{,}5$ cm. Nový obrazec ve tvaru L má obvod $6+6{,}5+2+4{,}5+4+2=25$ cm.'],
     'ans': '7.1: $21$ cm²; 7.2: $25$ cm', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 8',
     'zad': [
         'V rovině leží body $D$, $K$, $L$ a přímka $o$ (viz obrázek). Bod $D$ je vrchol rovnoběžníku $ABCD$. V osové souměrnosti s osou $o$ je bod $K$ obrazem vrcholu $A$ rovnoběžníku $ABCD$ a bod $L$ obrazem vrcholu $B$ tohoto rovnoběžníku.',
         '8.1 Sestrojte vrcholy $A$, $B$ rovnoběžníku $ABCD$ a označte je písmeny.',
         '8.2 Sestrojte vrchol $C$ rovnoběžníku $ABCD$, označte jej písmenem a rovnoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'body-DKL-o.svg',
     'alt': 'Body D, K, L a šikmá přímka o v rovině.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': [
         'Vrcholy $A$, $B$ získáme jako obrazy bodů $K$, $L$ v osové souměrnosti podle osy $o$ (pata kolmice z $K$, resp. $L$ na osu $o$ a nanesení stejné vzdálenosti na opačnou stranu). Vrchol $C$ doplníme tak, aby čtyřúhelník $ABCD$ byl rovnoběžník (strana $CD$ je rovnoběžná a shodná se stranou $BA$).'],
     'ans': 'Konstrukce rovnoběžníku $ABCD$: $A$, $B$ jsou obrazy bodů $K$, $L$ v osové souměrnosti podle osy $o$; vrchol $C$ dopočteme (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 9',
     'zad': [
         'V rovině leží body $C$, $S_1$ a $S_2$ (viz obrázek). Bod $C$ je vrchol trojúhelníku $ABC$ a body $S_1$, $S_2$ jsou středy dvou stran tohoto trojúhelníku.',
         'Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna $3$ řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-C-S1-S2.svg',
     'alt': 'Body C, S1 a S2 v rovině.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': [
         'Body $S_1$, $S_2$ jsou středy dvou z tří stran trojúhelníku. Podle toho, které dvě strany mají tyto středy, vznikají tři řešení (dvojice stran $CA$ a $CB$, $CA$ a $AB$, $CB$ a $AB$). V každém případě dopočteme zbývající vrcholy tak, aby $S_1$, $S_2$ byly středy příslušných stran; celkem tři různé trojúhelníky $ABC$.'],
     'ans': 'Tři řešení: podle volby, které dvě strany mají středy $S_1$, $S_2$, vzniknou tři různé trojúhelníky $ABC$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 8, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 10',
     'zad': [
         'V grafu jsou znázorněny počty dívek a počty chlapců v jazykových školách A a B. Ve škole A je v každé třídě $10$ dětí a ve škole B je v každé třídě $20$ dětí.',
         'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).',
         '10.1 Ve škole A je o polovinu méně chlapců než ve škole B.',
         '10.2 Ve škole B je o třetinu více chlapců než dívek.',
         '10.3 Ve škole B je o třetinu méně tříd než ve škole A.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'graf-skoly.svg',
     'alt': 'Sloupcový graf počtu dětí: dívky ve škole A devadesát, ve škole B osmdesát; chlapci ve škole A šedesát, ve škole B sto dvacet.',
     'cap': 'Počty dívek a chlapců ve školách A a B',
     'sol': [
         '10.1 Chlapci: škola A $60$, škola B $120$; $60$ je polovina ze $120$. Pravda (Ano).',
         '10.2 Ve škole B: chlapců $120$, dívek $80$; $120$ je o polovinu (ne o třetinu) více než $80$. Nepravda (Ne).',
         '10.3 Tříd: škola A $(90+60):10=15$, škola B $(80+120):20=10$; $10$ je o třetinu méně než $15$. Pravda (Ano).'],
     'ans': '10.1: Ano; 10.2: Ne; 10.3: Ano', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2021 – úloha 11',
     'zad': [
         'V dětské hře se smí provádět pouze následující nákupy: za $5$ mincí lze koupit $6$ panáčků, za $20$ mincí lze koupit $9$ zvířátek.',
         'Pepa si chce koupit stejný počet panáčků jako zvířátek. Kolik nejméně mincí k takovému nákupu potřebuje?'],
     'opts': ['A) méně než $55$ mincí', 'B) $55$ mincí', 'C) $85$ mincí', 'D) $110$ mincí', 'E) více než $110$ mincí'],
     'ln': 0,
     'sol': ['Panáčci se kupují po $6$, zvířátka po $9$; nejmenší společný počet je $18$. $18$ panáčků $=3\\cdot 5=15$ mincí, $18$ zvířátek $=2\\cdot 20=40$ mincí. Celkem $15+40=55$ mincí.'],
     'ans': 'B) $55$ mincí', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2021 – úloha 12',
     'zad': [
         'Celý povrch dřevěného kvádru, jehož síť je na obrázku, jsme obarvili modrou barvou. Obarvený kvádr jsme beze zbytku rozřezali na malé krychličky o hraně délky $1$ cm.',
         'Kolik krychliček vzniklo rozřezáním kvádru?'],
     'opts': ['A) $10$', 'B) $20$', 'C) $28$', 'D) $48$', 'E) jiný počet'],
     'ln': 0, 'svg': SVG_KVADR, 'fn': 'sit-kvadru.svg',
     'alt': 'Síť kvádru ve tvaru kříže; hrany kvádru jsou 2 cm, 2 cm a 5 cm.',
     'cap': 'Síť kvádru',
     'sol': ['Kvádr má rozměry $2\\times 2\\times 5$ cm, objem $2\\cdot 2\\cdot 5=20$ cm³. Vznikne $20$ krychliček o hraně $1$ cm.'],
     'ans': 'B) $20$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 13',
     'zad': [
         'Celý povrch dřevěného kvádru, jehož síť je na obrázku, jsme obarvili modrou barvou. Obarvený kvádr jsme beze zbytku rozřezali na malé krychličky o hraně délky $1$ cm.',
         'Kolik vzniklých krychliček má právě dvě modré stěny?'],
     'opts': ['A) $6$', 'B) $8$', 'C) $12$', 'D) $20$', 'E) jiný počet'],
     'ln': 0, 'svg': SVG_KVADR, 'fn': 'sit-kvadru.svg',
     'alt': 'Síť kvádru ve tvaru kříže; hrany kvádru jsou 2 cm, 2 cm a 5 cm.',
     'cap': 'Síť kvádru',
     'sol': ['Právě dvě obarvené stěny mají krychličky ležící na hranách kvádru (mimo rohy). U kvádru $2\\times 2\\times 5$ jsou to jen krychličky na čtyřech hranách délky $5$: $4\\cdot(5-2)=12$ krychliček.'],
     'ans': 'C) $12$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 14',
     'zad': [
         'Lichoběžník $ABCD$ má základny $AB$, $CD$, vnitřní úhly při vrcholech $A$, $C$ mají velikosti $\\alpha$, $\\gamma$. Úhly označené v obrázku stejnými písmeny mají stejnou velikost (viz obrázek).',
         'Jaký je součet velikostí úhlů $\\alpha+\\gamma$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) $80^\\circ$', 'B) $85^\\circ$', 'C) $90^\\circ$', 'D) $100^\\circ$', 'E) větší než $100^\\circ$'],
     'ln': 0, 'svg': SVG14, 'fn': 'lichobeznik-uhly.svg',
     'alt': 'Lichoběžník ABCD se základnami AB a CD, s úhlopříčkou DB a úsečkou z vrcholu D; vyznačené úhly alfa, dva alfa a několik gama.',
     'cap': 'Lichoběžník s vyznačenými úhly',
     'sol': [
         'Protože $AB\\parallel CD$, je úhel $DBC=\\gamma$ (vyznačen) a úhel $DBA=\\gamma$ (střídavý úhel k úhlu $BDC$). Vnitřní úhel při vrcholu $B$ je tedy $2\\gamma$, při vrcholu $C$ je $\\gamma$; jejich součet je $180^\\circ$, takže $3\\gamma=180^\\circ$ a $\\gamma=60^\\circ$.',
         'Vnitřní úhel při vrcholu $D$ je $2\\alpha+2\\gamma$, při vrcholu $A$ je $\\alpha$; jejich součet je $180^\\circ$: $3\\alpha+2\\gamma=180^\\circ$, odtud $\\alpha=20^\\circ$. Součet $\\alpha+\\gamma=20^\\circ+60^\\circ=80^\\circ$.'],
     'ans': 'A) $80^\\circ$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2021 – úloha 15',
     'zad': [
         'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
         '15.1 Škola má celkem $250$ žáků, ale dnes je ve škole jen $200$ žáků, ostatní chybí. Kolik procent žáků školy dnes chybí?',
         '15.2 Ze $132$ žáků školy se pět šestin zúčastnilo soutěže. Nejlepších $33$ žáků bylo za úspěch v soutěži odměněno. Kolik procent soutěžících žáků bylo odměněno?',
         '15.3 Obor A studuje $270$ žáků, což je $18\\,\\%$ všech žáků školy. Obor B téže školy studuje $480$ žáků. Kolik procent žáků školy studuje obor B?'],
     'opts': ['A) $20\\,\\%$', 'B) $25\\,\\%$', 'C) $27\\,\\%$', 'D) $30\\,\\%$', 'E) $32\\,\\%$', 'F) jiný počet procent'],
     'ln': 0,
     'sol': [
         '15.1 Chybí $250-200=50$ žáků; $\\frac{50}{250}=20\\,\\%$ → A.',
         '15.2 Soutěžilo $\\frac{5}{6}\\cdot 132=110$ žáků; odměněno $33$; $\\frac{33}{110}=30\\,\\%$ → D.',
         '15.3 Všech žáků $\\frac{270}{0{,}18}=1\\,500$; obor B $\\frac{480}{1\\,500}=32\\,\\%$ → E.'],
     'ans': '15.1: A ($20\\,\\%$); 15.2: D ($30\\,\\%$); 15.3: E ($32\\,\\%$)',
     'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2021 – úloha 16',
     'zad': [
         'Ve výloze obchodu jsou dvě reklamní lišty se žárovkami. Na kratší liště jsou $4$ žárovky a na delší liště je $6$ žárovek. Na počátku žádná žárovka nesvítí. Na kratší i delší liště se v 1. sekundě rozsvítí první žárovka zleva, ve 2. sekundě ještě druhá žárovka, ve 3. sekundě ještě třetí žárovka atd. Jakmile jsou na některé liště rozsvíceny všechny žárovky, od další sekundy začínají žárovky na této liště postupně zhasínat, a to ve stejném pořadí, v němž se rozsvěcovaly. Jakmile na liště zhasnou všechny žárovky, od další sekundy se začnou žárovky opět rozsvěcovat. Celý cyklus se u každé lišty opakuje stále dokola (viz obrázek).',
         '16.1 Určete, v kolikáté sekundě bude poprvé na kratší liště rozsvíceno více žárovek než na delší liště.',
         '16.2 Určete, kolik žárovek bude rozsvíceno na delší liště v 57. sekundě.',
         '16.3 Určete, kolik žárovek bude dohromady rozsvíceno na obou lištách v 91. sekundě.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'zarovky.svg',
     'alt': 'Schéma rozsvěcování žárovek na kratší liště (4 žárovky) a delší liště (6 žárovek) v prvních šesti sekundách.',
     'cap': 'Rozsvěcování žárovek v prvních sekundách',
     'sol': [
         '16.1 Počet svítících žárovek na kratší liště se opakuje s periodou $8$ ($1,2,3,4,3,2,1,0$), na delší s periodou $12$ ($1,2,3,4,5,6,5,4,3,2,1,0$). Poprvé je na kratší liště více žárovek v $11.$ sekundě (kratší $3$, delší $1$).',
         '16.2 $57=4\\cdot 12+9$, tedy jako v $9.$ sekundě: na delší liště svítí $3$ žárovky.',
         '16.3 Kratší: $91=11\\cdot 8+3$, tj. $3$ žárovky; delší: $91=7\\cdot 12+7$, tj. $5$ žárovek. Dohromady $3+5=8$ žárovek.'],
     'ans': '16.1: v $11.$ sekundě; 16.2: $3$ žárovky; 16.3: $8$ žárovek',
     'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PBD21C0T02'
    gen.YEAR = 2021

    def dollars_ok(s):
        return s.count('$') % 2 == 0
    errors = []
    names = set()
    for p in PROBLEMS:
        if p['name'] in names:
            errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t):
                errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'):
            errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try:
                json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e:
                errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:')
        [print('  -', e) for e in errors]
        sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7B-2021')):
        tot += k
        print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
