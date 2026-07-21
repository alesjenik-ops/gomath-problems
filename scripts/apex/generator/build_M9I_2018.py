# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9I 2018 (ilustrační test, 4-leté obory)."""
import os, re, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9I_2018_TS.pdf"
SRC = "CERMAT – Ilustrační test 2018, matematika 9 (čtyřleté obory)"
CCODE = "M9PID18C0T01"
YR = 2018
FN = "obr.svg"


def fig(pi, rect):
    # Figure text labels use a symbol font that decodes to control chars
    # (breaking XML); keep only the clean vector geometry, strip <text>.
    svg = region_svg(PDF, pi, rect)
    return re.sub(r"<text.*?</text>", "", svg)


P = []

P.append(dict(
    name="CERMAT 2018 M9I · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Myslím si číslo. Číslo k němu opačné je o $6$ menší.",
         r"Určete číslo, které si myslím."],
    solp=[r"Hledané číslo označíme $x$, opačné číslo je $-x$. Platí $-x=x-6$, odtud $-2x=-6$, tedy $x=3$."],
    ans=r"$3$",
    codes=["zs2", "r9", "cisla", "rovnice", "uvazovani", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 2", pts=2, mins=3, diff="2",
    zad=[r"Trojúhelník má obvod $21\ \mathrm{cm}$ a délky jeho stran jsou v poměru $6:5:3$.",
         r"2.1 Určete v cm délku nejdelší strany trojúhelníku.",
         r"2.2 Určete, o kolik cm se liší délky dvou kratších stran trojúhelníku."],
    solp=[r"Součet dílů poměru je $6+5+3=14$; jeden díl $=\frac{21}{14}=1{,}5\ \mathrm{cm}$.",
          r"2.1: nejdelší strana $=6\cdot1{,}5=9\ \mathrm{cm}$.",
          r"2.2: kratší strany jsou $5\cdot1{,}5=7{,}5\ \mathrm{cm}$ a $3\cdot1{,}5=4{,}5\ \mathrm{cm}$; liší se o $7{,}5-4{,}5=3\ \mathrm{cm}$."],
    ans=r"2.1: $9\ \mathrm{cm}$; 2.2: o $3\ \mathrm{cm}$",
    codes=["zs2", "r9", "pomer", "planimetrie", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $2-2\cdot\dfrac{2\cdot\frac{9}{10}}{3}=$",
         r"3.2 \quad $\dfrac{3^2}{5}-\dfrac{3}{5^2}+\left(-\dfrac{3}{5}\right)^2=$"],
    solp=[r"3.1: $2\cdot\frac{9}{10}=\frac{9}{5}$; $\frac{9/5}{3}=\frac{9}{15}=\frac{3}{5}$; $2-2\cdot\frac{3}{5}=2-\frac{6}{5}=\frac{4}{5}$.",
          r"3.2: $\frac{9}{5}-\frac{3}{25}+\frac{9}{25}=\frac{45}{25}-\frac{3}{25}+\frac{9}{25}=\frac{51}{25}$."],
    ans=r"3.1: $\frac{4}{5}$; 3.2: $\frac{51}{25}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 4", pts=4, mins=5, diff="3",
    zad=[r"Zjednodušte (výsledný výraz nesmí obsahovat závorky):",
         r"4.1 \quad $\left[(a-4a)^2-3a\cdot(3a+2)\right]^2=$",
         r"4.2 \quad $(2b+1)\cdot(2b-1)-b\cdot(-b+b)+1=$"],
    solp=[r"4.1: $(a-4a)^2=(-3a)^2=9a^2$; $3a\cdot(3a+2)=9a^2+6a$; hranatá závorka $=9a^2-(9a^2+6a)=-6a$; $(-6a)^2=36a^2$.",
          r"4.2: $(2b+1)(2b-1)=4b^2-1$; $-b\cdot(-b+b)=-b\cdot0=0$; celkem $4b^2-1+1=4b^2$."],
    ans=r"4.1: $36a^2$; 4.2: $4b^2$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 5", pts=4, mins=5, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $\dfrac{5x-2}{4}=1{,}25x-\dfrac{1}{2}$",
         r"5.2 \quad $\dfrac{2}{3}\cdot(x+1)=-\dfrac{1}{3}\cdot(2x-1)-1$"],
    solp=[r"5.1: $1{,}25=\frac{5}{4}$, pravá strana $=\frac{5x}{4}-\frac{1}{2}=\frac{5x-2}{4}$. Obě strany jsou totožné, rovnice platí pro každé $x$ — nekonečně mnoho řešení.",
          r"5.2: vynásobíme $3$: $2(x+1)=-(2x-1)-3$; $2x+2=-2x+1-3=-2x-2$; $4x=-4$; $x=-1$."],
    ans=r"5.1: nekonečně mnoho řešení; 5.2: $x=-1$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 6", pts=4, mins=6, diff="4",
    zad=[r"V každé krabici je stejný počet mýdel. Čtvrtina všech krabic obsahuje jen bílá mýdla a v každé ze zbývajících $120$ krabic je vždy polovina mýdel bílých a polovina zelených. Bílých mýdel je celkem $1\,200$.",
         r"6.1 Určete počet všech krabic s mýdly.",
         r"6.2 Určete nejmenší počet krabic, do nichž by se vešla všechna bílá mýdla.",
         r"6.3 Určete počet všech mýdel."],
    solp=[r"Zbývajících $120$ krabic tvoří tři čtvrtiny všech krabic, tedy všech krabic je $120:\frac{3}{4}=160$.",
          r"6.1: všech krabic je $160$.",
          r"6.2: čistě bílých krabic je $\frac{1}{4}\cdot160=40$. V každé krabici je stejný počet mýdel $m$; bílá mýdla: $40m+120\cdot\frac{m}{2}=40m+60m=100m=1\,200$, tedy $m=12$. Všech $1\,200$ bílých mýdel se vejde do $1\,200:12=100$ krabic.",
          r"6.3: všech mýdel je $160\cdot12=1\,920$."],
    ans=r"6.1: $160$ krabic; 6.2: $100$ krabic; 6.3: $1\,920$ mýdel",
    codes=["zs2", "r9", "slovni", "aritmetika", "zlomky", "uvazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 7", pts=3, mins=6, diff="4",
    zad=[r"Obdélník $ABCD$ lze rozdělit na šest shodných pravoúhlých trojúhelníků. Přemístěním jediného trojúhelníku lze vytvořit lichoběžník $EFGH$ (viz obrázek). Strana trojúhelníku délky $8\ \mathrm{cm}$ je současně výškou lichoběžníku. Rameno lichoběžníku měří $10\ \mathrm{cm}$.",
         r"7.1 Určete, o kolik cm se liší obvod lichoběžníku $EFGH$ a obvod obdélníku $ABCD$.",
         r"7.2 Vypočtěte v cm délku strany $AB$ obdélníku $ABCD$.",
         r"7.3 Vypočtěte v cm$^2$ obsah lichoběžníku $EFGH$."],
    solp=[r"Pravoúhlý trojúhelník má odvěsny $8\ \mathrm{cm}$ a $6\ \mathrm{cm}$ (neboť $\sqrt{10^2-8^2}=\sqrt{36}=6$) a přeponu (rameno) $10\ \mathrm{cm}$.",
          r"7.2: obdélník tvoří tři sloupce po $6\ \mathrm{cm}$, tedy $AB=3\cdot6=18\ \mathrm{cm}$ (výška je $8\ \mathrm{cm}$).",
          r"7.3: přemístěním trojúhelníku se obsah nemění, $S=18\cdot8=144\ \mathrm{cm}^2$.",
          r"7.1: obvod obdélníku $=2\cdot(18+8)=52\ \mathrm{cm}$. Lichoběžník má výšku $8\ \mathrm{cm}$ a obě ramena $10\ \mathrm{cm}$; součet obou rovnoběžných stran $=\frac{2\cdot144}{8}=36\ \mathrm{cm}$, obvod $=36+2\cdot10=56\ \mathrm{cm}$. Liší se o $56-52=4\ \mathrm{cm}$."],
    ans=r"7.1: o $4\ \mathrm{cm}$; 7.2: $18\ \mathrm{cm}$; 7.3: $144\ \mathrm{cm}^2$",
    svg=fig(3, (105, 445, 470, 540)), fn=FN,
    alt="Obdélník ABCD rozdělený na šest shodných pravoúhlých trojúhelníků a lichoběžník EFGH vytvořený přemístěním jednoho z nich; jeden trojúhelník je zvýrazněn.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 8", pts=3, mins=4, diff="2",
    zad=[r"8.1 Chlapec klusal po pláži rovnoměrným tempem. Za $1$ hodinu tak překonal vzdálenost $7{,}5\ \mathrm{km}$. Vypočtěte, kolik metrů uběhl za $2$ minuty.",
         r"8.2 V trojúhelníku $ABC$ pro velikosti dvou vnitřních úhlů platí $\alpha=\beta=45^\circ\,45'$. Vypočtěte velikost třetího vnitřního úhlu $\gamma$.",
         r"8.3 Plocha o rozloze $90\,000\ \mathrm{m}^2$ je rozdělena na $36$ shodných čtverců. Určete v metrech délku strany jednoho čtverce."],
    solp=[r"8.1: $7{,}5\ \mathrm{km}=7\,500\ \mathrm{m}$ za $60$ minut, tj. $125\ \mathrm{m}$ za minutu; za $2$ minuty $250\ \mathrm{m}$.",
          r"8.2: $\alpha+\beta=45^\circ45'+45^\circ45'=91^\circ30'$; $\gamma=180^\circ-91^\circ30'=88^\circ30'$ (tj. $88{,}5^\circ$).",
          r"8.3: obsah jednoho čtverce $=\frac{90\,000}{36}=2\,500\ \mathrm{m}^2$; strana $=\sqrt{2\,500}=50\ \mathrm{m}$."],
    ans=r"8.1: $250\ \mathrm{m}$; 8.2: $\gamma=88^\circ30'$ (resp. $88{,}5^\circ$); 8.3: $50\ \mathrm{m}$",
    codes=["zs2", "r9", "vypocet", "uhly", "aritmetika", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 9", pts=2, mins=5, diff="3",
    zad=[r"V rovině leží obdélník $ABCD$, bod $X$, který je vnitřním bodem strany $AD$, a bod $Y$, který je vnitřním bodem strany $CD$.",
         r"Sestrojte kružnici $k$, na níž leží vrcholy pravoúhlého trojúhelníku $DXY$. Střed kružnice označte $S$."],
    solp=[r"Trojúhelník $DXY$ má pravý úhel při vrcholu $D$ (roh obdélníku, $AD\perp CD$). Vrcholy pravoúhlého trojúhelníku leží na Thaletově kružnici sestrojené nad přeponou; přepona je úsečka $XY$.",
          r"Sestrojíme střed úsečky $XY$, označíme jej $S$, a narýsujeme kružnici $k$ se středem $S$ a poloměrem $\frac{|XY|}{2}$; ta prochází body $D$, $X$, $Y$."],
    ans=r"Kružnice $k$ je Thaletova kružnice nad přeponou $XY$ se středem $S$ ve středu úsečky $XY$ (prochází body $D$, $X$, $Y$).",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 10", pts=3, mins=7, diff="4",
    zad=[r"V rovině leží přímka $p$, na níž leží bod $B$, a mimo ni body $X$ a $Y$. Bod $B$ je vrchol obdélníku $ABCD$ a na přímce $p$ leží úhlopříčka $BD$ tohoto obdélníku. Bod $X$ je vnitřní bod strany $AD$ a bod $Y$ vnitřní bod strany $CD$ obdélníku $ABCD$.",
         r"Sestrojte chybějící vrcholy $D$, $A$, $C$ obdélníku $ABCD$ a obdélník narýsujte."],
    solp=[r"Strany $AD$ a $CD$ jsou na sebe kolmé a procházejí po řadě body $X$ a $Y$. Z vrcholu $D$ je tedy úsečka $XY$ vidět pod pravým úhlem — $D$ leží na Thaletově kružnici nad úsečkou $XY$. Vrchol $D$ získáme jako průsečík této Thaletovy kružnice s přímkou $p$.",
          r"Přímka $DX$ nese stranu $AD$, přímka $DY$ nese stranu $CD$. Úhly při vrcholech $A$ a $C$ jsou pravé, proto $A$ i $C$ leží na Thaletově kružnici nad úhlopříčkou $BD$: $A$ je průsečík přímky $DX$ s touto kružnicí, $C$ je průsečík přímky $DY$ s touto kružnicí. Obdélník $ABCD$ narýsujeme."],
    ans=r"$D$ = průsečík přímky $p$ s Thaletovou kružnicí nad $XY$; $A$, $C$ = průsečíky přímek $DX$, $DY$ s Thaletovou kružnicí nad úhlopříčkou $BD$.",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 11", pts=4, mins=4, diff="3",
    zad=[r"Naši koně mají zásobu ovsa na $12$ dnů. Soused má o polovinu větší zásobu ovsa než my, ale dvakrát více koní. Každý kůň (náš i sousedův) dostává denně stejné množství ovsa.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 Sousedovy zásoby ovsa by našim koním vydržely na $24$ dnů.",
         r"11.2 Naše zásoby ovsa by sousedovým koním vydržely na $6$ dnů.",
         r"11.3 Sousedovy zásoby ovsa vydrží jeho koním na $9$ dnů."],
    solp=[r"Označme počet našich koní $h$ a denní dávku na jednoho koně $1$. Naše zásoba $=12h$. Sousedova zásoba $=1{,}5\cdot12h=18h$, sousedových koní $=2h$.",
          r"11.1: $18h$ pro naše koně ($h$) vydrží $18$ dnů, ne $24$ — \textbf{N}.",
          r"11.2: $12h$ pro sousedovy koně ($2h$) vydrží $6$ dnů — \textbf{A}.",
          r"11.3: $18h$ pro sousedovy koně ($2h$) vydrží $9$ dnů — \textbf{A}."],
    ans=r"11.1: N; 11.2: A; 11.3: A",
    codes=["zs2", "r9", "slovni", "uvazovani", "aritmetika", "pomer", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 12", pts=2, mins=3, diff="3",
    zad=[r"Model vozidla má na každé straně za sebou tři kolečka s poloměrem $1\ \mathrm{cm}$, přes která je natažen pás. Vzdálenost středů každých dvou sousedních koleček na téže straně vozidla je $3\ \mathrm{cm}$.",
         r"Jaká je délka jednoho pásu? Výsledek v mm je zaokrouhlen na celé číslo."],
    solp=[r"Pás tvoří dvě přímé části (nahoře a dole), každá délky rovné vzdálenosti krajních středů $2\cdot3=6\ \mathrm{cm}$, a dva půlkruhové oblouky kolem krajních koleček, které dohromady tvoří celou kružnici o poloměru $1\ \mathrm{cm}$.",
          r"Délka $=2\cdot6+2\pi\cdot1=12+2\pi\doteq12+6{,}28=18{,}28\ \mathrm{cm}=182{,}8\ \mathrm{mm}\doteq183\ \mathrm{mm}$, což je více než $180\ \mathrm{mm}$."],
    ans=r"A) větší než $180\ \mathrm{mm}$",
    opts=[r"A) větší než $180\ \mathrm{mm}$", r"B) $180\ \mathrm{mm}$", r"C) $176\ \mathrm{mm}$", r"D) $163\ \mathrm{mm}$", r"E) $151\ \mathrm{mm}$"],
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "vyber", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 13", pts=2, mins=3, diff="2",
    zad=[r"Dřevěný kvádr s rozměry $5\ \mathrm{cm}$, $4\ \mathrm{cm}$ a $5\ \mathrm{cm}$ má hmotnost $50\ \mathrm{g}$. V kvádru byl vytvořen skrz naskrz otvor tvaru krychle s hranou délky $4\ \mathrm{cm}$ (otvor prochází kvádrem ve směru hrany délky $4\ \mathrm{cm}$).",
         r"Jaký objem má nově vytvořené těleso?"],
    solp=[r"Objem kvádru $=5\cdot4\cdot5=100\ \mathrm{cm}^3$. Odebraný otvor je krychle o hraně $4\ \mathrm{cm}$, tj. $4\cdot4\cdot4=64\ \mathrm{cm}^3$. Nové těleso má objem $100-64=36\ \mathrm{cm}^3$."],
    ans=r"D) $36\ \mathrm{cm}^3$",
    opts=[r"A) $25\ \mathrm{cm}^3$", r"B) $30\ \mathrm{cm}^3$", r"C) $32\ \mathrm{cm}^3$", r"D) $36\ \mathrm{cm}^3$", r"E) jiný objem"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 14", pts=2, mins=3, diff="3",
    zad=[r"Dřevěný kvádr s rozměry $5\ \mathrm{cm}$, $4\ \mathrm{cm}$ a $5\ \mathrm{cm}$ má hmotnost $50\ \mathrm{g}$. Skrz naskrz je v něm vytvořen otvor tvaru krychle s hranou délky $4\ \mathrm{cm}$ (objem otvoru $64\ \mathrm{cm}^3$).",
         r"O kolik gramů se snížila hmotnost kvádru po vytvoření otvoru?"],
    solp=[r"Hustota dřeva $=\frac{50\ \mathrm{g}}{100\ \mathrm{cm}^3}=0{,}5\ \mathrm{g/cm}^3$. Odebraný objem je $64\ \mathrm{cm}^3$, úbytek hmotnosti $=64\cdot0{,}5=32\ \mathrm{g}$."],
    ans=r"D) o $32\ \mathrm{g}$",
    opts=[r"A) o $16\ \mathrm{g}$", r"B) o $20\ \mathrm{g}$", r"C) o $25\ \mathrm{g}$", r"D) o $32\ \mathrm{g}$", r"E) o $36\ \mathrm{g}$"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "vyber", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 15", pts=6, mins=7, diff="4",
    zad=[r"Pavel za hodinu vydělal $300\ \mathrm{Kč}$, Václav o třetinu více než Pavel. Václav odpracoval celkem $60$ hodin, což je o třetinu méně hodin, než odpracoval Pavel.",
         r"Přiřaďte ke každé otázce (15.1–15.3) správnou odpověď (A–F).",
         r"15.1 O kolik procent méně vydělal za hodinu Pavel než Václav?",
         r"15.2 O kolik procent více hodin odpracoval Pavel než Václav?",
         r"15.3 O kolik procent více si celkem vydělal Pavel než Václav?",
         r"Nabídka: A) o $0\ \%$; B) o $12{,}5\ \%$; C) o $25\ \%$; D) o $33{,}\overline{3}\ \%$; E) o $50\ \%$; F) o jiný počet procent."],
    solp=[r"Pavel za hodinu $300\ \mathrm{Kč}$, Václav $300\cdot\frac{4}{3}=400\ \mathrm{Kč}$. Václav odpracoval $60$ h, což jsou dvě třetiny Pavlových hodin, tedy Pavel $=90$ h. Celkem: Pavel $300\cdot90=27\,000\ \mathrm{Kč}$, Václav $400\cdot60=24\,000\ \mathrm{Kč}$.",
          r"15.1: $\frac{400-300}{400}=0{,}25=25\ \%$ — \textbf{C}.",
          r"15.2: $\frac{90-60}{60}=0{,}5=50\ \%$ — \textbf{E}.",
          r"15.3: $\frac{27\,000-24\,000}{24\,000}=0{,}125=12{,}5\ \%$ — \textbf{B}."],
    ans=r"15.1: C; 15.2: E; 15.3: B",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2018 M9I · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Obdélník budeme opakovaně zvětšovat tak, že stranu, která je v daném okamžiku kratší, prodloužíme o $3\ \mathrm{cm}$ a delší stranu jen o $1\ \mathrm{cm}$. Po třetím prodloužení se vytvoří obdélník s rozměry $11\ \mathrm{cm}$ a $12\ \mathrm{cm}$. Strana, která byla na počátku kratší, zůstane kratší po prvním, druhém i třetím prodloužení.",
         r"16.1 Určete rozměry původního obdélníku.",
         r"16.2 Určete rozměry obdélníku po pátém prodloužení.",
         r"16.3 Určete rozměry obdélníku po sto pátém prodloužení."],
    solp=[r"Za každé prodloužení roste kratší strana o $3\ \mathrm{cm}$ a delší o $1\ \mathrm{cm}$. Po $3$ prodlouženích je kratší $s+9$ a delší $l+3$; z rozměrů $11$ a $12$ (kratší zůstala kratší) plyne $s+9=11$ a $l+3=12$, tedy $s=2$, $l=9$.",
          r"16.1: rozměry původního obdélníku jsou $2\ \mathrm{cm}$ a $9\ \mathrm{cm}$.",
          r"16.2: postupně $(2;9)\to(5;10)\to(8;11)\to(11;12)\to(14;13)\to(16;15)$. Po pátém prodloužení má obdélník rozměry $15\ \mathrm{cm}$ a $16\ \mathrm{cm}$.",
          r"16.3: od třetího prodloužení se rozměry liší o $1\ \mathrm{cm}$ a jejich součet roste o $4\ \mathrm{cm}$ za krok. Součet po $n$ prodlouženích je $11+4n$; pro $n=105$ je $11+420=431$, strany jsou $\frac{431-1}{2}=215$ a $\frac{431+1}{2}=216$. Rozměry jsou $215\ \mathrm{cm}$ a $216\ \mathrm{cm}$."],
    ans=r"16.1: $2\ \mathrm{cm}$, $9\ \mathrm{cm}$; 16.2: $15\ \mathrm{cm}$, $16\ \mathrm{cm}$; 16.3: $215\ \mathrm{cm}$, $216\ \mathrm{cm}$",
    codes=["zs2", "r9", "posloupnosti", "slovni", "uvazovani", "vypocet", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9I-2018")
for path, size, names in written:
    print("%s  %d B  (%d úloh)" % (path, size, len(names)))
