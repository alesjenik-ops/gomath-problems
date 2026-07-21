# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9A 2022 (1. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9A_2022_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2022, 1. řádný termín (M9A)"
CCODE = "M9PAD22C0T01"
YR = 2022
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2022 M9A · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte:",
         r"$\dfrac{7^2-\sqrt{7^2}}{\sqrt{49}}=$"],
    solp=[r"$\sqrt{7^2}=7$, $\sqrt{49}=7$; čitatel $49-7=42$; $\dfrac{42}{7}=6$."],
    ans=r"$6$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 2", pts=2, mins=4, diff="3",
    zad=[r"2.1 \quad Obdélník má šířku $8\ \mathrm{cm}$ a obsah $4\ \mathrm{dm}^2$. Vypočtěte, o kolik cm se liší délka a šířka obdélníku.",
         r"2.2 \quad Vypočtěte, kolikrát větší je objem $1{,}2\ \mathrm{dm}^3$ než objem $300\ \mathrm{mm}^3$."],
    solp=[r"2.1: $4\ \mathrm{dm}^2=400\ \mathrm{cm}^2$; délka $=400:8=50\ \mathrm{cm}$; rozdíl $50-8=42\ \mathrm{cm}$.",
          r"2.2: $1{,}2\ \mathrm{dm}^3=1\,200\,000\ \mathrm{mm}^3$; $1\,200\,000:300=4\,000$."],
    ans=r"2.1: o $42\ \mathrm{cm}$; 2.2: $4\,000$krát",
    codes=["zs2", "r9", "aritmetika", "geometrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{8}{5}\cdot\left(\dfrac{5}{6}\cdot\dfrac{7}{10}-\dfrac{5}{6}\right)=$",
         r"3.2 \quad $\dfrac{\left(\frac{4}{5}-\frac{2}{3}\right)\cdot\frac{5}{8}}{\frac{2}{3}}=$"],
    solp=[r"3.1: $\frac{5}{6}\cdot\frac{7}{10}=\frac{7}{12}$; $\frac{7}{12}-\frac{5}{6}=\frac{7}{12}-\frac{10}{12}=-\frac{3}{12}=-\frac{1}{4}$; $\frac{8}{5}\cdot\left(-\frac{1}{4}\right)=-\frac{8}{20}=-\frac{2}{5}$.",
          r"3.2: $\frac{4}{5}-\frac{2}{3}=\frac{12-10}{15}=\frac{2}{15}$; $\frac{2}{15}\cdot\frac{5}{8}=\frac{10}{120}=\frac{1}{12}$; $\frac{1}{12}:\frac{2}{3}=\frac{1}{12}\cdot\frac{3}{2}=\frac{3}{24}=\frac{1}{8}$."],
    ans=r"3.1: $-\frac{2}{5}$; 3.2: $\frac{1}{8}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 \quad Z daného výrazu vytkněte $3y$: $\ 3y^2-9y+6xy=$",
         r"4.2 \quad Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $\ \left(x+\dfrac{3}{2}\right)^2=$",
         r"4.3 \quad Zjednodušte (výsledný výraz nesmí obsahovat závorky): $\ (4+3n)\cdot(3n-2n)-(n-1)\cdot5n=$"],
    solp=[r"4.1: $3y\cdot(y-3+2x)$.",
          r"4.2: $\left(x+\frac{3}{2}\right)^2=x^2+2\cdot x\cdot\frac{3}{2}+\frac{9}{4}=x^2+3x+\frac{9}{4}$.",
          r"4.3: $3n-2n=n$; $(4+3n)\cdot n=4n+3n^2$; $(n-1)\cdot5n=5n^2-5n$; $4n+3n^2-(5n^2-5n)=-2n^2+9n$."],
    ans=r"4.1: $3y\cdot(y-3+2x)$; 4.2: $x^2+3x+\frac{9}{4}$; 4.3: $-2n^2+9n$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $5\cdot0{,}4-3x:2=0{,}5x+7$",
         r"5.2 \quad $\dfrac{3-y}{3}+\dfrac{3}{5}\cdot(y+1)+\dfrac{y}{3}=y$"],
    solp=[r"5.1: $2-1{,}5x=0{,}5x+7\Rightarrow2-7=0{,}5x+1{,}5x\Rightarrow-5=2x\Rightarrow x=-2{,}5$.",
          r"5.2: vynásobíme $15$: $5(3-y)+9(y+1)+5y=15y\Rightarrow15-5y+9y+9+5y=15y\Rightarrow24+9y=15y\Rightarrow24=6y\Rightarrow y=4$."],
    ans=r"5.1: $x=-2{,}5$; 5.2: $y=4$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 6", pts=3, mins=5, diff="4",
    zad=[r"Domeček je vytvořen z pravidelného čtyřbokého hranolu a kolmého trojbokého hranolu. Oba hranoly mají jednu stěnu společnou. Rozměry čtyřbokého hranolu jsou $x$, $x$ a $20\ \mathrm{cm}$. Podstavou trojbokého hranolu je pravoúhlý trojúhelník s odvěsnami délek $6\ \mathrm{cm}$ a $8\ \mathrm{cm}$.",
         r"Vypočtěte v cm$^3$",
         r"6.1 \quad objem trojbokého hranolu,",
         r"6.2 \quad objem pravidelného čtyřbokého hranolu."],
    solp=[r"Přepona pravoúhlého trojúhelníku (společná hrana obou hranolů) je $\sqrt{6^2+8^2}=\sqrt{100}=10\ \mathrm{cm}$; to je zároveň hrana čtvercové podstavy, tedy $x=10\ \mathrm{cm}$. Oba hranoly jsou dlouhé $20\ \mathrm{cm}$.",
          r"6.1: podstavou trojbokého hranolu je pravoúhlý trojúhelník o obsahu $\frac{1}{2}\cdot6\cdot8=24\ \mathrm{cm}^2$; objem $=24\cdot20=480\ \mathrm{cm}^3$.",
          r"6.2: pravidelný čtyřboký hranol má čtvercovou podstavu $x^2=10^2=100\ \mathrm{cm}^2$; objem $=100\cdot20=2\,000\ \mathrm{cm}^3$."],
    ans=r"6.1: $480\ \mathrm{cm}^3$; 6.2: $2\,000\ \mathrm{cm}^3$",
    svg=fig(3, (365, 60, 527, 200)), fn=FN,
    alt="Domeček z pravidelného čtyřbokého hranolu (rozměry x, x, 20 cm) a kolmého trojbokého hranolu, jehož podstavou je pravoúhlý trojúhelník s odvěsnami 6 cm a 8 cm; oba hranoly mají společnou stěnu.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "slovni", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 7", pts=3, mins=5, diff="3",
    zad=[r"Děti i dospělí užívají doporučené dávky vitaminů denně po celý rok. Dle příbalového letáku je doporučená denní dávka vitaminů pro dítě poloviční než pro dospělého. Dva dospělí spotřebují dohromady jedno balení vitaminů za $30$ dní.",
         r"Vypočtěte,",
         r"7.1 \quad kolik balení vitaminů spotřebuje jeden dospělý za $360$ dní,",
         r"7.2 \quad za kolik dní spotřebuje jedno balení vitaminů jedno dítě,",
         r"7.3 \quad za kolik dní spotřebují jedno balení vitaminů dohromady dva dospělí a jedno dítě."],
    solp=[r"Dva dospělí spotřebují za den $\frac{1}{30}$ balení, jeden dospělý tedy $\frac{1}{60}$ balení za den; jedno dítě má poloviční dávku, tj. $\frac{1}{120}$ balení za den.",
          r"7.1: $360\cdot\frac{1}{60}=6$ balení.",
          r"7.2: $1:\frac{1}{120}=120$ dní.",
          r"7.3: společná denní spotřeba dvou dospělých a jednoho dítěte $=\frac{1}{30}+\frac{1}{120}=\frac{4}{120}+\frac{1}{120}=\frac{5}{120}=\frac{1}{24}$ balení za den, tedy $24$ dní."],
    ans=r"7.1: $6$ balení; 7.2: za $120$ dní; 7.3: za $24$ dní",
    codes=["zs2", "r9", "aritmetika", "pomer", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 8", pts=4, mins=6, diff="3",
    zad=[r"Za $4$ dortíky zaplatíme v cukrárně celkem $x$ korun, stejně jako za $5$ koláčů.",
         r"8.1 \quad Vyjádřete výrazem s proměnnou $x$, kolik korun zaplatíme v cukrárně za $1$ dortík.",
         r"8.2 \quad Vyjádřete výrazem s proměnnou $x$, kolik korun zaplatíme v cukrárně za $4$ koláče.",
         r"8.3 \quad V cukrárně jsme za $5$ dortíků a $4$ koláče zaplatili celkem $246$ korun. Vypočtěte, kolik korun jsme zaplatili za jeden dortík."],
    solp=[r"8.1: $1$ dortík stojí $\frac{x}{4}$ korun.",
          r"8.2: $1$ koláč stojí $\frac{x}{5}$ korun, $4$ koláče tedy $\frac{4}{5}x$ korun.",
          r"8.3: $5\cdot\frac{x}{4}+4\cdot\frac{x}{5}=246\Rightarrow\frac{25x+16x}{20}=246\Rightarrow\frac{41x}{20}=246\Rightarrow x=120$; jeden dortík stojí $\frac{120}{4}=30$ korun."],
    ans=r"8.1: $\frac{1}{4}x$; 8.2: $\frac{4}{5}x$; 8.3: $30$ korun",
    codes=["zs2", "r9", "vyrazy", "rovnice", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 9", pts=3, mins=7, diff="4",
    zad=[r"V rovině leží body C, S a přímka $q$ (viz obrázek).",
         r"Bod C je vrchol rovnoramenného trojúhelníku ABC se základnou AB. Bod S je střed jednoho ramene tohoto trojúhelníku a na přímce $q$ leží jeden z vrcholů A, B.",
         r"Sestrojte vrcholy A, B trojúhelníku ABC, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení."],
    solp=[r"Bod S je střed ramene, tedy střed úsečky spojující vrchol C s jedním z vrcholů A, B, který leží na přímce $q$. Ve středové souměrnosti se středem S se vrchol C zobrazí na tento vrchol ležící na $q$: sestrojíme obraz $C'$ bodu C v souměrnosti podle S a jeho průsečík s přímkou $q$ dává hledaný vrchol (A nebo B).",
          r"Druhý vrchol základny doplníme tak, aby trojúhelník ABC byl rovnoramenný se základnou AB (vrchol C je od obou vrcholů základny stejně vzdálen). Úloha se řeší konstrukcí; podle polohy může mít jedno řešení.",
          r"Jde o konstrukční úlohu, hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce rovnoramenného trojúhelníku ABC (S střed ramene, jeden vrchol základny na přímce $q$); nutno nalézt všechna řešení.",
    svg=fig(4, (70, 445, 500, 660)), fn=FN,
    alt="V rovině leží body C a S a přímka q; bod S je nad bodem C, přímka q je vodorovná nad nimi.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 10", pts=2, mins=6, diff="4",
    zad=[r"V rovině leží bod O a přímka $p$ (viz obrázek).",
         r"Bod O je střed čtverce ABCD, jehož strana BC leží na přímce $p$.",
         r"Sestrojte všechny vrcholy čtverce ABCD, označte je písmeny a čtverec narýsujte."],
    solp=[r"Vzdálenost středu O od přímky $p$ (na níž leží strana BC) je rovna polovině strany čtverce; strana čtverce má tedy délku $2\cdot|Op|$, kde $|Op|$ je vzdálenost bodu O od přímky $p$.",
          r"Sestrojíme kolmici z O na $p$, její patu a od ní naneseme na obě strany po $|Op|$ (vrcholy B, C); protější stranu AD získáme posunutím o $2\cdot|Op|$ kolmo od $p$ přes bod O. Označíme vrcholy a čtverec narýsujeme.",
          r"Jde o konstrukční úlohu, hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce čtverce ABCD se středem O a stranou BC na přímce $p$ (strana $=2\cdot|Op|$).",
    svg=fig(5, (70, 120, 535, 388)), fn=FN,
    alt="V rovině leží bod O a šikmá přímka p vpravo od bodu O.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 11", pts=4, mins=6, diff="3",
    zad=[r"Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).",
         r"11.1 \quad Tři čtvrtiny z $200$ minut je totéž jako polovina ze $3$ hodin.",
         r"11.2 \quad Dvě třetiny z $2{,}4$ hodiny je více než $1$ hodina a $40$ minut.",
         r"11.3 \quad Tři osminy z $5$ dnů je totéž jako pět osmin ze $3$ dnů."],
    solp=[r"11.1: $\frac{3}{4}\cdot200=150$ min; polovina ze $3$ hodin $=1{,}5$ h $=90$ min. $150\neq90$ — \textbf{N}.",
          r"11.2: $\frac{2}{3}\cdot2{,}4$ h $=1{,}6$ h $=1$ h $36$ min; to je méně než $1$ h $40$ min — \textbf{N}.",
          r"11.3: $\frac{3}{8}\cdot5=\frac{15}{8}$ a $\frac{5}{8}\cdot3=\frac{15}{8}$ — jsou stejné — \textbf{A}."],
    ans=r"11.1: N; 11.2: N; 11.3: A",
    codes=["zs2", "r9", "zlomky", "aritmetika", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"V rovině leží čtyři vzájemně různoběžné přímky; tři z nich procházejí bodem A (viz situace níže). Přímka, která bodem A neprochází, protíná dvě z těchto přímek — v horním vrcholu svírá úhel $60^\circ$ a v pravém vrcholu je vně trojúhelníku vyznačen úhel $132^\circ$. U bodu A jsou mezi přímkami vyznačeny úhly $\alpha$ a $3\alpha$ (spolu s vnitřním úhlem trojúhelníku u vrcholu A tvoří přímý úhel).",
         r"Jaká je velikost úhlu $\alpha$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Vnitřní úhel trojúhelníku u pravého vrcholu je $180^\circ-132^\circ=48^\circ$.",
          r"Vnitřní úhel trojúhelníku u vrcholu A $=180^\circ-60^\circ-48^\circ=72^\circ$.",
          r"U vrcholu A leží na přímce vedle sebe úhly $\alpha$, $3\alpha$ a vnitřní úhel $72^\circ$, jejich součet je přímý úhel: $\alpha+3\alpha+72^\circ=180^\circ\Rightarrow4\alpha=108^\circ\Rightarrow\alpha=27^\circ$."],
    ans=r"B) $27^\circ$",
    opts=[r"A) $24^\circ$", r"B) $27^\circ$", r"C) $32^\circ$", r"D) $36^\circ$", r"E) jiná velikost"],
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 13", pts=2, mins=3, diff="3",
    zad=[r"Papír tvaru kruhu se středem S a poloměrem $10\ \mathrm{cm}$ byl rozstříhán na $5$ shodných kruhových výsečí (středový úhel každé výseče je $\frac{360^\circ}{5}=72^\circ$).",
         r"Jaký je obvod jedné výseče? Výsledek je zaokrouhlen na celé cm."],
    solp=[r"Obvod výseče tvoří dva poloměry a kruhový oblouk: $o=2r+\frac{72}{360}\cdot2\pi r=2\cdot10+\frac{1}{5}\cdot2\pi\cdot10=20+4\pi$.",
          r"$20+4\pi\doteq20+12{,}57=32{,}57\doteq33\ \mathrm{cm}$."],
    ans=r"D) $33\ \mathrm{cm}$",
    opts=[r"A) menší než $25\ \mathrm{cm}$", r"B) $25\ \mathrm{cm}$", r"C) $30\ \mathrm{cm}$", r"D) $33\ \mathrm{cm}$", r"E) větší než $33\ \mathrm{cm}$"],
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 14", pts=2, mins=4, diff="4",
    zad=[r"V soutěži mohli jednotliví soutěžící dosáhnout výsledků: $0$ bodů, $1$ bod, nebo $2$ body. Graf (kruhový diagram) znázorňuje rozdělení soutěžících podle výsledků. Po $1$ bodu získalo $30$ soutěžících, po $2$ bodech $10\ \%$ všech soutěžících. Soutěžících, kteří získali po $1$ bodu, bylo dvakrát více než soutěžících bez bodu.",
         r"Jaký je aritmetický průměr výsledků všech soutěžících?"],
    solp=[r"Nechť je celkem $N$ soutěžících. Bez bodu jich je polovina z těch, kdo mají $1$ bod, tedy $15$; s $2$ body je $0{,}1N$. Platí $15+30+0{,}1N=N\Rightarrow0{,}9N=45\Rightarrow N=50$.",
          r"S $2$ body je $0{,}1\cdot50=5$ soutěžících. Součet bodů $=0\cdot15+1\cdot30+2\cdot5=40$; průměr $=\frac{40}{50}=0{,}8$ bodu."],
    ans=r"A) $0{,}8$ bodu",
    opts=[r"A) $0{,}8$ bodu", r"B) $0{,}75$ bodu", r"C) $0{,}\overline{6}$ bodu", r"D) $0{,}6$ bodu", r"E) jiný průměr"],
    codes=["zs2", "r9", "grafy", "aritmetika", "procenta", "vypocet", "vyber", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Ve škole, která má v každém ročníku dvě třídy (A, B), proběhla soutěž ve sběru papíru. V prvním ročníku nasbírala třída 1. A $600\ \mathrm{kg}$ a třída 1. B $600\ \mathrm{kg}$, celkem tedy $1\,200\ \mathrm{kg}$.",
         r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 \quad Třída 2. A nasbírala o $25\ \%$ méně papíru než třída 1. A. Kolik kg papíru nasbírala třída 2. A?",
         r"15.2 \quad Třída 1. B nasbírala o $20\ \%$ více papíru než třída 2. B. Kolik kg papíru nasbírala třída 2. B?",
         r"15.3 \quad Ze všech žáků prvního ročníku nasbíraly dívky o $50\ \%$ více papíru než chlapci. Kolik kg papíru nasbírali dohromady chlapci z prvního ročníku?",
         r"Nabídka: A) $800\ \mathrm{kg}$; B) $720\ \mathrm{kg}$; C) $500\ \mathrm{kg}$; D) $480\ \mathrm{kg}$; E) $450\ \mathrm{kg}$; F) jiný počet kg."],
    solp=[r"15.1: $600\cdot(1-0{,}25)=600\cdot0{,}75=450\ \mathrm{kg}$ — \textbf{E}.",
          r"15.2: $1{,}2\cdot(\text{2. B})=600\Rightarrow\text{2. B}=500\ \mathrm{kg}$ — \textbf{C}.",
          r"15.3: chlapci $+$ dívky $=1\,200$, dívky $=1{,}5\cdot$chlapci; $2{,}5\cdot$chlapci $=1\,200\Rightarrow$ chlapci $=480\ \mathrm{kg}$ — \textbf{D}."],
    ans=r"15.1: E; 15.2: C; 15.3: D",
    codes=["zs2", "r9", "procenta", "aritmetika", "prirazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9A · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Tři děti v jednotlivých kolech hry přidávaly mince do klobouku, který byl na počátku prázdný. Julie přidávala v každém kole $1$ minci. Čeněk přidával mince pouze v každém $4$. kole, a to vždy $4$ najednou. Pavla přidávala mince pouze v každém $5$. kole, a to vždy $5$ najednou. Např. po prvních $9$ kolech bylo v klobouku celkem $22$ mincí ($9$ od Julie, $8$ od Čeňka a $5$ od Pavly).",
         r"16.1 \quad Určete celkový počet mincí v klobouku po prvních $35$ kolech.",
         r"16.2 \quad Čeněk přidal své $4$ mince do klobouku zatím $14$krát. Určete, kolikrát již přidala do klobouku svou pětici mincí Pavla.",
         r"16.3 \quad Určete, po kolika kolech od počátku bylo v klobouku přesně $183$ mincí."],
    solp=[r"Po $n$ kolech je v klobouku $n+4\cdot\left\lfloor\frac{n}{4}\right\rfloor+5\cdot\left\lfloor\frac{n}{5}\right\rfloor$ mincí.",
          r"16.1: $35+4\cdot\lfloor35/4\rfloor+5\cdot\lfloor35/5\rfloor=35+4\cdot8+5\cdot7=35+32+35=102$ mincí.",
          r"16.2: Čeněk přidával $14$krát znamená $56\le n\le59$; v tomto rozsahu Pavla přidávala $\lfloor n/5\rfloor=11$krát (v kolech $5,10,\dots,55$).",
          r"16.3: pro $n=60$ je součet $60+60+60=180$; $n=61\to181$, $n=62\to182$, $n=63\to63+4\cdot15+5\cdot12=63+60+60=183$. Bylo to po $63$ kolech."],
    ans=r"16.1: $102$ mincí; 16.2: $11$krát; 16.3: po $63$ kolech",
    codes=["zs2", "r9", "posloupnosti", "aritmetika", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9A-2022")
for path, size, names in written:
    print(path, size, "B", len(names), "úloh")
