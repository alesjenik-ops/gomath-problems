# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2024, MATEMATIKA 7B (sestilete obory, 7. rocnik), 1. radny termin.
# Kod testu: M7PBD24C0T02. 16 uloh (po rozdeleni nezavislych poduloh 19 uloh), 50 bodu.
# Zdroj odpovedi: klic spravnych reseni (KSR) k testu M7PBD24C0T02.

# ---- SVG obrazky (bez ' a \) ----

# uloha 7: ram se zrcadlem + schema hranolu s ozdobou
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 220" font-family="sans-serif">
<rect x="20" y="20" width="180" height="180" fill="#ededed" stroke="#000" stroke-width="2"/>
<rect x="48" y="48" width="124" height="124" fill="#cfe0f0" stroke="#000"/>
<text x="110" y="114" font-size="12" text-anchor="middle">zrcadlo</text>
<rect x="28" y="28" width="16" height="16" fill="#8f8f8f" stroke="#000"/>
<rect x="176" y="28" width="16" height="16" fill="#8f8f8f" stroke="#000"/>
<rect x="28" y="176" width="16" height="16" fill="#8f8f8f" stroke="#000"/>
<rect x="176" y="176" width="16" height="16" fill="#8f8f8f" stroke="#000"/>
<text x="110" y="214" font-size="11" text-anchor="middle">ram se zrcadlem (4 hranoly)</text>
<rect x="248" y="30" width="22" height="150" fill="#f4f4f4" stroke="#000"/>
<rect x="248" y="30" width="22" height="22" fill="#8f8f8f" stroke="#000"/>
<text x="284" y="44" font-size="11">hranol: podstava 5 cm x 5 cm,</text>
<text x="284" y="60" font-size="11">ozdoba na 3 stranach = 6 % povrchu</text>
<text x="284" y="90" font-size="11">(schematicky nakres)</text>
</svg>"""

# uloha 8: primka p, bod A na p, bod S_b mimo p (vychozi obrazek)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 320" font-family="sans-serif">
<line x1="60" y1="280" x2="360" y2="60" stroke="#000" stroke-width="2"/>
<text x="72" y="276" font-size="15" font-style="italic">p</text>
<text x="314" y="90" font-size="14">x</text>
<text x="330" y="82" font-size="15" font-style="italic">A</text>
<text x="242" y="196" font-size="14">x</text>
<text x="256" y="198" font-size="15" font-style="italic">S</text>
<text x="268" y="202" font-size="10">b</text>
</svg>"""

# uloha 9: sloupcovy graf pocet chlapcu a divek podle rocniku
def _graf9():
    data = [("6. rocnik", 24, 21), ("7. rocnik", 23, 27), ("8. rocnik", 25, 25), ("9. rocnik", 23, 22)]
    x0, y0, sc, bw, grp = 60, 300, 8, 26, 110
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 340" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="40" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="500" y2="{y0}" stroke="#000"/>')
    for v in range(0, 31, 5):
        y = y0 - v * sc
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    x = x0 + 24
    for name, ch, di in data:
        s.append(f'<rect x="{x}" y="{y0-ch*sc}" width="{bw}" height="{ch*sc}" fill="#b8b8b8" stroke="#000"/>')
        s.append(f'<rect x="{x+bw+4}" y="{y0-di*sc}" width="{bw}" height="{di*sc}" fill="#fff" stroke="#000"/>')
        s.append(f'<text x="{x+bw+2}" y="{y0+16}" font-size="11" text-anchor="middle">{name}</text>')
        x += grp
    s.append('<rect x="330" y="16" width="12" height="12" fill="#b8b8b8" stroke="#000"/><text x="348" y="26" font-size="11">Chlapci</text>')
    s.append('<rect x="410" y="16" width="12" height="12" fill="#fff" stroke="#000"/><text x="428" y="26" font-size="11">Divky</text>')
    s.append('</svg>')
    return "".join(s)
SVG9 = _graf9()

# uloha 10: ctvercova sit s utvary A (ctyruhelnik) a B (trojuhelnik)
def _sit10():
    c, ox, oy, W, H = 24, 20, 20, 13, 7
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+W*c} {oy*2+H*c}" font-family="sans-serif">']
    for i in range(W + 1):
        s.append(f'<line x1="{ox+i*c}" y1="{oy}" x2="{ox+i*c}" y2="{oy+H*c}" stroke="#bbb"/>')
    for j in range(H + 1):
        s.append(f'<line x1="{ox}" y1="{oy+j*c}" x2="{ox+W*c}" y2="{oy+j*c}" stroke="#bbb"/>')
    s.append(f'<polygon points="{ox+1*c},{oy+2*c} {ox+4*c},{oy+1*c} {ox+4*c},{oy+5*c} {ox+1*c},{oy+5*c}" fill="none" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="{ox+7*c},{oy+3*c} {ox+10*c},{oy+2*c} {ox+9*c},{oy+6*c}" fill="none" stroke="#000" stroke-width="2"/>')
    s.append(f'<text x="{ox+2*c}" y="{oy+4*c}" font-size="15" font-weight="bold">A</text>')
    s.append(f'<text x="{ox+8*c}" y="{oy+4*c}" font-size="15" font-weight="bold">B</text>')
    s.append(f'<rect x="{ox+11*c}" y="{oy}" width="{c}" height="{c}" fill="#c8c8c8" stroke="#000"/>')
    s.append(f'<text x="{ox+W*c-4}" y="{oy+c+12}" font-size="10" text-anchor="end">16 cm2</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _sit10()

# uloha 11: tabulka ordinacni doby a poctu pacientu
def _tab11():
    days = [("pondeli", "7:00-13:30"), ("utery", "7:00-14:30"), ("streda", "7:00-14:30"), ("ctvrtek", "11:00-18:00"), ("patek", "7:00-14:00")]
    muzi, zeny, deti = [7, 6, 9, 9, 7], [5, 10, 7, 11, 6], [6, 4, 7, 1, 4]
    cw, x0, y0, ch = 96, 90, 42, 34
    W = x0 + len(days) * cw
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W+10} {y0+4*ch+10}" font-family="sans-serif">']
    s.append(f'<text x="{x0 + len(days)*cw//2}" y="{y0-8}" font-size="12" text-anchor="middle">Ordinacni doba</text>')
    for i, (d, t) in enumerate(days):
        cx = x0 + i * cw
        s.append(f'<rect x="{cx}" y="{y0}" width="{cw}" height="{ch}" fill="#e6e6e6" stroke="#000"/>')
        s.append(f'<text x="{cx+cw//2}" y="{y0+15}" font-size="11" text-anchor="middle">{d}</text>')
        s.append(f'<text x="{cx+cw//2}" y="{y0+29}" font-size="10" text-anchor="middle">{t}</text>')
    for r, (lbl, vals) in enumerate([("muzi", muzi), ("zeny", zeny), ("deti", deti)]):
        ry = y0 + ch + r * ch
        s.append(f'<rect x="0" y="{ry}" width="{x0}" height="{ch}" fill="#e6e6e6" stroke="#000"/>')
        s.append(f'<text x="{x0//2}" y="{ry+21}" font-size="11" text-anchor="middle">{lbl}</text>')
        for i, v in enumerate(vals):
            cx = x0 + i * cw
            s.append(f'<rect x="{cx}" y="{ry}" width="{cw}" height="{ch}" fill="#fff" stroke="#000"/>')
            s.append(f'<text x="{cx+cw//2}" y="{ry+21}" font-size="12" text-anchor="middle">{v}</text>')
    s.append(f'<rect x="0" y="{y0}" width="{x0}" height="{ch}" fill="#e6e6e6" stroke="#000"/>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _tab11()

# uloha 12: sachovnice 8x8 se znackami (schematicky nakres)
def _sach():
    c, ox, oy, N = 26, 15, 15, 8
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+N*c} {oy*2+N*c+34}" font-family="sans-serif">']
    for i in range(N + 1):
        s.append(f'<line x1="{ox+i*c}" y1="{oy}" x2="{ox+i*c}" y2="{oy+N*c}" stroke="#000"/>')
        s.append(f'<line x1="{ox}" y1="{oy+i*c}" x2="{ox+N*c}" y2="{oy+i*c}" stroke="#000"/>')
    s.append(f'<circle cx="{ox+c//2}" cy="{oy+c//2}" r="8" fill="none" stroke="#000"/>')
    s.append(f'<circle cx="{ox+2*c+c//2}" cy="{oy+c//2}" r="8" fill="none" stroke="#000"/>')
    s.append(f'<polygon points="{ox+4*c+5},{oy+c-5} {ox+4*c+c//2},{oy+5} {ox+5*c-5},{oy+c-5}" fill="none" stroke="#000"/>')
    s.append(f'<text x="{ox+N*c//2}" y="{oy+N*c+22}" font-size="11" text-anchor="middle">Sachovnice 8 x 8 se znackami - rozmisteni viz testovy sesit.</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _sach()

# uloha 14: rovnobezky a, b a primky c, d; uhly 147 stupnu a alfa
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif">
<line x1="40" y1="90" x2="380" y2="90" stroke="#000" stroke-width="1.5"/>
<text x="70" y="82" font-size="14" font-style="italic">a</text>
<text x="92" y="86" font-size="12">||</text>
<line x1="40" y1="180" x2="380" y2="180" stroke="#000" stroke-width="1.5"/>
<text x="70" y="172" font-size="14" font-style="italic">b</text>
<text x="92" y="176" font-size="12">||</text>
<line x1="150" y1="30" x2="150" y2="270" stroke="#000" stroke-width="1.5"/>
<text x="138" y="44" font-size="14" font-style="italic">d</text>
<line x1="70" y1="270" x2="360" y2="40" stroke="#000" stroke-width="1.5"/>
<text x="70" y="262" font-size="14" font-style="italic">c</text>
<rect x="152" y="78" width="10" height="10" fill="none" stroke="#000"/>
<text x="298" y="84" font-size="12">147 st.</text>
<text x="166" y="204" font-size="14">alfa</text>
</svg>"""

# uloha 16: opakujici se motiv dlazby 4x4 (rohove trojuhelniky + stredovy kosoctverec)
def _dlazba():
    c, ox, oy, N = 40, 10, 10, 4
    g = "#8a8a8a"
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+N*c} {ox*2+N*c}" font-family="sans-serif">']
    s.append(f'<polygon points="{ox},{oy} {ox+c},{oy} {ox},{oy+c}" fill="{g}"/>')
    s.append(f'<polygon points="{ox+3*c},{oy} {ox+4*c},{oy} {ox+4*c},{oy+c}" fill="{g}"/>')
    s.append(f'<polygon points="{ox},{oy+3*c} {ox},{oy+4*c} {ox+c},{oy+4*c}" fill="{g}"/>')
    s.append(f'<polygon points="{ox+4*c},{oy+3*c} {ox+4*c},{oy+4*c} {ox+3*c},{oy+4*c}" fill="{g}"/>')
    cx, cy = ox + 2 * c, oy + 2 * c
    s.append(f'<polygon points="{cx},{oy+1*c} {ox+3*c},{cy} {cx},{oy+3*c} {ox+1*c},{cy}" fill="{g}"/>')
    for i in range(N + 1):
        s.append(f'<line x1="{ox+i*c}" y1="{oy}" x2="{ox+i*c}" y2="{oy+N*c}" stroke="#000"/>')
        s.append(f'<line x1="{ox}" y1="{oy+i*c}" x2="{ox+N*c}" y2="{oy+i*c}" stroke="#000"/>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _dlazba()

B = ['zs2', 'r7']  # 7. rocnik ZS (sestilete obory / prijimacky)

PROBLEMS = [
    {'name': 'CERMAT M7B 2024 - uloha 1', 'zad': ['Vypocitejte v litrech ctyri petiny z $8$ hektolitru.'],
     'opts': None, 'ln': 2,
     'sol': ['$8$ hektolitru $= 800$ litru, ctyri petiny z toho: $\\frac{4}{5}\\cdot 800 = 640$ litru.'],
     'ans': '$640$ litru', 'pts': 1, 'mins': 2, 'diff': '1',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2024 - uloha 2.1', 'zad': ['Vypocitejte (uvedte cely postup reseni): $4\\cdot(-5\\cdot 3)-24:(-0{,}2+1)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$4\\cdot(-15)-24:0{,}8 = -60-30 = -90$.'],
     'ans': '$-90$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2024 - uloha 2.2', 'zad': ['Vypocitejte (uvedte cely postup reseni): $\\frac{2}{0{,}02}:100-0{,}4\\cdot 25=$'],
     'opts': None, 'ln': 3,
     'sol': ['$100:100-10 = 1-10 = -9$.'],
     'ans': '$-9$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2024 - uloha 3.1', 'zad': ['Vypocitejte a vysledek zapiste zlomkem v zakladnim tvaru: $\\left(\\frac{11}{12}-\\frac{3}{4}\\right)-\\left(\\frac{7}{8}-\\frac{5}{6}\\right)=$'],
     'opts': None, 'ln': 4,
     'sol': ['$\\left(\\frac{11}{12}-\\frac{9}{12}\\right)-\\left(\\frac{21}{24}-\\frac{20}{24}\\right)=\\frac{2}{12}-\\frac{1}{24}=\\frac{4}{24}-\\frac{1}{24}=\\frac{3}{24}=\\frac{1}{8}$.'],
     'ans': '$\\frac{1}{8}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2024 - uloha 3.2', 'zad': ['Vypocitejte a vysledek zapiste zlomkem v zakladnim tvaru: $\\dfrac{3\\cdot\\frac{4}{9}-\\frac{2}{3}}{\\frac{5}{6}+\\frac{3}{4}+\\frac{1}{12}}=$'],
     'opts': None, 'ln': 4,
     'sol': ['Citatel: $3\\cdot\\frac{4}{9}-\\frac{2}{3}=\\frac{4}{3}-\\frac{2}{3}=\\frac{2}{3}$. Jmenovatel: $\\frac{5}{6}+\\frac{3}{4}+\\frac{1}{12}=\\frac{10+9+1}{12}=\\frac{20}{12}=\\frac{5}{3}$. Podil: $\\frac{2}{3}:\\frac{5}{3}=\\frac{2}{5}$.'],
     'ans': '$\\frac{2}{5}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2024 - uloha 4.1', 'zad': ['Petr, Jirka a Adam spolecne natreli cely plot kolem skolniho hriste. Petr nejprve natrel jednu ctvrtinu, Jirka dve tretiny toho, co zbylo, a nakonec Adam poslednich $150$ metru. Jak dlouhy byl plot kolem hriste v metrech?'],
     'opts': None, 'ln': 4,
     'sol': ['Po Petrovi zbyvaji $\\frac{3}{4}$ plotu. Jirka natrel $\\frac{2}{3}\\cdot\\frac{3}{4}=\\frac{1}{2}$ plotu. Zbyva $\\frac{3}{4}-\\frac{1}{2}=\\frac{1}{4}$, coz natrel Adam ($150$ m). Cely plot: $4\\cdot 150 = 600$ m.'],
     'ans': '$600$ m', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2024 - uloha 4.2', 'zad': ['Kdyz nezname cislo vynasobime ctyrmi, dostaneme stejne cislo, jako kdyz vydelime ctyrmi cislo $256$. Urcete nezname cislo.'],
     'opts': None, 'ln': 3,
     'sol': ['$4x = 256:4 = 64$, tedy $x = 16$.'],
     'ans': '$16$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2024 - uloha 5', 'zad': [
        'Pani Stastna chysta krabicky s vanocnim cukrovim. Do kazde krabicky dava $300$ g cukrovi. Uz rozdelila ctyri petiny napeceneho cukrovi a zbyva ji $1{,}2$ kg. Pani Vesela napekla o jednu polovinu vice cukrovi nez pani Stastna a chysta krabicky po $500$ g.',
        '5.1 Kolik krabicek nachystala pani Stastna?',
        '5.2 Kolik krabicek nachystala pani Vesela?'],
     'opts': None, 'ln': 4,
     'sol': [
        'Zbylych $1{,}2$ kg je jedna petina cukrovi pani Stastne, celkem tedy napekla $5\\cdot 1{,}2 = 6$ kg $= 6000$ g.',
        '5.1 Pocet krabicek: $6000:300 = 20$.',
        '5.2 Pani Vesela napekla $6\\cdot 1{,}5 = 9$ kg $= 9000$ g, krabicek: $9000:500 = 18$.'],
     'ans': '5.1: $20$ krabicek; 5.2: $18$ krabicek', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2024 - uloha 6', 'zad': [
        'Honza, Patrik a David jsou kolegove. Kazdy z nich chodi hrat golf, ale maji ruzne pracovni povinnosti, takze nemohou vzdy hrat spolu. Honza chodi hrat jen kazdy $4.$ den, Patrik jen kazdy $6.$ den a David jen kazdy $5.$ den. Spolecne si zahraji $4.\\,5.\\,2024$. (Kveten ma $31$ dni, cerven $30$ dni.)',
        '6.1 V jaky nejblizsi nasledujici den (uvedte datum) se opet vsichni tri sejdou?',
        '6.2 Kolikrat se mezi dvema setkanimi vsech tri na golfu sesli pouze Honza s Davidem?'],
     'opts': None, 'ln': 4,
     'sol': [
        '6.1 Nejmensi spolecny nasobek cisel $4$, $5$ a $6$ je $60$; vsichni tri se sejdou po $60$ dnech. Od $4.\\,5.$ o $60$ dni: $27$ dni do konce kvetna, dalsich $30$ dni cerven, zbyvaji $3$ dny cervence - tedy $3.\\,7.\\,2024$.',
        '6.2 Honza (kazdy $4.$ den) a David (kazdy $5.$ den) se schazeji po $20$ dnech, tj. $24.\\,5.$ a $13.\\,6.$ (dne $3.\\,7.$ uz je s nimi i Patrik). Pouze Honza s Davidem se tedy sesli dvakrat.'],
     'ans': '6.1: $3.\\,7.\\,2024$; 6.2: dvakrat ($24.\\,5.$ a $13.\\,6.$)', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2024 - uloha 7', 'zad': [
        'Ram kolem ctvercoveho zrcadla je tvoren $4$ shodnymi hranoly se ctvercovou podstavou o delce hrany $5$ cm. Kazdy z hranolu je na jednom konci ze tri stran stejnym zpusobem ozdoben. Ozdobena plocha jednoho hranolu (tri ctverce $5$ cm $\\times$ $5$ cm) tvori $6\\,\\%$ povrchu tohoto hranolu.',
        'Jak dlouha je strana viditelne casti ctvercoveho zrcadla umisteneho uvnitr ramu?'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'ram-zrcadlo.svg',
     'alt': 'Ctvercovy ram se zrcadlem tvoreny ctyrmi hranoly a schema jednoho hranolu s ozdobou na tri stranach.',
     'cap': 'Schematicky nakres ramu a hranolu',
     'sol': [
        'Ozdobena plocha je $3\\cdot(5\\cdot 5) = 75$ cm2 a tvori $6\\,\\%$ povrchu, takze povrch hranolu je $75:0{,}06 = 1250$ cm2.',
        'Pro delku hranolu $d$ plati $2\\cdot 5\\cdot 5 + 4\\cdot 5\\cdot d = 1250$, tj. $50 + 20d = 1250$, odtud $d = 60$ cm.',
        'V rozich se sousedni hranoly prekryvaji o $5$ cm, proto strana viditelne casti zrcadla je $60 - 5 = 55$ cm.'],
     'ans': '$55$ cm', 'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['stereometrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2024 - uloha 8 (konstrukce)', 'zad': [
        'Je dana primka $p$, bod $A$, ktery lezi na primce $p$, a bod $S_b$, ktery lezi mimo primku $p$ (viz obrazek).',
        '8.1 Sestrojte rovnoramenny trojuhelnik $ABC$ se zakladnou $BC$, pokud plati, ze teznice k zakladne $BC$ lezi na primce $p$ a bod $S_b$ je stredem strany $b$.',
        '8.2 Narysujte teziste trojuhelniku $ABC$ a tento bod popiste pismenem $T$.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'primka-p-bod-A.svg',
     'alt': 'Primka p, bod A lezici na primce p a bod S_b lezici mimo primku p.',
     'cap': 'Vychozi obrazek k uloze 8',
     'sol': [
        'Strana $b$ je strana $AC$, jejim stredem je bod $S_b$; bod $C$ proto lezi na primce $AS_b$ tak, ze $|S_bC| = |AS_b|$ (kruznice $k_1$ se stredem $S_b$ a polomerem $|AS_b|$).',
        'Trojuhelnik je rovnoramenny se zakladnou $BC$ a teznici z $A$ na primce $p$; primka $p$ je tedy osou strany $BC$. Patu $X$ kolmice $m$ z bodu $C$ na primku $p$ ziskame jako $m\\cap p$; bod $B$ je obrazem $C$ v soumernosti podle $p$, tj. na primce $CX$ plati $|XB| = |CX|$ (kruznice $k_2$).',
        'Teziste $T$ je prusecik primky $p$ (na niz lezi teznice z $A$) a teznice $BS_b$: $T = p\\cap BS_b$.'],
     'ans': 'Rovnoramenny trojuhelnik $ABC$: $C$ na primce $AS_b$ s $|S_bC|=|AS_b|$, $B$ obraz $C$ v osove soumernosti podle $p$; teziste $T = p\\cap BS_b$ (viz nacrt v klici).',
     'pts': 3, 'mins': 8, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2024 - uloha 9', 'zad': [
        'V grafu je uveden pocet chlapcu a pocet divek podle rocniku ZS, jehoz jsou zaky.',
        '9.1 Kolik zaku celkem navstevuje druhy stupen ZS?',
        '9.2 Kolik procent zaku druheho stupne ZS tvori divky?',
        '9.3 Jakou cast zaku druheho stupne tvori zaci $9.$ rocniku? Vysledek vyjadrete zlomkem v zakladnim tvaru.'],
     'opts': None, 'ln': 4, 'svg': SVG9, 'fn': 'graf-rocniky.svg',
     'alt': 'Sloupcovy graf: pocet chlapcu a divek v 6. az 9. rocniku (chlapci 24, 23, 25, 23; divky 21, 27, 25, 22).',
     'cap': 'Pocet chlapcu a divek podle rocniku',
     'sol': [
        'Pocty zaku: $6.$ rocnik $24+21=45$, $7.$ rocnik $23+27=50$, $8.$ rocnik $25+25=50$, $9.$ rocnik $23+22=45$.',
        '9.1 Celkem $45+50+50+45 = 190$ zaku.',
        '9.2 Divek je $21+27+25+22 = 95$, coz je $\\frac{95}{190} = 50\\,\\%$.',
        '9.3 Zaku $9.$ rocniku je $45$, tedy $\\frac{45}{190} = \\frac{9}{38}$.'],
     'ans': '9.1: $190$ zaku; 9.2: $50\\,\\%$; 9.3: $\\frac{9}{38}$', 'pts': 3, 'mins': 5, 'diff': '2',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2024 - uloha 10', 'zad': [
        'Ve ctvercove siti jsou umisteny dva obrazce (utvary $A$ a $B$). Jejich vrcholy lezi v mrizovych bodech. Sit je tvorena ctverecky s obsahem $16$ cm2.',
        'Rozhodnete o kazdem z nasledujicich tvrzeni (10.1-10.3), zda je pravdive (A), ci nikoli (N).',
        '10.1 Obsah utvaru $A$ je $256$ cm2.',
        '10.2 Obsah utvaru $A$ je k obsahu utvaru $B$ v pomeru $7:4$.',
        '10.3 Obvody obou utvaru se lisi o $16$ cm.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'sit-utvary-AB.svg',
     'alt': 'Ctvercova sit s utvarem A (ctyruhelnik) a utvarem B (trojuhelnik), vrcholy v mrizovych bodech.',
     'cap': 'Schematicky nakres (jeden ctverecek ma obsah 16 cm2)',
     'sol': [
        'Jeden ctverecek ma obsah $16$ cm2, jeho strana meri $4$ cm.',
        '10.1 Utvar $A$ zabira $16$ ctverecku, jeho obsah je $16\\cdot 16 = 256$ cm2 - pravda (A).',
        '10.2 Pomer obsahu utvaru $A$ a $B$ neni $7:4$ - nepravda (N).',
        '10.3 Obvody obou utvaru se lisi o $16$ cm - pravda (A).'],
     'ans': '10.1: A; 10.2: N; 10.3: A', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2024 - uloha 11', 'zad': [
        'Zubni lekar si zaznamenava, kolik pacientu behem tydne osetril. Kazdy den ma pulhodinovou prestavku. Ordinacni doba a pocty osetrenych muzu, zen a deti jsou v tabulce.',
        'Rozhodnete o kazdem z nasledujicich tvrzeni (11.1-11.3), zda je pravdive (A), ci nikoli (N).',
        '11.1 Za cely tyden osetril dany lekar za jednu hodinu v prumeru $3$ pacienty.',
        '11.2 Prumerny cas na osetreni jednoho pacienta byl u daneho lekare nejkratsi ve stredu.',
        '11.3 Prumerny cas na osetreni jednoho pacienta byl u daneho lekare v pondeli vice nez $20$ minut.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'tabulka-ordinace.svg',
     'alt': 'Tabulka poctu osetrenych muzu, zen a deti a ordinacni doby pro pondeli az patek.',
     'cap': 'Pocet pacientu a ordinacni doba v jednotlivych dnech',
     'sol': [
        'Cista ordinacni doba (bez pulhodinove prestavky) a pocet pacientu: pondeli $6$ h / $18$, utery $7$ h / $20$, streda $7$ h / $23$, ctvrtek $6{,}5$ h / $21$, patek $6{,}5$ h / $17$.',
        '11.1 Celkem $99$ pacientu za $33$ hodin, tj. $99:33 = 3$ pacienti za hodinu - pravda (A).',
        '11.2 Prumerny cas na pacienta: streda $420:23 \\approx 18{,}3$ min je nejmene ze vsech dnu - pravda (A).',
        '11.3 V pondeli $360:18 = 20$ min, coz neni vice nez $20$ minut - nepravda (N).'],
     'ans': '11.1: A; 11.2: A; 11.3: N', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2024 - uloha 12', 'zad': [
        'Na sachovnici $8\\times 8$ jsou prazdna pole a pole se znackami (kolecka, hvezdy, sipky, trojuhelniky a kosoctverce).',
        'Jaky je pomer poctu kolecek ku poctu prazdnych poli?'],
     'opts': ['A) $1:4$', 'B) $1:3$', 'C) $3:8$', 'D) $8:3$', 'E) $5:4$'], 'ln': 0,
     'svg': SVG12, 'fn': 'sachovnice.svg',
     'alt': 'Sachovnice 8 krat 8 s prazdnymi poli a poli se znackami (schematicky nakres).',
     'cap': 'Sachovnice se znackami - viz testovy sesit',
     'sol': ['Pomer poctu kolecek k poctu prazdnych poli na sachovnici je $3:8$ (moznost C).'],
     'ans': 'C) $3:8$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2024 - uloha 13', 'zad': [
        'Mapa na orientacni beh ma meritko $1:5\\,000$.',
        'Jak velkou vzdalenost v metrech ubehli orientacni bezci, je-li ubehnuta vzdalenost vyznacena na mape useckou o delce $8{,}5$ cm?'],
     'opts': ['A) $42{,}5$ m', 'B) $142{,}5$ m', 'C) $212{,}5$ m', 'D) $425$ m', 'E) $4\\,250$ m'], 'ln': 0,
     'sol': ['Skutecna vzdalenost je $8{,}5$ cm $\\cdot\\, 5\\,000 = 42\\,500$ cm $= 425$ m.'],
     'ans': 'D) $425$ m', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2024 - uloha 14', 'zad': [
        'Jsou dany rovnobezky $a$, $b$ a primky $c$, $d$ (viz obrazek). Primka $d$ je kolma k rovnobezkam, primka $c$ je ruznobezka, ktera s primkou $a$ svira uhel $147^\\circ$.',
        'Jaka je velikost uhlu $\\alpha$? Velikosti uhlu nemerte, ale vypocitejte.'],
     'opts': ['A) $67^\\circ$', 'B) $57^\\circ$', 'C) $53^\\circ$', 'D) $47^\\circ$', 'E) $33^\\circ$'], 'ln': 0,
     'svg': SVG14, 'fn': 'uhly-rovnobezky.svg',
     'alt': 'Rovnobezky a, b, kolma primka d a ruznobezka c; u primky a je vyznacen uhel 147 stupnu, u primky b uhel alfa.',
     'cap': 'Schematicky nakres k uloze 14',
     'sol': ['Primka $c$ svira s rovnobezkou $a$ (a tedy i s $b$) ostry uhel $180^\\circ - 147^\\circ = 33^\\circ$. Protoze primka $d$ je kolma k rovnobezkam, je uhel $\\alpha$ mezi primkami $c$ a $d$ roven $90^\\circ - 33^\\circ = 57^\\circ$.'],
     'ans': 'B) $57^\\circ$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2024 - uloha 15', 'zad': [
        'Ke kazde poduloze (15.1-15.3) priradte spravny vysledek z nabidky (A-F).',
        '15.1 $22.$ unora letosniho roku prislo do zlatnictvi $36$ lidi, coz je $80\\,\\%$ zakazniku, kteri prisli ve stejny den minuleho roku. Kolik lidi navstivilo zlatnictvi $22.$ unora vloni?',
        '15.2 Penal stal puvodne $60$ Kc, po Vanocich byl zlevnen o $30\\,\\%$ z ceny. Jaka je nova cena penalu v korunach?',
        '15.3 Puvodne stal televizor $18\\,000$ Kc, jeho nova cena je $9\\,720$ Kc. O kolik procent byl televizor zlevnen?'],
     'opts': ['A) $42$', 'B) $43$', 'C) $44$', 'D) $45$', 'E) $46$', 'F) $47$'], 'ln': 0,
     'sol': [
        '15.1 $36$ je $80\\,\\%$, tj. $36:0{,}8 = 45$ lidi - moznost D.',
        '15.2 Sleva $30\\,\\%$: nova cena $60\\cdot 0{,}7 = 42$ Kc - moznost A.',
        '15.3 $9\\,720:18\\,000 = 0{,}54$, cena klesla na $54\\,\\%$, sleva je $46\\,\\%$ - moznost E.'],
     'ans': '15.1: D ($45$); 15.2: A ($42$ Kc); 15.3: E ($46\\,\\%$)', 'pts': 6, 'mins': 6, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7B 2024 - uloha 16', 'zad': [
        'Do chodby dlouhe $5{,}6$ m a siroke $3{,}2$ m bude tatinek pokladat dlazbu. Pouzivat bude jednobarevne a dvoubarevne ctvercove dlazdice o strane $20$ cm. Sestavovat je bude do motivu na obrazku, ktery se bude pravidelne opakovat.',
        '16.1 Kolik kusu jednobarevnych dlazdic bude tatinek potrebovat na vydlazdeni cele chodby?',
        '16.2 Kolik metru ctverecnich dvoubarevnych dlazdic bude tatinek potrebovat na vydlazdeni cele chodby? Vysledek uvedte s presnosti na dve desetinna mista.',
        '16.3 Nejmensi baleni, po kterem se jednobarevne dlazdice prodavaji, je $1$ m2; cena za $1$ m2 je $240$ Kc. Kolik korun zaplati tatinek za jednobarevne dlazdice?',
        '16.4 Dvoubarevne dlazdice se prodavaji pouze v baleni po $20$ kusech; cena za baleni je $360$ Kc. Kolik korun zaplati tatinek za dvoubarevne dlazdice?'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'dlazba-motiv.svg',
     'alt': 'Opakujici se ctvercovy motiv dlazby 4 krat 4 s rohovymi trojuhelniky a stredovym kosoctvercem.',
     'cap': 'Motiv dlazby (schematicky nakres)',
     'sol': [
        'Chodba ma rozmery $28\\times 16 = 448$ dlazdic (strana dlazdice $0{,}2$ m). V opakujicim se motivu $4\\times 4$ je polovina dlazdic jednobarevnych a polovina dvoubarevnych, takze obou druhu je po $448:2 = 224$ kusech.',
        '16.1 Jednobarevnych dlazdic je $224$ kusu.',
        '16.2 Dvoubarevnych je $224$ kusu, tj. $224\\cdot 0{,}2\\cdot 0{,}2 = 8{,}96$ m2.',
        '16.3 Jednobarevne ($8{,}96$ m2) se prodavaji po celych $1$ m2, nutno koupit $9$ m2: $9\\cdot 240 = 2\\,160$ Kc.',
        '16.4 Dvoubarevnych $224$ kusu, baleni po $20$: nutno koupit $12$ baleni: $12\\cdot 360 = 4\\,320$ Kc.'],
     'ans': '16.1: $224$ kusu; 16.2: $8{,}96$ m2; 16.3: $2\\,160$ Kc; 16.4: $4\\,320$ Kc', 'pts': 4, 'mins': 9, 'diff': '4',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PBD24C0T02'
    gen.YEAR = 2024

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP nazev: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Neparovy $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakazany znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrazek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'uloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7B-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
