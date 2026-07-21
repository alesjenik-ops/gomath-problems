# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9C 2023 (náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9C_2023_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2023, náhradní termín (M9C)"
CCODE = "M9PCD23C0T03"
YR = 2023
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2023 M9C · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte, kolikrát je součet čísel $0{,}2$ a $0{,}5$ větší než jejich součin."],
    solp=[r"Součet $0{,}2+0{,}5=0{,}7$; součin $0{,}2\cdot0{,}5=0{,}1$; $\frac{0{,}7}{0{,}1}=7$."],
    ans=r"$7$krát",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 2", pts=2, mins=3, diff="3",
    zad=[r"Vypočtěte:",
         r"2.1 \quad $4+6:2-5\cdot(-3+5)=$",
         r"2.2 \quad $\sqrt{1{,}3^2-1{,}2^2}=$"],
    solp=[r"2.1: $4+3-5\cdot2=4+3-10=-3$.",
          r"2.2: $\sqrt{1{,}69-1{,}44}=\sqrt{0{,}25}=0{,}5$."],
    ans=r"2.1: $-3$; 2.2: $0{,}5$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $3\cdot\dfrac{2}{7}-\dfrac{2}{7}=$",
         r"3.2 \quad $1-\dfrac{14}{5}:2=$",
         r"3.3 \quad $\dfrac{\frac{3}{4}+\frac{4}{3}}{\frac{5}{7}\cdot\frac{14}{3}}=$"],
    solp=[r"3.1: $\frac{6}{7}-\frac{2}{7}=\frac{4}{7}$.",
          r"3.2: $1-\frac{14}{10}=1-\frac{7}{5}=-\frac{2}{5}$.",
          r"3.3: čitatel $\frac{3}{4}+\frac{4}{3}=\frac{9+16}{12}=\frac{25}{12}$; jmenovatel $\frac{5}{7}\cdot\frac{14}{3}=\frac{10}{3}$; $\frac{25}{12}:\frac{10}{3}=\frac{25}{12}\cdot\frac{3}{10}=\frac{5}{8}$."],
    ans=r"3.1: $\frac{4}{7}$; 3.2: $-\frac{2}{5}$; 3.3: $\frac{5}{8}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 Rozložte na součin podle vzorce: $4a^2-9=$",
         r"4.2 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2x-1)\cdot\dfrac{1}{2}-x=$",
         r"4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(4n-3)^2-4n\cdot(4n-3)=$"],
    solp=[r"4.1: $(2a+3)\cdot(2a-3)$.",
          r"4.2: $x-\frac{1}{2}-x=-\frac{1}{2}$.",
          r"4.3: vytkneme $(4n-3)$: $(4n-3)\cdot[(4n-3)-4n]=(4n-3)\cdot(-3)=-12n+9$."],
    ans=r"4.1: $(2a+3)(2a-3)$; 4.2: $-\frac{1}{2}$; 4.3: $-12n+9$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $0{,}3\cdot(2x+1)=0{,}2x-0{,}7$",
         r"5.2 \quad $y+\dfrac{5y}{6}=\dfrac{2y-1}{4}+\dfrac{y+1}{2}$"],
    solp=[r"5.1: $0{,}6x+0{,}3=0{,}2x-0{,}7\Rightarrow0{,}4x=-1\Rightarrow x=-2{,}5$.",
          r"5.2: levá strana $\frac{6y+5y}{6}=\frac{11y}{6}$; pravá $\frac{2y-1}{4}+\frac{2y+2}{4}=\frac{4y+1}{4}$; $\frac{11y}{6}=\frac{4y+1}{4}\Rightarrow44y=6(4y+1)\Rightarrow20y=6\Rightarrow y=0{,}3$."],
    ans=r"5.1: $x=-2{,}5$; 5.2: $y=0{,}3$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 6", pts=3, mins=5, diff="3",
    zad=[r"Vítek, Rudolf a Ondra jeli společně autem k moři. Každý z nich odřídil část trasy. Vítek odřídil třetinu celé trasy, Rudolf odřídil o $60\ \mathrm{km}$ méně než Vítek a Ondra odřídil zbývající dvě pětiny celé trasy. Celá trasa měřila $x\ \mathrm{km}$.",
         r"6.1 Vyjádřete výrazem s proměnnou $x$, kolik km trasy odřídil Rudolf.",
         r"6.2 Vypočtěte, kolik km měřila celá trasa."],
    solp=[r"6.1: Rudolf $=\frac{x}{3}-60$ (ekvivalentně $\frac{4}{15}x$, neboť $x-\frac{x}{3}-\frac{2x}{5}=\frac{4}{15}x$).",
          r"6.2: $\frac{x}{3}-60=\frac{4}{15}x\Rightarrow\frac{5x}{15}-\frac{4x}{15}=60\Rightarrow\frac{x}{15}=60\Rightarrow x=900$."],
    ans=r"6.1: $\frac{x}{3}-60$ (resp. $\frac{4}{15}x$); 6.2: $900\ \mathrm{km}$",
    codes=["zs2", "r9", "vyrazy", "rovnice", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 7", pts=3, mins=5, diff="4",
    zad=[r"Rotační válec má výšku $12\ \mathrm{cm}$. Odstraněním čtyř částí vytvoříme z tohoto válce kvádr s rozměry $8\ \mathrm{cm}$, $6\ \mathrm{cm}$ a $12\ \mathrm{cm}$. Všechny hrany kvádru leží na povrchu válce.",
         r"7.1 Vypočtěte v cm poloměr podstavy válce.",
         r"7.2 Vypočtěte v cm$^3$ objem válce. Výsledek zaokrouhlete na desítky cm$^3$."],
    solp=[r"7.1: obdélník $8\times6$ je vepsán do podstavy válce, jeho úhlopříčka je průměrem: $\sqrt{8^2+6^2}=\sqrt{100}=10\ \mathrm{cm}$, tedy $r=5\ \mathrm{cm}$.",
          r"7.2: $V=\pi r^2 h=\pi\cdot25\cdot12=300\pi\doteq942\doteq940\ \mathrm{cm}^3$."],
    ans=r"7.1: $r=5\ \mathrm{cm}$; 7.2: $V\doteq940\ \mathrm{cm}^3$",
    svg=fig(3, (66, 455, 530, 600)), fn=FN,
    alt="Rotační válec o výšce 12 cm a z něj vytvořený kvádr s rozměry 8 cm, 6 cm a 12 cm; hrany kvádru leží na povrchu válce.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "slovni", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 8", pts=3, mins=5, diff="3",
    zad=[r"V obchodě s oříšky prodávají různé směsi. Jejich cena závisí pouze na hmotnosti a ceně použitých surovin. Ceny za $1\ \mathrm{kg}$: arašídy $80$ korun, kešu $280$ korun, mandle $200$ korun.",
         r"8.1 Dvoukilogramové balení směsi arašídů a mandlí obsahuje $800\ \mathrm{g}$ arašídů a $1\,200\ \mathrm{g}$ mandlí. Vypočtěte, kolik korun stojí jeden kilogram této směsi.",
         r"8.2 Jiná směs obsahuje pouze arašídy a kešu, přičemž $1\ \mathrm{kg}$ této směsi stojí $200$ korun. Velké balení této směsi obsahuje $500\ \mathrm{g}$ arašídů. Vypočtěte, kolik gramů kešu obsahuje velké balení této směsi."],
    solp=[r"8.1: cena $2\ \mathrm{kg}$ $=0{,}8\cdot80+1{,}2\cdot200=64+240=304$ korun, tedy $1\ \mathrm{kg}$ stojí $152$ korun.",
          r"8.2: nechť balení obsahuje $m$ kg kešu; $\frac{0{,}5\cdot80+m\cdot280}{0{,}5+m}=200\Rightarrow40+280m=100+200m\Rightarrow80m=60\Rightarrow m=0{,}75\ \mathrm{kg}=750\ \mathrm{g}$."],
    ans=r"8.1: $152$ korun; 8.2: $750\ \mathrm{g}$",
    codes=["zs2", "r9", "aritmetika", "rovnice", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží přímka AB a přímka $p$ procházející bodem B (viz obrázek).",
         r"Úsečka AB je strana pravoúhlého lichoběžníku ABCD. Vrchol C tohoto lichoběžníku leží na přímce $p$, úhlopříčka AC má stejnou délku jako strana AB lichoběžníku ABCD.",
         r"Sestrojte vrcholy C, D lichoběžníku ABCD, označte je písmeny a lichoběžník narýsujte. Najděte všechna řešení."],
    solp=[r"Vrchol C leží na přímce $p$ a zároveň na kružnici se středem A a poloměrem $|AB|$ (podmínka $|AC|=|AB|$) — sestrojíme průsečík. V pravoúhlém lichoběžníku jsou pravé úhly při vrcholech A a D; vrchol D získáme jako patu kolmice z C na přímku AB (resp. sestrojením strany DA kolmé k AB). Podle počtu průsečíků přímky $p$ s kružnicí může úloha mít jedno nebo dvě řešení.",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce pravoúhlého lichoběžníku ABCD (C na přímce $p$, $|AC|=|AB|$); nutno nalézt všechna řešení.",
    svg=fig(5, (66, 88, 595, 300)), fn=FN,
    alt="V rovině leží úsečka AB a přímka p procházející bodem B.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body A, C a přímka $p$ procházející bodem C (viz obrázek).",
         r"Úsečka AC je základna rovnoramenného trojúhelníku ABC. Na přímce $p$ leží jedna ze tří výšek tohoto trojúhelníku.",
         r"10.1 Sestrojte osu souměrnosti trojúhelníku ABC a označte ji písmenem $o$.",
         r"10.2 Sestrojte vrchol B trojúhelníku ABC, označte ho písmenem a trojúhelník narýsujte."],
    solp=[r"Osa souměrnosti $o$ rovnoramenného trojúhelníku se základnou AC je osa úsečky AC (prochází středem AC kolmo k AC). Výška na přímce $p$ prochází bodem C; vrchol B najdeme jako průsečík přímky $p$ (resp. odpovídající konstrukce výšky) s osou $o$ tak, aby ABC byl rovnoramenný se základnou AC.",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce osy $o$ (osa úsečky AC) a vrcholu B rovnoramenného trojúhelníku ABC.",
    svg=fig(6, (66, 88, 595, 300)), fn=FN,
    alt="V rovině leží body A, C a přímka p procházející bodem C.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 11", pts=4, mins=6, diff="4",
    zad=[r"Na táboře je každé dítě zařazeno do jednoho ze tří oddílů A, B a C. V oddíle A je dvakrát více dětí než v oddíle C. Poměr počtu dětí v oddíle A ku počtu dětí v oddíle B je $4:3$.",
         r"Graf udává počty chlapců a dívek v jednotlivých oddílech, dva údaje však chybí: oddíl A má $9$ chlapců a $7$ dívek, oddíl C má $3$ chlapce (počet dívek chybí), oddíl B má $4$ dívky (počet chlapců chybí).",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 V oddíle C je $5$ dívek.",
         r"11.2 V oddíle B je chlapců o polovinu více než dívek.",
         r"11.3 Na táboře je dívek o pětinu méně než chlapců."],
    solp=[r"Oddíl A $=9+7=16$ dětí. A $=2\cdot$C $\Rightarrow$ C $=8$; A$:$B $=4:3\Rightarrow$ B $=12$.",
          r"C: $3$ chlapci, tedy dívek $8-3=5$. B: $4$ dívky, tedy chlapců $12-4=8$.",
          r"11.1: v oddíle C je $5$ dívek — \textbf{A} (pravda).",
          r"11.2: v oddíle B je $8$ chlapců a $4$ dívky, tj. dvakrát více (ne o polovinu více) — \textbf{N}.",
          r"11.3: chlapců celkem $9+3+8=20$, dívek $7+5+4=16$; $16=20-\frac{20}{5}$, tedy o pětinu méně — \textbf{A}."],
    ans=r"11.1: A; 11.2: N; 11.3: A",
    codes=["zs2", "r9", "pomer", "aritmetika", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 12", pts=2, mins=3, diff="4",
    zad=[r"Ve vlakové soupravě jsou pouze stejně dlouhé vagony a jedna lokomotiva. Lokomotiva je o čtvrtinu kratší než jeden vagon a její délka tvoří jednu sedmnáctinu délky celé vlakové soupravy.",
         r"Kolik vagonů je celkem ve vlakové soupravě?"],
    solp=[r"Vagon má délku $v$, lokomotiva $\frac{3}{4}v$. Pro $n$ vagonů: $\frac{\frac{3}{4}v}{n\cdot v+\frac{3}{4}v}=\frac{1}{17}\Rightarrow17\cdot\frac{3}{4}=n+\frac{3}{4}\Rightarrow n=\frac{51-3}{4}=12$."],
    ans=r"C) $12$ vagonů",
    opts=[r"A) $10$ vagonů", r"B) $11$ vagonů", r"C) $12$ vagonů", r"D) $13$ vagonů", r"E) jiný počet vagonů"],
    codes=["zs2", "r9", "rovnice", "aritmetika", "slovni", "vyber", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Pětiúhelník ABCDE se skládá z rovnoramenného, rovnostranného a pravoúhlého trojúhelníku (viz obrázek). Základnou rovnoramenného trojúhelníku je strana AB. Strany BC a AE pětiúhelníku jsou rovnoběžné. Úhel při vrcholu A má velikost $55^\circ$, při vrcholu C je pravý úhel.",
         r"Jaká je velikost úhlu $\omega$ (při vrcholu D)? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Rovnoramenný trojúhelník ABE se základnou AB: úhly při A i B jsou $55^\circ$, tedy úhel AEB $=70^\circ$.",
          r"Rovnostranný trojúhelník BDE má všechny úhly $60^\circ$ (úhel EBD $=60^\circ$).",
          r"Protože BC $\parallel$ AE, jsou úhly EAB a ABC přilehlé (součet $180^\circ$): úhel ABC $=180^\circ-55^\circ=125^\circ$.",
          r"Úhel DBC $=125^\circ-55^\circ-60^\circ=10^\circ$. V pravoúhlém trojúhelníku BCD (pravý úhel při C) je $\omega=90^\circ-10^\circ=80^\circ$."],
    ans=r"D) $80^\circ$",
    opts=[r"A) $65^\circ$", r"B) $70^\circ$", r"C) $75^\circ$", r"D) $80^\circ$", r"E) jiná velikost"],
    svg=fig(8, (232, 58, 595, 245)), fn=FN,
    alt="Pětiúhelník ABCDE složený z rovnoramenného, rovnostranného a pravoúhlého trojúhelníku; úhel při A je 55°, při C pravý úhel, hledaný úhel omega při vrcholu D.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 14", pts=2, mins=3, diff="4",
    zad=[r"Povrch pravidelného čtyřbokého hranolu je $144\ \mathrm{cm}^2$. Obsah pláště tohoto hranolu je dvakrát větší než obsah jedné jeho čtvercové podstavy. (Plášť tvoří čtyři shodné boční stěny.)",
         r"Jaký je objem hranolu?"],
    solp=[r"Podstava je čtverec o straně $a$, výška $h$. Plášť $=4ah$, podstava $=a^2$; $4ah=2a^2\Rightarrow a=2h$.",
          r"Povrch $=2a^2+4ah=2a^2+2a^2=4a^2=144\Rightarrow a^2=36\Rightarrow a=6\ \mathrm{cm}$, $h=3\ \mathrm{cm}$.",
          r"Objem $V=a^2\cdot h=36\cdot3=108\ \mathrm{cm}^3$."],
    ans=r"B) $108\ \mathrm{cm}^3$",
    opts=[r"A) $72\ \mathrm{cm}^3$", r"B) $108\ \mathrm{cm}^3$", r"C) $144\ \mathrm{cm}^3$", r"D) $216\ \mathrm{cm}^3$", r"E) jiný objem"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Encyklopedie má o $25\ \%$ více stran než atlas, který má $200$ stran. Kolik stran má encyklopedie?",
         r"15.2 Róza čte knihu, která má $500$ stran. Počet stran, které Róza již přečetla, je o $50\ \%$ větší než počet stran, které dosud nepřečetla. Kolik stran knihy Róza dosud nepřečetla?",
         r"15.3 V knihovně jsou některé knihy psané německy, jiné anglicky a ostatní česky. Německy psaných je $30$ knih, což je $10\ \%$ všech knih. Anglicky psané tvoří pětinu všech knih. Kolik je v knihovně česky psaných knih?",
         r"Nabídka: A) méně než $210$; B) $210$; C) $220$; D) $240$; E) $250$; F) jiný počet."],
    solp=[r"15.1: $200\cdot1{,}25=250$ — \textbf{E}.",
          r"15.2: nepřečteno $x$, přečteno $1{,}5x$; $x+1{,}5x=500\Rightarrow2{,}5x=500\Rightarrow x=200$ — méně než $210$, tedy \textbf{A}.",
          r"15.3: $30$ knih $=10\ \%\Rightarrow$ celkem $300$; anglicky $\frac{1}{5}\cdot300=60$; česky $300-30-60=210$ — \textbf{B}."],
    ans=r"15.1: E; 15.2: A; 15.3: B",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9C · úloha 16", pts=4, mins=6, diff="4",
    zad=[r"Každý obrazec tvaru obdélníku je složen z malých šedých čtverečků a větších bílých čtverečků. Šedé čtverečky jsou stejné a jsou poskládány do spodní řady a do levého sloupce; zbytek tvoří bílé čtverečky. Každý bílý čtvereček má dvakrát delší stranu než šedý. První obrazec má ve spodní řadě $5$ šedých čtverečků a v levém sloupci $3$ šedé čtverečky; skládá se celkem z $9$ čtverečků. Každý další obrazec má oproti předchozímu vždy o $2$ šedé čtverečky více jak ve spodní řadě, tak i v levém sloupci.",
         r"16.1 Obrazec má ve spodní řadě $41$ šedých čtverečků. Určete počet bílých čtverečků v obrazci.",
         r"16.2 V obrazci je $90$ bílých čtverečků. Určete počet šedých čtverečků v obrazci.",
         r"16.3 Počet všech čtverečků v posledním a v předposledním obrazci se liší o $106$. Určete počet šedých čtverečků v posledním obrazci."],
    solp=[r"Pro $n$-tý obrazec: spodní řada $=2n+3$ šedých, levý sloupec $=2n+1$ šedých. Bílá část má rozměr $(2n+2)\times2n$ v malých čtverečcích, tj. bílých $\frac{2n+2}{2}\cdot\frac{2n}{2}=n(n+1)$. Šedých je $(2n+3)+(2n+1)-1=4n+3$.",
          r"16.1: $2n+3=41\Rightarrow n=19$; bílých $19\cdot20=380$.",
          r"16.2: $n(n+1)=90\Rightarrow n=9$; šedých $4\cdot9+3=39$.",
          r"16.3: celkem $C(n)=n^2+5n+3$; $C(n)-C(n-1)=2n+4=106\Rightarrow n=51$; šedých $4\cdot51+3=207$."],
    ans=r"16.1: $380$ bílých; 16.2: $39$ šedých; 16.3: $207$ šedých",
    svg=fig(10, (66, 180, 360, 305)), fn=FN,
    alt="Posloupnost obrazců tvaru obdélníku z malých šedých a větších bílých čtverečků; 1. a 2. obrazec a tři tečky naznačující pokračování.", cap="",
    codes=["zs2", "r9", "posloupnosti", "algebra", "vypocet", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9C-2023")
