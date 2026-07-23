# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2018, MATEMATIKA 5A (osmileté obory, 5. ročník),
# 1. řádný termín. Kód testu: M5PAD18C0T01.
# 14 úloh; po rozdělení izolovaných poduúloh (1.1/1.2 „Vypočtěte", 7.1/7.2 konstrukce) 16 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR); všechny počtářské výsledky ověřeny přepočtem.
# Součet bodů = 50.

# ---- SVG obrázky (bez znaků apostrof a zpětné lomítko) ----

# úloha 3: farmář Malý (malé pytle + zbytek 150 kg) a farmář Velký (velké pytle) – schematicky
def _farmari():
    def bag(cx, cy, rx, ry):
        return (f'<ellipse cx="{cx}" cy="{cy}" rx="{rx}" ry="{ry}" fill="#efe6d0" stroke="#000"/>'
                f'<rect x="{cx-4}" y="{cy-ry-6}" width="8" height="8" fill="#efe6d0" stroke="#000"/>')
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 190" font-family="sans-serif">']
    s.append('<text x="145" y="20" font-size="13" text-anchor="middle" font-weight="bold">Farmář Malý</text>')
    s.append('<rect x="20" y="30" width="255" height="125" fill="none" stroke="#000"/>')
    s.append(bag(58, 112, 15, 22)); s.append(bag(96, 112, 15, 22)); s.append(bag(134, 112, 15, 22))
    s.append('<text x="170" y="118" font-size="18">…</text>')
    s.append('<polygon points="205,145 255,145 230,98" fill="#9e9e9e" stroke="#000"/>')
    s.append('<text x="230" y="170" font-size="11" text-anchor="middle">zbývá 150 kg</text>')
    s.append('<text x="425" y="20" font-size="13" text-anchor="middle" font-weight="bold">Farmář Velký</text>')
    s.append('<rect x="305" y="30" width="245" height="125" fill="none" stroke="#000"/>')
    s.append(bag(345, 120, 24, 33)); s.append(bag(400, 120, 24, 33))
    s.append('<text x="443" y="126" font-size="18">…</text>')
    s.append(bag(515, 120, 24, 33))
    s.append('</svg>')
    return "".join(s)
SVG3 = _farmari()

# úloha 5: 10 světlých kuliček (horní řada) a větší počet tmavých kuliček
def _kulicky():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 180" font-family="sans-serif">']
    r = 15
    for i in range(10):
        s.append(f'<circle cx="{32+i*50}" cy="35" r="{r}" fill="#d6d6d6" stroke="#000"/>')
    for i in range(10):
        s.append(f'<circle cx="{32+i*50}" cy="90" r="{r}" fill="#4a4a4a" stroke="#000"/>')
    for i in range(6):
        s.append(f'<circle cx="{32+i*50}" cy="145" r="{r}" fill="#4a4a4a" stroke="#000"/>')
    s.append('<text x="330" y="153" font-size="22">…</text>')
    s.append('</svg>')
    return "".join(s)
SVG5 = _kulicky()

# úloha 7 (7.1 i 7.2): přímky b, c, d a bod R mimo ně (b a c se protínají ve vrcholu A)
SVG7 = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif">'
        '<line x1="50" y1="60" x2="470" y2="60" stroke="#000" stroke-width="2"/>'
        '<text x="58" y="80" font-size="16" font-style="italic">d</text>'
        '<line x1="60" y1="205" x2="455" y2="150" stroke="#000" stroke-width="2"/>'
        '<text x="462" y="150" font-size="16" font-style="italic">c</text>'
        '<line x1="70" y1="165" x2="425" y2="300" stroke="#000" stroke-width="2"/>'
        '<text x="432" y="305" font-size="16" font-style="italic">b</text>'
        '<text x="248" y="262" font-size="18">×</text>'
        '<text x="250" y="282" font-size="15" font-style="italic">R</text>'
        '</svg>')

# úloha 8: čtvercová síť 8x7; bílý čtyřúhelník A a bílý trojúhelník B (vrcholy v mřížových bodech)
def _sit8():
    cell = 32; ox = 40; oy = 16; W = 8; H = 7
    def px(c): return ox + c * cell
    def py(r): return oy + r * cell
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox+W*cell+120} {oy+H*cell+45}" font-family="sans-serif">']
    s.append(f'<rect x="{px(7)}" y="{py(6)}" width="{cell}" height="{cell}" fill="#d9d9d9"/>')
    for i in range(W + 1):
        s.append(f'<line x1="{px(i)}" y1="{py(0)}" x2="{px(i)}" y2="{py(H)}" stroke="#555" stroke-width="1"/>')
    for j in range(H + 1):
        s.append(f'<line x1="{px(0)}" y1="{py(j)}" x2="{px(W)}" y2="{py(j)}" stroke="#555" stroke-width="1"/>')
    s.append(f'<polygon points="{px(0)},{py(1)} {px(5)},{py(1)} {px(2)},{py(5)} {px(1)},{py(5)}" fill="#fff" stroke="#000" stroke-width="2.5"/>')
    s.append(f'<polygon points="{px(6)},{py(1)} {px(8)},{py(1)} {px(5)},{py(5)}" fill="#fff" stroke="#000" stroke-width="2.5"/>')
    s.append(f'<text x="{px(2)-6}" y="{py(3)}" font-size="18" font-weight="bold">A</text>')
    s.append(f'<text x="{px(6)+8}" y="{py(3)-4}" font-size="18" font-weight="bold">B</text>')
    s.append(f'<text x="{px(8)+8}" y="{py(6)+20}" font-size="12">1 cm²</text>')
    s.append(f'<text x="{px(0)-34}" y="{py(7)-6}" font-size="12">1 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _sit8()

# úlohy 11 a 12: sloupcový graf naspořené částky třídy (za 1.–5. měsíc; za 6. měsíc otazník)
def _graf():
    x0 = 64; y0 = 300; top = 30; scale = 260.0 / 2400.0
    vals = [100, 300, 600, 1000, 1500]
    labels = ['za 1 měsíc', 'za 2 měsíce', 'za 3 měsíce', 'za 4 měsíce', 'za 5 měsíců', 'za 6 měsíců']
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 350" font-family="sans-serif">']
    s.append('<text x="290" y="18" font-size="13" text-anchor="middle" font-weight="bold">Naspořená částka třídy 5. A</text>')
    s.append(f'<line x1="{x0}" y1="{top}" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="530" y2="{y0}" stroke="#000"/>')
    for v in range(0, 2401, 200):
        y = y0 - v * scale
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="9" text-anchor="end">{v}</text>')
    s.append('<text x="18" y="170" font-size="11" text-anchor="middle" transform="rotate(-90 18 170)">Počet korun</text>')
    bw = 44
    for i in range(6):
        bx = x0 + 24 + i * 76; cx = bx + bw / 2
        if i < 5:
            h = vals[i] * scale
            s.append(f'<rect x="{bx}" y="{y0-h}" width="{bw}" height="{h}" fill="#a9a9a9" stroke="#000"/>')
        else:
            s.append(f'<text x="{cx}" y="{y0-120}" font-size="26" text-anchor="middle" font-weight="bold">?</text>')
        s.append(f'<text x="{cx}" y="{y0+16}" font-size="9" text-anchor="middle">{labels[i]}</text>')
    s.append('</svg>')
    return "".join(s)
SVG_GRAF = _graf()

# úloha 13: krychle 5x5x5 a těleso po odebrání krychliček z rohů a středů stěn (schematicky)
def _krychle():
    def cube(ox, removed):
        cell = 26; n = 5; W = n * cell; fx = ox; fy = 80
        g = [f'<polygon points="{fx},{fy} {fx+40},{fy-40} {fx+W+40},{fy-40} {fx+W},{fy}" fill="#bdbdbd" stroke="#000"/>',
             f'<polygon points="{fx+W},{fy} {fx+W+40},{fy-40} {fx+W+40},{fy+W-40} {fx+W},{fy+W}" fill="#9e9e9e" stroke="#000"/>',
             f'<rect x="{fx}" y="{fy}" width="{W}" height="{W}" fill="#d0d0d0" stroke="#000"/>']
        for (cc, rr) in removed:
            g.append(f'<rect x="{fx+cc*cell}" y="{fy+rr*cell}" width="{cell}" height="{cell}" fill="#fff" stroke="#000"/>')
        for i in range(n + 1):
            g.append(f'<line x1="{fx+i*cell}" y1="{fy}" x2="{fx+i*cell}" y2="{fy+W}" stroke="#000" stroke-width="0.7"/>')
            g.append(f'<line x1="{fx}" y1="{fy+i*cell}" x2="{fx+W}" y2="{fy+i*cell}" stroke="#000" stroke-width="0.7"/>')
        return "".join(g)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 285" font-family="sans-serif">']
    s.append(cube(40, []))
    s.append(cube(330, [(0, 0), (4, 0), (0, 4), (4, 4), (2, 2)]))
    s.append('<text x="105" y="255" font-size="12" text-anchor="middle">krychle 5×5×5</text>')
    s.append('<text x="395" y="255" font-size="12" text-anchor="middle">těleso po odebrání</text>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _krychle()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 se v taxonomii nepoužívá

PROBLEMS = [
    {'name': 'CERMAT M5A 2018 – úloha 1.1',
     'zad': ['Vypočtěte: $4\\cdot 16-16:2+0\\cdot 125-25=$'], 'opts': None, 'ln': 2,
     'sol': ['Podle pořadí operací: $64-8+0-25=31$.'], 'ans': '$31$',
     'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2018 – úloha 1.2',
     'zad': ['Vypočtěte: $100-[35-(15+11)]-35=$'], 'opts': None, 'ln': 2,
     'sol': ['$100-[35-26]-35=100-9-35=56$.'], 'ans': '$56$',
     'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2018 – úloha 2',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost.',
             '2.1  $2$ m $12$ cm $=85$ cm $+\\ \\square\\ $ cm',
             '2.2  $26$ km $-\\ \\square\\ \\cdot 400$ m $=9$ km $200$ m',
             '2.3  $\\square\\ $ minut $+\\,300$ sekund $=1$ hodina'],
     'opts': None, 'ln': 3,
     'sol': ['2.1 $2$ m $12$ cm $=212$ cm; do rámečku patří $212-85=127$.',
             '2.2 $26$ km $=26\\,000$ m a $9$ km $200$ m $=9\\,200$ m; $(26\\,000-9\\,200):400=16\\,800:400=42$.',
             '2.3 $1$ hodina $=3\\,600$ s, $300$ s $=5$ min; do rámečku patří $60-5=55$.'],
     'ans': '2.1: $127$; 2.2: $42$; 2.3: $55$',
     'pts': 3, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2018 – úloha 3',
     'zad': ['Farmář Malý svou úrodu pšenice plní do malých pytlů. Do každého pytle se vejde $30$ kg pšenice. Farmáři zbývá naplnit do pytlů ještě $150$ kg pšenice, což je jedna čtvrtina jeho úrody pšenice. Farmář Velký má o polovinu větší úrodu pšenice než farmář Malý. Celou svou úrodu pšenice již uskladnil ve velkých pytlích, do každého nasypal $50$ kg pšenice.',
             '3.1 Vypočtěte, kolik malých pytlů pšenice již farmář Malý naplnil.',
             '3.2 Vypočtěte, v kolika velkých pytlích uskladnil celou svou úrodu pšenice farmář Velký.'],
     'opts': None, 'ln': 2, 'svg': SVG3, 'fn': 'farmari-pytle.svg',
     'alt': 'Schéma: farmář Malý s malými pytli a zbývajícími 150 kg pšenice, farmář Velký s velkými pytli.',
     'cap': 'schematický nákres',
     'sol': ['3.1 $150$ kg je čtvrtina úrody, celá úroda farmáře Malého je $4\\cdot 150=600$ kg. Již naplnil $600-150=450$ kg, tj. $450:30=15$ pytlů.',
             '3.2 Farmář Velký má o polovinu větší úrodu: $600+300=900$ kg; po $50$ kg to je $900:50=18$ pytlů.'],
     'ans': '3.1: $15$ pytlů; 3.2: $18$ pytlů',
     'pts': 4, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2018 – úloha 4',
     'zad': ['Aleniny, Bořkovy i Cyrilovy čerstvě nakrájené houby snížily svou hmotnost během první noci o třetinu a po týdnu už měly jen desetinu hmotnosti čerstvě nakrájených hub. Aleniny čerstvě nakrájené houby měly hmotnost $1\\,650$ gramů. Bořkovy nakrájené houby ztratily na váze během první noci $720$ gramů a Cyrilovy houby měly po týdnu hmotnost $210$ gramů.',
             'Vypočtěte, kolik gramů vážily po první noci',
             '4.1 Aleniny houby;',
             '4.2 Bořkovy houby;',
             '4.3 Cyrilovy houby.'],
     'opts': None, 'ln': 3,
     'sol': ['4.1 Během první noci ubude třetina, zůstanou dvě třetiny: $\\frac{2}{3}\\cdot 1\\,650=1\\,100$ g.',
             '4.2 Ztráta $720$ g je třetina čerstvé hmotnosti, čerstvé houby vážily $3\\cdot 720=2\\,160$ g; po první noci $2\\,160-720=1\\,440$ g.',
             '4.3 Po týdnu $210$ g je desetina čerstvé hmotnosti, čerstvé houby vážily $10\\cdot 210=2\\,100$ g; po první noci $\\frac{2}{3}\\cdot 2\\,100=1\\,400$ g.'],
     'ans': '4.1: $1\\,100$ g; 4.2: $1\\,440$ g; 4.3: $1\\,400$ g',
     'pts': 5, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2018 – úloha 5',
     'zad': ['Na stole bylo $10$ světlých kuliček a o něco více tmavých kuliček. Ema a Ivo si rozdělili všech $10$ světlých kuliček tak, že Ema si vzala o $4$ kuličky více než Ivo. Ema si pak vzala ještě několik tmavých kuliček a Ivo si jich vzal dvakrát více než Ema. Dohromady obě děti odebraly jen tolik tmavých kuliček, aby měly celkový počet kuliček stejný.',
             '5.1 Vypočtěte, kolik světlých kuliček si vzala Ema.',
             '5.2 Vypočtěte, kolik tmavých kuliček si vzal Ivo.',
             '5.3 Vypočtěte, kolik kuliček si celkem vzala Ema.'],
     'opts': None, 'ln': 2, 'svg': SVG5, 'fn': 'kulicky.svg',
     'alt': 'Deset světlých kuliček v horní řadě a větší počet tmavých kuliček pod nimi.',
     'cap': 'schematický nákres',
     'sol': ['5.1 Světlých je $10$: Ema $+$ Ivo $=10$ a Ema $=$ Ivo $+4$, tedy Ivo $=3$ a Ema $=7$.',
             '5.2 Ema si vzala $t$ tmavých, Ivo $2t$. Stejné celkové počty: $7+t=3+2t$, odtud $t=4$; Ivo má $2t=8$ tmavých.',
             '5.3 Ema si vzala $7$ světlých a $4$ tmavé, celkem $11$ kuliček.'],
     'ans': '5.1: $7$; 5.2: $8$; 5.3: $11$',
     'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2018 – úloha 6',
     'zad': ['Jana si nahrála na několik CD všechny lekce angličtiny, a to postupně od první lekce do poslední. Jednotlivá CD zaplňovala rovněž v pořadí od prvního do posledního CD. Na každém CD je stejný počet lekcí. Lekce číslo $49$ je v pořadí na pátém CD.',
             'Určete, kolik lekcí může být na jednom CD. Uveďte všechna možná řešení.'],
     'opts': None, 'ln': 2,
     'sol': ['Je-li na každém CD $n$ lekcí, obsahuje páté CD lekce $4n+1$ až $5n$. Musí platit $4n+1\\le 49\\le 5n$, tedy $n\\le 12$ a $n\\ge 9{,}8$. Vyhovují celá čísla $n=10$, $11$, $12$.'],
     'ans': '$10$, $11$ nebo $12$ lekcí',
     'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2018 – úloha 7.1 (konstrukce)',
     'zad': ['V rovině leží přímky $b$, $c$, $d$ a mimo ně bod $R$ (viz obrázek). V průsečíku přímek $b$, $c$ je vrchol $A$ obdélníku $ABCD$. Vrchol $B$ téhož obdélníku leží na přímce $b$, vrchol $C$ na přímce $c$ a vrchol $D$ na přímce $d$.',
             'Sestrojte chybějící vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'primky-bcd-R.svg',
     'alt': 'Přímky b, c, d a bod R mimo ně; přímky b a c se protínají v bodě A.',
     'cap': 'schematický nákres',
     'sol': ['Vrchol $A$ je průsečík přímek $b$ a $c$; strana $AB$ leží na přímce $b$. Bodem $A$ vedeme kolmici k přímce $b$ – její průsečík s přímkou $d$ je vrchol $D$. Bod $C$ je průsečík přímky $c$ s rovnoběžkou s přímkou $b$ vedenou bodem $D$; vrchol $B$ je pata kolmice z bodu $C$ na přímku $b$. Obdélník $ABCD$ – viz obrázek v klíči (KSR).'],
     'ans': 'Konstrukce obdélníku $ABCD$: $A=b\\cap c$, $B$ na přímce $b$, $C$ na přímce $c$, $D$ na přímce $d$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2018 – úloha 7.2 (konstrukce)',
     'zad': ['V rovině leží přímky $b$, $c$, $d$ a mimo ně bod $R$ (viz obrázek). V průsečíku přímek $b$, $c$ je bod $A$.',
             'Na přímce $c$ sestrojte bod $S$ tak, aby obrazec $ARS$ byl pravoúhlý trojúhelník. Bod $S$ označte a trojúhelník $ARS$ narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'primky-bcd-R.svg',
     'alt': 'Přímky b, c, d a bod R mimo ně; přímky b a c se protínají v bodě A.',
     'cap': 'schematický nákres',
     'sol': ['Vrchol $A$ je průsečík přímek $b$ a $c$; bod $S$ leží na přímce $c$. Pravý úhel při vrcholu $R$: bodem $R$ vedeme kolmici k přímce $AR$, její průsečík s přímkou $c$ je bod $S_1$. Pravý úhel při vrcholu $S$: nad úsečkou $AR$ jako průměrem sestrojíme Thaletovu kružnici, její druhý průsečík s přímkou $c$ (kromě bodu $A$) je bod $S_2$. Úloha má dvě řešení – viz obrázek v klíči (KSR).'],
     'ans': 'Dvě řešení – body $S_1$, $S_2$ na přímce $c$ (pravý úhel při $R$: $S_1$ na kolmici k $AR$; pravý úhel při $S$: $S_2$ na Thaletově kružnici nad $AR$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2018 – úloha 8',
     'zad': ['Čtvercová síť je tvořena čtverečky s délkou strany $1$ cm a obsahem $1$ cm$^2$. Ve čtvercové síti jsou zakresleny bílé obrazce $A$, $B$ s vrcholy v mřížových bodech (viz obrázek).',
             'Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
             '8.1 Obsah obrazce $A$ je $10$ cm$^2$.',
             '8.2 Obsah obrazce $B$ je třikrát menší než obsah obrazce $A$.',
             '8.3 Obvod obrazce $B$ je o $4$ cm menší než obvod obrazce $A$.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'sit-obrazce-AB.svg',
     'alt': 'Čtvercová síť 8 krát 7; vlevo bílý čtyřúhelník A, vpravo bílý trojúhelník B, vrcholy v mřížových bodech.',
     'cap': 'schematický nákres',
     'sol': ['8.1 Obrazec $A$ je čtyřúhelník o obsahu $12$ cm$^2$ (nikoli $10$ cm$^2$). Tvrzení je nepravdivé (N).',
             '8.2 Obrazec $B$ je trojúhelník o obsahu $\\frac{1}{2}\\cdot 2\\cdot 4=4$ cm$^2$; $12:3=4$, obsah $B$ je třikrát menší než obsah $A$. Pravdivé (A).',
             '8.3 Obvod $A$ je $5+5+1+\\sqrt{17}=11+\\sqrt{17}$ cm, obvod $B$ je $2+5+\\sqrt{17}=7+\\sqrt{17}$ cm; rozdíl je právě $4$ cm. Pravdivé (A).'],
     'ans': '8.1: N (nepravdivé); 8.2: A (pravdivé); 8.3: A (pravdivé)',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2018 – úloha 9',
     'zad': ['Chlapci a dívky ve třídě vytvořili beze zbytku pětice, v nichž jsou $2$ dívky a $3$ chlapci. K vytvoření smíšených párů ($1$ chlapec a $1$ dívka) chybí $6$ dívek.',
             'Kolik dívek je ve třídě?'],
     'opts': ['A) méně než 10', 'B) 10', 'C) 11', 'D) více než 11', 'E) Nelze jednoznačně určit.'],
     'ln': 0,
     'sol': ['Je-li pětic $n$, je ve třídě $2n$ dívek a $3n$ chlapců. Pro smíšené páry by muselo být dívek stejně jako chlapců; chybí $3n-2n=n$ dívek, tedy $n=6$. Dívek je $2\\cdot 6=12$, což je více než $11$.'],
     'ans': 'D) více než 11',
     'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2018 – úloha 10',
     'zad': ['Koberec je ručně vázaný. Každý měsíc se zhotovil stejný díl koberce. Vázání pětiny koberce trvalo půl roku.',
             'Kolik měsíců trvalo vázání poloviny koberce?'],
     'opts': ['A) méně než 14 měsíců', 'B) 14 měsíců', 'C) 15 měsíců', 'D) 16 měsíců', 'E) jiný počet měsíců'],
     'ln': 0,
     'sol': ['Pětina koberce trvala půl roku, tj. $6$ měsíců; měsíčně se tak zhotoví $\\frac{1}{5}:6=\\frac{1}{30}$ koberce. Polovina koberce trvá $\\frac{1}{2}:\\frac{1}{30}=15$ měsíců.'],
     'ans': 'C) 15 měsíců',
     'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2018 – úloha 11',
     'zad': ['Třída 5. A s $20$ žáky spořila půl roku na podporu adoptovaného hrocha. Všichni žáci přispívali rovným dílem, ale každý měsíc vyšší částkou. Příspěvek žáka se každý měsíc zvyšoval o stejnou částku. Graf udává, jak v průběhu pěti měsíců narůstala naspořená částka celé třídy 5. A. Např. za $3$ měsíce (tj. za 1., 2. a 3. měsíc) třída naspořila celkem $600$ korun.',
             'O kolik korun se každý měsíc zvýšil příspěvek jednoho žáka třídy 5. A?'],
     'opts': ['A) o 5 korun', 'B) o 10 korun', 'C) o 15 korun', 'D) o 20 korun', 'E) o více než 20 korun'],
     'ln': 0, 'svg': SVG_GRAF, 'fn': 'graf-sporeni.svg',
     'alt': 'Sloupcový graf naspořené částky třídy: za 1 až 5 měsíců 100, 300, 600, 1000 a 1500 korun; za 6 měsíců otazník.',
     'cap': 'Naspořená částka třídy 5. A (v korunách)',
     'sol': ['Naspořené částky celé třídy narůstají za jednotlivé měsíce o $100$, $200$, $300$, $400$ a $500$ korun (rozdíly sousedních hodnot $100$, $300$, $600$, $1\\,000$, $1\\,500$). Každý měsíc přibude o $100$ korun více než minulý měsíc, na jednoho z $20$ žáků tedy $100:20=5$ korun.'],
     'ans': 'A) o 5 korun',
     'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2018 – úloha 12',
     'zad': ['Třída 5. A s $20$ žáky spořila půl roku na podporu adoptovaného hrocha. Všichni žáci přispívali rovným dílem, ale každý měsíc vyšší částkou o stejnou částku. Graf udává, jak v průběhu pěti měsíců narůstala naspořená částka celé třídy 5. A (za 1. až 5. měsíc postupně $100$, $300$, $600$, $1\\,000$ a $1\\,500$ korun).',
             'Kolik korun třída 5. A uspořila za půl roku (celkem za 6 měsíců)?'],
     'opts': ['A) méně než 2 100 korun', 'B) 2 100 korun', 'C) 2 200 korun', 'D) 2 300 korun', 'E) více než 2 300 korun'],
     'ln': 0, 'svg': SVG_GRAF, 'fn': 'graf-sporeni.svg',
     'alt': 'Sloupcový graf naspořené částky třídy: za 1 až 5 měsíců 100, 300, 600, 1000 a 1500 korun; za 6 měsíců otazník.',
     'cap': 'Naspořená částka třídy 5. A (v korunách)',
     'sol': ['Měsíční příspěvky celé třídy jsou $100$, $200$, $300$, $400$, $500$ a $600$ korun. Za šestý měsíc přibude $600$ korun, celkem za půl roku $1\\,500+600=2\\,100$ korun.'],
     'ans': 'B) 2 100 korun',
     'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2018 – úloha 13',
     'zad': ['Krychle vlevo byla slepena ze $125$ bílých krychliček, má tedy v každé řadě $5$ krychliček. Krychle je na povrchu obarvena na šedo. Když se z každého rohu a ze středu každé stěny této krychle odebere jedna krychlička, vznikne těleso vpravo.',
             'Přiřaďte ke každé otázce (13.1–13.3) odpovídající odpověď (A–F).',
             '13.1 Kolik krychliček v tělese vpravo má právě jednu stěnu obarvenou na šedo?',
             '13.2 Kolik krychliček v tělese vpravo má právě dvě stěny obarvené na šedo?',
             '13.3 Kolik krychliček v tělese vpravo nemá obarvenou žádnou stěnu na šedo?'],
     'opts': ['A) 27', 'B) 30', 'C) 36', 'D) 41', 'E) 48', 'F) jiný počet krychliček'],
     'ln': 0, 'svg': SVG13, 'fn': 'krychle-teleso.svg',
     'alt': 'Vlevo krychle 5 krát 5 krát 5, vpravo stejná krychle s odebranými krychličkami z rohů a středů stěn.',
     'cap': 'schematický nákres',
     'sol': ['V krychli $5\\times5\\times5$ mají krychličky obarveno: $8$ rohových po $3$ stěnách, $36$ hranových (mimo rohy) po $2$ stěnách, $54$ stěnových po $1$ stěně a $27$ vnitřních žádnou. Odebere se $8$ rohových a $6$ středů stěn (stěnové, po $1$ obarvené stěně); nově vzniklé plochy nejsou obarvené.',
             '13.1 Právě jednu obarvenou stěnu má $54-6=48$ krychliček → E.',
             '13.2 Právě dvě obarvené stěny má $36$ krychliček (žádná se neodebrala) → C.',
             '13.3 Žádnou obarvenou stěnu má $27$ vnitřních krychliček → A.'],
     'ans': '13.1: E (48); 13.2: C (36); 13.3: A (27)',
     'pts': 5, 'mins': 6, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2018 – úloha 14',
     'zad': ['Na obrazovce počítače jsou dvě čísla – jedno v modrém a druhé v červeném poli. Na počátku jsou obě čísla stejná. Při každém pípnutí se obě čísla zvětší – v modrém poli o $1$ a v červeném o $3$. V jednu chvíli se na obrazovce objeví v modrém poli číslo $49$ a současně v červeném poli číslo $129$.',
             '14.1 Určete, jaké číslo je v modrém poli na počátku.',
             '14.2 Určete číslo v modrém poli v okamžiku, kdy je o $30$ menší než číslo v červeném poli.',
             '14.3 Určete číslo v červeném poli v okamžiku, kdy je součet čísel v obou polích $2\\,018$.'],
     'opts': None, 'ln': 3,
     'sol': ['Po $n$ pípnutích je v modrém poli $s+n$ a v červeném $s+3n$, kde $s$ je počáteční číslo. Z $s+n=49$ a $s+3n=129$ plyne $2n=80$, tedy $n=40$ a $s=9$.',
             '14.1 Na počátku je v modrém poli číslo $s=9$.',
             '14.2 Rozdíl červené $-$ modré je $2n=30$, tedy $n=15$; v modrém poli je $9+15=24$.',
             '14.3 Součet je $(s+n)+(s+3n)=2s+4n=18+4n=2\\,018$, odtud $n=500$; v červeném poli je $9+3\\cdot 500=1\\,509$.'],
     'ans': '14.1: $9$; 14.2: $24$; 14.3: $1\\,509$',
     'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PAD18C0T01'
    gen.YEAR = 2018

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set(); total_pts = 0
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        total_pts += p['pts']
        if 'M5A' not in p['name']: errors.append('Název bez M5A: ' + p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if total_pts != 50: errors.append(f'Součet bodů = {total_pts}, má být 50')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, součet bodů', total_pts)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2018')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
