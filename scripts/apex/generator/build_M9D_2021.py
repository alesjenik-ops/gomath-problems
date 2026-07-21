# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9D 2021 (druhý náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9D_2021_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2021, druhý náhradní termín (M9D)"
CCODE = "M9PDD21C0T04"
YR = 2021
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2021 M9D · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte: $\dfrac{0{,}25}{0{,}025}:0{,}2=$"],
    solp=[r"$\frac{0{,}25}{0{,}025}=10$, potom $10:0{,}2=50$."],
    ans=r"$50$",
    codes=["zs2", "r9", "aritmetika", "cisla", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 2", pts=2, mins=4, diff="2",
    zad=[r"2.1 Řeka Labe protéká pouze dvěma státy a délka celého jejího toku je $1\,094\ \mathrm{km}$. V Německu je tok Labe o $352\ \mathrm{km}$ delší než v České republice. Vypočtěte délku toku Labe v Německu.",
         r"2.2 Zahrada měla výměru $1\,799\ \mathrm{m}^2$. Při stavbě nového plotu se posunutím sloupků výměra zahrady zvětšila o $250\ \mathrm{dm}^2$. Vypočtěte v $\mathrm{m}^2$ novou výměru zahrady."],
    solp=[r"2.1: Délku v ČR označme $c$. Pak $c+(c+352)=1\,094$, tedy $2c=742$, $c=371\ \mathrm{km}$; v Německu $371+352=723\ \mathrm{km}$.",
          r"2.2: $250\ \mathrm{dm}^2=2{,}5\ \mathrm{m}^2$; nová výměra $1\,799+2{,}5=1\,801{,}5\ \mathrm{m}^2$."],
    ans=r"2.1: $723\ \mathrm{km}$; 2.2: $1\,801{,}5\ \mathrm{m}^2$",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\left(\dfrac{5}{8}-\dfrac{5}{12}\right)\cdot4-2\cdot\left(\dfrac{3}{4}-\dfrac{2}{3}\right)=$",
         r"3.2 \quad $\dfrac{\left(\dfrac{27}{10}\cdot\dfrac{5}{9}-4\right):3}{5}=$"],
    solp=[r"3.1: $\frac{5}{8}-\frac{5}{12}=\frac{15-10}{24}=\frac{5}{24}$; $\frac{5}{24}\cdot4=\frac{5}{6}$; $\frac{3}{4}-\frac{2}{3}=\frac{1}{12}$; $2\cdot\frac{1}{12}=\frac{1}{6}$; $\frac{5}{6}-\frac{1}{6}=\frac{4}{6}=\frac{2}{3}$.",
          r"3.2: $\frac{27}{10}\cdot\frac{5}{9}=\frac{135}{90}=\frac{3}{2}$; $\frac{3}{2}-4=-\frac{5}{2}$; $-\frac{5}{2}:3=-\frac{5}{6}$; $-\frac{5}{6}:5=-\frac{1}{6}$."],
    ans=r"3.1: $\frac{2}{3}$; 3.2: $-\frac{1}{6}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 4", pts=4, mins=7, diff="3",
    zad=[r"4.1 Z daného výrazu vytkněte $(-3x)$: $\quad -6x^2-3x+9xy=$",
         r"4.2 Doplňte do rámečků chybějící čísla tak, aby platila rovnost (uveďte všechna tři čísla): $\left(\square\cdot a-\square\cdot b\right)^2=\square\cdot a^2-56ab+(4\cdot b)^2$",
         r"4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(5-y)(5+y)+3\cdot(y^2-10)-(2y-3)\cdot y=$"],
    solp=[r"4.1: $-6x^2-3x+9xy=(-3x)\cdot(2x+1-3y)$.",
          r"4.2: $(p\cdot a-q\cdot b)^2=p^2a^2-2pq\,ab+q^2b^2$. Z $(4b)^2=16b^2$ je $q=4$; z $-2pq=-56$ je $p=7$; koeficient u $a^2$ je $p^2=49$. Čísla: $7$; $4$; $49$.",
          r"4.3: $25-y^2+3y^2-30-(2y^2-3y)=25-y^2+3y^2-30-2y^2+3y=3y-5$."],
    ans=r"4.1: $(-3x)(2x+1-3y)$; 4.2: $7$; $4$; $49$; 4.3: $3y-5$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $2{,}5\cdot(2-3x)=\dfrac{5x+10}{2}$",
         r"5.2 \quad $\dfrac{5}{3}\cdot(y-1)+\dfrac{5}{6}\cdot(11-2y)-\dfrac{3}{4}\cdot y=0$"],
    solp=[r"5.1: $5-7{,}5x=\frac{5x+10}{2}$; vynásobením dvěma $10-15x=5x+10$, tedy $-20x=0$, $x=0$.",
          r"5.2: vynásobíme $12$: $20(y-1)+10(11-2y)-9y=0$; $20y-20+110-20y-9y=0$; $-9y+90=0$, $y=10$."],
    ans=r"5.1: $x=0$; 5.2: $y=10$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 6", pts=3, mins=5, diff="3",
    zad=[r"Na trati závodila 3 autíčka. První autíčko ujelo závod za $1$ minutu a $42$ sekund. Druhé autíčko ujelo závod za dobu o třetinu kratší než první autíčko. První autíčko ujelo závod za dobu o třetinu kratší než třetí autíčko.",
         r"Vypočtěte v minutách a sekundách, za jakou dobu ujelo závod",
         r"6.1 druhé autíčko,",
         r"6.2 třetí autíčko."],
    solp=[r"První autíčko: $1\ \mathrm{min}\ 42\ \mathrm{s}=102\ \mathrm{s}$.",
          r"6.1: druhé $=102\cdot\frac{2}{3}=68\ \mathrm{s}=1\ \mathrm{min}\ 8\ \mathrm{s}$.",
          r"6.2: první je o třetinu kratší než třetí, tedy první $=\frac{2}{3}\cdot$třetí, třetí $=102\cdot\frac{3}{2}=153\ \mathrm{s}=2\ \mathrm{min}\ 33\ \mathrm{s}$."],
    ans=r"6.1: $1$ minuta $8$ sekund; 6.2: $2$ minuty $33$ sekund",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 7", pts=3, mins=6, diff="4",
    zad=[r"V bílé krabičce jsou jen bílé kuličky, v zelené krabičce jen zelené a v modré krabičce jen modré kuličky. Bílých kuliček je $12$ a modrých $60$.",
         r"Do bílé krabičky přendáme ze zelené a modré krabičky tolik kuliček, aby byl ve všech třech krabičkách stejný počet kuliček. Ze zelené krabičky tak musíme přendat o $9$ kuliček více než z modré krabičky.",
         r"7.1 Určete počet všech zelených kuliček.",
         r"7.2 Vypočtěte, kolik kuliček zůstane v modré krabičce.",
         r"7.3 Vypočtěte, kolik zelených kuliček přendáme do bílé krabičky."],
    solp=[r"Počet zelených označme $Z$. Celkem je $12+60+Z=72+Z$ kuliček, po vyrovnání je v každé krabičce $\frac{72+Z}{3}$.",
          r"Z modré přendáme $60-\frac{72+Z}{3}$, ze zelené $Z-\frac{72+Z}{3}$; jejich rozdíl je $\left(Z-\frac{72+Z}{3}\right)-\left(60-\frac{72+Z}{3}\right)=Z-60=9$, tedy $Z=69$.",
          r"7.1: zelených je $69$.",
          r"7.2: v každé krabičce nakonec $\frac{72+69}{3}=47$ kuliček, v modré tedy zůstane $47$.",
          r"7.3: ze zelené přendáme $69-47=22$ kuliček."],
    ans=r"7.1: $69$ zelených kuliček; 7.2: $47$ kuliček; 7.3: $22$ zelených kuliček",
    codes=["zs2", "r9", "rovnice", "aritmetika", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 8", pts=3, mins=5, diff="3",
    zad=[r"V pravoúhlém lichoběžníku ABCD se základnou AB platí: $|AB|=15\ \mathrm{cm}$, $|CD|=10\ \mathrm{cm}$, $|AD|=12\ \mathrm{cm}$, $|\angle BAD|=90^\circ$ (viz obrázek).",
         r"Vypočtěte",
         r"8.1 v $\mathrm{cm}^2$ obsah lichoběžníku ABCD,",
         r"8.2 v cm obvod lichoběžníku ABCD."],
    solp=[r"8.1: rovnoběžné strany $|AB|=15$ a $|CD|=10$, výška $|AD|=12$; obsah $S=\frac{15+10}{2}\cdot12=12{,}5\cdot12=150\ \mathrm{cm}^2$.",
          r"8.2: rameno BC je přeponou pravoúhlého trojúhelníku s odvěsnami $15-10=5$ a $12$: $|BC|=\sqrt{5^2+12^2}=\sqrt{169}=13\ \mathrm{cm}$; obvod $=15+10+12+13=50\ \mathrm{cm}$."],
    ans=r"8.1: $150\ \mathrm{cm}^2$; 8.2: $50\ \mathrm{cm}$",
    svg=fig(4, (372, 66, 520, 192)), fn=FN,
    alt="Pravoúhlý lichoběžník ABCD se základnou AB = 15 cm, kratší rovnoběžnou stranou CD = 10 cm, ramenem AD = 12 cm kolmým k AB (pravý úhel při vrcholu A).", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 9", pts=3, mins=7, diff="4",
    zad=[r"V rovině leží úsečka LM a bod U (viz obrázek).",
         r"Úsečka LM je strana rovnoramenného trojúhelníku KLM. V tomto trojúhelníku je každé z obou ramen dvakrát delší než základna. Bod U leží uvnitř trojúhelníku KLM.",
         r"Sestrojte vrchol K trojúhelníku KLM, označte jej písmenem a trojúhelník narýsujte. Najděte všechna $3$ řešení."],
    solp=[r"Úsečka LM může být buď základnou, nebo ramenem trojúhelníku (rameno $=2\times$ základna).",
          r"a) LM je základna: pak $|KL|=|KM|=2\,|LM|$; vrchol K leží na ose úsečky LM a na kružnicích $k(L;2|LM|)$, $k(M;2|LM|)$ — dá řešení, u něhož U leží uvnitř.",
          r"b) LM je rameno: apexem je L, nebo M. Je-li apexem L, je $|LK|=|LM|$ a základna $|MK|=\tfrac{1}{2}|LM|$; symetricky pro apex M. Vrchol K sestrojíme jako průsečík odpovídajících kružnic.",
          r"Celkem podmínce „U uvnitř trojúhelníku“ vyhovují tři řešení (tři trojúhelníky KLM). Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce tří rovnoramenných trojúhelníků KLM (rameno $=2\times$ základna, bod U uvnitř); tři řešení.",
    svg=fig(5, (355, 115, 470, 300)), fn=FN,
    alt="V rovině leží úsečka LM (M vlevo nahoře, L vpravo dole) a bod U ležící vlevo od úsečky.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 10", pts=3, mins=7, diff="5",
    zad=[r"V rovině leží body A, S. Bod A je vrchol obdélníku ABCD a bod S je střed tohoto obdélníku.",
         r"Vrchol C má od vrcholu D i od středu S stejnou vzdálenost, tedy $|CD|=|CS|$.",
         r"Sestrojte vrcholy B, C, D obdélníku ABCD, označte je písmeny a obdélník narýsujte. Najděte všechna řešení."],
    solp=[r"Střed S je střed úhlopříčky AC, proto vrchol C je obraz bodu A ve středové souměrnosti se středem S (tj. C je souměrný s A podle S) — je určen jednoznačně.",
          r"V obdélníku platí $|SA|=|SB|=|SC|=|SD|=r$ (polovina úhlopříčky). Z podmínky $|CD|=|CS|=r$ sestrojíme vrchol D jako průsečík kružnic $k(S;r)$ a $k(C;r)$ — dva průsečíky dávají dvě řešení. Vrchol B je obraz bodu D podle S.",
          r"Vzniká obdélník se stranami $r$ a $r\sqrt{3}$; úloha má dvě řešení. Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce dvou obdélníků ABCD (C souměrný s A podle S, $|CD|=|CS|$); dvě řešení.",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 11", pts=4, mins=6, diff="4",
    zad=[r"Číslo $A$ může být kterékoli celé číslo větší než $9$. Číslo $B$ je o $3$ větší než číslo $A$. Číslo $C$ je dvojnásobkem čísla $B$.",
         r"Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).",
         r"11.1 Číslo, které je výsledkem výpočtu $A+B+C$, může být sudé.",
         r"11.2 Číslo, které je výsledkem výpočtu $A\cdot B+C$, musí být vždy sudé.",
         r"11.3 Číslo, které je výsledkem výpočtu $A+B-C$, musí být vždy záporné."],
    solp=[r"Platí $B=A+3$ a $C=2B=2A+6$.",
          r"11.1: $A+B+C=A+(A+3)+(2A+6)=4A+9$ — vždy liché číslo, nikdy sudé — \textbf{N}.",
          r"11.2: $A\cdot B+C=A(A+3)+2A+6=A^2+5A+6=(A+2)(A+3)$ — součin dvou po sobě jdoucích celých čísel, tedy vždy sudé — \textbf{A}.",
          r"11.3: $A+B-C=A+(A+3)-(2A+6)=-3$ — vždy záporné — \textbf{A}."],
    ans=r"11.1: N; 11.2: A; 11.3: A",
    codes=["zs2", "r9", "algebra", "vyrazy", "cisla", "uvazovani", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Na obrázku jsou čtyři přímky; shodně označené přímky (dvojitou čárkou) jsou rovnoběžné. Nejvýše položená přímka procházející vrcholem úhlu $62^\circ$ žádné označení nemá.",
         r"Jaká je velikost úhlu $\varphi$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Obě „klesající“ přímky jsou rovnoběžné, stejně tak prostřední a spodní „stoupající“ přímka. Nejvýše položená přímka (u úhlu $62^\circ$) rovnoběžná není, proto je údaj $62^\circ$ pro výpočet nadbytečný.",
          r"Úhel $\varphi$ a úhel $66^\circ$ jsou úhly u dvou rovnoběžných (klesajících) přímek proťatých prostřední příčkou — jsou to přilehlé (přísluš­né doplňkové) úhly, jejichž součet je $180^\circ$: $\varphi=180^\circ-66^\circ=114^\circ$."],
    ans=r"D) $114^\circ$",
    opts=[r"A) $128^\circ$", r"B) $126^\circ$", r"C) $118^\circ$", r"D) $114^\circ$", r"E) jiná velikost"],
    svg=fig(7, (62, 62, 285, 172)), fn=FN,
    alt="Dvě rovnoběžné klesající přímky proťaté třemi téměř vodorovnými přímkami; u průsečíků jsou vyznačeny úhly 62°, 66° a hledaný úhel φ. Dvojité čárky značí rovnoběžnost.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "uvazovani"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 13", pts=2, mins=5, diff="4",
    zad=[r"Všechny díly stavebnice jsou pravidelné čtyřboké hranoly s rozměry $1\ \mathrm{cm}\times1\ \mathrm{cm}\times2\ \mathrm{cm}$. Stojící díl má dole čtvercovou stěnu (stojí na výšku $2\ \mathrm{cm}$), ležící díl leží (výška $1\ \mathrm{cm}$).",
         r"Stavba má podobu tří spojených kvádrů (rozměry šířka $\times$ hloubka $\times$ výška v cm): levý $3\times4\times6$, prostřední $3\times4\times7$, pravý $3\times4\times5$. Díly jsou naskládány bez mezer tak, aby stavba obsahovala co největší počet stojících dílů.",
         r"Kolik ležících dílů stavba obsahuje?"],
    solp=[r"Každý sloupec $1\times1$ o sudé výšce lze zaplnit jen stojícími díly; při liché výšce zbude navrchu vrstva vysoká $1\ \mathrm{cm}$, kterou musí vyplnit ležící díly.",
          r"Levý kvádr má výšku $6$ (sudou) — jen stojící díly. Prostřední ($7$) a pravý ($5$) mají lichou výšku, proto má každý navrchu vrstvu $3\times4=12$ jednotkových krychliček.",
          r"Celkem je navrchu $12+12=24$ jednotkových krychliček; jeden ležící díl pokryje $2$ z nich, takže ležících dílů je $24:2=12$."],
    ans=r"C) $12$",
    opts=[r"A) $0$", r"B) $6$", r"C) $12$", r"D) $18$", r"E) $24$"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "uvazovani", "vyber", "slovni"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 14", pts=2, mins=3, diff="3",
    zad=[r"Ve třídě je o polovinu více chlapců než děvčat.",
         r"Které z následujících tvrzení je pravdivé?"],
    solp=[r"Počet děvčat označme $d$, chlapců je $1{,}5d$, žáků celkem $2{,}5d$.",
          r"A) chlapci tvoří $\frac{1{,}5d}{2{,}5d}=\frac{3}{5}$ žáků — \textbf{pravda}.",
          r"B) děvčata tvoří $\frac{d}{2{,}5d}=40\ \%$ (ne $33\ \%$); C) celkem je $2{,}5\times$ počet děvčat (ne trojnásobek); D) děvčat je o třetinu méně než chlapců (ne o polovinu). Ostatní tvrzení tedy neplatí."],
    ans=r"A) Chlapci tvoří tři pětiny žáků třídy.",
    opts=[r"A) Chlapci tvoří tři pětiny žáků třídy.", r"B) Děvčata tvoří $33\ \%$ žáků třídy.", r"C) Počet žáků třídy je trojnásobkem počtu děvčat.", r"D) Počet dívek ve třídě je o polovinu menší než počet chlapců.", r"E) Žádné z výše uvedených tvrzení není pravdivé."],
    codes=["zs2", "r9", "pomer", "procenta", "uvazovani", "vyber", "bez-kalkulacky", "slovni"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 15", pts=6, mins=9, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 V lednu navštívilo výstavu $350$ lidí, v únoru $420$ lidí. O kolik procent byla návštěvnost v únoru vyšší než v lednu?",
         r"15.2 Obdélník i tmavý obrazec zakreslený v obdélníku mají všechny vrcholy v mřížových bodech čtvercové sítě (viz obrázek). O kolik procent je obsah tmavého obrazce menší než obsah obdélníku?",
         r"15.3 Věra měla naspořeno $1\,000$ korun. Nejprve si za $20\ \%$ úspor koupila tričko a potom $20\ \%$ ze zbývajících peněz utratila za knížku. O kolik procent bylo tričko dražší než knížka?",
         r"Nabídka: A) o $0\ \%$; B) o $20\ \%$; C) o $25\ \%$; D) o $30\ \%$; E) o $35\ \%$; F) o jiný počet procent."],
    solp=[r"15.1: $\frac{420-350}{350}=\frac{70}{350}=0{,}2=20\ \%$ — \textbf{B}.",
          r"15.2: obdélník má $5\times4=20$ čtverečků, obsah tmavého obrazce je $13$ čtverečků; je menší o $20-13=7$, tj. o $\frac{7}{20}=35\ \%$ — \textbf{E}.",
          r"15.3: tričko $=20\ \%$ z $1\,000=200$ Kč; zbývá $800$ Kč, knížka $=20\ \%$ z $800=160$ Kč; tričko je dražší o $\frac{200-160}{160}=\frac{40}{160}=25\ \%$ — \textbf{C}."],
    ans=r"15.1: B; 15.2: E; 15.3: C",
    svg=fig(8, (432, 373, 495, 425)), fn=FN,
    alt="Obdélník rozdělený čtvercovou sítí 5 krát 4; v něm je tmavě vyplněný šestiúhelník s vrcholy v mřížových bodech o obsahu 13 čtverečků.", cap="",
    codes=["zs2", "r9", "procenta", "planimetrie", "aritmetika", "prirazovani", "vypocet", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9D · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Do řady po sobě jdoucích kladných celých čísel přidáme za každé číslo dělitelné třemi toto číslo ještě jednou. Nová řada tak všechna čísla dělitelná třemi obsahuje dvakrát. Na $1.$ až $17.$ místě je: $1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11, 12, 12, 13, \dots$",
         r"Určete,",
         r"16.1 na kolikátém místě nové řady je číslo $100$,",
         r"16.2 které číslo je na $100.$ místě nové řady,",
         r"16.3 na kolika místech nové řady je mezi čísly $1$ až $101$ uvedeno sudé číslo."],
    solp=[r"Číslo $v$ končí na místě $v+\left\lfloor\frac{v}{3}\right\rfloor$ (za každý násobek $3$ menší nebo rovný $v$ přibude jedno místo).",
          r"16.1: $100$ není dělitelné $3$, je na místě $100+\left\lfloor\frac{100}{3}\right\rfloor=100+33=133$.",
          r"16.2: hledáme $v$ s $v+\lfloor v/3\rfloor=100$; pro $v=75$ je $75+25=100$. Číslo $75$ je dělitelné $3$, vyskytuje se dvakrát (na $99.$ a $100.$ místě), takže na $100.$ místě je $75$.",
          r"16.3: sudých čísel od $1$ do $101$ je $50$ (čísla $2,4,\dots,100$). Z nich jsou násobky $6$ (sudé a zároveň dělitelné $3$) uvedeny dvakrát: $6,12,\dots,96$, tj. $16$ čísel. Počet míst $=(50-16)\cdot1+16\cdot2=34+32=66$."],
    ans=r"16.1: na $133.$ místě; 16.2: $75$; 16.3: na $66$ místech",
    codes=["zs2", "r9", "posloupnosti", "cisla", "aritmetika", "uvazovani", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9D-2021")
for path, size, names in written:
    print("%s  %d B  (%d úloh)" % (path, size, len(names)))
