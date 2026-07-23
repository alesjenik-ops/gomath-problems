# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2025, MATEMATIKA 5D, 2. nahradni termin.
# Kod testu: M5PDD25C0T04. 14 uloh (po rozdeleni izolovanych podulohu 17 uloh).
# Zdroj odpovedi: rozsireny klic spravnych reseni (KSR) 2025.

# ---- SVG obrazky (bez ' a \) ----

# uloha 4: vychozi tabulka (pocet soutezicich; nektere udaje)
SVG4 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 150" font-family="sans-serif" font-size="12">
<rect x="10" y="10" width="500" height="130" fill="none" stroke="#000"/>
<line x1="110" y1="10" x2="110" y2="140" stroke="#000"/>
<line x1="350" y1="10" x2="350" y2="140" stroke="#000"/>
<line x1="190" y1="45" x2="190" y2="140" stroke="#000"/>
<line x1="270" y1="45" x2="270" y2="140" stroke="#000"/>
<line x1="110" y1="45" x2="350" y2="45" stroke="#000"/>
<line x1="10" y1="70" x2="510" y2="70" stroke="#000"/>
<line x1="10" y1="105" x2="510" y2="105" stroke="#000"/>
<text x="230" y="32" font-size="11" text-anchor="middle">Pocet soutezicich, kteri ziskali</text>
<text x="430" y="34" text-anchor="middle">Soucet bodu</text>
<text x="430" y="52" text-anchor="middle">celeho tymu</text>
<text x="150" y="62" text-anchor="middle">8 bodu</text>
<text x="230" y="62" text-anchor="middle">9 bodu</text>
<text x="310" y="62" text-anchor="middle">10 bodu</text>
<text x="20" y="92">1. kolo</text>
<text x="230" y="92" text-anchor="middle">5</text>
<text x="20" y="127">2. kolo</text>
<text x="430" y="127" text-anchor="middle">95</text>
</svg>"""

# uloha 6: obrazec A (4 bile obdelnicky + 4 sede ctverecky) a obrazec B (osmiuhelnik) - schematicky
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 170" font-family="sans-serif" font-size="12">
<text x="70" y="24" text-anchor="middle">Obrazec A</text>
<text x="270" y="24" text-anchor="middle">Obrazec B</text>
<rect x="20" y="34" width="52" height="26" fill="#ffffff" stroke="#000"/>
<rect x="72" y="34" width="52" height="26" fill="#ffffff" stroke="#000"/>
<rect x="20" y="60" width="26" height="26" fill="#bbbbbb" stroke="#000"/>
<rect x="46" y="60" width="26" height="26" fill="#bbbbbb" stroke="#000"/>
<rect x="72" y="60" width="52" height="26" fill="#ffffff" stroke="#000"/>
<rect x="20" y="86" width="52" height="26" fill="#ffffff" stroke="#000"/>
<rect x="72" y="86" width="26" height="26" fill="#bbbbbb" stroke="#000"/>
<rect x="98" y="86" width="26" height="26" fill="#bbbbbb" stroke="#000"/>
<rect x="20" y="34" width="104" height="78" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="200,112 200,60 252,60 252,34 330,34 330,86 278,86 278,112" fill="none" stroke="#000" stroke-width="2"/>
<rect x="200" y="60" width="26" height="26" fill="#bbbbbb" stroke="#000"/>
<rect x="252" y="34" width="26" height="26" fill="#bbbbbb" stroke="#000"/>
</svg>"""

# uloha 7.1: body K, M (vychozi obrazek)
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 240" font-family="sans-serif">
<rect x="10" y="10" width="440" height="220" fill="none" stroke="#cccccc"/>
<text x="232" y="98" font-size="15" font-style="italic">M</text>
<text x="230" y="112" font-size="15">x</text>
<text x="292" y="176" font-size="15" font-style="italic">K</text>
<text x="278" y="172" font-size="15">x</text>
</svg>"""

# uloha 7.2: bod A a primka p prochazejici bodem R
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 240" font-family="sans-serif">
<rect x="10" y="10" width="440" height="220" fill="none" stroke="#cccccc"/>
<line x1="40" y1="196" x2="420" y2="150" stroke="#000" stroke-width="2"/>
<text x="426" y="150" font-size="15" font-style="italic">p</text>
<line x1="250" y1="164" x2="250" y2="178" stroke="#000" stroke-width="1"/>
<text x="244" y="196" font-size="15" font-style="italic">R</text>
<text x="228" y="118" font-size="15" font-style="italic">A</text>
<text x="226" y="132" font-size="15">x</text>
</svg>"""

# ulohy 11-12: sloupcovy graf (zaokrouhlene castky Leden-Duben)
def _graf():
    x0, y0 = 70, 300
    sc = 0.30
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif" font-size="11">']
    s.append(f'<line x1="{x0}" y1="20" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="480" y2="{y0}" stroke="#000"/>')
    for v in range(0, 801, 100):
        y = y0 - v*sc
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" text-anchor="end">{v}</text>')
    data = [('Leden', 400), ('Unor', 600), ('Brezen', 700), ('Duben', 700)]
    bw = 50; gap = 40; x = x0 + gap
    for name, val in data:
        h = val*sc
        s.append(f'<rect x="{x}" y="{y0-h}" width="{bw}" height="{h}" fill="#666666" stroke="#000"/>')
        s.append(f'<text x="{x+bw/2}" y="{y0+16}" text-anchor="middle">{name}</text>')
        x += bw + gap
    s.append('<text x="24" y="160" font-size="11" text-anchor="middle" transform="rotate(-90 24 160)">Zaokrouhlena castka v korunach</text>')
    s.append('</svg>')
    return "".join(s)
SVG_GRAF = _graf()

# uloha 13: stavby z krychlovych kostek - schematicka poznamka
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 120" font-family="sans-serif">
<text x="260" y="46" font-size="13" text-anchor="middle">Stavby z krychlovych kostek: pyramida, Jitcina a Emilova stavba (viz testovy sesit).</text>
<text x="260" y="72" font-size="11" text-anchor="middle" fill="#666666">Prostorove stavby nelze verne prenest do SVG; posuzuje se podle originalu.</text>
</svg>"""

# uloha 14: hriste KLMN se stanovisti A, B, C, D a sedym ctvercem
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif" font-size="13">
<rect x="256" y="30" width="144" height="144" fill="#cccccc" stroke="none"/>
<rect x="40" y="30" width="360" height="240" fill="none" stroke="#000" stroke-width="2"/>
<line x1="256" y1="30" x2="256" y2="270" stroke="#000" stroke-dasharray="4 4"/>
<line x1="40" y1="174" x2="400" y2="174" stroke="#000" stroke-dasharray="4 4"/>
<text x="30" y="28" font-style="italic">K</text>
<text x="404" y="28" font-style="italic">N</text>
<text x="30" y="284" font-style="italic">L</text>
<text x="404" y="284" font-style="italic">M</text>
<circle cx="256" cy="30" r="3" fill="#000"/><text x="248" y="24" font-style="italic">A</text>
<circle cx="40" cy="174" r="3" fill="#000"/><text x="26" y="170" font-style="italic">B</text>
<circle cx="256" cy="270" r="3" fill="#000"/><text x="250" y="288" font-style="italic">C</text>
<circle cx="400" cy="174" r="3" fill="#000"/><text x="406" y="172" font-style="italic">D</text>
</svg>"""

B = ['zs1']  # 5. rocnik ZS (prijimacky na osmilete); kod r5 v taxonomii neni

PROBLEMS = [
    {'name': 'CERMAT M5D 2025 - uloha 1', 'zad': [
        'Plavec uplave v bazenu rovnomernym tempem $2$ kilometry za $48$ minut.',
        'Vypoctete, za kolik minut uplave plavec timto tempem celkem $5$ padesatimetrovych bazenu.'],
     'opts': None, 'ln': 2,
     'sol': ['Tempo: $2$ km $=2000$ m za $48$ min. Pet bazenu $=5\\cdot 50=250$ m. Cas $=48\\cdot\\frac{250}{2000}=48\\cdot\\frac{1}{8}=6$ min.'],
     'ans': '$6$ minut', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2025 - uloha 2.1', 'zad': ['Vypoctete: $(510:34)-(8+56:8)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$510:34=15$; $8+56:8=8+7=15$; $15-15=0$.'],
     'ans': '$0$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2025 - uloha 2.2', 'zad': ['Vypoctete: $10\\cdot 100-(100-6\\cdot 14):2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$10\\cdot 100=1000$; $100-6\\cdot 14=100-84=16$; $16:2=8$; $1000-8=992$.'],
     'ans': '$992$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2025 - uloha 2.3', 'zad': ['Vypoctete: $72:4+8-10:1+1=$'],
     'opts': None, 'ln': 2,
     'sol': ['$72:4=18$; $10:1=10$; $18+8-10+1=17$.'],
     'ans': '$17$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2025 - uloha 3', 'zad': [
        'Martin ma jednobarevne kulicky. Jedna tretina vsech Martinovych kulicek je zlutych, $12$ kulicek je cervenych a zbyvajici kulicky jsou modre. Modrych kulicek ma Martin o polovinu vice nez cervenych.',
        '3.1 Urcete pocet vsech Martinovych kulicek.',
        '3.2 Martin da kamaradce tolik cervenych kulicek, aby polovinu jeho zbylych kulicek tvorily modre kulicky. Urcete, kolik cervenych kulicek da Martin kamaradce.'],
     'opts': None, 'ln': 2,
     'sol': ['3.1 Modrych je $12\\cdot\\frac{3}{2}=18$. Zlute tvori tretinu, takze cervene a modre dohromady tvori dve tretiny: $12+18=30$ je $\\frac{2}{3}$ vsech, tedy vsech je $30:\\frac{2}{3}=45$ kulicek.',
            '3.2 Modrych je $18$. Aby modre tvorily polovinu zbylych kulicek, musi zbyt $2\\cdot 18=36$ kulicek. Martin proto rozda $45-36=9$ cervenych kulicek.'],
     'ans': '3.1: $45$ kulicek; 3.2: $9$ cervenych kulicek', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2025 - uloha 4', 'zad': [
        'Vedomostni souteze, ktera mela dve kola, se zucastnil deseticlenny tym. V kazdem kole ziskali jednotlivi soutezici $8$, $9$, nebo $10$ bodu. Nektere udaje jsou v tabulce (v 1. kole ziskalo $9$ bodu $5$ soutezicich; soucet bodu celeho tymu ve 2. kole je $95$).',
        '4.1 V 1. kole bylo soutezicich, kteri ziskali $8$ bodu, o jednoho mene nez tech, kteri ziskali $10$ bodu. Urcete soucet bodu celeho tymu v 1. kole.',
        '4.2 Urcete, kolik soutezicich mohlo ve 2. kole ziskat $9$ bodu. Najdete vsechna reseni.'],
     'opts': None, 'ln': 3, 'svg': SVG4, 'fn': 'tabulka-souteze.svg',
     'alt': 'Tabulka poctu soutezicich se ziskem 8, 9 a 10 bodu ve dvou kolech; v 1. kole 9 bodu ziskalo 5 soutezicich, soucet ve 2. kole je 95.',
     'cap': 'Vychozi tabulka k uloze 4',
     'sol': ['4.1 V 1. kole $9$ bodu ziskalo $5$ soutezicich, zbyva $5$ soutezicich se ziskem $8$ nebo $10$ bodu. Oznacime pocet desitkovych $c$ a osmickovych $c-1$: $(c-1)+c=5$, tedy $c=3$ a osmicek $2$. Soucet $=2\\cdot 8+5\\cdot 9+3\\cdot 10=16+45+30=91$ bodu.',
            '4.2 Ve 2. kole plati $x+y+z=10$ a $8x+9y+10z=95$, kde $y$ je pocet devitkovych. Odtud $y+2z=15$ a $x=z-5$, takze $z\\in\\{5,6,7\\}$ a $y\\in\\{5,3,1\\}$. Devitkovych mohlo byt $1$, $3$, nebo $5$ soutezicich.'],
     'ans': '4.1: $91$ bodu; 4.2: $1$ soutezici, $3$ soutezici, nebo $5$ soutezicich', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2025 - uloha 5', 'zad': [
        'Na odvoz beden ze skladu se pouzivaji dva ruzni roboti $A$, $B$. Ve skladu bylo $140$ beden. Bedny nejprve odvazel robot $A$, a to po $5$ kusech; jezdil v pravidelnych intervalech a odvezl ze skladu za $2$ hodiny celkem $50$ beden. Pak pokracoval robot $B$, ktery vozil bedny jen po $3$ kusech, avsak v kratsich pravidelnych intervalech; odvezl tak ze skladu za $3$ hodiny zbyvajicich $90$ beden.',
        '5.1 Vypoctete, o kolik kusu se lisi pocet beden odvezenych ze skladu za $1$ hodinu robotem $A$ a pocet beden odvezenych za $1$ hodinu robotem $B$.',
        '5.2 Vypoctete, kolikrat mene jizd vykona za $1$ hodinu robot $A$ nez robot $B$.',
        '5.3 Vypoctete, kolik beden by ze skladu odvezli za $36$ minut oba roboti dohromady pri spolecnem provozu.'],
     'opts': None, 'ln': 3,
     'sol': ['Robot $A$: $50$ beden za $2$ h, tj. $25$ beden/h a $25:5=5$ jizd/h. Robot $B$: $90$ beden za $3$ h, tj. $30$ beden/h a $30:3=10$ jizd/h.',
            '5.1 Rozdil beden za hodinu: $30-25=5$ kusu.',
            '5.2 Jizd za hodinu: $A$ pet, $B$ deset, tedy $A$ jezdi $2$krat mene.',
            '5.3 Dohromady $25+30=55$ beden/h; za $36$ min $=\\frac{36}{60}$ h odvezou $55\\cdot\\frac{36}{60}=33$ beden.'],
     'ans': '5.1: o $5$ kusu; 5.2: $2$krat; 5.3: $33$ beden', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2025 - uloha 6', 'zad': [
        'Na obrazku jsou obrazce $A$, $B$. Obrazec $A$ je obdelnik slozeny ze $4$ stejnych bilych obdelnicku a $4$ stejnych sedych ctvercku. Obvod bile casti obrazce $A$ je o $32$ cm vetsi nez obvod sede casti. Obrazec $B$ je osmiuhelnik, ktery vznikl preskladanim jednotlivych dilu obrazce $A$.',
        '6.1 Urcete, kolik cm meri obvod obrazce $A$.',
        '6.2 Urcete, o kolik cm se lisi obvody obrazcu $A$, $B$.'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'obrazce-AB.svg',
     'alt': 'Obrazec A - obdelnik slozeny ze ctyr bilych obdelnicku a ctyr sedych ctvercku; obrazec B - osmiuhelnik vznikly preskladanim (schematicky).',
     'cap': 'Schematicky nakres obrazcu A a B',
     'sol': ['6.1 Bily obdelnicek ma rozmer $a\\times 2a$, kde $a$ je strana sedeho ctvercku. Soucet obvodu ctyr bilych dilu je $4\\cdot 2(a+2a)=24a$, soucet obvodu ctyr sedych ctvercku $4\\cdot 4a=16a$. Rozdil $24a-16a=8a=32$, tedy $a=4$ cm. Obrazec $A$ je obdelnik $12\\times 16$ cm a jeho obvod je $2\\cdot(12+16)=56$ cm.',
            '6.2 Preskladanim dilu vznikne osmiuhelnik, jehoz obvod se od obvodu obrazce $A$ (tj. od $56$ cm) lisi o $8$ cm.'],
     'ans': '6.1: $56$ cm; 6.2: o $8$ cm', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2025 - uloha 7.1 (konstrukce)', 'zad': [
        'V rovine lezi body $K$, $M$ (viz obrazek).',
        'Body $K$, $M$ jsou vrcholy trojuhelniku $KLM$. Stred strany $LM$ tohoto trojuhelniku je bod $S$. Pritom trojuhelnik $KMS$ je rovnostranny.',
        'Sestrojte bod $S$ a vrchol $L$ trojuhelniku $KLM$, oznacte je pismeny a trojuhelnik $KLM$ narysujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG7_1, 'fn': 'body-KM.svg',
     'alt': 'Dva body K a M v rovine.', 'cap': 'Vychozi obrazek k uloze 7.1',
     'sol': ['Trojuhelnik $KMS$ je rovnostranny, proto $|MS|=|KM|$ a bod $S$ lezi v pruseciku dvou kruznic o polomeru $|KM|$ se stredy $K$ a $M$ (dve polohy $S_1$, $S_2$). Bod $S$ je stred strany $LM$, takze vrchol $L$ dostaneme prodlouzenim usecky $MS$ za bod $S$ tak, ze $|SL|=|MS|$. Uloha ma dve reseni.'],
     'ans': 'Dve reseni: bod $S$ jako vrchol rovnostranneho trojuhelniku $KMS$ (polohy $S_1$, $S_2$), vrchol $L$ soumerny s $M$ podle $S$ - viz obrazek v klici.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2025 - uloha 7.2 (konstrukce)', 'zad': [
        'V rovine lezi bod $A$ a primka $p$ prochazejici bodem $R$ (viz obrazek).',
        'Bod $A$ je vrchol ctverce $ABCD$. Na primce $p$ lezi vrchol $B$ tohoto ctverce. Bod $R$ ma od obou vrcholu $A$ i $B$ stejnou vzdalenost. Bod $R$ nelezi uvnitr ctverce $ABCD$.',
        'Sestrojte vrcholy $B$, $C$, $D$ ctverce $ABCD$, oznacte je pismeny a ctverec narysujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG7_2, 'fn': 'bod-A-primka-p.svg',
     'alt': 'Bod A a primka p prochazejici vyznacenym bodem R.', 'cap': 'Vychozi obrazek k uloze 7.2',
     'sol': ['Bod $R$ ma od $A$ i $B$ stejnou vzdalenost, lezi tedy na ose usecky $AB$. Protoze $R$ i vrchol $B$ lezi na primce $p$ a plati $|RB|=|RA|$, najdeme vrchol $B$ na primce $p$ ve vzdalenosti $|RA|$ od bodu $R$ (dve polohy $B_1$, $B_2$). Nad usečkou $AB$ sestrojime ctverec $ABCD$ tak, aby bod $R$ nelezel uvnitr. Uloha ma dve reseni.'],
     'ans': 'Dve reseni: vrchol $B$ na primce $p$ ve vzdalenosti $|RA|$ od $R$ (polohy $B_1$, $B_2$), ctverec $ABCD$ doplneny na opacnou stranu nez bod $R$ - viz obrazek v klici.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2025 - uloha 8', 'zad': [
        'Honza mel $22$ sirek o delce $4$ cm a $18$ sirek o delce $5$ cm. Ze vsech techto sirek poskladal obrazce tvaru ctverce a obrazce tvaru obdelniku. Stranu obrazce tvorila vzdy jedina sirka a zadne dva obrazce nemely spolecnou stranu.',
        'Rozhodnete o kazdem z nasledujicich tvrzeni 8.1-8.3, zda je pravdive (A), ci nikoli (N).',
        '8.1 Honza mohl vytvorit nejvyse $9$ ctvercu.',
        '8.2 Honza mohl vytvorit stejny pocet ctvercu a obdelniku.',
        '8.3 Honza mohl vytvorit obrazce tak, ze prave jeden z nich byl ctverec a vsechny ostatni byly obdelniky.'],
     'opts': None, 'ln': 0,
     'sol': ['8.1 Ctverec tvori $4$ stejne sirky. Ze $22$ ctyrcentimetrovych lze slozit nejvyse $5$ ctvercu, z $18$ peticentimetrovych nejvyse $4$ ctverce, celkem nejvyse $9$. Pravda (A).',
            '8.2 Obdelnik (nectvercovy) tvori $2$ ctyrcentimetrove a $2$ peticentimetrove sirky. Volba $3$ ctvercu ze $4$cm, $2$ ctvercu z $5$cm a $5$ obdelniku dava $5$ ctvercu a $5$ obdelniku a spotrebuje $12+10=22$ ctyrcentimetrovych a $8+10=18$ peticentimetrovych sirek. Pravda (A).',
            '8.3 Jeden ctverec ze $4$ ctyrcentimetrovych sirek a $9$ obdelniku (kazdy $2$ ctyrcentimetrove a $2$ peticentimetrove) spotrebuje $4+18=22$ ctyrcentimetrovych a $18$ peticentimetrovych sirek. Pravda (A).'],
     'ans': '8.1: Ano; 8.2: Ano; 8.3: Ano', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2025 - uloha 9', 'zad': [
        'V obchode prodavaji ve $2$ ruznych sadach figurky dvou druhu dinosauru, T-rex a Velociraptor. Velka sada stoji $180$ korun a obsahuje $8$ figurek druhu T-rex a $5$ figurek druhu Velociraptor. Mala sada stoji $54$ korun a obsahuje $2$ figurky druhu T-rex a $2$ figurky druhu Velociraptor. Standa koupil $2$ velke sady a nekolik malych sad. Celkem tak ziskal $70$ novych figurek dinosauru.',
        'Kolik korun utratil Standa za nakup figurek dinosauru?'],
     'opts': ['A) $900$ korun', 'B) $954$ korun', 'C) $988$ korun', 'D) $1008$ korun', 'E) jinou castku'],
     'ln': 0,
     'sol': ['Velka sada ma $8+5=13$ figurek, dve velke sady tedy $26$ figurek. Zbyva $70-26=44$ figurek z malych sad po $4$ figurkach, tj. $11$ malych sad. Cena $2\\cdot 180+11\\cdot 54=360+594=954$ korun.'],
     'ans': 'B) $954$ korun', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2025 - uloha 10', 'zad': [
        'Ve stanici Licha Lhota stoji na kazde ze tri koleji jeden vlak. Vlak na druhe koleji ma o $3$ vagony vice nez vlak na prvni koleji a dvakrat mene vagonu nez vlak na treti koleji. Vsechny tri vlaky dohromady maji $41$ vagonu.',
        'O kolik vagonu vice ma vlak na treti koleji nez vlak na prvni koleji?'],
     'opts': ['A) o $8$ vagonu', 'B) o $10$ vagonu', 'C) o $11$ vagonu', 'D) o $13$ vagonu', 'E) o $14$ vagonu'],
     'ln': 0,
     'sol': ['Pocet vagonu na prvni koleji oznacime $x$. Druha kolej $x+3$, treti kolej $2(x+3)$. Soucet $x+(x+3)+2(x+3)=4x+9=41$, tedy $x=8$. Vlaky maji $8$, $11$ a $22$ vagonu; treti ma o $22-8=14$ vagonu vice.'],
     'ans': 'E) o $14$ vagonu', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2025 - uloha 11', 'zad': [
        'Lucka si ukladala do kasicky jen desetikoruny. Na konci kazdeho mesice vsechny penize v kasicce spocitala, celou castku zaokrouhlila na stovky korun a zaznamenala do grafu. Nasledujici graf zobrazuje tyto zaokrouhlene castky v prvnich ctyrech mesicich roku. V tomto obdobi Lucka penize pouze ukladala, z kasicky nic nevybirala.',
        'Jakou nejvyssi castku mohla mit Lucka v kasicce na konci brezna?'],
     'opts': ['A) $650$ korun', 'B) $690$ korun', 'C) $740$ korun', 'D) $750$ korun', 'E) jinou castku'],
     'ln': 0, 'svg': SVG_GRAF, 'fn': 'graf-lucka.svg',
     'alt': 'Sloupcovy graf zaokrouhlenych castek: leden 400, unor 600, brezen 700, duben 700 korun.',
     'cap': 'Zaokrouhlene castky v kasicce (leden az duben)',
     'sol': ['Na konci brezna je zaokrouhlena castka $700$ korun, skutecna castka tedy lezi v rozmezi od $650$ do $749$ korun. Protoze Lucka uklada pouze desetikoruny, je nejvyssi mozna castka $740$ korun (castka $750$ by se zaokrouhlila na $800$).'],
     'ans': 'C) $740$ korun', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['statistika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2025 - uloha 12', 'zad': [
        'Lucka si ukladala do kasicky jen desetikoruny; na konci kazdeho mesice castku zaokrouhlila na stovky korun a zaznamenala do grafu (leden $400$, unor $600$, brezen $700$, duben $700$ korun). V tomto obdobi penize pouze ukladala, z kasicky nic nevybirala.',
        'Ktere z nasledujicich tvrzeni neni pravdive?'],
     'opts': ['A) Na konci ledna mela Lucka v kasicce mene nez $450$ korun.',
              'B) Behem unora ulozila Lucka do kasicky vice nez $100$ korun.',
              'C) V breznu ulozila Lucka do kasicky alespon jednu desetikorunu.',
              'D) Behem dubna se castka v Lucine kasicce mohla zvysit o $100$ korun.',
              'E) Na konci dubna mohla mit Lucka v kasicce jinou castku nez na konci brezna.'],
     'ln': 0, 'svg': SVG_GRAF, 'fn': 'graf-lucka.svg',
     'alt': 'Sloupcovy graf zaokrouhlenych castek: leden 400, unor 600, brezen 700, duben 700 korun.',
     'cap': 'Zaokrouhlene castky v kasicce (leden az duben)',
     'sol': ['Skutecne castky (nasobky deseti): leden $350$ az $449$, unor $550$ az $649$, brezen i duben $650$ az $749$ korun. Tvrzeni A, B, C i E mohou nastat. Behem dubna je vsak rozdil skutecnych castek nejvyse $740-650=90$ korun, takze se castka nemohla zvysit o $100$ korun - tvrzeni D neni pravdive.'],
     'ans': 'D) Behem dubna se castka v Lucine kasicce mohla zvysit o $100$ korun.', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2025 - uloha 13', 'zad': [
        'Vsechny kostky ve stavebnici jsou stejne a maji tvar krychle. Ze vsech kostek stavebnice byla na podlozce postavena pyramida (obrazek vlevo). Jitka pyramidu zbourala a ze vsech kostek postavila stavbu naznacenou na obrazku uprostred. Nakonec Emil zboural i Jitcinu stavbu a ze vsech kostek postavil pravidelnou stavbu, jejiz ctyri horni patra jsou na obrazku vpravo. Zadna stavba nemela mezi kostkami mezery.',
        'Priradte ke kazde uloze (13.1-13.3) odpovidajici vysledek (A-F).',
        '13.1 Kolik kostek uvnitr pyramidy nebylo videt z zadne strany?',
        '13.2 Kolik kostek v Jitcine stavbe se dotykalo podlozky?',
        '13.3 Kolik kostek dohromady obsahuji spodni dve patra Emilovy stavby?'],
     'opts': ['A) mene nez $15$ kostek', 'B) $15$ kostek', 'C) $18$ kostek', 'D) $21$ kostek', 'E) $26$ kostek', 'F) vice nez $26$ kostek'],
     'ln': 0, 'svg': SVG13, 'fn': 'stavby-kostky.svg',
     'alt': 'Pyramida a dalsi dve stavby z krychlovych kostek (schematicka poznamka).',
     'cap': 'Prostorove stavby - viz testovy sesit',
     'sol': ['Podle nacrtu v testovem sesitu: 13.1 uvnitr pyramidy nebylo videt mene nez $15$ kostek (A); 13.2 podlozky se v Jitcine stavbe dotykalo vice nez $26$ kostek (F); 13.3 spodni dve patra Emilovy pravidelne stavby obsahuji dohromady $26$ kostek (E).'],
     'ans': '13.1: A (mene nez $15$ kostek); 13.2: F (vice nez $26$ kostek); 13.3: E ($26$ kostek)', 'pts': 6, 'mins': 8, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2025 - uloha 14', 'zad': [
        'Hriste ma tvar obdelniku $KLMN$. Po jeho obvodu vede soutezni trasa se stanovisti $A$, $B$, $C$, $D$ (viz obrazek). Usecky $AC$ a $BD$ jsou rovnobezne se stranami hriste a vyznaceny sedy obrazec je ctverec. Usek $AKB$ soutezni trasy (ze stanoviste $A$ pres vrchol $K$ na stanoviste $B$) meri $45$ m, usek $BLC$ meri $39$ m a posledni usek $CMD$ meri $30$ m.',
        'Vypoctete v metrech:',
        '14.1 rozdil mezi delkami usecek $BK$ a $BL$,',
        '14.2 delku kratsi strany hriste,',
        '14.3 obvod hriste,',
        '14.4 vzdalenost stanoviste $D$ od vrcholu $N$.'],
     'opts': None, 'ln': 0, 'svg': SVG14, 'fn': 'hriste-KLMN.svg',
     'alt': 'Obdelnikove hriste KLMN se stanovisti A, B, C, D na stranach; usecky AC a BD, vpravo nahore sedy ctverec.',
     'cap': 'Hriste KLMN se soutezni trasou',
     'sol': ['Ze zadani plati $AK+KB=45$, $BL+LC=39$ a $CM+MD=30$; sedy obrazec je ctverec, proto $NA=ND$ (strana ctverce $s$). Vyjadrenim vyjde $s=18$ m, dale $AK=27$ m, $KB=18$ m, $BL=12$ m, $LC=27$ m, $CM=18$ m, $MD=12$ m.',
            '14.1 $BK-BL=18-12=6$ m.',
            '14.2 Kratsi strana hriste $KL=KB+BL=18+12=30$ m.',
            '14.3 Delsi strana $KN=AK+NA=27+18=45$ m; obvod $=2\\cdot(30+45)=150$ m.',
            '14.4 Vzdalenost $D$ od vrcholu $N$ je rovna strane ctverce, tedy $18$ m.'],
     'ans': '14.1: $6$ m; 14.2: $30$ m; 14.3: $150$ m; 14.4: $18$ m', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PDD25C0T04'
    gen.YEAR = 2025

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP nazev: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Neparovy $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakazany znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrazek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'uloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5D-2025')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
