# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9B 2019 (2. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9B_2019_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2019, 2. řádný termín (M9B)"
CCODE = "M9PBD19C0T02"
YR = 2019
FN = "obr.svg"

# The úloha 12 figure labels its angles with a symbol font whose φ/α/β map to
# private code points; remap them to real Greek Unicode so the figure renders.
GREEK = {"߮": "φ", "ߙ": "α", "ߚ": "β"}


def fig(pi, rect, remap=None):
    s = region_svg(PDF, pi, rect)
    if remap:
        for a, b in remap.items():
            s = s.replace(a, b)
    return s


P = []

P.append(dict(
    name="CERMAT 2019 M9B · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte, kolik procent z $20$ tun tvoří $500$ kilogramů."],
    solp=[r"$20\ \mathrm{t}=20\,000\ \mathrm{kg}$; $\frac{500}{20\,000}=0{,}025=2{,}5\ \%$."],
    ans=r"$2{,}5\ \%$",
    codes=["zs2", "r9", "procenta", "aritmetika", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 2", pts=2, mins=3, diff="2",
    zad=[r"Vypočtěte:",
         r"2.1 \quad $\sqrt{10^2\cdot0{,}002\,5}=$",
         r"2.2 \quad $5:0{,}2-(-0{,}3+0{,}5)=$"],
    solp=[r"2.1: $\sqrt{100\cdot0{,}002\,5}=\sqrt{0{,}25}=0{,}5$.",
          r"2.2: $5:0{,}2-0{,}2=25-0{,}2=24{,}8$."],
    ans=r"2.1: $0{,}5$; 2.2: $24{,}8$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{1-\frac{1}{3}}{-6^2}=$",
         r"3.2 \quad $12\cdot\left(\dfrac{2}{3}-\dfrac{1}{2}\right)-\dfrac{5}{2}+\dfrac{2}{3}=$"],
    solp=[r"3.1: čitatel $1-\frac{1}{3}=\frac{2}{3}$; jmenovatel $-6^2=-36$; $\frac{2}{3}:(-36)=\frac{2}{-108}=-\frac{1}{54}$.",
          r"3.2: $12\cdot\left(\frac{4}{6}-\frac{3}{6}\right)-\frac{5}{2}+\frac{2}{3}=12\cdot\frac{1}{6}-\frac{5}{2}+\frac{2}{3}=2-\frac{5}{2}+\frac{2}{3}=\frac{12-15+4}{6}=\frac{1}{6}$."],
    ans=r"3.1: $-\frac{1}{54}$; 3.2: $\frac{1}{6}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"Zjednodušte (výsledný výraz nesmí obsahovat závorky):",
         r"4.1 \quad $(2a+3b)^2=$",
         r"4.2 \quad $3e\cdot(2-f)-2f\cdot(e-3f)=$",
         r"4.3 \quad $(1+3n)\cdot(1+3n)+(1+3n)\cdot(1-3n)-2=$"],
    solp=[r"4.1: $(2a+3b)^2=4a^2+12ab+9b^2$.",
          r"4.2: $6e-3ef-2ef+6f^2=6e-5ef+6f^2$.",
          r"4.3: $(1+3n)^2+(1-9n^2)-2=1+6n+9n^2+1-9n^2-2=6n$."],
    ans=r"4.1: $4a^2+12ab+9b^2$; 4.2: $6e-5ef+6f^2$; 4.3: $6n$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $2\cdot(3-0{,}75x)+x=7-\dfrac{x}{2}$",
         r"5.2 \quad $\dfrac{5}{6}\cdot(y-2)-\dfrac{2}{3}\cdot y=\dfrac{y}{2}-\dfrac{5}{4}$"],
    solp=[r"5.1: levá strana $6-1{,}5x+x=6-0{,}5x$; rovnice $6-0{,}5x=7-0{,}5x\Rightarrow6=7$, což neplatí — rovnice nemá řešení.",
          r"5.2: levá strana $\frac{5y}{6}-\frac{10}{6}-\frac{2y}{3}=\frac{y}{6}-\frac{5}{3}$; rovnice $\frac{y}{6}-\frac{5}{3}=\frac{y}{2}-\frac{5}{4}$; vynásobíme $12$: $2y-20=6y-15\Rightarrow-5=4y\Rightarrow y=-\frac{5}{4}=-1{,}25$."],
    ans=r"5.1: rovnice nemá řešení; 5.2: $y=-1{,}25$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 6", pts=4, mins=7, diff="4",
    zad=[r"Zadaná práce byla rozdělena na dvě stejné části. První polovinu práce vykonal minibagr za $10$ hodin. Druhou polovinu práce pak vykonali společně $4$ dělníci.",
         r"Přitom minibagr udělá za každých $5$ hodin stejný díl práce jako $5$ dělníků za $8$hodinovou pracovní dobu. (Každý dělník vykoná za hodinu stejné množství práce.)",
         r"Za půjčení $1$ minibagru se platí jednorázový poplatek $1\,500$ korun. Každá hodina práce minibagru (i s obsluhou) stojí $600$ korun, hodina práce $1$ dělníka $150$ korun.",
         r"6.1 Vypočtěte, kolik korun se celkem zaplatilo za půjčení a práci minibagru (i s obsluhou).",
         r"6.2 Vypočtěte, kolik korun stála práce vykonaná dělníky.",
         r"6.3 Vypočtěte, kolik hodin musel odpracovat každý ze $4$ dělníků."],
    solp=[r"6.1: minibagr pracoval $10$ hodin; $1\,500+10\cdot600=1\,500+6\,000=7\,500$ korun.",
          r"6.2: za $5$ hodin udělá minibagr práci $5\cdot8=40$ dělníkohodin, tedy za $10$ hodin $80$ dělníkohodin — to je první polovina. Druhá polovina je rovněž $80$ dělníkohodin; cena $80\cdot150=12\,000$ korun.",
          r"6.3: $80$ dělníkohodin vykonají $4$ dělníci, každý $\frac{80}{4}=20$ hodin."],
    ans=r"6.1: $7\,500$ korun; 6.2: $12\,000$ korun; 6.3: $20$ hodin",
    codes=["zs2", "r9", "aritmetika", "rovnice", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 7", pts=3, mins=5, diff="4",
    zad=[r"Nájezdová rampa sestavená ze čtyř dřevotřískových desek je přistavena ke schodu. Nakloněnou čtvercovou desku rampy podpírají tři stejné trojúhelníkové desky. Hloubka rampy je $12\ \mathrm{dm}$ a výška rampy je $5\ \mathrm{dm}$. Trojúhelníkové desky jsou pravoúhlé trojúhelníky s odvěsnami $5\ \mathrm{dm}$ (výška) a $12\ \mathrm{dm}$ (hloubka); nakloněná deska je čtverec. Tloušťku desky neuvažujte.",
         r"Vypočtěte, kolik dm$^2$ dřevotřísky je v hotové rampě použito",
         r"7.1 na všechny tři trojúhelníkové desky dohromady,",
         r"7.2 na čtvercovou desku."],
    solp=[r"7.1: jedna trojúhelníková deska má obsah $\frac{1}{2}\cdot5\cdot12=30\ \mathrm{dm}^2$; tři desky $3\cdot30=90\ \mathrm{dm}^2$.",
          r"7.2: strana nakloněné čtvercové desky je přepona trojúhelníku $\sqrt{5^2+12^2}=\sqrt{169}=13\ \mathrm{dm}$; obsah čtverce $13^2=169\ \mathrm{dm}^2$."],
    ans=r"7.1: $90\ \mathrm{dm}^2$; 7.2: $169\ \mathrm{dm}^2$",
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "vypocet", "slovni", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 8", pts=3, mins=4, diff="3",
    zad=[r"Čtverec je rozdělen čtyřmi svislými úsečkami a jednou vodorovnou úsečkou na $10$ shodných malých obdélníků (viz obrázek). Každý z malých obdélníků má obvod $42\ \mathrm{cm}$.",
         r"8.1 Vyjádřete v základním tvaru poměr délek sousedních stran jednoho malého obdélníku.",
         r"8.2 Vypočtěte v cm délku strany čtverce."],
    solp=[r"8.1: čtverec o straně $a$ je rozdělen na $5$ sloupců a $2$ řady, malý obdélník má rozměry $\frac{a}{5}$ a $\frac{a}{2}$; poměr $\frac{a}{5}:\frac{a}{2}=2:5$.",
          r"8.2: obvod malého obdélníku $2\left(\frac{a}{5}+\frac{a}{2}\right)=2\cdot\frac{7a}{10}=\frac{7a}{5}=42\Rightarrow a=30\ \mathrm{cm}$."],
    ans=r"8.1: $2:5$ (příp. $5:2$); 8.2: $30\ \mathrm{cm}$",
    svg=fig(4, (78, 114, 176, 204)), fn=FN,
    alt="Čtverec rozdělený čtyřmi svislými a jednou vodorovnou úsečkou na 10 shodných malých obdélníků (5 sloupců, 2 řady).", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "pomer", "obvod", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 9", pts=2, mins=5, diff="3",
    zad=[r"V rovině leží bod $B$ a přímka $p$, která prochází bodem $A$ (viz obrázek).",
         r"Body $A$, $B$ jsou vrcholy rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Rameno $AC$ leží na přímce $p$.",
         r"Sestrojte a označte písmenem chybějící vrchol $C$ trojúhelníku $ABC$ a trojúhelník narýsujte."],
    solp=[r"Trojúhelník je rovnoramenný se základnou $AB$, tedy $|CA|=|CB|$ — vrchol $C$ leží na ose úsečky $AB$. Zároveň $C$ leží na přímce $p$ (na ní leží rameno $AC$).",
          r"Vrchol $C$ je proto průsečík přímky $p$ s osou úsečky $AB$; ten spojíme s body $A$ a $B$ a trojúhelník narýsujeme."],
    ans=r"Konstrukce: vrchol $C$ = průsečík přímky $p$ s osou úsečky $AB$ (rovnoramenný trojúhelník $ABC$ se základnou $AB$).",
    svg=fig(4, (150, 425, 472, 668)), fn=FN,
    alt="V rovině leží bod B a přímka p procházející bodem A.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží přímka $p$ a kružnice $k$ se středem $S$. Bod $A$ je jedním ze dvou průsečíků přímky $p$ a kružnice $k$ (viz obrázek).",
         r"Bod $A$ je vrchol čtverce $ABCD$, bod $S$ leží uvnitř tohoto čtverce a na přímce $p$ leží strana $AB$. Právě dva ze čtyř vrcholů čtverce $ABCD$ leží na kružnici $k$.",
         r"Sestrojte a označte písmeny chybějící vrcholy čtverce $ABCD$ a čtverec narýsujte. Najděte všechna řešení."],
    solp=[r"Strana $AB$ leží na přímce $p$, proto je vrchol $B$ druhý průsečík přímky $p$ s kružnicí $k$ (aby $A$ i $B$ ležely na $k$ — to jsou ony dva vrcholy na kružnici). Délka strany je $|AB|$.",
          r"Zbývající vrcholy $C$, $D$ sestrojíme jako kolmice k $AB$ v bodech $B$ a $A$ o délce $|AB|$ na té straně, kde leží střed $S$ (bod $S$ musí být uvnitř čtverce). Úloha vede na jedno řešení splňující všechny podmínky."],
    ans=r"Konstrukce čtverce $ABCD$: $B$ = druhý průsečík $p$ a $k$, vrcholy $C$, $D$ kolmo k $AB$ na straně bodu $S$.",
    svg=fig(5, (118, 132, 435, 402)), fn=FN,
    alt="V rovině leží přímka p a kružnice k se středem S; bod A je jedním ze dvou průsečíků přímky p a kružnice k.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 11", pts=4, mins=6, diff="4",
    zad=[r"Do tabulky se zapisují počty telefonních hovorů tří dětí (Aleš, Běla, Cyril) v prvním čtvrtletí kalendářního roku; některé údaje chybí. Známé údaje: Aleš měl v březnu $12$ hovorů; Běla měla v únoru $12$ hovorů; Cyril měl v únoru $9$ hovorů a jeho aritmetický průměr za měsíc je $9$; součet hovorů všech tří dětí v lednu je $36$.",
         r"V lednu měly všechny tři děti stejný počet hovorů. Aleš měl v březnu o třetinu hovorů méně než v únoru. Běla měla v březnu o polovinu hovorů více než v únoru.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 V prvním čtvrtletí byl aritmetický průměr počtu hovorů Aleše za měsíc menší než $14$.",
         r"11.2 Běla měla za první čtvrtletí celkem $42$ hovorů.",
         r"11.3 V březnu měl Cyril třikrát méně hovorů než Běla."],
    solp=[r"V lednu všichni stejně: $36:3=12$ hovorů každý. Aleš: březen $12=\frac{2}{3}\cdot$ únor $\Rightarrow$ únor $=18$; průměr Aleše $\frac{12+18+12}{3}=14$. Běla: březen $=\frac{3}{2}\cdot12=18$; součet $12+12+18=42$. Cyril: průměr $9\Rightarrow$ součet $27$; březen $27-12-9=6$.",
          r"11.1: průměr Aleše $=14$, není menší než $14$ — \textbf{N}.",
          r"11.2: Běla má $42$ hovorů — \textbf{A}.",
          r"11.3: Cyril v březnu $6$, Běla $18$; $18:3=6$ — \textbf{A}."],
    ans=r"11.1: N; 11.2: A; 11.3: A",
    codes=["zs2", "r9", "aritmetika", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"V trojúhelníku (viz obrázek) je vrcholový úhel rozdělen dvěma vnitřními úsečkami na tři shodné úhly $\varphi$. Levá z těchto úseček je výška trojúhelníku (v patě svírá s podstavou pravý úhel). Pravá vnitřní úsečka svírá s podstavou (směrem doprava) úhel $116^\circ$. Úhel při levém vrcholu podstavy je $\alpha$, při pravém vrcholu $\beta$.",
         r"Kolik je $\alpha+\beta$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"U paty pravé úsečky je $116^\circ$, tedy vnitřní úhel v pravoúhlém trojúhelníku (výška–pravá úsečka) je $180^\circ-116^\circ=64^\circ$, a proto $\varphi=90^\circ-64^\circ=26^\circ$.",
          r"Levý díl: v pravoúhlém trojúhelníku s výškou je $\alpha=90^\circ-\varphi=90^\circ-26^\circ=64^\circ$.",
          r"Pravý díl: v trojúhelníku s úhlem $116^\circ$ a vrcholovým dílem $\varphi=26^\circ$ je $\beta=180^\circ-116^\circ-26^\circ=38^\circ$.",
          r"$\alpha+\beta=64^\circ+38^\circ=102^\circ$."],
    ans=r"C) $102^\circ$",
    opts=[r"A) $90^\circ$", r"B) $92^\circ$", r"C) $102^\circ$", r"D) $112^\circ$", r"E) jiný výsledek"],
    svg=fig(6, (78, 528, 258, 625), remap=GREEK), fn=FN,
    alt="Trojúhelník s vrcholovým úhlem rozděleným na tři shodné úhly φ; levá vnitřní úsečka je výška (pravý úhel u paty), pravá svírá s podstavou úhel 116°; úhly α a β jsou při vrcholech podstavy.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Rotační válec s podstavou o poloměru $5\ \mathrm{cm}$ stojící na vodorovné podložce jsme svislými řezy rozdělili na čtyři shodná nová tělesa. Povrch válce byl šedý (včetně podstav), ale všechny nové plochy vytvořené rozříznutím jsou bílé. Součet obsahů obou bílých ploch na jednom z nových těles je $80\ \mathrm{cm}^2$.",
         r"Jaký je objem jednoho z nových těles? Výsledek je zaokrouhlen na celé cm$^3$."],
    solp=[r"Dvěma svislými řezy osou válce vznikne čtvrtina válce. Obě bílé plochy jsou obdélníky $r\times v$, tedy $2\cdot(5\cdot v)=80\Rightarrow10v=80\Rightarrow v=8\ \mathrm{cm}$.",
          r"Objem jednoho tělesa (čtvrtina válce) $=\frac{1}{4}\pi r^2 v=\frac{1}{4}\pi\cdot25\cdot8=50\pi\doteq157\ \mathrm{cm}^3$."],
    ans=r"D) $157\ \mathrm{cm}^3$",
    opts=[r"A) menší než $125\ \mathrm{cm}^3$", r"B) $126\ \mathrm{cm}^3$", r"C) $141\ \mathrm{cm}^3$", r"D) $157\ \mathrm{cm}^3$", r"E) větší než $158\ \mathrm{cm}^3$"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 14", pts=2, mins=3, diff="3",
    zad=[r"Kryštof, Lenka a Marek sbírali do čtvrtlitrových hrnků borůvky. Kryštof naplnil borůvkami třikrát více hrnků než Marek. Lenka naplnila borůvkami o $50\ \%$ méně hrnků než Kryštof. Kryštof naplnil borůvkami o $2$ hrnky více než Lenka s Markem dohromady.",
         r"Označme $m$ neznámý počet hrnků, které naplnil borůvkami Marek. Ze které z následujících rovnic lze v souladu se zadáním vypočítat $m$?"],
    solp=[r"Kryštof $=3m$, Lenka $=0{,}5\cdot3m=1{,}5m$. Podmínka „o $2$ více než Lenka a Marek dohromady“: $3m=1{,}5m+m+2$, tj. $3m=2{,}5m+2$."],
    ans=r"A) $3m=2{,}5m+2$",
    opts=[r"A) $3m=2{,}5m+2$", r"B) $3m+2=2{,}5m$", r"C) $3m-2=2m+0{,}5$", r"D) $3m=2{,}5m+2{,}5$", r"E) $3m-2=2m+50$"],
    codes=["zs2", "r9", "rovnice", "algebra", "slovni", "vyber", "uvazovani", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 V obchodě, v němž byla $20\ \%$ sleva na veškeré zboží, Kamila zaplatila $400$ korun. Kolik korun by zaplatila, kdyby nedostala žádnou slevu?",
         r"15.2 Svetr zdražili o $25\ \%$ a po čase jej zlevnili na $600$ korun, tedy na $80\ \%$ ceny svetru po zdražení. Kolik korun stál svetr ještě před zdražením?",
         r"15.3 V obou kapsách mám stejné množství peněz. Nejprve polovinu částky z levé kapsy přendám do pravé kapsy. Když pak dám $50\ \%$ částky z pravé kapsy opět do levé kapsy, v levé kapse budu mít $300$ korun. Kolik korun mám dohromady v obou kapsách?",
         r"Nabídka: A) $320$ korun; B) $480$ korun; C) $500$ korun; D) $540$ korun; E) $600$ korun; F) jiný počet korun."],
    solp=[r"15.1: $400$ je $80\ \%$ původní ceny; $400:0{,}8=500$ korun — \textbf{C}.",
          r"15.2: cena po zdražení $600:0{,}8=750$ korun; před zdražením $750:1{,}25=600$ korun — \textbf{E}.",
          r"15.3: každá kapsa $x$. Přesun: levá $\frac{x}{2}$, pravá $\frac{3x}{2}$; poté z pravé $50\ \%$ zpět: levá $\frac{x}{2}+\frac{3x}{4}=\frac{5x}{4}=300\Rightarrow x=240$; dohromady $2x=480$ korun — \textbf{B}."],
    ans=r"15.1: C; 15.2: E; 15.3: B",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9B · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Při spuštění programu je obrazovka prázdná. Při každém pípnutí se situace mění: při každém lichém pípnutí se objeví $2$ nové svislé čárky, při každém sudém pípnutí se objeví $2$ nové pomlčky. Při každém čtvrtém pípnutí však jedna nová pomlčka překříží jednu čárku na obrazovce a místo nich vidíme jeden symbol „plus“.",
         r"Na obrazovce tak mohou být tři různé symboly: „čárka“, „pomlčka“ a „plus“. Počty symbolů: po 1. pípnutí $2$ čárky; po 2. pípnutí $2$ čárky a $2$ pomlčky; po 3. pípnutí $4$ čárky a $2$ pomlčky; po 4. pípnutí $3$ čárky, $3$ pomlčky a $1$ plus (celkem $7$); po 5. pípnutí $5$ čárek, $3$ pomlčky a $1$ plus (celkem $9$); atd.",
         r"Určete, jaký je na obrazovce počet",
         r"16.1 symbolů „pomlčka“ při 10. pípnutí,",
         r"16.2 všech symbolů při 60. pípnutí,",
         r"16.3 symbolů „čárka“ právě ve chvíli, kdy se objevil 7. symbol „plus“."],
    solp=[r"16.1: pomlčky přibývají při sudých pípnutích; do 10. pípnutí jsou sudá $2,4,6,8,10$. U čtvrtých ($4,8$) se jedna pomlčka spotřebuje na plus (net $+1$), u ostatních ($2,6,10$) je $+2$. Pomlček $3\cdot2+2\cdot1=8$.",
          r"16.2: každé pípnutí přidá $2$ symboly, ale každé čtvrté jen $1$ (dva vzniknou, ale čárka s pomlčkou se sloučí v plus). Do $60$: čtvrtých je $15$, ostatních $45$; celkem $45\cdot2+15\cdot1=105$ symbolů.",
          r"16.3: $7$. plus vznikne při $4\cdot7=28$. pípnutí. Čárky: lichá pípnutí $1..27$ (jich $14$) dají $+2$, každé čtvrté ($4,8,\dots,28$, jich $7$) ubere $1$ čárku: $14\cdot2-7=21$."],
    ans=r"16.1: $8$ symbolů „pomlčka“; 16.2: $105$ symbolů; 16.3: $21$ symbolů „čárka“",
    codes=["zs2", "r9", "posloupnosti", "uvazovani", "vypocet", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9B-2019")
print("WROTE:")
for path, size, names in written:
    print(f"  {path}  {size} B  ({len(names)} úloh)")
