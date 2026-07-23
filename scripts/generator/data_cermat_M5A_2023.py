# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2023, MATEMATIKA 5A, 1. řádný termín.
# Kód testu: M5PAD23C0T01. 14 úloh (po rozdělení izolovaných poduúloh 17 úloh), 50 bodů.
# Zdroj odpovědí: klíč správných řešení (KSR).

# ---- SVG obrázky (bez ' a \) ----

# úloha 7.1: bod C a přímky a, b
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="150" y1="35" x2="120" y2="275" stroke="#000" stroke-width="2"/><text x="156" y="40" font-size="16" font-style="italic">a</text>
<line x1="40" y1="255" x2="430" y2="175" stroke="#000" stroke-width="2"/><text x="436" y="176" font-size="16" font-style="italic">b</text>
<text x="336" y="92" font-size="15" font-style="italic">C</text><text x="330" y="108" font-size="15">×</text>
</svg>"""

# úloha 7.2: body K, S a přímka p procházející bodem S
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 340" font-family="sans-serif">
<line x1="40" y1="290" x2="420" y2="120" stroke="#000" stroke-width="2"/><text x="426" y="120" font-size="16" font-style="italic">p</text>
<text x="234" y="205" font-size="15">×</text><text x="244" y="216" font-size="15" font-style="italic">S</text>
<text x="196" y="253" font-size="15">×</text><text x="206" y="266" font-size="15" font-style="italic">K</text>
</svg>"""

# úloha 8: desetiúhelník (schematický nákres složeného obrazce)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 320" font-family="sans-serif">
<polygon points="150,45 320,225 150,225" fill="#b9b9b9" stroke="#000"/>
<rect x="110" y="225" width="130" height="55" fill="#b9b9b9" stroke="#000"/>
<rect x="150" y="145" width="40" height="40" fill="#fff" stroke="#000"/>
<rect x="150" y="185" width="40" height="40" fill="#fff" stroke="#000"/>
<rect x="150" y="225" width="40" height="40" fill="#fff" stroke="#000"/>
<rect x="72" y="112" width="40" height="40" fill="#fff" stroke="#000"/>
<polygon points="72,112 112,112 92,77" fill="#fff" stroke="#000"/>
<text x="252" y="150" font-size="11" fill="#333">šedý obrazec</text>
</svg>"""

# úloha 11 a 12: dílek stavebnice (kvádr 6 x 4 x 4 cm)
SVG_DILEK = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 180" font-family="sans-serif">
<rect x="40" y="60" width="120" height="80" fill="#f5f5f5" stroke="#000"/>
<polygon points="40,60 80,30 200,30 160,60" fill="#eeeeee" stroke="#000"/>
<polygon points="160,60 200,30 200,110 160,140" fill="#e0e0e0" stroke="#000"/>
<text x="100" y="158" font-size="13" text-anchor="middle">6 cm</text>
<text x="205" y="80" font-size="13">4 cm</text>
<text x="168" y="28" font-size="13">4 cm</text>
</svg>"""

# úloha 13: skládaný pruhový graf (papír / plast / kovy), oddíly R, S, T
def _graf13():
    rows = [("R",6,15,3),("S",8,11,3),("T",1,9,4)]
    x0 = 60; sc = 19; top = 30; bh = 34; gap = 22
    W = x0 + 27*sc + 100
    ybot = top + 3*(bh+gap) + 6
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} 270" font-family="sans-serif">']
    for v in range(0,28,3):
        x = x0 + v*sc
        s.append(f'<line x1="{x}" y1="{top}" x2="{x}" y2="{ybot}" stroke="#ccc" stroke-width="1"/>')
        s.append(f'<text x="{x}" y="{ybot+16}" font-size="11" text-anchor="middle">{v}</text>')
    s.append(f'<text x="{x0+13*sc}" y="{ybot+34}" font-size="12" text-anchor="middle">počet kg</text>')
    y = top
    for name,pa,pl,ko in rows:
        x = x0
        for val,col in ((pa,"#c9c9c9"),(pl,"#ffffff"),(ko,"#555555")):
            w = val*sc
            s.append(f'<rect x="{x}" y="{y}" width="{w}" height="{bh}" fill="{col}" stroke="#000"/>')
            x += w
        s.append(f'<text x="{x0-12}" y="{y+bh/2+4}" font-size="13" text-anchor="end" font-weight="bold">{name}</text>')
        y += bh + gap
    lx = x0 + 27*sc + 18
    for i,(lab,col) in enumerate([("papír","#c9c9c9"),("plast","#ffffff"),("kovy","#555555")]):
        ly = top + i*22
        s.append(f'<rect x="{lx}" y="{ly}" width="14" height="14" fill="{col}" stroke="#000"/>')
        s.append(f'<text x="{lx+20}" y="{ly+12}" font-size="12">{lab}</text>')
    s.append("</svg>")
    return "".join(s)
SVG13 = _graf13()

# úloha 14: základní obrazec (2x3 světlé) a rozšířený obrazec (3x5, 9 tmavých)
def _obr14():
    c = 22
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 200" font-family="sans-serif">']
    ox, oy = 40, 55
    for r in range(2):
        for cc in range(3):
            s.append(f'<rect x="{ox+cc*c}" y="{oy+r*c}" width="{c}" height="{c}" fill="#f0f0f0" stroke="#000"/>')
    s.append(f'<text x="{ox+1.5*c}" y="{oy-12}" font-size="12" text-anchor="middle">základní obrazec</text>')
    px, py = 250, 55
    for r in range(3):
        for cc in range(5):
            dark = (r==0) or (cc==0) or (cc==4)
            col = "#8a8a8a" if dark else "#f0f0f0"
            s.append(f'<rect x="{px+cc*c}" y="{py+r*c}" width="{c}" height="{c}" fill="{col}" stroke="#000"/>')
    s.append(f'<text x="{px+2.5*c}" y="{py-12}" font-size="12" text-anchor="middle">rozšířený obrazec</text>')
    s.append("</svg>")
    return "".join(s)
SVG14 = _obr14()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté); kód r5 v taxonomii není

PROBLEMS = [
    {'name':'CERMAT M5A 2023 – úloha 1.1','zad':['Vypočtěte: $5\\cdot 120+(700-6\\cdot 25):(10-7+2)=$'],'opts':None,'ln':2,
     'sol':['$5\\cdot 120+(700-150):(10-7+2)=600+550:5=600+110=710$.'],'ans':'$710$','pts':2,'mins':2,'diff':'1',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5A 2023 – úloha 1.2','zad':['Vypočtěte: $(5+5\\cdot 29)-4\\cdot(176:8-8\\cdot 2)=$'],'opts':None,'ln':2,
     'sol':['$(5+145)-4\\cdot(22-16)=150-4\\cdot 6=150-24=126$.'],'ans':'$126$','pts':2,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5A 2023 – úloha 2.1','zad':['Vypočtěte, o kolik litrů se liší čtvrtina z 24 litrů a třetina z 12 litrů.'],'opts':None,'ln':2,
     'sol':['Čtvrtina z $24$ litrů je $24:4=6$ litrů, třetina z $12$ litrů je $12:3=4$ litry. Liší se o $6-4=2$ litry.'],
     'ans':'o $2$ litry','pts':2,'mins':2,'diff':'1',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5A 2023 – úloha 2.2','zad':[
        'Vynásobením dvou kladných celých čísel jsme získali součin 180. Jedno z těchto dvou čísel zvětšíme dvakrát a jedno zmenšíme šestkrát.',
        'Určete, jaký součin získáme vynásobením obou změněných čísel.'],'opts':None,'ln':2,
     'sol':['Součin se násobí dvěma a dělí šesti, tedy vydělí třemi: nový součin je $180\\cdot 2:6=180:3=60$.'],
     'ans':'$60$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5A 2023 – úloha 3','zad':[
        'V rotě je jeden kapitán a má pod sebou 4 poručíky. Každý poručík má pod sebou 3 své četaře a každý četař má pod sebou 10 svých vojínů. (Další osoby v rotě nejsou.) Kapitán se rozhodl svolat celou rotu k nástupu. Rozkaz k nástupu se předával tak, že kapitán vydal rozkaz všem poručíkům, z nichž každý vydal tento rozkaz svým četařům a každý četař jej vydal svým vojínům. Poté celá rota nastoupila.',
        '3.1 Vypočtěte, kolik je v rotě vojínů.',
        '3.2 Vypočtěte, kolik osob v rotě vydalo rozkaz k nástupu.',
        '3.3 Vypočtěte, kolik osob v rotě dostalo rozkaz k nástupu.'],'opts':None,'ln':3,
     'sol':['Poručíků je $4$, četařů $4\\cdot 3=12$, vojínů $12\\cdot 10=120$.',
            '3.1 V rotě je $120$ vojínů.',
            '3.2 Rozkaz vydal kapitán, všichni poručíci a všichni četaři: $1+4+12=17$ osob.',
            '3.3 Rozkaz dostali všichni poručíci, četaři a vojíni: $4+12+120=136$ osob.'],
     'ans':'3.1: $120$ vojínů; 3.2: $17$ osob; 3.3: $136$ osob','pts':3,'mins':4,'diff':'2',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5A 2023 – úloha 4','zad':[
        'Jana koupila v papírnictví několik stejných linkovaných sešitů, několik stejných čtverečkovaných sešitů a několik stejných kružítek.',
        '4.1 Jana koupila celkem 36 sešitů, přičemž linkovaných koupila třikrát více než čtverečkovaných. Vypočtěte, kolik linkovaných sešitů koupila.',
        '4.2 Dva linkované sešity a dva čtverečkované sešity stojí dohromady 180 korun. Dva čtverečkované sešity stojí stejně jako tři linkované. Vypočtěte, kolik korun stojí jeden čtverečkovaný sešit.',
        '4.3 K nákupu šesti kružítek chybělo Janě 160 korun, proto koupila jen čtyři kružítka a zbylo jí 100 korun. Vypočtěte, kolik korun zaplatila za 4 kružítka.'],'opts':None,'ln':3,
     'sol':['4.1 Čtverečkovaných je $x$, linkovaných $3x$; celkem $x+3x=4x=36$, tedy $x=9$ a linkovaných $3\\cdot 9=27$.',
            '4.2 Linkovaný stojí $l$, čtverečkovaný $c$: z $2l+2c=180$ je $l+c=90$, a $2c=3l$. Dosadíme $c=\\tfrac{3}{2}l$: $\\tfrac{5}{2}l=90$, $l=36$, $c=54$. Jeden čtverečkovaný stojí $54$ korun.',
            '4.3 Cena kružítka $k$: $6k$ převyšuje peníze o $160$ a $4k$ je o $100$ menší, takže $6k-4k=160+100$, $2k=260$, $k=130$. Za $4$ kružítka $4\\cdot 130=520$ korun.'],
     'ans':'4.1: $27$ linkovaných sešitů; 4.2: $54$ korun; 4.3: $520$ korun','pts':5,'mins':7,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5A 2023 – úloha 5','zad':[
        'Pro děti klubu SEN se letos otevřel pouze sportovní, divadelní a robotický kroužek. Každé dítě klubu SEN navštěvuje alespoň jeden z těchto tří kroužků – 3 děti navštěvují všechny tři kroužky, 8 dětí navštěvuje právě dva kroužky a ostatní děti jediný kroužek. Sportovní kroužek navštěvuje 14 dětí, divadelní 12 dětí a robotický 6 dětí.',
        '5.1 Vypočtěte, kolik dětí klubu SEN navštěvuje pouze jeden kroužek.',
        '5.2 Vypočtěte, kolik dětí je v klubu SEN.'],'opts':None,'ln':2,
     'sol':['Součet všech návštěvností je $14+12+6=32$. Dítě se třemi kroužky se v součtu počítá třikrát, se dvěma dvakrát a s jedním jednou: $32=3\\cdot 3+2\\cdot 8+x$, kde $x$ je počet dětí s jediným kroužkem.',
            '5.1 $32=9+16+x$, tedy $x=7$ dětí navštěvuje pouze jeden kroužek.',
            '5.2 V klubu je $x+8+3=7+8+3=18$ dětí.'],
     'ans':'5.1: $7$ dětí; 5.2: $18$ dětí','pts':4,'mins':5,'diff':'3',
     'codes':B+['statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5A 2023 – úloha 6','zad':[
        'Na odměny pro tři nejlepší soutěžící byla připravena finanční částka v korunách. První soutěžící získal polovinu této částky. Druhý soutěžící dostal 300 korun. Třetí soutěžící získal zbytek připravené částky, což bylo třikrát méně korun, než získal první soutěžící.',
        '6.1 Vypočtěte, kolikrát více korun dostal druhý soutěžící než třetí soutěžící.',
        '6.2 Vypočtěte, kolik korun bylo celkem připraveno na odměny.'],'opts':None,'ln':2,
     'sol':['Celková částka je $C$. První dostal $\\tfrac{C}{2}$, třetí $\\tfrac{1}{3}\\cdot\\tfrac{C}{2}=\\tfrac{C}{6}$. Zbytek pro třetího: $C-\\tfrac{C}{2}-300=\\tfrac{C}{6}$, tedy $\\tfrac{C}{2}-\\tfrac{C}{6}=300$, $\\tfrac{C}{3}=300$, $C=900$.',
            '6.2 Celkem bylo připraveno $900$ korun.',
            '6.1 První $450$, třetí $150$, druhý $300$ korun; druhý dostal $300:150=2$krát více než třetí.'],
     'ans':'6.1: $2$krát více; 6.2: $900$ korun','pts':3,'mins':4,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','finance']},
    {'name':'CERMAT M5A 2023 – úloha 7.1 (konstrukce)','zad':[
        'V rovině leží bod $C$ a přímky $a$, $b$ (viz obrázek).',
        'Bod $C$ je vrchol trojúhelníku $ABC$. Na přímce $a$ leží vrchol $A$ a na přímce $b$ vrchol $B$ tohoto trojúhelníku. Strana $AC$ trojúhelníku $ABC$ je rovnoběžná s přímkou $b$. Strany $AB$ a $AC$ mají stejnou délku.',
        'Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],'opts':None,'ln':0,
     'svg':SVG7_1,'fn':'primky-C-ab.svg',
     'alt':'Bod C a dvě přímky a, b protínající se v levé části obrázku.','cap':'Výchozí obrázek k úloze 7.1',
     'sol':['Protože $AC\\parallel b$, sestrojíme bodem $C$ rovnoběžku s přímkou $b$; její průsečík s přímkou $a$ je vrchol $A$. Vrchol $B$ leží na přímce $b$ ve vzdálenosti $|AB|=|AC|$ od bodu $A$: kružnice se středem $A$ a poloměrem $|AC|$ protne přímku $b$ ve dvou bodech $B_1$, $B_2$. Úloha má dvě řešení.'],
     'ans':'Dvě řešení: $A$ je průsečík přímky $a$ s rovnoběžkou s $b$ vedenou bodem $C$; $B_1$, $B_2$ leží na přímce $b$ a platí $|AB|=|AC|$ (viz obrázek v klíči).',
     'pts':3,'mins':6,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5A 2023 – úloha 7.2 (konstrukce)','zad':[
        'V rovině leží body $K$, $S$ a přímka $p$ procházející bodem $S$ (viz obrázek).',
        'Bod $K$ je vrchol obdélníku $KLMN$. Bod $S$ je střed strany $KL$ tohoto obdélníku. Přímka $p$ prochází středem $S$ strany $KL$ a středem ještě jedné strany obdélníku $KLMN$.',
        'Sestrojte vrcholy $L$, $M$, $N$ obdélníku $KLMN$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],'opts':None,'ln':0,
     'svg':SVG7_2,'fn':'body-KS-p.svg',
     'alt':'Body K a S a přímka p procházející bodem S.','cap':'Výchozí obrázek k úloze 7.2',
     'sol':['Vrchol $L$ je obrazem bodu $K$ ve středové souměrnosti se středem $S$ (protože $S$ je střed strany $KL$); strana $KL$ je tím dána. V bodech $K$ a $L$ vztyčíme kolmice ke straně $KL$. Přímka $p$ prochází i středem sousední strany: její průsečík s kolmicí v bodě $L$ je střed strany $LM$ (jedno řešení), její průsečík s kolmicí v bodě $K$ je střed strany $NK$ (druhé řešení). Zbývající vrcholy doplníme. Úloha má dvě řešení.'],
     'ans':'Dvě řešení: $L$ je obraz $K$ ve středové souměrnosti podle $S$; obdélník se dourčí tak, aby přímka $p$ procházela středem strany $LM$, resp. $NK$ (viz obrázek v klíči).',
     'pts':3,'mins':7,'diff':'4','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5A 2023 – úloha 8','zad':[
        'Desetiúhelník na obrázku se skládá z jednoho rovnostranného trojúhelníku, pěti stejných čtverců, jednoho šedého obdélníku a dvou stejných šedých trojúhelníků. Nejkratší strana desetiúhelníku měří 4 cm, nejdelší 20 cm.',
        'Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
        '8.1 Obvod rovnostranného trojúhelníku je 12 cm.',
        '8.2 Obvod šedého obdélníku je 56 cm.',
        '8.3 Obvod šedého trojúhelníku je větší než 50 cm.'],'opts':None,'ln':0,
     'svg':SVG8,'fn':'desetiuhelnik.svg',
     'alt':'Desetiúhelník složený z rovnostranného trojúhelníku, pěti čtverců, šedého obdélníku a dvou šedých trojúhelníků (schematicky).','cap':'Schematický nákres desetiúhelníku',
     'sol':['Strana čtverce je nejkratší strana, tj. $4$ cm. Rovnostranný trojúhelník má stranu $8$ cm, šedý obdélník rozměry $20$ cm a $8$ cm, šedý trojúhelník je pravoúhlý s odvěsnami $12$ cm a $16$ cm a přeponou $20$ cm.',
            '8.1 Obvod rovnostranného trojúhelníku je $3\\cdot 8=24$ cm, ne $12$ cm, tvrzení je nepravdivé → N.',
            '8.2 Obvod šedého obdélníku je $2\\cdot(20+8)=56$ cm → A.',
            '8.3 Obvod šedého trojúhelníku je $12+16+20=48$ cm, což není více než $50$ cm → N.'],
     'ans':'8.1: N; 8.2: A; 8.3: N','pts':4,'mins':6,'diff':'3',
     'codes':B+['planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5A 2023 – úloha 9','zad':[
        'Maminka koupila v cukrárně tři různé zákusky. První zákusek stál 72 korun. Druhý zákusek byl o čtvrtinu levnější než první. Cena třetího zákusku byla třetinou celkové ceny všech tří zákusků.',
        'O kolik korun byl třetí zákusek dražší než druhý?'],
     'opts':['A) o méně než 12 korun','B) o 12 korun','C) o 15 korun','D) o 18 korun','E) o více než 18 korun'],'ln':0,
     'sol':['Druhý zákusek: $72\\cdot\\tfrac{3}{4}=54$ korun. Třetí je třetina celku, tedy první a druhý tvoří dvě třetiny: $72+54=126$ korun je $\\tfrac{2}{3}$ celku, celek $=189$ korun, třetí $=189:3=63$ korun. Rozdíl $63-54=9$ korun, což je méně než 12.'],
     'ans':'A) o méně než 12 korun','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','finance']},
    {'name':'CERMAT M5A 2023 – úloha 10','zad':[
        'V kasičce je celkem 78 mincí – některé jsou pětikorunové a zbývající desetikorunové. Hodnota všech pětikorunových mincí v kasičce je stejná jako hodnota všech desetikorunových mincí v kasičce.',
        'Jaká je hodnota všech mincí v kasičce?'],
     'opts':['A) 390 korun','B) 520 korun','C) 585 korun','D) 780 korun','E) jiná hodnota'],'ln':0,
     'sol':['Nechť je $p$ pětikorunových a $d$ desetikorunových mincí: $p+d=78$ a $5p=10d$, tedy $p=2d$. Pak $3d=78$, $d=26$, $p=52$. Hodnota je $5\\cdot 52+10\\cdot 26=260+260=520$ korun.'],
     'ans':'B) 520 korun','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','finance']},
    {'name':'CERMAT M5A 2023 – úloha 11','zad':[
        'Stavebnice obsahuje samé stejné dílky. Každý dílek má tvar kvádru s rozměry 6 cm, 4 cm a 4 cm (viz obrázek).',
        'Kolik dílků stavebnice je třeba ke složení kvádru s rozměry 8 cm, 12 cm a 16 cm?'],
     'opts':['A) méně než 12 dílků','B) 12 dílků','C) 16 dílků','D) 32 dílků','E) více než 32 dílků'],'ln':0,
     'svg':SVG_DILEK,'fn':'dilek.svg',
     'alt':'Dílek stavebnice ve tvaru kvádru s rozměry 6 cm, 4 cm a 4 cm.','cap':'Dílek stavebnice (kvádr 6 cm krát 4 cm krát 4 cm)',
     'sol':['Objem skládaného kvádru je $8\\cdot 12\\cdot 16=1536$ cm³, objem dílku $6\\cdot 4\\cdot 4=96$ cm³. Počet dílků $1536:96=16$. Dílky lze skutečně poskládat (hrana 6 cm podél strany 12 cm, stěny 4 cm krát 4 cm vyplní 8 cm krát 16 cm), takže stačí $16$ dílků.'],
     'ans':'C) 16 dílků','pts':2,'mins':4,'diff':'3',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5A 2023 – úloha 12','zad':[
        'Stavebnice obsahuje samé stejné dílky. Každý dílek má tvar kvádru s rozměry 6 cm, 4 cm a 4 cm (viz obrázek).',
        'Kolik dílků stavebnice je třeba ke složení nejmenší možné krychle?'],
     'opts':['A) méně než 6 dílků','B) 6 dílků','C) 12 dílků','D) 18 dílků','E) více než 24 dílků'],'ln':0,
     'svg':SVG_DILEK,'fn':'dilek.svg',
     'alt':'Dílek stavebnice ve tvaru kvádru s rozměry 6 cm, 4 cm a 4 cm.','cap':'Dílek stavebnice (kvádr 6 cm krát 4 cm krát 4 cm)',
     'sol':['Hrana krychle musí být dělitelná délkami $6$ i $4$; nejmenší taková je nejmenší společný násobek $12$ cm. Objem krychle $12^3=1728$ cm³, objem dílku $96$ cm³, počet dílků $1728:96=18$. Krychli s hranou $12$ cm lze z dílků složit, takže je třeba $18$ dílků.'],
     'ans':'D) 18 dílků','pts':2,'mins':4,'diff':'3',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
    {'name':'CERMAT M5A 2023 – úloha 13','zad':[
        'Graf udává, kolik kg odpadu vytřídily tři skautské oddíly R, S a T.',
        'Do každé neúplné věty (13.1–13.3) doplňte na vynechané místo chybějící část (A–F) tak, aby vzniklo pravdivé tvrzení.',
        '13.1 Oddíl R vytřídil ...... méně kg papíru než oddíl S.',
        '13.2 Oddíly S a T dohromady vytřídily ...... více kg plastu než oddíl R.',
        '13.3 Všechny tři oddíly dohromady vytřídily ...... více kg papíru než kovů.'],
     'opts':['A) o šestinu','B) o pětinu','C) o čtvrtinu','D) o třetinu','E) o polovinu','F) dvakrát'],'ln':0,
     'svg':SVG13,'fn':'graf-odpad.svg',
     'alt':'Skládaný pruhový graf množství vytříděného papíru, plastu a kovů pro oddíly R, S a T.','cap':'Vytříděný odpad oddílů R, S, T (kg)',
     'sol':['Z grafu (v kg): R papír $6$, plast $15$, kovy $3$; S papír $8$, plast $11$, kovy $3$; T papír $1$, plast $9$, kovy $4$.',
            '13.1 R má $6$ kg papíru, S má $8$ kg; $8-6=2$ a $2$ je čtvrtina z $8$ → C (o čtvrtinu).',
            '13.2 S a T mají plastu $11+9=20$ kg, R má $15$ kg; $20-15=5$ a $5$ je třetina z $15$ → D (o třetinu).',
            '13.3 Papíru je celkem $6+8+1=15$ kg, kovů $3+3+4=10$ kg; $15-10=5$ a $5$ je polovina z $10$ → E (o polovinu).'],
     'ans':'13.1: C (o čtvrtinu); 13.2: D (o třetinu); 13.3: E (o polovinu)','pts':5,'mins':6,'diff':'3',
     'codes':B+['statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},
    {'name':'CERMAT M5A 2023 – úloha 14','zad':[
        'Ze stejně velkých světlých a tmavých čtverečků tvoříme obrazce tvaru čtverce nebo obdélníku. Základní obrazec je tvořen jednou nebo více řadami světlých čtverečků. Z každého základního obrazce vytvoříme rozšířený obrazec tak, že přidáme nahoru jednu řadu tmavých čtverečků a pak vlevo i vpravo po jednom sloupci tmavých čtverečků. Na obrázku je příklad základního obrazce (2 řady, 3 sloupce, 6 čtverečků) a z něj vzniklý rozšířený obrazec (3 řady, 5 sloupců, 15 čtverečků – z toho 9 tmavých).',
        '14.1 Ze základního obrazce, který má 5 řad, vytvoříme rozšířený obrazec přidáním 30 tmavých čtverečků. Určete počet sloupců v základním obrazci.',
        '14.2 Rozšířený obrazec má 3 řady a tvoří jej stejný počet tmavých a světlých čtverečků. Určete počet sloupců v rozšířeném obrazci.',
        '14.3 Můžeme najít mnoho rozšířených obrazců s 50 tmavými čtverečky. Určete počet všech těchto rozšířených obrazců.'],'opts':None,'ln':3,
     'svg':SVG14,'fn':'obrazce.svg',
     'alt':'Základní obrazec 2 řady krát 3 sloupce ze světlých čtverečků a rozšířený obrazec 3 řady krát 5 sloupců s tmavými čtverečky navrch a po stranách.','cap':'Příklad základního a rozšířeného obrazce',
     'sol':['Základní obrazec má $r$ řad a $s$ sloupců světlých čtverečků. Rozšířený má $r+1$ řad a $s+2$ sloupce; počet tmavých čtverečků je $(r+1)(s+2)-r\\cdot s=2r+s+2$.',
            '14.1 Pro $r=5$: $2\\cdot 5+s+2=30$, tedy $12+s=30$, $s=18$. Základní obrazec má $18$ sloupců.',
            '14.2 Rozšířený má $3$ řady, tj. $r=2$; světlých je $2s$, tmavých $2\\cdot 2+s+2=s+6$. Z rovnosti $2s=s+6$ je $s=6$; rozšířený má $s+2=8$ sloupců.',
            '14.3 $2r+s+2=50$, tedy $2r+s=48$; pro $r=1,2,\\dots,23$ je $s=48-2r$ celé kladné číslo. Existuje $23$ takových rozšířených obrazců.'],
     'ans':'14.1: $18$ sloupců; 14.2: $8$ sloupců; 14.3: $23$ rozšířených obrazců','pts':4,'mins':6,'diff':'4',
     'codes':B+['posloupnosti','modelovani','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PAD23C0T01'
    gen.YEAR = 2023

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2023')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
