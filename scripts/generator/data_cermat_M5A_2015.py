# -*- coding: utf-8 -*-
# CERMAT – přijímací zkoušky 2015 (pilotní ročník), MATEMATIKA 5 (osmileté obory, 5. ročník).
# Kód testu: M5PZD15C0T01. 16 úloh, celkem 50 bodů, 60 minut.
# Zdroj odpovědí: klíč správných řešení (KSR) + záznamový arch (VZA).

# ---- SVG obrázky (bez ' a \) ----

def _svg2():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 260" font-family="sans-serif">']
    def circ(cx, cy, txt):
        s.append(f'<circle cx="{cx}" cy="{cy}" r="27" fill="#fff" stroke="#777" stroke-width="2"/>')
        if txt:
            s.append(f'<text x="{cx}" y="{cy+7}" font-size="19" font-weight="bold" text-anchor="middle">{txt}</text>')
    def box(cx, cy, sign, txt):
        s.append(f'<text x="{cx-24}" y="{cy+8}" font-size="20" text-anchor="middle">{sign}</text>')
        s.append(f'<rect x="{cx-15}" y="{cy-17}" width="31" height="34" fill="#fff" stroke="#222" stroke-width="2"/>')
        if txt:
            s.append(f'<text x="{cx}" y="{cy+8}" font-size="19" font-weight="bold" text-anchor="middle">{txt}</text>')
    def arrow(x1, x2, y):
        s.append(f'<path d="M {x1} {y} Q {(x1+x2)//2} {y-20} {x2} {y}" fill="none" stroke="#777" stroke-width="2"/>')
        s.append(f'<polygon points="{x2},{y} {x2-14},{y-9} {x2-6},{y+3}" fill="#777"/>')
    s.append('<text x="8" y="16" font-size="13">Vzor:</text>')
    arrow(102, 208, 72); arrow(272, 378, 72)
    box(158, 34, "+", "4"); box(328, 34, "&#8722;", "3")
    circ(70, 82, "6"); circ(240, 82, "10"); circ(410, 82, "7")
    s.append('<text x="8" y="150" font-size="13">Úloha:</text>')
    arrow(102, 208, 206); arrow(272, 378, 206)
    box(158, 168, "+", ""); box(300, 168, "+", ""); box(366, 168, "+", "")
    circ(70, 216, ""); circ(240, 216, "45"); circ(410, 216, "77")
    s.append('</svg>')
    return "".join(s)
SVG2 = _svg2()

def _svg4():
    cols = [70, 108, 146, 184]
    r1 = ["7", "0", "8", "&#8727;"]; r2 = ["&#8727;", "2", "&#8727;", "8"]; r3 = ["1", "&#8727;", "1", "6"]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 150" font-family="serif">']
    for row, y in ((r1, 40), (r2, 82), (r3, 130)):
        for c, t in zip(cols, row):
            s.append(f'<text x="{c}" y="{y}" font-size="26" text-anchor="middle">{t}</text>')
    s.append('<text x="34" y="82" font-size="26" text-anchor="middle">&#8722;</text>')
    s.append('<line x1="26" y1="96" x2="200" y2="96" stroke="#000" stroke-width="2"/>')
    s.append('</svg>')
    return "".join(s)
SVG4 = _svg4()

SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 320" font-family="sans-serif">
<rect x="6" y="6" width="458" height="308" fill="none" stroke="#ccc"/>
<line x1="60" y1="52" x2="420" y2="182" stroke="#000" stroke-width="2"/>
<text x="428" y="196" font-size="16" font-style="italic">q</text>
<line x1="94" y1="54" x2="102" y2="76" stroke="#000" stroke-width="2"/>
<text x="82" y="90" font-size="16" font-style="italic">X</text>
<text x="222" y="272" font-size="18" text-anchor="middle" font-weight="bold">&#215;</text>
<text x="204" y="278" font-size="16" font-style="italic">L</text>
</svg>"""

SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 200" font-family="sans-serif">
<polygon points="32,95 160,26 434,95 160,164" fill="none" stroke="#000" stroke-width="2"/>
<line x1="160" y1="26" x2="160" y2="164" stroke="#000" stroke-width="2" stroke-dasharray="8 6"/>
<text x="16" y="100" font-size="16" font-style="italic">K</text>
<text x="154" y="18" font-size="16" font-style="italic">N</text>
<text x="154" y="184" font-size="16" font-style="italic">L</text>
<text x="442" y="100" font-size="16" font-style="italic">M</text>
</svg>"""

def _svg10():
    c = 52; ox, oy = 45, 32
    X = lambda i: ox + c*i
    Y = lambda j: oy + c*j          # j = 0 nahoře (řádek D-C), j = 2 dole (řádek A-B)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 180" font-family="sans-serif">']
    s.append(f'<polygon points="{X(0)},{Y(2)} {X(2)},{Y(2)} {X(0)},{Y(0)}" fill="#b9b9b9"/>')
    s.append(f'<polygon points="{X(2)},{Y(2)} {X(5)},{Y(2)} {X(5)},{Y(1)}" fill="#b9b9b9"/>')
    d = []
    for i in range(6): d.append(f'M {X(i)} {Y(0)} V {Y(2)}')
    for j in range(3): d.append(f'M {X(0)} {Y(j)} H {X(5)}')
    s.append('<path d="' + " ".join(d) + '" fill="none" stroke="#444" stroke-width="1"/>')
    s.append(f'<rect x="{X(0)}" y="{Y(0)}" width="{5*c}" height="{2*c}" fill="none" stroke="#000" stroke-width="2.5"/>')
    s.append(f'<path d="M {X(0)} {Y(0)} L {X(2)} {Y(2)} L {X(5)} {Y(1)}" fill="none" stroke="#000" stroke-width="2.5"/>')
    for t, x, y in (("D", X(0)-14, Y(0)-8), ("C", X(5)+4, Y(0)-8), ("A", X(0)-14, Y(2)+22),
                    ("B", X(5)-2, Y(2)+22), ("E", X(2)-4, Y(2)+22), ("F", X(5)+8, Y(1)+5)):
        s.append(f'<text x="{x}" y="{y}" font-size="15" font-style="italic">{t}</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _svg10()

def _svg12():
    x0, y0, u = 62, 296, 11.6      # u = px na 1 dítě
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 360" font-family="sans-serif">']
    s.append('<text x="250" y="20" font-size="14" font-weight="bold" text-anchor="middle">Počty chlapců a dívek v 5. třídách</text>')
    g = []
    for v in range(0, 21, 2):
        y = round(y0 - v*u, 1)
        g.append(f'M {x0} {y} H 430')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="12" text-anchor="end">{v}</text>')
    s.append('<path d="' + " ".join(g) + '" fill="none" stroke="#bbb" stroke-width="1"/>')
    s.append(f'<path d="M {x0} 60 V {y0} H 430" fill="none" stroke="#000" stroke-width="1.5"/>')
    data = [("třída 5. A", 12, 14), ("třída 5. B", 18, 12), ("třída 5. C", 16, None)]
    bx = x0 + 22
    for name, ch, di in data:
        s.append(f'<rect x="{bx}" y="{round(y0-ch*u,1)}" width="44" height="{round(ch*u,1)}" fill="#fff" stroke="#000" stroke-width="2"/>')
        if di is None:
            s.append(f'<rect x="{bx+48}" y="{round(y0-20*u,1)}" width="44" height="{round(20*u,1)}" fill="#ececec" stroke="#999" stroke-width="1.5" stroke-dasharray="5 4"/>')
            s.append(f'<text x="{bx+70}" y="{round(y0-11*u,1)}" font-size="24" text-anchor="middle" font-weight="bold">?</text>')
        else:
            s.append(f'<rect x="{bx+48}" y="{round(y0-di*u,1)}" width="44" height="{round(di*u,1)}" fill="#555" stroke="#000" stroke-width="1.5"/>')
        s.append(f'<text x="{bx+46}" y="{y0+20}" font-size="12" text-anchor="middle">{name}</text>')
        bx += 122
    s.append('<rect x="440" y="150" width="15" height="15" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="461" y="163" font-size="12">chlapci</text>')
    s.append('<rect x="440" y="174" width="15" height="15" fill="#555" stroke="#000" stroke-width="1.5"/><text x="461" y="187" font-size="12">dívky</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _svg12()

def _svg_kostky():
    # kabinetní projekce: X vpravo (+56,0), Y dozadu (+28,-20), Z nahoru (0,-56)
    ox, oy = 26, 258
    P = lambda x, y, z: (round(ox + 56*x + 28*y, 1), round(oy - 20*y - 56*z, 1))
    cubes = [(0,1,0), (1,1,0), (0,1,1), (0,1,2), (0,0,0)]   # pořadí vykreslení: zezadu dopředu
    occ = set(cubes)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 290" font-family="sans-serif">']
    def face(pts, label):
        p = " ".join(f'{a},{b}' for a, b in pts)
        s.append(f'<polygon points="{p}" fill="#fff" stroke="#000" stroke-width="2.5"/>')
        cx = round(sum(a for a, b in pts)/4, 1); cy = round(sum(b for a, b in pts)/4, 1)
        s.append(f'<text x="{cx}" y="{cy+7}" font-size="20" font-weight="bold" text-anchor="middle">{label}</text>')
    for (x, y, z) in cubes:
        if (x, y, z+1) not in occ:      # horní stěna: 1
            face([P(x,y,z+1), P(x+1,y,z+1), P(x+1,y+1,z+1), P(x,y+1,z+1)], "1")
        if (x, y-1, z) not in occ:      # přední stěna: 5
            face([P(x,y,z), P(x+1,y,z), P(x+1,y,z+1), P(x,y,z+1)], "5")
        if (x+1, y, z) not in occ:      # pravá stěna: 3
            face([P(x+1,y,z), P(x+1,y+1,z), P(x+1,y+1,z+1), P(x+1,y,z+1)], "3")
    s.append('</svg>')
    return "".join(s)
SVG13 = _svg_kostky()

def _svg15():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 140" font-family="sans-serif">']
    for k, ox in enumerate((60, 220, 380)):
        oy = 44
        s.append(f'<text x="{ox-52}" y="{oy+26}" font-size="14">15.{k+1}</text>')
        for j, row in enumerate((("6", ""), ("3", "4"))):
            for i, t in enumerate(row):
                x = ox + 44*i; y = oy + 38*j
                s.append(f'<rect x="{x}" y="{y}" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/>')
                if t:
                    s.append(f'<text x="{x+22}" y="{y+27}" font-size="19" font-weight="bold" text-anchor="middle">{t}</text>')
    s.append('</svg>')
    return "".join(s)
SVG15 = _svg15()

def _svg16():
    c, oy, N = 38, 26, 6
    W1 = [(0.2,0.35),(5.05,0.35),(5.05,2.45),(4.2,2.5),(3.35,2.35),(3.2,1.85),(1.95,1.9),(1.6,2.85),(0.9,2.9),(0.2,2.4)]
    W2 = [(1.22,5.68),(2.5,5.85),(3.8,5.88),(4.75,5.78),(4.92,5.45),(4.92,4.85),(5.05,4.2),(5.25,3.4),(5.2,2.8),
          (4.9,2.35),(3.6,2.2),(3.5,2.9),(3.7,3.6),(3.9,4.2),(3.5,4.75),(2.6,5.3)]
    W3 = [(5.1,5.95),(5.5,5.95),(5.85,5.4),(5.9,4.6),(5.6,4.05),(5.1,3.85),(4.75,4.05),(4.9,4.45),(5.3,4.5),
          (5.45,4.9),(5.3,5.4),(5.1,5.6)]
    MARK = [(0,0),(0,3),(2,3),(2,2),(3,2),(3,4),(2,4),(2,5),(1,5),(1,6),(5,6),(5,5)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 570 310" font-family="sans-serif">']
    for k, ox in enumerate((26, 300)):
        X = lambda a: round(ox + c*a, 1)
        Y = lambda b: round(oy + c*(N-b), 1)
        for poly in (W1, W2, W3):
            p = " ".join(f'{X(a)},{Y(b)}' for a, b in poly)
            s.append(f'<polygon points="{p}" fill="#b9b9b9"/>')
        d = []
        for i in range(N+1): d.append(f'M {X(i)} {Y(0)} V {Y(N)}')
        for j in range(N+1): d.append(f'M {X(0)} {Y(j)} H {X(N)}')
        s.append('<path d="' + " ".join(d) + '" fill="none" stroke="#000" stroke-width="1.2"/>')
        if k == 0:
            d2 = "M " + " L ".join(f'{X(a)} {Y(b)}' for a, b in MARK)
            s.append(f'<path d="{d2}" fill="none" stroke="#000" stroke-width="4" stroke-linejoin="round"/>')
        s.append(f'<circle cx="{X(0)}" cy="{Y(0)}" r="4.5" fill="#000"/><text x="{X(0)-14}" y="{Y(0)+18}" font-size="14" font-style="italic">S</text>')
        s.append(f'<circle cx="{X(5)}" cy="{Y(5)}" r="4.5" fill="#000"/><text x="{X(5)-16}" y="{Y(5)-6}" font-size="14" font-style="italic">C</text>')
    s.append('<text x="126" y="304" font-size="12" text-anchor="middle">vyznačená cesta (1 800 m)</text>')
    s.append('<text x="400" y="304" font-size="12" text-anchor="middle">síť pro vlastní zákres</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _svg16()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 v taxonomii není

_KOSTKY = ('Na každé stěně hrací kostky je napsáno jedno z čísel 1, 2, 3, 4, 5 nebo 6. Součet čísel na protějších '
           'stěnách hrací kostky je vždy 7, tedy proti číslu 1 je 6, proti 3 je 4 a proti 5 je 2.')
_KOSTKY2 = ('Milan postavil z pěti hracích kostek stavbu (viz obrázek). Všechny kostky natočil stejně, a to tak, '
            'že nahoře je číslo 1, vpředu 5 a vpravo 3.')
_ALTK = 'Stavba z pěti stejných hracích kostek: sloupec tří kostek vzadu vlevo, jedna kostka vpředu a jedna vpravo.'

PROBLEMS = [
    {'name':'CERMAT M5A 2015 – úloha 1','zad':['Vypočtěte: $65-5\\cdot(14-6:2)=$'],'opts':None,'ln':2,
     'sol':['Nejdříve závorka: $14-6:2=14-3=11$.','Potom $65-5\\cdot 11=65-55=10$.'],
     'ans':'$10$','pts':2,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 2','zad':[
        'Výpočty se provádějí podle vzoru: z čísla v kroužku vznikne další číslo v kroužku tak, že se k němu přičte (nebo se od něj odečte) číslo ve čtverečku. Ve vzoru je $6+4=10$ a $10-3=7$.',
        'Neznámá čísla ve všech čtvercích musí být stejná.',
        'Vypočtěte chybějící číslo v kroužku.'],
     'opts':None,'ln':2,'svg':SVG2,'fn':'schema-kruzky.svg',
     'alt':'Vzor 6 plus 4 rovná se 10, 10 minus 3 rovná se 7; úloha: prázdný kroužek, plus čtvereček, 45, plus čtvereček plus čtvereček, 77.',
     'cap':'Vzor a schéma úlohy',
     'sol':['Ze druhého kroužku do třetího se dvakrát přičítá totéž neznámé číslo $x$: $45+2x=77$, tedy $2x=32$ a $x=16$.',
            'Z prvního kroužku do druhého se přičítá stejné číslo, hledané číslo je proto $45-16=29$.'],
     'ans':'$29$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 3','zad':[
        'V rámečku je trojciferné číslo, jehož první dvě číslice jsou 3 a 7 a poslední číslice chybí.',
        'Doplňte u čísla v rámečku poslední číslici tak, aby dělení bylo beze zbytku, a vypočtěte podíl.',
        'Do záznamového archu přepište celý zápis výpočtu (dělenec, dělitel i podíl).'],
     'opts':None,'ln':2,
     'sol':['Hledáme násobek osmi mezi 370 a 379. Platí $8\\cdot 46=368$ a $8\\cdot 47=376$, další násobek $8\\cdot 48=384$ je už větší než 379.',
            'Jediná možnost je tedy $376:8=47$.'],
     'ans':'$376:8=47$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 4','zad':[
        'Nahraďte každou hvězdičku takovou číslicí, aby byl písemný výpočet bez chyby (viz obrázek).',
        'Do záznamového archu přepište celý zápis výpočtu (menšenec, menšitel i rozdíl).'],
     'opts':None,'ln':3,'svg':SVG4,'fn':'pisemne-odcitani.svg',
     'alt':'Písemné odčítání pod sebou: menšenec 7 0 8 hvězdička, menšitel hvězdička 2 hvězdička 8, rozdíl 1 hvězdička 1 6.',
     'cap':'Písemné odčítání s chybějícími číslicemi',
     'sol':['Jednotky: číslice v jednotkách menšence po výpůjčce dává $14-8=6$, tedy v jednotkách menšence je 4.',
            'Desítky: $8-\\square-1=1$, tedy v desítkách menšitele je 6. Stovky: $0-2$ vyžaduje výpůjčku, $10-2=8$, v rozdílu jsou tedy stovky 8.',
            'Tisíce: $7-\\square-1=1$, v tisících menšitele je 5. Celkem $7\\,084-5\\,268=1\\,816$.'],
     'ans':'$7\\,084-5\\,268=1\\,816$','pts':3,'mins':4,'diff':'3',
     'codes':B+['aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 5','zad':[
        'Ve škole se musí denně uklidit 12 tříd. Pan školník zvládne uklidit první polovinu všech tříd za 1 hodinu a 45 minut.',
        'Někdy mu s úklidem pomáhají ještě dva pomocníci. Úklid kterékoli třídy trvá školníkovi i každému pomocníkovi stejně dlouhou dobu.',
        '5.1 Vypočtěte, jak dlouho trvá celý úklid, jestliže i druhou polovinu tříd uklízí pan školník sám.',
        '5.2 Vypočtěte, jak dlouho trvá celý úklid, jestliže druhou polovinu tříd uklízí pan školník společně s oběma pomocníky.'],
     'opts':None,'ln':3,
     'sol':['Polovina tříd je 6 tříd a školníkovi trvá $1$ h $45$ min $=105$ minut, jedna třída mu tedy trvá $105:6=17{,}5$ minuty.',
            '5.1 Druhá polovina trvá školníkovi stejně dlouho: $105+105=210$ minut, tj. $3$ hodiny $30$ minut.',
            '5.2 Druhou polovinu uklízejí tři lidé stejným tempem, každý z nich tedy uklidí 2 třídy za $2\\cdot 17{,}5=35$ minut. Celkem $105+35=140$ minut, tj. $2$ hodiny $20$ minut.'],
     'ans':'5.1: $3$ h $30$ min; 5.2: $2$ h $20$ min','pts':4,'mins':6,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5A 2015 – úloha 6','zad':[
        '5 balíčků sušenek stojí 80 Kč. 2 čokolády stojí stejně jako 3 balíčky sušenek. Hana si koupila 1 čokoládu a 2 balíčky sušenek.',
        '6.1 Vypočtěte, kolik korun stojí 2 čokolády.',
        '6.2 Vypočtěte, kolik korun Hana zaplatila.'],
     'opts':None,'ln':3,
     'sol':['Jeden balíček sušenek stojí $80:5=16$ Kč.',
            '6.1 Dvě čokolády stojí stejně jako tři balíčky, tedy $3\\cdot 16=48$ Kč.',
            '6.2 Jedna čokoláda stojí $48:2=24$ Kč, dva balíčky stojí $2\\cdot 16=32$ Kč. Hana zaplatila $24+32=56$ Kč.'],
     'ans':'6.1: $48$ Kč; 6.2: $56$ Kč','pts':4,'mins':5,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5A 2015 – úloha 7 (konstrukce)','zad':[
        'Na přímce $q$ leží bod $X$ a mimo ni bod $L$ (viz obrázek).',
        '7.1 Narýsujte přímku $p$, která prochází bodem $L$ a je kolmá k přímce $q$. Průsečík přímek $p$, $q$ označte $M$.',
        '7.2 Na polopřímce $MX$ sestrojte bod $N$ tak, aby úsečky $LM$ a $MN$ byly stejně dlouhé.',
        '7.3 Sestrojte chybějící vrchol $O$ čtverce $LMNO$ a čtverec narýsujte.',
        '7.4 Uvnitř čtverce $LMNO$ sestrojte takový bod $K$, aby body $K$, $L$, $M$ tvořily vrcholy rovnostranného trojúhelníku. Trojúhelník $KLM$ narýsujte.'],
     'opts':None,'ln':0,'svg':SVG7,'fn':'primka-q-bod-L.svg',
     'alt':'Přímka q se zvýrazněným bodem X a bod L ležící mimo přímku q.',
     'cap':'Výchozí obrázek k úloze 7',
     'sol':['7.1 Z bodu $L$ spustíme kolmici na přímku $q$; její patou je bod $M$.',
            '7.2 Kružnicí se středem $M$ a poloměrem $|LM|$ protneme polopřímku $MX$ v bodě $N$, takže $|MN|=|LM|$.',
            '7.3 Protože $LM\\perp MN$ a $|LM|=|MN|$, je $LMNO$ čtverec. Vrchol $O$ je průsečíkem rovnoběžky s $MN$ vedené bodem $L$ a rovnoběžky s $LM$ vedené bodem $N$.',
            '7.4 Bod $K$ je ten průsečík kružnic se středy $L$ a $M$ a poloměrem $|LM|$, který leží uvnitř čtverce $LMNO$.'],
     'ans':'Konstrukce: $M$ je pata kolmice z $L$ na přímku $q$; $N$ leží na polopřímce $MX$ a $|MN|=|LM|$; $O$ doplňuje čtverec $LMNO$; $K$ je průsečík kružnic $(L;|LM|)$ a $(M;|LM|)$ uvnitř čtverce – viz obrázek v klíči.',
     'pts':6,'mins':11,'diff':'3',
     'codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 8','zad':[
        'Obrazec $KLMN$ je vytvořen z rovnostranného a rovnoramenného trojúhelníku (viz obrázek).',
        'Obvod rovnostranného trojúhelníku je 12 cm, obvod rovnoramenného trojúhelníku je dvojnásobný.',
        '8.1 Vypočtěte délku společné strany $LN$ obou trojúhelníků.',
        '8.2 Vypočtěte obvod celého obrazce $KLMN$.'],
     'opts':None,'ln':3,'svg':SVG8,'fn':'obrazec-KLMN.svg',
     'alt':'Obrazec KLMN: rovnostranný trojúhelník KLN vlevo a rovnoramenný trojúhelník LMN vpravo, společná strana LN je čárkovaná.',
     'cap':'Schematický nákres obrazce $KLMN$',
     'sol':['8.1 Rovnostranný trojúhelník $KLN$ má všechny strany stejně dlouhé, proto $|LN|=12:3=4$ cm.',
            '8.2 Rovnoramenný trojúhelník $LMN$ má obvod $2\\cdot 12=24$ cm a základnu $|LN|=4$ cm, tedy $|LM|=|MN|=(24-4):2=10$ cm.',
            'Obvod obrazce je $|KL|+|LM|+|MN|+|NK|=4+10+10+4=28$ cm.'],
     'ans':'8.1: $4$ cm; 8.2: $28$ cm','pts':3,'mins':5,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 9','zad':[
        'Rozhodněte o každém z následujících výpočtů (9.1–9.3), zda je proveden správně (A), či nikoli (N).',
        '9.1 $1$ kg $-$ $20$ g $=80$ g',
        '9.2 $5$ km $-$ $70$ m $=4\\,930$ m',
        '9.3 $14$ m $+$ $3$ cm $+$ $2$ mm $=1\\,432$ mm'],
     'opts':None,'ln':0,
     'sol':['9.1 $1$ kg $=1\\,000$ g, tedy $1\\,000-20=980$ g, nikoli 80 g. Výpočet je nesprávný.',
            '9.2 $5$ km $=5\\,000$ m, tedy $5\\,000-70=4\\,930$ m. Výpočet je správný.',
            '9.3 $14$ m $=14\\,000$ mm a $3$ cm $=30$ mm, tedy $14\\,000+30+2=14\\,032$ mm, nikoli $1\\,432$ mm. Výpočet je nesprávný.'],
     'ans':'9.1: Ne; 9.2: Ano; 9.3: Ne','pts':3,'mins':4,'diff':'2',
     'codes':B+['aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 10','zad':[
        'Ve čtvercové síti je zakreslen obdélník $ABCD$ a dva trojúhelníky $AED$ a $EBF$. (Body $A$, $B$, $C$, $D$, $E$, $F$ jsou mřížové body.)',
        'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).',
        '10.1 Obsah obdélníku $ABCD$ je pětkrát větší než obsah trojúhelníku $AED$.',
        '10.2 Obsah trojúhelníku $AED$ je větší než obsah trojúhelníku $EBF$.',
        '10.3 Obvod trojúhelníku $AED$ je větší než obvod trojúhelníku $EBF$.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'sit-ABCD.svg',
     'alt':'Čtvercová síť 5 krát 2 s obdélníkem ABCD, šedým trojúhelníkem AED vlevo a šedým trojúhelníkem EBF vpravo.',
     'cap':'Obdélník $ABCD$ a trojúhelníky $AED$ a $EBF$ ve čtvercové síti',
     'sol':['Stranu čtverečku sítě označme 1. Obdélník $ABCD$ má rozměry $5\\times 2$, jeho obsah je 10.',
            '10.1 Trojúhelník $AED$ má odvěsny $|AE|=2$ a $|AD|=2$, obsah je $2\\cdot 2:2=2$. Protože $10=5\\cdot 2$, tvrzení platí (A).',
            '10.2 Trojúhelník $EBF$ má odvěsny $|EB|=3$ a $|BF|=1$, obsah je $3\\cdot 1:2=1{,}5$. Platí $2>1{,}5$, tvrzení platí (A).',
            '10.3 Obvod $AED$ je $2+2+|ED|$, kde $|ED|$ je přepona nad odvěsnami 2 a 2, tedy asi $2{,}8$; obvod je asi $6{,}8$. Obvod $EBF$ je $3+1+|EF|$, kde $|EF|$ je přepona nad odvěsnami 3 a 1, tedy asi $3{,}2$; obvod je asi $7{,}2$. Obvod $AED$ je menší, tvrzení neplatí (N).'],
     'ans':'10.1: Ano; 10.2: Ano; 10.3: Ne','pts':3,'mins':6,'diff':'3',
     'codes':B+['planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 11','zad':[
        'Petr má stejný počet korunových, dvoukorunových a pětikorunových mincí. (Jiné mince Petr nemá.) Mince představují částku 96 Kč.',
        'Kolik mincí má Petr?'],
     'opts':['A) 18','B) 24','C) 32','D) 36','E) jiný počet'],'ln':0,
     'sol':['Jedna trojice mincí (1 Kč, 2 Kč a 5 Kč) má hodnotu $1+2+5=8$ Kč.',
            'Takových trojic je $96:8=12$, od každého druhu má tedy Petr 12 mincí a celkem $3\\cdot 12=36$ mincí.'],
     'ans':'D) 36','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5A 2015 – úloha 12','zad':[
        'V grafu je znázorněn počet dětí ze všech 5. tříd školy kromě počtu dívek třídy 5. C.',
        'Ve třídách 5. A a 5. B je dohromady dvakrát více dětí než ve třídě 5. C.',
        'Kolik dívek je ve třídě 5. C?'],
     'opts':['A) méně než 12','B) 12','C) 13','D) 14','E) více než 14'],'ln':0,'svg':SVG12,'fn':'graf-tridy.svg',
     'alt':'Sloupcový graf: 5. A chlapci 12 a dívky 14, 5. B chlapci 18 a dívky 12, 5. C chlapci 16 a dívky neznámé (otazník).',
     'cap':'Počty chlapců a dívek v 5. třídách',
     'sol':['Ve třídě 5. A je $12+14=26$ dětí, ve třídě 5. B je $18+12=30$ dětí, dohromady tedy $26+30=56$ dětí.',
            'Ve třídě 5. C je proto $56:2=28$ dětí. Chlapců je 16, dívek je tedy $28-16=12$.'],
     'ans':'B) 12','pts':2,'mins':4,'diff':'3',
     'codes':B+['statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M5A 2015 – úloha 13','zad':[
        _KOSTKY, _KOSTKY2,
        'Kolik čísel je napsáno na povrchu stojící stavby? (Nepatří mezi ně čísla na spodní ploše stavby.)'],
     'opts':['A) 16','B) 17','C) 19','D) 21','E) více než 21'],'ln':0,'svg':SVG13,'fn':'stavba-kostky.svg',
     'alt':_ALTK,'cap':'Schematický nákres stavby z pěti hracích kostek',
     'sol':['Pět kostek má dohromady $5\\cdot 6=30$ stěn.',
            'Na podložce stojí 3 kostky, takže dole je 3 stěn. Kostky se navzájem dotýkají na 4 místech a každý dotyk skryje 2 stěny, tedy $2\\cdot 4=8$ stěn.',
            'Na povrchu stavby je proto $30-3-8=19$ čísel.'],
     'ans':'C) 19','pts':2,'mins':4,'diff':'3',
     'codes':B+['stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 14','zad':[
        _KOSTKY, _KOSTKY2,
        'Jaký je součet všech čísel na povrchu stojící stavby? (Nepřičítají se čísla na spodní ploše stavby.)'],
     'opts':['A) 50','B) 59','C) 63','D) 65','E) jiný počet'],'ln':0,'svg':SVG13,'fn':'stavba-kostky.svg',
     'alt':_ALTK,'cap':'Schematický nákres stavby z pěti hracích kostek',
     'sol':['Součet čísel na všech stěnách jedné kostky je $1+2+3+4+5+6=21$, u pěti kostek tedy $5\\cdot 21=105$.',
            'Všechny kostky jsou natočeny stejně, dole je proto u každé z 3 kostek stojících na podložce číslo 6, celkem $3\\cdot 6=18$.',
            'V každém ze 4 dotyků se skryjí dvě protilehlé stěny, jejichž součet je 7, celkem tedy $4\\cdot 7=28$.',
            'Součet čísel na povrchu je $105-18-28=59$.'],
     'ans':'B) 59','pts':2,'mins':5,'diff':'4',
     'codes':B+['stereometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 15','zad':[
        'V každé z tabulek 15.1–15.3 je v prvním řádku vlevo číslo 6 a vpravo prázdné pole, ve druhém řádku jsou čísla 3 a 4 (viz obrázek).',
        'Doplňte do prázdného pole každé tabulky (15.1–15.3) takové číslo (A–F), aby platilo:',
        '15.1 Součin čísel v prvním řádku tabulky je dvojnásobkem součinu čísel ve druhém řádku.',
        '15.2 Součin čísel v prvním řádku tabulky je o 12 menší než součin čísel ve druhém řádku.',
        '15.3 Součin čísel v prvním řádku tabulky je o 6 větší než součin čísel ve druhém řádku.'],
     'opts':['A) 0','B) 1','C) 2','D) 3','E) 4','F) jiné číslo'],'ln':0,'svg':SVG15,'fn':'tabulky.svg',
     'alt':'Tři stejné tabulky o dvou řádcích a dvou sloupcích: v prvním řádku 6 a prázdné pole, ve druhém řádku 3 a 4.',
     'cap':'Tabulky k úlohám 15.1–15.3',
     'sol':['Součin čísel ve druhém řádku je $3\\cdot 4=12$. Hledané číslo označme $x$, součin v prvním řádku je pak $6x$.',
            '15.1 $6x=2\\cdot 12=24$, tedy $x=4$ (možnost E).',
            '15.2 $6x=12-12=0$, tedy $x=0$ (možnost A).',
            '15.3 $6x=12+6=18$, tedy $x=3$ (možnost D).'],
     'ans':'15.1: E ($4$); 15.2: A ($0$); 15.3: D ($3$)','pts':6,'mins':7,'diff':'3',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M5A 2015 – úloha 16','zad':[
        'Na cestě od startu $S$ do cíle $C$ kolem vodní plochy je možné postupovat pouze po čarách čtvercové sítě.',
        'Vyznačená cesta z $S$ do $C$ kolem vodní plochy měří 1 800 metrů, ale existují i kratší cesty.',
        '16.1 Zakreslete jednu cestu, která vede kolem vodní plochy z $S$ do $C$ a má nejkratší možnou délku.',
        '16.2 Vypočtěte nejkratší možnou délku cesty z $S$ do $C$ kolem vodní plochy.',
        '16.3 Určete počet všech různých cest z $S$ do $C$ kolem vodní plochy, které mají nejkratší možnou délku.'],
     'opts':None,'ln':3,'svg':SVG16,'fn':'mapa-cesta.svg',
     'alt':'Čtvercová síť 6 krát 6 s šedou vodní plochou, startem S v levém dolním rohu a cílem C; vlevo je tučně vyznačena cesta dlouhá 1 800 metrů.',
     'cap':'Schematický nákres sítě s vodní plochou (vyznačená cesta a prázdná síť)',
     'sol':['Vyznačená cesta se skládá z 18 stran čtverečků a měří 1 800 m, jedna strana čtverečku tedy měří $1\\,800:18=100$ m.',
            '16.1 a 16.2 Vodní plocha uzavírá cestu vpravo i dole, proto je nutné jít nejprve nahoru po levém okraji sítě, potom případně o jeden krok doprava a dále nahoru k hornímu okraji, po horním okraji doprava až nad cíl a nakonec jeden krok dolů do $C$. Taková cesta má 12 stran čtverečků, tedy $12\\cdot 100=1\\,200$ m.',
            '16.3 Odbočit doprava lze až ve třetím, čtvrtém nebo pátém mřížovém bodě levého okraje, případně až v horním rohu sítě. Nejkratších cest jsou proto 4.'],
     'ans':'16.1: viz obrázek (jedna z nejkratších cest); 16.2: $1\\,200$ m; 16.3: 4 cesty','pts':4,'mins':8,'diff':'4',
     'codes':B+['planimetrie','argumentace','slovni','bez-kalkulacky','bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PZD15C0T01'
    gen.YEAR = 2015

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
    tot_pts = sum(p['pts'] for p in PROBLEMS)
    if tot_pts != 50: errors.append(f'Součet bodů {tot_pts} != 50')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, bodů celkem:', tot_pts)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2015')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
