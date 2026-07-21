# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9C 2021 (náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9C_2021_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2021, náhradní termín (M9C)"
CCODE = "M9PCD21C0T03"
YR = 2021
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2021 M9C · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Zapište zlomkem v základním tvaru, jakou část litru tvoří $30\ \%$ ze čtvrtlitru."],
    solp=[r"$30\ \%$ ze čtvrtlitru je $0{,}3\cdot\dfrac{1}{4}\ \mathrm{l}=\dfrac{0{,}3}{4}\ \mathrm{l}=\dfrac{3}{40}\ \mathrm{l}$."],
    ans=r"$\dfrac{3}{40}$",
    codes=["zs2", "r9", "procenta", "zlomky", "aritmetika", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 2", pts=2, mins=4, diff="3",
    zad=[r"Dvě rekreační plavkyně Jana s Květou byly společně plavat. Každá uplavala $25$ bazénů. Obě začaly plavat současně a každá plavala svým stále stejným tempem.",
         r"Jana uplavala $5$ bazénů za $7$ minut. Květa uplavala $10$ bazénů za čtvrt hodiny.",
         r"2.1 Vypočtěte, o kolik sekund se lišily časy obou plavkyň na první obrátce (tj. po uplavání prvního bazénu).",
         r"2.2 Určete, za jak dlouho uplavala $25$ bazénů Květa. (Čas uveďte v minutách a sekundách.)"],
    solp=[r"2.1: Jana $1$ bazén za $\frac{7}{5}\ \mathrm{min}=1{,}4\ \mathrm{min}=84\ \mathrm{s}$; Květa $1$ bazén za $\frac{15}{10}\ \mathrm{min}=1{,}5\ \mathrm{min}=90\ \mathrm{s}$; rozdíl $90-84=6\ \mathrm{s}$.",
          r"2.2: Květa $25$ bazénů za $25\cdot1{,}5\ \mathrm{min}=37{,}5\ \mathrm{min}=37\ \mathrm{min}\ 30\ \mathrm{s}$."],
    ans=r"2.1: o $6$ sekund; 2.2: $37$ min $30$ s",
    codes=["zs2", "r9", "aritmetika", "pomer", "slovni", "vypocet", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\left(\dfrac{3}{4}+\dfrac{13}{6}\right)\cdot\left(\dfrac{2}{5}-1\right)=$",
         r"3.2 \quad $\dfrac{\frac{3}{5}\cdot2-4\cdot\frac{2}{7}}{2}=$"],
    solp=[r"3.1: $\frac{3}{4}+\frac{13}{6}=\frac{9}{12}+\frac{26}{12}=\frac{35}{12}$; $\frac{2}{5}-1=-\frac{3}{5}$; součin $\frac{35}{12}\cdot\left(-\frac{3}{5}\right)=-\frac{105}{60}=-\frac{7}{4}$.",
          r"3.2: $\frac{3}{5}\cdot2=\frac{6}{5}$; $4\cdot\frac{2}{7}=\frac{8}{7}$; $\frac{6}{5}-\frac{8}{7}=\frac{42-40}{35}=\frac{2}{35}$; $\frac{2}{35}:2=\frac{1}{35}$."],
    ans=r"3.1: $-\dfrac{7}{4}$; 3.2: $\dfrac{1}{35}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 Rozložte podle vzorce (výsledný výraz uveďte ve tvaru součinu): $(4\cdot a)^2-81=$",
         r"4.2 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $2\cdot(3y-x)\cdot(5-y)=$",
         r"4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(4n+1)^2+3\cdot(n-1)-(3n+n)\cdot2n=$"],
    solp=[r"4.1: $(4a)^2-81=16a^2-81=(4a-9)(4a+9)$.",
          r"4.2: $2(3y-x)(5-y)=2(15y-3y^2-5x+xy)=2xy-6y^2-10x+30y$.",
          r"4.3: $(4n+1)^2=16n^2+8n+1$; $3(n-1)=3n-3$; $(3n+n)\cdot2n=4n\cdot2n=8n^2$; celkem $16n^2+8n+1+3n-3-8n^2=8n^2+11n-2$."],
    ans=r"4.1: $(4a-9)(4a+9)$; 4.2: $2xy-6y^2-10x+30y$; 4.3: $8n^2+11n-2$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $0{,}4\cdot0{,}1x+0{,}32:0{,}1=0{,}2x$",
         r"5.2 \quad $\dfrac{y-4}{5}-\dfrac{y}{10}=\dfrac{3+y}{2}-2$"],
    solp=[r"5.1: $0{,}04x+3{,}2=0{,}2x\Rightarrow3{,}2=0{,}16x\Rightarrow x=20$.",
          r"5.2: vynásobíme $10$: $2(y-4)-y=5(3+y)-20\Rightarrow2y-8-y=15+5y-20\Rightarrow y-8=5y-5\Rightarrow-3=4y\Rightarrow y=-0{,}75$."],
    ans=r"5.1: $x=20$; 5.2: $y=-0{,}75$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 6", pts=3, mins=6, diff="4",
    zad=[r"Do firmy, která si pronajala dvě prázdné dílny, přivezli stroje. Polovinu přivezených strojů umístili do první dílny a polovinu do druhé dílny. První den zprovoznili tři pětiny strojů umístěných v první dílně (a žádný stroj v druhé dílně). Druhý den zprovoznili tři čtvrtiny strojů umístěných v druhé dílně (a žádný další v první). Třetí den zprovoznili veškeré zbývající stroje v obou dílnách.",
         r"Neznámá $x$ představuje celkový počet strojů přivezených do firmy.",
         r"6.1 V závislosti na veličině $x$ vyjádřete, kolik strojů zprovoznili první den.",
         r"6.2 V závislosti na veličině $x$ vyjádřete, kolik strojů zprovoznili třetí den v první dílně.",
         r"6.3 Třetí den zprovoznili v obou dílnách dohromady $52$ strojů. Vypočtěte celkový počet strojů přivezených do firmy."],
    solp=[r"6.1: v první dílně je $\frac{x}{2}$ strojů; první den $\frac{3}{5}\cdot\frac{x}{2}=\frac{3x}{10}$.",
          r"6.2: v první dílně zbývá (a třetí den se zprovozní) $\frac{x}{2}-\frac{3x}{10}=\frac{5x-3x}{10}=\frac{2x}{10}=\frac{x}{5}$.",
          r"6.3: v druhé dílně druhý den $\frac{3}{4}\cdot\frac{x}{2}=\frac{3x}{8}$, zbývá $\frac{x}{2}-\frac{3x}{8}=\frac{x}{8}$; třetí den celkem $\frac{x}{5}+\frac{x}{8}=\frac{8x+5x}{40}=\frac{13x}{40}=52\Rightarrow x=160$."],
    ans=r"6.1: $\dfrac{3x}{10}$; 6.2: $\dfrac{x}{5}$; 6.3: $160$ strojů",
    codes=["zs2", "r9", "vyrazy", "rovnice", "zlomky", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 7", pts=4, mins=6, diff="4",
    zad=[r"Brigádníci plní bedýnky ovocem. Za naplnění každé z prvních $10$ bedýnek dostávají základní odměnu $40$ korun za $1$ bedýnku. Za naplnění každé další bedýnky dostanou vyšší odměnu: odměna za $11.$ až $15.$ bedýnku je o $25\ \%$ vyšší než základní odměna. Počínaje $16.$ bedýnkou je odměna za každou bedýnku o $50\ \%$ vyšší než základní odměna.",
         r"7.1 Vypočtěte, kolik korun si brigádník vydělá za naplnění $12$ bedýnek.",
         r"7.2 Vypočtěte, kolik nejméně bedýnek musí brigádník naplnit, aby si vydělal alespoň $1\,000$ korun."],
    solp=[r"7.1: prvních $10$ bedýnek po $40$ korunách $=400$; $11.$ a $12.$ bedýnka po $40\cdot1{,}25=50$ korunách $=100$; celkem $500$ korun.",
          r"7.2: po $15$ bedýnkách má $400+5\cdot50=650$ korun; od $16.$ bedýnky je odměna $40\cdot1{,}5=60$ korun; chybí $1\,000-650=350$, tj. $350:60\Rightarrow6$ bedýnek ($6\cdot60=360$). Celkem $15+6=21$ bedýnek."],
    ans=r"7.1: $500$ korun; 7.2: $21$ bedýnek",
    codes=["zs2", "r9", "aritmetika", "procenta", "slovni", "vypocet", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 8", pts=3, mins=6, diff="3",
    zad=[r"Z celých dlaždic tvaru obdélníku o rozměrech $18\ \mathrm{cm}$ a $8\ \mathrm{cm}$ je sestaven nejmenší možný čtverec. Z každého ze čtyř rohů tohoto čtverce odebereme po jedné dlaždici a dostaneme nový útvar. (Jedna strana čtverce je rovnoběžná s delšími stranami všech dlaždic.)",
         r"8.1 Vypočtěte v cm délku strany sestaveného čtverce.",
         r"8.2 Vypočtěte počet dlaždic v novém útvaru.",
         r"8.3 Vypočtěte v cm obvod nového útvaru."],
    solp=[r"8.1: strana čtverce je nejmenší společný násobek $18$ a $8$, tedy $\mathrm{nsn}(18,8)=72\ \mathrm{cm}$.",
          r"8.2: čtverec obsahuje $\frac{72\cdot72}{18\cdot8}=\frac{5184}{144}=36$ dlaždic; po odebrání $4$ rohových dlaždic zbývá $32$ dlaždic.",
          r"8.3: odebráním obdélníkové dlaždice v rohu se obvod nezmění (chybějící vnější části nahradí stejně dlouhé zářezy), proto obvod $=4\cdot72=288\ \mathrm{cm}$."],
    ans=r"8.1: $a=72\ \mathrm{cm}$; 8.2: $32$ dlaždic; 8.3: $o=288\ \mathrm{cm}$",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "slovni", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 9", pts=3, mins=7, diff="4",
    zad=[r"V rovině leží body $A$, $B$, $M$ (viz obrázek).",
         r"Body $A$, $B$ jsou vrcholy obdélníku $ABCD$. Bod $M$ leží na téže kružnici $k$ jako všechny vrcholy obdélníku $ABCD$.",
         r"9.1 Sestrojte střed kružnice $k$ a označte ho písmenem $S$.",
         r"9.2 Sestrojte vrcholy $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte."],
    solp=[r"Vrcholy obdélníku i bod $M$ leží na kružnici $k$. Její střed $S$ je průsečíkem os stran trojúhelníku $ABM$ (os úseček $AB$ a $BM$, resp. $AM$); $S$ je zároveň středem obdélníku.",
          r"Kružnice $k$ má střed $S$ a poloměr $|SA|$. Vrchol $C$ je obrazem $A$ ve středové souměrnosti podle $S$, vrchol $D$ obrazem $B$ podle $S$; oba leží na $k$. Obdélník $ABCD$ narýsujeme."],
    ans=r"Konstrukce: střed $S$ (průsečík os stran trojúhelníku $ABM$) a obdélník $ABCD$ vepsaný do kružnice $k$ (max. $3$ body).",
    svg=fig(5, (66, 128, 530, 458)), fn=FN,
    alt="V rovině leží body A, B a M; A a B jsou vrcholy hledaného obdélníku ABCD, bod M leží na kružnici opsané obdélníku.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 10", pts=2, mins=6, diff="4",
    zad=[r"V rovině leží body $A$, $B$, $L$ (viz obrázek).",
         r"Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$. Osy vnitřních úhlů $BAC$ a $ABC$ tohoto trojúhelníku procházejí bodem $L$.",
         r"Sestrojte vrchol $C$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník narýsujte."],
    solp=[r"Bod $L$ je průsečíkem os vnitřních úhlů při vrcholech $A$ a $B$. Osu úhlu při $A$ určuje polopřímka $AL$, osu úhlu při $B$ polopřímka $BL$.",
          r"Rameno $AC$ získáme osovou souměrností polopřímky $AB$ podle přímky $AL$, rameno $BC$ osovou souměrností polopřímky $BA$ podle přímky $BL$. Vrchol $C$ je průsečíkem polopřímek $AC$ a $BC$."],
    ans=r"Konstrukce vrcholu $C$ jako průsečíku ramen $AC$ a $BC$ souměrných s přímkou $AB$ podle os $AL$ a $BL$ (max. $2$ body).",
    svg=fig(6, (66, 150, 530, 420)), fn=FN,
    alt="V rovině leží body A, B a L; A a B jsou vrcholy trojúhelníku ABC, bod L je průsečíkem os vnitřních úhlů u A a B.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 11", pts=4, mins=6, diff="4",
    zad=[r"Od startu $S$ do cíle $C$ vede jedna snadná cyklistická trasa údolími a druhá náročná přes kopce. Obě trasy se kříží v místě $K$. Po snadné trase ujedeme v první části od startu $S$ do místa $K$ $45\ \mathrm{km}$, což je o polovinu více, než ujedeme v druhé části od místa $K$ do cíle $C$. Náročná trasa je dlouhá $45\ \mathrm{km}$ a její první část od startu $S$ do místa $K$ je o pětinu kratší než její druhá část od místa $K$ do cíle $C$.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 U snadné trasy je poměr délky první části ku délce druhé části $2:1$.",
         r"11.2 Druhá část snadné trasy měří $30\ \mathrm{km}$.",
         r"11.3 Druhá část náročné trasy měří $25\ \mathrm{km}$."],
    solp=[r"Snadná trasa: první část $45\ \mathrm{km}$ je o polovinu více než druhá, tedy druhá $=45:1{,}5=30\ \mathrm{km}$; poměr $45:30=3:2$.",
          r"Náročná trasa: první $=\frac{4}{5}\cdot$druhá a první $+$ druhá $=45$; $\frac{4}{5}d+d=45\Rightarrow\frac{9}{5}d=45\Rightarrow d=25\ \mathrm{km}$ (první $=20\ \mathrm{km}$).",
          r"11.1: poměr je $3:2$, nikoli $2:1$ — \textbf{N}. 11.2: druhá část snadné trasy $=30\ \mathrm{km}$ — \textbf{A}. 11.3: druhá část náročné trasy $=25\ \mathrm{km}$ — \textbf{A}."],
    ans=r"11.1: N; 11.2: A; 11.3: A",
    codes=["zs2", "r9", "pomer", "aritmetika", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (viz obrázek). V obrázku jsou vyznačeny úhly $\alpha$, $2\alpha$ a $36^\circ$.",
         r"Jaká je velikost úhlu $\alpha$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Rovnoběžné přímky jsou proťaty dvěma příčkami. Úhel $\alpha$ u horní rovnoběžky odpovídá (střídavý úhel) úhlu $\alpha$ v trojúhelníku u dolní rovnoběžky. Vnitřní úhly tohoto trojúhelníku jsou $\alpha$, $36^\circ$ a $2\alpha$ (vrcholový k vyznačenému úhlu $2\alpha$).",
          r"Součet vnitřních úhlů trojúhelníku: $\alpha+2\alpha+36^\circ=180^\circ\Rightarrow3\alpha=144^\circ\Rightarrow\alpha=48^\circ$."],
    ans=r"D) $48^\circ$",
    opts=[r"A) $18^\circ$", r"B) $36^\circ$", r"C) $44^\circ$", r"D) $48^\circ$", r"E) jiná velikost"],
    svg=fig(8, (66, 104, 535, 248)), fn=FN,
    alt="Čtyři přímky, z nichž dvě jsou rovnoběžné (označené), proťaté dvěma příčkami; vyznačené úhly α u horní rovnoběžky, 2α v průsečíku příček a 36° u dolní rovnoběžky.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 13", pts=2, mins=3, diff="3",
    zad=[r"Kolmý šestiboký hranol byl vytvořen opracováním krychle o hraně délky $8\ \mathrm{cm}$. Podstava hranolu vznikne ze čtvercové stěny původní krychle oddělením $4$ shodných pravoúhlých trojúhelníků s odvěsnami délek $3\ \mathrm{cm}$ a $4\ \mathrm{cm}$. Výška hranolu je $8\ \mathrm{cm}$.",
         r"Jaký je objem šestibokého hranolu?"],
    solp=[r"Obsah podstavy $=$ obsah čtverce $-$ $4$ trojúhelníky $=8^2-4\cdot\frac{3\cdot4}{2}=64-24=40\ \mathrm{cm}^2$.",
          r"Objem $V=S_p\cdot v=40\cdot8=320\ \mathrm{cm}^3$."],
    ans=r"B) $320\ \mathrm{cm}^3$",
    opts=[r"A) $128\ \mathrm{cm}^3$", r"B) $320\ \mathrm{cm}^3$", r"C) $416\ \mathrm{cm}^3$", r"D) $488\ \mathrm{cm}^3$", r"E) jiný objem"],
    svg=fig(9, (70, 150, 295, 360)), fn=FN,
    alt="Podstava hranolu: čtverec o straně 8 cm, z jehož čtyř rohů jsou odděleny pravoúhlé trojúhelníky s odvěsnami 3 cm a 4 cm, čímž vznikne šestiúhelník.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 14", pts=2, mins=4, diff="3",
    zad=[r"Kolmý šestiboký hranol (viz úloha 13): podstava vznikla ze čtvercové stěny krychle o hraně $8\ \mathrm{cm}$ oddělením $4$ shodných pravoúhlých trojúhelníků s odvěsnami $3\ \mathrm{cm}$ a $4\ \mathrm{cm}$, výška hranolu je $8\ \mathrm{cm}$.",
         r"Jaký je povrch šestibokého hranolu?"],
    solp=[r"Podstava má obsah $40\ \mathrm{cm}^2$ (viz úloha 13). Strany šestiúhelníku: dvě rovnoběžné strany délky $8-2\cdot3=2\ \mathrm{cm}$ a čtyři přepony $\sqrt{3^2+4^2}=5\ \mathrm{cm}$; obvod podstavy $o=2\cdot2+4\cdot5=24\ \mathrm{cm}$.",
          r"Povrch $S=2\cdot S_p+o\cdot v=2\cdot40+24\cdot8=80+192=272\ \mathrm{cm}^2$."],
    ans=r"D) $272\ \mathrm{cm}^2$",
    opts=[r"A) $160\ \mathrm{cm}^2$", r"B) $192\ \mathrm{cm}^2$", r"C) $240\ \mathrm{cm}^2$", r"D) $272\ \mathrm{cm}^2$", r"E) $336\ \mathrm{cm}^2$"],
    svg=fig(9, (70, 150, 295, 360)), fn=FN,
    alt="Podstava hranolu: čtverec o straně 8 cm, z jehož čtyř rohů jsou odděleny pravoúhlé trojúhelníky s odvěsnami 3 cm a 4 cm, čímž vznikne šestiúhelník.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 V domově pro seniory je $120$ klientů a $84$ z nich bylo očkováno. Kolik procent klientů domova pro seniory nebylo očkováno?",
         r"15.2 Vláďa má $40$ kartiček. Roman má o čtvrtinu kartiček více než Vláďa. O kolik procent má Vláďa méně kartiček než Roman?",
         r"15.3 Cena za víkendový pobyt činila $2\,000$ korun a zahrnovala pouze dopravu, ubytování a stravování. Cena dopravy tvořila čtvrtinu ceny pobytu, ubytování stálo $800$ korun. Kolik procent ceny pobytu tvořila cena stravování?",
         r"Nabídka: A) $20\ \%$; B) $25\ \%$; C) $30\ \%$; D) $33\ \%$; E) $35\ \%$; F) jiný počet procent."],
    solp=[r"15.1: neočkováno $120-84=36$; $\frac{36}{120}=0{,}30=30\ \%$ — \textbf{C}.",
          r"15.2: Roman $=40\cdot1{,}25=50$ kartiček; Vláďa má o $50-40=10$ méně; $\frac{10}{50}=0{,}20=20\ \%$ — \textbf{A}.",
          r"15.3: doprava $=\frac{1}{4}\cdot2\,000=500$; stravování $=2\,000-500-800=700$; $\frac{700}{2\,000}=0{,}35=35\ \%$ — \textbf{E}."],
    ans=r"15.1: C; 15.2: A; 15.3: E",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9C · úloha 16", pts=4, mins=8, diff="4",
    zad=[r"Trojúhelníkové obrazce se podle vzoru sestavují z tmavých šestiúhelníků a bílých trojúhelníků. Šestiúhelník se skládá ze $6$ shodných tmavých trojúhelníků. Řady obrazce jsou očíslovány vždy od nejkratší (řada $1$ – vrchol dole) po nejdelší; řada $k$ obsahuje $2k-1$ malých trojúhelníků. Na obrázku jsou tři nejmenší obrazce, které mají $3$, $5$ a $7$ řad.",
         r"Ze vzoru: vrchol (řada $1$) je jeden bílý trojúhelník. Tmavé šestiúhelníky vznikají po dvojicích řad – např. v obrazci se $7$ řadami je v řadách $2$–$3$ jeden šestiúhelník, v řadách $4$–$5$ dva a v řadách $6$–$7$ tři šestiúhelníky. Bílé trojúhelníky doplňují okraje a mezery mezi šestiúhelníky.",
         r"Obrazec má $19$ řad. Určete počet:",
         r"16.1 bílých trojúhelníků v $9.$ řadě,",
         r"16.2 tmavých trojúhelníků v $16.$ řadě,",
         r"16.3 tmavých šestiúhelníků v celém obrazci."],
    solp=[r"V každé dvojici řad $2m$ a $2m+1$ (pro $m=1,2,\dots$) je $m$ tmavých šestiúhelníků. Počet bílých trojúhelníků: v liché řadě $2m+1$ je jich $m+1$, v sudé řadě $2m$ je jich $m-1$ (řada $1$ má $1$ bílý). Řada $k$ má celkem $2k-1$ malých trojúhelníků.",
          r"16.1: řada $9=2\cdot4+1$, tedy $m=4$; bílých $=m+1=5$.",
          r"16.2: řada $16=2\cdot8$, tedy $m=8$; celkem $2\cdot16-1=31$ trojúhelníků, z toho $m-1=7$ bílých, tedy tmavých $31-7=24$.",
          r"16.3: $19$ řad odpovídá dvojicím řad pro $m=1,\dots,9$; šestiúhelníků $1+2+\cdots+9=45$ (tmavých trojúhelníků celkem $6\cdot45=270$)."],
    ans=r"16.1: $5$ bílých trojúhelníků; 16.2: $24$ tmavých trojúhelníků; 16.3: $45$ tmavých šestiúhelníků",
    codes=["zs2", "r9", "posloupnosti", "planimetrie", "uvazovani", "vypocet", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9C-2021")
for path, size, names in written:
    print("%s : %d bytes, %d úloh" % (path, size, len(names)))
