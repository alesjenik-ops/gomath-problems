# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2021, MATEMATIKA 9 (čtyřleté obory, 9. ročník), varianta A, 1. řádný termín.
# Kód testu: M9PAD21C0T01. 16 úloh (po rozdělení izolovaných počtářských poduúloh 21 úloh), 50 bodů.
# Zdroj odpovědí: klíč správných řešení (KSR) M9PAD21C0T01. Ověřeno se zadáním (TS) a záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 8: síť kolmého čtyřbokého hranolu – vodorovný obdélník 40x8 (plášť) + dva shodné čtverce (podstavy 10x10) na pravém konci
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 240" font-family="sans-serif">
<rect x="85" y="101" width="255" height="44" fill="#f4f4f4" stroke="#000" stroke-width="2"/>
<rect x="340" y="68" width="55" height="55" fill="#f4f4f4" stroke="#000" stroke-width="2"/>
<rect x="340" y="123" width="55" height="55" fill="#f4f4f4" stroke="#000" stroke-width="2"/>
<line x1="65" y1="101" x2="65" y2="145" stroke="#444" stroke-width="1"/>
<polygon points="65,101 61,109 69,109" fill="#444"/><polygon points="65,145 61,137 69,137" fill="#444"/>
<text x="40" y="128" font-size="14">8 cm</text>
<line x1="85" y1="205" x2="340" y2="205" stroke="#444" stroke-width="1"/>
<polygon points="85,205 93,201 93,209" fill="#444"/><polygon points="340,205 332,201 332,209" fill="#444"/>
<text x="188" y="223" font-size="14">40 cm</text>
</svg>"""

# úloha 9: výchozí obrázek – polopřímka BX a přímka o
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="150" y1="62" x2="330" y2="255" stroke="#000" stroke-width="2"/>
<text x="138" y="58" font-size="16" font-style="italic">o</text>
<line x1="60" y1="238" x2="410" y2="150" stroke="#000" stroke-width="2"/>
<line x1="60" y1="231" x2="60" y2="245" stroke="#000" stroke-width="2"/>
<text x="46" y="256" font-size="16" font-style="italic">B</text>
<line x1="332" y1="163" x2="342" y2="181" stroke="#000" stroke-width="2"/>
<text x="338" y="200" font-size="16" font-style="italic">X</text>
</svg>"""

# úloha 10: výchozí obrázek – body B, P a přímka q procházející bodem B
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="252" y1="300" x2="398" y2="58" stroke="#000" stroke-width="2"/>
<text x="404" y="52" font-size="16" font-style="italic">q</text>
<line x1="272" y1="258" x2="288" y2="268" stroke="#000" stroke-width="2"/>
<text x="292" y="272" font-size="16" font-style="italic">B</text>
<text x="196" y="150" font-size="18" text-anchor="middle">×</text>
<text x="196" y="170" font-size="16" font-style="italic">P</text>
</svg>"""

# úloha 12: přímka AB a rovnoběžník ABCD; úhly alfa a 4 alfa při vrcholu A, úhel delta při vrcholu D
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif">
<line x1="60" y1="250" x2="440" y2="250" stroke="#000" stroke-width="1.5"/>
<polygon points="170,250 290,250 411,162 291,162" fill="none" stroke="#000" stroke-width="2"/>
<path d="M 196 250 A 26 26 0 0 0 191 235" fill="none" stroke="#000" stroke-width="1.2"/>
<path d="M 136 250 A 34 34 0 0 1 197 231" fill="none" stroke="#000" stroke-width="1.2"/>
<path d="M 315 162 A 24 24 0 0 1 272 173" fill="none" stroke="#000" stroke-width="1.2"/>
<text x="204" y="242" font-size="16" font-style="italic">α</text>
<text x="146" y="240" font-size="16">4α</text>
<text x="300" y="184" font-size="16" font-style="italic">δ</text>
<text x="164" y="268" font-size="15" font-style="italic">A</text>
<text x="286" y="268" font-size="15" font-style="italic">B</text>
<text x="416" y="158" font-size="15" font-style="italic">C</text>
<text x="278" y="156" font-size="15" font-style="italic">D</text>
</svg>"""

# úloha 13: vlevo pravoúhlý lichoběžník rozdělený úsečkou DP na čtverec PBCD a trojúhelník APD; vpravo šedý trojúhelník ABC
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 220" font-family="sans-serif">
<polygon points="60,180 180,180 180,90 90,90" fill="none" stroke="#000" stroke-width="2"/>
<line x1="90" y1="90" x2="90" y2="180" stroke="#000" stroke-width="1.5"/>
<text x="80" y="84" font-size="15" font-style="italic">D</text>
<text x="183" y="84" font-size="15" font-style="italic">C</text>
<text x="50" y="196" font-size="15" font-style="italic">A</text>
<text x="85" y="196" font-size="15" font-style="italic">P</text>
<text x="183" y="196" font-size="15" font-style="italic">B</text>
<polygon points="290,180 410,180 410,90 320,90" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="290,180 410,180 410,90" fill="#cfcfcf" stroke="#000" stroke-width="2"/>
<text x="310" y="84" font-size="15" font-style="italic">D</text>
<text x="413" y="84" font-size="15" font-style="italic">C</text>
<text x="280" y="196" font-size="15" font-style="italic">A</text>
<text x="413" y="196" font-size="15" font-style="italic">B</text>
</svg>"""

# úloha 14: tabulka počtu chovaných psů (Jižní / Severní ulice)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 155" font-family="sans-serif">
<line x1="10" y1="20" x2="470" y2="20" stroke="#000"/>
<line x1="10" y1="80" x2="470" y2="80" stroke="#000"/>
<line x1="10" y1="110" x2="470" y2="110" stroke="#000"/>
<line x1="10" y1="140" x2="470" y2="140" stroke="#000"/>
<line x1="150" y1="48" x2="370" y2="48" stroke="#000"/>
<line x1="10" y1="20" x2="10" y2="140" stroke="#000"/>
<line x1="70" y1="20" x2="70" y2="140" stroke="#000"/>
<line x1="150" y1="20" x2="150" y2="140" stroke="#000"/>
<line x1="370" y1="20" x2="370" y2="140" stroke="#000"/>
<line x1="470" y1="20" x2="470" y2="140" stroke="#000"/>
<line x1="205" y1="48" x2="205" y2="140" stroke="#000"/>
<line x1="260" y1="48" x2="260" y2="140" stroke="#000"/>
<line x1="315" y1="48" x2="315" y2="140" stroke="#000"/>
<text x="40" y="54" font-size="12" text-anchor="middle">Ulice</text>
<text x="110" y="42" font-size="11" text-anchor="middle">Počet všech</text>
<text x="110" y="60" font-size="11" text-anchor="middle">rodin</text>
<text x="260" y="40" font-size="11" text-anchor="middle">Počet rodin, které chovají</text>
<text x="177" y="68" font-size="11" text-anchor="middle">0 psů</text>
<text x="232" y="68" font-size="11" text-anchor="middle">1 psa</text>
<text x="287" y="68" font-size="11" text-anchor="middle">2 psy</text>
<text x="342" y="68" font-size="11" text-anchor="middle">3 psy</text>
<text x="420" y="42" font-size="11" text-anchor="middle">Aritmetický průměr</text>
<text x="420" y="58" font-size="11" text-anchor="middle">počtu chovaných</text>
<text x="420" y="74" font-size="11" text-anchor="middle">psů</text>
<text x="16" y="99" font-size="12">Jižní</text>
<text x="110" y="99" font-size="12" text-anchor="middle">48</text>
<text x="177" y="99" font-size="12" text-anchor="middle">33</text>
<text x="287" y="99" font-size="12" text-anchor="middle">5</text>
<text x="420" y="99" font-size="12" text-anchor="middle">0,5</text>
<text x="16" y="129" font-size="12">Severní</text>
<text x="177" y="129" font-size="12" text-anchor="middle">23</text>
<text x="232" y="129" font-size="12" text-anchor="middle">12</text>
<text x="287" y="129" font-size="12" text-anchor="middle">1</text>
<line x1="376" y1="113" x2="464" y2="137" stroke="#000"/>
<line x1="376" y1="137" x2="464" y2="113" stroke="#000"/>
</svg>"""

# úloha 16: tři pyramidy z krychliček (schematicky); otvory = vynechané pozice v lichých řadách
def _pyramids():
    s = 22
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif">']
    def pyr(bx, ty, R, label):
        out.append(f'<text x="{bx}" y="{ty-12}" font-size="13" text-anchor="middle">{label}</text>')
        for r in range(1, R + 1):
            y = ty + (r - 1) * s
            left = bx - r * s / 2
            for p in range(1, r + 1):
                if r >= 3 and r % 2 == 1 and p % 2 == 0:
                    continue  # otvor
                x = left + (p - 1) * s
                out.append(f'<rect x="{x}" y="{y}" width="{s}" height="{s}" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/>')
    pyr(95, 150, 2, '1. pyramida')
    pyr(255, 106, 4, '2. pyramida')
    pyr(445, 62, 6, '3. pyramida')
    out.append('<text x="528" y="182" font-size="22">…</text>')
    out.append('</svg>')
    return "".join(out)
SVG16 = _pyramids()

B = ['zs2', 'r9']  # 9. ročník ZŠ, přijímačky na čtyřleté obory

PROBLEMS = [
    {'name':'CERMAT M9A 2021 – úloha 1','zad':[
        'Určete, na kolik $16$minutových intervalů lze rozdělit $1{,}6$ hodiny.'],
     'opts':None,'ln':2,
     'sol':['$1{,}6$ hodiny $=96$ minut; $96:16=6$, tedy na $6$ intervalů.'],
     'ans':'na $6$ intervalů','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 2.1','zad':[
        'Doplňte do rámečku takové číslo, aby platila rovnost.',
        '$0{,}3$ m² $-\\;52$ cm² $=\\;\\square$ cm²'],
     'opts':None,'ln':2,
     'sol':['$0{,}3$ m² $=3\\,000$ cm²; $3\\,000-52=2\\,948$ cm².'],
     'ans':'$2\\,948$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 2.2','zad':[
        'Doplňte do rámečku takové číslo, aby platila rovnost.',
        '$\\square$ dm³ $-\\;0{,}04$ m³ $=250$ cm³'],
     'opts':None,'ln':2,
     'sol':['$250$ cm³ $=0{,}25$ dm³ a $0{,}04$ m³ $=40$ dm³, tedy $\\square=0{,}25+40=40{,}25$ dm³.'],
     'ans':'$40{,}25$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 3.1','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
        '$\\left(\\dfrac{5}{8}\\cdot\\dfrac{10}{9}-\\dfrac{4}{9}\\right):\\left(8\\cdot\\dfrac{1}{6}\\right)=$'],
     'opts':None,'ln':3,
     'sol':['$\\dfrac{5}{8}\\cdot\\dfrac{10}{9}=\\dfrac{50}{72}=\\dfrac{25}{36}$; $\\dfrac{25}{36}-\\dfrac{4}{9}=\\dfrac{25-16}{36}=\\dfrac{9}{36}=\\dfrac{1}{4}$; $8\\cdot\\dfrac{1}{6}=\\dfrac{4}{3}$; $\\dfrac{1}{4}:\\dfrac{4}{3}=\\dfrac{1}{4}\\cdot\\dfrac{3}{4}=\\dfrac{3}{16}$.'],
     'ans':'$\\dfrac{3}{16}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 3.2','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
        '$\\dfrac{2-\\dfrac{13}{10}}{\\dfrac{5}{3}-\\dfrac{1}{2}}=$'],
     'opts':None,'ln':3,
     'sol':['Čitatel: $2-\\dfrac{13}{10}=\\dfrac{20-13}{10}=\\dfrac{7}{10}$; jmenovatel: $\\dfrac{5}{3}-\\dfrac{1}{2}=\\dfrac{10-3}{6}=\\dfrac{7}{6}$; podíl $\\dfrac{7}{10}:\\dfrac{7}{6}=\\dfrac{7}{10}\\cdot\\dfrac{6}{7}=\\dfrac{6}{10}=\\dfrac{3}{5}$.'],
     'ans':'$\\dfrac{3}{5}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 4.1','zad':[
        'Rozložte na součin podle vzorce.',
        '$9a^2-30a+25=$'],
     'opts':None,'ln':2,
     'sol':['$9a^2-30a+25=(3a)^2-2\\cdot 3a\\cdot 5+5^2=(3a-5)^2$.'],
     'ans':'$(3a-5)^2$','pts':1,'mins':2,'diff':'2',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 4.2','zad':[
        'Vynásobte (výsledný výraz nesmí obsahovat závorky).',
        '$(3x+y)\\cdot(3x-2)=$'],
     'opts':None,'ln':2,
     'sol':['$(3x+y)\\cdot(3x-2)=9x^2-6x+3xy-2y$.'],
     'ans':'$9x^2+3xy-6x-2y$','pts':1,'mins':2,'diff':'2',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 4.3','zad':[
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky).',
        '$(4n-1)\\cdot(4n+1)-8n\\cdot(n-1)=$'],
     'opts':None,'ln':3,
     'sol':['$(4n-1)(4n+1)=16n^2-1$ a $8n(n-1)=8n^2-8n$; $16n^2-1-(8n^2-8n)=8n^2+8n-1$.'],
     'ans':'$8n^2+8n-1$','pts':2,'mins':3,'diff':'3',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 5.1','zad':[
        'Řešte rovnici:',
        '$0{,}3\\cdot 2-0{,}5x\\cdot 2+0{,}4x=x+3{,}8$'],
     'opts':None,'ln':3,
     'sol':['$0{,}6-x+0{,}4x=x+3{,}8$; $0{,}6-0{,}6x=x+3{,}8$; $-1{,}6x=3{,}2$; $x=-2$.'],
     'ans':'$x=-2$','pts':2,'mins':3,'diff':'3',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 5.2','zad':[
        'Řešte rovnici:',
        '$\\dfrac{3}{4}\\cdot(4-y)+\\dfrac{3}{2}\\cdot(y+2)=6+\\dfrac{3y}{2}$'],
     'opts':None,'ln':3,
     'sol':['$3-\\dfrac{3}{4}y+\\dfrac{3}{2}y+3=6+\\dfrac{3}{2}y$; $6+\\dfrac{3}{4}y=6+\\dfrac{3}{2}y$; $\\dfrac{3}{4}y-\\dfrac{3}{2}y=0$; $-\\dfrac{3}{4}y=0$; $y=0$.'],
     'ans':'$y=0$','pts':2,'mins':3,'diff':'3',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 6','zad':[
        'Firma zaměstnává $200$ osob. Během epidemie museli někteří pracovat z domova. Včera byla na pracovišti jedna třetina žen zaměstnaných ve firmě a dvě pětiny mužů zaměstnaných ve firmě, všichni ostatní pracovali z domova.',
        'Počet všech žen zaměstnaných ve firmě označte $x$.',
        '6.1 V závislosti na veličině $x$ vyjádřete počet žen, které byly včera na pracovišti.',
        '6.2 V závislosti na veličině $x$ vyjádřete počet mužů, kteří byli včera na pracovišti.',
        '6.3 Včera bylo na pracovišti celkem $70$ osob zaměstnaných ve firmě. Vypočtěte, kolik žen firma zaměstnává.'],
     'opts':None,'ln':3,
     'sol':['6.1 Žen na pracovišti byla třetina ze $x$, tj. $\\dfrac{x}{3}$.',
            '6.2 Mužů je $200-x$, na pracovišti byly dvě pětiny, tj. $\\dfrac{2}{5}\\cdot(200-x)$.',
            '6.3 Rovnice $\\dfrac{x}{3}+\\dfrac{2}{5}(200-x)=70$; po vynásobení $15$: $5x+6(200-x)=1\\,050$; $5x+1\\,200-6x=1\\,050$; $-x=-150$; $x=150$.'],
     'ans':'6.1: $\\dfrac{x}{3}$; 6.2: $\\dfrac{2}{5}\\cdot(200-x)$; 6.3: $150$ žen','pts':3,'mins':6,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2021 – úloha 7','zad':[
        'Farmářka chová $3$ koně, ale nemá již pro ně žádné krmivo. Chovatel, který má pro svých $5$ koní krmivo na $120$ dní, farmářce dvě pětiny tohoto krmiva prodá. (Každý kůň spotřebuje za den stejné množství krmiva.)',
        'Vypočtěte, za kolik dní',
        '7.1 by veškeré chovatelovo krmivo spotřebovalo všech $8$ koní společně,',
        '7.2 spotřebují chovatelovi koně krmivo, které chovatel neprodá,',
        '7.3 spotřebují farmářčini koně krmivo, které farmářka zakoupí od chovatele.'],
     'opts':None,'ln':3,
     'sol':['Celkové krmivo vystačí $5$ koním na $120$ dní, tj. $5\\cdot 120=600$ krmných dávek (koňodní).',
            '7.1 Všech $8$ koní: $600:8=75$ dní.',
            '7.2 Chovatel neprodá $\\dfrac{3}{5}$ krmiva $=360$ dávek pro své $5$ koně: $360:5=72$ dní.',
            '7.3 Farmářka zakoupí $\\dfrac{2}{5}$ krmiva $=240$ dávek pro své $3$ koně: $240:3=80$ dní.'],
     'ans':'7.1: za $75$ dní; 7.2: za $72$ dní; 7.3: za $80$ dní','pts':4,'mins':6,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2021 – úloha 8','zad':[
        'Síť kolmého čtyřbokého hranolu se skládá ze dvou shodných čtverců a obdélníku s rozměry $40$ cm a $8$ cm (viz náčrt obrysu sítě).',
        'Vypočtěte',
        '8.1 v cm² povrch hranolu,',
        '8.2 v cm³ objem hranolu.'],
     'opts':None,'ln':2,'svg':SVG8,'fn':'sit-hranol.svg',
     'alt':'Náčrt obrysu sítě: vodorovný obdélník 40 cm krát 8 cm a na jeho pravém konci dva shodné čtverce (podstavy hranolu).',
     'cap':'Náčrt obrysu sítě kolmého čtyřbokého hranolu',
     'sol':['Obdélník $40$ cm $\\times$ $8$ cm je plášť hranolu, jeho delší strana je obvod podstavy: $40:4=10$ cm je strana čtvercové podstavy, výška hranolu je $8$ cm.',
            '8.1 Povrch $=2\\cdot 10\\cdot 10+40\\cdot 8=200+320=520$ cm².',
            '8.2 Objem $=10\\cdot 10\\cdot 8=800$ cm³.'],
     'ans':'8.1: $520$ cm²; 8.2: $800$ cm³','pts':3,'mins':5,'diff':'3',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 9 (konstrukce)','zad':[
        'V rovině leží polopřímka $BX$ a přímka $o$ (viz obrázek).',
        'Bod $B$ je vrchol trojúhelníku $ABC$. Přímka $o$ je osou strany $AB$. Velikost vnitřního úhlu $BAC$ je $60^\\circ$ a vrchol $C$ leží na polopřímce $BX$.',
        'Sestrojte vrcholy $A$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'poloprimka-BX-o.svg',
     'alt':'Polopřímka BX (z bodu B doprava nahoru přes bod X) a přímka o protínající ji.',
     'cap':'Výchozí obrázek k úloze 9',
     'sol':['Přímka $o$ je osou úsečky $AB$, proto vrchol $A$ získáme jako obraz daného bodu $B$ v osové souměrnosti podle přímky $o$.',
            'Při vrcholu $A$ sestrojíme k přímce $AB$ úhel velikosti $60^\\circ$; jeho rameno protne polopřímku $BX$ ve vrcholu $C$. Trojúhelník $ABC$ narýsujeme.'],
     'ans':'Vrchol $A$ je obraz bodu $B$ v osové souměrnosti podle přímky $o$ (osy $AB$); vrchol $C$ je průsečík polopřímky $BX$ s ramenem úhlu velikosti $60^\\circ$ sestrojeného při vrcholu $A$ k přímce $AB$ – viz obrázek v klíči.',
     'pts':2,'mins':6,'diff':'3',
     'codes':B+['planimetrie','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 10 (konstrukce)','zad':[
        'V rovině leží body $B$, $P$ a přímka $q$ procházející bodem $B$ (viz obrázek).',
        'Bod $B$ je vrchol rovnoramenného lichoběžníku $ABCD$ se základnou $AB$, rameno $BC$ leží na přímce $q$. Úhlopříčky $AC$ a $BD$ se protínají v bodě $P$ a jsou na sebe kolmé.',
        'Sestrojte vrcholy $A$, $C$, $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'body-BP-q.svg',
     'alt':'Body B a P a přímka q procházející bodem B v rovině.',
     'cap':'Výchozí obrázek k úloze 10',
     'sol':['Úhlopříčka $BD$ prochází body $B$ a $P$, leží tedy na přímce $BP$. Druhá úhlopříčka $AC$ je k ní kolmá a prochází bodem $P$; její průsečík s přímkou $q$ je vrchol $C$.',
            'Rovnoramenný lichoběžník se základnou $AB$ má $|PA|=|PB|$ a $|PC|=|PD|$. Vrchol $A$ naneseme na přímku $AC$ tak, aby $|PA|=|PB|$ (na opačnou stranu než $C$), vrchol $D$ na přímku $BP$ za bod $P$ tak, aby $|PD|=|PC|$. Lichoběžník narýsujeme.'],
     'ans':'Úhlopříčka $BD$ leží na přímce $BP$; kolmice k $BP$ vedená bodem $P$ protne přímku $q$ ve vrcholu $C$. Vrchol $A$ leží na této kolmici tak, že $|PA|=|PB|$ (na opačné straně než $C$), vrchol $D$ leží na přímce $BP$ za bodem $P$ tak, že $|PD|=|PC|$ – viz obrázek v klíči.',
     'pts':3,'mins':7,'diff':'4',
     'codes':B+['planimetrie','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 11','zad':[
        'Děti mají mapu s měřítkem $1:50\\,000$. Alena ujela na koloběžce trasu délky $10$ km a vypočetla, že na mapě je to $5$ cm. Beáta ušla trasu, která je na mapě zobrazena čarou délky $15$ cm. Čestmír ušel dvakrát delší trasu než Beáta.',
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
        '11.1 Alenin výpočet je správný.',
        '11.2 Beáta ušla trasu délky $7{,}5$ km.',
        '11.3 Na mapě je Beátina trasa o polovinu kratší než Čestmírova trasa.'],
     'opts':None,'ln':0,
     'sol':['Měřítko $1:50\\,000$ znamená $1$ cm na mapě $=50\\,000$ cm $=0{,}5$ km ve skutečnosti.',
            '11.1 $10$ km odpovídá na mapě $10:0{,}5=20$ cm, nikoli $5$ cm; výpočet je nesprávný → N.',
            '11.2 Beátina trasa $15$ cm na mapě $=15\\cdot 0{,}5=7{,}5$ km → A.',
            '11.3 Čestmír ušel dvakrát delší trasu, na mapě tedy $30$ cm; Beátiných $15$ cm je o polovinu (o $15$ cm) kratší než $30$ cm → A.'],
     'ans':'11.1: N; 11.2: A; 11.3: A','pts':4,'mins':5,'diff':'3',
     'codes':B+['aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2021 – úloha 12','zad':[
        'V rovině leží přímka $AB$ a rovnoběžník $ABCD$. Rovnoběžník má vnitřní úhly o velikostech $\\alpha$, $\\delta$ (viz obrázek).',
        'Jaká je velikost úhlu $\\delta$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts':['A) menší než $108^\\circ$','B) $108^\\circ$','C) $135^\\circ$','D) $144^\\circ$','E) větší než $144^\\circ$'],
     'ln':0,'svg':SVG12,'fn':'rovnobeznik-ABCD.svg',
     'alt':'Přímka AB s rovnoběžníkem ABCD; při vrcholu A úhly alfa a 4 alfa, při vrcholu D úhel delta.',
     'cap':'Výchozí obrázek k úloze 12',
     'sol':['Úhel $4\\alpha$ (mezi přímkou $AB$ vlevo od $A$ a stranou $AD$) a vnitřní úhel $\\alpha$ při vrcholu $A$ jsou vedlejší, tedy $4\\alpha+\\alpha=180^\\circ$, odkud $\\alpha=36^\\circ$. V rovnoběžníku jsou sousední úhly doplňkové, proto $\\delta=180^\\circ-\\alpha=180^\\circ-36^\\circ=144^\\circ$.'],
     'ans':'D) $144^\\circ$','pts':2,'mins':4,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 13','zad':[
        'Pravoúhlý lichoběžník $ABCD$ je úsečkou $DP$ délky $12$ cm rozdělen na čtverec $PBCD$ a trojúhelník $APD$. Obsah trojúhelníku $APD$ je $6$krát menší než obsah čtverce $PBCD$. Z lichoběžníku $ABCD$ oddělíme šedý trojúhelník $ABC$ (viz obrázek).',
        'Jaký je obvod šedého trojúhelníku $ABC$?'],
     'opts':['A) menší než $48$ cm','B) $48$ cm','C) $50$ cm','D) $52$ cm','E) větší než $52$ cm'],
     'ln':0,'svg':SVG13,'fn':'lichobeznik-trojuhelnik.svg',
     'alt':'Vlevo pravoúhlý lichoběžník ABCD rozdělený úsečkou DP na čtverec PBCD a trojúhelník APD; vpravo týž lichoběžník se šedým trojúhelníkem ABC.',
     'cap':'Rozdělení lichoběžníku a šedý trojúhelník ABC',
     'sol':['Čtverec $PBCD$ má stranu $DP=12$ cm, obsah $144$ cm². Trojúhelník $APD$ má obsah $144:6=24$ cm² a výšku $DP=12$ cm, tedy $\\dfrac{1}{2}\\cdot AP\\cdot 12=24$, odkud $AP=4$ cm.',
            'Trojúhelník $ABC$ je pravoúhlý s odvěsnami $AB=AP+PB=4+12=16$ cm a $BC=12$ cm; přepona $AC=\\sqrt{16^2+12^2}=\\sqrt{400}=20$ cm. Obvod $=16+12+20=48$ cm.'],
     'ans':'B) $48$ cm','pts':2,'mins':4,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9A 2021 – úloha 14','zad':[
        'Všechny rodiny z Jižní a Severní ulice uvedly, kolik chovají psů. Výsledky šetření jsou uvedeny v tabulce (některá pole nejsou vyplněna).',
        'Právě $3$ psy chová v Severní ulici dvakrát více rodin než v Jižní ulici. Kolik rodin bydlí v Severní ulici?'],
     'opts':['A) $40$','B) $42$','C) $44$','D) $46$','E) jiný počet'],
     'ln':0,'svg':SVG14,'fn':'tabulka-psi.svg',
     'alt':'Tabulka počtu chovaných psů. Jižní ulice: 48 rodin, 0 psů 33, 2 psy 5, průměr 0,5. Severní ulice: 0 psů 23, 1 psa 12, 2 psy 1.',
     'cap':'Počty rodin podle počtu chovaných psů',
     'sol':['Jižní ulice: celkem $48$ rodin. Neznámé počty $1$ psa ($j_1$) a $3$ psy ($j_3$). Součet rodin: $33+j_1+5+j_3=48$, tj. $j_1+j_3=10$. Průměr $0{,}5$: $\\dfrac{j_1+2\\cdot 5+3j_3}{48}=0{,}5$, tj. $j_1+3j_3=14$. Odečtením $2j_3=4$, $j_3=2$.',
            'V Severní ulici chová $3$ psy dvakrát více rodin: $2\\cdot 2=4$. Počet rodin v Severní ulici $=23+12+1+4=40$.'],
     'ans':'A) $40$','pts':2,'mins':5,'diff':'3',
     'codes':B+['statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2021 – úloha 15','zad':[
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Při úklidové akci „Čisté břehy“ měl každý dobrovolník naplnit jeden odpadkový pytel, ale $20\\,\\%$ dobrovolníků naplnilo ještě druhý pytel. Dobrovolníci tak naplnili o $130$ pytlů více, než se předpokládalo. Kolik pytlů celkem dobrovolníci naplnili?',
        '15.2 Učitel matematiky obdržel peněžitý dar na nákup učebních pomůcek. Za $24\\,\\%$ daru zakoupil $3$ stejná kružítka na tabuli. Model tělesa stál $180$ korun, což představuje $2\\,\\%$ daru. Kolik korun stálo jedno kružítko?',
        '15.3 Na $25\\,\\%$ rozlohy zemědělské půdy Jablonecka jsou pole, zbytek tvoří louky. Pastviny pro dobytek zabírají $20\\,\\%$ rozlohy luk, zbývajících $1\\,800$ hektarů luk se využívá pro pěstování trávy na seno. Kolik hektarů zabírají pole na Jablonecku?'],
     'opts':['A) $650$','B) $675$','C) $720$','D) $750$','E) $780$','F) jiný počet'],
     'ln':0,
     'sol':['15.1 Druhý pytel naplnilo $20\\,\\%$ dobrovolníků a to je oněch $130$ pytlů navíc, tedy $0{,}2\\cdot D=130$, $D=650$ dobrovolníků. Celkem naplnili $650+130=780$ pytlů → E.',
            '15.2 $2\\,\\%$ daru $=180$ Kč, tedy $1\\,\\%=90$ Kč a celý dar $=9\\,000$ Kč. Za $3$ kružítka utratil $24\\,\\%=2\\,160$ Kč, jedno stojí $2\\,160:3=720$ Kč → C.',
            '15.3 Seno tvoří $80\\,\\%$ luk: $0{,}8\\cdot L=1\\,800$, $L=2\\,250$ ha. Louky jsou $75\\,\\%$ půdy, tedy celá půda $=2\\,250:0{,}75=3\\,000$ ha. Pole $=25\\,\\%$ z $3\\,000=750$ ha → D.'],
     'ans':'15.1: E ($780$); 15.2: C ($720$); 15.3: D ($750$)','pts':6,'mins':9,'diff':'4',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9A 2021 – úloha 16','zad':[
        'Každý díl stavebnice se skládá ze tří stejných krychliček; všechny díly jsou stejné. Z dílů stavíme stále větší pyramidy jako na obrázku. Nejmenší pyramidu tvoří jediný díl. Druhá pyramida sestavená ze $3$ dílů má $1$ otvor, $4$ řady a ve spodní řadě $4$ krychličky. Každá další pyramida bude o dvě řady vyšší než předchozí pyramida.',
        '16.1 Pyramida má ve spodní řadě $50$ krychliček. Určete počet otvorů ve druhé řadě zdola.',
        '16.2 Pyramida má celkem $10$ otvorů. Určete počet krychliček v celé pyramidě.',
        '16.3 Pyramida je sestavena z $21$ dílů. Určete počet krychliček ve spodní řadě.'],
     'opts':None,'ln':3,'svg':SVG16,'fn':'pyramidy.svg',
     'alt':'Tři pyramidy z krychliček: 1. pyramida (2 řady), 2. pyramida (4 řady, 1 otvor), 3. pyramida (6 řad, 3 otvory).',
     'cap':'1., 2. a 3. pyramida z dílů po třech krychličkách',
     'sol':['$n$-tá pyramida má $2n$ řad; řada odshora s pořadím $r$ má $r$ pozic a v liché řadě ($r\\ge 3$) se pravidelně střídají krychlička a otvor, takže obsahuje $\\dfrac{r-1}{2}$ otvorů. Spodní řada má $2n$ krychliček, počet dílů je $\\dfrac{n(n+1)}{2}$, počet krychliček $3\\cdot\\dfrac{n(n+1)}{2}$ a počet otvorů $\\dfrac{n(n-1)}{2}$.',
            '16.1 Spodní řada $2n=50$, tedy $n=25$. Druhá řada zdola má $2n-1=49$ pozic, otvorů je $\\dfrac{49-1}{2}=24$.',
            '16.2 $\\dfrac{n(n-1)}{2}=10\\Rightarrow n(n-1)=20\\Rightarrow n=5$. Krychliček $3\\cdot\\dfrac{5\\cdot 6}{2}=45$.',
            '16.3 Dílů $\\dfrac{n(n+1)}{2}=21\\Rightarrow n(n+1)=42\\Rightarrow n=6$. Ve spodní řadě je $2n=12$ krychliček.'],
     'ans':'16.1: $24$ otvorů; 16.2: $45$ krychliček; 16.3: $12$ krychliček','pts':4,'mins':7,'diff':'4',
     'codes':B+['posloupnosti','modelovani','slovni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PAD21C0T01'
    gen.YEAR = 2021

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9A-2021')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
