# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9A 2020 (řádný termín – jediný termín kvůli COVID)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9A_2020_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2020, řádný termín (M9A)"
CCODE = "M9PAD20C0T01"
YR = 2020
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2020 M9A · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte:",
         r"$(-0{,}4)^2+0{,}3^2=$"],
    solp=[r"$(-0{,}4)^2=0{,}16$ a $0{,}3^2=0{,}09$; součet $0{,}16+0{,}09=0{,}25$."],
    ans=r"$0{,}25$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 2", pts=2, mins=4, diff="3",
    zad=[r"2.1 \quad Z dvouhodinové přednášky již tři pětiny uplynuly. Vypočtěte, kolik minut zbývá do konce přednášky.",
         r"2.2 \quad Objemy dvou laboratorních nádob jsou $V_1=9\,500\ \mathrm{mm}^3$, $V_2=0{,}001\ \mathrm{m}^3$. Vypočtěte, o kolik $\mathrm{cm}^3$ se liší objemy $V_1$, $V_2$ těchto laboratorních nádob."],
    solp=[r"2.1: dvě hodiny $=120$ minut; zbývají dvě pětiny, tedy $\frac{2}{5}\cdot120=48$ minut.",
          r"2.2: $V_1=9\,500\ \mathrm{mm}^3=9{,}5\ \mathrm{cm}^3$; $V_2=0{,}001\ \mathrm{m}^3=1\,000\ \mathrm{cm}^3$; rozdíl $1\,000-9{,}5=990{,}5\ \mathrm{cm}^3$."],
    ans=r"2.1: $48$ minut; 2.2: o $990{,}5\ \mathrm{cm}^3$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "pocetni", "slovni", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\left(\dfrac{1}{4}+\dfrac{5}{6}\right)\cdot\left(\dfrac{5}{13}-\dfrac{1}{2}\right)=$",
         r"3.2 \quad $\dfrac{\frac{6}{5}}{\frac{7}{6}\cdot4-4\cdot\frac{5}{12}}=$"],
    solp=[r"3.1: $\frac{1}{4}+\frac{5}{6}=\frac{3+10}{12}=\frac{13}{12}$; $\frac{5}{13}-\frac{1}{2}=\frac{10-13}{26}=-\frac{3}{26}$; součin $\frac{13}{12}\cdot\left(-\frac{3}{26}\right)=-\frac{39}{312}=-\frac{1}{8}$.",
          r"3.2: jmenovatel $\frac{7}{6}\cdot4-4\cdot\frac{5}{12}=\frac{28}{6}-\frac{20}{12}=\frac{14}{3}-\frac{5}{3}=3$; tedy $\frac{6}{5}:3=\frac{6}{15}=\frac{2}{5}$."],
    ans=r"3.1: $-\frac{1}{8}$; 3.2: $\frac{2}{5}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 \quad Rozložte na součin: $p^2-16=$",
         r"4.2 \quad Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2x+5)^2=$",
         r"4.3 \quad Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2n+6)\cdot(4n-5)+(3-5)\cdot2n-5n\cdot(n-2n)=$"],
    solp=[r"4.1: $p^2-16=(p-4)(p+4)$.",
          r"4.2: $(2x+5)^2=4x^2+20x+25$.",
          r"4.3: $(2n+6)(4n-5)=8n^2+14n-30$; $(3-5)\cdot2n=-4n$; $-5n\cdot(n-2n)=-5n\cdot(-n)=5n^2$; součet $8n^2+5n^2+14n-4n-30=13n^2+10n-30$."],
    ans=r"4.1: $(p-4)(p+4)$; 4.2: $4x^2+20x+25$; 4.3: $13n^2+10n-30$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $3{,}2-0{,}5x-1=0{,}6-1{,}3x$",
         r"5.2 \quad $\dfrac{5y+3}{8}-\dfrac{y}{2}=\dfrac{4-y}{5}+\dfrac{2y-1}{10}$"],
    solp=[r"5.1: $2{,}2-0{,}5x=0{,}6-1{,}3x\Rightarrow0{,}8x=-1{,}6\Rightarrow x=-2$.",
          r"5.2: levá strana $\frac{5y+3-4y}{8}=\frac{y+3}{8}$; pravá strana $\frac{2(4-y)+(2y-1)}{10}=\frac{8-2y+2y-1}{10}=\frac{7}{10}$; tedy $\frac{y+3}{8}=\frac{7}{10}\Rightarrow10(y+3)=56\Rightarrow10y=26\Rightarrow y=\frac{13}{5}$."],
    ans=r"5.1: $x=-2$; 5.2: $y=\frac{13}{5}$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 6", pts=3, mins=5, diff="3",
    zad=[r"Tři vázy mají různé velikosti. Objem velké vázy je o polovinu větší než objem střední vázy. Objem střední vázy je čtyřikrát větší než objem malé vázy. Neznámý objem střední vázy označte $x$.",
         r"6.1 \quad V závislosti na veličině $x$ vyjádřete objem velké vázy.",
         r"6.2 \quad V závislosti na veličině $x$ vyjádřete objem malé vázy.",
         r"6.3 \quad Všechny tři vázy dohromady mají objem $5{,}5$ litru. Vypočtěte v litrech objem střední vázy."],
    solp=[r"6.1: velká $=x+\frac{1}{2}x=\frac{3x}{2}$.",
          r"6.2: malá $=\frac{x}{4}$.",
          r"6.3: $\frac{3x}{2}+x+\frac{x}{4}=\frac{6x+4x+x}{4}=\frac{11x}{4}=5{,}5\Rightarrow x=2$, tedy střední váza má objem $2$ litry."],
    ans=r"6.1: $\frac{3x}{2}$; 6.2: $\frac{x}{4}$; 6.3: $2$ litry",
    codes=["zs2", "r9", "vyrazy", "rovnice", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 7", pts=3, mins=5, diff="3",
    zad=[r"Škrabací sloupek pro kočky má tvar rotačního válce. Válec má výšku $50\ \mathrm{cm}$ a jeho podstava má průměr $14\ \mathrm{cm}$. Obě podstavy jsou bílé, plášť válce je šedý. (Za $\pi$ dosazujte $\frac{22}{7}$.)",
         r"Vypočtěte v $\mathrm{cm}^2$:",
         r"7.1 \quad obsah jedné podstavy válce,",
         r"7.2 \quad obsah pláště válce."],
    solp=[r"7.1: poloměr $r=7\ \mathrm{cm}$; obsah podstavy $=\pi r^2=\frac{22}{7}\cdot49=154\ \mathrm{cm}^2$.",
          r"7.2: obsah pláště $=\pi d\cdot h=\frac{22}{7}\cdot14\cdot50=2\,200\ \mathrm{cm}^2$."],
    ans=r"7.1: $154\ \mathrm{cm}^2$; 7.2: $2\,200\ \mathrm{cm}^2$",
    svg=fig(3, (448, 428, 524, 570)), fn=FN,
    alt="Rotační válec (škrabací sloupek) o výšce 50 cm a s podstavou o průměru 14 cm; plášť je šedý.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "vypocet", "slovni", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 8", pts=4, mins=7, diff="4",
    zad=[r"Obdélníkový záhon má rozměry $210\ \mathrm{cm}$ a $140\ \mathrm{cm}$.",
         r"8.1 \quad Záhon bude po obvodu osázen tulipány ve stejných rozestupech. Rozestupy mezi sousedními tulipány musí být co největší, přitom tulipán musí být v každém rohu záhonu a také uprostřed delší strany. Vypočtěte v cm rozestup mezi sousedními tulipány.",
         r"8.2 \quad Uvnitř záhonu je vyznačen menší obdélník. V jeho rozích a po jeho obvodu budou v $10$centimetrových rozestupech vysázeny narcisy. Každý narcis bude vzdálen $25\ \mathrm{cm}$ od nejbližšího okraje záhonu. Vypočtěte, kolik narcisů bude vysázeno."],
    solp=[r"8.1: rozestup musí beze zbytku dělit kratší stranu $140\ \mathrm{cm}$ i polovinu delší strany $105\ \mathrm{cm}$ (tulipán je i uprostřed delší strany). Největší takové číslo je největší společný dělitel čísel $105$ a $140$, tedy $35\ \mathrm{cm}$.",
          r"8.2: vnitřní obdélník je od každého okraje vzdálen $25\ \mathrm{cm}$, jeho rozměry jsou $(210-2\cdot25)\times(140-2\cdot25)=160\times90\ \mathrm{cm}$; jeho obvod je $2\cdot(160+90)=500\ \mathrm{cm}$. Narcisy jsou po $10\ \mathrm{cm}$: $500:10=50$ narcisů."],
    ans=r"8.1: $35\ \mathrm{cm}$; 8.2: $50$ narcisů",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 9", pts=2, mins=6, diff="4",
    zad=[r"V rovině leží přímka $AC$ a přímka $b$ (viz obrázek).",
         r"Body $A$, $C$ jsou vrcholy trojúhelníku $ABC$. Na přímce $b$ leží vrchol $B$. Délka těžnice $t_b$ na stranu $AC$ je $6\ \mathrm{cm}$.",
         r"Sestrojte vrchol $B$ trojúhelníku $ABC$, označte jej písmenem a trojúhelník narýsujte. Najděte všechna řešení."],
    solp=[r"Těžnice $t_b$ spojuje vrchol $B$ se středem $S_{AC}$ strany $AC$. Sestrojíme střed $S_{AC}$ úsečky $AC$.",
          r"Vrchol $B$ leží na přímce $b$ a zároveň na kružnici se středem $S_{AC}$ a poloměrem $6\ \mathrm{cm}$ (podmínka $|BS_{AC}|=t_b=6\ \mathrm{cm}$).",
          r"Průsečíky přímky $b$ s touto kružnicí dávají dvě polohy vrcholu $B$ ($B_1$, $B_2$) — úloha má dvě řešení."],
    ans=r"Konstrukce vrcholu $B$ na přímce $b$ tak, že $|BS_{AC}|=6\ \mathrm{cm}$; úloha má dvě řešení ($B_1$, $B_2$).",
    svg=fig(5, (70, 126, 520, 360)), fn=FN,
    alt="V rovině leží přímka AC (s vyznačenými body A a C) a přímka b.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží přímka $o$ a body $A$, $M$ (viz obrázek).",
         r"Bod $A$ je vrchol rovnoramenného lichoběžníku $ABCD$, bod $M$ je střed jeho ramene $BC$. Přímka $o$ je osou lichoběžníku $ABCD$.",
         r"Sestrojte vrcholy $B$, $C$, $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte."],
    solp=[r"Přímka $o$ je osou souměrnosti rovnoramenného lichoběžníku, proto se vrchol $B$ zobrazí na vrchol $A$. Vrchol $B$ tedy sestrojíme jako obraz bodu $A$ v osové souměrnosti podle osy $o$.",
          r"Bod $M$ je střed ramene $BC$, proto vrchol $C$ sestrojíme tak, aby $M$ byl středem úsečky $BC$ (bod $C$ je středově souměrný s $B$ podle bodu $M$).",
          r"Vrchol $D$ získáme jako obraz vrcholu $C$ v osové souměrnosti podle osy $o$."],
    ans=r"Konstrukce lichoběžníku $ABCD$: $B$ je obraz $A$ podle osy $o$, $C$ tak, že $M$ je střed $BC$, $D$ je obraz $C$ podle osy $o$.",
    svg=fig(6, (75, 100, 420, 355)), fn=FN,
    alt="V rovině leží přímka o a body A, M (označené křížky).", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "soumernost", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 11", pts=4, mins=5, diff="4",
    zad=[r"Všichni pracovníci natírají plot stejným tempem. Polovinu plotu by natřeli všichni pracovníci společně za $6$ hodin.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 \quad Celý plot by natřeli všichni pracovníci společně za $9$ hodin.",
         r"11.2 \quad Polovinu plotu by natřela třetina pracovníků společně za $18$ hodin.",
         r"11.3 \quad Čtvrtinu plotu by natřela čtvrtina pracovníků společně za $12$ hodin."],
    solp=[r"Všichni pracovníci natřou polovinu plotu za $6$ hodin, tedy celý plot za $12$ hodin.",
          r"11.1: celý plot trvá $12$ hodin, ne $9$ hodin — \textbf{N}.",
          r"11.2: třetina pracovníků potřebuje na stejnou práci trojnásobný čas: polovinu plotu za $3\cdot6=18$ hodin — \textbf{A}.",
          r"11.3: všichni natřou čtvrtinu plotu za $12:4=3$ hodiny; čtvrtina pracovníků čtyřikrát déle, tj. $4\cdot3=12$ hodin — \textbf{A}."],
    ans=r"11.1: N; 11.2: A; 11.3: A",
    codes=["zs2", "r9", "pomer", "aritmetika", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Na obrázku jsou dvě rovnoběžné přímky (označené dvojitými ryskami) a tři příčky, které mezi nimi vytvářejí lomenou čáru. Jsou vyznačeny úhly $32^\circ$, $62^\circ$, $128^\circ$ a hledaný úhel $\alpha$ (viz obrázek).",
         r"Jaká je velikost úhlu $\alpha$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Přímky jsou rovnoběžné, využijeme střídavé (a vedlejší) úhly.",
          r"Z úhlu $128^\circ$ u dolní přímky: pravá příčka svírá s dolní přímkou úhel $180^\circ-128^\circ=52^\circ$, který se u horního vrcholu přenese jako střídavý úhel.",
          r"U horního vrcholu je $52^\circ+62^\circ=114^\circ$, takže levé rameno svírá s vodorovnou přímkou úhel $180^\circ-114^\circ=66^\circ$ (a stejně $66^\circ$ i s dolní přímkou).",
          r"U dolního vrcholu přičteme úhel $32^\circ$: příčka příslušná úhlu $\alpha$ svírá s dolní přímkou $66^\circ+32^\circ=98^\circ$. Podle střídavých úhlů je $\alpha=98^\circ$."],
    ans=r"B) $98^\circ$",
    opts=[r"A) menší než $98^\circ$", r"B) $98^\circ$", r"C) $100^\circ$", r"D) $102^\circ$", r"E) větší než $102^\circ$"],
    svg=fig(7, (75, 66, 335, 168)), fn=FN,
    alt="Dvě rovnoběžné přímky a tři příčky tvořící lomenou čáru; vyznačené úhly 32°, 62°, 128° a hledaný úhel alfa.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Podstavou kolmého trojbokého hranolu $ABCDEF$ je pravoúhlý trojúhelník s odvěsnami délek $a=9\ \mathrm{cm}$ a $b=12\ \mathrm{cm}$ (viz obrázek). Obsah největší boční stěny $ABED$ je $300\ \mathrm{cm}^2$.",
         r"Jaký je povrch hranolu?"],
    solp=[r"Přepona podstavy $=\sqrt{9^2+12^2}=\sqrt{225}=15\ \mathrm{cm}$; největší boční stěna přísluší nejdelší hraně (přeponě) $15\ \mathrm{cm}$, tedy $15\cdot v=300\Rightarrow v=20\ \mathrm{cm}$ (výška hranolu).",
          r"Obsah podstavy $=\frac{1}{2}\cdot9\cdot12=54\ \mathrm{cm}^2$; obě podstavy $108\ \mathrm{cm}^2$.",
          r"Plášť $=$ obvod podstavy $\cdot\,v=(9+12+15)\cdot20=720\ \mathrm{cm}^2$.",
          r"Povrch $=108+720=828\ \mathrm{cm}^2$."],
    ans=r"A) $828\ \mathrm{cm}^2$",
    opts=[r"A) $828\ \mathrm{cm}^2$", r"B) $888\ \mathrm{cm}^2$", r"C) $936\ \mathrm{cm}^2$", r"D) $1\,008\ \mathrm{cm}^2$", r"E) $1\,080\ \mathrm{cm}^2$"],
    svg=fig(7, (395, 432, 528, 588)), fn=FN,
    alt="Kolmý trojboký hranol ABCDEF s podstavou pravoúhlého trojúhelníku (odvěsny a, b) a vyznačenými pravými úhly.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 14", pts=2, mins=4, diff="3",
    zad=[r"Pravoúhlý trojúhelník s odvěsnami délek $12\ \mathrm{cm}$ a $6\ \mathrm{cm}$ je dvěma úsečkami rovnoběžnými s kratší odvěsnou rozdělen na tři rovinné útvary. Úsečky rozdělily delší odvěsnu na tři úseky délek $6\ \mathrm{cm}$, $4\ \mathrm{cm}$ a $2\ \mathrm{cm}$ (viz obrázek).",
         r"Jaký je obsah tmavého útvaru (prostředního)?"],
    solp=[r"Výška trojúhelníku roste podél delší odvěsny lineárně od $0$ do $6\ \mathrm{cm}$ (výška ve vzdálenosti $d$ od vrcholu s nulovou výškou je $\frac{d}{2}$).",
          r"Ve vzdálenosti $6\ \mathrm{cm}$ je výška $3\ \mathrm{cm}$, ve vzdálenosti $10\ \mathrm{cm}$ je výška $5\ \mathrm{cm}$.",
          r"Tmavý útvar je lichoběžník se základnami $3\ \mathrm{cm}$ a $5\ \mathrm{cm}$ a výškou $4\ \mathrm{cm}$: $S=\frac{3+5}{2}\cdot4=16\ \mathrm{cm}^2$."],
    ans=r"A) $16\ \mathrm{cm}^2$",
    opts=[r"A) $16\ \mathrm{cm}^2$", r"B) $18\ \mathrm{cm}^2$", r"C) $20\ \mathrm{cm}^2$", r"D) $21\ \mathrm{cm}^2$", r"E) jiný obsah"],
    svg=fig(8, (335, 66, 522, 172)), fn=FN,
    alt="Pravoúhlý trojúhelník s odvěsnami 12 cm a 6 cm rozdělený dvěma svislými úsečkami; delší odvěsna je rozdělena na úseky 6 cm, 4 cm, 2 cm, prostřední útvar je šedý.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 \quad Roční čtenářský poplatek již zaplatilo $40\ \%$ všech čtenářů knihovny, a poplatek tak musí zaplatit ještě zbývajících $264$ čtenářů. Kolik čtenářů má knihovna?",
         r"15.2 \quad Do školní družiny se přihlásilo $540$ žáků, což je o pětinu více, než činí kapacita družiny. Kolik žáků činí kapacita družiny?",
         r"15.3 \quad Do školního tanečního kroužku chodí $25$ žáků, což je $5\ \%$ všech žáků školy. Kroužek juda navštěvuje $20$ žáků školy, přičemž čtvrtina z nich chodí navíc do tanečního kroužku. Kolik žáků školy nechodí ani do tanečního kroužku, ani do kroužku juda?",
         r"Nabídka: A) $400$; B) $420$; C) $440$; D) $450$; E) $460$; F) jiný počet."],
    solp=[r"15.1: zbývajících $264$ čtenářů tvoří $60\ \%$; celkem $264:0{,}6=440$ — \textbf{C}.",
          r"15.2: $540=1{,}2\cdot$kapacita; kapacita $=540:1{,}2=450$ — \textbf{D}.",
          r"15.3: $25$ žáků $=5\ \%\Rightarrow$ všech žáků $500$; taneční $25$, juda $20$, oba kroužky $\frac{1}{4}\cdot20=5$; alespoň jeden kroužek $25+20-5=40$; ani jeden $500-40=460$ — \textbf{E}."],
    ans=r"15.1: C; 15.2: D; 15.3: E",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2020 M9A · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"V počítačové hře má každé čtvercové město tyto vlastnosti: čtverečky představují domy a ve všech řadách i sloupcích je jich stejný počet; mezi každými dvěma sousedními domy prochází jedna ulice (je přímá a spojuje protější okraje města); libovolné dvě ulice jsou buď rovnoběžné, nebo k sobě kolmé; každé dvě navzájem kolmé ulice mají společnou křižovatku.",
         r"Nejmenší dvě čtvercová města: město se $4$ domy má $2$ ulice a $1$ křižovatku; město s $9$ domy má $4$ ulice a $4$ křižovatky.",
         r"Určete,",
         r"16.1 \quad kolik křižovatek je ve městě se $36$ domy,",
         r"16.2 \quad kolik ulic je ve městě se $36$ křižovatkami,",
         r"16.3 \quad kolik domů je ve městě se $36$ ulicemi."],
    solp=[r"Město s $n\times n$ domy má $n^2$ domů, $2(n-1)$ ulic a $(n-1)^2$ křižovatek.",
          r"16.1: $n^2=36\Rightarrow n=6$; křižovatek $(6-1)^2=25$.",
          r"16.2: $(n-1)^2=36\Rightarrow n-1=6\Rightarrow n=7$; ulic $2\cdot6=12$.",
          r"16.3: $2(n-1)=36\Rightarrow n-1=18\Rightarrow n=19$; domů $19^2=361$."],
    ans=r"16.1: $25$ křižovatek; 16.2: $12$ ulic; 16.3: $361$ domů",
    codes=["zs2", "r9", "posloupnosti", "algebra", "uvazovani", "vypocet", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9A-2020")
