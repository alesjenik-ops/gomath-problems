# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 5B, 2. řádný termín (osmileté obory).
# Kód testu: M5PBD22C0T02. 14 úloh (po rozdělení izolovaných poduúloh 16 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR) + ověření záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \\) ----

# úloha 6: písmeno E slepené z 12 krychliček (schematický čelní pohled)
def _letterE():
    c = 34; ox = 30; oy = 20
    cells = [(0,0),(1,0),(2,0),(3,0),(0,1),(0,2),(1,2),(2,2),(0,3),(0,4),(1,4),(2,4)]
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+5*c} {oy*2+5*c}" font-family="sans-serif">']
    for (x, y) in cells:
        s.append(f'<rect x="{ox+x*c}" y="{oy+y*c}" width="{c}" height="{c}" fill="#cfe0f5" stroke="#111"/>')
    s.append('</svg>')
    return "".join(s)
SVG6 = _letterE()

# úloha 7.1: bod A, bod O na přímce p
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="40" y1="240" x2="430" y2="60" stroke="#000" stroke-width="2"/>
<text x="36" y="255" font-size="16" font-style="italic">p</text>
<line x1="292" y1="118" x2="308" y2="130" stroke="#000" stroke-width="1"/>
<text x="300" y="150" font-size="15" font-style="italic" text-anchor="middle">O</text>
<text x="352" y="182" font-size="15">x</text><text x="352" y="198" font-size="15" font-style="italic">A</text>
</svg>"""

# úloha 7.2: body P, S a přímka m
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="50" y1="80" x2="430" y2="300" stroke="#000" stroke-width="2"/>
<text x="55" y="72" font-size="16" font-style="italic">m</text>
<text x="212" y="222" font-size="15">x</text><text x="212" y="238" font-size="15" font-style="italic">P</text>
<text x="285" y="182" font-size="15">x</text><text x="285" y="198" font-size="15" font-style="italic">S</text>
</svg>"""

# úloha 8: sloupcový graf – počty vyzkoušených žáků po dnech (2 týdny)
def _bars8():
    data = [('Po','3. 1.',3),('Út','4. 1.',0),('St','5. 1.',5),('Čt','6. 1.',2),('Pá','7. 1.',2),
            ('Po','10. 1.',6),('Út','11. 1.',3),('St','12. 1.',0),('Čt','13. 1.',2),('Pá','14. 1.',7)]
    x0, y0 = 62, 250; unit = 26; bw = 44; gap = 10
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 320" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="24" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="632" y2="{y0}" stroke="#000"/>')
    for v in range(0, 9):
        y = y0 - v*unit
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-8}" y="{y+4}" font-size="12" text-anchor="end">{v}</text>')
    x = x0 + 14
    for i, (d, dt, val) in enumerate(data):
        if i == 5:
            x += 18
        if val > 0:
            h = val*unit
            s.append(f'<rect x="{x}" y="{y0-h}" width="{bw}" height="{h}" fill="#6f6f6f" stroke="#000"/>')
        s.append(f'<text x="{x+bw/2}" y="{y0+16}" font-size="11" text-anchor="middle">{d}</text>')
        s.append(f'<text x="{x+bw/2}" y="{y0+30}" font-size="10" text-anchor="middle">{dt}</text>')
        x += bw + gap
    s.append('<text x="26" y="150" font-size="11" text-anchor="middle" transform="rotate(-90 26 150)">Počet vyzkoušených žáků</text>')
    s.append(f'<text x="200" y="{y0+50}" font-size="12" text-anchor="middle">1. týden</text>')
    s.append(f'<text x="480" y="{y0+50}" font-size="12" text-anchor="middle">2. týden</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _bars8()

# úloha 10: tři kroužky s cyklickými výpočty + vzor
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif">
<text x="150" y="18" font-size="13" text-anchor="middle">nákres</text>
<circle cx="150" cy="58" r="24" fill="none" stroke="#000"/>
<circle cx="95" cy="152" r="24" fill="none" stroke="#000"/>
<circle cx="205" cy="152" r="24" fill="none" stroke="#000"/>
<text x="86" y="108" font-size="15" text-anchor="end">: 2</text>
<text x="214" y="108" font-size="15">+ 34</text>
<text x="150" y="192" font-size="15" text-anchor="middle">- 12</text>
<text x="430" y="18" font-size="13" text-anchor="middle">VZOR</text>
<circle cx="430" cy="58" r="24" fill="none" stroke="#000"/><text x="430" y="64" font-size="18" text-anchor="middle">9</text>
<circle cx="375" cy="152" r="24" fill="none" stroke="#000"/><text x="375" y="158" font-size="18" text-anchor="middle">3</text>
<circle cx="485" cy="152" r="24" fill="none" stroke="#000"/><text x="485" y="158" font-size="18" text-anchor="middle">11</text>
<text x="366" y="108" font-size="15" text-anchor="end">· 3</text>
<text x="494" y="108" font-size="15">+ 2</text>
<text x="430" y="192" font-size="15" text-anchor="middle">- 8</text>
</svg>"""

# úloha 11: obdélník rozdělený na čtverce S, M, L, XL (schematicky)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif">
<rect x="30" y="30" width="460" height="200" fill="none" stroke="#000" stroke-width="2"/>
<rect x="30" y="30" width="30" height="30" fill="none" stroke="#000"/>
<rect x="30" y="60" width="30" height="30" fill="none" stroke="#000"/>
<rect x="30" y="90" width="30" height="30" fill="none" stroke="#000"/>
<rect x="30" y="120" width="30" height="30" fill="none" stroke="#000"/>
<rect x="60" y="30" width="120" height="120" fill="#f4f4f4" stroke="#000"/><text x="120" y="95" font-size="18" text-anchor="middle">L</text>
<rect x="60" y="150" width="30" height="30" fill="none" stroke="#000"/><text x="75" y="170" font-size="11" text-anchor="middle">S</text>
<rect x="90" y="150" width="90" height="90" fill="#eaeaea" stroke="#000"/><text x="135" y="200" font-size="16" text-anchor="middle">M</text>
<rect x="30" y="150" width="30" height="30" fill="none" stroke="#000"/>
<rect x="30" y="180" width="30" height="60" fill="none" stroke="#000"/>
<rect x="180" y="30" width="200" height="200" fill="#f4f4f4" stroke="#000"/><text x="280" y="135" font-size="22" text-anchor="middle">XL</text>
<rect x="380" y="30" width="110" height="110" fill="none" stroke="#000"/>
<rect x="380" y="140" width="110" height="90" fill="none" stroke="#000"/>
<line x1="30" y1="255" x2="490" y2="255" stroke="#000"/>
<line x1="30" y1="250" x2="30" y2="260" stroke="#000"/><line x1="490" y1="250" x2="490" y2="260" stroke="#000"/>
<text x="260" y="275" font-size="14" text-anchor="middle">260 cm</text>
</svg>"""

# úloha 12: prostorové stavby z krychliček (schematická poznámka)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif">
<text x="280" y="50" font-size="13" text-anchor="middle">Petrova stavba (13 krychliček) a stavby A-E (po 14 krychličkách) - prostorová tělesa.</text>
<text x="280" y="76" font-size="12" text-anchor="middle" fill="#666">Spojením Petrovy stavby a jedné ze staveb A-E vznikne krychle 3x3x3 (27 krychliček).</text>
<text x="280" y="100" font-size="12" text-anchor="middle" fill="#666">Tělesa nelze věrně přenést do SVG; posuzuje se podle originálu v testovém sešitu.</text>
</svg>"""

# úloha 13: tabulka žetonů tří hráčů
def _tab13():
    xb = [10, 120, 240, 360, 480, 600]
    yb = [10, 66, 106, 146, 186]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 610 196" font-family="sans-serif">']
    for x in xb:
        s.append(f'<line x1="{x}" y1="{yb[0]}" x2="{x}" y2="{yb[-1]}" stroke="#000"/>')
    for y in yb:
        s.append(f'<line x1="{xb[0]}" y1="{y}" x2="{xb[-1]}" y2="{y}" stroke="#000"/>')
    hdr = [('Počet', 'žetonů'), ('na začátku', 'hry'), ('vyhraných', 'během hry'),
           ('prohraných', 'během hry'), ('na konci', 'hry')]
    for i, (a, b) in enumerate(hdr):
        cx = (xb[i] + xb[i+1]) / 2
        s.append(f'<text x="{cx}" y="34" font-size="12" text-anchor="middle">{a}</text>')
        s.append(f'<text x="{cx}" y="52" font-size="12" text-anchor="middle">{b}</text>')
    rows = [['Blanka', '48', '6', '', ''], ['Emil', '', '', '0', '52'], ['Ivana', '', '18', '12', '']]
    for r, row in enumerate(rows):
        cy = (yb[r+1] + yb[r+2]) / 2 + 4
        for i, val in enumerate(row):
            cx = (xb[i] + xb[i+1]) / 2 if i > 0 else xb[0] + 8
            anc = 'middle' if i > 0 else 'start'
            if val:
                s.append(f'<text x="{cx}" y="{cy}" font-size="13" text-anchor="{anc}">{val}</text>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _tab13()

# úloha 14: stavba z kostek – opakující se sloupce výšek 1,2,3,4,3,2 (první sloupec tmavý)
def _build14():
    heights = [1,2,3,4,3,2,1,2,3,4,3,2]
    c = 18; ox = 20; oy = 20; baseY = oy + 4*c
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+14*c} {baseY+30}" font-family="sans-serif">']
    x = ox
    for i, h in enumerate(heights):
        if i == 6:
            x += c  # mezera mezi periodami
        dark = (i % 6 == 0)
        for k in range(h):
            fill = '#9a9a9a' if (dark and k == 0) else '#ffffff'
            y = baseY - (k+1)*c
            s.append(f'<rect x="{x}" y="{y}" width="{c}" height="{c}" fill="{fill}" stroke="#000"/>')
        x += c
    s.append(f'<line x1="{ox}" y1="{baseY}" x2="{x}" y2="{baseY}" stroke="#000" stroke-width="2"/>')
    s.append('</svg>')
    return "".join(s)
SVG14 = _build14()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 v taxonomii není

PROBLEMS = [
    {'name':'CERMAT M5B 2022 – úloha 1.1','zad':['Vypočtěte: $(1\\,100-110-90):(5-2\\cdot 2)+24=$'],'opts':None,'ln':2,
     'sol':['$(1\\,100-110-90):(5-2\\cdot 2)+24=900:1+24=900+24=924$.'],'ans':'$924$','pts':2,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2022 – úloha 1.2','zad':['Vypočtěte: $60\\cdot 40-(5+5\\cdot 13):2=$'],'opts':None,'ln':2,
     'sol':['$60\\cdot 40-(5+5\\cdot 13):2=2\\,400-70:2=2\\,400-35=2\\,365$.'],'ans':'$2\\,365$','pts':2,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2022 – úloha 2','zad':[
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '2.1 $1$ hodina $=20$ minut $+$ [ ] sekund',
        '2.2 $\\frac{1}{4}$ metru $+340$ milimetrů $=1$ metr $-$ [ ] centimetrů'],
     'opts':None,'ln':2,
     'sol':['2.1 $1$ hodina $=3\\,600$ s, $20$ minut $=1\\,200$ s; do rámečku patří $3\\,600-1\\,200=2\\,400$.',
            '2.2 $\\frac{1}{4}$ m $=25$ cm, $340$ mm $=34$ cm, levá strana $=59$ cm; $1$ m $-41$ cm $=59$ cm, do rámečku patří $41$.'],
     'ans':'2.1: $2\\,400$; 2.2: $41$','pts':4,'mins':4,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2022 – úloha 3','zad':[
        '3.1 Od startovní čáry vyběhli současně 4 běžci. Každý doběhl do cíle v jiném čase. Eda nebyl první ani poslední. Leoš se umístil těsně před Adamem a Adam doběhl později než Honza. Zapište běžce ve stejném pořadí, v jakém doběhli do cíle. Každého běžce označte počátečním písmenem jeho jména.',
        '3.2 Na výletě bylo pětkrát více dětí než dospělých. Dospělých bylo o 60 méně než dětí. Vypočtěte, kolik dětí bylo na výletě.'],
     'opts':None,'ln':2,
     'sol':['3.1 Z podmínek (Eda ne první ani poslední; Leoš těsně před Adamem; Honza doběhl před Adamem) plyne jediné pořadí H, E, L, A.',
            '3.2 Dětí je pětkrát více než dospělých a zároveň o 60 více: $5d-d=60$, $4d=60$, $d=15$; dětí je $5\\cdot 15=75$.'],
     'ans':'3.1: H, E, L, A; 3.2: $75$ dětí','pts':4,'mins':5,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5B 2022 – úloha 4','zad':[
        'V kasičce bylo na začátku prázdnin 2 800 korun. Každý den prázdnin si z kasičky brala Anna 30 korun a Radka 40 korun, a to až do dne, kdy se kasička vyprázdnila.',
        '4.1 Vypočtěte, kolikátý den prázdnin se kasička vyprázdnila.',
        '4.2 Když si jednoho prázdninového dne obě dívky vzaly peníze z kasičky, zůstalo v ní přesně tolik korun, kolik už si z ní od začátku prázdnin vybrala Anna. Vypočtěte, kolikátý den prázdnin k tomu došlo.'],
     'opts':None,'ln':2,
     'sol':['4.1 Za jeden den obě dívky vyberou $30+40=70$ korun; $2\\,800:70=40$, kasička se vyprázdní $40.$ den.',
            '4.2 Po $n$ dnech v kasičce zůstane $2\\,800-70n$ korun, Anna vybrala celkem $30n$ korun. Z rovnice $2\\,800-70n=30n$ plyne $100n=2\\,800$, tedy $n=28$.'],
     'ans':'4.1: $40.$ den; 4.2: $28.$ den','pts':4,'mins':5,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5B 2022 – úloha 5','zad':[
        'V pohádkové říši se setkání draků zúčastnili pouze dvouhlaví a tříhlaví draci. Draků bylo celkem 52 a dohromady měli 134 hlav.',
        '5.1 Vypočtěte, kolik dvouhlavých draků bylo na setkání.',
        '5.2 Vypočtěte, o kolik hlav více měli dohromady všichni tříhlaví draci než všichni dvouhlaví draci.'],
     'opts':None,'ln':2,
     'sol':['5.1 Označme $d$ počet dvouhlavých a $t$ počet tříhlavých draků: $d+t=52$ a $2d+3t=134$. Odtud $t=30$ a $d=22$.',
            '5.2 Tříhlaví draci mají $30\\cdot 3=90$ hlav, dvouhlaví $22\\cdot 2=44$ hlav; rozdíl je $90-44=46$ hlav.'],
     'ans':'5.1: $22$ dvouhlavých draků; 5.2: o $46$ hlav','pts':4,'mins':4,'diff':'2',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5B 2022 – úloha 6','zad':[
        'Písmeno E (na obrázku) slepené z 12 stejných bílých krychliček jsme obarvili ze všech stran (i zespodu) modrou barvou. Po čase se písmeno rozpadlo na jednotlivé krychličky. Původně slepené stěny krychliček zůstaly bílé.',
        '6.1 Určete, kolik krychliček z rozpadlého písmene E má právě 4 stěny modré.',
        '6.2 Určete, kolik krychliček z rozpadlého písmene E má stejný počet modrých a bílých stěn.'],
     'opts':None,'ln':2,'svg':SVG6,'fn':'pismeno-E.svg',
     'alt':'Písmeno E slepené z 12 stejných krychliček (schematický čelní pohled).','cap':'Písmeno E z 12 krychliček (schematicky)',
     'sol':['Počet modrých stěn krychličky $=6-$ (počet sousedních krychliček, ke kterým byla přilepená).',
            '6.1 Právě 4 modré stěny má krychlička se 2 sousedy; takových krychliček je 8.',
            '6.2 Stejný počet modrých a bílých stěn (3 a 3) má krychlička se 3 sousedy; taková je jen 1 (spoj svislého sloupce s prostřední řadou).'],
     'ans':'6.1: $8$ krychliček; 6.2: $1$ krychlička','pts':3,'mins':4,'diff':'3',
     'codes':B+['stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2022 – úloha 7.1 (konstrukce)','zad':[
        'V rovině leží body $A$, $O$ a přímka $p$ procházející bodem $O$ (viz obrázek).',
        'Bod $A$ je vrchol obdélníku $ABCD$. Na přímce $p$ leží vrchol $C$ tohoto obdélníku. Bod $O$ je střed některé strany obdélníku $ABCD$.',
        'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG7_1,'fn':'body-AO-primka-p.svg',
     'alt':'Přímka p procházející bodem O a bod A ležící mimo přímku p.','cap':'Výchozí obrázek k úloze 7.1',
     'sol':['Bod $O$ je střed strany sousedící s vrcholem $A$. Protější krajní bod této strany získáme jako obraz bodu $A$ ve středové souměrnosti se středem $O$. V tomto bodě vztyčíme kolmici ke straně; její průsečík s přímkou $p$ je vrchol $C$, zbývající vrchol doplníme na obdélník. Podle volby strany (u vrcholu $A$ dvě možnosti) vzniknou dvě řešení $ABCD$.'],
     'ans':'Konstrukce obdélníku $ABCD$: $O$ je střed strany u vrcholu $A$, $C$ leží na přímce $p$; dvě řešení (viz obrázek v klíči).',
     'pts':3,'mins':6,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2022 – úloha 7.2 (konstrukce)','zad':[
        'V rovině leží body $P$, $S$ a přímka $m$ (viz obrázek).',
        'Bod $S$ je střed kružnice $k$, která má poloměr $5$ cm. Bod $P$ je vrchol rovnostranného trojúhelníku $PQR$. Další vrchol tohoto trojúhelníku leží na přímce $m$ a zároveň na kružnici $k$ a poslední vrchol trojúhelníku $PQR$ leží uvnitř kružnice $k$.',
        'Sestrojte vrcholy $Q$, $R$ trojúhelníku $PQR$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG7_2,'fn':'body-PS-primka-m.svg',
     'alt':'Přímka m a body P a S ležící pod přímkou m.','cap':'Výchozí obrázek k úloze 7.2',
     'sol':['Sestrojíme kružnici $k$ se středem $S$ a poloměrem $5$ cm. Vrchol trojúhelníku ležící na přímce $m$ i na kružnici $k$ je jeden z průsečíků přímky $m$ a kružnice $k$ (dva body). Pro každý z nich sestrojíme rovnostranný trojúhelník $PQR$ tak, aby jeho třetí vrchol ležel uvnitř kružnice $k$. Vznikají dvě řešení.'],
     'ans':'Konstrukce rovnostranného trojúhelníku $PQR$: vrchol na průniku přímky $m$ a kružnice $k$, třetí vrchol uvnitř $k$; dvě řešení (viz obrázek v klíči).',
     'pts':3,'mins':6,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2022 – úloha 8','zad':[
        'V prvních dvou lednových týdnech učitel matematiky vyzkoušel všech 30 žáků třídy 5. A, a to každého právě jednou. Graf udává počty žáků vyzkoušených v jednotlivých dnech.',
        'Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).',
        '8.1 V 1. týdnu učitel vyzkoušel o 6 žáků méně než ve 2. týdnu.',
        '8.2 Ve 2. týdnu učitel vyzkoušel v pátek sedmkrát více žáků než ve středu.',
        '8.3 V úterý 11. 1. učitel vyzkoušel čtvrtinu z těch žáků, kteří nebyli vyzkoušeni v žádném z předchozích dnů.'],
     'opts':None,'ln':0,'svg':SVG8,'fn':'graf-vyzkouseni.svg',
     'alt':'Sloupcový graf počtu vyzkoušených žáků v deseti dnech dvou lednových týdnů.','cap':'Počty vyzkoušených žáků v jednotlivých dnech',
     'sol':['8.1 V 1. týdnu vyzkoušel $3+0+5+2+2=12$ žáků, ve 2. týdnu $6+3+0+2+7=18$ žáků; $18-12=6$, tvrzení platí (Ano).',
            '8.2 Ve středu 2. týdne vyzkoušel 0 žáků, v pátek 7 žáků; 7 není sedminásobek nuly, tvrzení neplatí (Ne).',
            '8.3 Před úterým 11. 1. nebylo vyzkoušeno $30-(3+0+5+2+2+6)=12$ žáků; jejich čtvrtina je $3$, což je počet vyzkoušených v úterý 11. 1., tvrzení platí (Ano).'],
     'ans':'8.1: Ano; 8.2: Ne; 8.3: Ano','pts':4,'mins':6,'diff':'3',
     'codes':B+['statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5B 2022 – úloha 9','zad':[
        'Květinářka měla v prodejně celkem 105 růží, některé byly červené a ostatní bílé. Ze všech těchto růží uvázala kytice po 5 růžích. V každé kytici byly právě 3 růže červené.',
        'Kolik bílých růží měla květinářka v prodejně?'],
     'opts':['A) $21$','B) $35$','C) $42$','D) $63$','E) více než $63$'],'ln':0,
     'sol':['Kytic je $105:5=21$. V každé kytici jsou $5-3=2$ bílé růže, celkem $21\\cdot 2=42$ bílých růží.'],
     'ans':'C) $42$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5B 2022 – úloha 10','zad':[
        'V nákresu se do tří prázdných kroužků doplní čísla v souladu se všemi uvedenými výpočty (vpravo je uveden vzor).',
        'Jaký je součet čísel doplněných do tří prázdných kroužků?'],
     'opts':['A) $89$','B) $100$','C) $122$','D) $188$','E) jiný součet'],'ln':0,'svg':SVG10,'fn':'krouzky-vypocty.svg',
     'alt':'Tři kroužky spojené šipkami s operacemi : 2, + 34, - 12 a vzor s čísly 9, 11, 3.','cap':'Cyklus výpočtů a vzor',
     'sol':['Označme čísla v kroužcích $a$ (vlevo dole), $b$ (nahoře), $c$ (vpravo dole). Platí $a:2=b$, $b+34=c$ a $c-12=a$. Dosazením $a=\\frac{a}{2}+34-12$ vyjde $a=44$, dále $b=22$ a $c=56$. Součet je $44+22+56=122$.'],
     'ans':'C) $122$','pts':2,'mins':4,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2022 – úloha 11','zad':[
        'Obdélník je rozdělen na 12 čtverců čtyř různých velikostí (S, M, L a XL). Delší strana obdélníku měří 260 cm.',
        'Jaký je obvod čtverce velikosti L?'],
     'opts':['A) méně než $320$ cm','B) $320$ cm','C) $360$ cm','D) $400$ cm','E) více než $400$ cm'],'ln':0,'svg':SVG11,'fn':'obdelnik-ctverce.svg',
     'alt':'Obdélník s delší stranou 260 cm rozdělený na čtverce velikostí S, M, L a XL (schematicky).','cap':'Schematické rozdělení obdélníku na čtverce',
     'sol':['Ze vzájemných poměrů stran čtverců v nákresu vychází strana čtverce velikosti L rovna $80$ cm. Obvod čtverce L je $4\\cdot 80=320$ cm.'],
     'ans':'B) $320$ cm','pts':2,'mins':4,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2022 – úloha 12','zad':[
        'Petr postavil na podložce stavbu ze 13 stejných krychliček (viz obrázek). Každá z pěti staveb (A–E) byla postavena na podložce ze 14 stejných krychliček. V každé stavbě (i v Petrově) jsou sousední krychličky vždy slepeny k sobě.',
        'Kterou ze staveb A–E lze spojit s Petrovou stavbou tak, že vznikne krychle?'],
     'opts':['A) stavba A','B) stavba B','C) stavba C','D) stavba D','E) stavba E'],'ln':0,'svg':SVG12,'fn':'stavby-krychle.svg',
     'alt':'Petrova stavba ze 13 krychliček a pět staveb A–E po 14 krychličkách (schematická poznámka).','cap':'Prostorové stavby – viz testový sešit',
     'sol':['Petrova stavba má 13 krychliček, hledaná stavba 14; dohromady $13+14=27=3^3$, tedy krychle $3\\times 3\\times 3$. Doplňkem Petrovy stavby na krychli je stavba D.'],
     'ans':'D) stavba D','pts':2,'mins':3,'diff':'3',
     'codes':B+['stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5B 2022 – úloha 13','zad':[
        'Na začátku hry si hráč vylosuje určitý počet žetonů. Během hry může žetony vyhrát, ale i prohrát. Na konci hry zjistí, kolik žetonů mu zůstalo. Následující tabulka udává některé údaje tří hráčů.',
        'Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).',
        '13.1 Blance zůstala na konci hry jen třetina žetonů, které si na začátku vylosovala. Kolik žetonů Blanka během hry prohrála?',
        '13.2 Emil si na začátku hry vylosoval o 8 žetonů více, než vyhrál během hry. Kolik žetonů si Emil vylosoval na začátku hry?',
        '13.3 Ivana měla na konci hry o jednu šestinu žetonů více, než si vylosovala na začátku hry. Kolik žetonů si Ivana vylosovala na začátku hry?'],
     'opts':['A) $30$ žetonů','B) $32$ žetonů','C) $34$ žetonů','D) $36$ žetonů','E) $38$ žetonů','F) jiný počet žetonů'],'ln':0,'svg':SVG13,'fn':'tabulka-zetony.svg',
     'alt':'Tabulka s údaji hráčů Blanka, Emil a Ivana o žetonech na začátku, vyhraných, prohraných a na konci hry.','cap':'Údaje tří hráčů o žetonech',
     'sol':['13.1 Blance na konci zůstalo $\\frac{1}{3}\\cdot 48=16$ žetonů; z $48+6-$prohráno$=16$ plyne prohrála $48+6-16=38$ (E).',
            '13.2 Emil: $52=$začátek$+$výhra a začátek$=$výhra$+8$; tedy $2\\cdot$výhra$+8=52$, výhra $22$, začátek $30$ (A).',
            '13.3 Ivana: konec$=$začátek$+18-12=$začátek$+6$ a zároveň konec$=\\frac{7}{6}\\cdot$začátek; tedy $\\frac{1}{6}$začátku$=6$, začátek $36$ (D).'],
     'ans':'13.1: E ($38$ žetonů); 13.2: A ($30$ žetonů); 13.3: D ($36$ žetonů)','pts':5,'mins':6,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5B 2022 – úloha 14','zad':[
        'Amélka, Viktorka a Zuzanka vytvářely stavby z kostek podle následujících pravidel: první sloupec stavby tvoří 1 tmavá kostka a dalších 5 sloupců je postaveno postupně ze 2, 3, 4, 3 a 2 bílých kostek. Poté se sloupce opakují ve stejném pořadí, ale po dostavění kteréhokoliv sloupce lze stavbu ukončit. Např. stavba na obrázku má celkem 23 sloupců, z nichž je 19 sloupců bílých a 4 tmavé.',
        '14.1 Amélčina stavba má celkem 42 sloupců. Vypočtěte, kolik kostek (bílých i tmavých dohromady) obsahuje Amélčina stavba.',
        '14.2 Viktorčina stavba má 58 bílých sloupců. Vypočtěte, kolik tmavých kostek obsahuje Viktorčina stavba.',
        '14.3 Zuzančina stavba obsahuje celkem 156 kostek (bílých i tmavých dohromady). Vypočtěte, kolik sloupců má Zuzančina stavba.'],
     'opts':None,'ln':3,'svg':SVG14,'fn':'stavba-sloupce.svg',
     'alt':'Opakující se stavba ze sloupců kostek výšek 1, 2, 3, 4, 3, 2; první sloupec každé periody je tmavý.','cap':'Perioda šesti sloupců (první sloupec tmavý)',
     'sol':['Jedna perioda má 6 sloupců (výšky 1, 2, 3, 4, 3, 2), tj. $1+2+3+4+3+2=15$ kostek, z toho 1 tmavý sloupec (1 tmavá kostka) a 5 bílých sloupců.',
            '14.1 $42$ sloupců $=7$ celých period; $7\\cdot 15=105$ kostek.',
            '14.2 $58$ bílých sloupců $=11\\cdot 5+3$, tj. 11 celých period a 3 bílé sloupce ve 12. periodě; tmavých sloupců je 12, tedy 12 tmavých kostek.',
            '14.3 $156=10\\cdot 15+6$; v 11. periodě dají první tři sloupce $1+2+3=6$ kostek, celkem $60+3=63$ sloupců.'],
     'ans':'14.1: $105$ kostek; 14.2: $12$ tmavých kostek; 14.3: $63$ sloupců','pts':4,'mins':6,'diff':'3',
     'codes':B+['posloupnosti','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PBD22C0T02'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5B-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)

