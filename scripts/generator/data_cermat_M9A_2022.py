# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 9 (čtyřleté obory), varianta A, 1. řádný termín.
# Kód testu: M9PAD22C0T01. 16 úloh (po rozdělení izolovaných počtářských poduúloh 21 úloh), 50 bodů.
# Zdroj odpovědí: klíč správných řešení (KSR) M9PAD22C0T01. Ověřeno se zadáním (TS) a záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 6: domeček = pravidelný čtyřboký hranol (x, x, 20) + kolmý trojboký hranol (odvěsny 6, 8)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 300" font-family="sans-serif">
<polygon points="90,230 190,230 190,130 90,130" fill="#f2f2f2" stroke="#000" stroke-width="2"/>
<polygon points="90,130 126,82 190,130" fill="#e2e2e2" stroke="#000" stroke-width="2"/>
<polyline points="118.8,91.6 128.4,98.8 135.6,89.2" fill="none" stroke="#000" stroke-width="1"/>
<line x1="190" y1="230" x2="260" y2="190" stroke="#000" stroke-width="1.5"/>
<line x1="260" y1="190" x2="260" y2="90" stroke="#000" stroke-width="1.5"/>
<line x1="190" y1="130" x2="260" y2="90" stroke="#000" stroke-width="1.5"/>
<line x1="126" y1="82" x2="196" y2="42" stroke="#000" stroke-width="1.5"/>
<line x1="196" y1="42" x2="260" y2="90" stroke="#000" stroke-width="1.5"/>
<text x="58" y="108" font-size="15">6 cm</text>
<text x="150" y="94" font-size="15">8 cm</text>
<text x="196" y="188" font-size="15" font-style="italic">x</text>
<text x="134" y="252" font-size="15" font-style="italic">x</text>
<text x="230" y="224" font-size="15">20 cm</text>
</svg>"""

# úloha 9: výchozí obrázek – body C, S a přímka q
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="60" y1="110" x2="400" y2="110" stroke="#000" stroke-width="2"/>
<text x="408" y="115" font-size="16" font-style="italic">q</text>
<text x="236" y="180" font-size="18" text-anchor="middle">×</text>
<text x="248" y="172" font-size="15" font-style="italic">S</text>
<text x="200" y="286" font-size="18" text-anchor="middle">×</text>
<text x="206" y="300" font-size="15" font-style="italic">C</text>
</svg>"""

# úloha 10: výchozí obrázek – bod O a přímka p
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="250" y1="80" x2="405" y2="245" stroke="#000" stroke-width="2"/>
<text x="410" y="252" font-size="16" font-style="italic">p</text>
<text x="196" y="200" font-size="18" text-anchor="middle">×</text>
<text x="182" y="212" font-size="15" font-style="italic">O</text>
</svg>"""

# úloha 12: čtyři různoběžné přímky, tři procházejí bodem A; úhly 60, 132, alfa, 3 alfa
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 500" font-family="sans-serif">
<line x1="361" y1="96" x2="321" y2="482" stroke="#000" stroke-width="2"/>
<line x1="149" y1="465" x2="577" y2="311" stroke="#000" stroke-width="2"/>
<line x1="270" y1="20" x2="581" y2="331" stroke="#000" stroke-width="2"/>
<line x1="215" y1="250" x2="446" y2="498" stroke="#000" stroke-width="2"/>
<text x="333" y="176" font-size="20">60°</text>
<text x="495" y="300" font-size="20">132°</text>
<text x="303" y="356" font-size="18" font-style="italic">α</text>
<text x="276" y="424" font-size="18">3α</text>
<text x="340" y="424" font-size="17" font-style="italic">A</text>
</svg>"""

# úloha 13: kruh se středem S rozdělený na 5 shodných výsečí + samostatná výseč
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif">
<circle cx="150" cy="150" r="88" fill="none" stroke="#000" stroke-width="2"/>
<line x1="150" y1="150" x2="150" y2="62" stroke="#000" stroke-width="1.5"/>
<line x1="150" y1="150" x2="66" y2="123" stroke="#000" stroke-width="1.5"/>
<line x1="150" y1="150" x2="98" y2="221" stroke="#000" stroke-width="1.5"/>
<line x1="150" y1="150" x2="202" y2="221" stroke="#000" stroke-width="1.5"/>
<line x1="150" y1="150" x2="234" y2="123" stroke="#000" stroke-width="1.5"/>
<text x="156" y="146" font-size="15" font-style="italic">S</text>
<path d="M 330 160 L 414 130 A 84 84 0 0 1 408 190 Z" fill="none" stroke="#000" stroke-width="2"/>
<text x="372" y="104" font-size="15">Výseč</text>
<text x="320" y="168" font-size="15" font-style="italic">S</text>
</svg>"""

# úloha 14: kruhový graf – 0 bodů (30 %, bílá), 1 bod (60 %, šedá), 2 body (10 %, tmavá)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 310" font-family="sans-serif">
<path d="M 230 160 L 334.6 194.0 A 110 110 0 1 1 165.3 71.0 Z" fill="#c9c9c9" stroke="#000" stroke-width="1.5"/>
<path d="M 230 160 L 230 50 A 110 110 0 0 1 334.6 194.0 Z" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<path d="M 230 160 L 165.3 71.0 A 110 110 0 0 1 230 50 Z" fill="#444444" stroke="#000" stroke-width="1.5"/>
<text x="150" y="36" font-size="15" font-weight="bold">2 body</text>
<text x="170" y="55" font-size="14">10 %</text>
<text x="352" y="112" font-size="15" font-weight="bold">0 bodů</text>
<text x="96" y="258" font-size="15" font-weight="bold">1 bod</text>
<text x="66" y="278" font-size="14">30 soutěžících</text>
</svg>"""

# úloha 15: tabulky sběru papíru (První ročník: 1.A 600, 1.B 600, celkem 1200; Druhý ročník: 2.A, 2.B)
SVG15 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 130" font-family="sans-serif">
<rect x="20" y="20" width="380" height="30" fill="none" stroke="#000"/>
<text x="210" y="40" font-size="14" text-anchor="middle">První ročník</text>
<rect x="20" y="50" width="76" height="30" fill="none" stroke="#000"/>
<rect x="96" y="50" width="76" height="30" fill="none" stroke="#000"/>
<rect x="172" y="50" width="76" height="30" fill="none" stroke="#000"/>
<rect x="248" y="50" width="76" height="30" fill="none" stroke="#000"/>
<rect x="324" y="50" width="76" height="30" fill="none" stroke="#000"/>
<text x="58" y="70" font-size="13" text-anchor="middle">1. A</text>
<text x="134" y="70" font-size="13" text-anchor="middle">1. B</text>
<text x="210" y="70" font-size="13" text-anchor="middle">celkem</text>
<text x="286" y="70" font-size="13" text-anchor="middle">dívky</text>
<text x="362" y="70" font-size="13" text-anchor="middle">chlapci</text>
<rect x="20" y="80" width="76" height="30" fill="none" stroke="#000"/>
<rect x="96" y="80" width="76" height="30" fill="none" stroke="#000"/>
<rect x="172" y="80" width="76" height="30" fill="none" stroke="#000"/>
<rect x="248" y="80" width="76" height="30" fill="none" stroke="#000"/>
<rect x="324" y="80" width="76" height="30" fill="none" stroke="#000"/>
<text x="58" y="100" font-size="13" text-anchor="middle">600 kg</text>
<text x="134" y="100" font-size="13" text-anchor="middle">600 kg</text>
<text x="210" y="100" font-size="13" text-anchor="middle">1 200 kg</text>
<rect x="452" y="20" width="152" height="30" fill="none" stroke="#000"/>
<text x="528" y="40" font-size="14" text-anchor="middle">Druhý ročník</text>
<rect x="452" y="50" width="76" height="30" fill="none" stroke="#000"/>
<rect x="528" y="50" width="76" height="30" fill="none" stroke="#000"/>
<text x="490" y="70" font-size="13" text-anchor="middle">2. A</text>
<text x="566" y="70" font-size="13" text-anchor="middle">2. B</text>
<rect x="452" y="80" width="76" height="30" fill="none" stroke="#000"/>
<rect x="528" y="80" width="76" height="30" fill="none" stroke="#000"/>
</svg>"""

B = ['zs2', 'r9']  # 9. ročník ZŠ, přijímačky na čtyřleté obory

PROBLEMS = [
    {'name':'CERMAT M9A 2022 – úloha 1','zad':[
        'Vypočtěte: $\\dfrac{7^2-\\sqrt{7^2}}{\\sqrt{49}}=$'],
     'opts':None,'ln':2,
     'sol':['$\\sqrt{7^2}=7$ a $\\sqrt{49}=7$, tedy $\\dfrac{49-7}{7}=\\dfrac{42}{7}=6$.'],
     'ans':'$6$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 2.1','zad':[
        'Obdélník má šířku $8$ cm a obsah $4$ dm².',
        'Vypočtěte, o kolik cm se liší délka a šířka obdélníku.'],
     'opts':None,'ln':2,
     'sol':['$4$ dm² $=400$ cm². Délka $=400:8=50$ cm, šířka je $8$ cm, rozdíl $50-8=42$ cm.'],
     'ans':'o $42$ cm','pts':1,'mins':2,'diff':'2',
     'codes':B+['planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 2.2','zad':[
        'Vypočtěte, kolikrát větší je objem $1{,}2$ dm³ než objem $300$ mm³.'],
     'opts':None,'ln':2,
     'sol':['$1{,}2$ dm³ $=1\\,200\\,000$ mm³; podíl $1\\,200\\,000:300=4\\,000$.'],
     'ans':'$4\\,000$krát','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 3.1','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\dfrac{8}{5}\\cdot\\left(\\dfrac{5}{6}\\cdot\\dfrac{7}{10}-\\dfrac{5}{6}\\right)=$'],
     'opts':None,'ln':3,
     'sol':['$\\dfrac{5}{6}\\cdot\\dfrac{7}{10}=\\dfrac{35}{60}=\\dfrac{7}{12}$; $\\dfrac{7}{12}-\\dfrac{5}{6}=\\dfrac{7-10}{12}=-\\dfrac{1}{4}$; $\\dfrac{8}{5}\\cdot\\left(-\\dfrac{1}{4}\\right)=-\\dfrac{8}{20}=-\\dfrac{2}{5}$.'],
     'ans':'$-\\dfrac{2}{5}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 3.2','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\dfrac{\\left(\\dfrac{4}{5}-\\dfrac{2}{3}\\right)\\cdot\\dfrac{5}{8}}{\\dfrac{2}{3}}=$'],
     'opts':None,'ln':3,
     'sol':['$\\dfrac{4}{5}-\\dfrac{2}{3}=\\dfrac{12-10}{15}=\\dfrac{2}{15}$; $\\dfrac{2}{15}\\cdot\\dfrac{5}{8}=\\dfrac{10}{120}=\\dfrac{1}{12}$; $\\dfrac{1}{12}:\\dfrac{2}{3}=\\dfrac{1}{12}\\cdot\\dfrac{3}{2}=\\dfrac{3}{24}=\\dfrac{1}{8}$.'],
     'ans':'$\\dfrac{1}{8}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 4.1','zad':[
        'Z daného výrazu vytkněte $3y$:',
        '$3y^2-9y+6xy=$'],
     'opts':None,'ln':2,
     'sol':['$3y^2-9y+6xy=3y\\cdot(y-3+2x)$.'],
     'ans':'$3y\\cdot(y-3+2x)$','pts':1,'mins':2,'diff':'2',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 4.2','zad':[
        'Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky):',
        '$\\left(x+\\dfrac{3}{2}\\right)^2=$'],
     'opts':None,'ln':2,
     'sol':['$\\left(x+\\dfrac{3}{2}\\right)^2=x^2+2\\cdot x\\cdot\\dfrac{3}{2}+\\dfrac{9}{4}=x^2+3x+\\dfrac{9}{4}$.'],
     'ans':'$x^2+3x+\\dfrac{9}{4}$','pts':1,'mins':2,'diff':'2',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 4.3','zad':[
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky):',
        '$(4+3n)\\cdot(3n-2n)-(n-1)\\cdot 5n=$'],
     'opts':None,'ln':3,
     'sol':['$3n-2n=n$, tedy $(4+3n)\\cdot n=4n+3n^2$ a $(n-1)\\cdot 5n=5n^2-5n$; $4n+3n^2-(5n^2-5n)=-2n^2+9n$.'],
     'ans':'$-2n^2+9n$','pts':2,'mins':3,'diff':'3',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 5.1','zad':[
        'Řešte rovnici:',
        '$5\\cdot 0{,}4-3x:2=0{,}5x+7$'],
     'opts':None,'ln':3,
     'sol':['$2-1{,}5x=0{,}5x+7$; $-1{,}5x-0{,}5x=7-2$; $-2x=5$; $x=-2{,}5$.'],
     'ans':'$x=-2{,}5$','pts':2,'mins':3,'diff':'3',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 5.2','zad':[
        'Řešte rovnici:',
        '$\\dfrac{3-y}{3}+\\dfrac{3}{5}\\cdot(y+1)+\\dfrac{y}{3}=y$'],
     'opts':None,'ln':3,
     'sol':['$\\dfrac{3-y}{3}+\\dfrac{y}{3}=\\dfrac{3}{3}=1$, tedy $1+\\dfrac{3}{5}(y+1)=y$. Po vynásobení pěti: $5+3(y+1)=5y$; $5+3y+3=5y$; $8=2y$; $y=4$.'],
     'ans':'$y=4$','pts':2,'mins':3,'diff':'3',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 6','zad':[
        'Domeček je vytvořen z pravidelného čtyřbokého hranolu a kolmého trojbokého hranolu. Oba hranoly mají jednu stěnu společnou. Rozměry čtyřbokého hranolu jsou $x$, $x$ a $20$ cm. Podstavou trojbokého hranolu je pravoúhlý trojúhelník s odvěsnami délek $6$ cm a $8$ cm.',
        'Vypočtěte v cm³',
        '6.1 objem trojbokého hranolu,',
        '6.2 objem pravidelného čtyřbokého hranolu.'],
     'opts':None,'ln':2,'svg':SVG6,'fn':'domecek.svg',
     'alt':'Domeček složený z pravidelného čtyřbokého hranolu a kolmého trojbokého hranolu se společnou stěnou; roof odvěsny 6 cm a 8 cm, hrany x, x a 20 cm.',
     'cap':'Domeček – čtyřboký a trojboký hranol se společnou stěnou',
     'sol':['6.1 Podstava trojbokého hranolu je pravoúhlý trojúhelník s obsahem $\\dfrac{6\\cdot 8}{2}=24$ cm², délka hranolu je $20$ cm, objem $=24\\cdot 20=480$ cm³.',
            '6.2 Společná stěna je čtverec o straně rovné přeponě trojúhelníku $\\sqrt{6^2+8^2}=10$ cm, tedy $x=10$ cm; objem $=10\\cdot 10\\cdot 20=2\\,000$ cm³.'],
     'ans':'6.1: $480$ cm³; 6.2: $2\\,000$ cm³','pts':3,'mins':5,'diff':'3',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 7','zad':[
        'Děti i dospělí užívají doporučené dávky vitaminů denně po celý rok. Dle příbalového letáku je doporučená denní dávka vitaminů pro dítě poloviční než pro dospělého. Dva dospělí spotřebují dohromady jedno balení vitaminů za $30$ dní.',
        'Vypočtěte,',
        '7.1 kolik balení vitaminů spotřebuje jeden dospělý za $360$ dní,',
        '7.2 za kolik dní spotřebuje jedno balení vitaminů jedno dítě,',
        '7.3 za kolik dní spotřebují jedno balení vitaminů dohromady dva dospělí a jedno dítě.'],
     'opts':None,'ln':3,
     'sol':['Dva dospělí spotřebují balení za $30$ dní, jeden dospělý tedy za $60$ dní; dítě má poloviční dávku, spotřebuje balení za $120$ dní.',
            '7.1 $360:60=6$ balení.',
            '7.2 za $120$ dní.',
            '7.3 Za den spotřebují dva dospělí $\\dfrac{1}{30}$ balení a dítě $\\dfrac{1}{120}$ balení, dohromady $\\dfrac{1}{30}+\\dfrac{1}{120}=\\dfrac{5}{120}=\\dfrac{1}{24}$ balení, tj. jedno balení za $24$ dní.'],
     'ans':'7.1: $6$ balení; 7.2: za $120$ dní; 7.3: za $24$ dní','pts':3,'mins':5,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2022 – úloha 8','zad':[
        'Za $4$ dortíky zaplatíme v cukrárně celkem $x$ korun, stejně jako za $5$ koláčů.',
        '8.1 Vyjádřete výrazem s proměnnou $x$, kolik korun zaplatíme v cukrárně za $1$ dortík.',
        '8.2 Vyjádřete výrazem s proměnnou $x$, kolik korun zaplatíme v cukrárně za $4$ koláče.',
        '8.3 V cukrárně jsme za $5$ dortíků a $4$ koláče zaplatili celkem $246$ korun. Vypočtěte, kolik korun jsme zaplatili za jeden dortík.'],
     'opts':None,'ln':3,
     'sol':['8.1 Jeden dortík stojí $\\dfrac{x}{4}$ korun.',
            '8.2 Jeden koláč stojí $\\dfrac{x}{5}$ korun, čtyři koláče tedy $\\dfrac{4}{5}x$ korun.',
            '8.3 $5\\cdot\\dfrac{x}{4}+4\\cdot\\dfrac{x}{5}=246$; $\\dfrac{25x+16x}{20}=246$; $\\dfrac{41x}{20}=246$; $x=120$. Jeden dortík stojí $\\dfrac{120}{4}=30$ korun.'],
     'ans':'8.1: $\\dfrac{x}{4}$; 8.2: $\\dfrac{4}{5}x$; 8.3: $30$ korun','pts':4,'mins':6,'diff':'3',
     'codes':B+['vyrazy','modelovani','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M9A 2022 – úloha 9 (konstrukce)','zad':[
        'V rovině leží body $C$, $S$ a přímka $q$ (viz obrázek).',
        'Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Bod $S$ je střed jednoho ramene tohoto trojúhelníku a na přímce $q$ leží jeden z vrcholů $A$, $B$.',
        'Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'body-CSq.svg',
     'alt':'Body C a S a přímka q v rovině.','cap':'Výchozí obrázek k úloze 9',
     'sol':['Bod $P$, obraz vrcholu $C$ ve středové souměrnosti se středem $S$ (tj. $S$ je střed úsečky $CP$), je koncovým bodem ramene, a je proto jedním z vrcholů základny (v klíči $A_1=B_2$). Kružnice se středem $C$ a poloměrem $|CP|=2|CS|$ protne přímku $q$ ve dvou bodech; ty spolu s $P$ určují dvě rovnoramenná řešení $A_1B_1C$ a $A_2B_2C$ (v každém je jeden vrchol základny na $q$).'],
     'ans':'Dvě řešení. Bod $P$ (v klíči $A_1=B_2$) je obraz $C$ ve středové souměrnosti podle $S$; kružnice se středem $C$ a poloměrem $|CP|=2|CS|$ protne přímku $q$ v bodech $B_1$ a $A_2$. Trojúhelníky $A_1B_1C$ a $A_2B_2C$ – viz obrázek v klíči.',
     'pts':3,'mins':7,'diff':'4',
     'codes':B+['planimetrie','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 10 (konstrukce)','zad':[
        'V rovině leží bod $O$ a přímka $p$ (viz obrázek).',
        'Bod $O$ je střed čtverce $ABCD$, jehož strana $BC$ leží na přímce $p$.',
        'Sestrojte všechny vrcholy čtverce $ABCD$, označte je písmeny a čtverec narýsujte.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'bod-O-p.svg',
     'alt':'Bod O a přímka p v rovině.','cap':'Výchozí obrázek k úloze 10',
     'sol':['Vzdálenost středu $O$ od přímky $p$ je polovina strany čtverce. Sestrojíme patu kolmice z $O$ na $p$ (střed strany $BC$, v klíči $S_{BC}$); na přímce $p$ od ní naneseme na obě strany polovinu strany, čímž dostaneme $B$ a $C$ ($|BC|=2\\cdot|Op|$). Vrcholy $A$ a $D$ jsou obrazy $B$ a $C$ ve středové souměrnosti se středem $O$.'],
     'ans':'Střed strany $BC$ je pata kolmice z $O$ na $p$; $|BC|=2\\cdot|Op|$ a vrcholy $A$, $D$ jsou obrazy $B$, $C$ ve středové souměrnosti podle $O$ – viz obrázek v klíči.',
     'pts':2,'mins':5,'diff':'3',
     'codes':B+['planimetrie','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 11','zad':[
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
        '11.1 Tři čtvrtiny z $200$ minut je totéž jako polovina ze $3$ hodin.',
        '11.2 Dvě třetiny z $2{,}4$ hodiny je více než $1$ hodina a $40$ minut.',
        '11.3 Tři osminy z $5$ dnů je totéž jako pět osmin ze $3$ dnů.'],
     'opts':None,'ln':0,
     'sol':['11.1 $\\dfrac{3}{4}\\cdot 200=150$ min; polovina ze $3$ hodin $=90$ min; $150\\ne 90$ → N.',
            '11.2 $\\dfrac{2}{3}\\cdot 2{,}4=1{,}6$ hodiny $=1$ h $36$ min, což je méně než $1$ h $40$ min → N.',
            '11.3 $\\dfrac{3}{8}\\cdot 5=\\dfrac{15}{8}$ dne a $\\dfrac{5}{8}\\cdot 3=\\dfrac{15}{8}$ dne; jsou stejné → A.'],
     'ans':'11.1: N; 11.2: N; 11.3: A','pts':4,'mins':4,'diff':'3',
     'codes':B+['aritmetika','argumentace','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 12','zad':[
        'V rovině leží čtyři vzájemně různoběžné přímky. Tři z nich procházejí bodem $A$ (viz obrázek).',
        'Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts':['A) $24^\\circ$','B) $27^\\circ$','C) $32^\\circ$','D) $36^\\circ$','E) jiná velikost'],
     'ln':0,'svg':SVG12,'fn':'uhly-A.svg',
     'alt':'Čtyři různoběžné přímky, tři procházejí bodem A; vyznačené úhly 60 stupňů, 132 stupňů, alfa a 3 alfa.',
     'cap':'Výchozí obrázek k úloze 12',
     'sol':['Přímky procházející bodem $A$ (nejstrmější a šikmá) a čtvrtá přímka tvoří trojúhelník s vrcholem $A$ nahoře i vpravo. U horního vrcholu je úhel $60^\\circ$, u pravého vrcholu je vnitřní úhel $180^\\circ-132^\\circ=48^\\circ$. Vnitřní úhel u vrcholu $A$ je $180^\\circ-(\\alpha+3\\alpha)=180^\\circ-4\\alpha$. Ze součtu úhlů v trojúhelníku $60^\\circ+48^\\circ+(180^\\circ-4\\alpha)=180^\\circ$ plyne $4\\alpha=108^\\circ$, tedy $\\alpha=27^\\circ$.'],
     'ans':'B) $27^\\circ$','pts':2,'mins':4,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 13','zad':[
        'Papír tvaru kruhu se středem $S$ a poloměrem $10$ cm byl rozstříhán na $5$ shodných výsečí dle obrázku.',
        'Jaký je obvod jedné výseče? Výsledek je zaokrouhlen na celé cm.'],
     'opts':['A) menší než $25$ cm','B) $25$ cm','C) $30$ cm','D) $33$ cm','E) větší než $33$ cm'],
     'ln':0,'svg':SVG13,'fn':'kruh-vysece.svg',
     'alt':'Kruh se středem S rozdělený pěti poloměry na 5 shodných výsečí a vedle jedna samostatná výseč.',
     'cap':'Kruh rozdělený na 5 shodných výsečí',
     'sol':['Výseč má středový úhel $\\dfrac{360^\\circ}{5}=72^\\circ$. Její obvod tvoří dva poloměry a oblouk: $2\\cdot 10+\\dfrac{72}{360}\\cdot 2\\pi\\cdot 10=20+4\\pi\\doteq 20+12{,}6=32{,}6$ cm, po zaokrouhlení $33$ cm.'],
     'ans':'D) $33$ cm','pts':2,'mins':3,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2022 – úloha 14','zad':[
        'V soutěži mohli jednotliví soutěžící dosáhnout výsledků: $0$ bodů, $1$ bod, nebo $2$ body. Graf znázorňuje rozdělení soutěžících podle výsledků. Po jednom bodu získalo $30$ soutěžících, po dvou bodech $10\\,\\%$ všech soutěžících. Soutěžících, kteří získali po $1$ bodu, bylo dvakrát více než soutěžících bez bodu.',
        'Jaký je aritmetický průměr výsledků všech soutěžících?'],
     'opts':['A) $0{,}8$ bodu','B) $0{,}75$ bodu','C) $0{,}6\\overline{6}$ bodu','D) $0{,}6$ bodu','E) jiný průměr'],
     'ln':0,'svg':SVG14,'fn':'graf-soutez.svg',
     'alt':'Kruhový graf rozdělení soutěžících: 0 bodů, 1 bod (30 soutěžících), 2 body (10 %).',
     'cap':'Rozdělení soutěžících podle výsledků',
     'sol':['Po $1$ bodu $30$ soutěžících, bez bodu polovina, tedy $15$. Nechť je celkem $N$ soutěžících; po $2$ bodech je $0{,}1N$. Pak $15+30+0{,}1N=N$, odtud $0{,}9N=45$ a $N=50$; po $2$ bodech je $5$ soutěžících. Průměr $=\\dfrac{15\\cdot 0+30\\cdot 1+5\\cdot 2}{50}=\\dfrac{40}{50}=0{,}8$ bodu.'],
     'ans':'A) $0{,}8$ bodu','pts':2,'mins':4,'diff':'3',
     'codes':B+['statistika','porozumeni','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2022 – úloha 15','zad':[
        'Ve škole, která má v každém ročníku dvě třídy (A, B), proběhla soutěž ve sběru papíru. V tabulkách jsou uvedeny některé údaje z této soutěže (třídy 1. A a 1. B nasbíraly po $600$ kg, první ročník celkem $1\\,200$ kg).',
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Třída 2. A nasbírala o $25\\,\\%$ méně papíru než třída 1. A. Kolik kg papíru nasbírala třída 2. A?',
        '15.2 Třída 1. B nasbírala o $20\\,\\%$ více papíru než třída 2. B. Kolik kg papíru nasbírala třída 2. B?',
        '15.3 Ze všech žáků prvního ročníku nasbíraly dívky o $50\\,\\%$ více papíru než chlapci. Kolik kg papíru nasbírali dohromady chlapci z prvního ročníku?'],
     'opts':['A) $800$ kg','B) $720$ kg','C) $500$ kg','D) $480$ kg','E) $450$ kg','F) jiný počet kg'],
     'ln':0,'svg':SVG15,'fn':'tabulky-papir.svg',
     'alt':'Dvě tabulky sběru papíru: První ročník (1. A 600 kg, 1. B 600 kg, celkem 1 200 kg, dívky, chlapci) a Druhý ročník (2. A, 2. B).',
     'cap':'Údaje ze soutěže ve sběru papíru',
     'sol':['15.1 $600\\cdot(1-0{,}25)=600\\cdot 0{,}75=450$ kg → E.',
            '15.2 $600=1{,}2\\cdot(\\text{2. B})$, tedy $\\text{2. B}=600:1{,}2=500$ kg → C.',
            '15.3 Chlapci $=c$, dívky $=1{,}5c$; $c+1{,}5c=2{,}5c=1\\,200$, odtud $c=480$ kg → D.'],
     'ans':'15.1: E ($450$ kg); 15.2: C ($500$ kg); 15.3: D ($480$ kg)','pts':6,'mins':6,'diff':'3',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2022 – úloha 16','zad':[
        'Tři děti v jednotlivých kolech hry přidávaly mince do klobouku, který byl na počátku prázdný. Julie přidávala v každém kole $1$ minci. Čeněk přidával mince pouze v každém $4.$ kole, a to vždy $4$ najednou. Pavla přidávala mince pouze v každém $5.$ kole, a to vždy $5$ najednou. Např. po prvních $9$ kolech bylo v klobouku celkem $22$ mincí ($9$ od Julie, $8$ od Čeňka a $5$ od Pavly).',
        '16.1 Určete celkový počet mincí v klobouku po prvních $35$ kolech.',
        '16.2 Čeněk přidal své $4$ mince do klobouku zatím $14$krát. Určete, kolikrát již přidala do klobouku svou pětici mincí Pavla.',
        '16.3 Určete, po kolika kolech od počátku bylo v klobouku přesně $183$ mincí.'],
     'opts':None,'ln':3,
     'sol':['16.1 Julie $35$ mincí, Čeněk $4\\cdot 8=32$ (kola $4,8,\\dots,32$), Pavla $5\\cdot 7=35$ (kola $5,10,\\dots,35$); celkem $35+32+35=102$ mincí.',
            '16.2 Čeněk přidával v každém $4.$ kole, $14$krát tedy po $14\\cdot 4=56$ kolech. Pavla po $56$ kolech přidala $\\lfloor 56:5\\rfloor=11$krát.',
            '16.3 Po $k$ kolech je v klobouku $k+4\\lfloor k:4\\rfloor+5\\lfloor k:5\\rfloor$ mincí. Pro $k=63$: $63+4\\cdot 15+5\\cdot 12=63+60+60=183$; po $63$ kolech.'],
     'ans':'16.1: $102$ mincí; 16.2: $11$krát; 16.3: po $63$ kolech','pts':4,'mins':6,'diff':'4',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PAD22C0T01'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9A-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
