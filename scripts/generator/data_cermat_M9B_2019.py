# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2019, MATEMATIKA 9 (čtyřleté obory), varianta B (2. řádný termín).
# Kód testu: M9PBD19C0T02. 16 úloh; po rozdělení izolovaných početních podúloh (2,3,4,5) => 21 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno výpočtem; konstrukce dle obrázků v KSR.
# SVG bez apostrofů a zpětných lomítek; matematika v $...$; desetinná čárka $0{,}25$; stupně ^\circ.

# ---------- SVG obrázky (bez ' a \) ----------

# úloha 7: nájezdová rampa – trojboký hranol (schematicky), výška 5 dm, hloubka 12 dm
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 260" font-family="sans-serif">
<polygon points="150,50 400,180 445,150 195,20" fill="#d7d7d7" stroke="#000" stroke-width="2"/>
<polygon points="90,70 90,200 400,200" fill="#efefef" stroke="#000" stroke-width="2"/>
<polygon points="150,50 150,180 400,180" fill="none" stroke="#000" stroke-width="1.5" stroke-dasharray="5 4"/>
<line x1="90" y1="70" x2="150" y2="50" stroke="#000" stroke-width="1.5"/>
<line x1="90" y1="200" x2="150" y2="180" stroke="#000" stroke-width="1.5"/>
<line x1="400" y1="200" x2="400" y2="180" stroke="#000" stroke-width="1.5"/>
<path d="M 106 200 L 106 184 L 90 184" fill="none" stroke="#000" stroke-width="1.2"/>
<text x="70" y="140" font-size="15" text-anchor="middle">5 dm</text>
<text x="245" y="220" font-size="15" text-anchor="middle">12 dm</text>
<text x="300" y="95" font-size="14" text-anchor="middle" fill="#333">čtvercová deska</text>
</svg>"""

# úloha 8: čtverec rozdělený 4 svislými a 1 vodorovnou úsečkou na 10 shodných obdélníků
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 260" font-family="sans-serif">
<rect x="30" y="30" width="200" height="200" fill="none" stroke="#000" stroke-width="2.5"/>
<line x1="70" y1="30" x2="70" y2="230" stroke="#000" stroke-width="1.3"/>
<line x1="110" y1="30" x2="110" y2="230" stroke="#000" stroke-width="1.3"/>
<line x1="150" y1="30" x2="150" y2="230" stroke="#000" stroke-width="1.3"/>
<line x1="190" y1="30" x2="190" y2="230" stroke="#000" stroke-width="1.3"/>
<line x1="30" y1="130" x2="230" y2="130" stroke="#000" stroke-width="1.3"/>
</svg>"""

# úloha 9: svislá přímka p procházející bodem A (nahoře), bod B vlevo dole
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 400" font-family="sans-serif">
<line x1="280" y1="60" x2="280" y2="370" stroke="#000" stroke-width="2"/>
<text x="292" y="366" font-size="18" font-style="italic">p</text>
<line x1="270" y1="90" x2="290" y2="90" stroke="#000" stroke-width="2"/>
<text x="298" y="96" font-size="18" font-style="italic">A</text>
<text x="188" y="252" font-size="20" text-anchor="middle">×</text>
<text x="188" y="274" font-size="18" font-style="italic" text-anchor="middle">B</text>
</svg>"""

# úloha 10: přímka p protínající kružnici k se středem S, bod A jeden z průsečíků
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 400" font-family="sans-serif">
<circle cx="260" cy="200" r="140" fill="none" stroke="#000" stroke-width="2"/>
<text x="176" y="118" font-size="18" font-style="italic">k</text>
<text x="272" y="206" font-size="20" text-anchor="middle">×</text>
<text x="284" y="224" font-size="18" font-style="italic">S</text>
<line x1="60" y1="300" x2="440" y2="250" stroke="#000" stroke-width="2"/>
<text x="66" y="288" font-size="18" font-style="italic">p</text>
<text x="150" y="296" font-size="20" text-anchor="middle">×</text>
<text x="142" y="316" font-size="18" font-style="italic" text-anchor="middle">A</text>
</svg>"""

# úloha 11: tabulka počtu hovorů (chybějící údaje prázdné)
def _table11():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250" font-family="sans-serif" font-size="15">']
    # vnější a vnitřní čáry
    s.append('<rect x="20" y="20" width="560" height="210" fill="none" stroke="#000" stroke-width="1.6"/>')
    for x in (150, 450):
        s.append(f'<line x1="{x}" y1="20" x2="{x}" y2="230" stroke="#000"/>')
    for x in (250, 350):
        s.append(f'<line x1="{x}" y1="55" x2="{x}" y2="230" stroke="#000"/>')
    s.append('<line x1="150" y1="55" x2="450" y2="55" stroke="#000"/>')
    for y in (90, 125, 160, 195):
        s.append(f'<line x1="20" y1="{y}" x2="580" y2="{y}" stroke="#000"/>')
    # záhlaví
    s.append('<text x="300" y="42" text-anchor="middle">Počet hovorů</text>')
    s.append('<text x="515" y="47" text-anchor="middle">Aritmetický průměr</text>')
    s.append('<text x="515" y="72" text-anchor="middle">za měsíc</text>')
    for x, t in ((200, 'Leden'), (300, 'Únor'), (400, 'Březen')):
        s.append(f'<text x="{x}" y="80" text-anchor="middle">{t}</text>')
    # řádky
    for y, t in ((110, 'Aleš'), (145, 'Běla'), (180, 'Cyril'), (215, 'Součet')):
        s.append(f'<text x="85" y="{y}" text-anchor="middle">{t}</text>')
    # hodnoty
    s.append('<text x="400" y="110" text-anchor="middle">12</text>')
    s.append('<text x="300" y="145" text-anchor="middle">12</text>')
    s.append('<text x="300" y="180" text-anchor="middle">9</text>')
    s.append('<text x="515" y="180" text-anchor="middle">9</text>')
    s.append('<text x="200" y="215" text-anchor="middle">36</text>')
    s.append('</svg>')
    return ''.join(s)
SVG11 = _table11()

# úloha 12: trojúhelník; vrchol nahoře rozdělen na tři shodné úhly, svislá výška, 116° u paty, úhly α, β
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 300" font-family="sans-serif">
<line x1="60" y1="250" x2="520" y2="250" stroke="#000" stroke-width="2"/>
<line x1="240" y1="50" x2="60" y2="250" stroke="#000" stroke-width="2"/>
<line x1="240" y1="50" x2="240" y2="250" stroke="#000" stroke-width="1.4"/>
<line x1="240" y1="50" x2="360" y2="250" stroke="#000" stroke-width="1.4"/>
<line x1="240" y1="50" x2="520" y2="250" stroke="#000" stroke-width="2"/>
<path d="M 226 250 L 226 236 L 240 236" fill="none" stroke="#000" stroke-width="1.2"/>
<text x="200" y="118" font-size="17" font-style="italic">φ</text>
<text x="240" y="112" font-size="17" font-style="italic" text-anchor="middle">φ</text>
<text x="278" y="120" font-size="17" font-style="italic">φ</text>
<text x="82" y="242" font-size="17" font-style="italic">α</text>
<text x="500" y="242" font-size="17" font-style="italic">β</text>
<text x="352" y="240" font-size="15" text-anchor="middle">116°</text>
</svg>"""

# úloha 13: jedno z nových těles – čtvrtinový válec (schematicky), r = 5 cm; nové plochy bílé
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 300" font-family="sans-serif">
<path d="M 80 115 L 80 255 A 95 34 0 0 0 250 255 L 250 115 A 95 34 0 0 1 80 115 Z" fill="#c9c9c9" stroke="#000" stroke-width="1.5"/>
<path d="M 160 80 L 80 115 L 80 255 L 160 220 Z" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<path d="M 160 80 L 250 115 L 250 255 L 160 220 Z" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<path d="M 160 80 L 80 115 A 95 34 0 0 0 250 115 Z" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/>
<line x1="160" y1="80" x2="250" y2="115" stroke="#000" stroke-width="1"/>
<text x="212" y="86" font-size="14" text-anchor="middle">5 cm</text>
<text x="165" y="285" font-size="14" text-anchor="middle" fill="#333">jedno nové těleso</text>
</svg>"""

# ---------- Úlohy ----------

B = ['zs2', 'r9']

PROBLEMS = [
    # ---- úloha 1 (samostatné "Vypočtěte") ----
    {'name': 'CERMAT M9B 2019 – úloha 1',
     'zad': ['Vypočtěte, kolik procent z $20$ tun tvoří $500$ kilogramů.'],
     'opts': None, 'ln': 2,
     'sol': ['$20$ tun $=20\\,000$ kg. Podíl $\\frac{500}{20\\,000}=0{,}025=2{,}5\\,\\%$.'],
     'ans': '$2{,}5\\,\\%$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['procenta', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    # ---- úloha 2 (izolované "Vypočtěte" 2.1, 2.2 -> samostatné) ----
    {'name': 'CERMAT M9B 2019 – úloha 2.1',
     'zad': ['Vypočtěte: $\\sqrt{10^2\\cdot 0{,}0025}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\sqrt{100\\cdot 0{,}0025}=\\sqrt{0{,}25}=0{,}5$.'],
     'ans': '$0{,}5$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9B 2019 – úloha 2.2',
     'zad': ['Vypočtěte: $5:0{,}2-(-0{,}3+0{,}5)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$5:0{,}2-(-0{,}3+0{,}5)=25-0{,}2=24{,}8$.'],
     'ans': '$24{,}8$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    # ---- úloha 3 (izolované "Vypočtěte" zlomkem, s postupem 3.1, 3.2 -> samostatné) ----
    {'name': 'CERMAT M9B 2019 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{1-\\frac{1}{3}}{-6^2}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel $1-\\frac{1}{3}=\\frac{2}{3}$, jmenovatel $-6^2=-36$. Podíl $\\frac{2}{3}:(-36)=-\\frac{2}{108}=-\\frac{1}{54}$.'],
     'ans': '$-\\frac{1}{54}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9B 2019 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $12\\cdot\\left(\\frac{2}{3}-\\frac{1}{2}\\right)-\\frac{5}{2}+\\frac{2}{3}=$'],
     'opts': None, 'ln': 4,
     'sol': ['$\\frac{2}{3}-\\frac{1}{2}=\\frac{1}{6}$, takže $12\\cdot\\frac{1}{6}=2$. Dále $2-\\frac{5}{2}+\\frac{2}{3}=\\frac{12-15+4}{6}=\\frac{1}{6}$.'],
     'ans': '$\\frac{1}{6}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    # ---- úloha 4 (izolované "Zjednodušte" 4.1, 4.2, 4.3 -> samostatné) ----
    {'name': 'CERMAT M9B 2019 – úloha 4.1',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2a+3b)^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(2a+3b)^2=(2a)^2+2\\cdot 2a\\cdot 3b+(3b)^2=4a^2+12ab+9b^2$.'],
     'ans': '$4a^2+12ab+9b^2$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9B 2019 – úloha 4.2',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky): $3e\\cdot(2-f)-2f\\cdot(e-3f)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$3e\\cdot(2-f)-2f\\cdot(e-3f)=6e-3ef-2ef+6f^2=6e-5ef+6f^2$.'],
     'ans': '$6e-5ef+6f^2$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9B 2019 – úloha 4.3',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(1+3n)\\cdot(1+3n)+(1+3n)\\cdot(1-3n)-2=$'],
     'opts': None, 'ln': 3,
     'sol': ['$(1+3n)^2=1+6n+9n^2$; $(1+3n)(1-3n)=1-9n^2$. Součet $1+6n+9n^2+1-9n^2-2=6n$.'],
     'ans': '$6n$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    # ---- úloha 5 (izolované "Řešte rovnici" 5.1, 5.2 -> samostatné) ----
    {'name': 'CERMAT M9B 2019 – úloha 5.1',
     'zad': ['Řešte rovnici: $2\\cdot(3-0{,}75x)+x=7-\\dfrac{x}{2}$'],
     'opts': None, 'ln': 4,
     'sol': ['$6-1{,}5x+x=7-0{,}5x$, tj. $6-0{,}5x=7-0{,}5x$. Po odečtení $-0{,}5x$ zbyde $6=7$, což neplatí. Rovnice nemá řešení.'],
     'ans': 'Rovnice nemá řešení.', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9B 2019 – úloha 5.2',
     'zad': ['Řešte rovnici: $\\dfrac{5}{6}\\cdot(y-2)-\\dfrac{2}{3}\\cdot y=\\dfrac{y}{2}-\\dfrac{5}{4}$'],
     'opts': None, 'ln': 4,
     'sol': ['Levá strana: $\\frac{5}{6}y-\\frac{5}{3}-\\frac{2}{3}y=\\frac{1}{6}y-\\frac{5}{3}$. Rovnice $\\frac{1}{6}y-\\frac{5}{3}=\\frac{1}{2}y-\\frac{5}{4}$; vynásobením $12$: $2y-20=6y-15$, odtud $-5=4y$, tedy $y=-1{,}25$.'],
     'ans': '$y=-1{,}25$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    # ---- úloha 6 (sdílený kontext minibagr; 6.1–6.3 jedna úloha) ----
    {'name': 'CERMAT M9B 2019 – úloha 6',
     'zad': [
        'Zadaná práce byla rozdělena na dvě stejné části. První polovinu práce vykonal minibagr za $10$ hodin. Druhou polovinu práce pak vykonali společně $4$ dělníci. Minibagr udělá za každých $5$ hodin stejný díl práce jako $5$ dělníků za $8$hodinovou pracovní dobu. (Každý dělník vykoná za hodinu stejné množství práce.) Za půjčení $1$ minibagru se platí jednorázový poplatek $1\\,500$ korun, každá hodina práce minibagru (i s obsluhou) stojí $600$ korun a hodina práce $1$ dělníka $150$ korun.',
        '6.1 Vypočtěte, kolik korun se celkem zaplatilo za půjčení a práci minibagru (i s obsluhou).',
        '6.2 Vypočtěte, kolik korun stála práce vykonaná dělníky.',
        '6.3 Vypočtěte, kolik hodin musel odpracovat každý ze $4$ dělníků.'],
     'opts': None, 'ln': 3,
     'sol': [
        '6.1 Poplatek $1\\,500$ Kč a $10$ hodin práce po $600$ Kč: $1\\,500+10\\cdot 600=7\\,500$ korun.',
        'První polovinu práce zvládl minibagr za $10$ h, což je $2\\times$ výkon „$5$ dělníků za $8$ h", tj. $2\\cdot 5\\cdot 8=80$ dělníkohodin. Druhá (stejná) polovina je také $80$ dělníkohodin.',
        '6.2 Dělníci odpracovali $80$ hodin po $150$ Kč: $80\\cdot 150=12\\,000$ korun.',
        '6.3 $80$ dělníkohodin rozdělených mezi $4$ dělníky: $80:4=20$ hodin na každého.'],
     'ans': '6.1: $7\\,500$ korun; 6.2: $12\\,000$ korun; 6.3: $20$ hodin',
     'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    # ---- úloha 7 (sdílený kontext rampa + obrázek; 7.1, 7.2 jedna úloha) ----
    {'name': 'CERMAT M9B 2019 – úloha 7',
     'zad': [
        'Nájezdová rampa sestavená ze čtyř dřevotřískových desek je přistavena ke schodu. Nakloněnou čtvercovou desku rampy podpírají tři stejné trojúhelníkové desky. Hloubka rampy je $12$ dm a výška rampy je $5$ dm. Tloušťku desky neuvažujte.',
        'Vypočtěte, kolik dm² dřevotřísky je v hotové rampě použito',
        '7.1 na všechny tři trojúhelníkové desky dohromady,',
        '7.2 na čtvercovou desku.'],
     'opts': None, 'ln': 2, 'svg': SVG7, 'fn': 'rampa.svg',
     'alt': 'Nájezdová rampa jako trojboký hranol; svislá výška 5 dm, vodorovná hloubka 12 dm, nakloněná čtvercová deska nahoře.',
     'cap': 'Schematický nákres rampy (výška 5 dm, hloubka 12 dm)',
     'sol': [
        '7.1 Každá trojúhelníková deska je pravoúhlý trojúhelník s odvěsnami $5$ dm a $12$ dm, obsah $\\frac{5\\cdot 12}{2}=30$ dm². Tři desky: $3\\cdot 30=90$ dm².',
        '7.2 Strana čtvercové desky je přepona: $\\sqrt{5^2+12^2}=\\sqrt{169}=13$ dm. Obsah $13^2=169$ dm².'],
     'ans': '7.1: $90$ dm²; 7.2: $169$ dm²',
     'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    # ---- úloha 8 (sdílený kontext čtverec + obrázek; 8.1, 8.2 jedna úloha) ----
    {'name': 'CERMAT M9B 2019 – úloha 8',
     'zad': [
        'Čtverec je rozdělen čtyřmi svislými úsečkami a jednou vodorovnou úsečkou na $10$ shodných malých obdélníků. Každý z malých obdélníků má obvod $42$ cm.',
        '8.1 Vyjádřete v základním tvaru poměr délek sousedních stran jednoho malého obdélníku.',
        '8.2 Vypočtěte v cm délku strany čtverce.'],
     'opts': None, 'ln': 2, 'svg': SVG8, 'fn': 'ctverec-obdelniky.svg',
     'alt': 'Čtverec rozdělený čtyřmi svislými a jednou vodorovnou úsečkou na 10 shodných obdélníků (5 sloupců, 2 řady).',
     'cap': 'Čtverec rozdělený na 10 shodných obdélníků',
     'sol': [
        'Čtverec je rozdělen na $5$ sloupců a $2$ řady. Má-li čtverec stranu $a$, malý obdélník má rozměry $\\frac{a}{5}$ a $\\frac{a}{2}$.',
        '8.1 Poměr sousedních stran $\\frac{a}{5}:\\frac{a}{2}=2:5$ (příp. $5:2$).',
        '8.2 Obvod obdélníku $2\\left(\\frac{a}{5}+\\frac{a}{2}\\right)=2\\cdot\\frac{7a}{10}=\\frac{7a}{5}=42$, odtud $a=30$ cm.'],
     'ans': '8.1: $2:5$ (příp. $5:2$); 8.2: $30$ cm',
     'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    # ---- úloha 9 (konstrukce – rovnoramenný trojúhelník) ----
    {'name': 'CERMAT M9B 2019 – úloha 9',
     'zad': [
        'V rovině leží bod $B$ a přímka $p$, která prochází bodem $A$ (viz obrázek).',
        'Body $A$, $B$ jsou vrcholy rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Rameno $AC$ leží na přímce $p$.',
        'Sestrojte a označte písmenem chybějící vrchol $C$ trojúhelníku $ABC$ a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-p-bod-B.svg',
     'alt': 'Svislá přímka p procházející bodem A poblíž horního okraje a bod B vlevo dole.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': [
        'Trojúhelník má základnu $AB$, takže ramena jsou shodná: $|CA|=|CB|$. Vrchol $C$ tedy leží na ose úsečky $AB$ a zároveň (podle zadání) na přímce $p$. Sestrojíme osu úsečky $AB$ a její průsečík s přímkou $p$ je hledaný vrchol $C$.'],
     'ans': 'Vrchol $C$ je průsečík přímky $p$ s osou úsečky $AB$ (bod, pro který $|CA|=|CB|$); trojúhelník $ABC$ je rovnoramenný se základnou $AB$ – viz obrázek v klíči.',
     'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    # ---- úloha 10 (konstrukce – čtverec, všechna řešení) ----
    {'name': 'CERMAT M9B 2019 – úloha 10',
     'zad': [
        'V rovině leží přímka $p$ a kružnice $k$ se středem $S$. Bod $A$ je jedním ze dvou průsečíků přímky $p$ a kružnice $k$ (viz obrázek).',
        'Bod $A$ je vrchol čtverce $ABCD$, bod $S$ leží uvnitř tohoto čtverce a na přímce $p$ leží strana $AB$. Právě dva ze čtyř vrcholů čtverce $ABCD$ leží na kružnici $k$.',
        'Sestrojte a označte písmeny chybějící vrcholy čtverce $ABCD$ a čtverec narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'primka-kruznice-k.svg',
     'alt': 'Kružnice k se středem S a přímka p, která ji protíná; bod A je levý průsečík přímky p a kružnice k.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': [
        'Strana $AB$ leží na $p$, takže $B$ je na přímce $p$ (druhý průsečík s $k$ nebo bod na $p$ tak, aby právě dva vrcholy ležely na $k$). Čtverec dostavíme kolmicemi a přenesením délky $|AB|$; podmínku „$S$ uvnitř čtverce a právě dva vrcholy na $k$" splňují tři různé čtverce.',
        'Úloha má tři řešení: čtverce s vrcholy $B_1C_1D_1$, $B_2C_2D_2$ a $B_3C_3D_3$.'],
     'ans': 'Tři řešení – čtverce $ABCD$ s vrcholy $B_1C_1D_1$, $B_2C_2D_2$ a $B_3C_3D_3$ (strana $AB$ na přímce $p$, $S$ uvnitř čtverce, právě dva vrcholy na kružnici $k$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    # ---- úloha 11 (sdílený kontext tabulka; Ano/Ne 11.1–11.3 jedna úloha) ----
    {'name': 'CERMAT M9B 2019 – úloha 11',
     'zad': [
        'Do tabulky se zapisují počty telefonních hovorů tří dětí v prvním čtvrtletí kalendářního roku; některé údaje chybí. V lednu měly všechny tři děti stejný počet hovorů. Aleš měl v březnu o třetinu hovorů méně než v únoru. Běla měla v březnu o polovinu hovorů více než v únoru.',
        'Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
        '11.1 V prvním čtvrtletí byl aritmetický průměr počtu hovorů Aleše za měsíc menší než $14$.',
        '11.2 Běla měla za první čtvrtletí celkem $42$ hovorů.',
        '11.3 V březnu měl Cyril třikrát méně hovorů než Běla.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'tabulka-hovory.svg',
     'alt': 'Tabulka počtu hovorů (Leden, Únor, Březen, aritmetický průměr) pro Aleše, Bělu, Cyrila a řádek Součet; vyplněné údaje: Aleš březen 12, Běla únor 12, Cyril únor 9 a průměr 9, součet ledna 36.',
     'cap': 'Počty telefonních hovorů (chybějící údaje jsou prázdné)',
     'sol': [
        'V lednu měly děti stejně, součet $36$, tedy každé $12$. Cyril má průměr $9$, celkem $27$, v březnu $27-12-9=6$. Aleš březen $12=\\frac{2}{3}$ února, tedy únor $18$; Aleš celkem $12+18+12=42$, průměr $14$. Běla březen $=$ únor $+\\frac{1}{2}=18$; celkem $12+12+18=42$, průměr $14$.',
        '11.1 Průměr Aleše je $14$, není menší než $14$ → N.',
        '11.2 Běla celkem $42$ hovorů → A.',
        '11.3 Cyril v březnu $6$, Běla $18$; $18=3\\cdot 6$, tj. třikrát méně → A.'],
     'ans': '11.1: N; 11.2: A; 11.3: A',
     'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    # ---- úloha 12 (výběr z možností + obrázek) ----
    {'name': 'CERMAT M9B 2019 – úloha 12',
     'zad': [
        'V trojúhelníku na obrázku je vrchol rozdělen na tři shodné úhly $\\varphi$, jedna z úseček je kolmá k základně (pravý úhel) a u paty je vyznačen úhel $116^\\circ$; u dolních vrcholů jsou úhly $\\alpha$ a $\\beta$.',
        'Kolik je $\\alpha+\\beta$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) $90^\\circ$', 'B) $92^\\circ$', 'C) $102^\\circ$', 'D) $112^\\circ$', 'E) jiný výsledek'],
     'ln': 0, 'svg': SVG12, 'fn': 'uhly-trojuhelnik.svg',
     'alt': 'Trojúhelník se svislou výškou z horního vrcholu; horní vrchol je rozdělen na tři shodné úhly φ, u paty výšky je pravý úhel a vpravo úhel 116°, u dolních vrcholů úhly α a β.',
     'cap': 'Výchozí obrázek k úloze 12',
     'sol': [
        'V pravoúhlém trojúhelníku s výškou platí $\\alpha=90^\\circ-\\varphi$. Úhel u paty šikmé úsečky je $116^\\circ=90^\\circ+\\varphi$, odtud $\\varphi=26^\\circ$. Vrcholový úhel je $3\\varphi=78^\\circ$, proto $\\alpha+\\beta=180^\\circ-3\\varphi=180^\\circ-78^\\circ=102^\\circ$.'],
     'ans': 'C) $102^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    # ---- úloha 13 (výběr z možností + obrázek) ----
    {'name': 'CERMAT M9B 2019 – úloha 13',
     'zad': [
        'Rotační válec s podstavou o poloměru $5$ cm stojící na vodorovné podložce jsme svislými řezy rozdělili na čtyři shodná nová tělesa. Povrch válce byl šedý (včetně podstav), ale všechny nové plochy vytvořené rozříznutím jsou bílé. Součet obsahů obou bílých ploch na jednom z nových těles je $80$ cm².',
        'Jaký je objem jednoho z nových těles? Výsledek je zaokrouhlen na celé cm³.'],
     'opts': ['A) menší než $125$ cm³', 'B) $126$ cm³', 'C) $141$ cm³', 'D) $157$ cm³', 'E) větší než $158$ cm³'],
     'ln': 0, 'svg': SVG13, 'fn': 'valec-ctvrtina.svg',
     'alt': 'Jedno ze čtyř shodných těles vzniklých rozříznutím válce – čtvrtinový válec se dvěma bílými obdélníkovými řeznými plochami; poloměr 5 cm.',
     'cap': 'Jedno z nových těles (čtvrtina válce)',
     'sol': [
        'Každá bílá plocha je obdélník o rozměrech $r\\times v=5\\times v$. Dvě plochy: $2\\cdot 5\\cdot v=80$, tedy $v=8$ cm. Objem celého válce $\\pi r^2 v=\\pi\\cdot 25\\cdot 8=200\\pi$ cm³; jedna čtvrtina $\\frac{200\\pi}{4}=50\\pi\\doteq 157$ cm³.'],
     'ans': 'D) $157$ cm³', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    # ---- úloha 14 (výběr z možností – sestavení rovnice) ----
    {'name': 'CERMAT M9B 2019 – úloha 14',
     'zad': [
        'Kryštof, Lenka a Marek sbírali do čtvrtlitrových hrnků borůvky. Kryštof naplnil borůvkami třikrát více hrnků než Marek. Lenka naplnila borůvkami o $50\\,\\%$ méně hrnků než Kryštof. Kryštof naplnil borůvkami o $2$ hrnky více než Lenka s Markem dohromady.',
        'Označme $m$ neznámý počet hrnků, které naplnil borůvkami Marek. Ze které z následujících rovnic lze v souladu se zadáním vypočítat $m$?'],
     'opts': ['A) $3m=2{,}5m+2$', 'B) $3m+2=2{,}5m$', 'C) $3m-2=2m+0{,}5$', 'D) $3m=2{,}5m+2{,}5$', 'E) $3m-2=2m+50$'],
     'ln': 0,
     'sol': [
        'Kryštof $3m$, Lenka $0{,}5\\cdot 3m=1{,}5m$. Kryštof je o $2$ větší než Lenka s Markem: $3m=1{,}5m+m+2=2{,}5m+2$.'],
     'ans': 'A) $3m=2{,}5m+2$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    # ---- úloha 15 (přiřazování 15.1–15.3 -> A–F; společná nabídka) ----
    {'name': 'CERMAT M9B 2019 – úloha 15',
     'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 V obchodě, v němž byla $20\\,\\%$ sleva na veškeré zboží, Kamila zaplatila $400$ korun. Kolik korun by zaplatila, kdyby nedostala žádnou slevu?',
        '15.2 Svetr zdražili o $25\\,\\%$ a po čase jej zlevnili na $600$ korun, tedy na $80\\,\\%$ ceny svetru po zdražení. Kolik korun stál svetr ještě před zdražením?',
        '15.3 V obou kapsách mám stejné množství peněz. Nejprve polovinu částky z levé kapsy přendám do pravé kapsy. Když pak dám $50\\,\\%$ částky z pravé kapsy opět do levé kapsy, v levé kapse budu mít $300$ korun. Kolik korun mám dohromady v obou kapsách?'],
     'opts': ['A) $320$ korun', 'B) $480$ korun', 'C) $500$ korun', 'D) $540$ korun', 'E) $600$ korun', 'F) jiný počet korun'],
     'ln': 0,
     'sol': [
        '15.1 $400$ Kč je $80\\,\\%$ ceny, plná cena $\\frac{400}{0{,}8}=500$ korun → C.',
        '15.2 Cena po zdražení: $600=80\\,\\%$, tedy $750$ Kč. Před zdražením $\\frac{750}{1{,}25}=600$ korun → E.',
        '15.3 Nechť v každé kapse $a$. Levá: $a\\to\\frac{a}{2}$; pravá $\\frac{3a}{2}$, z ní $\\frac{3a}{4}$ zpět do levé: levá $\\frac{a}{2}+\\frac{3a}{4}=\\frac{5a}{4}=300\\Rightarrow a=240$; dohromady $2a=480$ korun → B.'],
     'ans': '15.1: C ($500$ korun); 15.2: E ($600$ korun); 15.3: B ($480$ korun)',
     'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},
    # ---- úloha 16 (sdílený kontext program; 16.1–16.3 jedna úloha) ----
    {'name': 'CERMAT M9B 2019 – úloha 16',
     'zad': [
        'Při spuštění programu je obrazovka prázdná. Při každém lichém pípnutí (1., 3., …) se objeví $2$ nové čárky, při každém sudém pípnutí (2., 4., …) se objeví $2$ nové pomlčky. Při každém čtvrtém pípnutí však jedna nová pomlčka překříží jednu čárku a místo nich vidíme plus. Na obrazovce tak mohou být tři symboly: čárka, pomlčka a plus. (Např. při 5. pípnutí je $9$ symbolů: $5$ čárek, $3$ pomlčky a $1$ plus.)',
        'Určete, jaký je na obrazovce počet',
        '16.1 symbolů „pomlčka" při 10. pípnutí,',
        '16.2 všech symbolů při 60. pípnutí,',
        '16.3 symbolů „čárka" právě ve chvíli, kdy se objevil 7. symbol „plus".'],
     'opts': None, 'ln': 3,
     'sol': [
        '16.1 Do 10. pípnutí přibylo na $5$ sudých pípnutích $5\\cdot 2=10$ pomlček, na $2$ čtvrtých pípnutích ($4.$ a $8.$) se $2$ pomlčky změnily v plus. Pomlček je $10-2=8$.',
        '16.2 Do 60. pípnutí: $30$ lichých pípnutí dá $60$ čárek, $30$ sudých dá $60$ pomlček, na $15$ čtvrtých pípnutích vznikne $15$ plus (a ubyde $15$ čárek i $15$ pomlček). Čárky $45$, pomlčky $45$, plus $15$; všech symbolů $45+45+15=105$.',
        '16.3 $7.$ plus vznikne při $7\\cdot 4=28.$ pípnutí. Do 28. pípnutí je $14$ lichých pípnutí ($28$ čárek) a $7$ čtvrtých pípnutí ($7$ čárek se změní v plus): čárek $28-7=21$.'],
     'ans': '16.1: $8$ pomlček; 16.2: $105$ symbolů; 16.3: $21$ čárek',
     'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PBD19C0T02'
    gen.YEAR = 2019

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M9B' not in p['name']: errors.append('Název bez M9B: ' + p['name'])
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9B-2019')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
