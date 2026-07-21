# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9I 2021 (ilustrační test, 4leté obory)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9I_2021_TS.pdf"
SRC = "CERMAT – Ilustrační test 2021, matematika 9 (čtyřleté obory)"
CCODE = "M9PID21C0T01"
YR = 2021
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2021 M9I · úloha 1", pts=1, mins=2, diff="1",
    zad=[r"Vypočtěte, o kolik se liší druhá mocnina čísla $16$ a druhá odmocnina z čísla $16$."],
    solp=[r"$16^2=256$; $\sqrt{16}=4$; rozdíl $256-4=252$."],
    ans=r"o $252$",
    codes=["zs2", "r9", "aritmetika", "cisla", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 2", pts=2, mins=4, diff="2",
    zad=[r"2.1 \quad Cesta tam trvala $1$ hodinu a $14$ minut. Zpáteční cesta byla o $46$ minut kratší. Vypočtěte v hodinách a minutách, jak dlouho trvala celá cesta (tam i zpět).",
         r"2.2 \quad Když jsme z nádoby zcela naplněné vodou vylili $0{,}12\ \mathrm{m}^3$ vody, v nádobě zbylo ještě $4\,500\ \mathrm{cm}^3$ vody. Vypočtěte v litrech objem nádoby."],
    solp=[r"2.1: cesta tam $=74$ min; zpět $=74-46=28$ min; celkem $74+28=102$ min $=1$ hodina $42$ minut.",
          r"2.2: $0{,}12\ \mathrm{m}^3=120\ \mathrm{l}$; $4\,500\ \mathrm{cm}^3=4{,}5\ \mathrm{l}$; objem $=120+4{,}5=124{,}5\ \mathrm{l}$."],
    ans=r"2.1: $1$ hodina $42$ minut; 2.2: $124{,}5$ litru",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{1}{2}+\dfrac{8}{5}\cdot\left(\dfrac{3}{8}-\dfrac{1}{6}\right)=$",
         r"3.2 \quad $\dfrac{\frac{7}{4}-4}{\,7-\frac{4}{7}\,}=$"],
    solp=[r"3.1: $\frac{3}{8}-\frac{1}{6}=\frac{9-4}{24}=\frac{5}{24}$; $\frac{8}{5}\cdot\frac{5}{24}=\frac{1}{3}$; $\frac{1}{2}+\frac{1}{3}=\frac{5}{6}$.",
          r"3.2: čitatel $\frac{7}{4}-4=-\frac{9}{4}$; jmenovatel $7-\frac{4}{7}=\frac{45}{7}$; $-\frac{9}{4}:\frac{45}{7}=-\frac{9}{4}\cdot\frac{7}{45}=-\frac{7}{20}$."],
    ans=r"3.1: $\frac{5}{6}$; 3.2: $-\frac{7}{20}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 \quad Rozložte na součin: $(4a)^2-9\cdot9=$",
         r"4.2 \quad Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $\left(\dfrac{3y}{2}+2\right)^2=$",
         r"4.3 \quad Zjednodušte a rozložte na součin: $(3n+7)\cdot(-4n+3n)+n\cdot(4n+9)=$"],
    solp=[r"4.1: $(4a)^2-9\cdot9=16a^2-81=(4a-9)(4a+9)$.",
          r"4.2: $\left(\frac{3y}{2}\right)^2+2\cdot\frac{3y}{2}\cdot2+2^2=\frac{9y^2}{4}+6y+4$.",
          r"4.3: $(3n+7)\cdot(-n)+n(4n+9)=-3n^2-7n+4n^2+9n=n^2+2n=n(n+2)$."],
    ans=r"4.1: $(4a-9)(4a+9)$; 4.2: $\frac{9y^2}{4}+6y+4$; 4.3: $n(n+2)$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $2{,}5\cdot(2x-0{,}4)+x=2{,}5x+0{,}4$",
         r"5.2 \quad $y-\dfrac{2-5y}{10}=\dfrac{5y-8}{15}-2$"],
    solp=[r"5.1: $5x-1+x=2{,}5x+0{,}4\Rightarrow6x-1=2{,}5x+0{,}4\Rightarrow3{,}5x=1{,}4\Rightarrow x=0{,}4$.",
          r"5.2: vynásobíme $30$: $30y-3(2-5y)=2(5y-8)-60\Rightarrow30y-6+15y=10y-16-60\Rightarrow45y-6=10y-76\Rightarrow35y=-70\Rightarrow y=-2$."],
    ans=r"5.1: $x=0{,}4$; 5.2: $y=-2$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 6", pts=2, mins=5, diff="3",
    zad=[r"Na záhonu je v každém z $10$ řádků stejný počet květin. První květina ve druhém a každém dalším řádku je vždy na úrovni druhé květiny předchozího řádku (každý řádek je oproti předchozímu posunut o jeden rozestup doprava). Rozestupy mezi sousedními květinami v řádcích i ve sloupcích jsou stejné. Květiny v $1.$ a $10.$ řádku, které jsou ve stejném sloupci, mají vzdálenost $270\ \mathrm{cm}$. Předposlední květina v $1.$ řádku je ve stejném sloupci jako druhá květina v $10.$ řádku. (Při výpočtech rozměry květin zanedbáváme.)",
         r"6.1 \quad Vypočtěte v cm rozestup mezi sousedními květinami.",
         r"6.2 \quad Vypočtěte počet květin vysázených v jednom řádku."],
    solp=[r"6.1: mezi $1.$ a $10.$ řádkem je $9$ rozestupů, tedy rozestup $=270:9=30\ \mathrm{cm}$.",
          r"6.2: $10.$ řádek je posunut o $9$ rozestupů; jeho druhá květina je ve sloupci $9+2=11$. Předposlední (tj. $(n-1).$) květina $1.$ řádku je ve sloupci $n-1$, proto $n-1=11\Rightarrow n=12$ květin."],
    ans=r"6.1: $30\ \mathrm{cm}$; 6.2: $12$ květin",
    codes=["zs2", "r9", "posloupnosti", "aritmetika", "slovni", "uvazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 7", pts=3, mins=5, diff="3",
    zad=[r"Dvě bagety a $5$ housek váží o $480$ gramů více než $1$ bageta, ale o $40$ gramů méně než $3$ bagety. Všechny bagety jsou stejné, rovněž housky jsou stejné. Vypočtěte, kolik gramů váží",
         r"7.1 \quad bageta,",
         r"7.2 \quad houska."],
    solp=[r"Nechť $b$ je hmotnost bagety, $h$ housky. $2b+5h=b+480$ a $2b+5h=3b-40$.",
          r"Z druhé rovnice $5h=b-40$; dosazením do $b+5h=480$: $b+(b-40)=480\Rightarrow2b=520\Rightarrow b=260\ \mathrm{g}$.",
          r"Pak $5h=260-40=220\Rightarrow h=44\ \mathrm{g}$."],
    ans=r"7.1: $260$ gramů; 7.2: $44$ gramů",
    codes=["zs2", "r9", "rovnice", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 8", pts=4, mins=6, diff="3",
    zad=[r"Obdélník ABCD má stranu BC délky $8\ \mathrm{cm}$. Na straně CD leží bod E. Obdélník je rozdělen úsečkami BE a BD na tři trojúhelníky. Obsahy trojúhelníků BCE a BED jsou stejné, a to $24\ \mathrm{cm}^2$ (viz obrázek). Vypočtěte",
         r"8.1 \quad v cm$^2$ obsah lichoběžníku ABED,",
         r"8.2 \quad v cm obvod lichoběžníku ABED."],
    solp=[r"Trojúhelník BCE má základnu CE a výšku $BC=8$: $\frac{1}{2}\cdot CE\cdot8=24\Rightarrow CE=6\ \mathrm{cm}$.",
          r"Trojúhelník BED má výšku $8$ (vzdálenost B od přímky CD): $\frac{1}{2}\cdot ED\cdot8=24\Rightarrow ED=6\ \mathrm{cm}$, takže $CD=12\ \mathrm{cm}$.",
          r"8.1: obsah obdélníku $=12\cdot8=96\ \mathrm{cm}^2$; lichoběžník ABED $=96-24=72\ \mathrm{cm}^2$.",
          r"8.2: strany $AB=12$, $ED=6$, $DA=8$ a $BE=\sqrt{6^2+8^2}=10\ \mathrm{cm}$; obvod $=12+6+8+10=36\ \mathrm{cm}$."],
    ans=r"8.1: $72\ \mathrm{cm}^2$; 8.2: $36\ \mathrm{cm}$",
    svg=fig(5, (82, 135, 255, 245)), fn=FN,
    alt="Obdélník ABCD se stranou BC = 8 cm, bod E na straně CD; úsečky BD a BE dělí obdélník na trojúhelníky, vyznačen je lichoběžník ABED.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 9", pts=3, mins=7, diff="4",
    zad=[r"V rovině leží přímka $p$ a přímka $a$ procházející bodem A (viz obrázek).",
         r"Bod A je vrchol čtverce ABCD. Na přímce $p$ leží jeden ze zbývajících vrcholů B, C, D tohoto čtverce a strana AB leží na přímce $a$. Celý čtverec leží v jedné polorovině s hraniční přímkou $p$.",
         r"Sestrojte vrcholy B, C, D čtverce ABCD, označte je písmeny a čtverec narýsujte. Najděte všechna $3$ řešení."],
    solp=[r"Postupně předpokládáme, že na přímce $p$ leží vrchol B, C, resp. D. Vrchol B (i C, D) musí ležet na přímce $a$ jen v případě strany AB; obecně využijeme, že úhly čtverce jsou pravé a strany shodné.",
          r"Pro každý ze tří případů sestrojíme kolmice a shodné úsečky (otočení o $90^\circ$ kolem příslušného vrcholu) tak, aby vrchol ležel na $p$ a celý čtverec byl v jedné polorovině s hranicí $p$. Úloha má tři řešení (čtverce ABCD pro polohu B, C, D na $p$).",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce všech tří řešení."],
    ans=r"Konstrukce tří čtverců ABCD (vrchol B, C, resp. D na přímce $p$, strana AB na přímce $a$); tři řešení.",
    svg=fig(6, (160, 120, 490, 415)), fn=FN,
    alt="V rovině leží přímka p a přímka a procházející bodem A; na přímce a je vyznačen bod A.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 10", pts=3, mins=7, diff="4",
    zad=[r"V rovině leží body C, T (viz obrázek).",
         r"Bod C je vrchol rovnoramenného pravoúhlého trojúhelníku ABC s pravým úhlem při vrcholu C. Bod T je těžiště trojúhelníku ABC.",
         r"Sestrojte vrcholy A, B trojúhelníku ABC, označte je písmeny a trojúhelník narýsujte."],
    solp=[r"Přímka CT je osou souměrnosti rovnoramenného trojúhelníku a zároveň leží na těžnici z vrcholu C ke středu $S_{AB}$ přepony AB. Těžiště dělí těžnici v poměru $2:1$, proto $|CS_{AB}|=\frac{3}{2}|CT|$; sestrojíme bod $S_{AB}$ na polopřímce CT za bodem T.",
          r"V pravoúhlém rovnoramenném trojúhelníku je $|CS_{AB}|=\frac{1}{2}|AB|$, tedy $|S_{AB}A|=|S_{AB}B|=|CS_{AB}|$. Bodem $S_{AB}$ vedeme kolmici k CT; na ní ve vzdálenosti $|CS_{AB}|$ od $S_{AB}$ na obě strany leží vrcholy A a B.",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce rovnoramenného pravoúhlého trojúhelníku ABC (pravý úhel u C, T těžiště): $S_{AB}$ na polopřímce CT s $|CS_{AB}|=\frac{3}{2}|CT|$, A a B na kolmici v $S_{AB}$ ve vzdálenosti $|CS_{AB}|$.",
    svg=fig(7, (225, 100, 305, 240)), fn=FN,
    alt="V rovině leží dva body: bod C nahoře a bod T níže a mírně vpravo.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 11", pts=4, mins=6, diff="3",
    zad=[r"Podstavou kolmého pětibokého hranolu je pětiúhelník o obvodu $20\ \mathrm{cm}$ a obsahu $24\ \mathrm{cm}^2$. Všechny hrany hranolu mají stejnou délku (viz obrázek).",
         r"Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).",
         r"11.1 \quad Součet délek všech hran hranolu je $60\ \mathrm{cm}$.",
         r"11.2 \quad Obsah podstavy je o polovinu větší než obsah jedné boční stěny hranolu.",
         r"11.3 \quad Objem hranolu je $96\ \mathrm{cm}^3$."],
    solp=[r"Pětiúhelník má $5$ stran, obvod $20\ \mathrm{cm}\Rightarrow$ hrana $=4\ \mathrm{cm}$; všechny hrany (i výška hranolu) mají $4\ \mathrm{cm}$.",
          r"11.1: hranol má $15$ hran po $4\ \mathrm{cm}$: $15\cdot4=60\ \mathrm{cm}$ — \textbf{A}.",
          r"11.2: boční stěna je čtverec $4\times4=16\ \mathrm{cm}^2$; $16\cdot1{,}5=24=$ obsah podstavy — \textbf{A}.",
          r"11.3: $V=S_{podstavy}\cdot v=24\cdot4=96\ \mathrm{cm}^3$ — \textbf{A}."],
    ans=r"11.1: A; 11.2: A; 11.3: A",
    svg=fig(8, (78, 100, 198, 190)), fn=FN,
    alt="Kolmý pětiboký hranol, jehož podstavou je pětiúhelník; všechny hrany mají stejnou délku.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "uvazovani", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 12", pts=2, mins=4, diff="3",
    zad=[r"V rovnoramenném trojúhelníku ABC má vnitřní úhel při základně AB velikost $70^\circ$. Na straně AC leží vrchol D rovnoramenného trojúhelníku ABD se základnou AD. Uvnitř trojúhelníku je vyznačen úhel $\varphi$ s rameny BC a BD (viz obrázek).",
         r"Jaká je velikost úhlu $\varphi$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"V trojúhelníku ABC jsou úhly při A i B rovny $70^\circ$, tedy $\angle ABC=70^\circ$.",
          r"Trojúhelník ABD má základnu AD, úhel při A je $70^\circ$, proto i $\angle ADB=70^\circ$ a $\angle ABD=180^\circ-140^\circ=40^\circ$.",
          r"$\varphi=\angle DBC=\angle ABC-\angle ABD=70^\circ-40^\circ=30^\circ$."],
    ans=r"A) $30^\circ$",
    opts=[r"A) $30^\circ$", r"B) $35^\circ$", r"C) $40^\circ$", r"D) $45^\circ$", r"E) větší než $45^\circ$"],
    svg=fig(8, (440, 450, 525, 588)), fn=FN,
    alt="Rovnoramenný trojúhelník ABC s úhlem 70° při vrcholu A; bod D na straně AC, uvnitř vyznačen úhel fí s rameny BC a BD.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 13", pts=2, mins=3, diff="2",
    zad=[r"Obdélník ABCD je možné rozdělit na čtyři shodné čtverce v jedné řadě. V každém čtverci je tmavý kruh, který se dotýká všech stran tohoto čtverce. Obvod jednoho tmavého kruhu je $o=\pi\cdot9\ \mathrm{cm}$ (viz obrázek).",
         r"Jaký je obvod obdélníku ABCD?"],
    solp=[r"Z $o=\pi d=\pi\cdot9$ plyne průměr kruhu $d=9\ \mathrm{cm}$, což je i strana čtverce.",
          r"Obdélník má rozměry $4\cdot9=36\ \mathrm{cm}$ a $9\ \mathrm{cm}$; obvod $=2\cdot(36+9)=90\ \mathrm{cm}$."],
    ans=r"E) $90\ \mathrm{cm}$",
    opts=[r"A) menší než $45\ \mathrm{cm}$", r"B) $45\ \mathrm{cm}$", r"C) $60\ \mathrm{cm}$", r"D) $72\ \mathrm{cm}$", r"E) $90\ \mathrm{cm}$"],
    svg=fig(9, (88, 128, 292, 200)), fn=FN,
    alt="Obdélník ABCD rozdělený na čtyři shodné čtverce v řadě, v každém čtverci tmavý kruh vepsaný do čtverce.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 14", pts=2, mins=4, diff="3",
    zad=[r"Celou plochu haly by uklidilo $10$ nepřetržitě pracujících čisticích strojů společně za $12$ hodin. Každý čisticí stroj uklidí za tentýž čas stejně velkou část plochy. V sobotu pracovalo pouze $5$ čisticích strojů a za $18$ hodin uklidilo větší část plochy haly. Zbývající plochu haly uklidily stroje v neděli.",
         r"Kolik procent plochy haly uklidily stroje v neděli?"],
    solp=[r"Celková práce $=10\cdot12=120$ strojhodin.",
          r"V sobotu $5\cdot18=90$ strojhodin, tj. $\frac{90}{120}=75\ \%$ plochy.",
          r"V neděli zbývá $100\ \%-75\ \%=25\ \%$."],
    ans=r"B) $25\ \%$",
    opts=[r"A) méně než $25\ \%$", r"B) $25\ \%$", r"C) $30\ \%$", r"D) $35\ \%$", r"E) více než $35\ \%$"],
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "vyber", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Ve městě jsou tři střední školy. Na školu X se přihlásilo $450$ žáků; přihlášených žáků bylo o $150\ \%$ více než přijatých. Na školu Y se přihlásilo o $50\ \%$ více žáků než na školu X a bylo přijato $40\ \%$ přihlášených žáků. Na školu Z se přihlásilo $300$ žáků, což je o třetinu žáků více, než na ni bylo přijato.",
         r"Přiřaďte ke každé otázce (15.1–15.3) odpovídající odpověď (A–F).",
         r"15.1 \quad Kolik žáků bylo přijato na školu X?",
         r"15.2 \quad Kolik žáků bylo přijato na školu Y?",
         r"15.3 \quad Kolik žáků bylo přijato na školu Z?",
         r"Nabídka: A) $180$; B) $200$; C) $225$; D) $270$; E) $300$; F) jiný počet."],
    solp=[r"15.1: $450$ je $250\ \%$ přijatých, tedy přijato $\frac{450}{2{,}5}=180$ — \textbf{A}.",
          r"15.2: přihlášeno $450\cdot1{,}5=675$; přijato $0{,}4\cdot675=270$ — \textbf{D}.",
          r"15.3: $300=\frac{4}{3}\cdot$ přijatých, tedy přijato $300\cdot\frac{3}{4}=225$ — \textbf{C}."],
    ans=r"15.1: A; 15.2: D; 15.3: C",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9I · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Čtvercová deska má v každé řadě i v každém sloupci $15$ polí. V prvním tahu se položí jeden žeton na prostřední pole desky. Ve druhém a každém dalším tahu se položí po jednom žetonu na všechna neobsazená pole, která svou stranou sousedí s poli obsazenými žetony v předchozích tazích. Teprve po posledním tahu bude ležet na každém poli desky jeden žeton.",
         r"Obsazená pole tvoří „kosočtverec“: bezprostředně po $n$-tém tahu jsou obsazena právě všechna pole, jejichž vzdálenost od prostředního pole (počítáno po krocích vodorovně a svisle) je nejvýše $n-1$.",
         r"Určete,",
         r"16.1 \quad kolik žetonů bude celkem na desce bezprostředně po pátém tahu,",
         r"16.2 \quad kolik žetonů se na desku položí v posledním tahu,",
         r"16.3 \quad kolik neobsazených polí bude na desce bezprostředně po $12.$ tahu."],
    solp=[r"Počet obsazených polí do vzdálenosti $r$ je $2r^2+2r+1$ (dokud kosočtverec nepřesahuje okraj $15\times15$ desky).",
          r"16.1: po $5.$ tahu je $r=4$: $2\cdot16+2\cdot4+1=41$ žetonů.",
          r"16.2: přepona/rohy jsou ve vzdálenosti $7+7=14$ od středu, poslední je $15.$ tah. V $15.$ tahu se obsadí jen $4$ rohová pole (jediná ve vzdálenosti $14$): $4$ žetony.",
          r"16.3: neobsazená po $12.$ tahu jsou pole ve vzdálenosti $\ge12$. Pro vzdálenosti $12,13,14$ (souřadnice omezené na $\pm7$) jich je $12+8+4=24$ polí."],
    ans=r"16.1: $41$ žetonů; 16.2: $4$ žetony; 16.3: $24$ polí",
    codes=["zs2", "r9", "posloupnosti", "aritmetika", "uvazovani", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9I-2021")
for path, size, names in written:
    print(path, size, "B", len(names), "úloh")
