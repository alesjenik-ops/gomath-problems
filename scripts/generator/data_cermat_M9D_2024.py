# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2024, MATEMATIKA 9D (ctyrlete obory, 9. rocnik), 1. termin.
# Kod testu: M9PDD24C0T04. 16 uloh, 50 bodu (po rozdeleni nezavislych poduloh 20 uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR) MATEMATIKA 9D 2024.

# ---- SVG obrazky (bez ' a \) ----

# uloha 7: tabulka poctu obedu A/B/C u tri skupin + celkova cena
def _table7():
    segs_v = [(20,15,140),(150,15,140),(205,40,140),(260,40,140),(315,15,140),(470,15,140)]
    segs_h = [(15,20,470),(40,150,315),(65,20,470),(90,20,470),(115,20,470),(140,20,470)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 490 155" font-family="sans-serif">']
    for x,y1,y2 in segs_v:
        s.append(f'<line x1="{x}" y1="{y1}" x2="{x}" y2="{y2}" stroke="#000" stroke-width="1"/>')
    for y,x1,x2 in segs_h:
        s.append(f'<line x1="{x1}" y1="{y}" x2="{x2}" y2="{y}" stroke="#000" stroke-width="1"/>')
    s.append('<text x="232" y="32" font-size="12" text-anchor="middle">Pocet obedu</text>')
    s.append('<text x="392" y="30" font-size="12" text-anchor="middle">Celkova cena</text>')
    s.append('<text x="392" y="56" font-size="12" text-anchor="middle">za obedy</text>')
    for x,t in ((177,'A'),(232,'B'),(287,'C')):
        s.append(f'<text x="{x}" y="58" font-size="12" text-anchor="middle">{t}</text>')
    rows = [('skupina 1','20','0','0','4 000 Kc'),('skupina 2','10','10','0','4 800 Kc'),('skupina 3','5','5','10','5 400 Kc')]
    yy = [82,107,132]
    for i,(lab,a,b,cc,cena) in enumerate(rows):
        y = yy[i]
        s.append(f'<text x="85" y="{y}" font-size="12" text-anchor="middle">{lab}</text>')
        s.append(f'<text x="177" y="{y}" font-size="12" text-anchor="middle">{a}</text>')
        s.append(f'<text x="232" y="{y}" font-size="12" text-anchor="middle">{b}</text>')
        s.append(f'<text x="287" y="{y}" font-size="12" text-anchor="middle">{cc}</text>')
        s.append(f'<text x="392" y="{y}" font-size="12" text-anchor="middle">{cena}</text>')
    s.append('</svg>')
    return "".join(s)
SVG7 = _table7()

# uloha 8: dva kolacove grafy (denni cinnosti 24 h; rozlozeni volneho casu)
def _pies():
    import math
    def pie(cx, cy, r, slices):
        out = []
        ang = -90.0
        for pct, color, label in slices:
            sweep = pct/100.0*360.0
            a0 = math.radians(ang); a1 = math.radians(ang+sweep)
            x0 = cx + r*math.cos(a0); y0 = cy + r*math.sin(a0)
            x1 = cx + r*math.cos(a1); y1 = cy + r*math.sin(a1)
            large = 1 if sweep > 180 else 0
            out.append(f'<path d="M{cx},{cy} L{x0:.1f},{y0:.1f} A{r},{r} 0 {large},1 {x1:.1f},{y1:.1f} Z" fill="{color}" stroke="#000" stroke-width="1"/>')
            am = math.radians(ang+sweep/2)
            lx = cx + r*0.62*math.cos(am); ly = cy + r*0.62*math.sin(am)
            fill = "#fff" if color == "#202020" else "#000"
            out.append(f'<text x="{lx:.1f}" y="{ly:.1f}" font-size="12" text-anchor="middle" fill="{fill}">{label}</text>')
            ang += sweep
        return "".join(out)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 300" font-family="sans-serif">']
    s.append('<text x="120" y="22" font-size="13" text-anchor="middle" font-weight="bold">Denni cinnosti (24 hodin)</text>')
    s.append(pie(120, 150, 82, [(25,"#f0f0f0","25 %"),(35,"#b0b0b0","35 %"),(30,"#707070","30 %"),(10,"#202020","10 %")]))
    y = 110
    for col,txt in [("#f0f0f0","zamestnani"),("#b0b0b0","spanek"),("#707070","denni povinnosti"),("#202020","volny cas")]:
        s.append(f'<rect x="235" y="{y}" width="12" height="12" fill="{col}" stroke="#000"/><text x="252" y="{y+11}" font-size="11">{txt}</text>')
        y += 20
    s.append('<text x="450" y="22" font-size="13" text-anchor="middle" font-weight="bold">Volny cas</text>')
    s.append(pie(450, 150, 82, [(35,"#b0b0b0","35 %"),(40,"#f0f0f0","40 %"),(25,"#202020","25 %")]))
    y = 120
    for col,txt in [("#b0b0b0","TV"),("#f0f0f0","sport"),("#202020","cetba")]:
        s.append(f'<rect x="558" y="{y}" width="12" height="12" fill="{col}" stroke="#000"/><text x="575" y="{y+11}" font-size="11">{txt}</text>')
        y += 20
    s.append('</svg>')
    return "".join(s)
SVG8 = _pies()

# uloha 9: primka p a body A, S (vychozi obrazek)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif">
<line x1="60" y1="150" x2="410" y2="120" stroke="#000" stroke-width="2"/>
<text x="120" y="132" font-size="16" font-style="italic">p</text>
<text x="248" y="176" font-size="15" font-style="italic">S</text>
<text x="243" y="192" font-size="15">×</text>
<text x="170" y="206" font-size="15" font-style="italic">A</text>
<text x="184" y="210" font-size="15">×</text>
</svg>"""

# uloha 10: body C, S a primka p (vychozi obrazek)
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="120" y1="272" x2="420" y2="170" stroke="#000" stroke-width="2"/>
<text x="425" y="168" font-size="16" font-style="italic">p</text>
<text x="138" y="118" font-size="15" font-style="italic">C</text>
<text x="140" y="132" font-size="15">×</text>
<text x="258" y="150" font-size="15" font-style="italic">S</text>
<text x="252" y="164" font-size="15">×</text>
</svg>"""

# uloha 14: primky p, r, s protinajici se v jednom bode; uhel 126°30, pravy uhel, alfa/beta/gama
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif">
<line x1="60" y1="150" x2="440" y2="150" stroke="#000" stroke-width="1.5"/>
<text x="448" y="154" font-size="15" font-style="italic">p</text>
<line x1="250" y1="35" x2="250" y2="275" stroke="#000" stroke-width="1.5"/>
<text x="242" y="30" font-size="15" font-style="italic">s</text>
<line x1="161" y1="271" x2="339" y2="29" stroke="#000" stroke-width="1.5"/>
<text x="344" y="26" font-size="15" font-style="italic">r</text>
<path d="M250,150 L263,150 L263,163 L250,163" fill="none" stroke="#000" stroke-width="1"/>
<text x="200" y="96" font-size="14">126°30′</text>
<text x="298" y="142" font-size="15">γ</text>
<text x="203" y="171" font-size="15">α</text>
<text x="232" y="206" font-size="15">β</text>
</svg>"""

B = ['zs2', 'r9']  # 9. rocnik ZS / ctyrlete obory (JPZ)

PROBLEMS = [
    {'name':'CERMAT M9D 2024 – úloha 1','zad':[
        'Adam a Naďa šli spolu z Heraltic do Hvězdoňovic trasou dlouhou $2{,}7$ km. Adam má délku každého kroku $75$ cm, Naďa má každý krok dlouhý $60$ cm.',
        'O kolik kroků udělala Naďa více?'],
     'opts':None,'ln':2,
     'sol':['Trasa $2{,}7$ km $=270\\,000$ cm. Adam: $270\\,000:75=3600$ kroků. Naďa: $270\\,000:60=4500$ kroků. Rozdíl je $4500-3600=900$ kroků.'],
     'ans':'$900$ kroků','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2024 – úloha 2','zad':[
        'Reproduktory byly před Vánocemi zlevněny z původní ceny o $150$ korun, což bylo $15\\,\\%$ původní ceny. Po Vánocích je prodejce zlevnil ještě o $200$ korun z nové ceny.',
        'O kolik procent byla konečná cena nižší než cena původní?'],
     'opts':None,'ln':2,
     'sol':['$150$ korun je $15\\,\\%$ původní ceny, tedy původní cena $=150:0{,}15=1000$ korun. Po prvním zlevnění $1000-150=850$ korun, po druhém $850-200=650$ korun. Konečná cena je o $1000-650=350$ korun nižší, což je $\\frac{350}{1000}=35\\,\\%$.'],
     'ans':'$35\\,\\%$','pts':2,'mins':3,'diff':'3',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M9D 2024 – úloha 3.1','zad':[
        'Vypočítejte a výsledek zapište zlomkem v základním tvaru.',
        '$\\dfrac{\\left(\\frac{1}{6}-\\frac{1}{3}\\right):\\left(-\\frac{5}{3}\\right)}{0{,}3}=$'],
     'opts':None,'ln':3,
     'sol':['$\\frac{1}{6}-\\frac{1}{3}=-\\frac{1}{6}$. Dále $\\left(-\\frac{1}{6}\\right):\\left(-\\frac{5}{3}\\right)=\\frac{1}{6}\\cdot\\frac{3}{5}=\\frac{1}{10}$. Nakonec $\\frac{1}{10}:0{,}3=\\frac{1}{10}:\\frac{3}{10}=\\frac{1}{3}$.'],
     'ans':'$\\frac{1}{3}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2024 – úloha 3.2','zad':[
        'Vypočítejte a výsledek zapište zlomkem v základním tvaru.',
        '$\\frac{1}{6}+\\frac{1}{3}\\cdot\\left(\\frac{2}{5}-1\\right)=$'],
     'opts':None,'ln':3,
     'sol':['$\\frac{2}{5}-1=-\\frac{3}{5}$. Dále $\\frac{1}{3}\\cdot\\left(-\\frac{3}{5}\\right)=-\\frac{1}{5}$. Nakonec $\\frac{1}{6}-\\frac{1}{5}=\\frac{5}{30}-\\frac{6}{30}=-\\frac{1}{30}$.'],
     'ans':'$-\\frac{1}{30}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2024 – úloha 4.1','zad':[
        'Upravte a rozložte na součin vytknutím:',
        '$a\\cdot(-a)-2^2\\cdot 3a+6a^2=$'],
     'opts':None,'ln':2,
     'sol':['$a\\cdot(-a)-2^2\\cdot 3a+6a^2=-a^2-12a+6a^2=5a^2-12a=a(5a-12)$.'],
     'ans':'$a(5a-12)$','pts':1,'mins':2,'diff':'2',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2024 – úloha 4.2','zad':[
        'Umocněte a zjednodušte:',
        '$\\left(\\frac{1}{3}-4b\\right)^2=$'],
     'opts':None,'ln':2,
     'sol':['$\\left(\\frac{1}{3}-4b\\right)^2=\\left(\\frac{1}{3}\\right)^2-2\\cdot\\frac{1}{3}\\cdot 4b+(4b)^2=\\frac{1}{9}-\\frac{8}{3}b+16b^2$.'],
     'ans':'$\\frac{1}{9}-\\frac{8}{3}b+16b^2$','pts':1,'mins':2,'diff':'2',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2024 – úloha 4.3','zad':[
        'Upravte výraz tak, aby neobsahoval závorky, a zjednodušte:',
        '$(2x+3)^2-x\\cdot 6-4\\cdot(x-1)^2=$'],
     'opts':None,'ln':3,
     'sol':['$(2x+3)^2=4x^2+12x+9$ a $4\\cdot(x-1)^2=4x^2-8x+4$. Dosazením: $4x^2+12x+9-6x-(4x^2-8x+4)=14x+5$.'],
     'ans':'$14x+5$','pts':2,'mins':3,'diff':'3',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2024 – úloha 5.1','zad':[
        'Řešte rovnici (zkoušku nezapisujte):',
        '$x-\\frac{x-2}{2}=\\frac{2x}{3}-2$'],
     'opts':None,'ln':3,
     'sol':['Vynásobíme rovnici číslem $6$: $6x-3(x-2)=4x-12$, tj. $6x-3x+6=4x-12$, $3x+6=4x-12$, odtud $x=18$.'],
     'ans':'$x=18$','pts':2,'mins':3,'diff':'2',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2024 – úloha 5.2','zad':[
        'Řešte rovnici (zkoušku nezapisujte):',
        '$2\\cdot(3x-2{,}5)=-5+3\\cdot(3x-2)$'],
     'opts':None,'ln':3,
     'sol':['$6x-5=-5+9x-6$, tj. $6x-5=9x-11$, $6=3x$, odtud $x=2$.'],
     'ans':'$x=2$','pts':2,'mins':3,'diff':'3',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2024 – úloha 6','zad':[
        'Ve vnitrostátním rychlíku jsou řazeny vagóny 1. a 2. třídy. Vagónů 2. třídy je dvakrát více než vagónů 1. třídy. V každém vagónu je $10$ kupé (oddílů pro cestující). Ve vagónech 1. třídy je v každém kupé šest míst k sezení, ve vagónech 2. třídy osm míst k sezení. Ve všech kupé rychlíku je dohromady $440$ míst k sezení.',
        '6.1 Kolik vagónů 2. třídy je součástí rychlíku?',
        '6.2 Kolik míst k sezení je dohromady ve vagónech 1. třídy?'],
     'opts':None,'ln':3,
     'sol':['Označme počet vagónů 1. třídy $v$, pak vagónů 2. třídy je $2v$. V jednom vagónu 1. třídy je $10\\cdot 6=60$ míst, ve vagónu 2. třídy $10\\cdot 8=80$ míst. Rovnice: $60v+80\\cdot 2v=440$, tj. $220v=440$, odtud $v=2$.',
            '6.1 Vagónů 2. třídy je $2v=4$.',
            '6.2 Míst k sezení ve vagónech 1. třídy je $2\\cdot 60=120$.'],
     'ans':'6.1: $4$ vagóny; 6.2: $120$ míst','pts':4,'mins':5,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2024 – úloha 7','zad':[
        'V restauraci nabízejí tři různá obědová menu (polévku, hlavní jídlo a nápoj) označená písmeny A, B a C. Do restaurace přijely tři skupiny turistů po dvaceti lidech. V tabulce jsou uvedeny obědy, které si jednotlivé skupiny objednaly, a kolik za ně zaplatily.',
        '7.1 Jaká byla cena oběda B?',
        '7.2 Jaká byla cena oběda C?'],
     'opts':None,'ln':3,'svg':SVG7,'fn':'obedy-tabulka.svg',
     'alt':'Tabulka poctu objednanych obedu A, B, C u tri skupin a celkove ceny: skupina 1 (20, 0, 0) za 4 000 Kc, skupina 2 (10, 10, 0) za 4 800 Kc, skupina 3 (5, 5, 10) za 5 400 Kc.',
     'cap':'Počty objednaných obědů a zaplacené částky',
     'sol':['Skupina 1: $20$ obědů A za $4\\,000$ Kč, cena oběda A je $4\\,000:20=200$ Kč.',
            '7.1 Skupina 2: $10\\cdot 200+10\\cdot B=4\\,800$, tj. $2\\,000+10B=4\\,800$, odtud $B=280$ Kč.',
            '7.2 Skupina 3: $5\\cdot 200+5\\cdot 280+10\\cdot C=5\\,400$, tj. $2\\,400+10C=5\\,400$, odtud $C=300$ Kč.'],
     'ans':'7.1: $280$ Kč; 7.2: $300$ Kč','pts':4,'mins':5,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2024 – úloha 8','zad':[
        'V prvním grafu je průměrné časové rozložení všech denních činností paní Kratochvílové v pracovní den (celkem $24$ hodin): zaměstnání $25\\,\\%$, spánek $35\\,\\%$, denní povinnosti $30\\,\\%$, volný čas $10\\,\\%$. Ve druhém grafu je rozložení jejího volného času: TV $35\\,\\%$, sport $40\\,\\%$, četba $25\\,\\%$.',
        '8.1 Kolik hodin denně paní Kratochvílová tráví v zaměstnání?',
        '8.2 Kolik minut denně paní Kratochvílová sportuje? Výsledek zaokrouhlete na celé minuty.'],
     'opts':None,'ln':3,'svg':SVG8,'fn':'grafy-cas.svg',
     'alt':'Dva kolacove grafy: denni cinnosti (zamestnani 25 %, spanek 35 %, denni povinnosti 30 %, volny cas 10 %) a rozlozeni volneho casu (TV 35 %, sport 40 %, cetba 25 %).',
     'cap':'Rozložení denních činností a volného času',
     'sol':['8.1 Zaměstnání tvoří $25\\,\\%$ z $24$ hodin, tj. $0{,}25\\cdot 24=6$ hodin.',
            '8.2 Volný čas je $10\\,\\%$ z $24$ hodin $=2{,}4$ hodiny $=144$ minut. Sport je $40\\,\\%$ volného času: $0{,}4\\cdot 144=57{,}6$ minuty, po zaokrouhlení $58$ minut.'],
     'ans':'8.1: $6$ hodin; 8.2: $58$ minut','pts':4,'mins':5,'diff':'3',
     'codes':B+['statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2024 – úloha 9 (konstrukce)','zad':[
        'V rovině je dána přímka $p$ a body $A$ a $S$, které neleží na přímce $p$. Bod $A$ je vrchol obdélníku $ABCD$, bod $S$ je střed obdélníku (průsečík úhlopříček). Vrchol $D$ obdélníku leží na přímce $p$.',
        'Sestrojte obdélník $ABCD$. Nalezněte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'obdelnik-p-A-S.svg',
     'alt':'Primka p a dva body A a S, ktere na ni nelezi.','cap':'Výchozí obrázek k úloze 9',
     'sol':['Vrchol $C$ je souměrný s bodem $A$ podle středu $S$: sestrojíme polopřímku $AS$ a kružnici $k(S;|SA|)$; druhý průsečík polopřímky $AS$ s $k$ je bod $C$. Kružnice $k$ je Thaletova kružnice nad úhlopříčkou $AC$, proto vrchol $D$ leží na $k$ a zároveň na přímce $p$; průsečíky $k$ a $p$ dají dvě polohy $D_1$, $D_2$. Vrchol $B$ je obraz $D$ ve středové souměrnosti podle $S$. Vzniknou obdélníky $AB_1CD_1$ a $AB_2CD_2$.'],
     'ans':'Dvě řešení: $C$ je obraz $A$ ve středové souměrnosti podle $S$; $k(S;|SA|)$ je Thaletova kružnice, její průsečíky s přímkou $p$ jsou $D_1$, $D_2$; $B$ je obraz $D$ podle $S$. Obdélníky $AB_1CD_1$ a $AB_2CD_2$ (viz náčrt v klíči).',
     'pts':3,'mins':7,'diff':'4',
     'codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2024 – úloha 10 (konstrukce)','zad':[
        'V rovině leží body $C$, $S$ a přímka $p$. Bod $C$ je vrchol pravoúhlého trojúhelníku $ABC$. Bod $S$ je střed strany $BC$ tohoto trojúhelníku. Strana $AB$ tohoto trojúhelníku je rovnoběžná s přímkou $p$.',
        'Sestrojte pravoúhlý trojúhelník $ABC$. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'trojuhelnik-C-S-p.svg',
     'alt':'Body C a S a primka p v rovine.','cap':'Výchozí obrázek k úloze 10',
     'sol':['Bod $B$ je souměrný s $C$ podle středu $S$: sestrojíme polopřímku $CS$ a kružnici $k(S;|CS|)$; druhý průsečík polopřímky $CS$ s $k$ je bod $B$. Bodem $B$ vedeme rovnoběžku $p^\\prime$ s přímkou $p$ (na ní leží vrchol $A$, neboť $AB\\parallel p$). Pravý úhel může být u vrcholu $A$: kolmice z $C$ k $p^\\prime$ ji protne v bodě $A_1$. Nebo je pravý úhel u vrcholu $C$: kolmice k $CS$ v bodě $C$ protne $p^\\prime$ v bodě $A_2$. Vzniknou trojúhelníky $A_1BC$ a $A_2BC$.'],
     'ans':'Dvě řešení: $B$ je obraz $C$ podle $S$, $A$ leží na rovnoběžce s $p$ vedené bodem $B$; pravý úhel u $A$ ($A_1$ je pata kolmice z $C$) nebo u $C$ ($A_2$ na kolmici k $CS$ v bodě $C$). Trojúhelníky $A_1BC$ a $A_2BC$ (viz náčrt v klíči).',
     'pts':3,'mins':7,'diff':'4',
     'codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2024 – úloha 11','zad':[
        'V obchodě prodávají dámská a pánská trička. Ráno před začátkem otevírací doby tvořila dámská trička $60\\,\\%$ z celkového naskladněného množství triček, zbytek byla trička pánská. Přes den se prodalo $45$ dámských triček, což je čtvrtina všech dámských triček naskladněných ten den ráno. Pánských triček se ze všech naskladněných pánských triček prodala polovina.',
        'Kolik zůstalo na konci dne v obchodě triček (dámských i pánských dohromady)?'],
     'opts':['A) méně než $200$','B) $200$','C) $210$','D) $220$','E) více než $220$'],'ln':0,
     'sol':['$45$ je čtvrtina dámských triček, dámských tedy bylo $180$. To je $60\\,\\%$ celku, celkem $180:0{,}6=300$ triček, z toho pánských $120$. Prodáno: dámských $45$, pánských $\\frac{120}{2}=60$. Zůstalo dámských $180-45=135$ a pánských $120-60=60$, celkem $195$ triček (méně než $200$).'],
     'ans':'A) méně než $200$','pts':2,'mins':4,'diff':'3',
     'codes':B+['procenta','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2024 – úloha 12','zad':[
        'Petr přečetl již $1\\,050$ stran knižní série, do konce mu zbývá přečíst ještě $450$ stran.',
        'Kolik procent stran knižní série Petrovi zbývá dočíst?'],
     'opts':['A) $27\\,\\%$','B) $30\\,\\%$','C) $33\\,\\%$','D) $40\\,\\%$','E) $43\\,\\%$'],'ln':0,
     'sol':['Celkem má série $1\\,050+450=1\\,500$ stran. Zbývá $\\frac{450}{1\\,500}=0{,}3=30\\,\\%$.'],
     'ans':'B) $30\\,\\%$','pts':2,'mins':3,'diff':'2',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2024 – úloha 13','zad':[
        'Maminka oškrabe $6$ kg brambor za $2$ hodiny a $24$ minut. Babička oškrabe $2$ kg brambor za $1$ hodinu a $20$ minut. Maminka i babička škrabou brambory stálým tempem.',
        'Za kolik minut oškrabou maminka a babička $1$ kg brambor, pokud škrabou obě dohromady?'],
     'opts':['A) za $64$ minut','B) za $32$ minut','C) za $15$ minut','D) za $12$ minut','E) jiný výsledek'],'ln':0,
     'sol':['Maminka: $6$ kg za $144$ minut, tj. $\\frac{6}{144}=\\frac{1}{24}$ kg za minutu. Babička: $2$ kg za $80$ minut, tj. $\\frac{2}{80}=\\frac{1}{40}$ kg za minutu. Dohromady $\\frac{1}{24}+\\frac{1}{40}=\\frac{5+3}{120}=\\frac{8}{120}=\\frac{1}{15}$ kg za minutu, tedy $1$ kg za $15$ minut.'],
     'ans':'C) za $15$ minut','pts':2,'mins':4,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2024 – úloha 14','zad':[
        'Přímky $p$, $r$ a $s$ se protínají v jednom bodě (viz obrázek).',
        'Jaký je součet úhlů $\\alpha+\\beta+\\gamma$? Velikosti úhlů neměřte, ale vypočítejte (obrázek je ilustrační).'],
     'opts':['A) $126^\\circ\\,30^\\prime$','B) $133^\\circ\\,30^\\prime$','C) $143^\\circ\\,30^\\prime$','D) $180^\\circ$','E) jiný výsledek'],
     'ln':0,'svg':SVG14,'fn':'primky-uhly.svg',
     'alt':'Tri primky p, r, s prochazejici jednim bodem; vyznacen uhel 126 stupnu 30 minut, pravy uhel a uhly alfa, beta, gama.',
     'cap':'Schematický nákres (obrázek je ilustrační)',
     'sol':['Přímky $p$ a $s$ jsou kolmé (vyznačený pravý úhel), svírají $90^\\circ$. Úhel $\\gamma$ doplňuje vyznačený úhel do přímého úhlu: $\\gamma=180^\\circ-126^\\circ\\,30^\\prime=53^\\circ\\,30^\\prime$. Úhel $\\alpha$ je vrcholový k úhlu $\\gamma$, tedy $\\alpha=53^\\circ\\,30^\\prime$. Úhel $\\beta$ doplňuje $\\alpha$ do pravého úhlu: $\\beta=90^\\circ-53^\\circ\\,30^\\prime=36^\\circ\\,30^\\prime$. Součet $\\alpha+\\beta+\\gamma=53^\\circ\\,30^\\prime+36^\\circ\\,30^\\prime+53^\\circ\\,30^\\prime=143^\\circ\\,30^\\prime$.'],
     'ans':'C) $143^\\circ\\,30^\\prime$','pts':2,'mins':4,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2024 – úloha 15','zad':[
        'V obchodě mají dva druhy jablek. Kilogram jednoho druhu (dražších) jablek stojí $30$ Kč, kilogram druhého druhu (levnějších) jablek stojí $25$ Kč. Paní Vitamínová koupila $x$ kilogramů jablek, kde $x$ je celé číslo, a zaplatila $330$ Kč.',
        'Rozhodněte o každém z tvrzení 15.1–15.3, zda je pravdivé (A), či nikoli (N).',
        '15.1 Pokud paní Vitamínová koupila $12$ kg jablek, koupila stejné množství obou druhů jablek.',
        '15.2 Paní Vitamínová mohla koupit jen levnější druh jablek.',
        '15.3 Pokud chce paní Vitamínová koupit co nejvíce kilogramů jablek, musí koupit právě jeden kilogram dražších jablek.'],
     'opts':None,'ln':0,
     'sol':['Označme $d$ počet kg dražších a $l$ počet kg levnějších jablek: $30d+25l=330$, tj. $6d+5l=66$. Celočíselná nezáporná řešení jsou $(d,l)=(1,12)$, $(6,6)$, $(11,0)$.',
            '15.1 Při $12$ kg jde o řešení $(6,6)$, tedy stejné množství obou druhů. Pravdivé (Ano).',
            '15.2 Jen levnější druh by znamenal $d=0$, ale to není žádné z řešení ($25l=330$ nemá celé řešení). Nepravdivé (Ne).',
            '15.3 Nejvíce kilogramů dává řešení $(1,12)$, tj. $13$ kg, kde je právě $1$ kg dražších jablek. Pravdivé (Ano).'],
     'ans':'15.1: Ano; 15.2: Ne; 15.3: Ano','pts':3,'mins':5,'diff':'4',
     'codes':B+['aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2024 – úloha 16','zad':[
        'Přiřaďte ke každé podúloze (16.1–16.3) odpovídající výsledek (A–F).',
        '16.1 Zvětšíme-li neznámé číslo o $4\\,\\%$, dostaneme číslo $780$. Jaké je toto neznámé číslo?',
        '16.2 O kolik procent musíme zvětšit $\\frac{1}{8}$, abychom dostali $\\frac{1}{2}$?',
        '16.3 Máme dvě čerpadla. Jejich výkony jsou v poměru $3:7$. Méně výkonné čerpadlo vyčerpá $150$ litrů vody za dvě hodiny. Kolik litrů vody vyčerpá výkonnější čerpadlo za $5$ hodin?'],
     'opts':['A) $300$','B) $400$','C) $720$','D) $750$','E) $875$','F) jiný výsledek'],'ln':0,
     'sol':['16.1 $x\\cdot 1{,}04=780$, tedy $x=780:1{,}04=750$ → D.',
            '16.2 Rozdíl $\\frac{1}{2}-\\frac{1}{8}=\\frac{3}{8}$; poměr k $\\frac{1}{8}$ je $\\frac{3/8}{1/8}=3=300\\,\\%$ → A.',
            '16.3 Méně výkonné čerpadlo: $150$ l za $2$ h, tj. $75$ l/h; to jsou $3$ díly, jeden díl $25$ l/h. Výkonnější ($7$ dílů) má $175$ l/h, za $5$ h vyčerpá $175\\cdot 5=875$ litrů → E.'],
     'ans':'16.1: D ($750$); 16.2: A ($300\\,\\%$); 16.3: E ($875$ litrů)','pts':6,'mins':7,'diff':'3',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PDD24C0T04'
    gen.YEAR = 2024

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9D-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
