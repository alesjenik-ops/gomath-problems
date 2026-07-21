# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9D 2024 (2. náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9D_2024_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2024, 2. náhradní termín (M9D)"
CCODE = "M9PDD24C0T04"
YR = 2024
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2024 M9D · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Adam a Naďa šli trasou dlouhou $2{,}7\ \mathrm{km}$. Adam má krok $75\ \mathrm{cm}$, Naďa $60\ \mathrm{cm}$. O kolik kroků udělala Naďa více?"],
    solp=[r"$2{,}7\ \mathrm{km}=270\,000\ \mathrm{cm}$. Adam $\frac{270\,000}{75}=3\,600$ kroků, Naďa $\frac{270\,000}{60}=4\,500$ kroků.",
          r"Rozdíl $4\,500-3\,600=900$ kroků."],
    ans=r"o $900$ kroků",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 2", pts=2, mins=4, diff="3",
    zad=[r"Reproduktory byly zlevněny o $150$ korun, což bylo $15\ \%$ původní ceny. Po Vánocích je prodejce zlevnil ještě o $200$ korun z nové ceny. O kolik procent byla konečná cena nižší než původní?"],
    solp=[r"Původní cena $\frac{150}{0{,}15}=1\,000$ Kč; nová cena $850$ Kč; konečná $850-200=650$ Kč.",
          r"$1\,000-650=350$ Kč, tj. $\frac{350}{1\,000}=35\ \%$ původní ceny."],
    ans=r"o $35\ \%$",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"Vypočítejte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{\left(\frac{1}{6}-\frac{1}{3}\right):\left(-\frac{5}{3}\right)}{0{,}3}=$",
         r"3.2 \quad $\dfrac{1}{6}+\dfrac{1}{3}\cdot\left(\dfrac{2}{5}-1\right)=$"],
    solp=[r"3.1: čitatel $\left(-\frac{1}{6}\right):\left(-\frac{5}{3}\right)=\frac{1}{10}$; $\frac{1}{10}:0{,}3=\frac{1}{3}$.",
          r"3.2: $\frac{1}{6}+\frac{1}{3}\cdot\left(-\frac{3}{5}\right)=\frac{1}{6}-\frac{1}{5}=\frac{5-6}{30}=-\frac{1}{30}$."],
    ans=r"3.1: $\frac{1}{3}$; 3.2: $-\frac{1}{30}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 4", pts=4, mins=5, diff="3",
    zad=[r"4.1 Upravte a rozložte na součin vytknutím: $a\cdot(-a)-2^2\cdot3a+6a^2=$",
         r"4.2 Umocněte a zjednodušte: $\left(\dfrac{1}{3}-4b\right)^2=$",
         r"4.3 Upravte bez závorek a zjednodušte: $(2x+3)^2-x\cdot6-4\cdot(x-1)^2=$"],
    solp=[r"4.1: $-a^2-12a+6a^2=5a^2-12a=a\cdot(5a-12)$.",
          r"4.2: $\frac{1}{9}-2\cdot\frac{1}{3}\cdot4b+16b^2=16b^2-\frac{8}{3}b+\frac{1}{9}$.",
          r"4.3: $(4x^2+12x+9)-6x-4(x^2-2x+1)=4x^2+12x+9-6x-4x^2+8x-4=14x+5$."],
    ans=r"4.1: $a\cdot(5a-12)$; 4.2: $16b^2-\frac{8}{3}b+\frac{1}{9}$; 4.3: $14x+5$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnice.",
         r"5.1 \quad $x-\dfrac{x-2}{2}=\dfrac{2x}{3}-2$",
         r"5.2 \quad $2\cdot(3x-2{,}5)=-5+3\cdot(3x-2)$"],
    solp=[r"5.1: vynásobením $6$: $6x-3(x-2)=4x-12\Rightarrow 3x+6=4x-12\Rightarrow x=18$.",
          r"5.2: $6x-5=-5+9x-6\Rightarrow 6x-5=9x-11\Rightarrow 6=3x\Rightarrow x=2$."],
    ans=r"5.1: $x=18$; 5.2: $x=2$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 6", pts=4, mins=5, diff="3",
    zad=[r"V rychlíku jsou vagóny 1. a 2. třídy; vagónů 2. třídy je dvakrát více než 1. třídy. V každém vagónu je $10$ kupé. V kupé 1. třídy je $6$ míst, v kupé 2. třídy $8$ míst. Celkem je $440$ míst k sezení.",
         r"6.1 Kolik vagónů 2. třídy je v rychlíku?",
         r"6.2 Kolik míst k sezení je dohromady ve vagónech 1. třídy?"],
    solp=[r"Vagónů 1. třídy $x$, 2. třídy $2x$: $x\cdot10\cdot6+2x\cdot10\cdot8=220x=440\Rightarrow x=2$.",
          r"6.1: vagónů 2. třídy $2x=4$.",
          r"6.2: míst v 1. třídě $x\cdot10\cdot6=2\cdot60=120$."],
    ans=r"6.1: $4$ vagóny; 6.2: $120$ míst",
    codes=["zs2", "r9", "rovnice", "aritmetika", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 7", pts=4, mins=5, diff="3",
    zad=[r"V restauraci nabízejí tři menu A, B, C. Tři skupiny po $20$ lidech objednaly: skupina 1 dvacet menu A za $4\,000$ Kč; skupina 2 deset A a deset B za $4\,800$ Kč; skupina 3 pět A, pět B a deset C za $5\,400$ Kč.",
         r"7.1 Jaká byla cena oběda B?",
         r"7.2 Jaká byla cena oběda C?"],
    solp=[r"Z první skupiny $A=\frac{4\,000}{20}=200$ Kč.",
          r"7.1: $10\cdot200+10B=4\,800\Rightarrow B=280$ Kč.",
          r"7.2: $5\cdot200+5\cdot280+10C=5\,400\Rightarrow 10C=3\,000\Rightarrow C=300$ Kč."],
    ans=r"7.1: $280$ Kč; 7.2: $300$ Kč",
    codes=["zs2", "r9", "rovnice", "soustava", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 8", pts=4, mins=5, diff="3",
    zad=[r"Průměrné denní činnosti paní Kratochvílové ($24$ hodin) jsou v grafu rozděleny takto: zaměstnání $25\ \%$, spánek $30\ \%$, denní povinnosti $35\ \%$, volný čas $10\ \%$. Její volný čas se dělí na sledování TV, sport a četbu, přičemž sport tvoří $40\ \%$ volného času.",
         r"8.1 Kolik hodin denně tráví v zaměstnání?",
         r"8.2 Kolik minut denně sportuje? (Zaokrouhlete na celé minuty.)"],
    solp=[r"8.1: zaměstnání tvoří $25\ \%$ z $24$ hodin, tj. $6$ hodin.",
          r"8.2: volný čas tvoří $10\ \%$ z $24$ hodin $=2{,}4$ h $=144$ minut; sport je $40\ \%$ volného času $=0{,}4\cdot144\doteq58$ minut."],
    ans=r"8.1: $6$ hodin; 8.2: $58$ minut",
    codes=["zs2", "r9", "procenta", "statistika", "porozumeni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině je dána přímka $p$ a body $A$, $S$, které na $p$ neleží. Bod $A$ je vrchol obdélníku $ABCD$, bod $S$ je střed obdélníku (průsečík úhlopříček), vrchol $D$ leží na přímce $p$ (viz obrázek).",
         r"Sestrojte obdélník $ABCD$. Nalezněte všechna řešení."],
    solp=[r"Vrchol $C$ je obraz $A$ ve středové souměrnosti podle $S$; kružnice $k$ se středem $S$ a poloměrem $|SA|$ prochází všemi vrcholy.",
          r"Vrchol $D$ leží na kružnici $k$ i na přímce $p$ (Thaletova kružnice nad $AC$ zaručí pravý úhel u $D$); průsečíky dávají dvě řešení, $B$ je obraz $D$ podle $S$."],
    ans=r"Kružnice $k(S,|SA|)$; $C$ je obraz $A$ podle $S$; $D=k\cap p$ (Thaletova kružnice nad $AC$), $B$ obraz $D$ podle $S$ (dvě řešení).",
    svg=fig(6, (66, 66, 560, 510)), fn=FN,
    alt="Přímka p a body A, S, které na ní neleží.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $C$, $S$ a přímka $p$. Bod $C$ je vrchol pravoúhlého trojúhelníku $ABC$, bod $S$ je střed strany $BC$ a strana $AB$ je rovnoběžná s přímkou $p$ (viz obrázek).",
         r"Sestrojte pravoúhlý trojúhelník $ABC$. Najděte všechna řešení."],
    solp=[r"Kružnice $k$ se středem $S$ a poloměrem $|SC|$ obsahuje vrchol $B$ ($S$ je střed $BC$); $B=k\cap$ polopřímka $CS$.",
          r"Přímka $AB$ prochází bodem $B$ rovnoběžně s $p$; pravý úhel trojúhelníku určí vrchol $A$ (dvě řešení podle umístění pravého úhlu)."],
    ans=r"Kružnice $k(S,|SC|)$ dá vrchol $B$; přímka $AB\parallel p$ prochází $B$; vrchol $A$ dopočteme z pravého úhlu (dvě řešení).",
    svg=fig(7, (66, 66, 560, 510)), fn=FN,
    alt="Body C, S a přímka p v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 11", pts=2, mins=4, diff="3",
    zad=[r"Ráno tvořila dámská trička $60\ \%$ naskladněných triček, zbytek pánská. Přes den se prodalo $45$ dámských triček, což je čtvrtina všech dámských. Pánských se prodala polovina.",
         r"Kolik triček (dámských i pánských) zůstalo na konci dne?"],
    opts=[r"A) méně než $200$", r"B) $200$", r"C) $210$", r"D) $220$", r"E) více než $220$"],
    solp=[r"Dámských bylo $45\cdot4=180$, což je $60\ \%$ celku, tedy celkem $300$ triček; pánských $120$.",
          r"Zůstalo dámských $180-45=135$, pánských $\frac{120}{2}=60$; celkem $195$."],
    ans=r"A) méně než $200$",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 12", pts=2, mins=3, diff="2",
    zad=[r"Petr přečetl již $1\,050$ stran, do konce mu zbývá $450$ stran. Kolik procent stran mu zbývá dočíst?"],
    opts=[r"A) $27\ \%$", r"B) $30\ \%$", r"C) $33\ \%$", r"D) $40\ \%$", r"E) $43\ \%$"],
    solp=[r"Celkem $1\,050+450=1\,500$ stran; zbývá $\frac{450}{1\,500}=30\ \%$."],
    ans=r"B) $30\ \%$",
    codes=["zs2", "r9", "procenta", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 13", pts=2, mins=4, diff="3",
    zad=[r"Maminka oškrabe $6\ \mathrm{kg}$ brambor za $2$ hodiny a $24$ minut, babička $2\ \mathrm{kg}$ za $1$ hodinu a $20$ minut. Za kolik minut oškrabou $1\ \mathrm{kg}$ dohromady?"],
    opts=[r"A) za $64$ minut", r"B) za $32$ minut", r"C) za $15$ minut", r"D) za $12$ minut", r"E) jiný výsledek"],
    solp=[r"Maminka $\frac{6}{144}=\frac{1}{24}\ \mathrm{kg/min}$, babička $\frac{2}{80}=\frac{1}{40}\ \mathrm{kg/min}$.",
          r"Dohromady $\frac{1}{24}+\frac{1}{40}=\frac{1}{15}\ \mathrm{kg/min}$, tedy $1\ \mathrm{kg}$ za $15$ minut."],
    ans=r"C) za $15$ minut",
    codes=["zs2", "r9", "zlomky", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 14", pts=2, mins=4, diff="4",
    zad=[r"Přímky $p$, $r$, $s$ se protínají v jednom bodě. V obrázku je vyznačen úhel $126^\circ30'$ a pravý úhel; hledané úhly jsou $\alpha$, $\beta$, $\gamma$.",
         r"Jaký je součet úhlů $\alpha+\beta+\gamma$? (Velikosti neměřte, ale vypočítejte.)"],
    opts=[r"A) $126^\circ30'$", r"B) $133^\circ30'$", r"C) $143^\circ30'$", r"D) $180^\circ$", r"E) jiný výsledek"],
    solp=[r"Z úhlů kolem průsečíku tří přímek, z vyznačeného úhlu $126^\circ30'$ a pravého úhlu se dopočtou $\alpha$, $\beta$, $\gamma$.",
          r"Jejich součet je $\alpha+\beta+\gamma=143^\circ30'$."],
    ans=r"C) $143^\circ30'$",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 15", pts=3, mins=5, diff="4",
    zad=[r"Kilogram dražších jablek stojí $30$ Kč, kilogram levnějších $25$ Kč. Paní Vitamínová koupila $x$ kilogramů ($x$ celé číslo) a zaplatila $330$ Kč.",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"15.1 Pokud koupila $12\ \mathrm{kg}$, koupila stejná množství obou druhů.",
         r"15.2 Mohla koupit jen levnější druh jablek.",
         r"15.3 Chce-li koupit co nejvíce kilogramů, musí koupit právě $1\ \mathrm{kg}$ dražších."],
    solp=[r"15.1: $6\ \mathrm{kg}$ dražších a $6\ \mathrm{kg}$ levnějších: $6\cdot30+6\cdot25=330$ Kč — A.",
          r"15.2: jen levnější: $25x=330\Rightarrow x=13{,}2$, není celé — N.",
          r"15.3: nejvíce kg dává $1\ \mathrm{kg}$ dražších a $12\ \mathrm{kg}$ levnějších ($30+300=330$, celkem $13\ \mathrm{kg}$) — A."],
    ans=r"15.1: A; 15.2: N; 15.3: A",
    codes=["zs2", "r9", "aritmetika", "rovnice", "argumentace", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9D · úloha 16", pts=6, mins=6, diff="3",
    zad=[r"Přiřaďte ke každé podúloze (16.1–16.3) odpovídající výsledek (A–F).",
         r"16.1 Zvětšíme-li neznámé číslo o $4\ \%$, dostaneme $780$. Jaké je to číslo?",
         r"16.2 O kolik procent musíme zvětšit $\dfrac{1}{8}$, abychom dostali $\dfrac{1}{2}$?",
         r"16.3 Výkony dvou čerpadel jsou v poměru $3:7$. Méně výkonné vyčerpá $150$ litrů za dvě hodiny. Kolik litrů vyčerpá výkonnější za $5$ hodin?"],
    opts=[r"A) $300$", r"B) $400$", r"C) $720$", r"D) $750$", r"E) $875$", r"F) jiný výsledek"],
    solp=[r"16.1: $1{,}04\cdot x=780\Rightarrow x=750$ — D.",
          r"16.2: $\frac{\frac{1}{2}-\frac{1}{8}}{\frac{1}{8}}=\frac{\frac{3}{8}}{\frac{1}{8}}=3=300\ \%$ — A.",
          r"16.3: méně výkonné $\frac{150}{2}=75$ l/h; výkonnější $75\cdot\frac{7}{3}=175$ l/h; za $5$ h $875$ litrů — E."],
    ans=r"16.1: D ($750$); 16.2: A ($300\ \%$); 16.3: E ($875$)",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9D-2024")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
