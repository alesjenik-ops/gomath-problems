# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2026, MATEMATIKA 5D, 2. náhradní termín.
# Kód testu: M5PDD26C0T04. 14 úloh (po rozdělení izolovaných poduúloh 17 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR) + vyplněný záznamový arch (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 4: čtvercová síť s čtyřúhelníkem (obsah 18 cm²) a sedmiúhelníkem (obsah 16 cm²) – schematicky
def _sit4():
    cell = 28; ox, oy = 20, 20; W, H = 13, 8
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+W*cell} {oy*2+H*cell}" font-family="sans-serif">']
    for i in range(W+1):
        s.append(f'<line x1="{ox+i*cell}" y1="{oy}" x2="{ox+i*cell}" y2="{oy+H*cell}" stroke="#c4c4c4" stroke-width="1"/>')
    for j in range(H+1):
        s.append(f'<line x1="{ox}" y1="{oy+j*cell}" x2="{ox+W*cell}" y2="{oy+j*cell}" stroke="#c4c4c4" stroke-width="1"/>')
    quad = [(1,1),(6,2),(6,7),(2,5)]
    p1 = " ".join(f"{ox+x*cell},{oy+y*cell}" for x,y in quad)
    s.append(f'<polygon points="{p1}" fill="#c9c9c9" stroke="#000" stroke-width="2"/>')
    hepta = [(8,2),(12,1),(11,3),(13,4),(11,5),(12,7),(8,6)]
    p2 = " ".join(f"{ox+x*cell},{oy+y*cell}" for x,y in hepta)
    s.append(f'<polygon points="{p2}" fill="#c9c9c9" stroke="#000" stroke-width="2"/>')
    s.append('</svg>')
    return "".join(s)
SVG4 = _sit4()

# úloha 5: obdélník ABCD z bílé (vlevo) a šedé (vpravo) části
SVG5 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 220" font-family="sans-serif">
<rect x="40" y="35" width="280" height="150" fill="#fff" stroke="#000" stroke-width="2"/>
<rect x="145" y="35" width="175" height="150" fill="#b9b9b9" stroke="#000" stroke-width="2"/>
<line x1="145" y1="35" x2="145" y2="185" stroke="#000" stroke-width="2"/>
<text x="30" y="30" font-size="16" font-style="italic">D</text>
<text x="322" y="30" font-size="16" font-style="italic">C</text>
<text x="30" y="205" font-size="16" font-style="italic">A</text>
<text x="322" y="205" font-size="16" font-style="italic">B</text>
</svg>"""

# úloha 7.1: body A, B, D
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 600" font-family="sans-serif">
<rect x="6" y="6" width="688" height="588" fill="none" stroke="#ccc"/>
<text x="60" y="40" font-size="15">V rovině leží body A, B, D.</text>
<text x="600" y="250" font-size="16" font-style="italic">D</text><text x="597" y="270" font-size="15">×</text>
<text x="336" y="345" font-size="16" font-style="italic">A</text><text x="333" y="365" font-size="15">×</text>
<text x="268" y="562" font-size="16" font-style="italic">B</text><text x="266" y="542" font-size="15">×</text>
</svg>"""

# úloha 7.2: bod L a přímka p
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 420" font-family="sans-serif">
<rect x="6" y="6" width="668" height="408" fill="none" stroke="#ccc"/>
<text x="60" y="40" font-size="15">V rovině leží bod L a přímka p.</text>
<line x1="60" y1="300" x2="630" y2="235" stroke="#000" stroke-width="2"/>
<text x="640" y="235" font-size="16" font-style="italic">p</text>
<text x="418" y="425" font-size="15"></text>
<text x="416" y="408" font-size="15">×</text><text x="416" y="425" font-size="16" font-style="italic">L</text>
</svg>"""

# úloha 8: sloupcový graf výšek (13 let 163, 15 let 169, 16 let 171)
def _graf8():
    x0, y0 = 70, 300; top = 40
    vmin, vmax = 158, 174
    scale = (y0 - top) / (vmax - vmin)
    def yv(v): return y0 - (v - vmin) * scale
    cats = [('12 let', None), ('13 let', 163), ('14 let', None), ('15 let', 169), ('16 let', 171), ('17 let', None)]
    slot = 75; bw = 42
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 340" font-family="sans-serif">']
    for v in range(vmin, vmax+1, 2):
        y = yv(v)
        s.append(f'<line x1="{x0}" y1="{y:.1f}" x2="510" y2="{y:.1f}" stroke="#d0d0d0" stroke-width="1"/>')
        s.append(f'<text x="{x0-8}" y="{y+4:.1f}" font-size="11" text-anchor="end">{v}</text>')
    s.append(f'<line x1="{x0}" y1="{top}" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="510" y2="{y0}" stroke="#000"/>')
    s.append(f'<text x="26" y="180" font-size="12" text-anchor="middle" transform="rotate(-90 26 180)">Výška v cm</text>')
    x = x0 + (slot - bw) / 2 + 6
    for name, val in cats:
        cx = x + bw / 2
        if val is not None:
            h = y0 - yv(val)
            s.append(f'<rect x="{x:.1f}" y="{yv(val):.1f}" width="{bw}" height="{h:.1f}" fill="#a9a9a9" stroke="#000"/>')
        s.append(f'<text x="{cx:.1f}" y="{y0+18}" font-size="12" text-anchor="middle">{name}</text>')
        x += slot
    s.append('</svg>')
    return "".join(s)
SVG8 = _graf8()

# úloha 11: pět prostorových těles ze 6 krychliček – schematická poznámka
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 110" font-family="sans-serif">
<text x="280" y="45" font-size="13" text-anchor="middle">Pět těles A–E, každé ze 6 krychliček s jednou tečkou na každé stěně (viz testový sešit).</text>
<text x="280" y="75" font-size="11" text-anchor="middle" fill="#666">Prostorová tělesa nelze věrně přenést do SVG; posuzuje se podle originálu.</text>
</svg>"""

# úloha 13: vzor + tři diagramy (čtverec = součet kroužků, trojúhelník = rozdíl kroužků)
def _diag(cx, cy, sqv, topv, triv, botv, lbl):
    p = []
    sx, sy = cx-52, cy; tx, ty = cx, cy-40; rx, ry = cx+52, cy; bx, by = cx, cy+40
    p.append(f'<text x="{cx}" y="{cy-62}" font-size="12" text-anchor="middle">{lbl}</text>')
    p.append(f'<path d="M{sx},{sy} Q{cx-28},{cy-52} {tx},{ty}" fill="none" stroke="#000"/>')
    p.append(f'<path d="M{tx},{ty} Q{cx+28},{cy-52} {rx},{ry}" fill="none" stroke="#000"/>')
    p.append(f'<path d="M{rx},{ry} Q{cx+28},{cy+52} {bx},{by}" fill="none" stroke="#000"/>')
    p.append(f'<path d="M{bx},{by} Q{cx-28},{cy+52} {sx},{sy}" fill="none" stroke="#000"/>')
    p.append(f'<rect x="{sx-15}" y="{sy-15}" width="30" height="30" fill="#fff" stroke="#000"/>')
    p.append(f'<text x="{sx}" y="{sy+5}" font-size="13" text-anchor="middle">{sqv}</text>')
    p.append(f'<circle cx="{tx}" cy="{ty}" r="15" fill="#c9c9c9" stroke="#000"/>')
    p.append(f'<text x="{tx}" y="{ty+5}" font-size="13" text-anchor="middle">{topv}</text>')
    p.append(f'<polygon points="{rx-14},{ry-15} {rx+16},{ry} {rx-14},{ry+15}" fill="#fff" stroke="#000"/>')
    p.append(f'<text x="{rx-3}" y="{ry+5}" font-size="13" text-anchor="middle">{triv}</text>')
    p.append(f'<circle cx="{bx}" cy="{by}" r="15" fill="#c9c9c9" stroke="#000"/>')
    p.append(f'<text x="{bx}" y="{by+5}" font-size="13" text-anchor="middle">{botv}</text>')
    return "".join(p)
def _diagrams():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 660 180" font-family="sans-serif">']
    s.append(_diag(95, 95, '11', '9', '7', '2', 'VZOR'))
    s.append(_diag(255, 95, '23', '16', '?', '', '13.1'))
    s.append(_diag(415, 95, '16', '', '14', '?', '13.2'))
    s.append(_diag(575, 95, '5', '?', '5', '', '13.3'))
    s.append('</svg>')
    return "".join(s)
SVG13 = _diagrams()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté); kód r5 v taxonomii není

PROBLEMS = [
    {'name':'CERMAT M5D 2026 – úloha 1.1','zad':['Vypočtěte: $(8\\cdot 3+7\\cdot 4):2=$'],'opts':None,'ln':2,
     'sol':['$(8\\cdot 3+7\\cdot 4):2=(24+28):2=52:2=26$.'],'ans':'$26$','pts':1,'mins':1,'diff':'1',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 1.2','zad':['Vypočtěte: $300-(4+13\\cdot 4)+4=$'],'opts':None,'ln':2,
     'sol':['$300-(4+13\\cdot 4)+4=300-(4+52)+4=300-56+4=248$.'],'ans':'$248$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 1.3','zad':['Vypočtěte: $20\\cdot 210-6\\,020:20+5\\cdot 60=$'],'opts':None,'ln':2,
     'sol':['$20\\cdot 210-6\\,020:20+5\\cdot 60=4\\,200-301+300=4\\,199$.'],'ans':'$4\\,199$','pts':2,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 2','zad':[
        '2.1 Vypočtěte, o kolik centimetrů je jedna pětina metru delší než $80$ milimetrů.',
        '2.2 Pět stejných krabiček váží dohromady o $50$ g méně než závaží o hmotnosti $1$ kg. Vypočtěte v gramech hmotnost jedné krabičky.'],
     'opts':None,'ln':2,
     'sol':['2.1 Jedna pětina metru $=\\frac{100}{5}=20$ cm $=200$ mm; $80$ mm $=8$ cm. Rozdíl $20-8=12$ cm (tj. o $120$ mm).',
            '2.2 Pět krabiček váží $1\\,000-50=950$ g, jedna krabička $950:5=190$ g.'],
     'ans':'2.1: o $12$ cm; 2.2: $190$ g','pts':3,'mins':4,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 3','zad':[
        'V malé rodinné pekárně pečou vánočky tří velikostí – malé splétají ze $3$ pramenů těsta, střední ze $6$ pramenů a velké z $9$ pramenů. Každý pramen těsta váží $200$ g.',
        '3.1 Včera v pekárně upekli vánočky z $8\\,400$ g těsta. Z upečených vánoček byly $2$ velké, $2$ střední a zbývající byly malé. Určete, kolik vánoček včera v pekárně upekli.',
        '3.2 Na zítřek přijali v pekárně objednávku na $36$ vánoček, z nichž čtvrtina má být malých, třetina velkých a zbytek středních. Určete v kg hmotnost těsta na celou tuto objednávku.'],
     'opts':None,'ln':3,
     'sol':['3.1 Velká vánočka má $9\\cdot 200=1\\,800$ g, střední $6\\cdot 200=1\\,200$ g, malá $3\\cdot 200=600$ g. Na $2$ velké a $2$ střední padne $3\\,600+2\\,400=6\\,000$ g, zbývá $8\\,400-6\\,000=2\\,400$ g na malé, tj. $2\\,400:600=4$ malé. Celkem $2+2+4=8$ vánoček.',
            '3.2 Malých $36:4=9$, velkých $36:3=12$, středních $36-9-12=15$. Těsto: $9\\cdot 600+12\\cdot 1\\,800+15\\cdot 1\\,200=5\\,400+21\\,600+18\\,000=45\\,000$ g $=45$ kg.'],
     'ans':'3.1: $8$ vánoček; 3.2: $45$ kg','pts':4,'mins':6,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5D 2026 – úloha 4','zad':[
        'Na obrázku je ve čtvercové síti zakreslen čtyřúhelník a sedmiúhelník. Všechny vrcholy obou obrazců leží v mřížových bodech sítě. Každý čtvereček čtvercové sítě má stranu délky $1$ cm a obsah $1$ cm².',
        'Vypočtěte:',
        '4.1 v cm² obsah čtyřúhelníku,',
        '4.2 v cm² obsah sedmiúhelníku,',
        '4.3 v cm, o kolik se liší obvod čtyřúhelníku a obvod sedmiúhelníku.'],
     'opts':None,'ln':3,'svg':SVG4,'fn':'sit-obrazce.svg',
     'alt':'Čtvercová síť s šedým čtyřúhelníkem vlevo a šedým sedmiúhelníkem vpravo, vrcholy v mřížových bodech.',
     'cap':'Schematický nákres (obsahy dle klíče)',
     'sol':['4.1 Obsah čtyřúhelníku určíme z mřížky (rozkladem na části, popř. Pickovou větou): $18$ cm².',
            '4.2 Obsah sedmiúhelníku: $16$ cm².',
            '4.3 Obvody obou obrazců změřené v mřížce se liší o $4$ cm.'],
     'ans':'4.1: $18$ cm²; 4.2: $16$ cm²; 4.3: o $4$ cm','pts':5,'mins':7,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 5','zad':[
        'Obdélník $ABCD$ je složen z bílého a šedého obdélníku jako na obrázku. Obvod obdélníku $ABCD$ je $68$ cm a délka strany $BC$ je $10$ cm. Obvod šedého obdélníku je o $12$ cm větší než obvod bílého obdélníku.',
        'Vypočtěte v cm:',
        '5.1 délku strany $AB$ obdélníku $ABCD$,',
        '5.2 obvod šedého obdélníku.'],
     'opts':None,'ln':2,'svg':SVG5,'fn':'obdelnik-abcd.svg',
     'alt':'Obdélník ABCD rozdělený svislou úsečkou na bílou levou a šedou pravou část.',
     'cap':'Obdélník ABCD složený z bílého a šedého obdélníku',
     'sol':['5.1 Obvod $ABCD=2\\cdot(AB+BC)=68$, tedy $AB+10=34$ a $AB=24$ cm.',
            '5.2 Součet šířek bílé a šedé části je $24$ cm, oba obdélníky mají výšku $10$ cm. Rozdíl obvodů je $12$ cm, takže šedá část je o $6$ cm širší. Ze součtu $24$ a rozdílu $6$ vychází šedá šířka $15$ cm; obvod šedého obdélníku $=2\\cdot(15+10)=50$ cm.'],
     'ans':'5.1: $24$ cm; 5.2: $50$ cm','pts':3,'mins':5,'diff':'2',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 6','zad':[
        'Spolek daroval na školní akci velké a malé balíčky sušenek. Malý balíček obsahuje $6$ sušenek a velký balíček $10$ sušenek. Ve všech darovaných balíčcích bylo celkem $264$ sušenek.',
        '6.1 Dopoledne se na akci rozdalo $15$ balíčků sušenek. Velkých balíčků se dopoledne rozdalo o polovinu více než malých. Vypočtěte, kolik sušenek bylo v balíčcích, které zbyly na odpoledne.',
        '6.2 Všech darovaných balíčků bylo dohromady $32$. Vypočtěte, kolik z darovaných balíčků bylo velkých.'],
     'opts':None,'ln':3,
     'sol':['6.1 Dopoledne: malých $m$, velkých $1{,}5m$; $m+1{,}5m=15\\Rightarrow m=6$ malých a $9$ velkých. Rozdáno $6\\cdot 6+9\\cdot 10=126$ sušenek, na odpoledne zbývá $264-126=138$ sušenek.',
            '6.2 Balíčků je $32$ a sušenek $264$. Kdyby byly všechny malé, bylo by jen $32\\cdot 6=192$ sušenek; přebytek $264-192=72$ připadá na velké ($+4$ sušenky za každý velký balíček), tedy velkých $72:4=18$.'],
     'ans':'6.1: $138$ sušenek; 6.2: $18$ velkých balíčků','pts':4,'mins':6,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5D 2026 – úloha 7.1 (konstrukce)','zad':[
        'V rovině leží body $A$, $B$, $D$ (viz obrázek).',
        'Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$, jehož strany $AB$ a $AC$ mají stejnou délku. Body $B$, $D$ jsou vrcholy trojúhelníku $BCD$, jehož strany $BD$ a $CD$ mají stejnou délku. Úsečka $BC$ je společnou stranou obou trojúhelníků $ABC$ a $BCD$.',
        'Sestrojte vrchol $C$, označte ho písmenem a narýsujte trojúhelníky $ABC$ a $BCD$.'],
     'opts':None,'ln':0,'svg':SVG7_1,'fn':'body-abd.svg',
     'alt':'Tři body A, B a D v rovině.','cap':'Výchozí obrázek k úloze 7.1',
     'sol':['Vrchol $C$ má od $A$ stejnou vzdálenost jako $B$ (protože $|AC|=|AB|$) a od $D$ stejnou vzdálenost jako $B$ (protože $|CD|=|BD|$). Sestrojíme proto kružnici se středem $A$ a poloměrem $|AB|$ a kružnici se středem $D$ a poloměrem $|DB|$; jejich průsečík (podle obrázku vlevo nahoře) je vrchol $C$. Pak narýsujeme trojúhelníky $ABC$ a $BCD$.'],
     'ans':'Vrchol $C$ je průsečík kružnice se středem $A$ a poloměrem $|AB|$ s kružnicí se středem $D$ a poloměrem $|DB|$; poté narýsujeme trojúhelníky $ABC$ a $BCD$ (viz obrázek v klíči).',
     'pts':3,'mins':6,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 7.2 (konstrukce)','zad':[
        'V rovině leží bod $L$ a přímka $p$ (viz obrázek).',
        'Bod $L$ je vrchol čtverce $KLMN$. Přímka $p$ je kolmá ke straně $LM$ tohoto čtverce a protíná ji v bodě $P$. Bod $P$ je střed strany $LM$ čtverce $KLMN$.',
        'Sestrojte střed $P$, vrcholy $K$, $M$, $N$ čtverce $KLMN$, označte je písmeny a čtverec narýsujte. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG7_2,'fn':'bod-l-primka-p.svg',
     'alt':'Bod L a přímka p v rovině.','cap':'Výchozí obrázek k úloze 7.2',
     'sol':['Bod $P$ je pata kolmice spuštěné z bodu $L$ na přímku $p$ (přímka $LM$ je kolmá k $p$). Protože $P$ je střed strany $LM$, je bod $M$ obrazem bodu $L$ ve středové souměrnosti se středem $P$, tj. $|PM|=|PL|$ a $|LM|=2|LP|$. Nad úsečkou $LM$ pak sestrojíme čtverec $KLMN$; ten lze umístit na obě strany přímky $LM$, úloha má proto dvě řešení.'],
     'ans':'Dvě řešení: $P$ je pata kolmice z $L$ na $p$, $M$ obraz $L$ ve středové souměrnosti podle $P$ ($|LM|=2|LP|$), nad $LM$ čtverec $KLMN$ na obě strany (viz obrázek v klíči).',
     'pts':3,'mins':7,'diff':'4','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 8','zad':[
        'Pavle je $17$ let. Od $12$ let si vždy v den narozenin zapisuje svou výšku v celých cm. V grafu jsou zaznamenány tři z těchto zapsaných výšek, zbývající tři údaje chybí.',
        'Během tří let od $12$ do $15$ narozenin povyrostla Pavla každým rokem o stejný počet cm. Počet cm, o které Pavla vyrostla během dvou let od $13$ do $15$ narozenin, byl o polovinu větší než počet cm, o které vyrostla během dalších dvou let (od $15$ do $17$ narozenin).',
        'Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), nebo nepravdivé (N).',
        '8.1 V den 14. narozenin měřila Pavla $167$ cm.',
        '8.2 Od 16. do 17. narozenin vyrostla Pavla o $1$ cm.',
        '8.3 Od 12. do 17. narozenin vyrostla Pavla celkem o $12$ cm.'],
     'opts':None,'ln':0,'svg':SVG8,'fn':'graf-vyska.svg',
     'alt':'Sloupcový graf výšek Pavly ve 13 letech (163 cm), 15 letech (169 cm) a 16 letech (171 cm); ostatní sloupce chybí.',
     'cap':'Zaznamenané výšky Pavly (cm)',
     'sol':['Roční přírůstek od $12$ do $15$ let je stejný: z $163$ cm ve $13$ letech a $169$ cm v $15$ letech plyne $6$ cm za dva roky, tj. $3$ cm ročně. Proto $12$ let $=160$ cm, $14$ let $=166$ cm. Přírůstek $13\\to 15$ je $6$ cm, a to je o polovinu více než přírůstek $15\\to 17$, ten je tedy $4$ cm; $17$ let $=169+4=173$ cm.',
            '8.1 Ve $14$ letech měřila $166$ cm, ne $167$ cm → Ne.',
            '8.2 Od $16$ do $17$ let vyrostla $173-171=2$ cm, ne $1$ cm → Ne.',
            '8.3 Od $12$ do $17$ let vyrostla $173-160=13$ cm, ne $12$ cm → Ne.'],
     'ans':'8.1: Ne; 8.2: Ne; 8.3: Ne','pts':4,'mins':6,'diff':'3',
     'codes':B+['statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5D 2026 – úloha 9','zad':[
        'Lucka si myslela kladné číslo menší než $100$ a chlapci se ho snažili uhodnout. Jakub hádal číslo $15$, Lukáš číslo $87$ a oba svá čísla vyznačili na číselné ose. Lucka pak řekla: „Kdyby jeden z vás přičetl ke svému číslu $5$, druhý od svého čísla odečetl $3$ a oba výsledky jste pak sečetli, dostanete dvojnásobek mého čísla." Zvítězil chlapec, jehož číslo bylo na číselné ose blíže Lucčinu číslu.',
        'O kolik se vítězovo číslo lišilo od Lucčina čísla?'],
     'opts':['A) o $35$','B) o $34$','C) o $33$','D) o $32$','E) o $31$'],'ln':0,
     'sol':['Součet $(15+5)+(87-3)=20+84=104$ (stejně vyjde i při opačném přiřazení) je dvojnásobek Lucčina čísla, tedy Lucčino číslo je $52$. Vzdálenosti: $|52-15|=37$, $|87-52|=35$; blíže je Lukáš s číslem $87$. Vítězovo číslo se od Lucčina liší o $35$.'],
     'ans':'A) o $35$','pts':2,'mins':4,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 10','zad':[
        'Pozemek má tvar obdélníku, jehož jedna strana je o třetinu delší než sousední strana. Bára obešla celý pozemek po jeho obvodu stejně dlouhými kroky, přitom delší stranu pozemku přešla $120$ kroky.',
        'Kolika kroky obešla Bára celý pozemek po jeho obvodu?'],
     'opts':['A) $300$ kroky','B) $320$ kroky','C) $360$ kroky','D) $400$ kroky','E) $420$ kroky'],'ln':0,
     'sol':['Delší strana $=120$ kroků je o třetinu delší než kratší, takže kratší $=120\\cdot\\frac{3}{4}=90$ kroků. Obvod $=2\\cdot(120+90)=420$ kroků.'],
     'ans':'E) $420$ kroky','pts':2,'mins':3,'diff':'2',
     'codes':B+['planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5D 2026 – úloha 11','zad':[
        'Ze stejných krychliček, které mají na každé své stěně po jedné tečce, jsme slepili $5$ různých těles (viz obrázek). Každé těleso obsahuje $6$ těchto krychliček. Každé slepené těleso jsme si prohlédli ze všech stran (i zespodu) a spočítali počet všech teček na jeho povrchu.',
        'Které těleso má na svém povrchu nejvíce teček?'],
     'opts':['A) těleso A','B) těleso B','C) těleso C','D) těleso D','E) těleso E'],'ln':0,'svg':SVG11,'fn':'krychlicky-tecky.svg',
     'alt':'Pět prostorových těles A–E slepených ze šesti krychliček s tečkami (schematická poznámka).',
     'cap':'Prostorová tělesa – viz testový sešit',
     'sol':['Každá krychlička má na povrchu $6$ teček. Slepením dvou stěn zmizí $2$ tečky, proto má na povrchu nejvíce teček to těleso, které má nejmenší počet slepených stěn (nejméně dotyků krychliček). Podle klíče je to těleso D.'],
     'ans':'D) těleso D','pts':2,'mins':3,'diff':'3',
     'codes':B+['stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 12','zad':[
        'Filip se učil házet oštěpem. Délka jeho prvního hodu byla $700$ cm. Jeho druhý hod byl o desetinu delší než první a třetí hod byl o desetinu kratší než druhý.',
        'Jak se lišily délky třetího a prvního Filipova hodu? Třetí hod byl…'],
     'opts':['A) o $77$ cm kratší než první.','B) o $7$ cm kratší než první.','C) stejně dlouhý jako první.','D) o $7$ cm delší než první.','E) o $63$ cm delší než první.'],'ln':0,
     'sol':['Druhý hod $700\\cdot 1{,}1=770$ cm, třetí hod $770\\cdot 0{,}9=693$ cm. Třetí byl o $700-693=7$ cm kratší než první.'],
     'ans':'B) o $7$ cm kratší než první.','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5D 2026 – úloha 13','zad':[
        'Každý vyplněný diagram obsahuje čtyři čísla, která splňují následující podmínky: v bílém čtverci je součet čísel zapsaných v šedých kroužcích; v bílém trojúhelníku je rozdíl čísel v šedých kroužcích (menšitel je vždy ve spodním kroužku). Vzor: horní kroužek $9$, spodní kroužek $2$, čtverec $11$, trojúhelník $7$.',
        'Přiřaďte ke každému diagramu (13.1–13.3) číslo (A–F), které v diagramu patří na místo otazníku.'],
     'opts':['A) $1$','B) $3$','C) $5$','D) $7$','E) $9$','F) $10$'],'ln':0,'svg':SVG13,'fn':'diagramy.svg',
     'alt':'Vzorový diagram a tři diagramy 13.1–13.3 se čtvercem, trojúhelníkem a dvěma šedými kroužky; na místě otazníku chybí číslo.',
     'cap':'Vzor a diagramy 13.1–13.3',
     'sol':['Podle vzoru platí: čtverec $=$ horní kroužek $+$ spodní kroužek; trojúhelník $=$ horní kroužek $-$ spodní kroužek.',
            '13.1 Spodní kroužek $=23-16=7$; otazník (trojúhelník) $=16-7=9$ → E.',
            '13.2 Součet kroužků je $16$ a jejich rozdíl $14$, tedy horní kroužek $=15$ a spodní kroužek (otazník) $=1$ → A.',
            '13.3 Součet kroužků je $5$ a jejich rozdíl $5$, tedy horní kroužek (otazník) $=5$ a spodní kroužek $=0$ → C.'],
     'ans':'13.1: E ($9$); 13.2: A ($1$); 13.3: C ($5$)','pts':5,'mins':6,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5D 2026 – úloha 14','zad':[
        'Vědomostní hra má $10$ kol. Hráč má na začátku hry celkem $10$ žetonů a postupně může odpovědět na $5$ lehčích a na $5$ těžších otázek. V každém kole si může koupit pouze $1$ otázku a zaplatí za ni $1$ žeton. Pokud hráč kolo vynechá (otázku si nekoupí), žeton mu zůstane. Za správnou odpověď na lehčí otázku získá hráč $2$ žetony, za správnou odpověď na těžší otázku $3$ žetony. Za chybnou odpověď žádný žeton nezíská.',
        '14.1 Určete, kolik nejvíce žetonů může mít hráč na konci hry.',
        '14.2 Hráč vynechal pouze $1$ kolo a ve zbývajících kolech získal za odpovědi na lehčí otázky o $3$ žetony více než za odpovědi na těžší otázky. Určete, kolik žetonů měl hráč na konci hry.',
        '14.3 Hráč měl na konci hry $10$ žetonů a přitom měl největší možný počet chybných odpovědí s tímto výsledkem. Určete, kolikrát v této hře správně odpověděl na lehčí otázku. Uveďte všechna řešení.'],
     'opts':None,'ln':3,
     'sol':['14.1 Za koupenou otázku se platí $1$ žeton; správná lehčí přinese čistý zisk $+1$, správná těžší $+2$. Nejvíce vydělá hráč, který správně odpoví na všech $5$ lehčích i $5$ těžších otázek: $5\\cdot 1+5\\cdot 2=15$. Na konci má $10+15=25$ žetonů.',
            '14.2 Vynechal $1$ kolo (žeton zůstal), v $9$ kolech zaplatil $9$ žetonů. Za lehčí získal o $3$ žetony více než za těžší; jediná možnost v mezích $5$ a $5$ otázek je $6$ žetonů za lehčí ($3$ správné lehčí) a $3$ žetony za těžší ($1$ správná těžší). Na konci má $10-9+6+3=10$ žetonů.',
            '14.3 Začátek i konec je $10$ žetonů, celková změna je $0$. Označíme počet správných lehčích $a$, těžších $b$ a chybných $w$; pak $a+2b=w$ při $a\\le 5$ a $b\\le 5$. Největší možný počet chybných je $6$: buď $a=0$, $b=3$ (a jedno vynechané kolo), nebo $a=2$, $b=2$. Na lehčí otázku tedy hráč odpověděl správně buď ani jednou, nebo dvakrát.'],
     'ans':'14.1: $25$ žetonů; 14.2: $10$ žetonů; 14.3: ani jednou nebo dvakrát','pts':4,'mins':8,'diff':'4',
     'codes':B+['aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PDD26C0T04'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5D-2026')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
