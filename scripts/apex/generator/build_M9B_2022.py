# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9B 2022 (2. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9B_2022_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2022, 2. řádný termín (M9B)"
CCODE = "M9PBD22C0T02"
YR = 2022
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2022 M9B · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte:",
         r"$(-6)^2-3\cdot(-3)=$"],
    solp=[r"$(-6)^2=36$, $-3\cdot(-3)=9$; celkem $36+9=45$."],
    ans=r"$45$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 2", pts=2, mins=4, diff="3",
    zad=[r"Body $A$, $B$, $C$ a $D$ představují čtyři čísla na číselné ose. Bod $B$ dělí (zleva) úsečku $AC$ v poměru $7:3$. Na ose jsou vyznačeny hodnoty: bod $B$ odpovídá číslu $10$, bod $C$ číslu $22$ a bod $D$ číslu $52$.",
         r"2.1 Určete, v jakém poměru dělí bod $C$ (zleva) úsečku $BD$. Poměr zapište v základním tvaru.",
         r"2.2 Určete číslo, které na číselné ose představuje bod $A$."],
    solp=[r"2.1: $|BC|=22-10=12$, $|CD|=52-22=30$; poměr $12:30=2:5$.",
          r"2.2: $B$ dělí $AC$ v poměru $|AB|:|BC|=7:3$, přičemž $|BC|=12$, tedy $|AB|=\frac{7}{3}\cdot12=28$. Bod $A=10-28=-18$."],
    ans=r"2.1: $2:5$; 2.2: $-18$",
    codes=["zs2", "r9", "pomer", "aritmetika", "vypocet", "cisla", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{7}{5}\cdot\dfrac{3}{8}\cdot\dfrac{10}{21}+\dfrac{3}{10}=$",
         r"3.2 \quad $\dfrac{\frac{1}{4}-\frac{5}{8}}{3\cdot\frac{5}{12}}=$"],
    solp=[r"3.1: $\frac{7}{5}\cdot\frac{3}{8}\cdot\frac{10}{21}=\frac{7\cdot3\cdot10}{5\cdot8\cdot21}=\frac{210}{840}=\frac{1}{4}$; poté $\frac{1}{4}+\frac{3}{10}=\frac{5}{20}+\frac{6}{20}=\frac{11}{20}$.",
          r"3.2: čitatel $\frac{1}{4}-\frac{5}{8}=\frac{2}{8}-\frac{5}{8}=-\frac{3}{8}$; jmenovatel $3\cdot\frac{5}{12}=\frac{15}{12}=\frac{5}{4}$; $-\frac{3}{8}:\frac{5}{4}=-\frac{3}{8}\cdot\frac{4}{5}=-\frac{12}{40}=-\frac{3}{10}$."],
    ans=r"3.1: $\frac{11}{20}$; 3.2: $-\frac{3}{10}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 Upravte a rozložte na součin vytknutím: $x\cdot x-x+2x^2=$",
         r"4.2 Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $(5b-0{,}4a)^2=$",
         r"4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2n-3)\cdot(4n-2)+(n-3)\cdot(n+3)=$"],
    solp=[r"4.1: $x\cdot x-x+2x^2=x^2+2x^2-x=3x^2-x=x\cdot(3x-1)$.",
          r"4.2: $(5b-0{,}4a)^2=(5b)^2-2\cdot5b\cdot0{,}4a+(0{,}4a)^2=25b^2-4ab+0{,}16a^2$.",
          r"4.3: $(2n-3)(4n-2)=8n^2-16n+6$; $(n-3)(n+3)=n^2-9$; součet $9n^2-16n-3$."],
    ans=r"4.1: $x\cdot(3x-1)$; 4.2: $25b^2-4ab+0{,}16a^2$; 4.3: $9n^2-16n-3$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $5\cdot(0{,}2x+1)=(8-6x):2$",
         r"5.2 \quad $\dfrac{y-5}{2}+\dfrac{3-y}{6}=1-\dfrac{2y}{3}$"],
    solp=[r"5.1: $x+5=4-3x\Rightarrow4x=-1\Rightarrow x=-\frac{1}{4}$.",
          r"5.2: vynásobíme $6$: $3(y-5)+(3-y)=6-4y\Rightarrow3y-15+3-y=6-4y\Rightarrow2y-12=6-4y\Rightarrow6y=18\Rightarrow y=3$."],
    ans=r"5.1: $x=-\frac{1}{4}$; 5.2: $y=3$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 6", pts=3, mins=4, diff="3",
    zad=[r"V krabici jsou pouze jednobarevné kuličky, a to zelené, červené a modré. Čtvrtina všech kuliček je zelených, šestina všech kuliček je červených, modrých kuliček je o $20$ více než červených.",
         r"6.1 Vypočtěte, kolik kuliček je v krabici.",
         r"6.2 Vypočtěte, o kolik se liší počty zelených a červených kuliček v krabici."],
    solp=[r"Označme počet všech kuliček $n$. Zelených $\frac{n}{4}$, červených $\frac{n}{6}$, modrých $\frac{n}{6}+20$. Součet: $\frac{n}{4}+\frac{n}{6}+\frac{n}{6}+20=n$.",
          r"Vynásobíme $12$: $3n+2n+2n+240=12n\Rightarrow7n+240=12n\Rightarrow5n=240\Rightarrow n=48$.",
          r"6.1: v krabici je $48$ kuliček.",
          r"6.2: zelených $\frac{48}{4}=12$, červených $\frac{48}{6}=8$; liší se o $12-8=4$."],
    ans=r"6.1: $48$ kuliček; 6.2: o $4$ kuličky",
    codes=["zs2", "r9", "zlomky", "rovnice", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 7", pts=4, mins=5, diff="3",
    zad=[r"Soutěže se zúčastnilo $5$ škol A, B, C, D, E. Každou školu reprezentovaly dva týmy – jeden dívčí a jeden chlapecký. Výsledky (počty bodů) jsou dány grafem, dva údaje chybí. Dívčí týmy: A $=12$, B $=6$, C chybí, D $=4$, E $=4$. Chlapecké týmy: A $=6$, B $=14$, C $=2$, D chybí, E $=6$.",
         r"7.1 Výsledek dívčího týmu školy C byl stejný jako aritmetický průměr výsledků dívčích týmů škol A a B. Vypočtěte aritmetický průměr výsledků všech pěti dívčích týmů.",
         r"7.2 Aritmetický průměr výsledků všech pěti chlapeckých týmů je $8$ bodů. Určete, kolik bodů získal chlapecký tým školy D."],
    solp=[r"7.1: dívčí tým C $=\frac{12+6}{2}=9$. Průměr všech pěti dívčích týmů $=\frac{12+6+9+4+4}{5}=\frac{35}{5}=7$ bodů.",
          r"7.2: součet bodů pěti chlapeckých týmů $=5\cdot8=40$. Známé $6+14+2+6=28$; chlapecký tým D $=40-28=12$ bodů."],
    ans=r"7.1: $7$ bodů; 7.2: $12$ bodů",
    codes=["zs2", "r9", "grafy", "aritmetika", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 8", pts=3, mins=5, diff="3",
    zad=[r"Bílý čtverec má obsah $9\ \mathrm{cm}^2$, černá plocha uvnitř čtverce $KLMN$ má obsah $16\ \mathrm{cm}^2$ a šedá plocha uvnitř čtverce $ABCD$ má obsah $56\ \mathrm{cm}^2$ (viz obrázek). Bílý čtverec leží uvnitř čtverce $KLMN$ a ten uvnitř čtverce $ABCD$.",
         r"8.1 Vypočtěte v cm délku strany $KL$.",
         r"8.2 Vypočtěte v cm obvod čtverce $ABCD$."],
    solp=[r"Bílý čtverec má stranu $\sqrt{9}=3\ \mathrm{cm}$.",
          r"8.1: obsah čtverce $KLMN=$ černá $+$ bílý $=16+9=25\ \mathrm{cm}^2$, tedy $|KL|=\sqrt{25}=5\ \mathrm{cm}$.",
          r"8.2: obsah čtverce $ABCD=$ šedá $+$ $KLMN=56+25=81\ \mathrm{cm}^2$, strana $\sqrt{81}=9\ \mathrm{cm}$; obvod $4\cdot9=36\ \mathrm{cm}$."],
    ans=r"8.1: $5\ \mathrm{cm}$; 8.2: $36\ \mathrm{cm}$",
    svg=fig(4, (350, 66, 524, 240)), fn=FN,
    alt="Čtverec ABCD (šedý) obsahuje pootočený čtverec KLMN (černý), uvnitř něhož je menší bílý čtverec.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obsah", "obvod", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 9", pts=2, mins=5, diff="3",
    zad=[r"V rovině leží bod $C$ a přímka $q$ (viz obrázek).",
         r"Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Základna $AB$ leží na přímce $q$ a má délku $6\ \mathrm{cm}$.",
         r"Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte."],
    solp=[r"Protože trojúhelník je rovnoramenný se základnou $AB$, leží vrchol $C$ na ose základny $AB$. Sestrojíme patu $S$ kolmice z bodu $C$ na přímku $q$ — to je střed základny.",
          r"Na přímce $q$ naneseme na obě strany od $S$ vzdálenost $3\ \mathrm{cm}$ (polovina $|AB|=6\ \mathrm{cm}$) a získáme body $A$ a $B$. Trojúhelník $ABC$ narýsujeme."],
    ans=r"Konstrukce rovnoramenného trojúhelníku $ABC$ se základnou $AB$ délky $6\ \mathrm{cm}$ na přímce $q$ a vrcholem $C$.",
    svg=fig(4, (130, 495, 430, 675)), fn=FN,
    alt="V rovině leží přímka q (šikmá) a pod ní bod C.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $A$, $C$ a přímka $p$ (viz obrázek).",
         r"Body $A$, $C$ jsou vrcholy rovnoběžníku $ABCD$, jehož dvě strany jsou rovnoběžné s přímkou $p$. Jedna z úhlopříček rovnoběžníku $ABCD$ je k přímce $p$ kolmá.",
         r"10.1 Sestrojte střed $S$ rovnoběžníku $ABCD$ a označte ho písmenem.",
         r"10.2 Sestrojte vrcholy $B$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte."],
    solp=[r"10.1: úhlopříčky rovnoběžníku se navzájem půlí, proto střed $S$ je střed úsečky $AC$.",
          r"10.2: strany rovnoběžníku jsou rovnoběžné s $p$, tedy úhlopříčka $BD$ je k $p$ kolmá. Bodem $S$ vedeme kolmici k $p$; na ní leží vrcholy $B$ a $D$ souměrně podle $S$. Jejich polohu určíme tak, aby strany $AB$ a $CD$ byly rovnoběžné s $p$ (např. $AB\parallel p$ určuje bod $B$ jako průsečík rovnoběžky s $p$ vedené bodem $A$ s kolmicí; $D$ je souměrný podle $S$)."],
    ans=r"Konstrukce středu $S$ (střed úsečky $AC$) a vrcholů $B$, $D$ rovnoběžníku $ABCD$.",
    svg=fig(5, (105, 108, 445, 320)), fn=FN,
    alt="V rovině leží přímka p (šikmá), bod A vlevo dole a bod C vpravo nahoře.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 11", pts=4, mins=6, diff="4",
    zad=[r"Ze tří stejných dřevěných krychlí byl slepen čtyřboký hranol, jehož síť má obsah $126\ \mathrm{cm}^2$ (viz obrázek sítě hranolu).",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 Povrch hranolu je $14$krát větší než obsah stěny jedné krychle.",
         r"11.2 Síť krychle má obsah $42\ \mathrm{cm}^2$.",
         r"11.3 Nejkratší hrana hranolu měří $3\ \mathrm{cm}$."],
    solp=[r"Krychle má hranu $a$. Hranol má rozměry $a\times a\times3a$; jeho povrch (obsah sítě) $=2a^2+4\cdot3a^2=14a^2=126\Rightarrow a^2=9\Rightarrow a=3\ \mathrm{cm}$.",
          r"11.1: povrch hranolu $=126\ \mathrm{cm}^2$, obsah stěny krychle $=a^2=9\ \mathrm{cm}^2$; $126:9=14$ — pravda (A).",
          r"11.2: síť (povrch) jedné krychle $=6a^2=6\cdot9=54\ \mathrm{cm}^2\neq42$ — nepravda (N).",
          r"11.3: nejkratší hrana hranolu $=a=3\ \mathrm{cm}$ — pravda (A)."],
    ans=r"11.1: A; 11.2: N; 11.3: A",
    svg=fig(6, (426, 68, 522, 184)), fn=FN,
    alt="Síť čtyřbokého hranolu složeného ze tří krychlí: řada čtyř obdélníků 1×3 a dva čtvercové podstavy.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "uvazovani", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Reklamní plochu pro vylepování plakátů tvoří plášť rotačního válce. Podstava válce má poloměr $50\ \mathrm{cm}$. Plakát, který přesně pokryje celou reklamní plochu, má tvar čtverce.",
         r"Jaká je výška válce? Výsledek je zaokrouhlen na celé cm."],
    solp=[r"Rozvinutý plášť je obdélník o šířce rovné obvodu podstavy $o=2\pi r=2\pi\cdot50=100\pi\ \mathrm{cm}$ a výšce $h$ (výška válce).",
          r"Plakát má tvar čtverce, tedy obdélník je čtverec: $h=100\pi\doteq314\ \mathrm{cm}$."],
    ans=r"C) $314\ \mathrm{cm}$",
    opts=[r"A) $157\ \mathrm{cm}$", r"B) $236\ \mathrm{cm}$", r"C) $314\ \mathrm{cm}$", r"D) $390\ \mathrm{cm}$", r"E) větší než $390\ \mathrm{cm}$"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (v obrázku vyznačeny značkami). Dvě různoběžky protínají rovnoběžky pod úhly $110^\circ$ a $100^\circ$ a navzájem se protínají ve vrcholu úhlu $\alpha$ (viz obrázek).",
         r"Jaká je velikost úhlu $\alpha$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Vrcholem úhlu $\alpha$ vedeme pomocnou přímku rovnoběžnou s oběma rovnoběžkami. Ta rozdělí úhel $\alpha$ na dvě části.",
          r"Podle přilehlých (přímých) úhlů u rovnoběžek jsou tyto části $180^\circ-110^\circ=70^\circ$ a $180^\circ-100^\circ=80^\circ$.",
          r"Tedy $\alpha=70^\circ+80^\circ=150^\circ$."],
    ans=r"D) $150^\circ$",
    opts=[r"A) menší než $120^\circ$", r"B) $120^\circ$", r"C) $130^\circ$", r"D) $150^\circ$", r"E) větší než $150^\circ$"],
    svg=fig(7, (72, 90, 300, 226)), fn=FN,
    alt="Dvě rovnoběžné přímky (se značkami) protnuté dvěma různoběžkami; vyznačené úhly 110° a 100° u rovnoběžek a hledaný úhel alfa v jejich průsečíku.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 14", pts=2, mins=3, diff="3",
    zad=[r"V knihovně je $k$ polic. V každé polici je o $8$ knih více, než je v knihovně polic. ($k$ může nabývat různých kladných celých hodnot.)",
         r"Který výraz vyjadřuje celkový počet knih v knihovně?"],
    solp=[r"V jedné polici je $k+8$ knih, polic je $k$. Celkový počet knih $=k\cdot(k+8)=k^2+8k$."],
    ans=r"A) $k^2+8k$",
    opts=[r"A) $k^2+8k$", r"B) $k^2+16k+64$", r"C) $k^2+64$", r"D) $2k+8$", r"E) $8k$"],
    codes=["zs2", "r9", "vyrazy", "algebra", "slovni", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Včera stála sekačka $20\,000$ korun a dnes je její cena pouze $8\,000$ korun. O kolik procent byla snížena cena sekačky?",
         r"15.2 První skupina poseče čtvrtinu louky a druhá skupina $60\ \%$ zbývající části louky. Poslední část louky zůstane neposečená. Kolik procent louky zůstane neposečeno?",
         r"15.3 Nedávno byly zdraženy hřebíky. Částka, za kterou jsme dříve koupili $120$ hřebíků, nyní vystačí jen na $80$ hřebíků. O kolik procent byly hřebíky zdraženy?",
         r"Nabídka: A) méně než $30\ \%$; B) $30\ \%$; C) $40\ \%$; D) $50\ \%$; E) $60\ \%$; F) jiný počet procent."],
    solp=[r"15.1: snížení o $20\,000-8\,000=12\,000$ korun; $\frac{12\,000}{20\,000}=0{,}6=60\ \%$ — \textbf{E}.",
          r"15.2: po první skupině zbývá $\frac{3}{4}$; druhá poseče $0{,}6\cdot\frac{3}{4}=0{,}45$. Posečeno celkem $0{,}25+0{,}45=0{,}70$, neposečeno $30\ \%$ — \textbf{B}.",
          r"15.3: cena za kus vzrostla v poměru $\frac{120}{80}=1{,}5$, tedy o $50\ \%$ — \textbf{D}."],
    ans=r"15.1: E; 15.2: B; 15.3: D",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9B · úloha 16", pts=4, mins=8, diff="4",
    zad=[r"Ve čtvercové síti (krok $1\ \mathrm{cm}$) vytváříme různé obdélníky s vrcholy v mřížových bodech. Uvnitř obdélníku zakreslíme v každém vnitřním mřížovém bodě hvězdičku. Hvězdičky nejblíže hranici obdélníku jsou tmavé, ostatní bílé. (Na obrázku je příklad obdélníku $8\ \mathrm{cm}\times4\ \mathrm{cm}$ se $7\cdot3=21$ hvězdičkami, z nichž vnitřní jsou bílé a vnější tmavé.)",
         r"Obdélník o rozměrech $a\ \mathrm{cm}\times b\ \mathrm{cm}$ má $(a-1)(b-1)$ hvězdiček; bílých je $(a-3)(b-3)$ a zbytek jsou tmavé.",
         r"16.1 Určete počet všech hvězdiček v obdélníku s rozměry $81\ \mathrm{cm}$ a $20\ \mathrm{cm}$.",
         r"16.2 Obdélník, jehož jeden rozměr je $50\ \mathrm{cm}$, obsahuje celkem $9\,800$ hvězdiček. Určete v cm druhý rozměr tohoto obdélníku.",
         r"16.3 Vypočtěte, o kolik se liší počty bílých a tmavých hvězdiček v obdélníku s rozměry $41\ \mathrm{cm}$ a $23\ \mathrm{cm}$."],
    solp=[r"Počet všech hvězdiček (vnitřních mřížových bodů) obdélníku $a\times b$ je $(a-1)(b-1)$; bílé tvoří vnitřní pole $(a-3)(b-3)$, tmavé jsou zbývající vnější řada.",
          r"16.1: $(81-1)(20-1)=80\cdot19=1\,520$ hvězdiček.",
          r"16.2: $(50-1)(b-1)=9\,800\Rightarrow49(b-1)=9\,800\Rightarrow b-1=200\Rightarrow b=201\ \mathrm{cm}$.",
          r"16.3: všech $=(41-1)(23-1)=40\cdot22=880$; bílých $=(41-3)(23-3)=38\cdot20=760$; tmavých $=880-760=120$; liší se o $760-120=640$."],
    ans=r"16.1: $1\,520$ hvězdiček; 16.2: $201\ \mathrm{cm}$; 16.3: o $640$ hvězdiček",
    codes=["zs2", "r9", "posloupnosti", "algebra", "vypocet", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9B-2022")
for path, size, names in written:
    print("%s  %d B  (%d úloh)" % (path, size, len(names)))
