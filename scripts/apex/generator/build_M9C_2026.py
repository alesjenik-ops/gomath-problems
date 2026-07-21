# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9C 2026 (1. náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9C_2026_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2026, 1. náhradní termín (M9C)"
CCODE = "M9PCD26C0T03"
YR = 2026
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2026 M9C · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Pan Červený strávil jízdou v autě přesně $7$ hodin, než dojel do cíle. Svou jízdu autem zahájil ráno v $7{:}44$ a přerušil ji jen jednou, když si udělal pauzu na oběd. Z auta vystoupil ve $12{:}02$ a do auta se vrátil za $38$ minut. Pak pokračoval v jízdě až do cíle.",
         r"Určete, kdy pan Červený dorazil do cíle. Výsledek zapište ve tvaru hodiny : minuty."],
    solp=[r"K času jízdy $7$ hodin je nutné přičíst $38$ minut přestávky.",
          r"$7{:}44 + 7\ \mathrm{h} = 14{:}44$, poté $+\,38\ \mathrm{min} = 15{:}22$."],
    ans=r"$15{:}22$",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 2", pts=4, mins=5, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem:",
         r"2.1 \quad $\dfrac{6}{5}:\dfrac{9}{15}-2=$",
         r"2.2 \quad $\dfrac{5}{44}\cdot(-5{,}5)=$",
         r"2.3 \quad $\dfrac{\frac{5}{3}-\frac{3}{5}}{\frac{8}{7}\cdot\frac{14}{5}}=$"],
    solp=[r"2.1: $\frac{6}{5}\cdot\frac{15}{9}-2=\frac{90}{45}-2=2-2=0$.",
          r"2.2: $\frac{5}{44}\cdot\left(-\frac{11}{2}\right)=-\frac{55}{88}=-\frac{5}{8}$.",
          r"2.3: čitatel $\frac{5}{3}-\frac{3}{5}=\frac{16}{15}$, jmenovatel $\frac{8}{7}\cdot\frac{14}{5}=\frac{16}{5}$; $\frac{16}{15}:\frac{16}{5}=\frac{1}{3}$."],
    ans=r"2.1: $0$; 2.2: $-\frac{5}{8}$; 2.3: $\frac{1}{3}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"3.1 Rozložte na součin užitím vzorce: $6\cdot 6-25a^2=$",
         r"3.2 Roznásobte a upravte (výsledný výraz nesmí obsahovat závorky): $4\cdot\left(n-\dfrac{1}{2}\right)^2=$",
         r"3.3 Upravte na co nejjednodušší tvar bez závorek: $(3-x)\cdot(3+x)+(x^2+2)\cdot3-2x\cdot(x+1)=$"],
    solp=[r"3.1: $36-25a^2=(6+5a)(6-5a)$.",
          r"3.2: $4\left(n^2-n+\frac{1}{4}\right)=4n^2-4n+1$.",
          r"3.3: $(9-x^2)+(3x^2+6)-(2x^2+2x)=9-x^2+3x^2+6-2x^2-2x=-2x+15$."],
    ans=r"3.1: $(6+5a)(6-5a)$; 3.2: $4n^2-4n+1$; 3.3: $-2x+15$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 Řešte rovnici: $2+\dfrac{x-6}{7}-\dfrac{x}{14}=\dfrac{4+x}{2}$",
         r"4.2 Řešte soustavu rovnic: $\begin{aligned}2x-3y&=-6\\ 2x-y&=2\end{aligned}$"],
    solp=[r"4.1: vynásobíme $14$: $28+2(x-6)-x=7(4+x)\Rightarrow 16+x=28+7x\Rightarrow -12=6x\Rightarrow x=-2$.",
          r"4.2: odečtením rovnic $-2y=-8\Rightarrow y=4$; dosazením $2x-4=2\Rightarrow x=3$."],
    ans=r"4.1: $x=-2$; 4.2: $x=3$, $y=4$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "soustava", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 5", pts=3, mins=5, diff="3",
    zad=[r"Do fitcentra mají přístup členové klubu i běžní návštěvníci. Člen klubu zaplatí na začátku roku jednorázový poplatek $600$ korun a za každý vstup platí $120$ korun. Běžný návštěvník platí za každý vstup $160$ korun. Tereza je členkou klubu, Mirek platí běžné vstupné.",
         r"Počet Tereziných letošních vstupů označíme $x$.",
         r"5.1 Vyjádřete výrazem s proměnnou $x$, kolik korun Tereza letos celkem zaplatila fitcentru.",
         r"5.2 Tereza s Mirkem navštěvují fitcentrum vždy společně. Mirek zaplatil letos za všechny vstupy stejnou částku jako Tereza. Vypočtěte, kolikrát Tereza letos navštívila fitcentrum."],
    solp=[r"5.1: $120x+600$ korun.",
          r"5.2: Mirek platí $160x$; z $160x=120x+600$ plyne $40x=600$, tedy $x=15$."],
    ans=r"5.1: $120x+600$; 5.2: $15$krát",
    codes=["zs2", "r9", "rovnice", "algebra", "slovni", "modelovani", "s-kalkulackou", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 6", pts=3, mins=5, diff="3",
    zad=[r"První šestiúhelník se skládá ze dvou shodných bílých rovnostranných trojúhelníků a dvou shodných šedých trojúhelníků. Trojúhelníky přeskládáme do druhého šestiúhelníku (viz obrázek). Nejdelší strana šedého trojúhelníku měří $10\ \mathrm{cm}$. Obvod prvního šestiúhelníku je $40\ \mathrm{cm}$ a obvod druhého šestiúhelníku je $46\ \mathrm{cm}$.",
         r"6.1 Určete v cm délku jedné strany bílého rovnostranného trojúhelníku.",
         r"6.2 Určete v cm obvod šedého trojúhelníku."],
    solp=[r"Označíme stranu bílého rovnostranného trojúhelníku $w$ a strany šedého trojúhelníku (nejdelší $10\ \mathrm{cm}$).",
          r"Z obvodů obou šestiúhelníků ($40\ \mathrm{cm}$ a $46\ \mathrm{cm}$) a délky nejdelší strany šedého trojúhelníku vychází $w=7\ \mathrm{cm}$.",
          r"Obvod šedého trojúhelníku je pak $23\ \mathrm{cm}$."],
    ans=r"6.1: $7\ \mathrm{cm}$; 6.2: $23\ \mathrm{cm}$",
    svg=fig(3, (75, 458, 595, 588)), fn=FN,
    alt="Dva shodné bílé rovnostranné trojúhelníky a dva shodné šedé trojúhelníky přeskládané ze prvního do druhého šestiúhelníku.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 7", pts=3, mins=5, diff="4",
    zad=[r"Slepením šedé krychle s povrchem $54\ \mathrm{cm}^2$ a bílého hranolu vznikne velký hranol $ABCDEFGH$ (viz obrázek). Nejdelší hrana bílého hranolu je o polovinu delší než hrana šedé krychle.",
         r"7.1 Vypočtěte v cm délku hrany šedé krychle.",
         r"7.2 Vypočtěte v $\mathrm{cm}^3$ objem velkého hranolu $ABCDEFGH$."],
    solp=[r"7.1: $6a^2=54\Rightarrow a^2=9\Rightarrow a=3\ \mathrm{cm}$.",
          r"7.2: nejdelší hrana bílého hranolu je $1{,}5\cdot3=4{,}5\ \mathrm{cm}$; bílý hranol má rozměry $3\times3\times4{,}5$, objem $40{,}5\ \mathrm{cm}^3$.",
          r"Krychle má objem $27\ \mathrm{cm}^3$, celkem $27+40{,}5=67{,}5\ \mathrm{cm}^3$."],
    ans=r"7.1: $3\ \mathrm{cm}$; 7.2: $67{,}5\ \mathrm{cm}^3$",
    svg=fig(4, (300, 60, 595, 190)), fn=FN,
    alt="Velký kvádr ABCDEFGH složený ze šedé krychle a bílého hranolu.",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 8", pts=3, mins=5, diff="4",
    zad=[r"V náčrtku pravidelného pětiúhelníku $ABCDE$ jsou vyznačeny dvě z jeho os souměrnosti $o_1$, $o_2$, jejich průsečík $S$, úsečka $AD$ a velikost úhlu $36^\circ$ (viz obrázek).",
         r"Vypočtěte ve stupních velikost úhlu (velikosti neměřte, ale vypočtěte):",
         r"8.1 $\varphi$,",
         r"8.2 $\omega$."],
    solp=[r"Vnitřní úhel pravidelného pětiúhelníku je $108^\circ$; osa souměrnosti tento úhel půlí.",
          r"8.1: $\varphi=54^\circ$.",
          r"8.2: $\omega=36^\circ$."],
    ans=r"8.1: $\varphi=54^\circ$; 8.2: $\omega=36^\circ$",
    svg=fig(4, (315, 470, 595, 712)), fn=FN,
    alt="Náčrtek pravidelného pětiúhelníku ABCDE se dvěma osami souměrnosti o1, o2, průsečíkem S, úsečkou AD a vyznačeným úhlem 36 stupňů.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).",
         r"Bod $A$ je vrchol rovnoramenného trojúhelníku $ABC$, jehož strany $AC$ a $BC$ mají stejnou délku. Bod $S$ je střed strany $AC$ a na přímce $p$ leží střed $P$ strany $BC$ trojúhelníku $ABC$.",
         r"Sestrojte vrchol $C$, střed $P$ a vrchol $B$, označte je písmeny a narýsujte trojúhelník $ABC$. Najděte všechna řešení."],
    solp=[r"Protože $S$ je střed strany $AC$, je vrchol $C$ obrazem bodu $A$ ve středové souměrnosti podle $S$ (tj. $|SC|=|SA|$).",
          r"Vrchol $B$ leží na kružnici se středem $C$ a poloměrem $|CA|$ (ramena $AC$ a $BC$ jsou shodná) tak, aby střed $P$ strany $BC$ ležel na přímce $p$.",
          r"Úloha má dvě řešení (dva vyhovující vrcholy $B$)."],
    ans=r"Vrchol $C$ je obraz $A$ ve středové souměrnosti podle $S$; vrchol $B$ leží na kružnici $(C,|CA|)$ tak, že střed $P$ strany $BC$ leží na $p$ (dvě řešení).",
    svg=fig(5, (66, 88, 595, 382)), fn=FN,
    alt="Body A, S a přímka p procházející bodem A.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 10", pts=2, mins=5, diff="4",
    zad=[r"V rovině leží body $U$, $V$ a přímka $k$ (viz obrázek).",
         r"Bod $U$ leží uvnitř strany $KN$ obdélníku $KLMN$. Na přímce $k$ leží strana $KL$ tohoto obdélníku. Bod $V$ má stejnou vzdálenost od všech čtyř vrcholů obdélníku $KLMN$.",
         r"Sestrojte všechny vrcholy obdélníku $KLMN$, označte je písmeny a obdélník narýsujte."],
    solp=[r"Bod $V$ stejně vzdálený od všech vrcholů je průsečík úhlopříček, tedy střed obdélníku.",
          r"Vrcholy $K$, $L$ leží na přímce $k$; vzdálenost $V$ od $k$ je polovina strany $KN$, proto patu kolmice z $V$ na $k$ a bod $U$ využijeme k určení strany $KN$.",
          r"Sestrojíme kolmici z $V$ na $k$ (její pata je střed strany $KL$), z bodu $U$ dopočítáme vrcholy $K$, $N$ a osovou souměrností podle $V$ pak $M$, $L$."],
    ans=r"Bod $V$ je střed obdélníku (průsečík úhlopříček); $K$, $L$ leží na $k$, strana $KN$ prochází bodem $U$ (viz konstrukce).",
    svg=fig(6, (66, 66, 595, 382)), fn=FN,
    alt="Body U, V a přímka k.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 11", pts=4, mins=5, diff="3",
    zad=[r"Tábor začal v pondělí snídaní a skončil v pátek po obědě. U snídaně měly mít službu vždy $4$ osoby, u oběda $5$ osob a u večeře také $5$ osob. Každé z $35$ dětí mělo službu v kuchyni právě jednou za celý tábor. Požadovaný počet osob vždy doplnili instruktoři, kteří měli službu společně s dětmi; každý instruktor měl službu nejvýše jedenkrát za den. V grafu je uveden pouze rozpis služeb dětí, oba páteční údaje chybí.",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), nebo nepravdivé (N):",
         r"11.1 V pátek mělo službu v kuchyni celkem $9$ dětí.",
         r"11.2 U každého jídla měli službu v kuchyni společně s dětmi nejvýše $3$ instruktoři.",
         r"11.3 Instruktorů muselo být na táboře nejméně $8$."],
    solp=[r"Celkem je $35$ dětí; z grafu se sečtou služby dětí od pondělí do čtvrtka a dopočítá pátek.",
          r"11.1: v pátek (snídaně $+$ oběd) mělo službu jiný počet dětí než $9$ — N.",
          r"11.2: u některého jídla doplňovali děti více než $3$ instruktoři — N.",
          r"11.3: instruktorů muselo být nejméně $8$ — A."],
    ans=r"11.1: N; 11.2: N; 11.3: A",
    svg=fig(7, (80, 126, 500, 340)), fn=FN,
    alt="Sloupcový graf rozpisu služeb dětí (snídaně, oběd, večeře) od pondělí do čtvrtka; oba páteční údaje chybí.",
    cap="",
    codes=["zs2", "r9", "statistika", "porozumeni", "slovni", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 12", pts=2, mins=3, diff="3",
    zad=[r"Jan použil připojení s rychlostí nahrávání $36\ \mathrm{Mb}$ za sekundu a nahrání videa mu trvalo $1$ hodinu. Karel použil připojení s rychlostí nahrávání $54\ \mathrm{Mb}$ za sekundu (rychlost byla stálá).",
         r"Kolik minut trvalo nahrání videa Karlovi?"],
    opts=[r"A) $40$ minut", r"B) $45$ minut", r"C) $60$ minut", r"D) $90$ minut", r"E) jiný počet minut"],
    solp=[r"Velikost videa: $36\ \mathrm{Mb/s}\cdot3600\ \mathrm{s}=129\,600\ \mathrm{Mb}$.",
          r"Karlovi: $129\,600:54=2\,400\ \mathrm{s}=40$ minut."],
    ans=r"A) $40$ minut",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 13", pts=2, mins=3, diff="2",
    zad=[r"Na tržišti se vyměňuje zboží. Jedna husa se vymění za $48\ \mathrm{kg}$ brambor, jedna slepice za $18\ \mathrm{kg}$ brambor.",
         r"Za kolik hus se vymění stejné množství brambor jako za $40$ slepic?"],
    opts=[r"A) za $20$ hus", r"B) za $18$ hus", r"C) za $16$ hus", r"D) za $15$ hus", r"E) za $12$ hus"],
    solp=[r"$40$ slepic $=40\cdot18=720\ \mathrm{kg}$ brambor.",
          r"$720:48=15$ hus."],
    ans=r"D) za $15$ hus",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 14", pts=2, mins=4, diff="3",
    zad=[r"Běžeckých závodů se zúčastnilo celkem $60$ soutěžících ve dvoučlenných a čtyřčlenných štafetách; vytvořili $21$ štafet. Každý soutěžící běžel pouze v jedné štafetě.",
         r"Jaká část soutěžících běžela ve čtyřčlenných štafetách?"],
    opts=[r"A) $\frac{3}{10}$", r"B) $\frac{7}{20}$", r"C) $\frac{3}{5}$", r"D) $\frac{2}{3}$", r"E) jiná část"],
    solp=[r"Nechť $a$ je počet dvoučlenných a $b$ čtyřčlenných štafet: $a+b=21$, $2a+4b=60$.",
          r"Odtud $b=9$, čtyřčlenných běžců $4\cdot9=36$; jejich část je $\frac{36}{60}=\frac{3}{5}$."],
    ans=r"C) $\frac{3}{5}$",
    codes=["zs2", "r9", "rovnice", "soustava", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 15", pts=6, mins=6, diff="3",
    zad=[r"Každý z $80$ prvňáků dostal školní sadu; všechny sady dohromady stály $36\,000$ korun. Sada obsahuje slabikář a balíček na malování (tempery a pastelky).",
         r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Každý prvňák zaplatil za sadu $90$ korun a zbytek uhradila škola. Kolik procent z ceny sady uhradila škola?",
         r"15.2 Poměr ceny temper ku ceně pastelek byl $3:2$. O kolik procent byla cena temper vyšší než cena pastelek?",
         r"15.3 Cena slabikáře byla o $50$ korun vyšší než cena balíčku na malování. O kolik procent byla cena slabikáře vyšší než cena balíčku?"],
    opts=[r"A) $20\ \%$", r"B) $25\ \%$", r"C) $30\ \%$", r"D) $40\ \%$", r"E) $50\ \%$", r"F) více než $50\ \%$"],
    solp=[r"Cena jedné sady: $36\,000:80=450$ korun.",
          r"15.1: škola uhradila $450-90=360$ korun, tj. $360:450=80\ \%$ — F.",
          r"15.2: $(3-2):2=50\ \%$ — E.",
          r"15.3: balíček $200$ Kč, slabikář $250$ Kč; $(250-200):200=25\ \%$ — B."],
    ans=r"15.1: F (více než $50\ \%$); 15.2: E ($50\ \%$); 15.3: B ($25\ \%$)",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "s-kalkulackou", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9C · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"První obrazec je čtverec. Druhý obrazec má tvar obdélníku a vznikl z prvního přidáním dvou menších čtverců. Každý další obrazec vznikne tak, že u kratší strany předchozího obrazce přidáme tolik menších čtverců, kolikátý obrazec vytváříme (viz obrázek). Delší strana $4.$ obrazce měří $125\ \mathrm{cm}$.",
         r"16.1 Vypočtěte, kolik cm měří strana $1.$ obrazce.",
         r"16.2 Vypočtěte, o kolik $\mathrm{cm}^2$ se liší obsah $4.$ obrazce a obsah $5.$ obrazce.",
         r"16.3 Vypočtěte, kolik cm měří obvod $6.$ obrazce."],
    solp=[r"Kratší strana je stále $S$ (strana $1.$ obrazce); do $n$-tého obrazce přidáme $n$ čtverců o straně $\frac{S}{n}$, takže delší strana vzroste o $\frac{S}{n}$.",
          r"16.1: delší strana $4.$ obrazce $=S\left(1+\frac{1}{2}+\frac{1}{3}+\frac{1}{4}\right)=\frac{25}{12}S=125$, tedy $S=60\ \mathrm{cm}$.",
          r"16.2: delší strana $5.$ obrazce $=125+\frac{60}{5}=137\ \mathrm{cm}$; rozdíl obsahů $60\cdot(137-125)=720\ \mathrm{cm}^2$.",
          r"16.3: delší strana $6.$ obrazce $=137+\frac{60}{6}=147\ \mathrm{cm}$; obvod $2\cdot(147+60)=414\ \mathrm{cm}$."],
    ans=r"16.1: $60\ \mathrm{cm}$; 16.2: o $720\ \mathrm{cm}^2$; 16.3: $414\ \mathrm{cm}$",
    svg=fig(10, (66, 122, 580, 214)), fn=FN,
    alt="Posloupnost obrazců: čtverec a rostoucí obdélníky vznikající přidáváním menších čtverců (1. až 3. obrazec).",
    cap="",
    codes=["zs2", "r9", "posloupnosti", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9C-2026")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
