# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 7 (šestileté obory, 7. ročník),
# varianta D (2. náhradní termín). Kód testu: M7PDD22C0T04.
# 16 úloh v testu; po rozdělení izolovaných "Vypočtěte" poduúloh (úloha 2 a 3) je 18 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 4: dva shodné nákresy I. a II. (kroužky, násobení 3 a 4, dolní čtvereček 43)
def _n4(ox, label):
    s = [f'<text x="{ox+90}" y="18" text-anchor="middle" font-size="13">{label}</text>']
    s.append(f'<circle cx="{ox+40}" cy="55" r="15" fill="none" stroke="#000"/><text x="{ox+66}" y="60">+</text>')
    s.append(f'<circle cx="{ox+95}" cy="55" r="15" fill="none" stroke="#000"/><text x="{ox+121}" y="60">=</text>')
    s.append(f'<rect x="{ox+138}" y="40" width="30" height="30" fill="none" stroke="#000" stroke-width="2"/>')
    s.append(f'<text x="{ox+30}" y="98" font-size="12">· 3</text><text x="{ox+108}" y="98" font-size="12">· 4</text>')
    s.append(f'<line x1="{ox+40}" y1="72" x2="{ox+40}" y2="118" stroke="#000"/><polygon points="{ox+40},122 {ox+36},114 {ox+44},114" fill="#000"/>')
    s.append(f'<line x1="{ox+95}" y1="72" x2="{ox+95}" y2="118" stroke="#000"/><polygon points="{ox+95},122 {ox+91},114 {ox+99},114" fill="#000"/>')
    s.append(f'<circle cx="{ox+40}" cy="150" r="15" fill="none" stroke="#000"/><text x="{ox+66}" y="155">+</text>')
    s.append(f'<circle cx="{ox+95}" cy="150" r="15" fill="none" stroke="#000"/><text x="{ox+121}" y="155">=</text>')
    s.append(f'<rect x="{ox+138}" y="135" width="30" height="30" fill="none" stroke="#000"/><text x="{ox+153}" y="156" text-anchor="middle" font-size="13">43</text>')
    return "".join(s)
SVG4 = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 180" font-family="sans-serif" font-size="14">' + _n4(0, "I. nákres") + _n4(230, "II. nákres") + '</svg>'

# úloha 5: schematická věž se dvěma schodišti (ochoz, 2 odpočívadla, nádvoří)
SVG5 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 300" font-family="sans-serif" font-size="13">
<polygon points="150,18 214,70 86,70" fill="none" stroke="#999"/>
<line x1="86" y1="70" x2="86" y2="262" stroke="#999"/><line x1="214" y1="70" x2="214" y2="262" stroke="#999"/>
<line x1="100" y1="80" x2="200" y2="80" stroke="#000" stroke-width="2"/><text x="80" y="84" text-anchor="end">ochoz</text>
<line x1="100" y1="140" x2="200" y2="140" stroke="#000"/><text x="80" y="144" text-anchor="end">2. odpočívadlo</text>
<line x1="100" y1="200" x2="200" y2="200" stroke="#000"/><text x="80" y="204" text-anchor="end">1. odpočívadlo</text>
<line x1="100" y1="260" x2="200" y2="260" stroke="#000"/><text x="80" y="262" text-anchor="end">nádvoří</text>
<line x1="128" y1="258" x2="128" y2="84" stroke="#000" stroke-dasharray="3 3"/><polygon points="128,80 124,89 132,89" fill="#000"/>
<line x1="172" y1="84" x2="172" y2="258" stroke="#000" stroke-dasharray="3 3"/><polygon points="172,262 168,253 176,253" fill="#000"/>
</svg>"""

# úloha 7: tmavý čtverec + 2 bílé trojúhelníky + 2 bílé lichoběžníky (schematicky)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 260" font-family="sans-serif" font-size="13">
<polygon points="100,80 200,80 150,28" fill="#fff" stroke="#000"/>
<polygon points="100,180 200,180 150,232" fill="#fff" stroke="#000"/>
<polygon points="100,80 100,180 52,155 52,105" fill="#fff" stroke="#000"/>
<polygon points="200,80 200,180 248,155 248,105" fill="#fff" stroke="#000"/>
<rect x="100" y="80" width="100" height="100" fill="#9a9a9a" stroke="#000"/>
</svg>"""

# úloha 8: výchozí obrázek – přímka p bodem A a bod S
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 210" font-family="sans-serif" font-size="14">
<line x1="40" y1="175" x2="340" y2="115" stroke="#000" stroke-width="1.5"/><text x="346" y="117" font-style="italic">p</text>
<line x1="150" y1="146" x2="150" y2="162" stroke="#000"/><text x="145" y="180" font-style="italic">A</text>
<text x="204" y="90" font-size="15">×</text><text x="213" y="78" font-style="italic">S</text>
</svg>"""

# úloha 9: výchozí obrázek – body C, Q a přímka p
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 235" font-family="sans-serif" font-size="14">
<line x1="90" y1="205" x2="330" y2="115" stroke="#000" stroke-width="1.5"/><text x="336" y="116" font-style="italic">p</text>
<text x="205" y="95" font-size="15">×</text><text x="206" y="80" font-style="italic">C</text>
<text x="118" y="122" font-size="15">×</text><text x="119" y="107" font-style="italic">Q</text>
</svg>"""

# úloha 10: tři útvary A, B, C ve čtvercové síti (schematicky)
def _grid10():
    c = 14; n = 5
    def one(ox, label, cells):
        s = [f'<text x="{ox+n*c//2}" y="15" text-anchor="middle" font-size="12">{label}</text>', '<g fill="#b9b9b9">']
        for (cx, cy) in cells:
            s.append(f'<rect x="{ox+cx*c}" y="{22+cy*c}" width="{c}" height="{c}"/>')
        s.append('</g><g stroke="#999" fill="none">')
        for i in range(n + 1):
            s.append(f'<line x1="{ox+i*c}" y1="22" x2="{ox+i*c}" y2="{22+n*c}"/>')
            s.append(f'<line x1="{ox}" y1="{22+i*c}" x2="{ox+n*c}" y2="{22+i*c}"/>')
        s.append('</g>')
        return "".join(s)
    A = [(2, 0), (1, 1), (2, 1), (3, 1), (0, 2), (2, 2), (4, 2), (1, 3), (2, 3), (3, 3)]
    B = [(2, 0), (1, 1), (3, 1), (0, 2), (2, 2), (4, 2), (1, 3), (3, 3), (2, 4)]
    C = [(2, 0), (2, 1), (0, 2), (1, 2), (2, 2), (3, 2), (4, 2), (2, 3), (2, 4)]
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 108" font-family="sans-serif">']
    out.append(one(10, "A", A)); out.append(one(120, "B", B)); out.append(one(230, "C", C))
    out.append('</svg>')
    return "".join(out)
SVG10 = _grid10()

# úloha 11: čtyřúhelník se dvěma tmavými rovnostrannými trojúhelníky a úhly (schematicky)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 200" font-family="sans-serif" font-size="14">
<polygon points="30,150 150,120 250,58 360,58 260,150" fill="#fff" stroke="#000"/>
<polygon points="150,120 250,58 260,150" fill="#9a9a9a" stroke="#000"/>
<polygon points="250,58 360,58 260,150" fill="#9a9a9a" stroke="#000"/>
<line x1="30" y1="150" x2="150" y2="120" stroke="#000"/>
<line x1="150" y1="120" x2="260" y2="150" stroke="#000"/>
<text x="58" y="146" font-size="12">41°</text>
<text x="150" y="110" font-size="13">φ</text>
<text x="160" y="134" font-size="12">36°</text>
</svg>"""

# úloha 12: slepené těleso ze čtyř trojbokých hranolů (lichoběžníkový hranol, schematicky)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200" font-family="sans-serif" font-size="13">
<polygon points="40,160 130,88 270,88 360,160" fill="#9a9a9a" stroke="#000"/>
<polygon points="70,150 150,82 288,82 320,150" fill="none" stroke="#000"/>
<line x1="40" y1="160" x2="70" y2="150" stroke="#000"/>
<line x1="130" y1="88" x2="150" y2="82" stroke="#000"/>
<line x1="270" y1="88" x2="288" y2="82" stroke="#000"/>
<line x1="360" y1="160" x2="320" y2="150" stroke="#000"/>
<line x1="130" y1="88" x2="130" y2="160" stroke="#000" stroke-dasharray="3 3"/>
<line x1="270" y1="88" x2="270" y2="160" stroke="#000" stroke-dasharray="3 3"/>
</svg>"""

# úloha 13: vodorovný sloupcový graf (Radek a Tomáš zobrazeni, Petr a Standa chybí)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 220" font-family="sans-serif" font-size="13">
<text x="215" y="18" text-anchor="middle">Počet kartiček</text>
<line x1="90" y1="38" x2="90" y2="192" stroke="#000"/>
<text x="88" y="206" text-anchor="middle">0</text>
<text x="80" y="64" text-anchor="end">Petr</text>
<text x="80" y="106" text-anchor="end">Radek</text>
<text x="80" y="146" text-anchor="end">Standa</text>
<text x="80" y="186" text-anchor="end">Tomáš</text>
<rect x="90" y="92" width="264" height="24" fill="#9a9a9a" stroke="#000"/>
<rect x="90" y="172" width="211" height="24" fill="#9a9a9a" stroke="#000"/>
<line x1="90" y1="60" x2="360" y2="60" stroke="#000" stroke-dasharray="5 4"/>
<line x1="90" y1="140" x2="360" y2="140" stroke="#000" stroke-dasharray="5 4"/>
</svg>"""

B = ['zs2', 'r7']  # základ: 2. stupeň ZŠ, 7. ročník (šestileté obory)

PROBLEMS = [
    {'name': 'CERMAT M7D 2022 – úloha 1',
     'zad': ['Vypište všechny dělitele čísla $95$, které jsou větší než $1$ a menší než $95$.'],
     'opts': None, 'ln': 2,
     'sol': ['$95=5\\cdot 19$. Dělitelé čísla $95$ jsou $1$, $5$, $19$, $95$. Mezi $1$ a $95$ tedy leží $5$ a $19$.'],
     'ans': '$5$; $19$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 2.1',
     'zad': ['Vypočtěte: $(-3)\\cdot(-3)-5\\cdot 5-4\\cdot(-4)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(-3)\\cdot(-3)=9$, $5\\cdot 5=25$, $4\\cdot(-4)=-16$. Tedy $9-25-(-16)=9-25+16=0$.'],
     'ans': '$0$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 2.2',
     'zad': ['Vypočtěte: $(0{,}08-1):0{,}2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}08-1=-0{,}92$; $(-0{,}92):0{,}2=-4{,}6$.'],
     'ans': '$-4{,}6$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{12}{5}\\cdot\\frac{3}{20}-\\frac{3}{20}\\right):\\frac{7}{25}=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\frac{12}{5}\\cdot\\frac{3}{20}=\\frac{36}{100}=\\frac{9}{25}$; $\\frac{9}{25}-\\frac{3}{20}=\\frac{36-15}{100}=\\frac{21}{100}$; $\\frac{21}{100}:\\frac{7}{25}=\\frac{21}{100}\\cdot\\frac{25}{7}=\\frac{3}{4}$.'],
     'ans': '$\\frac{3}{4}$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{12}{\\,2+\\frac{2}{3}\\,}\\cdot\\dfrac{2\\cdot\\frac{2}{3}}{18}=$'],
     'opts': None, 'ln': 3,
     'sol': ['$2+\\frac{2}{3}=\\frac{8}{3}$, takže $\\frac{12}{8/3}=12\\cdot\\frac{3}{8}=\\frac{9}{2}$. Dále $2\\cdot\\frac{2}{3}=\\frac{4}{3}$, takže $\\frac{4/3}{18}=\\frac{4}{54}=\\frac{2}{27}$. Součin: $\\frac{9}{2}\\cdot\\frac{2}{27}=\\frac{18}{54}=\\frac{1}{3}$.'],
     'ans': '$\\frac{1}{3}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 4',
     'zad': [
        'V každém nákresu se do prázdných kroužků a čtverečků doplňují pouze celá čísla větší než $0$. Podle vzoru se čísla v obou horních kroužcích sečtou do horního (silně ohraničeného) čtverečku; levý horní kroužek se vynásobí třemi a pravý čtyřmi, výsledky se zapíšou do dolních kroužků a jejich součet do dolního čtverečku. V I. i II. nákresu je v dolním čtverečku číslo $43$.',
        '4.1 Doplňte v I. nákresu taková čísla, aby byl součet v silně ohraničeném (horním) čtverečku co nejmenší.',
        '4.2 Doplňte ve II. nákresu taková čísla, aby byl součet v silně ohraničeném (horním) čtverečku co největší.'],
     'opts': None, 'ln': 2, 'svg': SVG4, 'fn': 'nakresy.svg',
     'alt': 'Dva shodné nákresy s horními kroužky, násobením třemi a čtyřmi a dolním čtverečkem s číslem 43.',
     'cap': 'I. a II. nákres k úloze 4',
     'sol': [
        'Označme čísla v horních kroužcích $a$ (vlevo) a $b$ (vpravo). Dolní kroužky jsou $3a$ a $4b$, jejich součet $3a+4b=43$. Do silně ohraničeného čtverečku patří $a+b$.',
        'Celá kladná řešení: $(a,b)=(1,10),(5,7),(9,4),(13,1)$; součty $a+b$ jsou $11$, $12$, $13$, $14$.',
        '4.1 Nejmenší součet je $11$ (pro $a=1$, $b=10$).',
        '4.2 Největší součet je $14$ (pro $a=13$, $b=1$).'],
     'ans': '4.1: $11$; 4.2: $14$', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 5',
     'zad': [
        'Z nádvoří se chodí nahoru na ochoz věže po $80$ stejných vyšších schodech, zatímco zpět na nádvoří se chodí dolů jiným schodištěm po $96$ stejných nižších schodech. Obě schodiště jsou ve dvou místech propojena odpočívadly.',
        'Václav šel z nádvoří nahoru a po $60$ schodech potkal na 2. odpočívadle Danu, která šla dolů. Když Dana sešla ještě o $30$ schodů níže, potkala na 1. odpočívadle Evu, která šla nahoru.',
        '5.1 Vypočtěte, kolik schodů sešla Dana dolů z ochozu, než potkala Václava.',
        '5.2 Vypočtěte, kolik schodů vyšla Eva nahoru z nádvoří, než potkala Danu.'],
     'opts': None, 'ln': 3, 'svg': SVG5, 'fn': 'vez-schodiste.svg',
     'alt': 'Schéma věže se dvěma schodišti mezi nádvořím a ochozem a dvěma odpočívadly.',
     'cap': 'Věž se dvěma schodišti',
     'sol': [
        'Výška je pro obě schodiště stejná. Václav vyšel $60$ z $80$ vyšších schodů, je tedy v $\\frac{60}{80}=\\frac{3}{4}$ výšky. Na nižším schodišti to odpovídá $\\frac{3}{4}\\cdot 96=72$ schodům od nádvoří, tj. $96-72=24$ schodům dolů z ochozu (2. odpočívadlo).',
        '5.1 Dana sešla z ochozu $24$ schodů.',
        'Dana sešla dalších $30$ schodů, celkem $24+30=54$ dolních schodů z ochozu, je tedy $96-54=42$ nižších schodů nad nádvořím. Výška 1. odpočívadla je $\\frac{42}{96}=\\frac{7}{16}$ celku, což na vyšším schodišti odpovídá $\\frac{7}{16}\\cdot 80=35$ schodům od nádvoří.',
        '5.2 Eva vyšla z nádvoří $35$ schodů.'],
     'ans': '5.1: $24$ schodů; 5.2: $35$ schodů', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2022 – úloha 6',
     'zad': [
        'Stejné činky jsou baleny po $6$ kusech do stejných krabic. V obchodě mají čtyři krabice s činkami: dvě jsou plné, dvě poloprázdné, a vše dohromady váží $47$ kg. V každé poloprázdné krabici zůstaly jen $3$ činky. Obě poloprázdné krabice s činkami váží celkem $16$ kg.',
        '6.1 Vypočtěte, kolik kilogramů váží jedna plná krabice s činkami.',
        '6.2 Vypočtěte, kolik kilogramů váží jedna činka.',
        '6.3 Vypočtěte, kolik kilogramů váží jedna prázdná krabice.'],
     'opts': None, 'ln': 3,
     'sol': [
        'Označme hmotnost prázdné krabice $k$ a hmotnost jedné činky $c$. Poloprázdná krabice váží $k+3c$, plná $k+6c$.',
        '6.1 Dvě poloprázdné: $2(k+3c)=16$, tj. $k+3c=8$. Všechny čtyři: $2(k+6c)+16=47$, tj. $2(k+6c)=31$, plná $k+6c=15{,}5$ kg.',
        '6.2 Z $k+6c=15{,}5$ a $k+3c=8$ plyne $3c=7{,}5$, tedy $c=2{,}5$ kg.',
        '6.3 $k=8-3\\cdot 2{,}5=0{,}5$ kg.'],
     'ans': '6.1: $15{,}5$ kg; 6.2: $2{,}5$ kg; 6.3: $0{,}5$ kg', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2022 – úloha 7',
     'zad': [
        'Obrazec se skládá z tmavého čtverce, dvou shodných bílých rovnoramenných trojúhelníků a dvou shodných bílých lichoběžníků. S každou stranou čtverce splývá základna jednoho bílého útvaru. Tmavý čtverec má stranu délky $12$ cm a jeho obsah je polovinou obsahu celého obrazce. Jeden trojúhelník má obsah $30$ cm$^2$. Délka kratší základny lichoběžníku je $9$ cm.',
        '7.1 Vypočtěte v cm výšku na základnu rovnoramenného trojúhelníku.',
        '7.2 Vypočtěte v cm výšku lichoběžníku.'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'obrazec.svg',
     'alt': 'Tmavý čtverec se čtyřmi bílými útvary na stranách: dvěma trojúhelníky a dvěma lichoběžníky (schematicky).',
     'cap': 'Složený obrazec',
     'sol': [
        'Obsah čtverce je $12^2=144$ cm$^2$, což je polovina obrazce, takže celý obrazec má $288$ cm$^2$ a bílé útvary dohromady $288-144=144$ cm$^2$.',
        '7.1 Základna trojúhelníku splývá se stranou čtverce, tj. $12$ cm. Z $30=\\frac{1}{2}\\cdot 12\\cdot v$ plyne $v=5$ cm.',
        '7.2 Dva trojúhelníky mají $60$ cm$^2$, dva lichoběžníky tedy $144-60=84$ cm$^2$, jeden $42$ cm$^2$. Delší základna lichoběžníku je $12$ cm, kratší $9$ cm. Z $42=\\frac{12+9}{2}\\cdot v$ plyne $v=4$ cm.'],
     'ans': '7.1: $5$ cm; 7.2: $4$ cm', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 8 (konstrukce)',
     'zad': [
        'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).',
        'Bod $A$ je vrchol rovnoběžníku $ABCD$, bod $S$ je střed tohoto rovnoběžníku. Na přímce $p$ leží vrchol $B$ rovnoběžníku $ABCD$. Úhel $ASB$ má velikost $120^\\circ$.',
        'Sestrojte vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'primka-A-S.svg',
     'alt': 'Přímka p procházející bodem A a bod S nad přímkou (výchozí obrázek ke konstrukci).',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': [
        'Bod $B$ leží na přímce $p$ a platí $|\\angle ASB|=120^\\circ$; sestrojíme jej pomocí úhlu $120^\\circ$ s vrcholem $S$ a ramenem $SA$ (druhé rameno protne přímku $p$ v bodě $B$).',
        'Protože $S$ je střed rovnoběžníku, je bod $C$ obrazem $A$ a bod $D$ obrazem $B$ ve středové souměrnosti se středem $S$ (tj. $S$ je střed úhlopříček $AC$ i $BD$). Doplněním vznikne rovnoběžník $ABCD$.'],
     'ans': 'Konstrukce rovnoběžníku $ABCD$: $B$ na přímce $p$ s $|\\angle ASB|=120^\\circ$, $C$ středovou souměrností bodu $A$ podle $S$, $D$ středovou souměrností bodu $B$ podle $S$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 9 (konstrukce)',
     'zad': [
        'V rovině leží body $C$, $Q$ a přímka $p$ (viz obrázek).',
        'Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Ramena mají délku $5$ cm. Na přímce $p$ leží jeden vrchol trojúhelníku $ABC$. Bodem $Q$ prochází osa souměrnosti trojúhelníku $ABC$.',
        'Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-C-Q.svg',
     'alt': 'Body C a Q a přímka p v rovině (výchozí obrázek ke konstrukci).',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': [
        'Ramena $|CA|=|CB|=5$ cm, takže $A$ i $B$ leží na kružnici se středem $C$ a poloměrem $5$ cm. Osa souměrnosti trojúhelníku prochází vrcholem $C$ i bodem $Q$, je to tedy přímka $CQ$; body $A$ a $B$ jsou souměrné podle přímky $CQ$.',
        'Jeden z vrcholů leží na přímce $p$: sestrojíme průsečíky kružnice s přímkou $p$ a jejich obrazy v osové souměrnosti podle $CQ$. Úloha má dvě řešení (trojúhelníky $A_1B_1C$ a $A_2B_2C$).'],
     'ans': 'Dvě řešení: $A$, $B$ na kružnici se středem $C$ a poloměrem $5$ cm, souměrné podle osy $CQ$, jeden vrchol na přímce $p$ (trojúhelníky $A_1B_1C$ a $A_2B_2C$ – viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 10',
     'zad': [
        'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary A, B, C. Každý z nich má pouze jednu osu souměrnosti. V každém útvaru přemístíme jediný tmavý čtverec tak, aby měl upravený útvar co nejvíce různých os souměrnosti (sestrojených svisle, vodorovně nebo šikmo).',
        'Rozhodněte o každém z následujících tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).',
        '10.1 Správně upravený útvar A má pouze $2$ osy souměrnosti.',
        '10.2 Správně upravený útvar B má pouze $2$ osy souměrnosti.',
        '10.3 Správně upravený útvar C má pouze $1$ osu souměrnosti.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'utvary-ABC.svg',
     'alt': 'Tři útvary A, B a C složené z tmavých čtverců ve čtvercové síti (schematicky).',
     'cap': 'Útvary A, B, C (schematicky)',
     'sol': [
        '10.1 Útvar A lze přemístěním jednoho čtverce upravit tak, aby měl právě $2$ osy souměrnosti. Tvrzení je pravdivé (Ano).',
        '10.2 Nejlépe upravený útvar B nemá právě $2$ osy souměrnosti. Tvrzení je nepravdivé (Ne).',
        '10.3 Nejlépe upravený útvar C nemá právě $1$ osu souměrnosti (má jich více). Tvrzení je nepravdivé (Ne).'],
     'ans': '10.1: Ano; 10.2: Ne; 10.3: Ne', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 11',
     'zad': [
        'Čtyřúhelník je rozdělen na dva tmavé rovnostranné trojúhelníky, jeden bílý čtyřúhelník a jeden bílý trojúhelník (viz obrázek). Vyznačené úhly mají velikost $41^\\circ$ a $36^\\circ$.',
        'Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) $105^\\circ$', 'B) $110^\\circ$', 'C) $115^\\circ$', 'D) $120^\\circ$', 'E) větší než $120^\\circ$'],
     'ln': 0, 'svg': SVG11, 'fn': 'ctyruhelnik-uhly.svg',
     'alt': 'Čtyřúhelník rozdělený na dva tmavé rovnostranné trojúhelníky, bílý čtyřúhelník a bílý trojúhelník; vyznačeny úhly 41 stupňů, 36 stupňů a hledaný úhel fí (schematicky).',
     'cap': 'Schematický nákres k úloze 11',
     'sol': [
        'Rovnostranné trojúhelníky mají všechny vnitřní úhly $60^\\circ$. Postupným dopočítáváním úhlů v jednotlivých trojúhelnících (součet vnitřních úhlů trojúhelníku je $180^\\circ$) a využitím přímých a vrcholových úhlů z daných hodnot $41^\\circ$ a $36^\\circ$ vyjde, že úhel $\\varphi$ je větší než $120^\\circ$.'],
     'ans': 'E) větší než $120^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 12',
     'zad': [
        'Podstavou trojbokého kolmého hranolu je pravoúhlý trojúhelník, jehož dvě delší strany měří $17$ cm a $15$ cm. Výška hranolu je $5$ cm. Obě podstavy hranolu jsou tmavé, ostatní stěny jsou bílé. Ze čtyř těchto trojbokých hranolů je slepeno těleso (viz obrázek), které má dvě shodné stěny tmavé a zbývající čtyři stěny bílé.',
        'Jaký obsah mají dohromady všechny bílé stěny slepeného tělesa?'],
     'opts': ['A) menší než $300$ cm$^2$', 'B) $300$ cm$^2$', 'C) $330$ cm$^2$', 'D) $470$ cm$^2$', 'E) větší než $470$ cm$^2$'],
     'ln': 0, 'svg': SVG12, 'fn': 'sleponove-teleso.svg',
     'alt': 'Těleso ve tvaru lichoběžníkového hranolu slepené ze čtyř trojbokých hranolů (schematicky).',
     'cap': 'Slepené těleso ze čtyř trojbokých hranolů',
     'sol': [
        'Třetí strana podstavy je $\\sqrt{17^2-15^2}=\\sqrt{289-225}=\\sqrt{64}=8$ cm (odvěsny $15$ cm a $8$ cm, přepona $17$ cm).',
        'Slepené těleso je hranol s podstavou rovnoramenného lichoběžníku (horní základna $15$ cm, dolní $45$ cm, ramena $17$ cm) a hloubkou $5$ cm. Bílé jsou čtyři obdélníkové stěny: dolní $45\\cdot 5=225$, horní $15\\cdot 5=75$ a dvě šikmé $17\\cdot 5=85$ každá. Celkem $225+75+2\\cdot 85=470$ cm$^2$.'],
     'ans': 'D) $470$ cm$^2$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2022 – úloha 13',
     'zad': [
        'Čtyři chlapci (Petr, Radek, Standa a Tomáš) sbírají kartičky s legendárními hokejisty. V grafu znázorňujícím počty jejich kartiček některé údaje chybí. Standa má o polovinu méně kartiček než Tomáš a oba dohromady mají $24$ kartiček. Petr má o $5$ kartiček více než Radek.',
        'O kolik se liší počet Petrových a Standových kartiček?'],
     'opts': ['A) o $1$ kartičku', 'B) o $8$ kartiček', 'C) o $10$ kartiček', 'D) o $17$ kartiček', 'E) o jiný počet kartiček'],
     'ln': 0, 'svg': SVG13, 'fn': 'graf-karticky.svg',
     'alt': 'Vodorovný sloupcový graf počtu kartiček čtyř chlapců; zobrazeny jsou sloupce Radka a Tomáše, sloupce Petra a Standy chybí.',
     'cap': 'Počet kartiček (Radek a Tomáš)',
     'sol': [
        'Standa má o polovinu méně než Tomáš, tj. $S=\\frac{T}{2}$, a $S+T=24$, odtud $T=16$ a $S=8$. Z grafu je Radek $R=20$. Petr má o $5$ více než Radek, tedy $P=25$. Rozdíl $P-S=25-8=17$.'],
     'ans': 'D) o $17$ kartiček', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2022 – úloha 14',
     'zad': [
        'Ve stánku mají celkem $140$ krabiček s čaji. Všechny jsou naskládány do sloupečků po čtyřech krabičkách. V $10$ sloupečcích jsou pouze krabičky s černými čaji a v každém ze zbývajících sloupečků je jedna krabička s černým čajem a $3$ krabičky s ovocnými čaji.',
        'Kolik krabiček s ovocnými čaji mají ve stánku?'],
     'opts': ['A) $30$ krabiček', 'B) $40$ krabiček', 'C) $75$ krabiček', 'D) $100$ krabiček', 'E) jiný počet krabiček'],
     'ln': 0,
     'sol': ['Sloupečků je $140:4=35$. Deset je pouze černých, zbývá $35-10=25$ sloupečků, v každém $3$ ovocné krabičky. Ovocných je $25\\cdot 3=75$.'],
     'ans': 'C) $75$ krabiček', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2022 – úloha 15',
     'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Do prosince roku 2020 prodělal covid-19 každý dvacátý Čech. Kolik procent Čechů prodělalo covid-19 do prosince roku 2020?',
        '15.2 Počet novorozenců tvořil v dubnu $\\frac{26}{25}$ počtu novorozenců v březnu. O kolik procent byl počet novorozenců v dubnu vyšší než v březnu?',
        '15.3 Teplá kapalina v nádobě po vychladnutí zmenšila svůj objem o $\\frac{2}{27}$. O kolik procent byl objem teplé kapaliny větší než objem vychladlé kapaliny?'],
     'opts': ['A) $4\\,\\%$', 'B) $5\\,\\%$', 'C) $6\\,\\%$', 'D) $7\\,\\%$', 'E) $8\\,\\%$', 'F) jiný počet procent'],
     'ln': 0,
     'sol': [
        '15.1 Každý dvacátý je $\\frac{1}{20}=5\\,\\%$ → B.',
        '15.2 $\\frac{26}{25}=1{,}04=104\\,\\%$, tj. o $4\\,\\%$ více → A.',
        '15.3 Vychladlá kapalina je $1-\\frac{2}{27}=\\frac{25}{27}$ objemu teplé. Poměr teplá ku vychladlé je $\\frac{27}{25}=1{,}08=108\\,\\%$, tj. o $8\\,\\%$ více → E.'],
     'ans': '15.1: B ($5\\,\\%$); 15.2: A ($4\\,\\%$); 15.3: E ($8\\,\\%$)', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2022 – úloha 16',
     'zad': [
        'Řada je vytvořena z celých čísel. První trojice čísel je $0, 1, 2$. Každou další trojici vytvoříme tak, že jednotlivá čísla z předchozí trojice zvětšíme o $1$. Prvních $18$ čísel řady je: $0, 1, 2,\\ 1, 2, 3,\\ 2, 3, 4,\\ 3, 4, 5,\\ 4, 5, 6,\\ 5, 6, 7,\\ \\ldots$',
        '16.1 Určete, na kolikátém místě řady je poprvé číslo $12$.',
        '16.2 Určete, na kolika místech řady je mezi prvními $125$ čísly uvedeno liché číslo.',
        '16.3 Určete, které číslo je na $152.$ místě řady.'],
     'opts': None, 'ln': 3,
     'sol': [
        '$n$-tá trojice zaujímá místa $3n-2$, $3n-1$, $3n$ a obsahuje čísla $n-1$, $n$, $n+1$.',
        '16.1 Číslo $12$ se poprvé objeví jako třetí člen trojice $n=11$ (trojice $10, 11, 12$) na místě $3\\cdot 11=33$.',
        '16.2 Prvních $125$ míst = $41$ úplných trojic (místa $1$ až $123$) plus místa $124$ a $125$. Trojice s lichým $n$ má $1$ liché číslo, se sudým $n$ má $2$ lichá čísla. Mezi trojicemi $1$ až $41$ je $21$ s lichým $n$ (celkem $21$) a $20$ se sudým $n$ (celkem $40$), tj. $61$. Na místech $124$, $125$ jsou čísla $41$ (liché) a $42$ (sudé), tj. $+1$. Celkem $62$.',
        '16.3 $152=3\\cdot 50+2$, jde o druhý (prostřední) člen trojice $n=51$ (trojice $50, 51, 52$), tedy číslo $51$.'],
     'ans': '16.1: na $33.$ místě; 16.2: na $62$ místech; 16.3: $51$', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PDD22C0T04'
    gen.YEAR = 2022

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7D-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
