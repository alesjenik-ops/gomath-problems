# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9C 2024 (1. náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9C_2024_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2024, 1. náhradní termín (M9C)"
CCODE = "M9PCD24C0T03"
YR = 2024
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2024 M9C · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Města Jihlava a Třebíč mají dohromady $86\,200$ obyvatel. Jihlava má o $16\,000$ obyvatel více. Kolik obyvatel má Třebíč?"],
    solp=[r"$(86\,200-16\,000):2=70\,200:2=35\,100$ obyvatel."],
    ans=r"$35\,100$ obyvatel",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 2", pts=2, mins=3, diff="3",
    zad=[r"Dvě válcové nádoby A a B mají stejnou výšku $v=20\ \mathrm{cm}$. Nádoba A má průměr podstavy $d_1=10\ \mathrm{cm}$, nádoba B $d_2=20\ \mathrm{cm}$. Nádoba A je plná vody, B prázdná.",
         r"Do jaké výšky bude sahat voda v nádobě B, přelijeme-li do ní všechnu vodu z A?"],
    solp=[r"Objem vody $V=\pi\cdot5^2\cdot20=500\pi\ \mathrm{cm}^3$.",
          r"V nádobě B: $\pi\cdot10^2\cdot h=500\pi\Rightarrow h=5\ \mathrm{cm}$."],
    ans=r"$5\ \mathrm{cm}$",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"Vypočítejte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{\frac{7}{5}+3{,}3-\frac{1}{2}}{\frac{1}{15}+\frac{1}{3}}=$",
         r"3.2 \quad $\left(\dfrac{1}{2}+\dfrac{1}{3}:\dfrac{5}{6}\right)-\dfrac{7}{2}+\dfrac{3}{5}:\dfrac{3}{2}-1=$"],
    solp=[r"3.1: čitatel $\frac{7}{5}+3{,}3-\frac{1}{2}=1{,}4+3{,}3-0{,}5=4{,}2=\frac{21}{5}$; jmenovatel $\frac{1}{15}+\frac{1}{3}=\frac{2}{5}$; $\frac{21}{5}:\frac{2}{5}=\frac{21}{2}$.",
          r"3.2: $\frac{1}{3}:\frac{5}{6}=\frac{2}{5}$, $\frac{3}{5}:\frac{3}{2}=\frac{2}{5}$; $\left(\frac{1}{2}+\frac{2}{5}\right)-\frac{7}{2}+\frac{2}{5}-1=\frac{9}{10}-\frac{35}{10}+\frac{4}{10}-\frac{10}{10}=-\frac{16}{5}$."],
    ans=r"3.1: $\frac{21}{2}$; 3.2: $-\frac{16}{5}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 4", pts=4, mins=5, diff="3",
    zad=[r"4.1 Umocněte a zjednodušte (výsledek zlomkem v základním tvaru): $\left(\dfrac{b}{3}-3b\right)^2=$",
         r"4.2 Upravte a rozložte na součin pomocí vzorců: $5-(1-x^2)-x\cdot2x=$",
         r"4.3 Zjednodušte (bez závorek): $(c-7)\cdot(c-7)-(c-5)\cdot3c+c\cdot(c+c)=$"],
    solp=[r"4.1: $\left(\frac{b}{3}-\frac{9b}{3}\right)^2=\left(-\frac{8b}{3}\right)^2=\frac{64b^2}{9}$.",
          r"4.2: $5-1+x^2-2x^2=4-x^2=(2-x)(2+x)$.",
          r"4.3: $(c^2-14c+49)-(3c^2-15c)+2c^2=c+49$."],
    ans=r"4.1: $\frac{64b^2}{9}$; 4.2: $(2-x)(2+x)$; 4.3: $c+49$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnice.",
         r"5.1 \quad $\left(x+\dfrac{1}{2}x\right)\cdot2=\left(x+\dfrac{1}{6}x\right)\cdot2+6$",
         r"5.2 \quad $\dfrac{1}{2}\cdot(x+2)-(x-2)^2=6-x^2$"],
    solp=[r"5.1: $3x=\frac{7}{3}x+6\Rightarrow 9x=7x+18\Rightarrow x=9$.",
          r"5.2: $\frac{x}{2}+1-(x^2-4x+4)=6-x^2\Rightarrow \frac{x}{2}+4x-3=6\Rightarrow \frac{9x}{2}=9\Rightarrow x=2$."],
    ans=r"5.1: $x=9$; 5.2: $x=2$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 6", pts=4, mins=5, diff="3",
    zad=[r"Pravoúhlý lichoběžník $ABCD$ se základnami $AB$, $CD$ a pravým úhlem při vrcholu $D$ je úhlopříčkou $AC$ rozdělen na trojúhelníky $ABC$ a $ACD$. Platí $|AB|=16\ \mathrm{cm}$, $|CD|=6\ \mathrm{cm}$, obsah trojúhelníku $ABC$ je $64\ \mathrm{cm}^2$.",
         r"6.1 Vypočítejte výšku lichoběžníku $ABCD$ (v cm).",
         r"6.2 Vypočítejte obsah lichoběžníku $ABCD$ (v $\mathrm{cm}^2$)."],
    solp=[r"6.1: trojúhelník $ABC$ má základnu $AB=16$; $\frac{16\cdot v}{2}=64\Rightarrow v=8\ \mathrm{cm}$ (výška lichoběžníku).",
          r"6.2: $S=\frac{(16+6)}{2}\cdot8=88\ \mathrm{cm}^2$."],
    ans=r"6.1: $8\ \mathrm{cm}$; 6.2: $88\ \mathrm{cm}^2$",
    svg=fig(5, (66, 66, 480, 240)), fn=FN,
    alt="Pravoúhlý lichoběžník ABCD se základnami AB=16 cm, CD=6 cm, úhlopříčkou AC a obsahem trojúhelníku ABC 64 cm².",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 7", pts=4, mins=5, diff="3",
    zad=[r"V parku jsou $3$ okrasné záhony: první a třetí (stejné) mají tvar čtvrtkruhu, druhý tvar kruhu. Každý záhon má obsah $314\ \mathrm{dm}^2$ (počítejte s $\pi\doteq3{,}14$).",
         r"7.1 Vypočítejte obvod druhého (kruhového) záhonu (v celých metrech).",
         r"7.2 Vypočítejte poloměr $r$ jednoho čtvrtkruhového záhonu (v celých metrech)."],
    solp=[r"7.1: $\pi r_2^2=314\Rightarrow r_2^2=100\Rightarrow r_2=10\ \mathrm{dm}$; obvod $2\pi r_2=62{,}8\ \mathrm{dm}\doteq6\ \mathrm{m}$.",
          r"7.2: $\frac{1}{4}\pi r^2=314\Rightarrow r^2=400\Rightarrow r=20\ \mathrm{dm}=2\ \mathrm{m}$."],
    ans=r"7.1: $6\ \mathrm{m}$; 7.2: $2\ \mathrm{m}$",
    svg=fig(6, (78, 92, 500, 240)), fn=FN,
    alt="Tři okrasné záhony: první a třetí ve tvaru čtvrtkruhu o poloměru r a druhý ve tvaru kruhu.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 8", pts=4, mins=5, diff="4",
    zad=[r"Trojúhelník $ABC$ je vymezen třemi různoběžkami $a$, $b$, $c$. Přímky $a$ a $c$ svírají úhel $130^\circ$ a velikosti úhlů $\alpha$ a $\gamma$ jsou v poměru $2:3$ (viz obrázek).",
         r"8.1 Vypočítejte velikost vnitřního úhlu $\gamma$ při vrcholu $C$.",
         r"8.2 Vypočítejte rozdíl $\alpha-\beta$ vnitřních úhlů."],
    solp=[r"Vnitřní úhel $\beta=180^\circ-130^\circ=50^\circ$; pak $\alpha+\gamma=130^\circ$ a $\alpha:\gamma=2:3$.",
          r"8.1: $\gamma=\frac{3}{5}\cdot130^\circ=78^\circ$.",
          r"8.2: $\alpha=\frac{2}{5}\cdot130^\circ=52^\circ$; $\alpha-\beta=52^\circ-50^\circ=2^\circ$."],
    ans=r"8.1: $\gamma=78^\circ$; 8.2: $\alpha-\beta=2^\circ$",
    svg=fig(7, (78, 72, 520, 325)), fn=FN,
    alt="Trojúhelník ABC vymezený třemi různoběžkami a, b, c; přímky a a c svírají úhel 130°, vyznačeny vnitřní úhly alfa, beta, gama.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží bod $E$ a kružnice $k$ se středem $S$, procházející bodem $A$. Bod $A$ je vrchol pravoúhlého lichoběžníku $ABCD$ se základnami $AB$, $CD$ a pravým úhlem při vrcholu $A$. Vrcholy $C$, $D$ leží na kružnici $k$, bod $E$ je střed ramene $BC$ (viz obrázek).",
         r"Sestrojte zbývající vrcholy $B$, $C$, $D$ lichoběžníku $ABCD$, označte je a lichoběžník narýsujte."],
    solp=[r"Strana $AD$ je kolmá k $AB$ (pravý úhel u $A$); $D$ leží na kružnici $k$.",
          r"Kružnice $k$ je Thaletova kružnice trojúhelníku $ACD$ s přeponou $AC$ a pravým úhlem u $D$; vrchol $D$ i $C$ leží na $k$.",
          r"Bod $E$ jako střed ramene $BC$ a kolmost stran určí vrcholy $B$ a $C$; lichoběžník dokreslíme."],
    ans=r"Konstrukce pravoúhlého lichoběžníku $ABCD$; $D$ na kružnici $k$ (Thaletova kružnice trojúhelníku $ACD$), $E$ střed $BC$ (viz postup).",
    svg=fig(8, (62, 66, 595, 380)), fn=FN,
    alt="Bod E a kružnice k se středem S procházející bodem A.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 10", pts=3, mins=5, diff="4",
    zad=[r"V rovině je dána přímka $o$ a body $A$, $S$, které na $o$ neleží. Bod $A$ je vrchol rovnoramenného lichoběžníku $ABCD$, bod $S$ je střed strany $BC$ a přímka $o$ je osa souměrnosti lichoběžníku (viz obrázek).",
         r"Sestrojte lichoběžník $ABCD$."],
    solp=[r"Osová souměrnost podle $o$ zobrazuje $A$ na $B$; vrchol $B$ je obrazem $A$ v souměrnosti podle $o$.",
          r"Bod $S$ je střed strany $BC$; vrchol $C$ dopočteme na polopřímce $BS$ tak, aby $|BS|=|SC|$, a $D$ jako obraz $C$ podle $o$."],
    ans=r"Vrchol $B$ je obraz $A$ v souměrnosti podle osy $o$; $C$ dopočteme ze středu $S$ strany $BC$ a $D$ jako obraz $C$ podle $o$.",
    svg=fig(9, (62, 66, 595, 380)), fn=FN,
    alt="Přímka o a body A, S, které na ní neleží.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 11", pts=2, mins=3, diff="3",
    zad=[r"Krychle má hranu $3\ \mathrm{dm}$. Krychli rozdělíme vodorovným řezem na dva shodné hranoly a vytvoříme nové těleso (viz obrázek).",
         r"O kolik $\mathrm{dm}^2$ se zvětší povrch nového tělesa?"],
    opts=[r"A) o $4{,}5\ \mathrm{dm}^2$", r"B) o $9\ \mathrm{dm}^2$", r"C) o $18\ \mathrm{dm}^2$", r"D) oba povrchy jsou stejné", r"E) jiný výsledek"],
    solp=[r"Řezem vzniknou dvě nové čtvercové plochy o obsahu $3\cdot3=9\ \mathrm{dm}^2$.",
          r"Povrch se zvětší o $2\cdot9=18\ \mathrm{dm}^2$."],
    ans=r"C) o $18\ \mathrm{dm}^2$",
    svg=fig(10, (78, 100, 470, 245)), fn=FN,
    alt="Krychle o hraně 3 dm a nové těleso vzniklé rozdělením krychle vodorovným řezem na dva hranoly.",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 12", pts=2, mins=4, diff="3",
    zad=[r"Eva a Michal šetří na dárek. Eva našetřila $40\ \%$ potřebné částky, Michal o $24$ korun více než Eva. Zbývá našetřit $72$ korun.",
         r"Kolik korun stojí dárek?"],
    opts=[r"A) $96$ Kč", r"B) $120$ Kč", r"C) $480$ Kč", r"D) $1\,920$ Kč", r"E) jiný výsledek"],
    solp=[r"Cena $C$: Eva $0{,}4C$, Michal $0{,}4C+24$; $0{,}4C+(0{,}4C+24)+72=C\Rightarrow 0{,}2C=96\Rightarrow C=480$ Kč."],
    ans=r"C) $480$ Kč",
    codes=["zs2", "r9", "procenta", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 13", pts=2, mins=4, diff="3",
    zad=[r"Těsně před představením bylo obsazeno $70\ \%$ sedadel. Po začátku přišlo dalších $11$ lidí a obsazenost se zvýšila na $75\ \%$.",
         r"Jaká je kapacita sálu?"],
    opts=[r"A) méně než $200$", r"B) $200$", r"C) $210$", r"D) $220$", r"E) více než $220$"],
    solp=[r"Rozdíl $75\ \%-70\ \%=5\ \%$ odpovídá $11$ lidem; kapacita $\frac{11}{0{,}05}=220$."],
    ans=r"D) $220$",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 14", pts=2, mins=4, diff="3",
    zad=[r"Petr přečetl o $3$ komiksy více než Cyril, Honza o osminu komiksů více než Cyril. Petr a Honza přečetli stejný počet komiksů.",
         r"Kolik komiksů přečetl Petr?"],
    opts=[r"A) $22$", r"B) $24$", r"C) $25$", r"D) $26$", r"E) $27$"],
    solp=[r"Cyril $c$: Petr $c+3$, Honza $\frac{9}{8}c$; $c+3=\frac{9}{8}c\Rightarrow 3=\frac{1}{8}c\Rightarrow c=24$; Petr $27$."],
    ans=r"E) $27$",
    codes=["zs2", "r9", "rovnice", "zlomky", "slovni", "modelovani", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 15", pts=3, mins=5, diff="3",
    zad=[r"Žáci 9. A a 9. B uvedli, jakou střední školu chtějí: gymnázium (GYM), SOŠ, nebo SOU. Na GYM chce $12$ žáků, na SOU $16\ \%$ žáků, na SOŠ všichni ostatní. Na uměleckou SOŠ chtějí $3$ žáci, na technickou $15$ žáků, zbytek SOŠ humanitní (viz grafy).",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"15.1 Na uměleckou střední školu chce jít $6\ \%$ všech žáků.",
         r"15.2 V 9. A a 9. B je celkem více než $50$ žáků.",
         r"15.3 Na gymnázia a na humanitní střední školy se chce hlásit stejný počet žáků."],
    solp=[r"GYM $=100\ \%-60\ \%-16\ \%=24\ \%$; $12$ žáků $=24\ \%$, celkem $50$ žáků. SOŠ $60\ \%=30$ žáků.",
          r"15.1: umělecké $3$ z $50$ je $6\ \%$ — A.",
          r"15.2: celkem $50$ žáků, nikoli více — N.",
          r"15.3: humanitní SOŠ $30-15-3=12=$ GYM $12$ — A."],
    ans=r"15.1: A; 15.2: N; 15.3: A",
    svg=fig(12, (78, 115, 500, 350)), fn=FN,
    alt="Dva kruhové diagramy: zájem o GYM, SOŠ, SOU a rozdělení SOŠ podle zaměření (technické, humanitní, umělecké).",
    cap="",
    codes=["zs2", "r9", "procenta", "statistika", "porozumeni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9C · úloha 16", pts=6, mins=6, diff="3",
    zad=[r"Deset zedníků dokončí stavbu za $20$ dní (všichni stejně výkonní). Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).",
         r"16.1 Za kolik dní dokončí stavbu $4$ zedníci?",
         r"16.2 Kolik zedníků dokončí stavbu za $5$ dní?",
         r"16.3 Kolik dní bude trvat stavba, jestliže na první polovině pracuje $8$ zedníků a současně na druhé polovině $10$ zedníků?"],
    opts=[r"A) $10$", r"B) $12{,}5$", r"C) $22{,}5$", r"D) $40$", r"E) $50$", r"F) $52{,}5$"],
    solp=[r"Celková práce je $10\cdot20=200$ zednídní.",
          r"16.1: $\frac{200}{4}=50$ dní — E.",
          r"16.2: $\frac{200}{5}=40$ zedníků — D.",
          r"16.3: první polovina ($100$) s $8$ zedníky trvá $12{,}5$ dne, druhá ($100$) s $10$ zedníky $10$ dní; obě probíhají současně, stavba trvá $12{,}5$ dne — B."],
    ans=r"16.1: E ($50$); 16.2: D ($40$); 16.3: B ($12{,}5$)",
    codes=["zs2", "r9", "aritmetika", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9C-2024")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
