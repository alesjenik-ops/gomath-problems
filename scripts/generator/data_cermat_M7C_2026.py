# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2026, MATEMATIKA 7C (šestileté obory, 7. ročník),
# 1. náhradní termín. Kód testu: M7PCD26C0T03. 16 úloh, 50 bodů.
# Po rozdělení nezávislých poduúloh (úloha 2 -> 2.1 a 2.2) celkem 17 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno vyplněným záznamovým archem (VZA).

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

# úloha 4: výchozí tabulka závaží
SVG4 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 130" font-family="sans-serif" font-size="14">
<rect x="10" y="10" width="420" height="110" fill="none" stroke="#000"/>
<line x1="150" y1="10" x2="150" y2="120" stroke="#000"/>
<line x1="245" y1="10" x2="245" y2="120" stroke="#000"/>
<line x1="340" y1="10" x2="340" y2="120" stroke="#000"/>
<line x1="10" y1="47" x2="430" y2="47" stroke="#000"/>
<line x1="10" y1="84" x2="430" y2="84" stroke="#000"/>
<text x="20" y="33">Závaží</text>
<text x="197" y="33" text-anchor="middle">Malé</text>
<text x="292" y="33" text-anchor="middle">Střední</text>
<text x="385" y="33" text-anchor="middle">Velké</text>
<text x="20" y="70">Hmotnost 1 kusu</text>
<text x="197" y="70" text-anchor="middle">15 g</text>
<text x="292" y="70" text-anchor="middle">25 g</text>
<text x="385" y="70" text-anchor="middle">50 g</text>
<text x="20" y="107">Počet kusů v sadě</text>
<text x="197" y="107" text-anchor="middle">5</text>
</svg>"""

# úloha 5: velký hranol ABCDEFGH slepený ze šedé krychle (vpravo) a bílého hranolu (schematicky)
SVG5 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif" font-size="15">
<polygon points="290,150 360,150 360,240 290,240" fill="#c9c9c9"/>
<polygon points="290,150 360,150 400,110 330,110" fill="#dcdcdc"/>
<polygon points="360,150 400,110 400,200 360,240" fill="#b8b8b8"/>
<polyline points="110,200 110,110 400,110 400,200" fill="none" stroke="#000" stroke-dasharray="5 4"/>
<line x1="110" y1="200" x2="400" y2="200" stroke="#000" stroke-dasharray="5 4"/>
<line x1="70" y1="240" x2="110" y2="200" stroke="#000" stroke-dasharray="5 4"/>
<line x1="70" y1="150" x2="360" y2="150" stroke="#000"/>
<line x1="360" y1="150" x2="360" y2="240" stroke="#000"/>
<line x1="360" y1="240" x2="70" y2="240" stroke="#000"/>
<line x1="70" y1="240" x2="70" y2="150" stroke="#000"/>
<line x1="70" y1="150" x2="110" y2="110" stroke="#000"/>
<line x1="360" y1="150" x2="400" y2="110" stroke="#000"/>
<line x1="360" y1="240" x2="400" y2="200" stroke="#000"/>
<line x1="290" y1="150" x2="290" y2="240" stroke="#000"/>
<line x1="290" y1="150" x2="330" y2="110" stroke="#000"/>
<text x="60" y="255" font-style="italic">A</text>
<text x="362" y="258" font-style="italic">B</text>
<text x="405" y="205" font-style="italic">C</text>
<text x="92" y="215" font-style="italic">D</text>
<text x="55" y="148" font-style="italic">E</text>
<text x="345" y="145" font-style="italic">F</text>
<text x="405" y="108" font-style="italic">G</text>
<text x="96" y="108" font-style="italic">H</text>
</svg>"""

# úloha 6: dva šestiúhelníky ze dvou bílých a dvou šedých trojúhelníků (schematicky)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 320" font-family="sans-serif" font-size="14">
<text x="160" y="120" text-anchor="middle">1. šestiúhelník</text>
<polygon points="40,200 120,140 120,260" fill="#ffffff" stroke="#000"/>
<polygon points="280,200 200,140 200,260" fill="#ffffff" stroke="#000"/>
<polygon points="120,140 200,140 200,260" fill="#bdbdbd" stroke="#000"/>
<polygon points="120,140 200,260 120,260" fill="#bdbdbd" stroke="#000"/>
<line x1="120" y1="140" x2="200" y2="260" stroke="#000"/>
<text x="210" y="205">10 cm</text>
<text x="460" y="145" text-anchor="middle">2. šestiúhelník</text>
<polygon points="360,260 460,260 360,175" fill="#bdbdbd" stroke="#000"/>
<polygon points="460,260 560,260 560,175" fill="#bdbdbd" stroke="#000"/>
<polygon points="360,175 460,175 460,260" fill="#ffffff" stroke="#000"/>
<polygon points="460,175 560,175 460,260" fill="#ffffff" stroke="#000"/>
<text x="390" y="278" text-anchor="middle">10 cm</text>
<text x="510" y="278" text-anchor="middle">10 cm</text>
</svg>"""

# úloha 8: body A, S a přímka p procházející bodem A
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 360" font-family="sans-serif" font-size="16">
<line x1="60" y1="320" x2="580" y2="120" stroke="#000" stroke-width="2"/>
<text x="588" y="115" font-style="italic">p</text>
<text x="146" y="290" text-anchor="middle">×</text>
<text x="140" y="278" font-style="italic">A</text>
<text x="300" y="210" text-anchor="middle">×</text>
<text x="296" y="198" font-style="italic">S</text>
</svg>"""

# úloha 9: body U, V a přímka k
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 340" font-family="sans-serif" font-size="16">
<line x1="70" y1="300" x2="600" y2="240" stroke="#000" stroke-width="2"/>
<text x="606" y="238" font-style="italic">k</text>
<text x="190" y="222" text-anchor="middle">×</text>
<text x="185" y="208" font-style="italic">U</text>
<text x="350" y="217" text-anchor="middle">×</text>
<text x="345" y="203" font-style="italic">V</text>
</svg>"""

# úloha 10: skupinový sloupcový graf služeb dětí (pátek chybí – čárkované)
def _bars10():
    days = [('Pondělí', 2, 4, 1), ('Úterý', 1, 3, 3), ('Středa', 3, 3, 2), ('Čtvrtek', 1, 2, 3)]
    x0, y0 = 70, 280; unit = 44; bw = 20; step = 24; dstep = 105; gx0 = 95
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 360" font-family="sans-serif" font-size="13">']
    s.append(f'<line x1="{x0}" y1="50" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="600" y2="{y0}" stroke="#000"/>')
    for v in range(0, 6):
        y = y0 - v * unit
        s.append(f'<line x1="{x0}" y1="{y}" x2="600" y2="{y}" stroke="#eeeeee"/>')
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-9}" y="{y+4}" text-anchor="end">{v}</text>')
    s.append(f'<text x="22" y="165" text-anchor="middle" transform="rotate(-90 22 165)">Počet dětí</text>')
    gx = gx0
    for name, sn, ob, ve in days:
        for i, (val, col) in enumerate(((sn, '#555555'), (ob, '#dcdcdc'), (ve, '#9a9a9a'))):
            h = val * unit; bx = gx + i * step
            s.append(f'<rect x="{bx}" y="{y0-h}" width="{bw}" height="{h}" fill="{col}" stroke="#000"/>')
        s.append(f'<text x="{gx+step}" y="{y0+16}" text-anchor="middle">{name}</text>')
        gx += dstep
    for i in range(3):
        bx = gx + i * step
        s.append(f'<rect x="{bx}" y="{y0-44}" width="{bw}" height="44" fill="none" stroke="#888888" stroke-dasharray="4 3"/>')
    s.append(f'<text x="{gx+step}" y="{y0+16}" text-anchor="middle">Pátek</text>')
    s.append('<rect x="150" y="326" width="13" height="13" fill="#555555" stroke="#000"/><text x="168" y="337">Snídaně</text>')
    s.append('<rect x="270" y="326" width="13" height="13" fill="#dcdcdc" stroke="#000"/><text x="288" y="337">Oběd</text>')
    s.append('<rect x="360" y="326" width="13" height="13" fill="#9a9a9a" stroke="#000"/><text x="378" y="337">Večeře</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _bars10()

# úloha 16: posloupnost obrazců (čtverec, obdélníky přidáváním menších čtverců)
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 210" font-family="sans-serif" font-size="14">
<text x="85" y="45" text-anchor="middle">1. obrazec</text>
<rect x="40" y="60" width="90" height="90" fill="none" stroke="#000"/>
<text x="237" y="45" text-anchor="middle">2. obrazec</text>
<rect x="170" y="60" width="135" height="90" fill="none" stroke="#000"/>
<line x1="260" y1="60" x2="260" y2="150" stroke="#000"/>
<line x1="260" y1="105" x2="305" y2="105" stroke="#000"/>
<text x="432" y="45" text-anchor="middle">3. obrazec</text>
<rect x="350" y="60" width="165" height="90" fill="none" stroke="#000"/>
<line x1="440" y1="60" x2="440" y2="150" stroke="#000"/>
<line x1="440" y1="105" x2="485" y2="105" stroke="#000"/>
<line x1="485" y1="60" x2="485" y2="150" stroke="#000"/>
<line x1="485" y1="90" x2="515" y2="90" stroke="#000"/>
<line x1="485" y1="120" x2="515" y2="120" stroke="#000"/>
<text x="555" y="110" font-size="22">…</text>
</svg>"""

# ---------- Úlohy ----------

B = ['zs2', 'r7']  # 7. ročník (šestileté obory); stupeň zs2, ročník r7

PROBLEMS = [
    {'name': 'CERMAT M7C 2026 – úloha 1', 'zad': [
        'Pan Červený strávil jízdou v autě přesně 7 hodin, než dojel do cíle. Svou jízdu autem zahájil ráno v 7:44 a přerušil ji jen jednou, když si udělal pauzu na oběd. Z auta vystoupil ve 12:02 a do auta se vrátil za 38 minut. Pak pokračoval v jízdě až do cíle.',
        'Určete, kdy pan Červený dorazil do cíle. Výsledek zapište ve tvaru hodiny : minuty.'],
     'opts': None, 'ln': 1,
     'sol': ['Do pauzy jel od 7:44 do 12:02, tj. 4 h 18 min. Pauza 38 min skončila ve 12:40. Zbývá dojet 7 h $-$ 4 h 18 min $=$ 2 h 42 min. Od 12:40 dojede v 12:40 $+$ 2 h 42 min, tedy v 15:22.'],
     'ans': '15:22 (resp. 3:22 odpoledne)', 'pts': 1, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2026 – úloha 2.1', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $4{,}4\\cdot\\left(\\dfrac{4}{11}-\\dfrac{1}{44}\\right)-2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\dfrac{4}{11}-\\dfrac{1}{44}=\\dfrac{16}{44}-\\dfrac{1}{44}=\\dfrac{15}{44}$; dále $4{,}4=\\dfrac{22}{5}$, takže $\\dfrac{22}{5}\\cdot\\dfrac{15}{44}=\\dfrac{3}{2}$ a $\\dfrac{3}{2}-2=-\\dfrac{1}{2}$.'],
     'ans': '$-\\dfrac{1}{2}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2026 – úloha 2.2', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\dfrac{5}{3}-\\dfrac{3}{5}}{\\dfrac{8}{7}\\cdot\\dfrac{14}{5}}=$'],
     'opts': None, 'ln': 2,
     'sol': ['Čitatel: $\\dfrac{5}{3}-\\dfrac{3}{5}=\\dfrac{25-9}{15}=\\dfrac{16}{15}$. Jmenovatel: $\\dfrac{8}{7}\\cdot\\dfrac{14}{5}=\\dfrac{16}{5}$. Celkem $\\dfrac{16}{15}:\\dfrac{16}{5}=\\dfrac{16}{15}\\cdot\\dfrac{5}{16}=\\dfrac{1}{3}$.'],
     'ans': '$\\dfrac{1}{3}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2026 – úloha 3', 'zad': [
        'Klára přinesla košík s jablky a dvě devítiny počtu jablek z košíku položila do prázdné misky. Matěj si později vzal polovinu jablek z misky a ještě další 3 jablka z košíku. V košíku tak zůstalo o 21 jablek více než v misce.',
        '3.1 Vypočtěte, kolik jablek přinesla Klára v košíku.',
        '3.2 Vypočtěte, kolik jablek si vzal Matěj.'],
     'opts': None, 'ln': 2,
     'sol': ['Označme počet jablek $x$. Do misky dala Klára $\\frac{2}{9}x$, v košíku zůstalo $\\frac{7}{9}x$. Matěj vzal polovinu misky, v misce pak zůstalo $\\frac{1}{9}x$ a v košíku $\\frac{7}{9}x-3$.',
             '3.1 Rovnice $\\frac{7}{9}x-3=\\frac{1}{9}x+21$ dává $\\frac{6}{9}x=24$, tedy $x=36$ jablek.',
             '3.2 Matěj vzal $\\frac{1}{2}\\cdot\\frac{2}{9}\\cdot 36+3=4+3=7$ jablek.'],
     'ans': '3.1: $36$ jablek; 3.2: $7$ jablek', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2026 – úloha 4', 'zad': [
        'Sadu tvoří 27 závaží. Celková hmotnost všech závaží v sadě je 1 kg. Sada obsahuje pouze malá, střední a velká závaží. Hmotnost 1 kusu je: malé $15$ g, střední $25$ g, velké $50$ g; malých závaží je v sadě $5$ kusů (viz tabulka).',
        '4.1 Určete počet velkých závaží v sadě.',
        '4.2 Určete v gramech celkovou hmotnost všech středních závaží v sadě.'],
     'opts': None, 'ln': 2, 'svg': SVG4, 'fn': 'zavazi-tabulka.svg',
     'alt': 'Tabulka závaží: malé 15 g, střední 25 g, velké 50 g; malých je 5 kusů.',
     'cap': 'Výchozí tabulka k úloze 4',
     'sol': ['Malá závaží mají $5\\cdot 15=75$ g. Na střední a velká zbývá $1000-75=925$ g a $27-5=22$ kusů.',
             '4.1 Pro počet středních $s$ a velkých $v$ platí $s+v=22$ a $25s+50v=925$. Odtud $v=15$ velkých závaží.',
             '4.2 Středních je pak $s=7$; jejich hmotnost je $7\\cdot 25=175$ g.'],
     'ans': '4.1: $15$ velkých závaží; 4.2: $175$ gramů', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2026 – úloha 5', 'zad': [
        'Slepením šedé krychle s povrchem $54$ cm² a bílého hranolu vznikne velký hranol $ABCDEFGH$ (viz obrázek). Nejdelší hrana bílého hranolu je o polovinu delší než hrana šedé krychle.',
        '5.1 Vypočtěte v cm délku hrany šedé krychle.',
        '5.2 Vypočtěte v cm³ objem velkého hranolu $ABCDEFGH$.'],
     'opts': None, 'ln': 2, 'svg': SVG5, 'fn': 'hranol-krychle.svg',
     'alt': 'Kvádr ABCDEFGH složený z bílého hranolu vlevo a šedé krychle vpravo.',
     'cap': 'Schematický nákres velkého hranolu',
     'sol': ['5.1 Povrch krychle $6a^2=54$, tedy $a^2=9$ a $a=3$ cm.',
             '5.2 Nejdelší hrana bílého hranolu je $3+\\frac{3}{2}=4{,}5$ cm; příčný řez zůstává $3\\times 3$ cm. Velký hranol má rozměry $3\\times 3\\times(3+4{,}5)=3\\times 3\\times 7{,}5$, objem $3\\cdot 3\\cdot 7{,}5=67{,}5$ cm³.'],
     'ans': '5.1: $3$ cm; 5.2: $67{,}5$ cm³', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2026 – úloha 6', 'zad': [
        'První šestiúhelník se skládá ze dvou shodných bílých rovnostranných trojúhelníků a dvou shodných šedých trojúhelníků. Trojúhelníky přeskládáme do druhého šestiúhelníku (viz obrázek). Nejdelší strana šedého trojúhelníku měří $10$ cm. Obvod prvního šestiúhelníku je $40$ cm a obvod druhého šestiúhelníku je $46$ cm.',
        '6.1 Určete v cm délku jedné strany bílého rovnostranného trojúhelníku.',
        '6.2 Určete v cm obvod šedého trojúhelníku.'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'sestiuhelniky.svg',
     'alt': 'Dva šestiúhelníky složené ze dvou bílých rovnostranných a dvou šedých trojúhelníků.',
     'cap': 'Schematický nákres obou šestiúhelníků',
     'sol': ['Označme stranu bílého rovnostranného trojúhelníku $a$ a nejkratší stranu šedého trojúhelníku $c$; nejdelší strana šedého trojúhelníku je $10$ cm.',
             'Obvod 1. šestiúhelníku tvoří čtyři strany délky $a$ a dvě strany délky $c$: $4a+2c=40$. Obvod 2. šestiúhelníku tvoří dvě strany $a$, dvě strany $c$ a dvě nejdelší strany $10$ cm: $2a+2c+2\\cdot 10=46$, tj. $2a+2c=26$.',
             'Odečtením dostaneme $2a=14$, tedy $a=7$ cm a $c=6$ cm. Strana bílého trojúhelníku je $7$ cm; obvod šedého trojúhelníku je $10+7+6=23$ cm.'],
     'ans': '6.1: $7$ cm; 6.2: $23$ cm', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2026 – úloha 7', 'zad': [
        'Každá naše tiskárna vytiskne za 2 minuty 54 stran. Každá strana se tiskne stejně dlouhou dobu.',
        '7.1 Vypočtěte, za kolik minut vytiskne jedna tiskárna 135 stran.',
        '7.2 Použili jsme dvě tiskárny společně. Vypočtěte, kolik stran vytiskly obě tiskárny dohromady za 7 minut.',
        '7.3 Použili jsme několik tiskáren společně a dohromady vytiskly za 3 minuty 486 stran. Vypočtěte, kolik tiskáren jsme použili.'],
     'opts': None, 'ln': 3,
     'sol': ['Jedna tiskárna vytiskne $54:2=27$ stran za minutu.',
             '7.1 $135:27=5$ minut.',
             '7.2 Dvě tiskárny vytisknou za minutu $2\\cdot 27=54$ stran, za 7 minut $7\\cdot 54=378$ stran.',
             '7.3 Za 3 minuty vytiskne jedna tiskárna $3\\cdot 27=81$ stran; $486:81=6$ tiskáren.'],
     'ans': '7.1: $5$ minut; 7.2: $378$ stran; 7.3: $6$ tiskáren', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2026 – úloha 8 (konstrukce)', 'zad': [
        'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).',
        'Bod $A$ je vrchol rovnoramenného trojúhelníku $ABC$, jehož strany $AC$ a $BC$ mají stejnou délku. Bod $S$ je střed strany $AC$ a na přímce $p$ leží střed $P$ strany $BC$ trojúhelníku $ABC$.',
        'Sestrojte vrchol $C$, střed $P$ a vrchol $B$, označte je písmeny a narýsujte trojúhelník $ABC$. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'body-AS-primka-p.svg',
     'alt': 'Body A a S a přímka p procházející bodem A.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['Bod $C$ je souměrný s bodem $A$ podle středu $S$ (protože $S$ je střed $AC$): leží na polopřímce $AS$ tak, že $|SC|=|AS|$; tím je určen jednoznačně a $|AC|=2\\,|AS|$.',
             'Protože $|BC|=|AC|$ a $P$ je střed $BC$, platí $|CP|=\\tfrac{1}{2}|AC|$. Kružnice se středem $C$ a poloměrem $\\tfrac{1}{2}|AC|$ protne přímku $p$ ve dvou bodech $P_1$, $P_2$ (dvě polohy středu $P$).',
             'Vrchol $B$ je souměrný s bodem $C$ podle bodu $P$. Dostáváme dvě řešení – trojúhelníky $ABC$ s vrcholy $B_1$ a $B_2$.'],
     'ans': 'Dvě řešení. $C$ je obraz bodu $A$ ve středové souměrnosti se středem $S$; střed $P$ je průsečík přímky $p$ s kružnicí se středem $C$ a poloměrem $\\tfrac{1}{2}|AC|$ (polohy $P_1$, $P_2$); $B$ je obraz $C$ podle středu $P$ (viz náčrt v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2026 – úloha 9 (konstrukce)', 'zad': [
        'V rovině leží body $U$, $V$ a přímka $k$ (viz obrázek).',
        'Bod $U$ leží uvnitř strany $KN$ obdélníku $KLMN$. Na přímce $k$ leží strana $KL$ tohoto obdélníku. Bod $V$ má stejnou vzdálenost od všech čtyř vrcholů obdélníku $KLMN$.',
        'Sestrojte všechny vrcholy obdélníku $KLMN$, označte je písmeny a obdélník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-UV-primka-k.svg',
     'alt': 'Body U a V a přímka k.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Strana $KN$ je kolmá ke straně $KL$, která leží na přímce $k$, a bod $U$ leží na $KN$. Vrchol $K$ je proto pata kolmice spuštěné z bodu $U$ na přímku $k$.',
             'Bod $V$ má stejnou vzdálenost od všech vrcholů, je tedy středem obdélníku (průsečíkem úhlopříček). Vrchol $M$ je souměrný s $K$ podle středu $V$.',
             'Kružnice se středem $V$ procházející bodem $K$ protne přímku $k$ ještě ve vrcholu $L$; vrchol $N$ je souměrný s $L$ podle středu $V$. Nakonec narýsujeme obdélník $KLMN$.'],
     'ans': '$K$ je pata kolmice z $U$ na přímku $k$; $V$ je střed obdélníku, takže $M$ je obraz $K$ podle $V$; $L$ je druhý průsečík kružnice se středem $V$ a poloměrem $|VK|$ s přímkou $k$ a $N$ je obraz $L$ podle $V$ (viz náčrt v klíči).',
     'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2026 – úloha 10', 'zad': [
        'Tábor začal v pondělí snídaní a skončil v pátek po obědě. U každého jídla pomáhala v kuchyni služba. U snídaně měly mít službu vždy 4 osoby, u oběda 5 osob a u večeře také 5 osob. Každé z 35 dětí mělo službu v kuchyni právě jednou za celý tábor. Požadovaný počet osob vždy doplnili instruktoři a ti pak měli službu společně s dětmi. Přitom každý instruktor měl službu v kuchyni nejvýše jedenkrát za den. V grafu je uveden pouze rozpis služeb dětí, oba páteční údaje chybí.',
        'Rozhodněte o každém z tvrzení 10.1–10.3, zda je pravdivé (A), nebo nepravdivé (N).',
        '10.1 V pátek mělo službu v kuchyni celkem 9 dětí.',
        '10.2 U každého jídla měli službu v kuchyni společně s dětmi nejvýše 3 instruktoři.',
        '10.3 Instruktorů muselo být na táboře nejméně 8.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'graf-sluzby.svg',
     'alt': 'Skupinový sloupcový graf počtu dětí ve službě u snídaně, oběda a večeře pondělí až čtvrtek; páteční sloupce chybí.',
     'cap': 'Rozpis služeb dětí (počet dětí)',
     'sol': ['Z grafu je počet dětí ve službě od pondělí do čtvrtka $28$; protože dětí je $35$ a každé slouží právě jednou, v pátek slouží $35-28=7$ dětí. Tvrzení 10.1 je tedy nepravdivé (N).',
             'Počet instruktorů u jídla je roven požadovanému počtu zmenšenému o počet dětí. V pondělí u večeře je jen $1$ dítě, tedy $5-1=4$ instruktoři – více než 3. Tvrzení 10.2 je nepravdivé (N).',
             'Každý instruktor slouží nejvýše jednou za den, proto je potřeba tolik instruktorů, kolik je jejich služeb v nejnáročnějším dni. Ve čtvrtek: snídaně $4-1=3$, oběd $5-2=3$, večeře $5-3=2$, celkem $8$. Instruktorů muselo být nejméně $8$. Tvrzení 10.3 je pravdivé (A).'],
     'ans': '10.1: N; 10.2: N; 10.3: A', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2026 – úloha 11', 'zad': [
        'Petr si vzal na nákupy určitý počet korun a $18\\,\\%$ z nich utratil za první nákup. Zbylo mu tak $328$ korun a $25\\,\\%$ z nich utratil za druhý nákup.',
        'Kolik korun Petr utratil za oba nákupy dohromady?'],
     'opts': ['A) $141$ korun', 'B) $154$ korun', 'C) $164$ korun', 'D) $172$ korun', 'E) jiný počet korun'],
     'ln': 0,
     'sol': ['Po prvním nákupu zbylo $82\\,\\%$ původní částky, tj. $328$ korun; původní částka je $328:0{,}82=400$ korun. První nákup: $0{,}18\\cdot 400=72$ korun. Druhý nákup: $0{,}25\\cdot 328=82$ korun. Dohromady $72+82=154$ korun.'],
     'ans': 'B) $154$ korun', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7C 2026 – úloha 12', 'zad': [
        'Alena vytvořila ze stejných sirek trojúhelníky a čtverce. Na každý trojúhelník použila 3 sirky a na každý čtverec 4 sirky, přitom žádná sirka nebyla společná pro dva útvary. Na všechny útvary použila celkem 90 sirek. Čtverců Alena vytvořila o dva méně než trojúhelníků.',
        'Kolik útvarů (trojúhelníků a čtverců) Alena celkem vytvořila?'],
     'opts': ['A) $24$ útvarů', 'B) $25$ útvarů', 'C) $26$ útvarů', 'D) $28$ útvarů', 'E) jiný počet útvarů'],
     'ln': 0,
     'sol': ['Nechť trojúhelníků je $t$ a čtverců $t-2$. Pak $3t+4(t-2)=90$, tj. $7t=98$ a $t=14$. Čtverců je $12$, útvarů celkem $14+12=26$.'],
     'ans': 'C) $26$ útvarů', 'pts': 2, 'mins': 4, 'diff': '2',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2026 – úloha 13', 'zad': [
        'Na tržišti se vyměňuje zboží. Jedna husa se vymění za $48$ kg brambor, jedna slepice za $18$ kg brambor.',
        'Za kolik hus se vymění stejné množství brambor, jako se vymění za 40 slepic?'],
     'opts': ['A) za $20$ hus', 'B) za $18$ hus', 'C) za $16$ hus', 'D) za $15$ hus', 'E) za $12$ hus'],
     'ln': 0,
     'sol': ['$40$ slepic odpovídá $40\\cdot 18=720$ kg brambor. Počet hus: $720:48=15$.'],
     'ans': 'D) za $15$ hus', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2026 – úloha 14', 'zad': [
        'V parku se konaly běžecké závody dvoučlenných a čtyřčlenných štafet. Závodů se zúčastnilo celkem 60 soutěžících a ti vytvořili 21 štafet. Každý soutěžící běžel pouze v jedné štafetě.',
        'Jaká část soutěžících běžela ve čtyřčlenných štafetách?'],
     'opts': ['A) $\\frac{3}{10}$', 'B) $\\frac{7}{20}$', 'C) $\\frac{3}{5}$', 'D) $\\frac{2}{3}$', 'E) jiná část'],
     'ln': 0,
     'sol': ['Nechť dvoučlenných štafet je $d$ a čtyřčlenných $c$. Pak $d+c=21$ a $2d+4c=60$. Odtud $c=9$; ve čtyřčlenných běželo $4\\cdot 9=36$ soutěžících, tj. část $\\frac{36}{60}=\\frac{3}{5}$.'],
     'ans': 'C) $\\frac{3}{5}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2026 – úloha 15', 'zad': [
        'Každý z 80 prvňáků dostal školní sadu. Všechny tyto sady dohromady stály $36\\,000$ korun. Školní sada pro prvňáky obsahuje slabikář a balíček na malování s temperami a pastelkami.',
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Každý prvňák zaplatil za školní sadu 90 korun a zbytek její ceny uhradila škola. Kolik procent z ceny sady pro prvňáky uhradila škola?',
        '15.2 Poměr ceny temper ku ceně pastelek byl $3:2$. O kolik procent byla cena temper vyšší než cena pastelek?',
        '15.3 Cena slabikáře byla o 50 korun vyšší než cena balíčku na malování. O kolik procent byla cena slabikáře vyšší než cena balíčku na malování?'],
     'opts': ['A) $20\\,\\%$', 'B) $25\\,\\%$', 'C) $30\\,\\%$', 'D) $40\\,\\%$', 'E) $50\\,\\%$', 'F) více než $50\\,\\%$'],
     'ln': 0,
     'sol': ['Cena jedné sady je $36\\,000:80=450$ korun.',
             '15.1 Škola uhradila $450-90=360$ korun, tj. $\\frac{360}{450}=80\\,\\%$ – více než $50\\,\\%$ → F.',
             '15.2 Při poměru $3:2$ jsou tempery o $\\frac{3-2}{2}=\\frac{1}{2}=50\\,\\%$ dražší → E.',
             '15.3 Slabikář $+$ balíček $=450$ a slabikář je o 50 korun dražší: balíček $200$, slabikář $250$ korun; rozdíl $\\frac{50}{200}=25\\,\\%$ → B.'],
     'ans': '15.1: F (o $80\\,\\%$); 15.2: E (o $50\\,\\%$); 15.3: B (o $25\\,\\%$)', 'pts': 6, 'mins': 9, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7C 2026 – úloha 16', 'zad': [
        'První obrazec je čtverec. Druhý obrazec má tvar obdélníku a vznikl z prvního obrazce přidáním dvou menších čtverců. Každý další obrazec má opět tvar obdélníku a vznikne tak, že u kratší strany předchozího obrazce přidáme tolik menších čtverců, kolikátý obrazec vytváříme (viz obrázek). Např. 3. obrazec vznikl z 2. obrazce přidáním tří menších čtverců. Delší strana 4. obrazce měří 125 cm.',
        '16.1 Vypočtěte, kolik cm měří strana 1. obrazce.',
        '16.2 Vypočtěte, o kolik cm² se liší obsah 4. obrazce a obsah 5. obrazce.',
        '16.3 Vypočtěte, kolik cm měří obvod 6. obrazce.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'obrazce-ctverce.svg',
     'alt': 'Posloupnost obrazců: čtverec, obdélník s dvěma menšími čtverci a obdélník s dalšími menšími čtverci.',
     'cap': 'Schematický nákres 1. až 3. obrazce',
     'sol': ['Kratší strana všech obrazců je stále strana $a$ prvního čtverce. Při tvorbě $n$-tého obrazce se delší strana prodlouží o $\\frac{a}{n}$ (šířka $n$ menších čtverců se stranou $\\frac{a}{n}$).',
             '16.1 Delší strana 4. obrazce je $a+\\frac{a}{2}+\\frac{a}{3}+\\frac{a}{4}=\\frac{25}{12}a=125$, tedy $a=60$ cm.',
             '16.2 Při tvorbě 5. obrazce se delší strana prodlouží o $\\frac{60}{5}=12$ cm; přibude pruh $60\\times 12$, obsahy se tedy liší o $60\\cdot 12=720$ cm².',
             '16.3 Delší strana 6. obrazce je $125+\\frac{60}{5}+\\frac{60}{6}=125+12+10=147$ cm; obvod je $2\\cdot(147+60)=414$ cm.'],
     'ans': '16.1: $60$ cm; 16.2: o $720$ cm²; 16.3: $414$ cm', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PCD26C0T03'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7C-2026')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
