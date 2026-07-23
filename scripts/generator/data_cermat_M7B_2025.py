# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2025, MATEMATIKA 7B (šestileté obory, 7. ročník),
# 2. řádný termín. Kód testu: M7PBD25C0T02. 16 úloh, 50 bodů.
# Po rozdělení nezávislých poduúloh (úloha 3.1 a 3.2 jsou samostatné výpočty) je 17 úloh.
# Zdroj odpovědí: rozšířený klíč správných řešení (KLIC). Bez samostatného VZA pro 2025.

# ---- SVG obrázky (bez apostrofu ' a bez zpětného lomítka \) ----

# úloha 2: tabulka se šesti poli (3. a 4. pole obsahují 72 a 108)
SVG2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 110" font-family="sans-serif">
<rect x="20" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="3"/>
<rect x="80" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="1"/>
<rect x="140" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="1"/>
<rect x="200" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="1"/>
<rect x="260" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="1"/>
<rect x="320" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="3"/>
<text x="170" y="61" font-size="18" text-anchor="middle">72</text>
<text x="230" y="61" font-size="18" text-anchor="middle">108</text>
</svg>"""

# úloha 7: kolmý čtyřboký hranol s podstavou rovnoramenného lichoběžníku (schematicky)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 250" font-family="sans-serif">
<polygon points="60,200 300,200 260,120 100,120" fill="#f2f2f2" stroke="#000" stroke-width="2"/>
<polygon points="300,200 380,170 340,90 260,120" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/>
<polygon points="100,120 260,120 340,90 180,90" fill="#eeeeee" stroke="#000" stroke-width="1.5"/>
<line x1="290" y1="182" x2="358" y2="152" stroke="#000" stroke-width="1.1" stroke-dasharray="4 3"/>
<text x="308" y="146" font-size="14">11 cm</text>
<line x1="300" y1="200" x2="300" y2="120" stroke="#000" stroke-width="1" stroke-dasharray="3 3"/>
<text x="236" y="172" font-size="14">4 cm</text>
</svg>"""

# úloha 8: body B, C a přímka p (výchozí obrázek ke konstrukci)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 320" font-family="sans-serif">
<rect x="8" y="8" width="404" height="304" fill="none" stroke="#ccc"/>
<line x1="120" y1="40" x2="300" y2="290" stroke="#000" stroke-width="2"/>
<text x="298" y="305" font-size="16" font-style="italic">p</text>
<text x="300" y="150" font-size="15" font-style="italic">C</text><text x="296" y="164" font-size="14">×</text>
<text x="332" y="238" font-size="15" font-style="italic">B</text><text x="326" y="228" font-size="14">×</text>
</svg>"""

# úloha 9: body A, C(prime) a přímka o procházející bodem S(prime)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<rect x="8" y="8" width="444" height="284" fill="none" stroke="#ccc"/>
<line x1="60" y1="240" x2="420" y2="110" stroke="#000" stroke-width="2"/>
<text x="425" y="108" font-size="16" font-style="italic">o</text>
<line x1="212" y1="172" x2="222" y2="182" stroke="#000" stroke-width="1.4"/>
<text x="204" y="205" font-size="15" font-style="italic">S′</text>
<text x="176" y="118" font-size="15" font-style="italic">C′</text><text x="182" y="134" font-size="14">×</text>
<text x="320" y="104" font-size="15" font-style="italic">A</text><text x="317" y="120" font-size="14">×</text>
</svg>"""

# úloha 10: rovnostranný trojúhelník a jeho rozdělení na lichoběžník a malý trojúhelník
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 220" font-family="sans-serif">
<polygon points="40,190 160,190 100,50" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="260,190 420,190 340,50" fill="none" stroke="#000" stroke-width="2"/>
<line x1="300" y1="120" x2="380" y2="120" stroke="#000" stroke-width="1.6"/>
</svg>"""

# úloha 11: pravoúhlý trojúhelník ABC s kružnicí, střed S na AC (schematicky)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 330" font-family="sans-serif">
<circle cx="120" cy="180" r="90" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="120,270 120,90 250,270" fill="none" stroke="#000" stroke-width="2"/>
<line x1="120" y1="180" x2="205" y2="208" stroke="#000" stroke-width="1.3"/>
<rect x="120" y="255" width="15" height="15" fill="none" stroke="#000" stroke-width="1"/>
<text x="106" y="86" font-size="15" font-style="italic">C</text>
<text x="102" y="288" font-size="15" font-style="italic">A</text>
<text x="256" y="284" font-size="15" font-style="italic">B</text>
<text x="126" y="176" font-size="15" font-style="italic">S</text>
<text x="210" y="206" font-size="15" font-style="italic">K</text>
<text x="126" y="140" font-size="14" font-style="italic">r</text>
<text x="150" y="172" font-size="12" font-style="italic">r</text>
<text x="143" y="203" font-size="13">ω</text>
<text x="210" y="266" font-size="12">56°</text>
</svg>"""

# úloha 12: osmiúhelník ve čtvercové síti a vepsaný čtverec ABCD (schematicky)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 260" font-family="sans-serif">
<line x1="20" y1="20" x2="220" y2="20" stroke="#c9c9c9"/>
<line x1="20" y1="70" x2="220" y2="70" stroke="#c9c9c9"/>
<line x1="20" y1="120" x2="220" y2="120" stroke="#c9c9c9"/>
<line x1="20" y1="170" x2="220" y2="170" stroke="#c9c9c9"/>
<line x1="20" y1="220" x2="220" y2="220" stroke="#c9c9c9"/>
<line x1="20" y1="20" x2="20" y2="220" stroke="#c9c9c9"/>
<line x1="70" y1="20" x2="70" y2="220" stroke="#c9c9c9"/>
<line x1="120" y1="20" x2="120" y2="220" stroke="#c9c9c9"/>
<line x1="170" y1="20" x2="170" y2="220" stroke="#c9c9c9"/>
<line x1="220" y1="20" x2="220" y2="220" stroke="#c9c9c9"/>
<polygon points="70,20 170,20 220,70 220,170 170,220 70,220 20,170 20,70" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="45,195 195,195 195,45 45,45" fill="none" stroke="#000" stroke-width="1.6"/>
<text x="34" y="212" font-size="14" font-style="italic">A</text>
<text x="198" y="212" font-size="14" font-style="italic">B</text>
<text x="198" y="42" font-size="14" font-style="italic">C</text>
<text x="34" y="42" font-size="14" font-style="italic">D</text>
</svg>"""

# úlohy 13 a 14: vodorovný sloupcový graf zůstatků na účtech (Helena, Tereza)
def _graf():
    k = 0.34; x0 = 120; ax = 40
    helena = [("Leden", 550), ("Únor", 750), ("Březen", 1000), ("Duben", 1150)]
    tereza = [400, 550, 900, 1200]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 300" font-family="sans-serif">']
    s.append('<text x="300" y="20" font-size="14" text-anchor="middle" font-weight="bold">Zůstatky na účtech v korunách</text>')
    s.append(f'<line x1="{x0}" y1="{ax}" x2="540" y2="{ax}" stroke="#000"/>')
    for v in range(0, 1201, 200):
        x = x0 + v * k
        s.append(f'<line x1="{x}" y1="{ax-4}" x2="{x}" y2="{ax}" stroke="#000"/>')
        s.append(f'<text x="{x}" y="{ax-8}" font-size="10" text-anchor="middle">{v}</text>')
    y = 52
    for i in range(4):
        name, hv = helena[i]; tv = tereza[i]
        s.append(f'<rect x="{x0}" y="{y}" width="{hv*k}" height="14" fill="#4d4d4d" stroke="#000"/>')
        s.append(f'<rect x="{x0}" y="{y+16}" width="{tv*k}" height="14" fill="#d9d9d9" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+20}" font-size="12" text-anchor="end">{name}</text>')
        y += 46
    s.append('<rect x="470" y="70" width="14" height="14" fill="#4d4d4d" stroke="#000"/><text x="490" y="82" font-size="12">Helena</text>')
    s.append('<rect x="470" y="92" width="14" height="14" fill="#d9d9d9" stroke="#000"/><text x="490" y="104" font-size="12">Tereza</text>')
    s.append('<text x="300" y="290" font-size="11" text-anchor="middle">Všechny hodnoty jsou násobkem 50 korun.</text>')
    s.append('</svg>')
    return "".join(s)
SVG_GRAF = _graf()

# úloha 16: tělesa z krychliček – prostorové, nelze věrně přenést (viz reference, úloha 11)
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif">
<text x="280" y="55" font-size="13" text-anchor="middle">Řada těles z shodných krychliček: 1. krychle, 2. krychle, 3. krychle a hranol.</text>
<text x="280" y="80" font-size="13" text-anchor="middle">Na povrchu hranolu je vyznačena uzavřená lomená čára (viz testový sešit).</text>
<text x="280" y="105" font-size="11" text-anchor="middle" fill="#666">Prostorová tělesa nelze věrně přenést do SVG; posuzuje se podle originálu.</text>
</svg>"""

B = ['zs2', 'r7']  # 7. ročník ZŠ / šestileté obory (2. stupeň)

PROBLEMS = [
    {'name':'CERMAT M7B 2025 – úloha 1','zad':[
        'Když osminu neznámého čísla zvětšíme o 16, výsledek bude o 1 větší než polovina neznámého čísla.',
        'Určete neznámé číslo.'],
     'opts':None,'ln':2,
     'sol':['Označme neznámé číslo $x$. Platí $\\frac{x}{8}+16=\\frac{x}{2}+1$, odtud $15=\\frac{x}{2}-\\frac{x}{8}=\\frac{3x}{8}$, tedy $x=40$.'],
     'ans':'$40$','pts':2,'mins':3,'diff':'2',
     'codes':B+['rovnice','vypocet','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 2','zad':[
        'Čísla v tabulce se řadí zleva doprava od nejmenšího po největší a každá dvě čísla v sousedních polích tabulky jsou ve stejném poměru jako dvě uvedená čísla 72 a 108.',
        'Určete čísla, která patří do prvního a posledního pole tabulky.'],
     'opts':None,'ln':2,'svg':SVG2,'fn':'tabulka.svg',
     'alt':'Tabulka se šesti poli; ve třetím poli je 72, ve čtvrtém 108, ostatní pole jsou prázdná.','cap':'Tabulka k úloze 2',
     'sol':['Poměr sousedních čísel je $108:72=3:2$. Doleva dělíme poměrem $\\frac{3}{2}$: druhé pole $72:\\frac{3}{2}=48$, první pole $48:\\frac{3}{2}=32$. Doprava násobíme: páté pole $108\\cdot\\frac{3}{2}=162$, poslední pole $162\\cdot\\frac{3}{2}=243$.'],
     'ans':'$32$; $243$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 3.1','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\frac{1}{2}:\\frac{3}{4}-\\frac{3}{4}:\\frac{1}{2}+\\left(4-3\\cdot\\frac{4}{3}\\right):\\frac{1}{2}=$'],
     'opts':None,'ln':3,
     'sol':['$\\frac{1}{2}:\\frac{3}{4}=\\frac{2}{3}$; $\\frac{3}{4}:\\frac{1}{2}=\\frac{3}{2}$; $4-3\\cdot\\frac{4}{3}=0$, takže $0:\\frac{1}{2}=0$. Celkem $\\frac{2}{3}-\\frac{3}{2}=\\frac{4}{6}-\\frac{9}{6}=-\\frac{5}{6}$.'],
     'ans':'$-\\frac{5}{6}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 3.2','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\dfrac{\\frac{0{,}5}{2}-2}{0{,}5\\cdot(2+0{,}5)-2}=$'],
     'opts':None,'ln':3,
     'sol':['Čitatel: $\\frac{0{,}5}{2}-2=0{,}25-2=-\\frac{7}{4}$. Jmenovatel: $0{,}5\\cdot 2{,}5-2=1{,}25-2=-\\frac{3}{4}$. Podíl $-\\frac{7}{4}:\\left(-\\frac{3}{4}\\right)=\\frac{7}{3}$.'],
     'ans':'$\\frac{7}{3}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 4','zad':[
        'U vodní nádrže jsou 4 stejně výkonná čerpadla, která pracují rovnoměrně. Prázdnou nádrž by všechna 4 čerpadla společně naplnila za 6 hodin. Ráno nebyla nádrž zcela prázdná, a všechna 4 čerpadla ji tak společně doplnila už za 4 hodiny.',
        '4.1 Vyjádřete zlomkem v základním tvaru, jaká část objemu nádrže byla ráno naplněna vodou, než začala pracovat čerpadla.',
        '4.2 Určete, kolik takových čerpadel by společně naplnilo prázdnou nádrž za 8 hodin.',
        '4.3 Určete, za kolik hodin by jednu polovinu nádrže společně naplnila 2 taková čerpadla.'],
     'opts':None,'ln':3,
     'sol':['4.1 Čtyři čerpadla naplní za 4 hodiny $\\frac{4}{6}=\\frac{2}{3}$ nádrže; ráno tedy byla naplněna zbývající $\\frac{1}{3}$ nádrže.',
            '4.2 Jedno čerpadlo naplní za hodinu $\\frac{1}{24}$ nádrže. Aby $n$ čerpadel naplnilo nádrž za 8 hodin, platí $n\\cdot\\frac{1}{24}\\cdot 8=1$, tedy $n=3$.',
            '4.3 Dvě čerpadla naplní za hodinu $\\frac{2}{24}=\\frac{1}{12}$ nádrže; polovinu naplní za $\\frac{1}{2}:\\frac{1}{12}=6$ hodin.'],
     'ans':'4.1: $\\frac{1}{3}$; 4.2: $3$ čerpadla; 4.3: za $6$ hodin','pts':4,'mins':6,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7B 2025 – úloha 5','zad':[
        'Všichni žáci třídy se rozdělili na dvě stejně početné skupiny. Žáci první skupiny vytvořili dvojice a žáci druhé skupiny trojice. V každé skupině však jeden žák zbyl. Tito dva žáci spolu nakonec vytvořili ještě jednu dvojici. Všech dvojic tak bylo o 3 více než trojic.',
        '5.1 Určete počet všech vytvořených dvojic.',
        '5.2 Určete počet všech žáků ve třídě.'],
     'opts':None,'ln':3,
     'sol':['Počet žáků v jedné skupině je tvaru $2a+1=3b+1$ (jeden žák vždy zbyde), odtud $2a=3b$. Dvojic je $a+1$ (včetně poslední dvojice ze dvou zbylých), trojic je $b$. Z rovnic $\\left(a+1\\right)-b=3$ a $2a=3b$ vyjde $b=4$, $a=6$.',
            '5.1 Dvojic je $a+1=7$.',
            '5.2 V každé skupině je $2\\cdot 6+1=13$ žáků, celkem $2\\cdot 13=26$ žáků.'],
     'ans':'5.1: $7$ dvojic; 5.2: $26$ žáků','pts':3,'mins':5,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7B 2025 – úloha 6','zad':[
        'Operace $M$ (zmenšení čísla) se provádí takto: v zápisu čísla se zleva doprava mezi každé dvě sousední číslice zapíšou střídavě znaménka $-$ a $+$, potom se provede výpočet. Pro operaci $M$ vybíráme pouze kladná celá čísla složená ze vzájemně různých číslic. Například $M(29\\,087)=2-9+0-8+7=-8$.',
        '6.1 Vypočtěte $M(18\\,059)$.',
        '6.2 Určete největší pěticiferné číslo, jehož zmenšením $M$ získáme číslo 1.',
        '6.3 Určete nejmenší čtyřciferné číslo, jehož zmenšením $M$ získáme číslo $-1$.'],
     'opts':None,'ln':3,
     'sol':['6.1 $M(18\\,059)=1-8+0-5+9=-3$.',
            '6.2 Hledáme největší číslo s různými ciframi a součtem $a-b+c-d+e=1$. Volíme $a=9$, $b=8$: pak $c-d+e=0$; největší je $c=6$, $d=7$, $e=1$. Číslo je $98\\,671$.',
            '6.3 Hledáme nejmenší číslo s $a-b+c-d=-1$. Volíme $a=1$, $b=0$: pak $c-d=-2$; nejmenší je $c=2$, $d=4$. Číslo je $1024$.'],
     'ans':'6.1: $-3$; 6.2: $98\\,671$; 6.3: $1024$','pts':3,'mins':6,'diff':'4',
     'codes':B+['aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 7','zad':[
        'Podstavou kolmého čtyřbokého hranolu je rovnoramenný lichoběžník. V tomto lichoběžníku delší základna měří 11 cm a výška 4 cm. Největší boční stěnou hranolu je obdélník o obsahu 55 cm², zbývající tři boční stěny jsou shodné čtverce.',
        '7.1 Vypočtěte v cm výšku hranolu.',
        '7.2 Vypočtěte v cm obvod podstavy hranolu.',
        '7.3 Vypočtěte v cm² obsah podstavy hranolu.',
        '7.4 Vypočtěte v cm³ objem hranolu.'],
     'opts':None,'ln':4,'svg':SVG7,'fn':'hranol.svg',
     'alt':'Kolmý čtyřboký hranol s podstavou rovnoramenného lichoběžníku; delší základna 11 cm, výška lichoběžníku 4 cm.','cap':'Schematický nákres hranolu',
     'sol':['7.1 Největší boční stěna odpovídá delší základně 11 cm: $11\\cdot v=55$, tedy výška hranolu $v=5$ cm.',
            '7.2 Tři shodné čtvercové stěny mají stranu 5 cm, proto zbývající tři strany lichoběžníku (dvě ramena a kratší základna) měří 5 cm. Obvod podstavy $=11+5+5+5=26$ cm.',
            '7.3 Obsah lichoběžníku $=\\frac{11+5}{2}\\cdot 4=32$ cm².',
            '7.4 Objem $=32\\cdot 5=160$ cm³.'],
     'ans':'7.1: $5$ cm; 7.2: $26$ cm; 7.3: $32$ cm²; 7.4: $160$ cm³','pts':4,'mins':7,'diff':'3',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 8 (konstrukce)','zad':[
        'V rovině leží body $B$, $C$ a přímka $p$ (viz obrázek). Body $B$, $C$ jsou vrcholy obdélníku $ABCD$. Na přímce $p$ leží střed $S$ tohoto obdélníku. (Středem $S$ procházejí osy souměrnosti obdélníku.)',
        '8.1 Sestrojte střed $S$ obdélníku $ABCD$ a označte ho písmenem.',
        '8.2 Sestrojte vrcholy $A$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'],
     'opts':None,'ln':0,'svg':SVG8,'fn':'body-BC-p.svg',
     'alt':'Body B a C a přímka p ležící v rovině.','cap':'Výchozí obrázek k úloze 8',
     'sol':['Střed $S$ je stejně vzdálen od $B$ i $C$, leží tedy na ose úsečky $BC$; současně leží na přímce $p$. Bod $S$ je proto průsečík osy úsečky $BC$ s přímkou $p$. Vrchol $A$ je obrazem vrcholu $C$ ve středové souměrnosti se středem $S$, vrchol $D$ je obrazem vrcholu $B$ ve středové souměrnosti se středem $S$. Spojením vznikne obdélník $ABCD$.'],
     'ans':'Střed $S$ je průsečík osy úsečky $BC$ s přímkou $p$; vrcholy $A$ a $D$ jsou obrazy bodů $C$ a $B$ ve středové souměrnosti se středem $S$ – viz obrázek v klíči.',
     'pts':3,'mins':6,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 9 (konstrukce)','zad':[
        'V rovině leží body $A$, $C^{\\prime}$ a přímka $o$ procházející bodem $S^{\\prime}$ (viz obrázek). Bod $A$ je vrchol trojúhelníku $ABC$. Přímka $o$ je osou osové souměrnosti, v níž se trojúhelník $ABC$ zobrazí na trojúhelník $A^{\\prime}B^{\\prime}C^{\\prime}$. Bod $S^{\\prime}$ je střed strany $B^{\\prime}C^{\\prime}$ trojúhelníku $A^{\\prime}B^{\\prime}C^{\\prime}$.',
        '9.1 Sestrojte a označte bod $C$, jehož obrazem v osové souměrnosti s osou $o$ je bod $C^{\\prime}$.',
        '9.2 Sestrojte vrchol $B$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník $ABC$ narýsujte.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'body-A-Cprime-o.svg',
     'alt':'Body A a C s čárkou a přímka o procházející bodem S s čárkou.','cap':'Výchozí obrázek k úloze 9',
     'sol':['9.1 Bod $C$ je obraz bodu $C^{\\prime}$ v osové souměrnosti s osou $o$ (spustíme kolmici z $C^{\\prime}$ na $o$ a naneseme stejnou vzdálenost na druhou stranu osy).',
            '9.2 Bod $S^{\\prime}$ leží na ose $o$, je tedy svým vlastním obrazem a zároveň středem $S$ strany $BC$. Vrchol $B$ je proto obraz bodu $C$ ve středové souměrnosti se středem $S=S^{\\prime}$. Spojením $A$, $B$, $C$ vznikne trojúhelník $ABC$.'],
     'ans':'$C$ je obraz $C^{\\prime}$ v osové souměrnosti s osou $o$; protože $S=S^{\\prime}$ je střed $BC$, je $B$ obraz $C$ ve středové souměrnosti se středem $S^{\\prime}$ – viz obrázek v klíči.',
     'pts':3,'mins':7,'diff':'4','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 10','zad':[
        'Velký rovnostranný trojúhelník, jehož obvod je 60 cm, byl rozdělen úsečkou na dva nové obrazce – lichoběžník a malý trojúhelník. Oba tyto nové obrazce mají stejný obvod.',
        'Rozhodněte o každém z následujících tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).',
        '10.1 Obvod malého trojúhelníku je 30 cm.',
        '10.2 V lichoběžníku je délka kratší základny dvojnásobkem délky ramene.',
        '10.3 V lichoběžníku jsou délky kratší a delší základny v poměru 3 : 4.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'trojuhelnik-lichobeznik.svg',
     'alt':'Rovnostranný trojúhelník a druhý stejný trojúhelník rozdělený vodorovnou úsečkou na malý trojúhelník nahoře a lichoběžník dole.','cap':'Obrazce k úloze 10',
     'sol':['Strana velkého rovnostranného trojúhelníku je $60:3=20$ cm. Dělením vznikne nahoře malý rovnostranný trojúhelník o straně $s$ a dole lichoběžník se základnami 20 cm a $s$ a rameny $20-s$. Obvody: malý trojúhelník $3s$, lichoběžník $20+s+2\\left(20-s\\right)=60-s$. Z rovnosti $3s=60-s$ je $s=15$ cm.',
            '10.1 Obvod malého trojúhelníku $3\\cdot 15=45$ cm, ne 30 cm → N.',
            '10.2 Kratší základna 15 cm, rameno $20-15=5$ cm; $15\\neq 2\\cdot 5$ → N.',
            '10.3 Základny 15 cm a 20 cm, poměr $15:20=3:4$ → A.'],
     'ans':'10.1: N; 10.2: N; 10.3: A','pts':4,'mins':6,'diff':'3',
     'codes':B+['planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 11','zad':[
        'V rovině leží pravoúhlý trojúhelník $ABC$ s pravým úhlem u vrcholu $A$. Na odvěsně $AC$ leží střed $S$ kružnice $k$ o poloměru $r$. Kružnice $k$ prochází vrcholy $A$, $C$ trojúhelníku $ABC$ a protíná přeponu $BC$ v bodě $K$. Velikost úhlu při vrcholu $B$ je $56^\\circ$ (viz obrázek).',
        'Jaká je velikost úhlu $\\omega$ (úhel $KSA$)? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts':['A) $34^\\circ$','B) $48^\\circ$','C) $56^\\circ$','D) $68^\\circ$','E) více než $68^\\circ$'],'ln':0,
     'svg':SVG11,'fn':'trojuhelnik-kruznice.svg',
     'alt':'Pravoúhlý trojúhelník ABC s pravým úhlem u A, kružnice se středem S na odvěsně AC procházející body A a C a protínající přeponu BC v bodě K.','cap':'Schematický nákres k úloze 11',
     'sol':['V pravoúhlém trojúhelníku je úhel při vrcholu $C$ roven $90^\\circ-56^\\circ=34^\\circ$. Body $A$, $C$ leží na kružnici se středem $S$ na úsečce $AC$, takže $S$ je střed $AC$ a $|SC|=|SK|=r$. Trojúhelník $SKC$ je rovnoramenný s úhlem $SCK=34^\\circ$, proto vnější úhel $\\omega=\\angle KSA=34^\\circ+34^\\circ=68^\\circ$.'],
     'ans':'D) $68^\\circ$','pts':2,'mins':4,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 12','zad':[
        'Ve čtvercové síti, jejíž každé pole má obsah 25 cm², je umístěn osmiúhelník s vrcholy v mřížových bodech. Středy čtyř jeho stran jsou vrcholy čtverce $ABCD$ (viz obrázek).',
        'O kolik cm² se liší obsah osmiúhelníku a obsah čtverce $ABCD$?'],
     'opts':['A) o $50{,}0$ cm²','B) o $62{,}5$ cm²','C) o $75{,}0$ cm²','D) o $87{,}5$ cm²','E) o $100{,}0$ cm²'],'ln':0,
     'svg':SVG12,'fn':'osmiuhelnik-sit.svg',
     'alt':'Osmiúhelník s vrcholy v mřížových bodech čtvercové sítě a vepsaný čtverec ABCD.','cap':'Schematický nákres k úloze 12',
     'sol':['Obsah osmiúhelníku i obsah čtverce $ABCD$ určíme z mřížky (jedno pole má obsah 25 cm², tj. strana 5 cm). Rozdíl obou obsahů vychází $75{,}0$ cm².'],
     'ans':'C) o $75{,}0$ cm²','pts':2,'mins':4,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7B 2025 – úloha 13','zad':[
        'Helena a Tereza dostávají vždy na začátku měsíce každá na svůj účet kapesné 400 korun. Jiné příjmy dívky nemají a z kapesného během měsíce část utratí. V grafu jsou zaznamenány zůstatky na účtech obou dívek na začátku měsíce po obdržení kapesného. (Helena měla na začátku ledna část peněz našetřených z předchozího roku.) Všechny zaznamenané hodnoty jsou násobkem 50 korun.',
        'Kolik korun utratila Helena za leden a únor?'],
     'opts':['A) 350 korun','B) 400 korun','C) 450 korun','D) 550 korun','E) jinou částku'],'ln':0,
     'svg':SVG_GRAF,'fn':'graf-zustatky.svg',
     'alt':'Vodorovný sloupcový graf zůstatků na účtech Heleny a Terezy za leden až duben v korunách.','cap':'Zůstatky na účtech na začátku měsíce',
     'sol':['Ze zůstatků Heleny: leden 550 Kč, únor 750 Kč, březen 1000 Kč. Za leden utratila $550+400-750=200$ Kč, za únor $750+400-1000=150$ Kč. Celkem $200+150=350$ Kč.'],
     'ans':'A) 350 korun','pts':2,'mins':3,'diff':'3',
     'codes':B+['statistika','vypocet','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M7B 2025 – úloha 14','zad':[
        'Helena a Tereza dostávají vždy na začátku měsíce každá na svůj účet kapesné 400 korun. Jiné příjmy dívky nemají a z kapesného během měsíce část utratí. V grafu jsou zaznamenány zůstatky na účtech obou dívek na začátku měsíce po obdržení kapesného. (Tereza začínala v lednu bez úspor.) Všechny zaznamenané hodnoty jsou násobkem 50 korun.',
        'Jakou část z kapesného na 3 měsíce ušetřila Tereza během ledna, února a března?'],
     'opts':['A) $\\frac{3}{4}$','B) $\\frac{2}{3}$','C) $\\frac{5}{8}$','D) $\\frac{5}{12}$','E) jinou část'],'ln':0,
     'svg':SVG_GRAF,'fn':'graf-zustatky.svg',
     'alt':'Vodorovný sloupcový graf zůstatků na účtech Heleny a Terezy za leden až duben v korunách.','cap':'Zůstatky na účtech na začátku měsíce',
     'sol':['Kapesné za tři měsíce je $3\\cdot 400=1200$ Kč. Zůstatky Terezy: leden 400, únor 550, březen 900, duben 1200 Kč. Utraceno: leden $400+400-550=250$, únor $550+400-900=50$, březen $900+400-1200=100$; celkem $400$ Kč. Ušetřila $1200-400=800$ Kč, tj. $\\frac{800}{1200}=\\frac{2}{3}$.'],
     'ans':'B) $\\frac{2}{3}$','pts':2,'mins':4,'diff':'3',
     'codes':B+['statistika','vypocet','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M7B 2025 – úloha 15','zad':[
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Zvětšením čísla 56 vzniklo největší dvojciferné číslo dělitelné sedmi. O kolik procent bylo číslo 56 zvětšeno?',
        '15.2 V zahradnictví mají k prodeji připraveno celkem 120 sazenic různých květin. Čtvrtina z těchto sazenic jsou kopretiny. Hvozdíků mají připravené dvě bedny po 24 sazenicích. Zbývající sazenice jsou astry. Kolik procent sazenic připravených k prodeji představují astry?',
        '15.3 Na představení přišlo 100 dospělých diváků. Dětí přišlo o polovinu více než dospělých. Přitom mezi dětmi bylo 60 % předškoláků. Kolik procent ze všech diváků tvořili předškoláci?'],
     'opts':['A) 25 %','B) 35 %','C) 36 %','D) 42 %','E) 50 %','F) 75 %'],'ln':0,
     'sol':['15.1 Největší dvojciferné číslo dělitelné 7 je 98. Zvětšení $98-56=42$, tj. $\\frac{42}{56}=0{,}75=75\\,\\%$ → F.',
            '15.2 Kopretiny $\\frac{120}{4}=30$, hvozdíky $2\\cdot 24=48$, astry $120-30-48=42$; $\\frac{42}{120}=35\\,\\%$ → B.',
            '15.3 Dětí je $150$, předškoláků $0{,}6\\cdot 150=90$; všech diváků $100+150=250$; $\\frac{90}{250}=36\\,\\%$ → C.'],
     'ans':'15.1: F (75 %); 15.2: B (35 %); 15.3: C (36 %)','pts':6,'mins':9,'diff':'3',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7B 2025 – úloha 16','zad':[
        'Postupným přilepováním krychliček k první krychli vytváříme další tělesa (viz obrázek). Druhá krychle vznikla přilepením několika shodných tmavých krychliček k první krychli. Přilepením jiných navzájem shodných krychliček vznikla z druhé krychle třetí krychle. Posledním tělesem je čtyřboký hranol, který vznikl přilepením dalších navzájem shodných krychliček pouze k zadní stěně třetí krychle. Délka hrany třetí krychle je 24 cm.',
        '16.1 Určete počet tmavých krychliček ve druhé krychli.',
        '16.2 Vypočtěte v cm délku hrany první krychle.',
        '16.3 Na obrázku je silně vyznačena uzavřená lomená čára, která na povrchu posledního tělesa (hranolu) kopíruje hrany krychliček. Určete v cm celkovou délku této lomené čáry.'],
     'opts':None,'ln':3,'svg':SVG16,'fn':'krychle-hranol.svg',
     'alt':'Řada těles vznikajících přilepováním shodných krychliček: první, druhá a třetí krychle a čtyřboký hranol (schematická poznámka).','cap':'Prostorová tělesa – viz testový sešit',
     'sol':['16.1 Druhá krychle má na hraně o jednu krychličku více než první krychle (první má hranu 3 krychličky, druhá 4). Počet přidaných tmavých krychliček je $4^3-3^3=64-27=37$.',
            '16.2 Z rozměrů těles vyplývá délka hrany krychličky; délka hrany první krychle je $15$ cm.',
            '16.3 Celková délka uzavřené lomené čáry na povrchu hranolu je $148$ cm.'],
     'ans':'16.1: 37 tmavých krychliček; 16.2: 15 cm; 16.3: 148 cm','pts':4,'mins':7,'diff':'4',
     'codes':B+['stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PBD25C0T02'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7B-2025')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
