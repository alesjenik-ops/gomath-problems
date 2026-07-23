# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2019, MATEMATIKA 5A, 1. řádný termín.
# Kód testu: M5PAD19C0T01. 14 úloh (po rozdělení nezávislých poduúloh 17 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR); struktura ověřena záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 6: papírový proužek = jedna řada osmi stejných čtverečků
def _strip():
    x0, y0, cell, n = 40, 45, 40, 8
    W = x0 * 2 + n * cell
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} 110" font-family="sans-serif">']
    s.append(f'<text x="{x0 + n * cell // 2}" y="30" font-size="14" text-anchor="middle">Papírový proužek</text>')
    s.append(f'<rect x="{x0}" y="{y0}" width="{n * cell}" height="{cell}" fill="none" stroke="#000" stroke-width="2"/>')
    for i in range(1, n):
        xx = x0 + i * cell
        s.append(f'<line x1="{xx}" y1="{y0}" x2="{xx}" y2="{y0 + cell}" stroke="#000" stroke-dasharray="3 3"/>')
    s.append('</svg>')
    return "".join(s)
SVG6 = _strip()

# úloha 7: výchozí obrázek – kružnice k (střed S), body A, L, přímka c protínající kružnici
def _fig7():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 400" font-family="sans-serif">']
    s.append('<circle cx="235" cy="215" r="150" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('<line x1="45" y1="150" x2="450" y2="95" stroke="#000" stroke-width="2"/>')
    s.append('<text x="452" y="94" font-size="16" font-style="italic">c</text>')
    s.append('<text x="392" y="330" font-size="16" font-style="italic">k</text>')
    marks = [(190, 180, "A", 176, 176), (248, 210, "S", 236, 226), (192, 275, "L", 178, 272)]
    for px, py, lab, lx, ly in marks:
        s.append(f'<text x="{px}" y="{py}" font-size="16" text-anchor="middle">×</text>')
        s.append(f'<text x="{lx}" y="{ly}" font-size="15" font-style="italic">{lab}</text>')
    s.append('</svg>')
    return "".join(s)
SVG7 = _fig7()

# úloha 8: tři obrazce ze čtverců a rovnoramenných trojúhelníků (schematicky)
def _obrazce():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200" font-family="sans-serif">']
    # 1. obrazec: dva čtverce vedle sebe
    s.append('<text x="95" y="55" font-size="13" text-anchor="middle">1. obrazec</text>')
    s.append('<rect x="45" y="105" width="55" height="55" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('<rect x="100" y="105" width="55" height="55" fill="none" stroke="#000" stroke-width="2"/>')
    # 2. obrazec: rovnoběžník s úhlopříčkou (dva trojúhelníky)
    s.append('<text x="305" y="55" font-size="13" text-anchor="middle">2. obrazec</text>')
    s.append('<polygon points="245,160 360,160 390,105 275,105" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('<line x1="245" y1="160" x2="390" y2="105" stroke="#000" stroke-width="1.4"/>')
    # 3. obrazec: dům – tři čtverce + vysoký trojúhelník + střecha
    s.append('<text x="500" y="55" font-size="13" text-anchor="middle">3. obrazec</text>')
    for i in range(3):
        xx = 440 + i * 40
        s.append(f'<rect x="{xx}" y="120" width="40" height="40" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('<polygon points="440,120 480,120 460,62" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('<polygon points="460,62 480,120 560,120" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _obrazce()

# úlohy 11 a 12: sdružený sloupcový graf – všichni žáci / chlapci / dívky (kompaktně)
def _bars():
    data = [("1. rok", 27, 15, 12), ("2. rok", 25, None, 10), ("3. rok", 28, 16, None),
            ("4. rok", 30, None, 14), ("5. rok", 29, 16, 13), ("6. rok", 22, None, 10)]
    x0, y0, sc = 55, 300, 7
    top = y0 - 32 * sc
    a = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 340" font-family="sans-serif">'
         '<defs>'
         '<pattern id="h" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><rect width="6" height="6" fill="#fff"/><line x2="0" y2="6" stroke="#333" stroke-width="2"/></pattern>'
         '<pattern id="d" width="6" height="6" patternUnits="userSpaceOnUse"><rect width="6" height="6" fill="#fff"/><circle cx="3" cy="3" r="1.2" fill="#666"/></pattern>'
         '</defs>']
    for v in range(0, 33, 8):
        yy = y0 - v * sc
        a.append(f'<text x="{x0-8}" y="{yy+4}" font-size="11" text-anchor="end">{v}</text>')
    a.append(f'<line x1="{x0}" y1="{top}" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="680" y2="{y0}" stroke="#000"/>')
    mid = (top + y0) // 2
    a.append(f'<text x="18" y="{mid}" font-size="12" text-anchor="middle" transform="rotate(-90 18 {mid})">Počet žáků</text>')
    gw, bw, gap = 82, 16, 3
    gx = x0 + 16
    for name, v, ch, d in data:
        bx = gx
        for val, fill in ((v, "#b0b0b0"), (ch, "url(#h)"), (d, "url(#d)")):
            if val is None:
                a.append(f'<text x="{bx+bw//2}" y="160" font-size="16" text-anchor="middle" font-weight="bold">?</text>')
            else:
                a.append(f'<rect x="{bx}" y="{y0-val*sc}" width="{bw}" height="{val*sc}" fill="{fill}" stroke="#000"/>')
            bx += bw + gap
        a.append(f'<text x="{gx+29}" y="{y0+16}" font-size="11" text-anchor="middle">{name}</text>')
        gx += gw
    a.append('<rect x="560" y="80" width="13" height="13" fill="#b0b0b0" stroke="#000"/><text x="578" y="91" font-size="11">Všichni žáci</text>')
    a.append('<rect x="560" y="100" width="13" height="13" fill="url(#h)" stroke="#000"/><text x="578" y="111" font-size="11">Chlapci</text>')
    a.append('<rect x="560" y="120" width="13" height="13" fill="url(#d)" stroke="#000"/><text x="578" y="131" font-size="11">Dívky</text>')
    a.append('</svg>')
    return "".join(a)
SVGGRAF = _bars()

# úloha 13: tři tělesa z kvádru 3x2x2 po odebrání dvou krychliček (schematicky)
def _telesa():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 210" font-family="sans-serif">']
    def box(ox, oy, label, notches):
        w, h, dx, dy = 90, 60, 28, -18
        s.append(f'<text x="{ox + w // 2}" y="{oy - 26}" font-size="12" text-anchor="middle">{label}</text>')
        s.append(f'<polygon points="{ox},{oy} {ox + dx},{oy + dy} {ox + w + dx},{oy + dy} {ox + w},{oy}" fill="#eee" stroke="#000" stroke-width="1.5"/>')
        s.append(f'<polygon points="{ox + w},{oy} {ox + w + dx},{oy + dy} {ox + w + dx},{oy + h + dy} {ox + w},{oy + h}" fill="#e0e0e0" stroke="#000" stroke-width="1.5"/>')
        s.append(f'<rect x="{ox}" y="{oy}" width="{w}" height="{h}" fill="#fff" stroke="#000" stroke-width="1.5"/>')
        for i in range(1, 3):
            s.append(f'<line x1="{ox + i * w // 3}" y1="{oy}" x2="{ox + i * w // 3}" y2="{oy + h}" stroke="#000" stroke-width="0.8"/>')
        s.append(f'<line x1="{ox}" y1="{oy + h // 2}" x2="{ox + w}" y2="{oy + h // 2}" stroke="#000" stroke-width="0.8"/>')
        for cx in range(3):
            for cy in range(2):
                if (cx, cy) in notches:
                    continue
                s.append(f'<circle cx="{ox + cx * w // 3 + w // 6}" cy="{oy + cy * h // 2 + h // 4}" r="3" fill="#000"/>')
        for cx, cy in notches:
            s.append(f'<rect x="{ox + cx * w // 3 + 3}" y="{oy + cy * h // 2 + 3}" width="{w // 3 - 6}" height="{h // 2 - 6}" fill="#cfcfcf" stroke="#000" stroke-width="0.8"/>')
    box(50, 80, "1. těleso", [])
    box(265, 80, "2. těleso", [(2, 0)])
    box(480, 80, "3. těleso", [(0, 0), (2, 1)])
    s.append('<text x="310" y="198" font-size="10" text-anchor="middle" fill="#555">schematický nákres, počty puntíků viz řešení</text>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _telesa()

# úloha 14: tři nejmenší čtvercové labyrinty (spirály ze sirek) na čtvercové síti (kompaktně)
def _labyrinty():
    paths = {
        1: [(1, 1), (1, 2), (2, 2), (2, 0), (0, 0), (0, 2)],
        2: [(2, 2), (2, 3), (3, 3), (3, 1), (1, 1), (1, 4), (4, 4), (4, 0), (0, 0), (0, 4)],
        3: [(3, 3), (3, 4), (4, 4), (4, 2), (2, 2), (2, 5), (5, 5), (5, 1), (1, 1),
            (1, 6), (6, 6), (6, 0), (0, 0), (0, 6)],
    }
    a = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 150" font-family="sans-serif">']
    for n, ox, cell in [(1, 18, 30), (2, 165, 20), (3, 380, 15)]:
        N, oy = 2 * n, 28
        g = []
        for i in range(N + 1):
            g.append(f'M{ox} {oy+i*cell}h{N*cell}')
            g.append(f'M{ox+i*cell} {oy}v{N*cell}')
        a.append(f'<path d="{"".join(g)}" stroke="#cfcfcf" stroke-width="0.6" fill="none"/>')
        pts = paths[n]
        poly = " ".join(f"{ox+px*cell},{oy+py*cell}" for px, py in pts)
        a.append(f'<polyline points="{poly}" fill="none" stroke="#000" stroke-width="3"/>')
        for px, py in pts:
            a.append(f'<circle cx="{ox+px*cell}" cy="{oy+py*cell}" r="3" fill="#000"/>')
        a.append(f'<text x="{ox}" y="{oy-9}" font-size="13">{n}.</text>')
    a.append('</svg>')
    return "".join(a)
SVG14 = _labyrinty()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmiletá gymnázia); kód r5 se v taxonomii nepoužívá

PROBLEMS = [
    {'name': 'CERMAT M5A 2019 – úloha 1.1',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:',
             '$216-144:(9+3)=\\square+4$'],
     'opts': None, 'ln': 2,
     'sol': ['Podle pořadí operací $216-144:(9+3)=216-144:12=216-12=204$. Z rovnosti $204=\\square+4$ plyne $\\square=200$.'],
     'ans': '$200$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2019 – úloha 1.2',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:',
             '$9\\cdot 3\\,000-\\square=2\\,400+300$'],
     'opts': None, 'ln': 2,
     'sol': ['$9\\cdot 3\\,000=27\\,000$ a $2\\,400+300=2\\,700$. Z rovnosti $27\\,000-\\square=2\\,700$ plyne $\\square=24\\,300$.'],
     'ans': '$24\\,300$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2019 – úloha 2.1',
     'zad': ['Automobil široký $1\\,770$ mm jel v jízdním pruhu širokém $3$ m $25$ cm. Jízdní pruh se zúžil o půl metru.',
             'Vypočtěte, o kolik centimetrů je zúžený jízdní pruh širší než automobil.'],
     'opts': None, 'ln': 2,
     'sol': ['Jízdní pruh $3$ m $25$ cm $=325$ cm; po zúžení o půl metru ($50$ cm) měří $275$ cm. Automobil je široký $1\\,770$ mm $=177$ cm. Rozdíl je $275-177=98$ cm.'],
     'ans': 'o $98$ cm', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2019 – úloha 2.2',
     'zad': ['Cesta z Prahy do Žiliny autobusem trvala $6$ hodin a $20$ minut, vlakem jen $4$ hodiny a $45$ minut.',
             'Vypočtěte, o kolik minut trvala cesta autobusem déle než vlakem.'],
     'opts': None, 'ln': 2,
     'sol': ['Autobusem $6$ h $20$ min $=380$ min, vlakem $4$ h $45$ min $=285$ min. Rozdíl je $380-285=95$ min.'],
     'ans': 'o $95$ minut', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2019 – úloha 3',
     'zad': ['Soutěže se zúčastnila čtvrtina žáků školy, ale někteří z nich soutěž nedokončili. Soutěž dokončilo pouze $76$ žáků školy, což je přesně sedmina žáků školy.',
             '3.1 Určete počet všech žáků školy.',
             '3.2 Určete počet žáků školy, kteří soutěž nedokončili.'],
     'opts': None, 'ln': 2,
     'sol': ['3.1 Dokončilo $76$ žáků, což je sedmina školy, proto škola má $7\\cdot 76=532$ žáků.',
             '3.2 Soutěže se zúčastnila čtvrtina, tj. $532:4=133$ žáků; z nich dokončilo $76$, takže nedokončilo $133-76=57$ žáků.'],
     'ans': '3.1: $532$ žáků; 3.2: $57$ žáků', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2019 – úloha 4',
     'zad': ['Eva s Janou mají dohromady $220$ korun. Václav má o $60$ korun více než Jana, ale o $20$ korun méně než Eva.',
             '4.1 Vypočtěte, o kolik korun se liší částky obou dívek.',
             '4.2 Vypočtěte, kolik korun má Václav.'],
     'opts': None, 'ln': 2,
     'sol': ['4.1 Eva má o $20$ korun více než Václav a Jana o $60$ korun méně než Václav, takže Eva má o $20+60=80$ korun více než Jana.',
             '4.2 Označme Václavovu částku $V$. Pak Eva má $V+20$ a Jana $V-60$; z rovnice $(V+20)+(V-60)=220$ plyne $2V-40=220$, tedy $V=130$ korun.'],
     'ans': '4.1: o $80$ korun; 4.2: $130$ korun', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2019 – úloha 5',
     'zad': ['Od školy k Martinovi domů vede jediná cesta. Tato cesta je dlouhá $450$ m. Martin na ní udělá víc kroků než jeho tatínek, neboť Martinův krok měří $60$ cm a tatínkův $90$ cm.',
             '5.1 Vypočtěte, o kolik kroků více udělá na této cestě Martin než tatínek.',
             '5.2 Martin jde opačným směrem než tatínek a oba se od sebe vzdalují. Vypočtěte, o kolik metrů se od sebe vzdálí, když každý udělá přesně $30$ kroků.',
             '5.3 Martin šel od školy domů, odkud mu tatínek vyrazil naproti. Než se setkali, udělali oba stejný počet kroků. Vypočtěte, kolik kroků udělal Martin od školy k místu setkání.'],
     'opts': None, 'ln': 3,
     'sol': ['5.1 Cesta $450$ m $=45\\,000$ cm. Martin udělá $45\\,000:60=750$ kroků, tatínek $45\\,000:90=500$ kroků; rozdíl je $250$ kroků.',
             '5.2 Za $30$ kroků ujde Martin $30\\cdot 60=1\\,800$ cm $=18$ m a tatínek $30\\cdot 90=2\\,700$ cm $=27$ m; vzdálí se o $18+27=45$ m.',
             '5.3 Oba udělají stejný počet kroků $n$; dohromady ujdou $60n+90n=150n=45\\,000$ cm, odtud $n=300$. Martin tedy udělal $300$ kroků.'],
     'ans': '5.1: o $250$ kroků; 5.2: o $45$ metrů; 5.3: $300$ kroků', 'pts': 5, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2019 – úloha 6',
     'zad': ['Adéla dostala několik stejných papírových proužků tvaru obdélníku. Každý z nich beze zbytku rozstříhala na $8$ stejných čtverečků (viz obrázek).',
             'Adéla z nastříhaných čtverečků sestavovala větší čtverce. Největší čtverec, který bylo možné z nastříhaných čtverečků sestavit, měl v každé řadě $5$ čtverečků. Adéla takový čtverec sestavila a ještě několik čtverečků jí zbylo. Obvod největšího sestaveného čtverce byl $40$ cm.',
             '6.1 Určete, kolik papírových proužků Adéla dostala.',
             '6.2 Určete, kolik čtverečků Adéle zbylo po sestavení největšího čtverce.',
             '6.3 Vypočtěte v cm obvod jednoho papírového proužku.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'prouzek.svg',
     'alt': 'Papírový proužek tvaru obdélníku rozdělený na osm stejných čtverečků v jedné řadě.',
     'cap': 'Papírový proužek rozdělený na 8 čtverečků',
     'sol': ['6.1 Největší čtverec má $5\\cdot 5=25$ čtverečků. Celkový počet čtverečků je násobek osmi; jediný násobek osmi mezi $25$ a $35$ (méně než $6\\cdot 6=36$) je $32$, tedy proužků bylo $32:8=4$.',
             '6.2 Zbylo $32-25=7$ čtverečků.',
             '6.3 Obvod čtverce je $40$ cm, jeho strana $40:4=10$ cm; protože má v řadě $5$ čtverečků, má čtvereček stranu $10:5=2$ cm. Proužek je $1\\times 8$ čtverečků, tj. obdélník $2$ cm $\\times 16$ cm, a jeho obvod je $2\\cdot(2+16)=36$ cm.'],
     'ans': '6.1: $4$ proužky; 6.2: $7$ čtverečků; 6.3: $36$ cm', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2019 – úloha 7.1 (konstrukce)',
     'zad': ['Uvnitř kružnice $k$ se středem $S$ leží body $A$, $L$. Kružnici $k$ protíná přímka $c$ (viz obrázek).',
             'Bod $A$ je vrchol obdélníku $ABCD$. Strana $CD$ leží na přímce $c$. Vrchol $B$ leží na kružnici $k$.',
             'Sestrojte a označte písmeny chybějící vrcholy $B$, $C$, $D$ obdélníku $ABCD$ a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'kruznice-k.svg',
     'alt': 'Kružnice k se středem S, uvnitř body A a L, přímka c protínající kružnici v horní části.',
     'cap': 'Výchozí obrázek k úloze 7 (kružnice k, body A, L, přímka c)',
     'sol': ['Strana $CD$ leží na přímce $c$ a v obdélníku je $AD\\perp CD$, proto vrchol $D$ je pata kolmice z bodu $A$ na přímku $c$. Strana $AB$ je rovnoběžná s $c$; vrchol $B$ je průsečík rovnoběžky s $c$ vedené bodem $A$ s kružnicí $k$ (dva průsečíky $B_1$, $B_2$). Vrchol $C$ je pata kolmice z $B$ na přímku $c$. Úloha má dvě řešení.'],
     'ans': 'Dvě řešení: $D$ je pata kolmice z $A$ na přímku $c$, vrchol $B$ leží na kružnici $k$ na rovnoběžce s $c$ procházející bodem $A$ (polohy $B_1$, $B_2$), $C$ je pata kolmice z $B$ na $c$ – viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2019 – úloha 7.2 (konstrukce)',
     'zad': ['Uvnitř kružnice $k$ se středem $S$ leží body $A$, $L$. Kružnici $k$ protíná přímka $c$ (viz obrázek).',
             'Body $A$, $L$ jsou vrcholy rovnoramenného trojúhelníku $AKL$. Vrchol $K$ leží na kružnici $k$ a strany $AL$, $KL$ jsou stejně dlouhé.',
             'Sestrojte a označte písmenem chybějící vrchol $K$ trojúhelníku $AKL$ a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'kruznice-k.svg',
     'alt': 'Kružnice k se středem S, uvnitř body A a L, přímka c protínající kružnici v horní části.',
     'cap': 'Výchozí obrázek k úloze 7 (kružnice k, body A, L, přímka c)',
     'sol': ['Trojúhelník $AKL$ je rovnoramenný se základnou $AK$ a rameny $AL=KL$. Vrchol $K$ je proto stejně vzdálen od $L$ jako bod $A$, leží tedy na kružnici se středem $L$ a poloměrem $|AL|$; zároveň leží na kružnici $k$. Průsečíky obou kružnic dávají dvě řešení $K_1$, $K_2$.'],
     'ans': 'Dvě řešení: vrchol $K$ je průsečík kružnice $k$ s kružnicí se středem $L$ a poloměrem $|AL|$ (polohy $K_1$, $K_2$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2019 – úloha 8',
     'zad': ['Tři obrazce byly složeny z $5$ shodných čtverců a $4$ shodných rovnoramenných trojúhelníků. Sousední čtverce a trojúhelníky mají vždy společné vrcholy a nikde nepřečnívají (viz obrázek).',
             'Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
             '8.1 Obvod jednoho čtverce je polovinou obvodu 1. obrazce.',
             '8.2 Obvod 2. obrazce je stejný jako obvod 1. obrazce.',
             '8.3 Obvod 3. obrazce je dvakrát větší než obvod 2. obrazce.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'obrazce.svg',
     'alt': 'Tři obrazce: dva čtverce vedle sebe; rovnoběžník s úhlopříčkou; dům ze tří čtverců a dvou trojúhelníků.',
     'cap': 'Tři obrazce ze čtverců a trojúhelníků (schematický nákres)',
     'sol': ['Označme stranu čtverce $a$; rovnoramenný trojúhelník má základnu $a$ a ramena délky $2a$.',
             '8.1 Obvod čtverce je $4a$, obvod 1. obrazce (dva čtverce vedle sebe) je $6a$. Protože $4a\\neq\\tfrac{1}{2}\\cdot 6a=3a$, tvrzení neplatí – Ne.',
             '8.2 Obvod 2. obrazce (rovnoběžník ze dvou trojúhelníků, strany $a$ a $2a$) je $2\\cdot(a+2a)=6a$, tedy stejný jako obvod 1. obrazce – Ano.',
             '8.3 Obvod 3. obrazce je $12a$, což je dvakrát obvod 2. obrazce ($6a$) – Ano.'],
     'ans': '8.1: Ne; 8.2: Ano; 8.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2019 – úloha 9',
     'zad': ['Na jaře se konal dětský plavecký závod smíšených štafet. Každá štafeta uplavala celkem $48$ bazénů. Ve štafetě A bylo o $6$ dívek více než chlapců. Každá dívka uplavala $1$ bazén a každý chlapec $2$ bazény.',
             'Kolik dětí bylo ve štafetě A?'],
     'opts': ['A) méně než $32$ dětí', 'B) $32$ dětí', 'C) $34$ dětí', 'D) $36$ dětí', 'E) více než $36$ dětí'],
     'ln': 0,
     'sol': ['Označme počet chlapců $c$, pak dívek je $c+6$. Uplavané bazény: $2c+(c+6)=48$, tj. $3c+6=48$, odtud $c=14$. Dívek je $20$, celkem $14+20=34$ dětí.'],
     'ans': 'C) $34$ dětí', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2019 – úloha 10',
     'zad': ['V levé kapse mám o třetinu více mincí než v pravé kapse. Počty mincí v levé a pravé kapse se liší o $4$.',
             'Kolik mincí mám dohromady v obou kapsách?'],
     'opts': ['A) $12$', 'B) $16$', 'C) $20$', 'D) $28$', 'E) jiný počet'],
     'ln': 0,
     'sol': ['Označme počet mincí v pravé kapse $p$; v levé je $\\tfrac{4}{3}p$. Rozdíl $\\tfrac{4}{3}p-p=\\tfrac{p}{3}=4$, tedy $p=12$ a v levé kapse $16$. Dohromady $12+16=28$ mincí.'],
     'ans': 'D) $28$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2019 – úloha 11',
     'zad': ['Graf udává počty žáků jedné třídy v průběhu šesti let. Některé údaje v grafu chybí (viz obrázek). Po doplnění chybějících údajů (počet chlapců a dívek dohromady dává počet všech žáků) vycházejte pouze z doplněného grafu.',
             'Kolikrát došlo k meziroční změně počtu chlapců v období od 1. do 6. roku?'],
     'opts': ['A) jedenkrát', 'B) dvakrát', 'C) třikrát', 'D) čtyřikrát', 'E) pětkrát'],
     'ln': 0, 'svg': SVGGRAF, 'fn': 'graf-zaci.svg',
     'alt': 'Sdružený sloupcový graf počtu všech žáků, chlapců a dívek v 1. až 6. roce; některé sloupce chybí a jsou označeny otazníkem.',
     'cap': 'Počty žáků v jednotlivých letech (chybějící údaje označeny ?)',
     'sol': ['Doplněné počty chlapců v jednotlivých letech jsou $15$, $15$, $16$, $16$, $16$, $12$. Ke změně počtu došlo mezi 2. a 3. rokem a mezi 5. a 6. rokem, tedy dvakrát.'],
     'ans': 'B) dvakrát', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['statistika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2019 – úloha 12',
     'zad': ['Graf udává počty žáků jedné třídy v průběhu šesti let. Některé údaje v grafu chybí (viz obrázek). Po doplnění chybějících údajů (počet chlapců a dívek dohromady dává počet všech žáků) vycházejte pouze z doplněného grafu.',
             'Ve kterém roce byl počet chlapců o čtvrtinu větší než počet dívek?'],
     'opts': ['A) v 1. roce', 'B) ve 2. roce', 'C) ve 3. roce', 'D) ve 4. roce', 'E) v 5. roce'],
     'ln': 0, 'svg': SVGGRAF, 'fn': 'graf-zaci.svg',
     'alt': 'Sdružený sloupcový graf počtu všech žáků, chlapců a dívek v 1. až 6. roce; některé sloupce chybí a jsou označeny otazníkem.',
     'cap': 'Počty žáků v jednotlivých letech (chybějící údaje označeny ?)',
     'sol': ['V 1. roce bylo $15$ chlapců a $12$ dívek a platí $15=12+\\tfrac{1}{4}\\cdot 12$, tedy chlapců bylo o čtvrtinu více než dívek. (Počty: chlapci $15,15,16,16,16,12$; dívky $12,10,12,14,13,10$ – v žádném jiném roce poměr o čtvrtinu neplatí.)'],
     'ans': 'A) v 1. roce', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2019 – úloha 13',
     'zad': ['Z malých krychliček byly slepeny tři stejné kvádry o rozměrech $3\\times 2\\times 2$ krychličky. Z každého kvádru jsme odstranili dvě malé krychličky a vytvořili tak tři nová tělesa. Na každé nové těleso jsme doprostřed každého čtverečku na jeho povrchu (i zespodu) nalepili jeden černý puntík (viz obrázek).',
             'Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).',
             '13.1 Kolik puntíků je na 1. tělese?',
             '13.2 Kolik puntíků je na 2. tělese?',
             '13.3 Kolik puntíků je na 3. tělese?'],
     'opts': ['A) $30$', 'B) $31$', 'C) $32$', 'D) $34$', 'E) $36$', 'F) jiný počet'],
     'ln': 0, 'svg': SVG13, 'fn': 'telesa.svg',
     'alt': 'Tři tělesa vzniklá z kvádru 3 krát 2 krát 2 odebráním dvou krychliček, s černými puntíky na čtverečcích povrchu (schematicky).',
     'cap': 'schematický nákres',
     'sol': ['Počet puntíků se rovná počtu jednotkových čtverečků na celém povrchu tělesa (i zespodu). Celý kvádr $3\\times 2\\times 2$ má povrch $2\\cdot(3\\cdot 2+3\\cdot 2+2\\cdot 2)=32$ čtverečků.',
             '13.1 U 1. tělesa jsou obě odebrané krychličky rohové (každá měla na povrchu $3$ čtverečky), povrch se nezmění: $32$ – odpověď C.',
             '13.2 U 2. tělesa vznikne odebráním dvou sousedních krychliček výklenek a počet čtverečků povrchu klesne na $30$ – odpověď A.',
             '13.3 U 3. tělesa se odebráním dvou krychliček počet čtverečků povrchu zvětší na $36$ – odpověď E.'],
     'ans': '13.1: C ($32$); 13.2: A ($30$); 13.3: E ($36$)', 'pts': 5, 'mins': 6, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2019 – úloha 14',
     'zad': ['Na čtvercové síti vytváříme ze sirek čtvercové labyrinty podle jednotných pravidel: každá sirka odděluje vždy dvě pole čtvercové sítě; sirky na sebe navazují, začínají ve středu labyrintu a končí v jeho levém dolním rohu; nejmenší labyrint je složen z $8$ sirek a obsahuje $4$ pole; při sestavování následujícího labyrintu se přidá k předchozímu nejmenší možný počet sirek. Na obrázku jsou tři nejmenší labyrinty.',
             '14.1 Vypočtěte, kolik polí čtvercové sítě obsahuje 4. labyrint.',
             '14.2 Vypočtěte, o kolik polí čtvercové sítě je 7. labyrint větší než 6. labyrint.',
             '14.3 Vypočtěte, kolik sirek musíme přidat, chceme-li zvětšit 9. labyrint na 10. labyrint.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'labyrinty.svg',
     'alt': 'Tři nejmenší čtvercové labyrinty ze sirek ve tvaru spirály na čtvercové síti.',
     'cap': '1., 2. a 3. nejmenší labyrint',
     'sol': ['V $n$-tém labyrintu je $(2n)^2=4n^2$ polí a $4n(n+1)$ sirek. (1. labyrint: $4$ pole a $8$ sirek.)',
             '14.1 4. labyrint: $4\\cdot 4^2=64$ polí.',
             '14.2 Rozdíl 7. a 6. labyrintu: $4\\cdot 7^2-4\\cdot 6^2=196-144=52$ polí.',
             '14.3 Přidané sirky: $4\\cdot 10\\cdot 11-4\\cdot 9\\cdot 10=440-360=80$ sirek.'],
     'ans': '14.1: $64$ polí; 14.2: o $52$ polí; 14.3: $80$ sirek', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PAD19C0T01'
    gen.YEAR = 2019

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2019')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
