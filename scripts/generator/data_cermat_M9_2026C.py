# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2026, MATEMATIKA 9C, 1. náhradní termín.
# Čtyřleté obory (9. ročník). Kód testu: M9PCD26C0T03. 16 úloh, 50 bodů.
# Po rozdělení nezávislých poduúloh (úlohy 2, 3, 4) vzniká 21 samostatných úloh.
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno vyplněným záznamovým archem (VZA).

# ---- SVG obrázky (bez apostrofů a zpětných lomítek) ----

# úloha 6: dva šestiúhelníky ze dvou bílých rovnostranných a dvou šedých trojúhelníků (schematicky)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 215" font-family="sans-serif">
<text x="140" y="20" font-size="13" text-anchor="middle">1. sestiuhelnik</text>
<polygon points="90,55 190,55 90,185" fill="#c4c4c4" stroke="#000"/>
<polygon points="190,55 190,185 90,185" fill="#c4c4c4" stroke="#000"/>
<polygon points="30,120 90,55 90,185" fill="#ffffff" stroke="#000"/>
<polygon points="250,120 190,55 190,185" fill="#ffffff" stroke="#000"/>
<polygon points="30,120 90,55 190,55 250,120 190,185 90,185" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="150" y="128" font-size="12">10 cm</text>
<text x="420" y="20" font-size="13" text-anchor="middle">2. sestiuhelnik</text>
<polygon points="320,185 420,185 370,95" fill="#c4c4c4" stroke="#000"/>
<polygon points="420,185 520,185 470,95" fill="#c4c4c4" stroke="#000"/>
<polygon points="370,95 470,95 420,185" fill="#ffffff" stroke="#000"/>
<polygon points="370,95 470,95 420,30" fill="#ffffff" stroke="#000"/>
<text x="352" y="200" font-size="12">10 cm</text>
<text x="452" y="200" font-size="12">10 cm</text>
</svg>"""

# úloha 7: velký hranol ABCDEFGH, vpravo šedá krychle (schematický 3D náčrt)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 240" font-family="sans-serif">
<rect x="216" y="100" width="104" height="100" fill="#cfcfcf" stroke="#000"/>
<polygon points="216,100 320,100 360,70 256,70" fill="#dedede" stroke="#000"/>
<polygon points="320,100 360,70 360,170 320,200" fill="#bdbdbd" stroke="#000"/>
<polygon points="60,200 320,200 320,100 60,100" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="60,100 320,100 360,70 100,70" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="320" y1="200" x2="360" y2="170" stroke="#000" stroke-width="1.5"/>
<line x1="360" y1="170" x2="360" y2="70" stroke="#000" stroke-width="1.5"/>
<line x1="216" y1="200" x2="216" y2="100" stroke="#000"/>
<line x1="216" y1="100" x2="256" y2="70" stroke="#000"/>
<line x1="60" y1="200" x2="100" y2="170" stroke="#000" stroke-dasharray="4 4"/>
<line x1="100" y1="170" x2="360" y2="170" stroke="#000" stroke-dasharray="4 4"/>
<line x1="100" y1="170" x2="100" y2="70" stroke="#000" stroke-dasharray="4 4"/>
<text x="50" y="216" font-size="14" font-style="italic">A</text>
<text x="316" y="216" font-size="14" font-style="italic">B</text>
<text x="366" y="184" font-size="14" font-style="italic">C</text>
<text x="86" y="185" font-size="14" font-style="italic">D</text>
<text x="46" y="98" font-size="14" font-style="italic">E</text>
<text x="322" y="96" font-size="14" font-style="italic">F</text>
<text x="366" y="70" font-size="14" font-style="italic">G</text>
<text x="88" y="70" font-size="14" font-style="italic">H</text>
</svg>"""

# úloha 8: pravidelný pětiúhelník ABCDE, osy o1, o2, průsečík S, úsečka AD, úhly 36, fí, omega (ilustrativní)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 260" font-family="sans-serif">
<polygon points="170,50 265,119 229,231 111,231 75,119" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="111" y1="231" x2="170" y2="50" stroke="#000"/>
<line x1="170" y1="50" x2="170" y2="231" stroke="#000"/>
<line x1="111" y1="231" x2="232" y2="65" stroke="#000"/>
<rect x="164" y="225" width="6" height="6" fill="none" stroke="#000"/>
<circle cx="170" cy="150" r="2.5" fill="#000"/>
<text x="176" y="150" font-size="13" font-style="italic">S</text>
<text x="170" y="44" font-size="13" font-style="italic" text-anchor="middle">D</text>
<text x="272" y="120" font-size="13" font-style="italic">C</text>
<text x="235" y="245" font-size="13" font-style="italic">B</text>
<text x="98" y="245" font-size="13" font-style="italic">A</text>
<text x="58" y="120" font-size="13" font-style="italic">E</text>
<text x="150" y="82" font-size="14" font-style="italic">ω</text>
<text x="182" y="84" font-size="14" font-style="italic">φ</text>
<text x="120" y="212" font-size="12">36°</text>
<text x="236" y="62" font-size="12" font-style="italic">o₂</text>
<text x="176" y="226" font-size="12" font-style="italic">o₁</text>
</svg>"""

# úloha 9: přímka p bodem A a bod S (výchozí obrázek)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 280" font-family="sans-serif">
<line x1="40" y1="250" x2="410" y2="95" stroke="#000" stroke-width="1.6"/>
<text x="415" y="92" font-size="14" font-style="italic">p</text>
<circle cx="110" cy="222" r="2.5" fill="#000"/>
<text x="104" y="242" font-size="14" font-style="italic">A</text>
<text x="236" y="150" font-size="16" text-anchor="middle">×</text>
<text x="230" y="140" font-size="14" font-style="italic">S</text>
</svg>"""

# úloha 10: body U, V a přímka k (výchozí obrázek)
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="60" y1="285" x2="430" y2="185" stroke="#000" stroke-width="1.6"/>
<text x="435" y="182" font-size="14" font-style="italic">k</text>
<text x="150" y="202" font-size="16" text-anchor="middle">×</text>
<text x="150" y="190" font-size="14" font-style="italic" text-anchor="middle">U</text>
<text x="300" y="202" font-size="16" text-anchor="middle">×</text>
<text x="300" y="190" font-size="14" font-style="italic" text-anchor="middle">V</text>
</svg>"""

# úloha 11: sloupcový graf rozpisu služeb dětí (pondělí–čtvrtek), páteční údaje chybí
def _bars11():
    days = [("Pondělí",2,4,1),("Úterý",1,3,3),("Středa",3,3,2),("Čtvrtek",1,2,3),("Pátek",None,None,"x")]
    x0,y0 = 60,190; unit=28; bw=13; grp=78
    s=['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 240" font-family="sans-serif">']
    s.append('<text x="18" y="110" font-size="12" text-anchor="middle" transform="rotate(-90 18 110)">Počet dětí</text>')
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="510" y2="{y0}" stroke="#000"/>')
    for v in range(0,6):
        y=y0-v*unit
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    x=x0+16
    for name,a,b,c in days:
        bx=x
        for val,col in ((a,"#555555"),(b,"#eeeeee"),(c,"#9a9a9a")):
            if val=="x":
                pass
            elif val is None:
                s.append(f'<rect x="{bx}" y="{y0-unit}" width="{bw}" height="{unit}" fill="none" stroke="#999" stroke-dasharray="3 3"/>')
            else:
                h=val*unit
                s.append(f'<rect x="{bx}" y="{y0-h}" width="{bw}" height="{h}" fill="{col}" stroke="#000"/>')
            bx+=bw+3
        s.append(f'<text x="{x+22}" y="{y0+16}" font-size="11" text-anchor="middle">{name}</text>')
        x+=grp
    s.append('<rect x="150" y="206" width="12" height="12" fill="#555555" stroke="#000"/><text x="166" y="216" font-size="11">Snídaně</text>')
    s.append('<rect x="250" y="206" width="12" height="12" fill="#eeeeee" stroke="#000"/><text x="266" y="216" font-size="11">Oběd</text>')
    s.append('<rect x="330" y="206" width="12" height="12" fill="#9a9a9a" stroke="#000"/><text x="346" y="216" font-size="11">Večeře</text>')
    s.append('</svg>')
    return "".join(s)
SVG11=_bars11()

# úloha 16: posloupnost obrazců (1. čtverec, 2. a 3. obdélník) – schematicky, ne v měřítku
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 140" font-family="sans-serif">
<text x="50" y="18" font-size="12" text-anchor="middle">1. obrazec</text>
<rect x="20" y="40" width="60" height="60" fill="none" stroke="#000" stroke-width="1.4"/>
<text x="155" y="18" font-size="12" text-anchor="middle">2. obrazec</text>
<rect x="110" y="40" width="90" height="60" fill="none" stroke="#000" stroke-width="1.4"/>
<line x1="170" y1="40" x2="170" y2="100" stroke="#000"/>
<line x1="170" y1="70" x2="200" y2="70" stroke="#000"/>
<text x="285" y="18" font-size="12" text-anchor="middle">3. obrazec</text>
<rect x="230" y="40" width="110" height="60" fill="none" stroke="#000" stroke-width="1.4"/>
<line x1="290" y1="40" x2="290" y2="100" stroke="#000"/>
<line x1="290" y1="70" x2="320" y2="70" stroke="#000"/>
<line x1="320" y1="40" x2="320" y2="100" stroke="#000"/>
<line x1="320" y1="60" x2="340" y2="60" stroke="#000"/>
<line x1="320" y1="80" x2="340" y2="80" stroke="#000"/>
<text x="360" y="78" font-size="22">…</text>
</svg>"""

# ---- Úlohy ----

B = ['zs2', 'r9']  # 9. ročník ZŠ / čtyřleté obory (JPZ)

PROBLEMS = [
    {'name':'CERMAT M9C 2026 – úloha 1','zad':[
        'Pan Červený strávil jízdou v autě přesně 7 hodin, než dojel do cíle. Svou jízdu autem zahájil ráno v 7:44 a přerušil ji jen jednou, když si udělal pauzu na oběd. Z auta vystoupil ve 12:02 a do auta se vrátil za 38 minut. Pak pokračoval v jízdě až do cíle.',
        'Určete, kdy pan Červený dorazil do cíle. Výsledek zapište ve tvaru hodiny : minuty.'],
     'opts':None,'ln':2,
     'sol':['Celková doba jízdy je 7 hodin. Od 7:44 do 12:02 pan Červený jel 4 hodiny a 18 minut. Po 38minutové pauze na oběd znovu vyjel ve 12:40. Zbývá tedy dojet 2 hodiny a 42 minut (7 hodin bez 4 hodin 18 minut). Do cíle dorazil ve 12:40 plus 2 h 42 min, tj. v 15:22.'],
     'ans':'15:22 (tj. 3:22 odpoledne)','pts':1,'mins':4,'diff':'2',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9C 2026 – úloha 2.1','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem: $\\frac{6}{5}:\\frac{9}{15}-2=$'],
     'opts':None,'ln':2,
     'sol':['$\\frac{6}{5}:\\frac{9}{15}-2=\\frac{6}{5}\\cdot\\frac{15}{9}-2=2-2=0$.'],
     'ans':'$0$','pts':1,'mins':2,'diff':'1',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 2.2','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem: $\\frac{5}{44}\\cdot(-5{,}5)=$'],
     'opts':None,'ln':2,
     'sol':['$\\frac{5}{44}\\cdot(-5{,}5)=\\frac{5}{44}\\cdot\\left(-\\frac{11}{2}\\right)=-\\frac{55}{88}=-\\frac{5}{8}$.'],
     'ans':'$-\\frac{5}{8}$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 2.3','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem (uveďte celý postup řešení): $\\dfrac{\\frac{5}{3}-\\frac{3}{5}}{\\frac{8}{7}\\cdot\\frac{14}{5}}=$'],
     'opts':None,'ln':4,
     'sol':['Čitatel: $\\frac{5}{3}-\\frac{3}{5}=\\frac{25-9}{15}=\\frac{16}{15}$. Jmenovatel: $\\frac{8}{7}\\cdot\\frac{14}{5}=\\frac{16}{5}$.',
            'Podíl: $\\frac{16}{15}:\\frac{16}{5}=\\frac{16}{15}\\cdot\\frac{5}{16}=\\frac{5}{15}=\\frac{1}{3}$.'],
     'ans':'$\\frac{1}{3}$','pts':2,'mins':4,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 3.1','zad':[
        'Rozložte na součin užitím vzorce: $6\\cdot 6-25a^2=$'],
     'opts':None,'ln':2,
     'sol':['$36-25a^2=6^2-(5a)^2=(6+5a)\\cdot(6-5a)$.'],
     'ans':'$(6+5a)\\cdot(6-5a)$','pts':1,'mins':2,'diff':'1',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 3.2','zad':[
        'Roznásobte a upravte (výsledný výraz nesmí obsahovat závorky): $4\\cdot\\left(n-\\frac{1}{2}\\right)^2=$'],
     'opts':None,'ln':2,
     'sol':['$4\\cdot\\left(n^2-2\\cdot n\\cdot\\frac{1}{2}+\\frac{1}{4}\\right)=4\\cdot\\left(n^2-n+\\frac{1}{4}\\right)=4n^2-4n+1$.'],
     'ans':'$4n^2-4n+1$','pts':1,'mins':3,'diff':'2',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 3.3','zad':[
        'Upravte na co nejjednodušší tvar bez závorek (uveďte celý postup řešení): $(3-x)\\cdot(3+x)+(x^2+2)\\cdot 3-2x\\cdot(x+1)=$'],
     'opts':None,'ln':4,
     'sol':['$(9-x^2)+(3x^2+6)-(2x^2+2x)=9-x^2+3x^2+6-2x^2-2x$.',
            'Sečtením: kvadratické členy $-x^2+3x^2-2x^2=0$, lineární $-2x$, absolutní $9+6=15$; výsledek $-2x+15$.'],
     'ans':'$-2x+15$','pts':2,'mins':4,'diff':'2',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 4.1','zad':[
        'Řešte rovnici (uveďte celý postup řešení): $2+\\frac{x-6}{7}-\\frac{x}{14}=\\frac{4+x}{2}$'],
     'opts':None,'ln':4,
     'sol':['Vynásobíme rovnici číslem 14: $28+2\\cdot(x-6)-x=7\\cdot(4+x)$.',
            '$28+2x-12-x=28+7x$, tj. $16+x=28+7x$, odtud $-12=6x$ a $x=-2$.'],
     'ans':'$x=-2$','pts':2,'mins':4,'diff':'2',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 4.2','zad':[
        'Řešte soustavu rovnic (uveďte celý postup řešení): $2x-3y=-6$,  $2x-y=2$.'],
     'opts':None,'ln':4,
     'sol':['Odečtením rovnic: $(2x-3y)-(2x-y)=-6-2$, tj. $-2y=-8$, takže $y=4$.',
            'Dosazením do $2x-y=2$: $2x-4=2$, tedy $2x=6$ a $x=3$.'],
     'ans':'$x=3$, $y=4$','pts':2,'mins':4,'diff':'3',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 5','zad':[
        'Do fitcentra mají přístup členové klubu i běžní návštěvníci. Člen klubu zaplatí fitcentru na začátku každého roku jednorázový poplatek 600 korun a za každý vstup platí 120 korun. Běžný návštěvník platí fitcentru za každý vstup 160 korun. Tereza je členkou klubu. Mirek členem klubu není, a platí tedy běžné vstupné. Počet Tereziných letošních vstupů do fitcentra označíme $x$.',
        '5.1 Vyjádřete výrazem s proměnnou $x$, kolik korun Tereza letos celkem zaplatila fitcentru.',
        '5.2 Tereza s Mirkem navštěvují fitcentrum vždy společně. Mirek zaplatil letos za všechny vstupy dohromady stejnou částku, jakou fitcentru letos celkem zaplatila Tereza. Vypočtěte, kolikrát Tereza letos navštívila fitcentrum.'],
     'opts':None,'ln':3,
     'sol':['5.1 Tereza platí poplatek 600 korun a za každý z $x$ vstupů 120 korun, celkem $120x+600$ korun.',
            '5.2 Mirek chodí stejně často jako Tereza ($x$ vstupů) a platí 160 korun za vstup, tj. $160x$ korun. Z rovnosti $160x=120x+600$ plyne $40x=600$, tedy $x=15$. Tereza navštívila fitcentrum 15krát.'],
     'ans':'5.1: $120x+600$ (korun); 5.2: 15krát','pts':3,'mins':5,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M9C 2026 – úloha 6','zad':[
        'První šestiúhelník se skládá ze dvou shodných bílých rovnostranných trojúhelníků a dvou shodných šedých trojúhelníků. Trojúhelníky přeskládáme do druhého šestiúhelníku (viz obrázek). Nejdelší strana šedého trojúhelníku měří 10 cm. Obvod prvního šestiúhelníku je 40 cm a obvod druhého šestiúhelníku je 46 cm.',
        '6.1 Určete v cm délku jedné strany bílého rovnostranného trojúhelníku.',
        '6.2 Určete v cm obvod šedého trojúhelníku.'],
     'opts':None,'ln':2,'svg':SVG6,'fn':'sestiuhelniky.svg',
     'alt':'Dva šestiúhelníky složené ze dvou bílých rovnostranných a dvou šedých trojúhelníků; nejdelší strana šedého trojúhelníku je 10 cm.',
     'cap':'Schematický nákres (1. a 2. šestiúhelník)',
     'sol':['Ze zadaných obvodů obou šestiúhelníků (40 cm a 46 cm) a přeskládání týchž čtyř trojúhelníků vychází, že bílý rovnostranný trojúhelník má stranu 7 cm a šedý trojúhelník má strany 10 cm, 7 cm a 6 cm.',
            '6.1 Strana bílého rovnostranného trojúhelníku je 7 cm.',
            '6.2 Obvod šedého trojúhelníku je $10+7+6=23$ cm.'],
     'ans':'6.1: 7 cm; 6.2: 23 cm','pts':3,'mins':6,'diff':'3',
     'codes':B+['planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 7','zad':[
        'Slepením šedé krychle s povrchem 54 cm² a bílého hranolu vznikne velký hranol $ABCDEFGH$ (viz obrázek). Nejdelší hrana bílého hranolu je o polovinu delší než hrana šedé krychle.',
        '7.1 Vypočtěte v cm délku hrany šedé krychle.',
        '7.2 Vypočtěte v cm³ objem velkého hranolu $ABCDEFGH$.'],
     'opts':None,'ln':2,'svg':SVG7,'fn':'hranol-krychle.svg',
     'alt':'Velký hranol ABCDEFGH složený z bílého hranolu vlevo a šedé krychle vpravo.',
     'cap':'Schematický nákres tělesa',
     'sol':['7.1 Povrch krychle je $6a^2=54$ cm², odtud $a^2=9$, tedy hrana šedé krychle $a=3$ cm.',
            '7.2 Nejdelší hrana bílého hranolu je o polovinu delší než hrana krychle, tj. $3\\cdot 1{,}5=4{,}5$ cm. Velký hranol má čtvercovou podstavu $3\\times 3$ cm a délku $3+4{,}5=7{,}5$ cm, objem $3\\cdot 3\\cdot 7{,}5=67{,}5$ cm³.'],
     'ans':'7.1: 3 cm; 7.2: $67{,}5$ cm³','pts':3,'mins':5,'diff':'2',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 8','zad':[
        'V náčrtku pravidelného pětiúhelníku $ABCDE$ jsou vyznačeny dvě z jeho os souměrnosti $o_1$, $o_2$, jejich průsečík $S$, úsečka $AD$ a velikosti některých úhlů (viz obrázek). Velikosti úhlů neměřte, ale vypočtěte.',
        '8.1 Vypočtěte ve stupních velikost úhlu $\\varphi$.',
        '8.2 Vypočtěte ve stupních velikost úhlu $\\omega$.'],
     'opts':None,'ln':2,'svg':SVG8,'fn':'petiuhelnik.svg',
     'alt':'Pravidelný pětiúhelník ABCDE se dvěma osami souměrnosti, jejich průsečíkem S, úsečkou AD a vyznačenými úhly 36 stupňů, fí a omega.',
     'cap':'Náčrt pravidelného pětiúhelníku (ilustrativní)',
     'sol':['Vnitřní úhel pravidelného pětiúhelníku má velikost $\\frac{(5-2)\\cdot 180^\\circ}{5}=108^\\circ$, středový úhel je $\\frac{360^\\circ}{5}=72^\\circ$.',
            '8.1 Osa souměrnosti procházející vrcholem $D$ půlí vnitřní úhel při vrcholu $D$, proto $\\varphi=\\frac{108^\\circ}{2}=54^\\circ$.',
            '8.2 Úhel $\\omega$ je polovina středového úhlu, tedy $\\omega=\\frac{72^\\circ}{2}=36^\\circ$ (rovněž $\\omega=90^\\circ-54^\\circ=36^\\circ$).'],
     'ans':'8.1: $\\varphi=54^\\circ$; 8.2: $\\omega=36^\\circ$','pts':3,'mins':5,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 9 (konstrukce)','zad':[
        'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).',
        'Bod $A$ je vrchol rovnoramenného trojúhelníku $ABC$, jehož strany $AC$ a $BC$ mají stejnou délku. Bod $S$ je střed strany $AC$ a na přímce $p$ leží střed $P$ strany $BC$ trojúhelníku $ABC$.',
        'Sestrojte vrchol $C$, střed $P$ a vrchol $B$, označte je písmeny a narýsujte trojúhelník $ABC$. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'bod-A-S-primka-p.svg',
     'alt':'Přímka p procházející bodem A a bod S ležící mimo přímku.',
     'cap':'Výchozí obrázek k úloze 9',
     'sol':['Vrchol $C$ je obraz bodu $A$ ve středové souměrnosti se středem $S$ (S je střed $AC$), tj. $|SC|=|AS|$; tím je $C$ určen.',
            'Trojúhelník je rovnoramenný, $|BC|=|AC|$, a $P$ je střed $BC$, proto $|PC|=\\frac{1}{2}|AC|=|AS|$. Střed $P$ tedy leží na přímce $p$ a zároveň na kružnici se středem $C$ a poloměrem $|AS|$; průsečíky dávají dvě polohy $P_1$, $P_2$.',
            'Vrchol $B$ získáme jako obraz $C$ ve středové souměrnosti se středem $P$ ($|PB|=|PC|$). Úloha má dvě řešení.'],
     'ans':'Dvě řešení: $C$ je obraz $A$ podle středu $S$; $P$ je průsečík přímky $p$ s kružnicí ($C$; $|AS|$) – polohy $P_1$, $P_2$; $B$ je obraz $C$ podle středu $P$ (viz obrázek v klíči).',
     'pts':3,'mins':8,'diff':'4',
     'codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 10 (konstrukce)','zad':[
        'V rovině leží body $U$, $V$ a přímka $k$ (viz obrázek).',
        'Bod $U$ leží uvnitř strany $KN$ obdélníku $KLMN$. Na přímce $k$ leží strana $KL$ tohoto obdélníku. Bod $V$ má stejnou vzdálenost od všech čtyř vrcholů obdélníku $KLMN$.',
        'Sestrojte všechny vrcholy obdélníku $KLMN$, označte je písmeny a obdélník narýsujte.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'body-U-V-primka-k.svg',
     'alt':'Body U a V a přímka k v rovině.',
     'cap':'Výchozí obrázek k úloze 10',
     'sol':['Bod $V$ má stejnou vzdálenost od všech vrcholů, je to tedy průsečík úhlopříček obdélníku (jeho střed). Strana $KN$ je kolmá k přímce $k$ a prochází bodem $U$; její pata na přímce $k$ je vrchol $K$ (spustíme kolmici z $U$ na $k$).',
            'Vrchol $M$ je obraz $K$ ve středové souměrnosti se středem $V$. Vrchol $L$ leží na přímce $k$ tak, že $|VL|=|VK|$ (druhý průsečík přímky $k$ s kružnicí ($V$; $|VK|$)); vrchol $N$ je obraz $L$ podle středu $V$. Obdélník $KLMN$ narýsujeme.'],
     'ans':'Vrchol $K$ je pata kolmice z $U$ na přímku $k$; $V$ je střed obdélníku, takže $M$ je obraz $K$ a $N$ obraz $L$ ve středové souměrnosti podle $V$; $L$ je druhý průsečík přímky $k$ s kružnicí ($V$; $|VK|$) (viz obrázek v klíči).',
     'pts':2,'mins':6,'diff':'3',
     'codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9C 2026 – úloha 11','zad':[
        'Tábor začal v pondělí snídaní a skončil v pátek po obědě. U každého jídla pomáhala v kuchyni služba. U snídaně měly mít službu vždy 4 osoby, u oběda 5 osob a u večeře také 5 osob. Každé z 35 dětí mělo službu v kuchyni právě jednou za celý tábor. Požadovaný počet osob vždy doplnili instruktoři a ti pak měli službu společně s dětmi. Přitom každý instruktor měl službu v kuchyni nejvýše jedenkrát za den. V grafu je uveden pouze rozpis služeb dětí, oba páteční údaje chybí.',
        'Rozhodněte o každém z tvrzení 11.1 až 11.3, zda je pravdivé (A), nebo nepravdivé (N).',
        '11.1 V pátek mělo službu v kuchyni celkem 9 dětí.',
        '11.2 U každého jídla měli službu v kuchyni společně s dětmi nejvýše 3 instruktoři.',
        '11.3 Instruktorů muselo být na táboře nejméně 8.'],
     'opts':None,'ln':0,'svg':SVG11,'fn':'graf-sluzby.svg',
     'alt':'Sloupcový graf počtu dětí ve službě u snídaně, oběda a večeře v pondělí až čtvrtek; páteční údaje chybí.',
     'cap':'Rozpis služeb dětí (počet dětí)',
     'sol':['Z grafu mají děti službu (pondělí až čtvrtek): snídaně $2+1+3+1=7$, oběd $4+3+3+2=12$, večeře $1+3+2+3=9$, celkem 28 dětí. V pátek (jen snídaně a oběd) má tedy službu $35-28=7$ dětí.',
            '11.1 V pátek má službu 7 dětí, nikoli 9 – tvrzení je nepravdivé (N).',
            '11.2 Instruktoři doplňují počet na 4 (snídaně), resp. 5 (oběd i večeře). Např. v pondělí u večeře byla jen 1 dítě, tedy $5-1=4$ instruktoři, což je více než 3 – nepravdivé (N).',
            '11.3 Každý instruktor má službu nejvýše jednou za den, proto je jich za den potřeba tolik, kolik je součet doplnění u snídaně, oběda a večeře. Nejvíce ve čtvrtek: $(4-1)+(5-2)+(5-3)=3+3+2=8$. Instruktorů muselo být nejméně 8 – pravdivé (A).'],
     'ans':'11.1: N; 11.2: N; 11.3: A','pts':4,'mins':8,'diff':'4',
     'codes':B+['statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9C 2026 – úloha 12','zad':[
        'Chlapci chtěli nahrát stejné video na internet. Jan použil připojení s rychlostí nahrávání 36 Mb za sekundu a nahrání videa mu trvalo 1 hodinu. Karel použil připojení s rychlostí nahrávání 54 Mb za sekundu. (Rychlost nahrávání videa byla v obou případech stálá a během nahrávání nedošlo k žádnému výpadku.)',
        'Kolik minut trvalo nahrání videa Karlovi?'],
     'opts':['A) 40 minut','B) 45 minut','C) 60 minut','D) 90 minut','E) jiný počet minut'],'ln':0,
     'sol':['Velikost videa je $36\\cdot 3600=129\\,600$ Mb (1 hodina má 3600 s). Karlovi trvalo nahrání $129\\,600:54=2400$ s $=40$ minut. (Rychlejší připojení v poměru $54:36=3:2$ zkrátí čas na $60\\cdot\\frac{2}{3}=40$ minut.)'],
     'ans':'A) 40 minut','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9C 2026 – úloha 13','zad':[
        'Na tržišti se vyměňuje zboží. Jedna husa se vymění za 48 kg brambor, jedna slepice za 18 kg brambor.',
        'Za kolik hus se vymění stejné množství brambor, jako se vymění za 40 slepic?'],
     'opts':['A) za 20 hus','B) za 18 hus','C) za 16 hus','D) za 15 hus','E) za 12 hus'],'ln':0,
     'sol':['Za 40 slepic se vymění $40\\cdot 18=720$ kg brambor. To odpovídá $720:48=15$ husám.'],
     'ans':'D) za 15 hus','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9C 2026 – úloha 14','zad':[
        'V parku se konaly běžecké závody dvoučlenných a čtyřčlenných štafet. Závodů se zúčastnilo celkem 60 soutěžících a ti vytvořili 21 štafet. Každý soutěžící běžel pouze v jedné štafetě.',
        'Jaká část soutěžících běžela ve čtyřčlenných štafetách?'],
     'opts':['A) $\\frac{3}{10}$','B) $\\frac{7}{20}$','C) $\\frac{3}{5}$','D) $\\frac{2}{3}$','E) jiná část'],'ln':0,
     'sol':['Nechť je $d$ dvoučlenných a $c$ čtyřčlenných štafet: $d+c=21$ a $2d+4c=60$. Řešením je $c=9$, $d=12$. Ve čtyřčlenných štafetách běželo $4\\cdot 9=36$ soutěžících, tj. $\\frac{36}{60}=\\frac{3}{5}$ všech.'],
     'ans':'C) $\\frac{3}{5}$','pts':2,'mins':4,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9C 2026 – úloha 15','zad':[
        'Každý z 80 prvňáků dostal školní sadu. Všechny tyto sady dohromady stály 36 000 korun. Školní sada pro prvňáky obsahuje slabikář a balíček na malování s temperami a pastelkami.',
        'Přiřaďte ke každé úloze (15.1 až 15.3) odpovídající výsledek (A až F).',
        '15.1 Každý prvňák zaplatil za školní sadu 90 korun a zbytek její ceny uhradila škola. Kolik procent z ceny sady pro prvňáky uhradila škola?',
        '15.2 Poměr ceny temper ku ceně pastelek byl 3 : 2. O kolik procent byla cena temper vyšší než cena pastelek?',
        '15.3 Cena slabikáře byla o 50 korun vyšší než cena balíčku na malování. O kolik procent byla cena slabikáře vyšší než cena balíčku na malování?'],
     'opts':['A) 20 %','B) 25 %','C) 30 %','D) 40 %','E) 50 %','F) více než 50 %'],'ln':0,
     'sol':['Cena jedné sady je $36\\,000:80=450$ korun.',
            '15.1 Škola uhradila $450-90=360$ korun, tj. $\\frac{360}{450}=0{,}8=80\\,\\%$ ceny – více než 50 %, výsledek F.',
            '15.2 Poměr temper ku pastelkám je $3:2$; tempery jsou vyšší o $\\frac{3-2}{2}=\\frac{1}{2}=50\\,\\%$ – výsledek E.',
            '15.3 Slabikář $+$ balíček $=450$ a slabikář je o 50 korun dražší, tedy balíček stojí 200 korun a slabikář 250 korun. Slabikář je vyšší o $\\frac{50}{200}=25\\,\\%$ – výsledek B.'],
     'ans':'15.1: F (škola uhradila 80 %); 15.2: E (o 50 %); 15.3: B (o 25 %)','pts':6,'mins':9,'diff':'3',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M9C 2026 – úloha 16','zad':[
        'První obrazec je čtverec. Druhý obrazec má tvar obdélníku a vznikl z prvního obrazce přidáním dvou menších čtverců. Každý další obrazec má opět tvar obdélníku a vznikne tak, že u kratší strany předchozího obrazce přidáme tolik menších čtverců, kolikátý obrazec vytváříme (viz obrázek). Např. 3. obrazec vznikl z 2. obrazce přidáním tří menších čtverců. Delší strana 4. obrazce měří 125 cm.',
        '16.1 Vypočtěte, kolik cm měří strana 1. obrazce.',
        '16.2 Vypočtěte, o kolik cm² se liší obsah 4. obrazce a obsah 5. obrazce.',
        '16.3 Vypočtěte, kolik cm měří obvod 6. obrazce.'],
     'opts':None,'ln':4,'svg':SVG16,'fn':'obrazce-posloupnost.svg',
     'alt':'Posloupnost obrazců: 1. čtverec, 2. a 3. obdélník vzniklé přidáváním menších čtverců u kratší strany.',
     'cap':'1., 2. a 3. obrazec (schematicky, ne v měřítku)',
     'sol':['Označme stranu 1. obrazce (čtverce) $a$. Kratší strana všech obrazců zůstává $a$; při vytváření $k$-tého obrazce přidáme $k$ menších čtverců podél kratší strany, každý o straně $\\frac{a}{k}$, takže se delší strana prodlouží o $\\frac{a}{k}$.',
            '16.1 Delší strana 4. obrazce: $a+\\frac{a}{2}+\\frac{a}{3}+\\frac{a}{4}=a\\cdot\\frac{25}{12}=125$, odtud $a=60$ cm.',
            '16.2 Delší strany: 4. obrazec 125 cm, 5. obrazec $125+\\frac{60}{5}=137$ cm. Obsahy: $60\\cdot 125=7500$ cm² a $60\\cdot 137=8220$ cm², rozdíl $8220-7500=720$ cm² (tj. $5\\cdot 12^2$).',
            '16.3 6. obrazec: delší strana $137+\\frac{60}{6}=147$ cm, kratší 60 cm; obvod $2\\cdot(60+147)=414$ cm.'],
     'ans':'16.1: 60 cm; 16.2: o 720 cm²; 16.3: 414 cm','pts':4,'mins':9,'diff':'4',
     'codes':B+['posloupnosti','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PCD26C0T03'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9-2026C')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
