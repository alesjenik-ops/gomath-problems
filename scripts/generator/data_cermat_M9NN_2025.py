# -*- coding: utf-8 -*-
# CERMAT – PŘIJÍMAČKY NANEČISTO 2025, MATEMATIKA 9 (čtyřleté obory, 9. ročník).
# Kód testu: M9PND25C0T01. 16 úloh, 50 bodů (po rozdělení izolovaných poduúloh 21 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR).

# ---- SVG obrázky (bez ' a \) ----

# úloha 8: ornament (osmiúhelník s tmavým čtvercem uprostřed) – schematicky
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 300" font-family="sans-serif">
<polygon points="110,20 190,20 280,110 280,190 190,280 110,280 20,190 20,110" fill="#ffffff" stroke="#000" stroke-width="2"/>
<rect x="110" y="110" width="80" height="80" fill="#bdbdbd" stroke="#000"/>
<line x1="110" y1="20" x2="110" y2="110" stroke="#000"/>
<line x1="190" y1="20" x2="190" y2="110" stroke="#000"/>
<line x1="280" y1="110" x2="190" y2="110" stroke="#000"/>
<line x1="280" y1="190" x2="190" y2="190" stroke="#000"/>
<line x1="190" y1="280" x2="190" y2="190" stroke="#000"/>
<line x1="110" y1="280" x2="110" y2="190" stroke="#000"/>
<line x1="20" y1="190" x2="110" y2="190" stroke="#000"/>
<line x1="20" y1="110" x2="110" y2="110" stroke="#000"/>
</svg>"""

# úloha 9: trojúhelník ABC s bodem A' (prime) na straně BC
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 340" font-family="sans-serif">
<polygon points="70,60 170,310 340,190" fill="none" stroke="#000" stroke-width="2"/>
<circle cx="245" cy="145" r="3" fill="#000"/>
<text x="52" y="58" font-size="16" font-style="italic">C</text>
<text x="166" y="330" font-size="16" font-style="italic">A</text>
<text x="350" y="192" font-size="16" font-style="italic">B</text>
<text x="250" y="138" font-size="16" font-style="italic">A′</text>
</svg>"""

# úloha 10: přímky AC a PX protínající se v bodě P
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 320" font-family="sans-serif">
<line x1="50" y1="285" x2="350" y2="70" stroke="#000" stroke-width="2"/>
<line x1="80" y1="50" x2="405" y2="270" stroke="#000" stroke-width="2"/>
<text x="55" y="278" font-size="15">×</text><text x="40" y="300" font-size="16" font-style="italic">A</text>
<text x="342" y="80" font-size="15">×</text><text x="356" y="70" font-size="16" font-style="italic">C</text>
<text x="393" y="262" font-size="15">×</text><text x="408" y="270" font-size="16" font-style="italic">X</text>
<text x="228" y="150" font-size="16" font-style="italic">P</text>
</svg>"""

# úloha 11: pravidelný desetiúhelník se středem S a úhly alfa, beta, gama – schematicky
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 300" font-family="sans-serif">
<polygon points="150,30 220,53 264,113 264,187 220,247 150,270 80,247 36,187 36,113 80,53" fill="none" stroke="#000" stroke-width="2"/>
<circle cx="150" cy="150" r="2.5" fill="#000"/>
<text x="156" y="146" font-size="14" font-style="italic">S</text>
<line x1="150" y1="150" x2="150" y2="30" stroke="#000"/>
<line x1="150" y1="150" x2="264" y2="113" stroke="#000"/>
<line x1="150" y1="150" x2="264" y2="187" stroke="#000"/>
<line x1="150" y1="150" x2="36" y2="113" stroke="#000"/>
<text x="168" y="118" font-size="15">β</text>
<text x="168" y="176" font-size="15">α</text>
<text x="96" y="140" font-size="15">γ</text>
</svg>"""

# úloha 13: čtvrtka rozdělená 6 rovnými čarami na 15 částí (příklad)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 180" font-family="sans-serif">
<rect x="30" y="30" width="200" height="120" fill="#d9d9d9" stroke="#000" stroke-width="1"/>
<line x1="70" y1="30" x2="70" y2="150" stroke="#000" stroke-width="3"/>
<line x1="110" y1="30" x2="110" y2="150" stroke="#000" stroke-width="3"/>
<line x1="150" y1="30" x2="150" y2="150" stroke="#000" stroke-width="3"/>
<line x1="190" y1="30" x2="190" y2="150" stroke="#000" stroke-width="3"/>
<line x1="30" y1="70" x2="230" y2="70" stroke="#000" stroke-width="3"/>
<line x1="30" y1="110" x2="230" y2="110" stroke="#000" stroke-width="3"/>
</svg>"""

# úloha 14: domeček (kvádr + trojboký hranol/střecha) – schematicky
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 240" font-family="sans-serif">
<polygon points="60,120 60,200 140,200 140,120 100,70" fill="#f0f0f0" stroke="#000" stroke-width="2"/>
<line x1="140" y1="200" x2="250" y2="160" stroke="#000" stroke-width="1.5" stroke-dasharray="4 4"/>
<line x1="140" y1="120" x2="250" y2="80" stroke="#000" stroke-width="1.5" stroke-dasharray="4 4"/>
<line x1="100" y1="70" x2="210" y2="30" stroke="#000" stroke-width="1.5" stroke-dasharray="4 4"/>
<polyline points="250,160 250,80 210,30" fill="none" stroke="#000" stroke-width="1.5" stroke-dasharray="4 4"/>
<line x1="60" y1="214" x2="140" y2="214" stroke="#000" stroke-width="1"/>
<text x="96" y="228" font-size="14" font-style="italic">a</text>
<text x="44" y="166" font-size="14" font-style="italic">a</text>
<text x="104" y="103" font-size="13" font-style="italic">v</text>
<text x="184" y="200" font-size="14" font-style="italic">4a</text>
</svg>"""

# úloha 16: dvojice obdélníků ze čtverečků (příklad: 2x3 -> 3x2) – schematicky
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 370 150" font-family="sans-serif">
<rect x="30" y="55" width="78" height="52" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<rect x="82" y="55" width="26" height="52" fill="#c9c9c9" stroke="#000" stroke-width="1"/>
<line x1="56" y1="55" x2="56" y2="107" stroke="#000"/>
<line x1="82" y1="55" x2="82" y2="107" stroke="#000"/>
<line x1="30" y1="81" x2="108" y2="81" stroke="#000"/>
<rect x="30" y="55" width="78" height="52" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="69" y="128" font-size="12" text-anchor="middle">nižší (2 řady)</text>
<text x="185" y="86" font-size="24" text-anchor="middle">→</text>
<rect x="250" y="30" width="52" height="78" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<rect x="250" y="30" width="52" height="26" fill="#c9c9c9" stroke="#000" stroke-width="1"/>
<line x1="276" y1="30" x2="276" y2="108" stroke="#000"/>
<line x1="250" y1="56" x2="302" y2="56" stroke="#000"/>
<line x1="250" y1="82" x2="302" y2="82" stroke="#000"/>
<rect x="250" y="30" width="52" height="78" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="276" y="128" font-size="12" text-anchor="middle">vyšší (3 řady)</text>
</svg>"""

B = ['zs2', 'r9']  # 9. ročník ZŠ (přijímačky na čtyřleté obory)

PROBLEMS = [
    {'name': 'CERMAT M9 nanečisto 2025 – úloha 1',
     'zad': ['Vypočtěte, o kolik cm² je plocha o obsahu $0{,}2$ m² větší než plocha o obsahu $20$ cm².'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}2$ m² $=2000$ cm². Rozdíl: $2000-20=1980$ cm².'],
     'ans': 'o $1980$ cm²', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 2.1',
     'zad': ['Vypočtěte: $(1{,}5^2-0{,}3^2):6=$'],
     'opts': None, 'ln': 2,
     'sol': ['$1{,}5^2-0{,}3^2=2{,}25-0{,}09=2{,}16$; $2{,}16:6=0{,}36$.'],
     'ans': '$0{,}36$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 2.2',
     'zad': ['Vypočtěte: $\\sqrt{\\dfrac{2\\cdot 2^2}{3}}\\cdot \\sqrt{\\dfrac{3}{2}}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\sqrt{\\dfrac{2\\cdot 2^2}{3}\\cdot \\dfrac{3}{2}}=\\sqrt{\\dfrac{8}{3}\\cdot\\dfrac{3}{2}}=\\sqrt{4}=2$.'],
     'ans': '$2$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $0{,}2-0{,}2\\cdot \\dfrac{5}{12}-\\left(-\\dfrac{7}{30}\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$0{,}2-\\dfrac{1}{12}+\\dfrac{7}{30}=\\dfrac{12}{60}-\\dfrac{5}{60}+\\dfrac{14}{60}=\\dfrac{21}{60}=\\dfrac{7}{20}$.'],
     'ans': '$\\dfrac{7}{20}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{1}{4}+\\frac{1}{6}}{\\frac{4}{9}-\\frac{5}{6}\\cdot\\frac{2}{15}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel $\\frac{1}{4}+\\frac{1}{6}=\\frac{5}{12}$. Jmenovatel $\\frac{4}{9}-\\frac{5}{6}\\cdot\\frac{2}{15}=\\frac{4}{9}-\\frac{1}{9}=\\frac{1}{3}$. Podíl $\\frac{5}{12}:\\frac{1}{3}=\\frac{5}{12}\\cdot 3=\\frac{5}{4}$.'],
     'ans': '$\\dfrac{5}{4}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 4.1',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky): $x^2-(x-2y)\\cdot(x+2y)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$x^2-(x^2-4y^2)=4y^2$.'],
     'ans': '$4y^2$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 4.2',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(5n-8)\\cdot(-3n)+(4n-3)^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(5n-8)(-3n)=-15n^2+24n$; $(4n-3)^2=16n^2-24n+9$. Součet $=n^2+9$.'],
     'ans': '$n^2+9$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 4.3',
     'zad': ['Zjednodušte a výsledný výraz rozložte na součin podle vzorce: $7\\cdot 3+10\\cdot(a^2+10)-a\\cdot(a+66)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$21+10a^2+100-a^2-66a=9a^2-66a+121=(3a-11)^2$.'],
     'ans': '$(3a-11)^2$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 5.1',
     'zad': ['Řešte rovnici: $\\dfrac{1}{5}y+\\dfrac{1}{2}=2\\cdot\\left(y+\\dfrac{1}{4}\\right)$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\frac{1}{5}y+\\frac{1}{2}=2y+\\frac{1}{2}$, odtud $\\frac{1}{5}y=2y$, tj. $\\frac{1}{5}y-2y=0$, $-\\frac{9}{5}y=0$, $y=0$.'],
     'ans': '$y=0$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 5.2',
     'zad': ['Řešte soustavu rovnic: $3x+\\dfrac{3}{4}y=1$; $3{,}5y+3x=6{,}5$.'],
     'opts': None, 'ln': 3,
     'sol': ['Odečtením první rovnice od druhé: $(3{,}5-0{,}75)y=6{,}5-1$, tj. $2{,}75y=5{,}5$, $y=2$. Dosazením: $3x+0{,}75\\cdot 2=1$, $3x=-0{,}5$, $x=-\\frac{1}{6}$.'],
     'ans': '$x=-\\dfrac{1}{6}$, $y=2$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 6',
     'zad': [
        'Zahradník sázel na záhon sazenice. Sazenic salátů zasadil o 4 více než sazenic okurek. Na záhoně čtvrtinu sazenic salátů zlikvidovali slimáci a šestina sazenic okurek uschla. Všechny ostatní sazenice se ujaly. Na záhoně se tak ujal stejný počet sazenic salátů a okurek.',
        'Určete:',
        '6.1 kolik sazenic salátů zahradník zasadil,',
        '6.2 kolik sazenic okurek se ujalo.'],
     'opts': None, 'ln': 3,
     'sol': [
        'Označme počet sazenic okurek $o$, salátů $o+4$. Ujalo se salátů $\\frac{3}{4}(o+4)$, okurek $\\frac{5}{6}o$. Rovnost $\\frac{3}{4}(o+4)=\\frac{5}{6}o$; po vynásobení 12 je $9(o+4)=10o$, tedy $o=36$.',
        '6.1 Salátů zahradník zasadil $o+4=40$.',
        '6.2 Okurek se ujalo $\\frac{5}{6}\\cdot 36=30$.'],
     'ans': '6.1: $40$ sazenic salátů; 6.2: $30$ sazenic okurek', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 7',
     'zad': [
        'Stejné výrobky jsou po 12 kusech baleny do stejných krabic. Na váhu se položily tři krabice, z nichž dvě byly plné, ale ve třetí krabici 5 výrobků chybělo. Tyto tři krabice i s výrobky vážily dohromady 2 kg. Když se z váhy odebraly obě plné krabice, displej váhy ukazoval 480 g.',
        'Vypočtěte, jaká je hmotnost v gramech:',
        '7.1 jedné plné krabice,',
        '7.2 jednoho výrobku,',
        '7.3 jedné prázdné krabice.'],
     'opts': None, 'ln': 3,
     'sol': [
        'Třetí krabice se 7 výrobky váží 480 g. Obě plné krabice tedy váží $2000-480=1520$ g, jedna plná krabice $760$ g.',
        '7.1 Jedna plná krabice $=760$ g.',
        '7.2 Rozdíl plné a třetí krabice je 5 výrobků: $760-480=280$ g, jeden výrobek $280:5=56$ g.',
        '7.3 Prázdná krabice $=760-12\\cdot 56=760-672=88$ g.'],
     'ans': '7.1: $760$ g; 7.2: $56$ g; 7.3: $88$ g', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 8',
     'zad': [
        'Z rohů čtverce se stranou délky 27 cm se nejprve odstřihnou čtyři shodné trojúhelníky a poté se vykreslí ornament.',
        'Ornament obsahuje jeden tmavý čtyřúhelník uprostřed, čtyři shodné bílé obdélníky a čtyři shodné bílé trojúhelníky, jejichž kratší strany mají délky 9 cm a 12 cm.',
        'Vypočtěte:',
        '8.1 v cm obvod ornamentu (zakresleného vpravo),',
        '8.2 v cm² celkový obsah bílých ploch ornamentu (zakresleného vpravo).'],
     'opts': None, 'ln': 3, 'svg': SVG8, 'fn': 'ornament.svg',
     'alt': 'Schematický nákres ornamentu tvaru osmiúhelníku s tmavým čtvercem uprostřed, bílými obdélníky a trojúhelníky.',
     'cap': 'Schematický nákres ornamentu (zakresleného vpravo)',
     'sol': [
        '8.1 Odstřižené trojúhelníky mají odvěsny 9 cm a 12 cm, přepona $\\sqrt{9^2+12^2}=15$ cm. Na každé straně čtverce zůstane $27-9-12=6$ cm. Obvod osmiúhelníku $=4\\cdot 6+4\\cdot 15=84$ cm.',
        '8.2 Obsah osmiúhelníku $=27^2-4\\cdot\\frac{1}{2}\\cdot 9\\cdot 12=729-216=513$ cm². Tmavý čtverec uprostřed má stranu 9 cm a obsah $81$ cm². Bílé plochy: $513-81=432$ cm².'],
     'ans': '8.1: $84$ cm; 8.2: $432$ cm²', 'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 9 (konstrukce)',
     'zad': [
        "V rovině leží trojúhelník $ABC$, na jehož straně $BC$ je umístěn bod $A'$ (viz obrázek).",
        "Bod $A'$ je vrchol trojúhelníku $A'B'C'$, který je obrazem trojúhelníku $ABC$ ve středové souměrnosti se středem $S$.",
        "9.1 Sestrojte a označte písmenem střed souměrnosti $S$.",
        "9.2 Sestrojte vrcholy $B'$ a $C'$ trojúhelníku $A'B'C'$, označte je písmeny a trojúhelník narýsujte."],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'trojuhelnik-ABC.svg',
     'alt': 'Trojúhelník ABC s bodem A (s čárkou) umístěným na straně BC.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': [
        "9.1 Bod $A'$ je obrazem vrcholu $A$, proto střed souměrnosti $S$ je střed úsečky $AA'$.",
        "9.2 Vrcholy $B'$ a $C'$ jsou obrazy bodů $B$ a $C$ ve středové souměrnosti se středem $S$ (bod $S$ je střed úseček $BB'$ i $CC'$). Spojením $A'B'C'$ vznikne hledaný trojúhelník."],
     'ans': "Střed $S$ je střed úsečky $AA'$; body $B'$, $C'$ jsou obrazy bodů $B$, $C$ ve středové souměrnosti se středem $S$ (viz obrázek v klíči).",
     'pts': 2, 'mins': 5, 'diff': '2',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 10 (konstrukce)',
     'zad': [
        'V rovině leží přímky $AC$ a $PX$, které se protínají v bodě $P$ (viz obrázek).',
        'Body $A$, $C$ jsou vrcholy pravoúhlého lichoběžníku $ABCD$ se základnami $AB$, $CD$ a pravým úhlem při vrcholu $D$. Bod $P$ je průsečík úhlopříček tohoto lichoběžníku. Vrchol $D$ leží na přímce $PX$.',
        'Sestrojte vrcholy $B$, $D$ pravoúhlého lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'primky-AC-PX.svg',
     'alt': 'Přímky AC a PX protínající se v bodě P; na přímkách jsou vyznačeny body A, C a X.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': [
        'Pravý úhel je při vrcholu $D$ (úhel $ADC$), proto $D$ leží na Thaletově kružnici nad průměrem $AC$. Zároveň $D$ leží na přímce $PX$; průsečíky dávají dvě polohy $D_1$, $D_2$.',
        'Bod $P$ je průsečík úhlopříček, takže vrchol $B$ leží na přímce $DP$; jeho polohu určuje rovnoběžnost základen $AB \\parallel CD$. Úloha má dvě řešení (lichoběžníky s vrcholy $D_1, B_1$ a $D_2, B_2$).'],
     'ans': 'Dvě řešení: $D$ je průsečík Thaletovy kružnice nad $AC$ s přímkou $PX$ ($D_1$, $D_2$), vrchol $B$ leží na přímce $DP$ tak, že $AB \\parallel CD$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 11',
     'zad': [
        'V náčrtku pravidelného desetiúhelníku se středem $S$ jsou vyznačeny úhly $\\alpha$, $\\beta$, $\\gamma$ (viz obrázek). Úhly neměřte, náčrtek není přesný.',
        'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
        '11.1 $\\alpha=72^\\circ$',
        '11.2 $\\beta<36^\\circ$',
        '11.3 $\\gamma=\\alpha$'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'desetiuhelnik.svg',
     'alt': 'Schematický náčrtek pravidelného desetiúhelníku se středem S a vyznačenými úhly alfa, beta a gama.',
     'cap': 'Schematický nákres (úhly neměřte)',
     'sol': [
        'V pravidelném desetiúhelníku je středový úhel příslušný jedné straně $360^\\circ:10=36^\\circ$ a vnitřní úhel $144^\\circ$; úhlopříčky z jednoho vrcholu dělí vnitřní úhel na osm dílů po $18^\\circ$.',
        '11.1 Úhel $\\alpha$ je středový úhel nad dvěma stranami: $2\\cdot 36^\\circ=72^\\circ$ → Ano (A).',
        '11.2 Úhel $\\beta=2\\cdot 18^\\circ=36^\\circ$, není tedy menší než $36^\\circ$ → Ne (N).',
        '11.3 Úhel $\\gamma=4\\cdot 18^\\circ=72^\\circ=\\alpha$ → Ano (A).'],
     'ans': '11.1: A; 11.2: N; 11.3: A', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 12',
     'zad': [
        'Kytice byla svázána ze tří druhů květin: růží, chryzantém a static.',
        'Růží a chryzantém dohromady je v kytici o 2 více než chryzantém a static dohromady. Počet růží ku počtu static je v poměru $5:4$, počet static ku počtu chryzantém v poměru $2:3$.',
        'Cena za jeden kus: růže $54$ korun, chryzantéma $40$ korun, statice $35$ korun. Cena celé kytice se získá jako součet cen jednotlivých květin.',
        'Kolik korun bude stát celá kytice?'],
     'opts': ['A) $1\\,090$ korun', 'B) $1\\,252$ korun', 'C) $1\\,280$ korun', 'D) $1\\,300$ korun', 'E) jinou částku'],
     'ln': 0,
     'sol': [
        'Z podmínky „růží a chryzantém o 2 více než chryzantém a static" plyne $R=St+2$. Z poměru $R:St=5:4$ je $R=\\frac{5}{4}St$, odtud $\\frac{5}{4}St=St+2$, tedy $St=8$ a $R=10$. Z poměru $St:Ch=2:3$ je $Ch=\\frac{3}{2}\\cdot 8=12$.',
        'Cena kytice: $10\\cdot 54+12\\cdot 40+8\\cdot 35=540+480+280=1300$ korun.'],
     'ans': 'D) $1\\,300$ korun', 'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 13',
     'zad': [
        'Na čtvrtku papíru narýsujeme rovné čáry, které jsou rovnoběžné s jedním nebo s druhým okrajem čtvrtky. Čáry jsou nakresleny přes celou čtvrtku a rozdělují ji na několik částí. Např. na obrázku rozděluje 6 rovných čar čtvrtku na 15 částí.',
        'Jaký je nejmenší počet rovných čar, které rozdělí čtvrtku na 40 částí?'],
     'opts': ['A) 11', 'B) 12', 'C) 13', 'D) 14', 'E) větší než 14'],
     'ln': 0, 'svg': SVG13, 'fn': 'ctvrtka-cary.svg',
     'alt': 'Schematický nákres čtvrtky rozdělené 6 rovnými čarami na 15 částí.',
     'cap': 'Příklad: 6 čar rozdělí čtvrtku na 15 částí',
     'sol': [
        'Čáry rovnoběžné se dvěma okraji: $v$ svislých a $h$ vodorovných čar rozdělí čtvrtku na $(v+1)(h+1)$ částí. Hledáme rozklad $40=(v+1)(h+1)$ s nejmenším součtem $v+h$.',
        'Nejmenší součet dává rozklad $40=5\\cdot 8$: $v+1=5$, $h+1=8$, tj. $v=4$, $h=7$, celkem $4+7=11$ čar.'],
     'ans': 'A) 11', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 14',
     'zad': [
        'Dřevěný domeček se skládá ze dvou kolmých hranolů a stojí na vodorovné podložce. Plocha, kterou se domeček dotýká podložky, má obsah $16$ cm². V obrázku jsou označeny některé rozměry hranolů. Platí $v=a$.',
        'Jaký je objem domečku?'],
     'opts': ['A) $42$ cm³', 'B) $48$ cm³', 'C) $56$ cm³', 'D) $64$ cm³', 'E) jiný objem'],
     'ln': 0, 'svg': SVG14, 'fn': 'domecek.svg',
     'alt': 'Schematický nákres domečku složeného z kvádru a trojbokého hranolu (střechy) s rozměry a, 4a a výškou v.',
     'cap': 'Schematický nákres domečku',
     'sol': [
        'Dolní podstava kvádru má rozměry $a\\times 4a$ a dotýká se podložky: $4a^2=16$, tedy $a=2$ cm.',
        'Objem kvádru: $a\\cdot 4a\\cdot a=4a^3=4\\cdot 8=32$ cm³. Objem střešního trojbokého hranolu: $\\frac{1}{2}\\cdot a\\cdot v\\cdot 4a=\\frac{1}{2}\\cdot a\\cdot a\\cdot 4a=2a^3=16$ cm³.',
        'Celkový objem $32+16=48$ cm³.'],
     'ans': 'B) $48$ cm³', 'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 15',
     'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Tři pětiny objemu nádoby jsou zaplněny vodou. Celou nádobu zaplníme po dolití dalších 14 litrů vody. (Nádoba nepřeteče.) Jaký je objem nádoby?',
        '15.2 Voda v nádobě vyplňuje $55\\,\\%$ jejího objemu. Když z nádoby odebereme 12 litrů vody, bude zaplněna přesně čtvrtina objemu nádoby. Jaký je objem nádoby?',
        '15.3 V každé ze tří stejných nádob je nalito jiné množství vody. V první nádobě vyplňuje voda $30\\,\\%$ jejího objemu a ve druhé nádobě $40\\,\\%$ objemu. Ve třetí nádobě je 19 litrů vody. Kdybychom vodu ze všech nádob rozdělili rovnoměrně, voda by v každé nádobě vyplnila dvě pětiny jejího objemu. Jaký je objem jedné nádoby?'],
     'opts': ['A) 30 litrů', 'B) 33 litrů', 'C) 35 litrů', 'D) 38 litrů', 'E) 40 litrů', 'F) jiný objem'],
     'ln': 0,
     'sol': [
        '15.1 Dolitých 14 litrů odpovídá $1-\\frac{3}{5}=\\frac{2}{5}$ objemu, objem $=14:\\frac{2}{5}=35$ litrů → C.',
        '15.2 Odebraných 12 litrů odpovídá $55\\,\\%-25\\,\\%=30\\,\\%$ objemu, objem $=12:0{,}3=40$ litrů → E.',
        '15.3 Nechť $V$ je objem nádoby. Celkem vody $0{,}3V+0{,}4V+19=1{,}2V$ (tj. $3\\cdot 0{,}4V$). Odtud $0{,}5V=19$, $V=38$ litrů → D.'],
     'ans': '15.1: C (35 litrů); 15.2: E (40 litrů); 15.3: D (38 litrů)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9 nanečisto 2025 – úloha 16',
     'zad': [
        'Obdélníky jsou sestaveny ze čtverečků. Pro každou dvojici obdélníků sestavených ze stejného počtu čtverečků platí: vyšší z obou obdélníků má vždy o jednu řadu čtverečků více než nižší obdélník; vyšší obdélník vznikne z nižšího přesunutím několika sloupců do horní řady; počet přesunutých sloupců je vždy o 1 menší, než je počet řad v nižším obdélníku (z obdélníku se 2 řadami se přemístí 1 sloupec, ze 3 řad 2 sloupce atd.).',
        '16.1 V jedné dvojici obdélníků má nižší obdélník 21 řad. V této dvojici určete počet sloupců ve vyšším obdélníku.',
        '16.2 V jiné dvojici obdélníků má vyšší obdélník 110 sloupců. V této dvojici určete počet řad v nižším obdélníku.'],
     'opts': None, 'ln': 2, 'svg': SVG16, 'fn': 'obdelniky.svg',
     'alt': 'Schematický nákres dvojice obdélníků ze čtverečků: nižší (2 řady, 3 sloupce) a z něj vzniklý vyšší (3 řady, 2 sloupce).',
     'cap': 'Příklad dvojice obdélníků (přesun sloupce do horní řady)',
     'sol': [
        'Označme počet řad nižšího obdélníku $r$. Přemístí se $r-1$ sloupců a vzniklá horní řada je plná; nižší obdélník má pak $r^2-1$ sloupců a vyšší obdélník má $r+1$ řad a $r(r-1)$ sloupců (celkový počet čtverečků $r(r^2-1)$ zůstává zachován).',
        '16.1 Pro $r=21$ má vyšší obdélník $r(r-1)=21\\cdot 20=420$ sloupců.',
        '16.2 Z rovnice $r(r-1)=110$ plyne $r=11$; nižší obdélník má tedy 11 řad.'],
     'ans': '16.1: $420$ sloupců; 16.2: $11$ řad', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PND25C0T01'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9NN-2025')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
