# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2018, MATEMATIKA 9 A (čtyřleté obory, 9. ročník),
# 1. řádný termín. Kód testu: M9PAD18C0T01. 16 úloh v testu (50 bodů).
# Po rozdělení nezávislých početních podúloh (2,3,4,5,8) => 22 samostatných úloh.
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno přepočtem.

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

# úloha 7: papírový obdélník 18 x 5 cm, směr stříhání rovnoběžný s kratší stranou
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 150" font-family="sans-serif">
<rect x="30" y="45" width="252" height="70" fill="#eeeeee" stroke="#000" stroke-width="2"/>
<line x1="240" y1="45" x2="240" y2="115" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<text x="156" y="134" font-size="13" text-anchor="middle">18 cm</text>
<text x="292" y="84" font-size="13">5 cm</text>
<text x="250" y="30" font-size="11" text-anchor="middle">směr stříhání</text>
<line x1="255" y1="48" x2="255" y2="72" stroke="#000" stroke-width="1"/>
<polygon points="255,74 251,66 259,66" fill="#000"/>
</svg>"""

# úloha 9: výchozí obrázek – přímka AB a bod M mimo ni
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 240" font-family="sans-serif">
<line x1="40" y1="190" x2="360" y2="190" stroke="#000" stroke-width="2"/>
<line x1="110" y1="184" x2="110" y2="196" stroke="#000"/>
<line x1="290" y1="184" x2="290" y2="196" stroke="#000"/>
<text x="104" y="212" font-size="15" font-style="italic">A</text>
<text x="284" y="212" font-size="15" font-style="italic">B</text>
<text x="300" y="86" font-size="15">×</text>
<text x="298" y="72" font-size="15" font-style="italic">M</text>
</svg>"""

# úloha 10: výchozí obrázek – trojúhelník KLM
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 300" font-family="sans-serif">
<polygon points="70,150 320,90 150,270" fill="none" stroke="#000" stroke-width="2"/>
<text x="50" y="150" font-size="15" font-style="italic">M</text>
<text x="326" y="92" font-size="15" font-style="italic">L</text>
<text x="146" y="288" font-size="15" font-style="italic">K</text>
</svg>"""

# úloha 12: lichoběžník ABCD, úhlopříčka DB, úhly 112°, phí, 2phí, gama, pravý úhel u D
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 200" font-family="sans-serif">
<line x1="10" y1="160" x2="360" y2="160" stroke="#000" stroke-width="1"/>
<polygon points="60,160 300,160 250,60 120,60" fill="none" stroke="#000" stroke-width="2"/>
<line x1="120" y1="60" x2="300" y2="160" stroke="#000" stroke-width="1.5"/>
<text x="110" y="54" font-size="14" font-style="italic">D</text>
<text x="252" y="54" font-size="14" font-style="italic">C</text>
<text x="50" y="176" font-size="14" font-style="italic">A</text>
<text x="304" y="174" font-size="14" font-style="italic">B</text>
<text x="66" y="150" font-size="12">112°</text>
<text x="236" y="82" font-size="13">γ</text>
<text x="262" y="120" font-size="12">2φ</text>
<text x="276" y="152" font-size="12">φ</text>
<circle cx="130" cy="72" r="2.5" fill="#000"/>
</svg>"""

# úloha 14: osově souměrný čtyřúhelník (deltoid) ABCD, osa o, úhlopříčky v bodě P
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 280" font-family="sans-serif">
<line x1="20" y1="140" x2="340" y2="140" stroke="#000" stroke-width="1"/>
<text x="330" y="134" font-size="13" font-style="italic">o</text>
<polygon points="200,50 300,140 200,230 90,140" fill="none" stroke="#000" stroke-width="2"/>
<line x1="200" y1="50" x2="200" y2="230" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<text x="196" y="44" font-size="13" font-style="italic">C</text>
<text x="196" y="248" font-size="13" font-style="italic">A</text>
<text x="76" y="145" font-size="13" font-style="italic">D</text>
<text x="306" y="145" font-size="13" font-style="italic">B</text>
<text x="186" y="135" font-size="12" font-style="italic">P</text>
<text x="208" y="100" font-size="12">12 cm</text>
<text x="242" y="134" font-size="12">16 cm</text>
<text x="118" y="198" font-size="12">13 cm</text>
</svg>"""

# úloha 15.1: šedý obrázek 12 x 8 cm na bílé podložce přesahující o 2 cm
SVG15 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 200" font-family="sans-serif">
<rect x="20" y="25" width="200" height="150" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<rect x="45" y="50" width="150" height="100" fill="#cfcfcf" stroke="#000" stroke-width="1.5"/>
<text x="90" y="95" font-size="13">12 cm</text>
<text x="150" y="116" font-size="13">8 cm</text>
<text x="200" y="103" font-size="10">2 cm</text>
<text x="110" y="170" font-size="10">2 cm</text>
</svg>"""

# úloha 16: shodné čtverce schodovitě rozdělené na světlou (bílou) a tmavou (šedou) plochu
def _stair(ox, oy, n, c):
    out = [f'<rect x="{ox}" y="{oy}" width="{n*c}" height="{n*c}" fill="#ffffff" stroke="#000"/>']
    pts = [f'{ox+c},{oy}', f'{ox+n*c},{oy}', f'{ox+n*c},{oy+(n-1)*c}']
    for step in range(n-1, 0, -1):
        pts.append(f'{ox+step*c},{oy+step*c}')
        pts.append(f'{ox+step*c},{oy+(step-1)*c}')
    joined = " ".join(pts)
    out.append(f'<polygon points="{joined}" fill="#8a8a8a" stroke="#000"/>')
    return "".join(out)

def _svg16():
    c = 16
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 120" font-family="sans-serif">']
    s.append(_stair(20, 20, 3, c))
    s.append('<text x="130" y="70" font-size="20">…</text>')
    s.append(_stair(200, 20, 5, c))
    s.append('<text x="350" y="70" font-size="20">…</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _svg16()

# ---------- Úlohy ----------

B = ['zs2', 'r9']  # 9. ročník ZŠ, čtyřleté obory

PROBLEMS = [
    # ---- úloha 1 (samostatná, výsledek) ----
    {'name': 'CERMAT M9A 2018 – úloha 1',
     'zad': ['Vypočtěte, kolikrát je trojnásobek čísla $9$ menší než číslo $324$.'],
     'opts': None, 'ln': 2,
     'sol': ['Trojnásobek čísla $9$ je $27$. Podíl $324:27=12$. Trojnásobek je tedy $12$krát menší než $324$.'],
     'ans': '$12$krát', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 2 (2.1, 2.2 nezávislé „Vypočtěte" -> samostatné) ----
    {'name': 'CERMAT M9A 2018 – úloha 2.1',
     'zad': ['Vypočtěte: $\\sqrt{1^2-0{,}6^2}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$1^2-0{,}6^2=1-0{,}36=0{,}64$, tedy $\\sqrt{0{,}64}=0{,}8$.'],
     'ans': '$0{,}8$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9A 2018 – úloha 2.2',
     'zad': ['Vypočtěte: $100-\\frac{1}{0{,}01\\cdot 0{,}1}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}01\\cdot 0{,}1=0{,}001$; $\\frac{1}{0{,}001}=1000$; $100-1000=-900$.'],
     'ans': '$-900$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 3 (3.1, 3.2 nezávislé, výsledek zlomkem + postup) ----
    {'name': 'CERMAT M9A 2018 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{4}{1+2}-1}{1+2}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\frac{4}{1+2}-1=\\frac{4}{3}-1=\\frac{1}{3}$. Jmenovatel je $1+2=3$. Celkem $\\frac{1}{3}:3=\\frac{1}{9}$.'],
     'ans': '$\\frac{1}{9}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9A 2018 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(2-\\frac{7}{8}\\right)\\cdot\\frac{8}{9}:\\left(\\frac{5}{8}+\\frac{5}{6}\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$2-\\frac{7}{8}=\\frac{9}{8}$; $\\frac{9}{8}\\cdot\\frac{8}{9}=1$; $\\frac{5}{8}+\\frac{5}{6}=\\frac{15+20}{24}=\\frac{35}{24}$; $1:\\frac{35}{24}=\\frac{24}{35}$.'],
     'ans': '$\\frac{24}{35}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 4 (4.1, 4.2 nezávislé, „Zjednodušte" + postup) ----
    {'name': 'CERMAT M9A 2018 – úloha 4.1',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(3+a)^2-(3\\cdot a)^2-3^2=$'],
     'opts': None, 'ln': 3,
     'sol': ['$(3+a)^2=9+6a+a^2$; $(3a)^2=9a^2$; $3^2=9$. Po dosazení $9+6a+a^2-9a^2-9=6a-8a^2$.'],
     'ans': '$6a-8a^2$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9A 2018 – úloha 4.2',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky): $2n\\cdot(3-n)+2\\cdot(3n\\cdot n)-n\\cdot(3\\cdot n)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$2n(3-n)=6n-2n^2$; $2\\cdot(3n\\cdot n)=6n^2$; $n\\cdot(3n)=3n^2$. Součet $6n-2n^2+6n^2-3n^2=n^2+6n$.'],
     'ans': '$n^2+6n$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 5 (5.1, 5.2 nezávislé rovnice + postup) ----
    {'name': 'CERMAT M9A 2018 – úloha 5.1',
     'zad': ['Řešte rovnici: $2\\cdot\\frac{5x}{6}-\\frac{1}{3}=x-\\frac{1}{2}$'],
     'opts': None, 'ln': 3,
     'sol': ['$2\\cdot\\frac{5x}{6}=\\frac{5x}{3}$. Rovnici $\\frac{5x}{3}-\\frac{1}{3}=x-\\frac{1}{2}$ vynásobíme $6$: $10x-2=6x-3$, tj. $4x=-1$, tedy $x=-\\frac{1}{4}$.'],
     'ans': '$x=-\\frac{1}{4}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9A 2018 – úloha 5.2',
     'zad': ['Řešte rovnici: $y-\\frac{1-3y}{2}=\\frac{7}{4}+\\frac{5y}{3}$'],
     'opts': None, 'ln': 3,
     'sol': ['Rovnici vynásobíme $12$: $12y-6(1-3y)=21+20y$, tj. $12y-6+18y=21+20y$, $30y-6=21+20y$, $10y=27$, tedy $y=2{,}7$.'],
     'ans': '$y=2{,}7$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 6 (sdílený výchozí text – knihovna; 6.1–6.3 -> jedna úloha) ----
    {'name': 'CERMAT M9A 2018 – úloha 6',
     'zad': [
         'Čtenáři si v knihovně během prvních tří dnů půjčili celkem $220$ knih. Druhý den si čtenáři půjčili o polovinu více knih než první den a zároveň o $20$ knih méně než třetí den.',
         'Neznámý počet knih, které si čtenáři půjčili v knihovně první den, označte $x$.',
         '6.1 V závislosti na veličině $x$ vyjádřete počet knih, které si čtenáři půjčili druhý den.',
         '6.2 V závislosti na veličině $x$ vyjádřete počet knih, které si čtenáři půjčili třetí den.',
         '6.3 Vypočtěte, kolik knih si čtenáři půjčili první den.'],
     'opts': None, 'ln': 4,
     'sol': [
         '6.1 Druhý den o polovinu více než první den: $x+\\frac{1}{2}x=1{,}5x$.',
         '6.2 Druhý den je o $20$ knih méně než třetí, třetí den tedy $1{,}5x+20$.',
         '6.3 Součet tří dnů: $x+1{,}5x+(1{,}5x+20)=220$, odtud $4x+20=220$, $4x=200$, $x=50$.'],
     'ans': '6.1: $1{,}5x$; 6.2: $1{,}5x+20$; 6.3: $50$ knih',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    # ---- úloha 7 (sdílený výchozí text a obrázek – kvádr z papíru) ----
    {'name': 'CERMAT M9A 2018 – úloha 7',
     'zad': [
         'Papírový obdélník s rozměry $18$ cm $\\times$ $5$ cm se beze zbytku použije na zhotovení kvádru. Obdélník se rozstříhá na jednotlivé stěny kvádru (tj. podstavy i boční stěny). Stříhat se smí jen v naznačeném směru – rovnoběžném s kratší stranou původního obdélníku. Z nastříhaných stěn se složí kvádr tak, aby se papír nikde nepřekrýval, a po hranách se spojí lepicí páskou.',
         'Vypočtěte:',
         '7.1 v cm² povrch složeného kvádru;',
         '7.2 v cm rozměry kvádru (existuje jediné možné řešení);',
         '7.3 v cm³ objem složeného kvádru.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'kvadr-papir.svg',
     'alt': 'Papírový obdélník 18 cm krát 5 cm s vyznačeným směrem stříhání rovnoběžným s kratší stranou.',
     'cap': 'Výchozí obrázek k úloze 7 (papírový obdélník)',
     'sol': [
         '7.1 Papír se použije beze zbytku a nikde se nepřekrývá, povrch kvádru se proto rovná obsahu obdélníku: $18\\cdot 5=90$ cm².',
         '7.2 Stříhá se rovnoběžně s kratší stranou, jeden rozměr kvádru je proto $5$ cm. Kvádr s povrchem $90$ cm² má rozměry $5\\times 5\\times 2$ cm, neboť $2(5\\cdot 5+5\\cdot 2+5\\cdot 2)=90$.',
         '7.3 Objem $5\\cdot 5\\cdot 2=50$ cm³.'],
     'ans': '7.1: $90$ cm²; 7.2: $5$ cm, $5$ cm, $2$ cm; 7.3: $50$ cm³',
     'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['stereometrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    # ---- úloha 8 (8.1, 8.2, 8.3 nezávislé „Vypočtěte" -> samostatné) ----
    {'name': 'CERMAT M9A 2018 – úloha 8.1',
     'zad': ['Vypočtěte v minutách devítinu úhlu o velikosti $7{,}5$ stupně.'],
     'opts': None, 'ln': 2,
     'sol': ['$7{,}5^\\circ=7{,}5\\cdot 60=450$ úhlových minut. Devítina je $450:9=50$ minut.'],
     'ans': '$50$ minut', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9A 2018 – úloha 8.2',
     'zad': ['Vypočtěte v cm² obsah trojúhelníku $ABC$, je-li obsah rovnoběžníku $ABCD$ $1{,}5$ dm².'],
     'opts': None, 'ln': 2,
     'sol': ['Obsah rovnoběžníku $1{,}5$ dm² $=150$ cm². Trojúhelník $ABC$ je polovina rovnoběžníku $ABCD$, tedy $150:2=75$ cm².'],
     'ans': '$75$ cm²', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9A 2018 – úloha 8.3',
     'zad': ['Vypočtěte, kolikrát je objem $0{,}2$ litru větší než objem $5$ mililitrů.'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}2$ litru $=200$ ml. Podíl $200:5=40$, objem je tedy $40$krát větší.'],
     'ans': '$40$krát', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 9 (konstrukce – těžnice, vrchol C, těžiště) ----
    {'name': 'CERMAT M9A 2018 – úloha 9',
     'zad': [
         'V rovině leží přímka $AB$ a mimo ni bod $M$ (viz obrázek).',
         'Úsečka $AB$ je strana $c$ trojúhelníku $ABC$. Bod $M$ leží uvnitř tohoto trojúhelníku na těžnici $t_c$ (těžnice na stranu $c$). Výška $v_c$ (výška na stranu $c$) měří $6$ cm.',
         '9.1 Sestrojte těžnici $t_c$, chybějící vrchol $C$ trojúhelníku $ABC$ a trojúhelník narýsujte.',
         '9.2 Sestrojte těžiště trojúhelníku $ABC$ a označte jej písmenem $T$.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-ab-m.svg',
     'alt': 'Přímka AB s vyznačenými body A a B a bod M ležící mimo přímku.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': [
         'Střed $S_c$ strany $AB$ najdeme jako průsečík osy úsečky $AB$ s $AB$. Těžnice $t_c$ je přímka procházející body $S_c$ a $M$. Vrchol $C$ leží na $t_c$ ve vzdálenosti $v_c=6$ cm od přímky $AB$ (na téže straně jako $M$); sestrojíme jej jako průsečík $t_c$ s rovnoběžkou s $AB$ vedenou ve vzdálenosti $6$ cm. Trojúhelník $ABC$ narýsujeme.',
         'Těžiště $T$ leží na těžnici $t_c$, přičemž $|S_cT|=\\frac{1}{3}|S_cC|$ (nebo jako průsečík dalších těžnic).'],
     'ans': 'Konstrukce: $S_c$ je střed strany $AB$; těžnice $t_c$ je přímka $S_cM$; vrchol $C$ leží na $t_c$ ve vzdálenosti $v_c=6$ cm od $AB$ (na straně bodu $M$); těžiště $T$ leží na $t_c$ s $|S_cT|=\\frac{1}{3}|S_cC|$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 10 (konstrukce – střed kružnice opsané) ----
    {'name': 'CERMAT M9A 2018 – úloha 10',
     'zad': [
         'V rovině leží trojúhelník $KLM$ (viz obrázek).',
         'Kružnice $k$ prochází vrcholy trojúhelníku $KLM$. Sestrojte střed $S$ kružnice $k$.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'trojuhelnik-klm.svg',
     'alt': 'Trojúhelník KLM v rovině (M vlevo, L vpravo nahoře, K dole).',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Střed $S$ kružnice opsané je stejně vzdálen od všech vrcholů, leží tedy na osách stran. Sestrojíme osy dvou stran trojúhelníku (např. $KL$ a $LM$); jejich průsečík je hledaný střed $S$.'],
     'ans': 'Konstrukce: střed $S$ je průsečík os stran trojúhelníku $KLM$ (os úseček $KL$ a $LM$) (viz obrázek v klíči).',
     'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 11 (sdílený výchozí text; Ano/Ne 11.1–11.3) ----
    {'name': 'CERMAT M9A 2018 – úloha 11',
     'zad': [
         'Pro vnitřní úhly trojúhelníku $ABC$ platí: $\\alpha:\\beta=5:3$, $\\alpha:\\gamma=1:2$.',
         'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
         '11.1 $\\beta:\\gamma=5:6$',
         '11.2 $\\gamma-\\beta=70^\\circ$',
         '11.3 $\\gamma-\\alpha=50^\\circ$'],
     'opts': None, 'ln': 0,
     'sol': [
         'Z $\\alpha:\\beta=5:3$ a $\\alpha:\\gamma=1:2$ plyne $\\alpha=5t$, $\\beta=3t$, $\\gamma=10t$. Součet $18t=180^\\circ$, tedy $t=10^\\circ$: $\\alpha=50^\\circ$, $\\beta=30^\\circ$, $\\gamma=100^\\circ$.',
         '11.1 $\\beta:\\gamma=30:100=3:10\\ne 5:6$ → Ne.',
         '11.2 $\\gamma-\\beta=100^\\circ-30^\\circ=70^\\circ$ → Ano.',
         '11.3 $\\gamma-\\alpha=100^\\circ-50^\\circ=50^\\circ$ → Ano.'],
     'ans': '11.1: Ne; 11.2: Ano; 11.3: Ano',
     'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 12 (výběr z možností A–E + obrázek – lichoběžník) ----
    {'name': 'CERMAT M9A 2018 – úloha 12',
     'zad': [
         'Čtyřúhelník $ABCD$ je lichoběžník se základnami $AB$ a $DC$ ($AB\\parallel DC$). Strana $AD$ svírá s prodloužením základny $AB$ za vrcholem $A$ úhel $112^\\circ$. Úhlopříčka $DB$ je kolmá ke straně $AD$ ($\\angle ADB=90^\\circ$). U vrcholu $B$ je $\\angle ABD=\\varphi$ a $\\angle DBC=2\\varphi$. Úhel u vrcholu $C$ je označen $\\gamma$.',
         'Jaká je velikost úhlu $\\gamma$? Úhly neměřte, ale vypočtěte.'],
     'opts': ['A) $114^\\circ$', 'B) $117^\\circ$', 'C) $120^\\circ$', 'D) $126^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG12, 'fn': 'lichobeznik-uhly.svg',
     'alt': 'Lichoběžník ABCD se základnami AB a DC, úhlopříčka DB, vyznačené úhly u vrcholů A, B, C a pravý úhel u D.',
     'cap': 'Výchozí obrázek k úloze 12',
     'sol': ['Vnitřní úhel u vrcholu $A$ je $\\angle DAB=180^\\circ-112^\\circ=68^\\circ$. V trojúhelníku $ABD$ je $\\angle ADB=90^\\circ$, tedy $\\varphi=\\angle ABD=180^\\circ-68^\\circ-90^\\circ=22^\\circ$. Úhel $\\angle ABC=\\varphi+2\\varphi=3\\varphi=66^\\circ$. Protože $AB\\parallel DC$, je $\\gamma=180^\\circ-66^\\circ=114^\\circ$.'],
     'ans': 'A) $114^\\circ$', 'pts': 2, 'mins': 6, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 13 (výběr z možností A–E; obvod kola) ----
    {'name': 'CERMAT M9A 2018 – úloha 13',
     'zad': [
         'Traktor najel na přímé silnici zadním kolem na tubu s červenou barvou. Tuba se zaklínila do pneumatiky a praskla. Traktor pak na silnici vytvořil každých $252$ cm maličkou červenou skvrnu.',
         'V jaké výšce nad zemí je střed zadního kola traktoru? Výsledek je zaokrouhlen na celé cm.'],
     'opts': ['A) menší než $35$ cm', 'B) $35$ cm', 'C) $40$ cm', 'D) $44$ cm', 'E) větší než $44$ cm'],
     'ln': 0,
     'sol': ['Červená skvrna vznikne právě jednou za otáčku kola, obvod kola je proto $252$ cm. Z $o=2\\pi r$ plyne $r=\\frac{252}{2\\pi}\\doteq 40{,}1$ cm. Střed kola je ve výšce rovné poloměru, tj. po zaokrouhlení $40$ cm.'],
     'ans': 'C) $40$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    # ---- úloha 14 (výběr z možností A–E + obrázek – deltoid) ----
    {'name': 'CERMAT M9A 2018 – úloha 14',
     'zad': [
         'Čtyřúhelník $ABCD$ je osově souměrný podle osy $o$. Úhlopříčky $AC$ a $BD$ se protínají v bodě $P$. Platí: $|CP|=12$ cm; $|BP|=16$ cm; $|AD|=13$ cm.',
         'Jaký je obsah čtyřúhelníku $ABCD$?'],
     'opts': ['A) $244$ cm²', 'B) $252$ cm²', 'C) $258$ cm²', 'D) $288$ cm²', 'E) jiný obsah'],
     'ln': 0, 'svg': SVG14, 'fn': 'deltoid-abcd.svg',
     'alt': 'Osově souměrný čtyřúhelník ABCD (deltoid) s osou o; úhlopříčky AC a BD se protínají v bodě P.',
     'cap': 'Výchozí obrázek k úloze 14',
     'sol': ['Osou souměrnosti je přímka $DB$, proto $AC\\perp DB$ a bod $P$ je střed $AC$: $|AP|=|PC|=12$ cm, $|AC|=24$ cm. V pravoúhlém trojúhelníku $APD$ je $|DP|=\\sqrt{13^2-12^2}=5$ cm. Úhlopříčka $|BD|=|DP|+|PB|=5+16=21$ cm. Obsah deltoidu $=\\frac{1}{2}\\cdot|AC|\\cdot|BD|=\\frac{1}{2}\\cdot 24\\cdot 21=252$ cm².'],
     'ans': 'B) $252$ cm²', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 15 (přiřazování 15.1–15.3 -> A–F; sdílená nabídka) ----
    {'name': 'CERMAT M9A 2018 – úloha 15',
     'zad': [
         'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
         '15.1 Obrázek tvaru obdélníku s rozměry $12$ cm a $8$ cm je nalepen na obdélníkové podložce. Podložka přesahuje obrázek nahoře, dole, vpravo i vlevo o $2$ cm. Kolik procent plochy podložky není zakryto obrázkem?',
         '15.2 V lednu se $2$ litry limonády prodávaly za $24$ Kč, v únoru se za tuto cenu prodávalo $2{,}5$ litru limonády. O kolik procent byl $1$ litr limonády v únoru levnější než v lednu?',
         '15.3 Cyklista ujel za $3$ dny trasu dlouhou $240$ km. První den ujel polovinu celé trasy, druhý den ujel dvě pětiny zbytku trasy. Kolik procent celé trasy ujel cyklista třetí den?'],
     'opts': ['A) o méně než $20\\,\\%$', 'B) o $20\\,\\%$', 'C) o $25\\,\\%$', 'D) o $30\\,\\%$', 'E) o $50\\,\\%$', 'F) o více než $50\\,\\%$'],
     'ln': 0, 'svg': SVG15, 'fn': 'podlozka-obrazek.svg',
     'alt': 'Šedý obrázek 12 cm krát 8 cm nalepený na bílé obdélníkové podložce přesahující o 2 cm na každé straně.',
     'cap': 'Obrázek k úloze 15.1',
     'sol': [
         '15.1 Podložka má rozměry $(12+4)\\times(8+4)=16\\times 12=192$ cm², obrázek $12\\cdot 8=96$ cm². Nezakryto $192-96=96$ cm², tj. $\\frac{96}{192}=50\\,\\%$ → E.',
         '15.2 Leden: $1$ l za $12$ Kč; únor: $24:2{,}5=9{,}6$ Kč/l. Zlevnění $\\frac{12-9{,}6}{12}=20\\,\\%$ → B.',
         '15.3 První den $\\frac{1}{2}\\cdot 240=120$ km, zbytek $120$ km; druhý den $\\frac{2}{5}\\cdot 120=48$ km; třetí den $120-48=72$ km, tj. $\\frac{72}{240}=30\\,\\%$ → D.'],
     'ans': '15.1: E (o $50\\,\\%$); 15.2: B (o $20\\,\\%$); 15.3: D (o $30\\,\\%$)',
     'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    # ---- úloha 16 (sdílený výchozí text a obrázek; číselná posloupnost) ----
    {'name': 'CERMAT M9A 2018 – úloha 16',
     'zad': [
         'Shodné čtverce jsou podle jednotného pravidla rozděleny vždy na světlou a tmavou plochu. Obě plochy se liší o $3$, $4$ nebo více čtverečků, které lze vyznačit po úhlopříčce. Poměr velikostí světlé a tmavé plochy u prvního zobrazeného čtverce je $6:3$ a v základním tvaru jej zapisujeme $2:1$.',
         '16.1 Zapište v základním tvaru poměr velikostí světlé a tmavé plochy čtverce, jestliže se obě plochy liší o $9$ čtverečků vyznačených po úhlopříčce.',
         '16.2 Zapište v základním tvaru poměr velikostí světlé a tmavé plochy čtverce, jestliže se obě plochy liší o $100$ čtverečků vyznačených po úhlopříčce.',
         '16.3 Určete počet čtverečků vyznačených po úhlopříčce, jestliže je poměr velikostí světlé a tmavé plochy $13:11$.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'ctverce-plochy.svg',
     'alt': 'Shodné čtverce schodovitě rozdělené po úhlopříčce na světlou (bílou) a tmavou (šedou) plochu; ukázka pro tři a pět čtverečků na straně.',
     'cap': 'Schodovité rozdělení čtverců na světlou a tmavou plochu',
     'sol': [
         'Čtverec o straně $n$ čtverečků má světlou plochu $\\frac{n^2+n}{2}$ a tmavou $\\frac{n^2-n}{2}$; liší se právě o $n$ čtverečků na úhlopříčce a jejich poměr je $(n+1):(n-1)$.',
         '16.1 Rozdíl $9\\Rightarrow n=9$: poměr $10:8=5:4$.',
         '16.2 Rozdíl $100\\Rightarrow n=100$: poměr $101:99$.',
         '16.3 $(n+1):(n-1)=13:11\\Rightarrow n=12$; po úhlopříčce je $12$ čtverečků.'],
     'ans': '16.1: $5:4$; 16.2: $101:99$; 16.3: $12$',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PAD18C0T01'
    gen.YEAR = 2018

    def dollars_ok(s):
        return s.count('$') % 2 == 0
    errors = []
    names = set()
    total_pts = 0
    for p in PROBLEMS:
        total_pts += p['pts']
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
    print('Validace OK:', len(PROBLEMS), 'úloh; součet bodů:', total_pts)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9A-2018')):
        tot += k
        print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
