# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9D 2025 (2. náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9D_2025_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2025, 2. náhradní termín (M9D)"
CCODE = "M9PDD25C0T04"
YR = 2025
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2025 M9D · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Třímetrovou stuhu jsme dvěma střihy rozdělili na tři díly. Nejprve jsme odstřihli čtvrtinu stuhy, potom dvě pětiny zbytku a poslední díl jsme použili na třetí dárek.",
         r"Vypočtěte, kolik cm stuhy jsme použili na třetí dárek."],
    solp=[r"Stuha $300\ \mathrm{cm}$; první díl $\frac{1}{4}\cdot300=75\ \mathrm{cm}$, zbytek $225\ \mathrm{cm}$.",
          r"Druhý díl $\frac{2}{5}\cdot225=90\ \mathrm{cm}$; třetí díl $225-90=135\ \mathrm{cm}$."],
    ans=r"$135\ \mathrm{cm}$",
    codes=["zs2", "r9", "zlomky", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 2", pts=1, mins=2, diff="2",
    zad=[r"Poměr dvou neznámých přirozených čísel je $4:5$ a dvojnásobky těchto čísel se liší o $6$. Určete menší z obou čísel."],
    solp=[r"Čísla jsou $4k$ a $5k$; $2\cdot5k-2\cdot4k=2k=6\Rightarrow k=3$.",
          r"Menší číslo je $4\cdot3=12$."],
    ans=r"$12$",
    codes=["zs2", "r9", "aritmetika", "rovnice", "slovni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 3", pts=3, mins=5, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\left(\dfrac{7}{5}-\dfrac{7}{4}\right):\dfrac{2}{5}=$",
         r"3.2 \quad $\dfrac{\left(1+\dfrac{1}{7}\right)^2\cdot\dfrac{7}{4}}{\sqrt{25}-\dfrac{3^2}{5}}=$"],
    solp=[r"3.1: $\frac{7}{5}-\frac{7}{4}=\frac{28-35}{20}=-\frac{7}{20}$; $-\frac{7}{20}:\frac{2}{5}=-\frac{7}{8}$.",
          r"3.2: čitatel $\left(\frac{8}{7}\right)^2\cdot\frac{7}{4}=\frac{64}{49}\cdot\frac{7}{4}=\frac{16}{7}$; jmenovatel $5-\frac{9}{5}=\frac{16}{5}$; $\frac{16}{7}:\frac{16}{5}=\frac{5}{7}$."],
    ans=r"3.1: $-\frac{7}{8}$; 3.2: $\frac{5}{7}$",
    codes=["zs2", "r9", "zlomky", "mocniny-odmocniny", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 4", pts=4, mins=5, diff="3",
    zad=[r"4.1 Upravte na co nejjednodušší tvar bez závorek: $(y+1)^2+(y-1)\cdot2y=$",
         r"4.2 Upravte a výsledný výraz rozložte na součin pomocí vzorce: $k\cdot(k-9)+9\cdot(k-16)=$",
         r"4.3 Upravte na co nejjednodušší tvar bez závorek: $(x-15)\cdot(2x-x)-(5x-8)\cdot(-3+1)-1=$"],
    solp=[r"4.1: $y^2+2y+1+2y^2-2y=3y^2+1$.",
          r"4.2: $k^2-9k+9k-144=k^2-144=(k+12)(k-12)$.",
          r"4.3: $(x-15)\cdot x-(5x-8)\cdot(-2)-1=x^2-15x+10x-16-1=x^2-5x-17$."],
    ans=r"4.1: $3y^2+1$; 4.2: $(k+12)(k-12)$; 4.3: $x^2-5x-17$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"5.1 Řešte rovnici: $0{,}1x+5\cdot(0{,}04x-3{,}2)=4-0{,}7x$",
         r"5.2 Řešte soustavu rovnic: $\begin{aligned}3x-(y+1)&=10\\ 2x-9&=y\end{aligned}$"],
    solp=[r"5.1: $0{,}1x+0{,}2x-16=4-0{,}7x\Rightarrow 0{,}3x-16=4-0{,}7x\Rightarrow x=20$.",
          r"5.2: dosazením $y=2x-9$: $3x-(2x-9+1)=10\Rightarrow x+8=10\Rightarrow x=2$, $y=-5$."],
    ans=r"5.1: $x=20$; 5.2: $x=2$, $y=-5$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "soustava", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 6", pts=4, mins=6, diff="3",
    zad=[r"Ve skladu bylo $95$ beden. Robot A vozil bedny po $5$ kusech a odvezl za $2$ hodiny $50$ beden. Robot B vozil bedny po $3$ kusech a odvezl za $1{,}5$ hodiny zbývajících $45$ beden.",
         r"6.1 Vyjádřete v základním tvaru poměr počtu beden odvezených za $1$ hodinu robotem A ku počtu odvezených robotem B.",
         r"6.2 Vyjádřete v základním tvaru poměr počtu jízd robota A za hodinu ku počtu jízd robota B za hodinu.",
         r"6.3 Vypočtěte, kolik beden odvezou oba roboti dohromady za $36$ minut při společném provozu."],
    solp=[r"A: $\frac{50}{2}=25$ beden/h; B: $\frac{45}{1{,}5}=30$ beden/h.",
          r"6.1: $25:30=5:6$.",
          r"6.2: jízd A $\frac{25}{5}=5$/h, B $\frac{30}{3}=10$/h; $5:10=1:2$.",
          r"6.3: $36$ min $=0{,}6$ h; $(25+30)\cdot0{,}6=33$ beden."],
    ans=r"6.1: $5:6$; 6.2: $1:2$; 6.3: $33$ beden",
    codes=["zs2", "r9", "aritmetika", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 7", pts=4, mins=6, diff="4",
    zad=[r"Do soutěže se přihlásilo $10$ soutěžících, všichni psali $1.$ i $2.$ kolo. V každém kole získal každý $8$, $9$, nebo $10$ bodů. V $1.$ kole získalo $9$ bodů $5$ soutěžících; ve $2.$ kole byl aritmetický průměr $9{,}5$ bodu.",
         r"7.1 V $1.$ kole bylo soutěžících s $8$ body o jednoho méně než těch s $10$ body. Určete průměrný bodový zisk všech soutěžících v $1.$ kole.",
         r"7.2 Určete, kolik soutěžících mohlo ve $2.$ kole získat $9$ bodů. Najděte všechna řešení."],
    solp=[r"7.1: nechť je $t$ soutěžících s $10$ body, $t-1$ s $8$ body; $(t-1)+5+t=10\Rightarrow t=3$. Průměr $\frac{8\cdot2+9\cdot5+10\cdot3}{10}=9{,}1$ bodu.",
          r"7.2: $a$ s $8$, $b$ s $9$, $c$ s $10$ body: $a+b+c=10$, $8a+9b+10c=95$; odtud $b+2c=15$, $a=c-5$; pro $c\in\{5,6,7\}$ vychází $b\in\{5,3,1\}$."],
    ans=r"7.1: $9{,}1$ bodu; 7.2: $1$, $3$, nebo $5$ soutěžících",
    codes=["zs2", "r9", "statistika", "argumentace", "slovni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 8", pts=3, mins=5, diff="3",
    zad=[r"Ze čtverce o straně $12\ \mathrm{cm}$ odstřihneme dva shodné trojúhelníky (viz obrázek). Vznikne rovnoramenný lichoběžník, jehož kratší základna má délku $2\ \mathrm{cm}$.",
         r"8.1 Určete, o kolik $\mathrm{cm}^2$ je obsah čtverce větší než obsah lichoběžníku.",
         r"8.2 Vypočtěte v cm obvod lichoběžníku."],
    solp=[r"Lichoběžník má základny $12$ a $2$, výšku $12$; obsah $\frac{12+2}{2}\cdot12=84\ \mathrm{cm}^2$.",
          r"8.1: čtverec $144\ \mathrm{cm}^2$; rozdíl $144-84=60\ \mathrm{cm}^2$.",
          r"8.2: rameno $\sqrt{5^2+12^2}=13\ \mathrm{cm}$; obvod $12+2+13+13=40\ \mathrm{cm}$."],
    ans=r"8.1: o $60\ \mathrm{cm}^2$; 8.2: $40\ \mathrm{cm}$",
    svg=fig(5, (66, 66, 480, 190)), fn=FN,
    alt="Čtverec o straně 12 cm s vyznačenými dvěma odstřiženými trojúhelníky a vzniklý rovnoramenný lichoběžník s kratší základnou 2 cm.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $A$, $A'$ a $M$ (viz obrázek).",
         r"Bod $A$ je vrchol rovnostranného trojúhelníku $ABC$. Na přímce $AM$ leží vrchol $C$. Bod $A'$ je vrchol trojúhelníku $A'B'C$, který je obrazem $ABC$ v osové souměrnosti s osou $o$. Oba trojúhelníky mají společný jen vrchol $C$.",
         r"9.1 Sestrojte osu $o$ a označte ji.",
         r"9.2 Sestrojte všechny chybějící vrcholy obou trojúhelníků, označte je a oba trojúhelníky narýsujte."],
    solp=[r"Vrchol $C$ je společný oběma trojúhelníkům; leží na přímce $AM$. Osa $o$ prochází bodem $C$ a je osou úsečky $AA'$ (souměrnost zobrazuje $A$ na $A'$).",
          r"9.2: $C=AM\cap o$; trojúhelník $ABC$ je rovnostranný ($|AB|=|BC|=|CA|$), $A'B'C$ je jeho obraz v souměrnosti podle $o$."],
    ans=r"Osa $o$ je osou úsečky $AA'$ a prochází bodem $C=AM\cap o$; $ABC$ je rovnostranný a $A'B'C$ jeho obraz v souměrnosti podle $o$.",
    svg=fig(6, (62, 64, 595, 360)), fn=FN,
    alt="Body A, A' a M v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $L$, $M$ a přímka $p$ procházející bodem $M$ (viz obrázek).",
         r"Body $L$, $M$ jsou vrcholy rovnoběžníku $KLMN$. Na přímce $p$ leží střed souměrnosti $S$ rovnoběžníku. Délka strany $LM$ je stejná jako délka úhlopříčky $LN$.",
         r"Sestrojte střed $S$ a vrcholy $K$, $N$, označte je a rovnoběžník narýsujte. Najděte všechna řešení."],
    solp=[r"Střed $S$ je střed úhlopříčky $KM$ i $LN$; leží na přímce $p$ a zároveň je středem úsečky $LN$ s $|LN|=|LM|$.",
          r"Bod $N$ leží na kružnici se středem $L$ a poloměrem $|LM|$; jeho střed s $L$ (tj. $S$) leží na $p$. Odtud $S$, pak $N$ jako obraz $L$ podle $S$ a $K$ jako obraz $M$ podle $S$ (dvě řešení)."],
    ans=r"Střed $S$ leží na $p$ a je středem úsečky $LN$ s $|LN|=|LM|$; $N$ je obraz $L$ a $K$ obraz $M$ podle $S$ (dvě řešení).",
    svg=fig(7, (62, 64, 595, 360)), fn=FN,
    alt="Body L, M a přímka p procházející bodem M.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 11", pts=4, mins=5, diff="4",
    zad=[r"Kružnice se středem $S$ prochází body $A$, $B$, $K$, $L$; úsečky $AB$ a $KL$ se protínají v bodě $S$ (jsou to průměry). V obrázku je vyznačen úhel $64^\circ$ a úhly $\alpha$, $\beta$, $\gamma$, $\delta$.",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"11.1 $\alpha>64^\circ$.",
         r"11.2 $\alpha+\beta>90^\circ$.",
         r"11.3 $\gamma-\alpha>\delta$."],
    solp=[r"$AB$ i $KL$ jsou průměry, trojúhelníky s vrcholy na kružnici jsou rovnoramenné (ramena jsou poloměry).",
          r"Z vlastností rovnoramenných trojúhelníků a vrcholových úhlů u středu $S$ vyjde: $\alpha<64^\circ$ — N; $\alpha+\beta<90^\circ$ — N; $\gamma-\alpha>\delta$ — A."],
    ans=r"11.1: N; 11.2: N; 11.3: A",
    svg=fig(8, (275, 60, 560, 205)), fn=FN,
    alt="Kružnice se středem S procházející body A, B, K, L; úsečky AB a KL se protínají v S; vyznačen úhel 64° a úhly alfa, beta, gama, delta.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 12", pts=2, mins=4, diff="3",
    zad=[r"Povrch malé krychle je o $42\ \mathrm{cm}^2$ menší než povrch velké krychle. Součet délek všech hran malé krychle je $36\ \mathrm{cm}$.",
         r"O kolik $\mathrm{cm}^3$ se liší objem malé a velké krychle?"],
    opts=[r"A) o $14\ \mathrm{cm}^3$", r"B) o $27\ \mathrm{cm}^3$", r"C) o $37\ \mathrm{cm}^3$", r"D) o $46\ \mathrm{cm}^3$", r"E) o jiný objem"],
    solp=[r"Malá krychle: $12a=36\Rightarrow a=3$, povrch $6\cdot9=54\ \mathrm{cm}^2$. Velká: povrch $54+42=96\Rightarrow b^2=16\Rightarrow b=4$.",
          r"Objemy $27$ a $64\ \mathrm{cm}^3$; rozdíl $37\ \mathrm{cm}^3$."],
    ans=r"C) o $37\ \mathrm{cm}^3$",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 13", pts=2, mins=3, diff="3",
    zad=[r"Vlak na druhé koleji má o $3$ vagony více než vlak na první koleji a dvakrát méně vagonů než vlak na třetí koleji. Všechny tři vlaky mají dohromady $41$ vagonů.",
         r"O kolik vagonů více má vlak na třetí koleji než vlak na první koleji?"],
    opts=[r"A) o $8$ vagonů", r"B) o $10$ vagonů", r"C) o $11$ vagonů", r"D) o $13$ vagonů", r"E) o $14$ vagonů"],
    solp=[r"První $v$, druhá $v+3$, třetí $2(v+3)$; $v+(v+3)+2(v+3)=41\Rightarrow 4v+9=41\Rightarrow v=8$.",
          r"Třetí kolej $2\cdot11=22$; rozdíl $22-8=14$ vagonů."],
    ans=r"E) o $14$ vagonů",
    codes=["zs2", "r9", "rovnice", "aritmetika", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 14", pts=2, mins=5, diff="4",
    zad=[r"Jonáš a Beáta zaznamenávali nejvyšší počet jedinců každého ptačího druhu (viz graf). Jonáš spatřil pět druhů, Beáta čtyři z nich. Oba dohromady zaznamenali pěnkav o $6$ méně než sýkor. Jonáš zaznamenal celkem o pětinu více jedinců než Beáta.",
         r"Kolik jedinců brhlíka lesního zaznamenala Beáta?"],
    opts=[r"A) $2$ jedince", r"B) $3$ jedince", r"C) $4$ jedince", r"D) $5$ jedinců", r"E) více než $5$ jedinců"],
    solp=[r"Z grafu se doplní chybějící údaj pomocí podmínek: pěnkav je o $6$ méně než sýkor a Jonáš zaznamenal celkem o pětinu ($20\ \%$) více jedinců než Beáta.",
          r"Dopočtem vychází, že Beáta zaznamenala $2$ jedince brhlíka lesního."],
    ans=r"A) $2$ jedince",
    svg=fig(9, (95, 290, 470, 470)), fn=FN,
    alt="Sloupcový graf nejvyššího počtu jedinců pěti ptačích druhů (kos černý, brhlík lesní, sýkora koňadra, červenka obecná, pěnkava obecná) pro Jonáše a Beátu; jeden údaj chybí.",
    cap="",
    codes=["zs2", "r9", "statistika", "argumentace", "porozumeni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 15", pts=6, mins=6, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Pan Zdeněk bydlí posledních pět osmin svého dosavadního života v Plzni, kam se přestěhoval, když mu bylo $27$ let. Kolik let bydlí v Plzni?",
         r"15.2 Základní škola je v provozu $84$ let, tedy o $75\ \%$ déle než gymnázium. Poměr doby fungování lycea a gymnázia je $2:3$. Kolik let funguje lyceum?",
         r"15.3 Součet věků dvojčat a jejich staršího bratra je $99$ let. Každému z dvojčat je o $40\ \%$ méně let než bratrovi. Kolik let je každému z dvojčat?"],
    opts=[r"A) $22$ let", r"B) $27$ let", r"C) $32$ let", r"D) $45$ let", r"E) $48$ let", r"F) více než $48$ let"],
    solp=[r"15.1: v Plzni je $\frac{5}{8}$ života, přistěhoval se ve $\frac{3}{8}$ života $=27$ let, celý život $72$; v Plzni $\frac{5}{8}\cdot72=45$ let — D.",
          r"15.2: gymnázium $\frac{84}{1{,}75}=48$; lyceum $\frac{2}{3}\cdot48=32$ let — C.",
          r"15.3: dvojče $=0{,}6B$; $2\cdot0{,}6B+B=99\Rightarrow B=45$, dvojče $27$ let — B."],
    ans=r"15.1: D ($45$); 15.2: C ($32$); 15.3: B ($27$)",
    codes=["zs2", "r9", "procenta", "zlomky", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9D · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Hřiště má tvar obdélníku $KLMN$. Po obvodu vede trasa se stanovišti $A$, $B$, $C$, $D$ (viz obrázek); úsečky $AC$ a $BD$ jsou rovnoběžné se stranami a šedý obrazec je čtverec. Úsek $AKB$ měří $45\ \mathrm{m}$, úsek $BLC$ měří $39\ \mathrm{m}$ a úsek $CMD$ měří $30\ \mathrm{m}$.",
         r"16.1 Vypočtěte v metrech rozdíl mezi délkami úseček $BK$ a $BL$.",
         r"16.2 Vypočtěte délku kratší strany hřiště.",
         r"16.3 Vypočtěte obvod hřiště.",
         r"16.4 Vypočtěte vzdálenost stanoviště $D$ od vrcholu $N$."],
    solp=[r"Označme $AK=LC=a$, $BK=b$; z rovnoběžností a délek úseků: $a+b=45$, $(w-b)+a=39$, $(h-a)+(w-b)=30$, kde $w$, $h$ jsou strany. Odtud $2b-w=6$ a $w+h=75$.",
          r"16.1: $BK-BL=b-(w-b)=2b-w=6\ \mathrm{m}$.",
          r"16.2 a 16.3: ze čtvercové podmínky vychází $w=30\ \mathrm{m}$ (kratší strana), $h=45\ \mathrm{m}$; obvod $2(30+45)=150\ \mathrm{m}$.",
          r"16.4: $DN=BK=b=18\ \mathrm{m}$."],
    ans=r"16.1: $6\ \mathrm{m}$; 16.2: $30\ \mathrm{m}$; 16.3: $150\ \mathrm{m}$; 16.4: $18\ \mathrm{m}$",
    svg=fig(11, (295, 66, 560, 168)), fn=FN,
    alt="Obdélníkové hřiště KLMN se stanovišti A, B, C, D na obvodu, úsečkami AC a BD rovnoběžnými se stranami a vyznačeným šedým čtvercem.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bezny-zivot"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9D-2025")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
