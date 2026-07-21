# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9 2015 (řádný termín, čtyřleté obory)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9A_2015_TS.pdf"
SRC = "CERMAT – Přijímací zkoušky 2015, matematika 9 (čtyřleté obory)"
CCODE = "M9PZD15C0T01"
YR = 2015
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2015 M9 · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte:",
         r"$20-3\cdot(30-30:2)=$"],
    solp=[r"$30:2=15$; $30-15=15$; $3\cdot15=45$; $20-45=-25$."],
    ans=r"$-25$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 2", pts=2, mins=3, diff="2",
    zad=[r"Zapište zlomkem v základním tvaru jednu šestinu rozdílu $2{,}4-1{,}5$."],
    solp=[r"Rozdíl $2{,}4-1{,}5=0{,}9$. Jedna šestina: $\frac{0{,}9}{6}=0{,}15=\frac{15}{100}=\frac{3}{20}$."],
    ans=r"$\frac{3}{20}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{1}{6}+\dfrac{2}{3}\cdot\dfrac{9}{8}=$",
         r"3.2 \quad $\dfrac{2}{3}:\dfrac{5}{2}-\dfrac{2}{3}=$"],
    solp=[r"3.1: $\frac{2}{3}\cdot\frac{9}{8}=\frac{18}{24}=\frac{3}{4}$; $\frac{1}{6}+\frac{3}{4}=\frac{2}{12}+\frac{9}{12}=\frac{11}{12}$.",
          r"3.2: $\frac{2}{3}:\frac{5}{2}=\frac{2}{3}\cdot\frac{2}{5}=\frac{4}{15}$; $\frac{4}{15}-\frac{2}{3}=\frac{4}{15}-\frac{10}{15}=-\frac{6}{15}=-\frac{2}{5}$."],
    ans=r"3.1: $\frac{11}{12}$; 3.2: $-\frac{2}{5}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"Zjednodušte (výsledný výraz nesmí obsahovat závorky):",
         r"4.1 \quad $2x(x-3)-(x^2+3x)=$",
         r"4.2 \quad $(2+y)(y+2-2y)=$"],
    solp=[r"4.1: $2x^2-6x-x^2-3x=x^2-9x$.",
          r"4.2: $(2+y)(2-y)=4-y^2$."],
    ans=r"4.1: $x^2-9x$; 4.2: $4-y^2$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 5", pts=3, mins=5, diff="3",
    zad=[r"Řešte rovnici:",
         r"$\dfrac{2-x}{2}-3=\dfrac{2x+1}{3}$"],
    solp=[r"Vynásobíme celou rovnici $6$: $3(2-x)-18=2(2x+1)$.",
          r"$6-3x-18=4x+2$; $-12-3x=4x+2$; $-14=7x$; $x=-2$."],
    ans=r"$x=-2$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 6", pts=4, mins=6, diff="3",
    zad=[r"Turistická trasa je na mapě s měřítkem $1:50\,000$ zobrazena čarou dlouhou $30\ \mathrm{cm}$.",
         r"6.1 Vypočtěte v km skutečnou délku turistické trasy.",
         r"6.2 Vypočtěte v cm délku čáry, která zobrazuje stejnou turistickou trasu na mapě s měřítkem $1:60\,000$."],
    solp=[r"6.1: Skutečná délka $=30\ \mathrm{cm}\cdot50\,000=1\,500\,000\ \mathrm{cm}=15\,000\ \mathrm{m}=15\ \mathrm{km}$.",
          r"6.2: $\frac{1\,500\,000\ \mathrm{cm}}{60\,000}=25\ \mathrm{cm}$."],
    ans=r"6.1: $15\ \mathrm{km}$; 6.2: $25\ \mathrm{cm}$",
    codes=["zs2", "r9", "pomer", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 7", pts=2, mins=3, diff="2",
    zad=[r"Vypočítejte a výsledek vyjádřete v uvedených jednotkách.",
         r"7.1 \quad $1{,}5\ \mathrm{dm}^2+75\ \mathrm{mm}^2=\ \dots\ \mathrm{mm}^2$",
         r"7.2 \quad $1\ \mathrm{m}^3-50$ litrů $=\ \dots$ litrů"],
    solp=[r"7.1: $1\ \mathrm{dm}^2=10\,000\ \mathrm{mm}^2$, tedy $1{,}5\ \mathrm{dm}^2=15\,000\ \mathrm{mm}^2$; $15\,000+75=15\,075\ \mathrm{mm}^2$.",
          r"7.2: $1\ \mathrm{m}^3=1\,000$ litrů; $1\,000-50=950$ litrů."],
    ans=r"7.1: $15\,075\ \mathrm{mm}^2$; 7.2: $950$ litrů",
    codes=["zs2", "r9", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 8", pts=3, mins=6, diff="4",
    zad=[r"Některé z bodů vyznačených v síti kvádru představují ve složeném kvádru jeden a týž vrchol. Například dva různé body $0$ a $E$ sítě kvádru představují ve složeném kvádru stejný vrchol (viz obrázek).",
         r"Připište k uvedenému bodu všechny body sítě kvádru, které ve složeném kvádru představují stejný vrchol.",
         r"8.1 \quad bod $1$",
         r"8.2 \quad bod $2$",
         r"8.3 \quad bod $3$"],
    solp=[r"Síť z obrázku složíme do kvádru a sledujeme, které vrcholy sítě po složení splynou v jeden vrchol.",
          r"8.1: bod $1$ splyne s vrcholem $L$.",
          r"8.2: bod $2$ splyne s vrcholy $A$ a $B$.",
          r"8.3: bod $3$ splyne s vrcholy $F$ a $K$."],
    ans=r"8.1: $L$; 8.2: $A$, $B$; 8.3: $F$, $K$",
    svg=fig(3, (95, 355, 505, 565)), fn=FN,
    alt="Síť kvádru s vyznačenými body A, B, C, D, E, F, G, H, K, L a body 0, 1, 2, 3; vpravo je z této sítě složený kvádr.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "uvazovani", "prirazovani", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 9", pts=2, mins=4, diff="3",
    zad=[r"V rovině leží různoběžky $o$, $p$ a bod $A$ na přímce $p$ (viz obrázek).",
         r"9.1 Sestrojte bod $B$, který je obrazem bodu $A$ v osové souměrnosti s osou $o$.",
         r"9.2 Sestrojte přímku $q$, která je obrazem přímky $p$ v osové souměrnosti s osou $o$."],
    solp=[r"9.1: Bodem $A$ vedeme kolmici k ose $o$; bod $B$ leží na této kolmici ve stejné vzdálenosti od $o$ jako $A$, ale na opačné straně.",
          r"9.2: Průsečík přímek $o$ a $p$ se zobrazí sám na sebe. Obraz $q$ přímky $p$ proto prochází tímto průsečíkem a bodem $B$ (obrazem bodu $A$)."],
    ans=r"Konstrukce: bod $B$ je obraz bodu $A$ v osové souměrnosti podle $o$; přímka $q$ prochází bodem $B$ a průsečíkem přímek $o$ a $p$.",
    svg=fig(4, (70, 168, 528, 315)), fn=FN,
    alt="V rovině leží různoběžky o a p a bod A ležící na přímce p.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "soumernost", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině jsou dány body $A$, $B$ a $Y$ (bod $A$ dole uprostřed, bod $B$ vpravo nahoře, bod $Y$ zhruba uprostřed nahoře).",
         r"10.1 Na polopřímce $BY$ sestrojte bod $C$ tak, aby body $A$, $B$, $C$ tvořily vrcholy rovnoramenného trojúhelníku se základnou $AB$, a trojúhelník $ABC$ narýsujte.",
         r"10.2 Sestrojte osu souměrnosti $o$ trojúhelníku $ABC$."],
    solp=[r"10.1: Trojúhelník je rovnoramenný se základnou $AB$, tedy $|CA|=|CB|$; bod $C$ leží na ose úsečky $AB$. Sestrojíme osu úsečky $AB$; její průsečík s polopřímkou $BY$ je hledaný bod $C$.",
          r"10.2: Osa souměrnosti $o$ rovnoramenného trojúhelníku $ABC$ je totožná s osou základny $AB$ (prochází bodem $C$ a středem $AB$)."],
    ans=r"Konstrukce: $C$ = průsečík polopřímky $BY$ s osou úsečky $AB$; osa souměrnosti $o$ je osa základny $AB$.",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "soumernost", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 11", pts=3, mins=5, diff="3",
    zad=[r"Uvnitř čtverce je sestrojen trojúhelník, jehož jedna strana je současně stranou čtverce. Přemístěním trojúhelníku k protější straně čtverce vznikne nový obrazec (trojúhelník se z vnitřku čtverce odebere a přiloží zvnějšku k protější straně). Obvod čtverce je $40\ \mathrm{cm}$ a obvod trojúhelníku $25\ \mathrm{cm}$.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 Obvod nového obrazce je $50\ \mathrm{cm}$.",
         r"11.2 Obsah čtverce je $100\ \mathrm{cm}^2$.",
         r"11.3 Obsah nového obrazce je větší než obsah čtverce."],
    solp=[r"Strana čtverce $=40:4=10\ \mathrm{cm}$. Základna trojúhelníku splývá se stranou čtverce, tj. $10\ \mathrm{cm}$; zbylé dvě strany trojúhelníku mají součet $25-10=15\ \mathrm{cm}$.",
          r"11.1: Nový obrazec tvoří dvě celé strany čtverce ($10+10=20$), na jedné straně místo úsečky $10\ \mathrm{cm}$ vznikl zářez ze dvou stran trojúhelníku ($15$) a na protější straně přečnívá trojúhelník ($15$): obvod $=20+15+15=50\ \mathrm{cm}$ — \textbf{A} (pravda).",
          r"11.2: Obsah čtverce $=10^2=100\ \mathrm{cm}^2$ — \textbf{A} (pravda).",
          r"11.3: Odebraná i přidaná plocha je týž trojúhelník, celkový obsah se nemění a je stejný jako obsah čtverce — \textbf{N} (nepravda)."],
    ans=r"11.1: A; 11.2: A; 11.3: N",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "uvazovani", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 12", pts=3, mins=5, diff="3",
    zad=[r"V pravoúhlém trojúhelníku $ABC$ leží proti přeponě $c$ úhel $\gamma$ a proti odvěsnám $a$, $b$ úhly $\alpha$, $\beta$. Platí: $a=6\ \mathrm{cm}$, $c=10\ \mathrm{cm}$.",
         r"Rozhodněte o každém z tvrzení 12.1–12.3, zda je pravdivé (A), či nikoli (N).",
         r"12.1 \quad $a+b=c$",
         r"12.2 \quad $\beta<\gamma$",
         r"12.3 \quad $\alpha+\beta=90^\circ$"],
    solp=[r"Přepona je $c$, proto $\gamma=90^\circ$. Odvěsna $b=\sqrt{c^2-a^2}=\sqrt{100-36}=\sqrt{64}=8\ \mathrm{cm}$.",
          r"12.1: $a+b=6+8=14\neq10=c$ — \textbf{N} (nepravda).",
          r"12.2: $\beta<90^\circ=\gamma$ — \textbf{A} (pravda).",
          r"12.3: Součet ostrých úhlů pravoúhlého trojúhelníku je $\alpha+\beta=90^\circ$ — \textbf{A} (pravda)."],
    ans=r"12.1: N; 12.2: A; 12.3: A",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "uvazovani", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 13", pts=2, mins=3, diff="3",
    zad=[r"Trojúhelník má základnu na přímce. U levého vrcholu je základna prodloužena vlevo; vnější úhel mezi tímto prodloužením a levou stranou trojúhelníku má velikost $90^\circ+\alpha$, vnitřní úhel u téhož vrcholu má velikost $\alpha$. U pravého vrcholu je vnitřní úhel $35^\circ$, u horního vrcholu je úhel $\gamma$.",
         r"Jaká je velikost úhlu $\gamma$?"],
    solp=[r"Vnější úhel $90^\circ+\alpha$ a vnitřní úhel $\alpha$ jsou vedlejší (leží na téže přímce), tedy $(90^\circ+\alpha)+\alpha=180^\circ$, odkud $2\alpha=90^\circ$, $\alpha=45^\circ$.",
          r"Vnitřní úhly trojúhelníku jsou $45^\circ$, $35^\circ$ a $\gamma$; $\gamma=180^\circ-45^\circ-35^\circ=100^\circ$."],
    ans=r"C) $100^\circ$",
    opts=[r"A) $90^\circ$", r"B) $95^\circ$", r"C) $100^\circ$", r"D) $105^\circ$", r"E) jiná velikost"],
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 14", pts=2, mins=3, diff="3",
    zad=[r"Kružnice je vytvořena z drátu délky $30\ \mathrm{cm}$. Z tohoto drátu se vytvaruje obdélník, jehož sousední strany mají délky v poměru $3:2$.",
         r"Jaký je obsah obdélníku?"],
    solp=[r"Obvod obdélníku je roven délce drátu, tj. $30\ \mathrm{cm}$. Strany jsou $3x$ a $2x$: $2(3x+2x)=10x=30\Rightarrow x=3$.",
          r"Strany obdélníku jsou $9\ \mathrm{cm}$ a $6\ \mathrm{cm}$; obsah $=9\cdot6=54\ \mathrm{cm}^2$."],
    ans=r"B) $54\ \mathrm{cm}^2$",
    opts=[r"A) $24\ \mathrm{cm}^2$", r"B) $54\ \mathrm{cm}^2$", r"C) $96\ \mathrm{cm}^2$", r"D) $108\ \mathrm{cm}^2$", r"E) jiný obsah"],
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "pomer", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 15", pts=2, mins=3, diff="3",
    zad=[r"Karel s rodiči odlétal na dovolenou. Při odbavení na letišti měla jejich $3$ zavazadla celkovou hmotnost $44\ \mathrm{kg}$. Otcovo zavazadlo mělo třikrát větší hmotnost než Karlovo zavazadlo a matčino zavazadlo mělo polovinu hmotnosti otcova zavazadla.",
         r"O kolik kilogramů je matčino zavazadlo těžší než Karlovo zavazadlo?"],
    solp=[r"Karlovo zavazadlo $=k$, otcovo $=3k$, matčino $=\frac{1}{2}\cdot3k=1{,}5k$.",
          r"$k+3k+1{,}5k=5{,}5k=44\Rightarrow k=8$. Karlovo $8\ \mathrm{kg}$, matčino $12\ \mathrm{kg}$; rozdíl $12-8=4\ \mathrm{kg}$."],
    ans=r"B) o $4\ \mathrm{kg}$",
    opts=[r"A) o $3{,}5\ \mathrm{kg}$", r"B) o $4\ \mathrm{kg}$", r"C) o $5\ \mathrm{kg}$", r"D) o $6\ \mathrm{kg}$", r"E) o $6{,}5\ \mathrm{kg}$"],
    codes=["zs2", "r9", "rovnice", "aritmetika", "slovni", "vyber", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 16", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).",
         r"16.1 Výrobek stojí $600$ korun. Kolik korun bude stát výrobek zdražený o $20\ \%$?",
         r"16.2 Kalhoty byly zlevněny o $20\ \%$ na $560$ korun. Kolik korun stály kalhoty před zlevněním?",
         r"16.3 Zájezd byl zdražen o pětinu na $3\,600$ korun. O kolik korun byl zájezd zdražen?",
         r"Nabídka: A) $600$; B) $650$; C) $672$; D) $700$; E) $720$; F) jiný výsledek."],
    solp=[r"16.1: $600\cdot1{,}2=720$ — \textbf{E}.",
          r"16.2: $560=0{,}8\cdot x\Rightarrow x=700$ — \textbf{D}.",
          r"16.3: Původní cena $x$: $x+\frac{1}{5}x=1{,}2x=3\,600\Rightarrow x=3\,000$; zdraženo o $3\,600-3\,000=600$ — \textbf{A}."],
    ans=r"16.1: E; 16.2: D; 16.3: A",
    opts=[r"A) $600$", r"B) $650$", r"C) $672$", r"D) $700$", r"E) $720$", r"F) jiný výsledek"],
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2015 M9 · úloha 17", pts=4, mins=7, diff="4",
    zad=[r"V motorestu se podávají tři různé večeře $A$, $B$, $C$. Přijely tři $20$členné skupiny. Pro každou skupinu je uvedeno, kolik večeří jednotlivých druhů si objednala, a jaká byla průměrná cena večeře ve skupině:",
         r"Skupina 1: $20\times A$, $0\times B$, $0\times C$; průměrná cena $200$ Kč.",
         r"Skupina 2: $10\times A$, $10\times B$, $0\times C$; průměrná cena $240$ Kč.",
         r"Skupina 3: $5\times A$, $5\times B$, $10\times C$; průměrná cena $270$ Kč.",
         r"17.1 Vypočtěte cenu večeře $B$.",
         r"17.2 Vypočtěte cenu večeře $C$."],
    solp=[r"Ze skupiny 1 (samé $A$, průměr $200$) plyne cena $A=200$ Kč.",
          r"17.1: Skupina 2: $\frac{10\cdot200+10\cdot B}{20}=240\Rightarrow2\,000+10B=4\,800\Rightarrow B=280$ Kč.",
          r"17.2: Skupina 3: $\frac{5\cdot200+5\cdot280+10\cdot C}{20}=270\Rightarrow2\,400+10C=5\,400\Rightarrow C=300$ Kč."],
    ans=r"17.1: $280$ Kč; 17.2: $300$ Kč",
    codes=["zs2", "r9", "rovnice", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9A-2015")
for path, size, names in written:
    print("%s  %d B  (%d úloh)" % (path, size, len(names)))
