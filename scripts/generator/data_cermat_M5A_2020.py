# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2020, MATEMATIKA 5A (osmileté obory, 5. ročník), 1. řádný termín.
# Kód testu: M5PAD20C0T01. 14 úloh (po rozdělení izolovaných poduúloh 16 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR) + záznamový arch (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 3: šest kartiček s čísly 1 až 6
def _cards():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 110" font-family="sans-serif">']
    for i in range(6):
        x = 30 + i * 82
        s.append(f'<rect x="{x}" y="28" width="60" height="60" rx="6" fill="#f4f4f4" stroke="#000" stroke-width="2"/>')
        s.append(f'<text x="{x+30}" y="68" font-size="26" text-anchor="middle">{i+1}</text>')
    s.append('</svg>')
    return "".join(s)
SVG3 = _cards()

# úloha 7.1: polopřímka XY a bod A
SVG71 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 460" font-family="sans-serif">
<line x1="110" y1="420" x2="560" y2="150" stroke="#000" stroke-width="2"/>
<circle cx="110" cy="420" r="3.5" fill="#000"/>
<text x="88" y="437" font-size="17" font-style="italic">X</text>
<circle cx="308" cy="301" r="3.5" fill="#000"/>
<text x="300" y="291" font-size="17" font-style="italic">Y</text>
<text x="322" y="392" font-size="17" text-anchor="middle">×</text>
<text x="322" y="412" font-size="17" font-style="italic" text-anchor="middle">A</text>
</svg>"""

# úloha 7.2: přímka p a body N, O
SVG72 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 420" font-family="sans-serif">
<line x1="90" y1="360" x2="590" y2="250" stroke="#000" stroke-width="2"/>
<text x="597" y="248" font-size="17" font-style="italic">p</text>
<text x="392" y="234" font-size="17" text-anchor="middle">×</text>
<text x="392" y="218" font-size="17" font-style="italic" text-anchor="middle">N</text>
<text x="378" y="346" font-size="17" text-anchor="middle">×</text>
<text x="378" y="366" font-size="17" font-style="italic" text-anchor="middle">O</text>
</svg>"""

# úloha 8: čtvercová síť 12x6 s obrazci A a B (vrcholy v mřížových bodech)
def _grid8():
    cell = 40; ox = 30; oy = 20; W = 12; H = 6
    def P(c, r): return f'{ox+c*cell},{oy+r*cell}'
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+W*cell} {oy*2+H*cell+30}" font-family="sans-serif">']
    for i in range(W+1):
        s.append(f'<line x1="{ox+i*cell}" y1="{oy}" x2="{ox+i*cell}" y2="{oy+H*cell}" stroke="#bbb" stroke-width="1"/>')
    for j in range(H+1):
        s.append(f'<line x1="{ox}" y1="{oy+j*cell}" x2="{ox+W*cell}" y2="{oy+j*cell}" stroke="#bbb" stroke-width="1"/>')
    s.append(f'<polygon points="{P(1,1)} {P(4,1)} {P(4,4)} {P(2,5)} {P(3,3)}" fill="#c9c9c9" stroke="#000" stroke-width="2.5"/>')
    s.append(f'<text x="{ox+int(2.5*cell)}" y="{oy+int(2.8*cell)}" font-size="18" text-anchor="middle">A</text>')
    s.append(f'<polygon points="{P(6,3)} {P(10,1)} {P(11,2)} {P(11,3)} {P(8,3)} {P(8,4)} {P(7,4)}" fill="#c9c9c9" stroke="#000" stroke-width="2.5"/>')
    s.append(f'<text x="{ox+int(9*cell)}" y="{oy+int(2.4*cell)}" font-size="18" text-anchor="middle">B</text>')
    s.append(f'<text x="{ox+W*cell//2}" y="{oy+H*cell+22}" font-size="13" text-anchor="middle">Strana čtverečku je 1 cm, obsah 1 cm².</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _grid8()

# úlohy 10–11: skládaný sloupcový graf (počty žáků podle bodů), 4. a 5. třída
def _graph():
    x0 = 70; y0 = 300; unit = 20; bw = 28; pitch = 92
    cats = [('0 bodů', 3, 5), ('1 bod', 10, 4), ('2 body', 8, 9), ('3 body', 4, None)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 360" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="55" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="460" y2="{y0}" stroke="#000"/>')
    for v in range(0, 13, 2):
        y = y0 - v * unit
        s.append(f'<line x1="{x0}" y1="{y}" x2="450" y2="{y}" stroke="#e4e4e4"/>')
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="12" text-anchor="end">{v}</text>')
    s.append('<text x="26" y="175" font-size="13" text-anchor="middle" transform="rotate(-90 26 175)">Počet žáků</text>')
    gx = x0 + 20
    for name, c4, c5 in cats:
        h4 = c4 * unit
        s.append(f'<rect x="{gx}" y="{y0-h4}" width="{bw}" height="{h4}" fill="#666" stroke="#000"/>')
        gx2 = gx + bw + 4
        if c5 is None:
            s.append(f'<rect x="{gx2}" y="55" width="{bw}" height="{y0-55}" fill="none" stroke="#aaa" stroke-dasharray="4 4"/>')
            s.append(f'<text x="{gx2+bw//2}" y="{y0-40}" font-size="18" text-anchor="middle">?</text>')
        else:
            h5 = c5 * unit
            s.append(f'<rect x="{gx2}" y="{y0-h5}" width="{bw}" height="{h5}" fill="#cfcfcf" stroke="#000"/>')
        s.append(f'<text x="{gx+bw}" y="{y0+18}" font-size="12" text-anchor="middle">{name}</text>')
        gx += pitch
    s.append('<rect x="478" y="150" width="14" height="14" fill="#666" stroke="#000"/><text x="497" y="162" font-size="12">4. třída</text>')
    s.append('<rect x="478" y="172" width="14" height="14" fill="#cfcfcf" stroke="#000"/><text x="497" y="184" font-size="12">5. třída</text>')
    s.append('</svg>')
    return "".join(s)
SVG_GRAPH = _graph()

# úloha 13: tři tělesa ze šesti krychlí s bílými a černými puntíky (prostorové – schematická poznámka)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif">
<text x="280" y="52" font-size="13" text-anchor="middle">První, druhé a třetí těleso, každé ze šesti krychlí s bílými a černými puntíky.</text>
<text x="280" y="80" font-size="11" text-anchor="middle" fill="#666">Prostorová tělesa a rozmístění puntíků nelze věrně přenést; posuzuje se podle testového sešitu.</text>
</svg>"""

# úloha 14: 1., 2. a 3. obrazec ze sirek (dva krajní trojúhelníky + n čtverců s úhlopříčkou)
def _matches():
    ytop = 50; ybot = 104; ymid = 77; tw = 22; sw = 34
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 150" font-family="sans-serif">']
    def figure(px, n, label):
        w = tw + n * sw + tw
        r = [f'<text x="{px+w//2}" y="34" font-size="13" text-anchor="middle">{label}</text>']
        lx = px + tw
        r.append(f'<line x1="{px}" y1="{ymid}" x2="{lx}" y2="{ytop}" stroke="#000" stroke-width="2"/>')
        r.append(f'<line x1="{px}" y1="{ymid}" x2="{lx}" y2="{ybot}" stroke="#000" stroke-width="2"/>')
        for k in range(n):
            x = lx + k * sw
            r.append(f'<line x1="{x}" y1="{ytop}" x2="{x}" y2="{ybot}" stroke="#000" stroke-width="2"/>')
            r.append(f'<line x1="{x}" y1="{ytop}" x2="{x+sw}" y2="{ytop}" stroke="#000" stroke-width="2"/>')
            r.append(f'<line x1="{x}" y1="{ybot}" x2="{x+sw}" y2="{ybot}" stroke="#000" stroke-width="2"/>')
            r.append(f'<line x1="{x}" y1="{ytop}" x2="{x+sw}" y2="{ybot}" stroke="#000" stroke-width="2"/>')
        rx = lx + n * sw
        r.append(f'<line x1="{rx}" y1="{ytop}" x2="{rx}" y2="{ybot}" stroke="#000" stroke-width="2"/>')
        r.append(f'<line x1="{rx}" y1="{ytop}" x2="{rx+tw}" y2="{ymid}" stroke="#000" stroke-width="2"/>')
        r.append(f'<line x1="{rx}" y1="{ybot}" x2="{rx+tw}" y2="{ymid}" stroke="#000" stroke-width="2"/>')
        return "".join(r)
    out.append(figure(20, 1, '1. obrazec'))
    out.append(figure(190, 2, '2. obrazec'))
    out.append(figure(380, 3, '3. obrazec'))
    out.append('<text x="600" y="83" font-size="22">…</text>')
    out.append('</svg>')
    return "".join(out)
SVG14 = _matches()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 se v taxonomii nepoužívá

PROBLEMS = [
    {'name': 'CERMAT M5A 2020 – úloha 1.1', 'zad': ['Vypočtěte: $305-20+15:5-2\\cdot(4+2\\cdot 3)=$'], 'opts': None, 'ln': 2,
     'sol': ['Podle pořadí operací: $305-20+3-2\\cdot 10=305-20+3-20=268$.'], 'ans': '$268$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2020 – úloha 1.2', 'zad': ['Vypočtěte: $(883+884+885):3-880:4=$'], 'opts': None, 'ln': 2,
     'sol': ['$(883+884+885):3-880:4=2652:3-220=884-220=664$.'], 'ans': '$664$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2020 – úloha 2', 'zad': [
        '2.1 Sjezdovka je o polovinu delší než lanovka. Jejich délky se liší o čtvrt kilometru. Vypočtěte v metrech délku sjezdovky.',
        '2.2 Jízda lanovkou trvala 1 minutu a 24 sekund. Lyžař sjel sjezdovku za dobu o třetinu kratší. Vypočtěte v sekundách, za jak dlouho sjel lyžař sjezdovku.'],
     'opts': None, 'ln': 2,
     'sol': ['2.1 Lanovka $l$, sjezdovka $1{,}5l$; rozdíl $0{,}5l=250$ m, tedy $l=500$ m a sjezdovka $1{,}5\\cdot 500=750$ m.',
             '2.2 $1$ min $24$ s $=84$ s; o třetinu kratší: $84-\\frac{84}{3}=84-28=56$ s.'],
     'ans': '2.1: $750$ metrů; 2.2: $56$ sekund', 'pts': 4, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2020 – úloha 3', 'zad': [
        'Na každé z 6 kartiček bylo zapsáno jedno číslo od 1 do 6. Žádná dvojice kartiček neobsahovala stejné číslo. Tři kartičky měl Eda a zbývající tři Petr. Součet čísel na Edových kartičkách byl o 3 větší než součet čísel na Petrových kartičkách.',
        'Určete, která čísla byla na Petrových kartičkách. Najděte všechna řešení. (Nezapisujte čísla na Edových kartičkách.)'],
     'opts': None, 'ln': 2, 'svg': SVG3, 'fn': 'karticky.svg',
     'alt': 'Šest kartiček s čísly 1, 2, 3, 4, 5 a 6.', 'cap': 'Kartičky s čísly 1 až 6',
     'sol': ['Součet všech čísel je $1+2+3+4+5+6=21$. Petrův součet $p$ a Edův $p+3$ dávají $p+(p+3)=21$, tedy $p=9$. Trojice se součtem $9$: $1{+}2{+}6$, $1{+}3{+}5$, $2{+}3{+}4$.'],
     'ans': 'Petrovy kartičky: $1, 2, 6$ nebo $1, 3, 5$ nebo $2, 3, 4$', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2020 – úloha 4', 'zad': [
        'Děti koupily mamince k narozeninám kytici růží, bonboniéru, ozdobnou záložku a knihu. Kytice s bonboniérou stály celkem 180 korun. Kytice byla dvakrát dražší než bonboniéra. Všechny čtyři dárky stály celkem 310 korun. Samotná kniha byla o 100 korun dražší než ozdobná záložka.',
        '4.1 Vypočtěte, kolik korun zaplatily děti za kytici růží.',
        '4.2 Vypočtěte, kolik korun stála ozdobná záložka.'],
     'opts': None, 'ln': 2,
     'sol': ['4.1 Bonboniéra $b$, kytice $2b$; $b+2b=180$, tedy $b=60$ a kytice $2b=120$ korun.',
             '4.2 Záložka a kniha stály $310-180=130$ korun; kniha je o $100$ dražší, tedy $z+(z+100)=130$, odtud $z=15$ korun (kniha $115$ korun).'],
     'ans': '4.1: $120$ korun; 4.2: $15$ korun', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2020 – úloha 5', 'zad': [
        'Kouzelník přinesl víle kouzelný podnos se 42 bílými perlami. Víla z podnosu odebírala perly na šperky. Za každou odebranou bílou perlu se na podnose okamžitě vykouzlily 4 růžové perly, ale na růžové perly kouzlo nefungovalo. Z prvních 30 odebraných bílých perel víla vytvořila náhrdelník. Když ho dokončila, začala z podnosu odebírat další perly (bílé i růžové) na korunku. Perly na korunku odebírala tak dlouho, dokud nebyl podnos prázdný.',
        '5.1 Vypočtěte, kolik perel bylo na podnose, když víla dokončila náhrdelník.',
        '5.2 Vypočtěte, kolik perel odebrala víla z podnosu na korunku.'],
     'opts': None, 'ln': 2,
     'sol': ['5.1 Víla odebrala $30$ bílých perel (zbývá $42-30=12$ bílých) a vykouzlila $30\\cdot 4=120$ růžových; na podnose je $12+120=132$ perel.',
             '5.2 Zbývá odebrat $12$ bílých a $120$ růžových. Odběrem $12$ bílých vznikne dalších $12\\cdot 4=48$ růžových. Celkem na korunku: $12+120+48=180$ perel.'],
     'ans': '5.1: $132$ perel; 5.2: $180$ perel', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2020 – úloha 6', 'zad': [
        'Každý ze tří spolužáků měl zapsat co nejvíce hlavních měst evropských států. Adam zapsal 12 hlavních měst, stejně jako Bětka, ale Eliška jich zapsala jen 6. Mezi všemi zapsanými hlavními městy byla 2 města zapsána třikrát, 7 měst dvakrát a ostatní jen jedenkrát.',
        '6.1 Vypočtěte, kolik hlavních měst bylo zapsáno jen jedenkrát.',
        '6.2 Vypočtěte, kolik různých hlavních měst bylo celkem zapsáno.'],
     'opts': None, 'ln': 2,
     'sol': ['6.1 Celkem bylo zapsáno $12+12+6=30$ měst (i s opakováním). Třikrát zapsaná $2$ města a dvakrát $7$ měst dají $2\\cdot 3+7\\cdot 2=20$ zápisů; zbylých $30-20=10$ měst je zapsáno jen jednou.',
             '6.2 Různých měst je $2+7+10=19$.'],
     'ans': '6.1: $10$ hlavních měst; 6.2: $19$ různých hlavních měst', 'pts': 4, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2020 – úloha 7.1 (konstrukce)', 'zad': [
        'V rovině leží polopřímka $XY$ a bod $A$ (viz obrázek).',
        'Bod $A$ je vrchol obdélníku $ABCD$. Jiné dva vrcholy tohoto obdélníku leží na polopřímce $XY$ a délka strany $AB$ je 7 cm.',
        'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG71, 'fn': 'poloprimka-xy.svg',
     'alt': 'Polopřímka XY směřující šikmo vzhůru doprava a bod A pod ní.', 'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Sestrojíme obdélník $ABCD$ s daným vrcholem $A$ a stranou $|AB|=7$ cm tak, aby další dva jeho vrcholy ležely na polopřímce $XY$. Úloha má dvě řešení (polohy $B_1 C_1 D_1$ a $B_2 C_2 D_2$) – viz obrázek v klíči.'],
     'ans': 'Konstrukce obdélníku $ABCD$ ($A$ dán, $|AB|=7$ cm, dva vrcholy na polopřímce $XY$); dvě řešení – viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '4', 'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2020 – úloha 7.2 (konstrukce)', 'zad': [
        'V rovině leží přímka $p$ a body $N$, $O$ (viz obrázek).',
        'Body $N$, $O$ jsou vrcholy trojúhelníku $NOP$. Vrchol $P$ tohoto trojúhelníku leží na přímce $p$. Délka strany $NO$ je polovinou délky strany $OP$.',
        'Sestrojte vrchol $P$ trojúhelníku $NOP$, označte jej písmenem a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG72, 'fn': 'primka-p-no.svg',
     'alt': 'Přímka p směřující šikmo vzhůru doprava a body N a O.', 'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Protože $|NO|$ je polovina $|OP|$, platí $|OP|=2\\cdot|NO|$. Vrchol $P$ tedy leží na přímce $p$ a zároveň na kružnici $k$ se středem $O$ a poloměrem $2\\cdot|NO|$. Průsečíky přímky $p$ a kružnice $k$ dávají dvě řešení $P_1$, $P_2$.'],
     'ans': 'Konstrukce: $P$ je průsečík přímky $p$ a kružnice $k(O; 2|NO|)$; dvě řešení $P_1$, $P_2$ – viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3', 'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2020 – úloha 8', 'zad': [
        'Ve čtvercové síti jsou zakresleny dva tmavé obrazce $A$, $B$. Vrcholy obou obrazců leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky 1 cm a obsah 1 cm².',
        'Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).',
        '8.1 Obsah obrazce $A$ je 7 cm².',
        '8.2 Obsah obrazce $B$ je o 1 cm² větší než obsah obrazce $A$.',
        '8.3 Obvod obrazce $B$ je stejný jako obvod obrazce $A$.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'sit-obrazce-ab.svg',
     'alt': 'Čtvercová síť 12 krát 6 se dvěma tmavými obrazci A (vlevo) a B (vpravo), vrcholy v mřížových bodech.', 'cap': 'Obrazce A a B ve čtvercové síti',
     'sol': ['Obsah obrazce $A$ je $6$ cm² (nikoli $7$), tvrzení 8.1 je nepravdivé (Ne).',
             'Obsah obrazce $B$ je $7$ cm², tj. o $1$ cm² více než $A$, tvrzení 8.2 je pravdivé (Ano).',
             'Oba obrazce mají obvod $6+2\\sqrt{5}+2\\sqrt{2}$ cm (stejný), tvrzení 8.3 je pravdivé (Ano).'],
     'ans': '8.1: Ne; 8.2: Ano; 8.3: Ano', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2020 – úloha 9', 'zad': [
        'Adéla a Hana dostaly stejnou knihu. Hana přečetla z knihy denně 10 stran. Adéla přečetla celou knihu za 8 dní a každý den z ní přečetla o polovinu více stran než Hana.',
        'Za kolik dní přečetla knihu Hana?'],
     'opts': ['A) za méně než 10 dní', 'B) za 10 dní', 'C) za 12 dní', 'D) za 15 dní', 'E) za více než 15 dní'], 'ln': 0,
     'sol': ['Adéla čte $1{,}5\\cdot 10=15$ stran denně, kniha má $8\\cdot 15=120$ stran. Hana čte $10$ stran denně: $120:10=12$ dní.'],
     'ans': 'C) za 12 dní', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2020 – úloha 10', 'zad': [
        'Všichni žáci 4. a 5. třídy se zúčastnili soutěže, v níž mohl každý z nich získat 0 až 3 body. V následujícím grafu jsou uvedeny počty žáků, kteří získali v soutěži daný počet bodů, jeden údaj však chybí. Žáci 4. třídy získali v soutěži celkem o 2 body méně než žáci 5. třídy.',
        'Kolik bodů celkem získali v soutěži žáci 5. třídy?'],
     'opts': ['A) 34 bodů', 'B) 36 bodů', 'C) 38 bodů', 'D) 40 bodů', 'E) jiný počet bodů'], 'ln': 0,
     'svg': SVG_GRAPH, 'fn': 'graf-body.svg',
     'alt': 'Sloupcový graf počtu žáků 4. a 5. třídy podle získaných bodů 0 až 3; údaj pro 5. třídu a 3 body chybí.', 'cap': 'Počty žáků podle získaných bodů',
     'sol': ['Body 4. třídy: $1\\cdot 10+2\\cdot 8+3\\cdot 4=38$. Žáci 4. třídy mají o $2$ body méně než 5. třída, takže 5. třída získala $38+2=40$ bodů.'],
     'ans': 'D) 40 bodů', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2020 – úloha 11', 'zad': [
        'Všichni žáci 4. a 5. třídy se zúčastnili soutěže, v níž mohl každý z nich získat 0 až 3 body. V následujícím grafu jsou uvedeny počty žáků, kteří získali v soutěži daný počet bodů, jeden údaj však chybí. Žáci 4. třídy získali v soutěži celkem o 2 body méně než žáci 5. třídy.',
        'Kolik žáků chodí do 5. třídy?'],
     'opts': ['A) méně než 24 žáků', 'B) 24 žáků', 'C) 25 žáků', 'D) 26 žáků', 'E) více než 26 žáků'], 'ln': 0,
     'svg': SVG_GRAPH, 'fn': 'graf-body.svg',
     'alt': 'Sloupcový graf počtu žáků 4. a 5. třídy podle získaných bodů 0 až 3; údaj pro 5. třídu a 3 body chybí.', 'cap': 'Počty žáků podle získaných bodů',
     'sol': ['Chybějící údaj (5. třída, 3 body): body 5. třídy jsou $40$, tj. $1\\cdot 4+2\\cdot 9+3\\cdot x=40$, odtud $x=6$. Počet žáků 5. třídy: $5+4+9+6=24$.'],
     'ans': 'B) 24 žáků', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2020 – úloha 12', 'zad': [
        'První číslo je čtvrtinou druhého čísla. Třetí číslo je 64, což je čtyřnásobek druhého čísla.',
        'Jaké je první číslo?'],
     'opts': ['A) 64', 'B) 32', 'C) 16', 'D) 8', 'E) 4'], 'ln': 0,
     'sol': ['Druhé číslo je $64:4=16$. První číslo je $16:4=4$.'],
     'ans': 'E) 4', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2020 – úloha 13', 'zad': [
        'Ve stavebnici je 18 stejných krychlí. Krychle mají na každé stěně jeden puntík. Na každé krychli jsou 2 bílé a 4 černé puntíky. Bílé puntíky jsou na krychli umístěny vždy proti sobě (buď nahoře a dole, nebo vpředu a vzadu, nebo vpravo a vlevo). Slepili jsme první a druhé těleso, každé z 6 krychlí. První těleso má na celém svém povrchu (tedy i zespodu) 26 puntíků (bílých i černých dohromady). Podle schématu slepíme ze zbývajících 6 krychlí třetí těleso.',
        'Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).',
        '13.1 Jaký je počet černých puntíků na povrchu prvního tělesa?',
        '13.2 Jaký je počet černých puntíků na povrchu druhého tělesa?',
        '13.3 Jaký je největší možný počet černých puntíků na povrchu třetího tělesa?'],
     'opts': ['A) 17', 'B) 18', 'C) 19', 'D) 20', 'E) 21', 'F) jiný počet'], 'ln': 0,
     'svg': SVG13, 'fn': 'tri-telesa.svg',
     'alt': 'Tři tělesa, každé slepené ze šesti krychlí s bílými a černými puntíky (schematická poznámka).', 'cap': 'Schematický nákres – tělesa viz testový sešit',
     'sol': ['Každá stěna krychle nese právě jeden puntík; počet puntíků na povrchu tělesa se rovná počtu jeho vnějších stěn a černých je tolik, kolik zbude po odečtení bílých puntíků viditelných na povrchu.',
             '13.1 Na povrchu prvního tělesa je $26$ puntíků, z nichž je $18$ černých → odpověď B.',
             '13.2 Na povrchu druhého tělesa je $17$ černých puntíků → odpověď A.',
             '13.3 Krychle třetího tělesa lze natočit tak, aby na povrchu zůstalo co nejméně bílých puntíků; největší možný počet černých je $20$ → odpověď D.'],
     'ans': '13.1: B (18 puntíků); 13.2: A (17 puntíků); 13.3: D (20 puntíků)', 'pts': 5, 'mins': 6, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2020 – úloha 14', 'zad': [
        'První obrazec je sestaven z 9 sirek, druhý obrazec je sestaven ze 13 sirek a třetí i všechny následující obrazce se postupně zvětšují podle téhož pravidla.',
        '14.1 Určete, o kolik sirek má 5. obrazec více než 3. obrazec.',
        '14.2 Určete, z kolika sirek je sestaven 20. obrazec.',
        '14.3 Určete, kolikátý obrazec je sestaven ze 129 sirek.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'sirky-obrazce.svg',
     'alt': 'První, druhý a třetí obrazec ze sirek: dva krajní trojúhelníky a mezi nimi 1, 2 a 3 čtverce s úhlopříčkou.', 'cap': '1., 2. a 3. obrazec ze sirek',
     'sol': ['Každý další obrazec má o $4$ sirky více; $n$-tý obrazec je z $9+4\\cdot(n-1)=4n+5$ sirek.',
             '14.1 $5$. obrazec: $4\\cdot 5+5=25$; $3$. obrazec: $4\\cdot 3+5=17$; rozdíl $25-17=8$ sirek.',
             '14.2 $20$. obrazec: $4\\cdot 20+5=85$ sirek.',
             '14.3 $4n+5=129\\Rightarrow 4n=124\\Rightarrow n=31$; je to $31.$ obrazec.'],
     'ans': '14.1: o $8$ sirek; 14.2: z $85$ sirek; 14.3: $31.$ obrazec', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PAD20C0T01'
    gen.YEAR = 2020

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2020')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
