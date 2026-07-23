# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2025, MATEMATIKA 5C, 1. náhradní termín.
# Kód testu: M5PCD25C0T03. 14 úloh (po rozdělení úlohy 7 na 7.1 a 7.2 celkem 15 úloh).
# Zdroj odpovědí: rozšířený klíč správných řešení (KSR) 2025.

import math

# ---- SVG obrázky (bez ' a \) ----

# úloha 6: šestiúhelník rozdělený dvěma úsečkami na velký a malý bílý čtverec
# a dva shodné tmavé pravoúhlé trojúhelníky (odvěsny 12 a 9, přepona 15).
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 285 285" font-family="sans-serif">
<polygon points="15,123 159,123 159,15" fill="#b3b3b3" stroke="#000"/>
<polygon points="159,267 267,123 159,123" fill="#b3b3b3" stroke="#000"/>
<polygon points="15,267 159,267 159,123 15,123" fill="#ffffff" stroke="#000"/>
<polygon points="159,123 267,123 267,15 159,15" fill="#ffffff" stroke="#000"/>
<polygon points="15,267 159,267 267,123 267,15 159,15 15,123" fill="none" stroke="#000" stroke-width="2.5"/>
</svg>"""

# úloha 7.1: výchozí obrázek – bod U a přímka p procházející bodem S
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="200" y1="285" x2="285" y2="25" stroke="#000" stroke-width="2"/>
<text x="186" y="290" font-size="16" font-style="italic">p</text>
<circle cx="245" cy="150" r="2.5" fill="#000"/>
<text x="255" y="152" font-size="15" font-style="italic">S</text>
<text x="400" y="118" font-size="15" font-style="italic">U</text>
<text x="396" y="133" font-size="15">×</text>
</svg>"""

# úloha 7.2: výchozí obrázek – bod R a přímka m procházející bodem K
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="130" y1="300" x2="410" y2="50" stroke="#000" stroke-width="2"/>
<text x="418" y="53" font-size="16" font-style="italic">m</text>
<text x="176" y="278" font-size="15">×</text>
<text x="182" y="292" font-size="15" font-style="italic">K</text>
<text x="298" y="180" font-size="15">×</text>
<text x="304" y="194" font-size="15" font-style="italic">R</text>
</svg>"""

# úloha 8: skupinový sloupcový graf – návštěvnost (děti / dospělí), květen–září
def _hist():
    data = [('Květen',30,80),('Červen',10,60),('Červenec',30,70),('Srpen',50,90),('Září',40,100)]
    x0,y0 = 60,300; sc=2.2; bw=24; gw=112
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 350" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="40" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="620" y2="{y0}" stroke="#000"/>')
    for v in range(0,111,10):
        y = y0 - v*sc
        s.append(f'<line x1="{x0-4}" y1="{y:.0f}" x2="{x0}" y2="{y:.0f}" stroke="#000"/><text x="{x0-8}" y="{y+4:.0f}" font-size="10" text-anchor="end">{v}</text>')
    x = x0 + 28
    for name,d,a in data:
        hd=d*sc; ha=a*sc
        s.append(f'<rect x="{x}" y="{y0-hd:.0f}" width="{bw}" height="{hd:.0f}" fill="#555" stroke="#000"/>')
        s.append(f'<rect x="{x+bw}" y="{y0-ha:.0f}" width="{bw}" height="{ha:.0f}" fill="#dddddd" stroke="#000"/>')
        s.append(f'<text x="{x+bw}" y="{y0+16}" font-size="11" text-anchor="middle">{name}</text>')
        x += gw
    s.append('<rect x="560" y="120" width="14" height="14" fill="#555" stroke="#000"/><text x="580" y="132" font-size="12">Děti</text>')
    s.append('<rect x="560" y="142" width="14" height="14" fill="#dddddd" stroke="#000"/><text x="580" y="154" font-size="12">Dospělí</text>')
    s.append('<text x="20" y="175" font-size="11" text-anchor="middle" transform="rotate(-90 20 175)">Počet prodaných vstupenek</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _hist()

# úloha 12: schematická stavba ze tří shodných kvádrů (prostorové těleso)
def _box(x,y,w,h,ox,oy):
    FLb=(x,y); FRb=(x+w,y); FRt=(x+w,y-h); FLt=(x,y-h)
    def o(p): return (p[0]+ox,p[1]+oy)
    def poly(pts,fill):
        ps=" ".join(f"{a:.0f},{b:.0f}" for a,b in pts)
        return f'<polygon points="{ps}" fill="{fill}" stroke="#000"/>'
    return [poly([FLt,FRt,o(FRt),o(FLt)],"#e9e9e9"),
            poly([FRb,FRt,o(FRt),o(FRb)],"#cfcfcf"),
            poly([FLb,FRb,FRt,FLt],"#f6f6f6")]
def _stavba():
    ox,oy = 24,-16
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">']
    for bx in _box(250,265,60,50,ox,oy): s.append(bx)   # pravý kvádr (Start)
    for bx in _box(160,240,80,52,ox,oy): s.append(bx)   # prostřední kvádr
    for bx in _box(70,205,55,100,ox,oy): s.append(bx)   # levý kvádr (Cíl)
    s.append('<text x="60" y="120" font-size="12">Cíl</text>')
    s.append('<text x="320" y="255" font-size="12">Start</text>')
    s.append('<text x="40" y="165" font-size="11">7 cm</text>')
    s.append('<text x="95" y="118" font-size="11">4 cm</text>')
    s.append('<text x="190" y="205" font-size="11">7 cm</text>')
    s.append('<text x="285" y="205" font-size="11">5 cm</text>')
    s.append('<text x="330" y="235" font-size="11">4 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _stavba()

# úloha 14: tři obrazce (šestiúhelníky) z bílých a šedých rovnostranných trojúhelníků
# (všechny trojúhelníky jedné barvy sloučeny do jednoho <path> kvůli velikosti)
def _seg(a,b,c):
    return (f'M{a[0]:.0f},{a[1]:.0f}L{b[0]:.0f},{b[1]:.0f}'
            f'L{c[0]:.0f},{c[1]:.0f}Z')
def _hexfig(cx,cy,n,R,gray,white):
    verts=[(cx+R*math.cos(math.radians(60*k-90)), cy+R*math.sin(math.radians(60*k-90))) for k in range(6)]
    for k in range(6):
        O=(cx,cy); P1=verts[k]; P2=verts[(k+1)%6]
        def G(i,j):
            return (O[0]+(i/n)*(P1[0]-O[0])+(j/n)*(P2[0]-O[0]),
                    O[1]+(i/n)*(P1[1]-O[1])+(j/n)*(P2[1]-O[1]))
        for i in range(n):
            for j in range(n-i):
                (gray if k%2==0 else white).append(_seg(G(i,j),G(i+1,j),G(i,j+1)))
                if i+j < n-1:
                    (gray if k%2==1 else white).append(_seg(G(i+1,j),G(i,j+1),G(i+1,j+1)))
def _obrazce():
    gray=[]; white=[]
    cfg=[(70,1,26,'1. obrazec'),(210,2,52,'2. obrazec'),(420,3,78,'3. obrazec')]
    for cx,n,R,label in cfg:
        _hexfig(cx,130,n,R,gray,white)
    s=['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250" font-family="sans-serif">']
    s.append(f'<path fill="#fff" stroke="#777" stroke-width="0.7" d="{"".join(white)}"/>')
    s.append(f'<path fill="#9a9a9a" stroke="#777" stroke-width="0.7" d="{"".join(gray)}"/>')
    for cx,n,R,label in cfg:
        s.append(f'<text x="{cx}" y="26" font-size="13" text-anchor="middle">{label}</text>')
    s.append('<text x="545" y="138" font-size="22">…</text>')
    s.append('</svg>')
    return "".join(s)
SVG14 = _obrazce()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 v taxonomii není

PROBLEMS = [
    {'name':'CERMAT M5C 2025 – úloha 1','zad':[
        'Vlak vyjel v poledne ze stanice a za každých 8 minut ujel 7 km. Ve 12:20 vlak minul lom a ve 12:36 dojel na most přes řeku.',
        'Určete v km vzdálenost, kterou ujel vlak od lomu k mostu.'],
     'opts':None,'ln':1,
     'sol':['Od 12:20 do 12:36 uplynulo 16 minut, což je dvakrát 8 minut. Vlak tedy ujel $2\\cdot 7=14$ km.'],
     'ans':'$14$ km','pts':2,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5C 2025 – úloha 2','zad':[
        'Děti doplňovaly jednu dvojici závorek do příkladu $9\\cdot 8-6:2=$. Každé z dětí doplnilo závorky jiným způsobem a vypočetlo správný výsledek svého příkladu. Pouze Jarda doplnil závorky více způsoby, ale všechny jeho zápisy vedly k témuž výsledku (např. jeden z nich byl $(9\\cdot 8-6:2)=$). Dětí bylo přesně tolik, kolik různých výsledků lze získat.',
        '2.1 Určete Jardův výsledek.',
        '2.2 Uveďte zápisy příkladů s doplněnými závorkami a vypočtenými výsledky všech dětí s výjimkou Jardy.'],
     'opts':None,'ln':4,
     'sol':['2.1 Závorka kolem celého výrazu nemění pořadí operací: $(9\\cdot 8-6:2)=72-3=69$. Jardův výsledek je $69$.',
            '2.2 Ostatní děti doplnily závorky takto: $9\\cdot(8-6:2)=45$; $(9\\cdot 8-6):2=33$; $9\\cdot(8-6):2=9$. Různých výsledků je celkem 4 ($69,45,33,9$), tedy dětí byly 4.'],
     'ans':'2.1: $69$; 2.2: $9\\cdot(8-6:2)=45$; $(9\\cdot 8-6):2=33$; $9\\cdot(8-6):2=9$','pts':4,'mins':6,'diff':'3',
     'codes':B+['aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5C 2025 – úloha 3','zad':[
        'Stuhu jsme beze zbytku rozstříhali na 20 dílů dvou různých délek – kratší díly po 20 cm a delší po 30 cm. Kratších dílů bylo o třetinu méně než delších dílů.',
        '3.1 Vypočtěte, kolik delších dílů jsme ze stuhy nastříhali.',
        '3.2 Vypočtěte, kolik cm měřila celá stuha, než jsme ji začali stříhat.'],
     'opts':None,'ln':2,
     'sol':['3.1 Delších dílů je $d$, kratších $d-\\frac{1}{3}d=\\frac{2}{3}d$. Dohromady $d+\\frac{2}{3}d=20$, tj. $\\frac{5}{3}d=20$, $d=12$. Delších dílů je $12$.',
            '3.2 Kratších dílů je $\\frac{2}{3}\\cdot 12=8$. Délka stuhy $12\\cdot 30+8\\cdot 20=360+160=520$ cm.'],
     'ans':'3.1: $12$ delších dílů; 3.2: $520$ cm','pts':3,'mins':4,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5C 2025 – úloha 4','zad':[
        'Adam pravidelně kupuje pro psy mražené mleté maso v baleních po 2 kg. Dnes měl v peněžence o 14 korun víc, než potřeboval minule na nákup 12 kg masa. Maso však bylo zdraženo, a tak mu dnes na nákup stejného množství masa 40 korun chybělo. Koupil proto o 1 balení masa méně a v peněžence mu zbylo 50 korun.',
        '4.1 Vypočtěte, kolik balení masa Adam dnes koupil.',
        '4.2 Vypočtěte, kolik korun dnes stálo jedno balení masa.',
        '4.3 Vypočtěte, kolik korun si dnes Adam vzal na nákup masa.',
        '4.4 Vypočtěte, o kolik korun bylo dnes jedno balení masa dražší než minule.'],
     'opts':None,'ln':4,
     'sol':['12 kg masa je $6$ balení. Minule stálo $6$ balení $6p$ korun, dnes za novou cenu $6q$ korun. Adam měl dnes $6p+14$ korun a na $6$ balení mu chybělo 40 korun: $6q=6p+14+40$, odtud $q=p+9$ (4.4: o $9$ korun).',
            '4.4 Nové balení je o $9$ korun dražší.',
            '4.2 Koupil o balení méně (5 balení) a zbylo mu 50 korun: $(6p+14)-5q=50$. Dosazením $q=p+9$: $6p+14-5(p+9)=50$, tj. $p-31=50$, $p=81$; nová cena $q=90$ korun.',
            '4.3 Adam měl $6p+14=6\\cdot 81+14=500$ korun.',
            '4.1 Za $500$ korun koupil $5$ balení po $90$ korunách (zbylo $500-450=50$).'],
     'ans':'4.1: $5$ balení; 4.2: $90$ korun; 4.3: $500$ korun; 4.4: o $9$ korun','pts':5,'mins':7,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M5C 2025 – úloha 5','zad':[
        '5.1 Písmena $K$, $L$ představují dvě různé číslice. Sčítaná trojciferná čísla jsou $\\overline{KLL}$ a $\\overline{KLK}$; jejich součet je čtyřciferné číslo, jehož poslední dvě číslice jsou $1$ a $1$ (první dvě číslice součtu chybějí). Určete číslice, kterými se nahradí $K$, $L$, a zapište je v tomto pořadí.',
        '5.2 Písmena $S$, $T$, $U$ představují tři navzájem různé číslice. V zápise součtu tří dvouciferných čísel $\\overline{ST}+\\overline{ST}+\\overline{TU}$ je výsledek roven $211$. Určete číslice $S$, $T$, $U$ a zapište je v tomto pořadí. Najděte všechna tři řešení.'],
     'opts':None,'ln':4,
     'sol':['5.1 Z posledního sloupce $L+K$ končí na 1 a přenáší se; ze sloupce desítek $L+L+1$ končí na 1. Řešením je $K=6$, $L=5$: $655+656=1311$ (poslední dvě číslice jsou $1$, $1$).',
            '5.2 Platí $\\overline{ST}+\\overline{ST}+\\overline{TU}=20S+12T+U=211$. Trojice různých číslic vyhovujících podmínce jsou $(S,T,U)=(9,2,7)$, $(8,4,3)$ a $(5,9,3)$.'],
     'ans':'5.1: $K=6$, $L=5$ (tj. $6, 5$); 5.2: $9, 2, 7$; $8, 4, 3$; $5, 9, 3$','pts':4,'mins':6,'diff':'4',
     'codes':B+['aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5C 2025 – úloha 6','zad':[
        'Šestiúhelník na obrázku je rozdělen dvěma úsečkami na dva bílé čtverce a dva stejné tmavé trojúhelníky. Délka strany malého čtverce je o čtvrtinu menší než délka strany velkého čtverce. Obvody obou čtverců se liší o 12 cm. Obvod jednoho tmavého trojúhelníku je stejný jako obvod malého čtverce.',
        '6.1 Vypočtěte v cm délku strany malého čtverce.',
        '6.2 Vypočtěte v cm obvod velkého čtverce.',
        '6.3 Určete, kolikrát větší je obvod šestiúhelníku než obvod malého čtverce.'],
     'opts':None,'ln':3,'svg':SVG6,'fn':'sestiuhelnik.svg',
     'alt':'Šestiúhelník rozdělený dvěma úsečkami na velký a malý bílý čtverec a dva shodné tmavé pravoúhlé trojúhelníky.',
     'cap':'Schematický nákres (rozměry dle zadání)',
     'sol':['6.1 Strana malého čtverce $m=\\frac{3}{4}v$. Obvody se liší o 12 cm: $4v-4m=12$, tj. $v-m=3$. Odtud $v-\\frac{3}{4}v=3$, $\\frac{1}{4}v=3$, $v=12$ cm a $m=9$ cm. Strana malého čtverce je $9$ cm.',
            '6.2 Obvod velkého čtverce je $4\\cdot 12=48$ cm.',
            '6.3 Tmavý trojúhelník je pravoúhlý s odvěsnami $12$ cm a $9$ cm a přeponou $\\sqrt{12^2+9^2}=15$ cm (jeho obvod $12+9+15=36$ cm je roven obvodu malého čtverce). Obvod šestiúhelníku tvoří dvě strany velkého čtverce, dvě strany malého čtverce a dvě přepony: $2\\cdot 12+2\\cdot 9+2\\cdot 15=72$ cm. Obvod malého čtverce je $36$ cm, tedy $72:36=2$.'],
     'ans':'6.1: $9$ cm; 6.2: $48$ cm; 6.3: 2krát','pts':5,'mins':7,'diff':'3',
     'codes':B+['planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5C 2025 – úloha 7.1 (konstrukce)','zad':[
        'V rovině leží bod $U$ a přímka $p$ procházející bodem $S$ (viz obrázek).',
        'Na přímce $p$ leží strana $AB$ pravoúhlého trojúhelníku $ABC$ s pravým úhlem při vrcholu $A$. Bod $S$ je střed strany $AB$ a vzdálenost bodu $A$ od bodu $S$ je 3 cm. Vrchol $C$ trojúhelníku $ABC$ leží na polopřímce $US$.',
        'Sestrojte všechny vrcholy trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG7_1,'fn':'uloha7-1.svg',
     'alt':'Bod U a přímka p procházející bodem S (výchozí obrázek k úloze 7.1).',
     'cap':'Výchozí obrázek k úloze 7.1',
     'sol':['Na přímce $p$ leží body $A$ a $B$ ve vzdálenosti $3$ cm od bodu $S$ na opačných stranách ($S$ je střed $AB$, $|AB|=6$ cm). Pravý úhel je při vrcholu $A$, proto vrchol $C$ leží na kolmici k přímce $p$ vedené bodem $A$; současně $C$ leží na polopřímce $US$. Vrchol $C$ je tedy průsečík této kolmice s polopřímkou $US$. Podle toho, který z obou bodů na $p$ zvolíme za $A$, dostaneme dvě řešení – trojúhelníky $A_1B_1C_1$ a $A_2B_2C_2$.'],
     'ans':'Dvě řešení: $A$, $B$ na přímce $p$ ve vzdálenosti $3$ cm od $S$; $C$ je průsečík kolmice k $p$ v bodě $A$ s polopřímkou $US$ (viz náčrt v klíči).',
     'pts':3,'mins':6,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5C 2025 – úloha 7.2 (konstrukce)','zad':[
        'V rovině leží bod $R$ a přímka $m$ procházející bodem $K$ (viz obrázek).',
        'Bod $K$ je vrchol obdélníku $KLMN$. Na přímce $m$ leží vrchol $M$ tohoto obdélníku. Přitom úsečka $MR$ má stejnou délku jako úsečka $KR$. Vrchol $L$ obdélníku $KLMN$ leží na přímce $KR$.',
        'Sestrojte vrcholy $L$, $M$, $N$ obdélníku $KLMN$, označte je písmeny a obdélník narýsujte.'],
     'opts':None,'ln':0,'svg':SVG7_2,'fn':'uloha7-2.svg',
     'alt':'Bod R a přímka m procházející bodem K (výchozí obrázek k úloze 7.2).',
     'cap':'Výchozí obrázek k úloze 7.2',
     'sol':['Bod $M$ leží na přímce $m$ a platí $|MR|=|KR|$, proto je $M$ průsečíkem přímky $m$ s kružnicí se středem $R$ a poloměrem $|KR|$. V obdélníku $KLMN$ je při vrcholu $L$ pravý úhel a $L$ leží na přímce $KR$, takže $L$ je pata kolmice spuštěné z bodu $M$ na přímku $KR$. Vrchol $N$ doplníme tak, aby $KLMN$ byl obdélník.'],
     'ans':'Jedno řešení: $M$ je průsečík přímky $m$ s kružnicí ($R$; $|KR|$), $L$ je pata kolmice z $M$ na přímku $KR$, $N$ doplní obdélník $KLMN$ (viz náčrt v klíči).',
     'pts':3,'mins':6,'diff':'4','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5C 2025 – úloha 8','zad':[
        'Rodný dům slavného spisovatele je otevřen pouze v letní sezoně od května do září. V pokladně zaznamenávají počet prodaných vstupenek dětským a dospělým návštěvníkům. V grafu je uvedena návštěvnost v jedné sezoně (počet prodaných vstupenek): Květen – děti 30, dospělí 80; Červen – děti 10, dospělí 60; Červenec – děti 30, dospělí 70; Srpen – děti 50, dospělí 90; Září – děti 40, dospělí 100.',
        'Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
        '8.1 V prvních třech měsících sezony bylo mezi návštěvníky rodného domu třikrát více dospělých než dětí.',
        '8.2 Dospělých návštěvníků rodného domu bylo v srpnu o polovinu více než v červnu.',
        '8.3 Za celou sezonu bylo dětských návštěvníků rodného domu o 340 méně než dospělých.'],
     'opts':None,'ln':0,'svg':SVG8,'fn':'graf-navstevnost.svg',
     'alt':'Skupinový sloupcový graf počtu prodaných vstupenek (děti a dospělí) v květnu až září.',
     'cap':'Návštěvnost rodného domu v jedné sezoně (počet vstupenek)',
     'sol':['8.1 První tři měsíce: dětí $30+10+30=70$, dospělých $80+60+70=210$; $210=3\\cdot 70$ – tvrzení platí (Ano).',
            '8.2 V srpnu bylo dospělých $90$, v červnu $60$; $90=60+\\frac{1}{2}\\cdot 60$, tj. o polovinu více – tvrzení platí (Ano).',
            '8.3 Za celou sezonu dětí $30+10+30+50+40=160$, dospělých $80+60+70+90+100=400$; rozdíl $400-160=240$, nikoli $340$ – tvrzení neplatí (Ne).'],
     'ans':'8.1: Ano; 8.2: Ano; 8.3: Ne','pts':4,'mins':6,'diff':'3',
     'codes':B+['statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5C 2025 – úloha 9','zad':[
        'V kamionu se převážejí bedny naplněné baleními minerálek. Do každé bedny se jednotlivá balení naskládají do 4 vrstev nad sebou. Každá vrstva obsahuje 3 řady po 7 baleních. K přepravě bylo připraveno 1560 balení minerálek, která se postupně skládala do beden. Všechny bedny kromě poslední byly zcela naplněny.',
        'Kolik balení minerálek by bylo třeba přidat do poslední bedny, aby byla plná?'],
     'opts':['A) méně než 32 balení','B) 32 balení','C) 34 balení','D) 36 balení','E) více než 36 balení'],'ln':0,
     'sol':['Jedna bedna pojme $4\\cdot 3\\cdot 7=84$ balení. Platí $1560=18\\cdot 84+48$, v poslední bedně je tedy $48$ balení. Do plné bedny chybí $84-48=36$ balení.'],
     'ans':'D) 36 balení','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5C 2025 – úloha 10','zad':[
        'Jitka s maminkou a babičkou trhaly na zahradě rybíz do stejně velkých hrnků. Maminka natrhala dvakrát více rybízu než Jitka. Babička natrhala o polovinu více rybízu než Jitka. Přitom babička natrhala o 2 hrnky rybízu méně než maminka.',
        'Kolik hrnků rybízu natrhaly všechny tři dohromady?'],
     'opts':['A) 18 hrnků','B) 20 hrnků','C) 21 hrnků','D) 24 hrnků','E) 25 hrnků'],'ln':0,
     'sol':['Jitka natrhala $j$ hrnků, maminka $2j$, babička $1{,}5j$. Babička o 2 hrnky méně než maminka: $1{,}5j=2j-2$, odtud $0{,}5j=2$, $j=4$. Maminka $8$, babička $6$. Celkem $4+8+6=18$ hrnků.'],
     'ans':'A) 18 hrnků','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5C 2025 – úloha 11','zad':[
        'Záhon má tvar obdélníku, jehož délka je trojnásobkem jeho šířky. Záhon má obvod 16 m. Po obvodu záhonu jsou vysázeny květiny ve stejných rozestupech, vzdálenost dvou sousedních květin je vždy 40 cm. Jedna květina je i v každém rohu záhonu.',
        'O kolik se liší počet květin vysázených na kratší straně záhonu a počet květin vysázených na delší straně záhonu?'],
     'opts':['A) o 9 květin','B) o 10 květin','C) o 11 květin','D) o 12 květin','E) o jiný počet květin'],'ln':0,
     'sol':['Obvod je $16$ m a délka je trojnásobek šířky: $2(3s+s)=16$, $8s=16$, $s=2$ m, délka $6$ m. Rozestup $40$ cm $=0{,}4$ m. Na kratší straně ($2$ m) je $2:0{,}4=5$ mezer, tj. $6$ květin i s rohovými; na delší straně ($6$ m) je $6:0{,}4=15$ mezer, tj. $16$ květin. Rozdíl je $16-6=10$.'],
     'ans':'B) o 10 květin','pts':2,'mins':4,'diff':'3',
     'codes':B+['planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5C 2025 – úloha 12','zad':[
        'Ze tří stejných kvádrů o rozměrech 7 cm, 5 cm a 4 cm jsme v rohu místnosti postavili stavbu jako na obrázku. Po černě vyznačené trase vedoucí po hranách kvádrů lezl od startu do cíle mravenec.',
        'Jak dlouhá je vyznačená mravencova trasa?'],
     'opts':['A) méně než 53 cm','B) 53 cm','C) 55 cm','D) 56 cm','E) 57 cm'],'ln':0,'svg':SVG12,'fn':'stavba-kvadry.svg',
     'alt':'Schematický nákres stavby ze tří shodných kvádrů 7 cm krát 5 cm krát 4 cm sestavených do schodů, se startem a cílem.',
     'cap':'Schematický nákres (prostorová stavba – posuzuje se podle originálu)',
     'sol':['Vyznačená trasa vede po hranách kvádrů o rozměrech $7$ cm, $5$ cm a $4$ cm. Součet délek všech jejích úseků je $57$ cm.'],
     'ans':'E) 57 cm','pts':2,'mins':4,'diff':'3',
     'codes':B+['stereometrie','porozumeni','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5C 2025 – úloha 13','zad':[
        'Skupina 18 osob přijela do penzionu na jednu noc. Každý pronajatý pokoj musí být vždy plně obsazen. Počty volných pokojů a ceny za jedno lůžko: jednolůžkový – 6 pokojů, 1400 korun za lůžko; dvoulůžkový – 5 pokojů, 700 korun za lůžko; třílůžkový – 5 pokojů, 500 korun za lůžko; čtyřlůžkový – 2 pokoje, 300 korun za lůžko.',
        'Přiřaďte ke každé situaci (13.1–13.3) počet dvoulůžkových pokojů (A–F), které skupina obsadí.',
        '13.1 Skupina obsadí stejný počet jednolůžkových, dvoulůžkových i třílůžkových pokojů.',
        '13.2 Skupina obsadí všechny volné třílůžkové pokoje a zaplatí celkem 10 300 korun.',
        '13.3 Skupina si vybere nejlevnější možné obsazení pokojů.'],
     'opts':['A) žádný dvoulůžkový pokoj','B) 1','C) 2','D) 3','E) 4','F) 5'],'ln':0,
     'sol':['13.1 Stejný počet $x$ jedno-, dvou- i třílůžkových pokojů ubytuje $x(1+2+3)=6x$ osob; $6x=18$, $x=3$. Dvoulůžkové: $3$ → D.',
            '13.2 Všech $5$ třílůžkových pokojů ubytuje $15$ osob za $5\\cdot 3\\cdot 500=7500$ korun. Zbývají $3$ osoby a $10\\,300-7500=2800$ korun, což odpovídá $1$ dvoulůžkovému ($1400$ Kč) a $1$ jednolůžkovému ($1400$ Kč) pokoji. Dvoulůžkové: $1$ → B.',
            '13.3 Nejlevnější je obsadit $2$ čtyřlůžkové ($8$ osob), $2$ třílůžkové ($6$ osob) a $2$ dvoulůžkové ($4$ osoby), celkem $18$ osob za $2400+3000+2800=8200$ korun. Dvoulůžkové: $2$ → C.'],
     'ans':'13.1: D (3 pokoje); 13.2: B (1 pokoj); 13.3: C (2 pokoje)','pts':5,'mins':8,'diff':'4',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M5C 2025 – úloha 14','zad':[
        'Vytváříme obrazce tvaru šestiúhelníku složené ze stejně velkých bílých a šedých rovnostranných trojúhelníků. První obrazec se skládá ze 3 bílých a 3 šedých trojúhelníků a každý další obrazec vznikne přidáním jednoho pásu trojúhelníků okolo předchozího obrazce (viz obrázek).',
        '14.1 Vypočtěte, kolik trojúhelníků (bílých i šedých dohromady) obsahuje poslední přidaný pás 4. obrazce.',
        '14.2 Vypočtěte, kolik šedých trojúhelníků obsahuje celý 6. obrazec.',
        '14.3 Určete, kolikátý obrazec má v posledním přidaném pásu 225 šedých trojúhelníků.'],
     'opts':None,'ln':3,'svg':SVG14,'fn':'obrazce-trojuhelniky.svg',
     'alt':'Tři obrazce tvaru šestiúhelníku z bílých a šedých rovnostranných trojúhelníků (1., 2. a 3. obrazec), dále pokračuje.',
     'cap':'1., 2. a 3. obrazec (schematický nákres)',
     'sol':['$n$-tý obrazec obsahuje celkem $6n^2$ trojúhelníků, z toho $3n^2$ šedých. Poslední přidaný pás obsahuje $6n^2-6(n-1)^2=6(2n-1)$ trojúhelníků, z toho $3(2n-1)$ šedých.',
            '14.1 Pás 4. obrazce: $6(2\\cdot 4-1)=6\\cdot 7=42$ trojúhelníků.',
            '14.2 Šedých v celém 6. obrazci: $3\\cdot 6^2=108$.',
            '14.3 Ze $3(2n-1)=225$ plyne $2n-1=75$, $n=38$. Jde o 38. obrazec.'],
     'ans':'14.1: $42$ trojúhelníků; 14.2: $108$ šedých trojúhelníků; 14.3: ve 38. obrazci','pts':4,'mins':6,'diff':'3',
     'codes':B+['posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PCD25C0T03'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5C-2025')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
