# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9B 2024 (2. řádný termín, skenované PDF)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9B_2024_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2024, 2. řádný termín (M9B)"
CCODE = "M9PBD24C0T02"
YR = 2024
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2024 M9B · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Josef má krok $75\ \mathrm{cm}$, Naďa $60\ \mathrm{cm}$; oba ušli $10\,000$ kroků. O kolik kilometrů ušel Josef více než Naďa?"],
    solp=[r"Josef $10\,000\cdot75=750\,000\ \mathrm{cm}=7{,}5\ \mathrm{km}$; Naďa $10\,000\cdot60=600\,000\ \mathrm{cm}=6\ \mathrm{km}$.",
          r"Rozdíl $7{,}5-6=1{,}5\ \mathrm{km}$."],
    ans=r"o $1{,}5\ \mathrm{km}$",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 2", pts=2, mins=4, diff="3",
    zad=[r"Adam a Ota jdou z místa A do místa C. Adam jde po rovných silnicích přes místo B (úsek $AB=40\ \mathrm{m}$, $BC=30\ \mathrm{m}$, pravý úhel u B), Ota jde zkratkou přímo z A do C (viz obrázek).",
         r"O kolik procent je Adamova cesta delší než cesta, kterou jde Ota?"],
    solp=[r"Adam ujde $40+30=70\ \mathrm{m}$; Ota (úhlopříčka) $\sqrt{40^2+30^2}=50\ \mathrm{m}$.",
          r"$\frac{70-50}{50}=\frac{20}{50}=40\ \%$."],
    ans=r"o $40\ \%$",
    svg=fig(2, (185, 470, 470, 660)), fn=FN,
    alt="Obdélník ABC: Adam jde z A do B (40 m) a do C (30 m, pravý úhel u B), Ota jde úhlopříčkou z A do C.",
    cap="",
    codes=["zs2", "r9", "geometrie", "procenta", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"Vypočítejte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\left(\dfrac{3}{4}+\dfrac{4}{3}\right)\cdot\left(\dfrac{2}{3}-\dfrac{6}{5}\right)=$",
         r"3.2 \quad $\dfrac{\frac{5}{9}-\frac{3}{2}:\frac{3}{5}}{\frac{2}{3}+\frac{1}{6}-\frac{7}{12}}=$"],
    solp=[r"3.1: $\left(\frac{9}{12}+\frac{16}{12}\right)\cdot\left(\frac{10}{15}-\frac{18}{15}\right)=\frac{25}{12}\cdot\left(-\frac{8}{15}\right)=-\frac{10}{9}$.",
          r"3.2: čitatel $\frac{5}{9}-\frac{3}{2}\cdot\frac{5}{3}=\frac{5}{9}-\frac{5}{2}=-\frac{35}{18}$; jmenovatel $\frac{8+2-7}{12}=\frac{1}{4}$; $-\frac{35}{18}:\frac{1}{4}=-\frac{70}{9}$."],
    ans=r"3.1: $-\frac{10}{9}$; 3.2: $-\frac{70}{9}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 4", pts=4, mins=5, diff="3",
    zad=[r"4.1 Umocněte: $(-3-2x)^2=$",
         r"4.2 Upravte a rozložte na součin podle vzorce: $6\,400-(x^2-3\,600)=$",
         r"4.3 Zjednodušte (bez závorek): $(3x+1)^2-x\cdot7x-(2x-5)\cdot(x+4)=$"],
    solp=[r"4.1: $(3+2x)^2=4x^2+12x+9$.",
          r"4.2: $6\,400-x^2+3\,600=10\,000-x^2=(100-x)(100+x)$.",
          r"4.3: $(9x^2+6x+1)-7x^2-(2x^2+3x-20)=3x+21$."],
    ans=r"4.1: $4x^2+12x+9$; 4.2: $(100-x)(100+x)$; 4.3: $3x+21$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnice.",
         r"5.1 \quad $1{,}6:2-\dfrac{x}{2}=3\cdot0{,}7x+3{,}4$",
         r"5.2 \quad $\dfrac{5-2y}{3}+\dfrac{y}{9}=\dfrac{3-y}{6}$"],
    solp=[r"5.1: $0{,}8-\frac{x}{2}=2{,}1x+3{,}4\Rightarrow -0{,}5x-2{,}1x=2{,}6\Rightarrow -2{,}6x=2{,}6\Rightarrow x=-1$.",
          r"5.2: vynásobením $18$: $6(5-2y)+2y=3(3-y)\Rightarrow 30-10y=9-3y\Rightarrow 21=7y\Rightarrow y=3$."],
    ans=r"5.1: $x=-1$; 5.2: $y=3$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 6", pts=4, mins=5, diff="4",
    zad=[r"Čtyřúhelník $ABCD$ je lichoběžník se základnami $AB$ a $CD$, přičemž úsečka $BD$ je jeho výška. Platí $|AD|=17\ \mathrm{cm}$, $|BD|=8\ \mathrm{cm}$ a obsah trojúhelníku $BCD$ je $24\ \mathrm{cm}^2$ (viz obrázek).",
         r"6.1 Vypočítejte obsah lichoběžníku $ABCD$ (v $\mathrm{cm}^2$).",
         r"6.2 Vypočítejte obvod lichoběžníku $ABCD$ (v cm)."],
    solp=[r"$BD\perp AB$, tedy v trojúhelníku $ABD$: $AB=\sqrt{AD^2-BD^2}=\sqrt{17^2-8^2}=15\ \mathrm{cm}$. Z obsahu $BCD$: $\frac{CD\cdot8}{2}=24\Rightarrow CD=6\ \mathrm{cm}$.",
          r"6.1: $S=\frac{15+6}{2}\cdot8=84\ \mathrm{cm}^2$.",
          r"6.2: $BC=\sqrt{6^2+8^2}=10\ \mathrm{cm}$; obvod $15+10+6+17=48\ \mathrm{cm}$."],
    ans=r"6.1: $84\ \mathrm{cm}^2$; 6.2: $48\ \mathrm{cm}$",
    svg=fig(5, (300, 108, 595, 300)), fn=FN,
    alt="Lichoběžník ABCD se základnami AB, CD a výškou BD; AD=17 cm, BD=8 cm, obsah trojúhelníku BCD je 24 cm².",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 7", pts=4, mins=5, diff="3",
    zad=[r"Petr sbírá modely aut. Druhý rok nasbíral o polovinu počtu modelů více než první rok. Třetí rok nasbíral $72$ modelů. Počet modelů z prvního roku označíme $x$.",
         r"7.1 Vyjádřete výrazem s proměnnou $x$, kolik modelů nasbíral druhý rok.",
         r"7.2 Vypočítejte, kolik modelů nasbíral první rok, pokud za tři roky nasbíral $217$ modelů."],
    solp=[r"7.1: druhý rok $x+\frac{1}{2}x=1{,}5x$.",
          r"7.2: $x+1{,}5x+72=217\Rightarrow 2{,}5x=145\Rightarrow x=58$."],
    ans=r"7.1: $1{,}5x$; 7.2: $58$ modelů",
    codes=["zs2", "r9", "vyrazy", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 8", pts=4, mins=5, diff="4",
    zad=[r"Obrazce jsou tvořeny z velkých bílých a malých tmavých kruhů. $1.$ obrazec tvoří $1$ bílý kruh; $2.$ obrazec $4$ bílé kruhy (středy tvoří vrcholy čtverce) a $1$ tmavý uprostřed; $3.$ obrazec $9$ bílých a $4$ tmavé kruhy atd. (viz obrázek).",
         r"8.1 Kolik velkých bílých kruhů obsahuje osmý obrazec?",
         r"8.2 Kolikátý obrazec obsahuje $361$ malých tmavých kruhů?"],
    solp=[r"$n$-tý obrazec má $n^2$ bílých a $(n-1)^2$ tmavých kruhů.",
          r"8.1: $8^2=64$ bílých kruhů.",
          r"8.2: $(n-1)^2=361\Rightarrow n-1=19\Rightarrow n=20$, tedy $20.$ obrazec."],
    ans=r"8.1: $64$; 8.2: $20.$ obrazec",
    svg=fig(7, (100, 235, 545, 380)), fn=FN,
    alt="Posloupnost obrazců z velkých bílých a malých tmavých kruhů (1., 2. a 3. obrazec).",
    cap="",
    codes=["zs2", "r9", "posloupnosti", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině jsou dány body $A$, $B$ a $O$. Body $A$, $B$ jsou vrcholy kosočtverce $ABCD$; vrchol $C$ leží na přímce $OA$ (viz obrázek).",
         r"Sestrojte kosočtverec $ABCD$."],
    solp=[r"Vrchol $C$ leží na přímce $OA$ a zároveň $|BC|=|AB|$ (strana kosočtverce), tedy $C$ je průsečík přímky $OA$ s kružnicí $(B,|AB|)$.",
          r"Vrchol $D$ dopočteme jako $D=A+C-B$ (protilehlý vrchol kosočtverce), resp. z rovnoběžnosti stran."],
    ans=r"Vrchol $C$ je průsečík přímky $OA$ s kružnicí $(B,|AB|)$; vrchol $D$ doplníme jako čtvrtý vrchol kosočtverce.",
    svg=fig(8, (66, 88, 595, 480)), fn=FN,
    alt="Body A, B a O v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině je dána kružnice $k$ se středem $S$ a body $K$, $L$. Body $K$, $L$ jsou vrcholy rovnoramenného trojúhelníku $KLM$ se základnou $LM$ (viz obrázek).",
         r"Sestrojte rovnoramenný trojúhelník $KLM$, leží-li bod $M$ na kružnici $k$. Nalezněte všechna řešení."],
    solp=[r"Trojúhelník $KLM$ je rovnoramenný se základnou $LM$, tedy ramena $KL=KM$; bod $M$ leží na kružnici $(K,|KL|)$.",
          r"Zároveň $M$ leží na dané kružnici $k$; vrchol $M$ je průsečík obou kružnic — dvě řešení $M_1$, $M_2$."],
    ans=r"Vrchol $M$ je průsečík kružnice $k$ s kružnicí $(K,|KL|)$ (dvě řešení).",
    svg=fig(9, (66, 88, 595, 490)), fn=FN,
    alt="Kružnice k se středem S a body K, L v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 11", pts=2, mins=3, diff="3",
    zad=[r"Hračka stála $250$ korun; nejdříve byla zdražena o $40\ \%$ oproti původní ceně, po měsíci zlevněna o $40\ \%$ z nové ceny. Kolik stála hračka po této dvojí úpravě?"],
    opts=[r"A) $200$ Kč", r"B) $210$ Kč", r"C) $230$ Kč", r"D) $250$ Kč", r"E) $280$ Kč"],
    solp=[r"$250\cdot1{,}4=350$ Kč, poté $350\cdot0{,}6=210$ Kč."],
    ans=r"B) $210$ Kč",
    codes=["zs2", "r9", "procenta", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Velký koláček byl o polovinu dražší než malý a stál $30$ Kč. Velké koláčky pekař prodal všechny a utržil za ně $3\,000$ Kč. Desetinu malých koláčků neprodal a za prodané malé utržil $3\,600$ Kč. Kolik malých koláčků původně přivezl?"],
    opts=[r"A) $100$", r"B) $180$", r"C) $200$", r"D) $240$", r"E) jiný počet"],
    solp=[r"Malý koláček stál $\frac{30}{1{,}5}=20$ Kč; prodaných malých $\frac{3\,600}{20}=180$.",
          r"Prodaných je $\frac{9}{10}$ přivezených, tedy přivezl $180\cdot\frac{10}{9}=200$ koláčků."],
    ans=r"C) $200$",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Přímky $k$, $l$, $m$ leží v rovině; průsečíky přímek $k$, $l$, $m$ tvoří vrcholy trojúhelníku $ABC$. Bodem $B$ prochází také přímka $n$. Jsou vyznačeny úhly $125^\circ$ (u $C$), $105^\circ$ (u $A$) a $90^\circ$ (u $B$) (viz obrázek).",
         r"Jaká je velikost úhlu $\alpha$? (Velikosti neměřte, ale vypočítejte.)"],
    opts=[r"A) $55^\circ$", r"B) $50^\circ$", r"C) $45^\circ$", r"D) $40^\circ$", r"E) $35^\circ$"],
    solp=[r"Vnitřní úhly: při $C$ $180^\circ-125^\circ=55^\circ$, při $A$ $180^\circ-105^\circ=75^\circ$, při $B$ $180^\circ-55^\circ-75^\circ=50^\circ$.",
          r"Úhel $\alpha=90^\circ-50^\circ=40^\circ$."],
    ans=r"D) $40^\circ$",
    svg=fig(11, (66, 90, 595, 400)), fn=FN,
    alt="Přímky k, l, m tvořící trojúhelník ABC a přímka n bodem B; vyznačené úhly 125°, 105° a 90°.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 14", pts=2, mins=4, diff="3",
    zad=[r"Ve čtvercové síti (strana čtverce $2\ \mathrm{cm}$) je zakreslen šedý obrazec — půlkruh s průměrem $AB$, kde $A$, $B$ leží v mřížových bodech a $|AB|=8\ \mathrm{cm}$ (viz obrázek).",
         r"Jaký je obsah šedé části? (Použijte $\pi\doteq3{,}14$.)"],
    opts=[r"A) $20{,}28\ \mathrm{cm}^2$", r"B) $22{,}56\ \mathrm{cm}^2$", r"C) $24{,}56\ \mathrm{cm}^2$", r"D) $25{,}12\ \mathrm{cm}^2$", r"E) $30{,}24\ \mathrm{cm}^2$"],
    solp=[r"Průměr $AB=8\ \mathrm{cm}$, poloměr $4\ \mathrm{cm}$; obsah půlkruhu $\frac{1}{2}\pi\cdot4^2=\frac{1}{2}\cdot3{,}14\cdot16=25{,}12\ \mathrm{cm}^2$."],
    ans=r"D) $25{,}12\ \mathrm{cm}^2$",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 15", pts=3, mins=5, diff="3",
    zad=[r"Žáci 9. ročníku volili svůj nejoblíbenější předmět (každý právě jeden). Z grafu: matematika (M) chlapci $7$, dívky $4$; český jazyk (Čj) chlapci $2$, dívky $6$; angličtina (Aj) chlapci $5$, dívky $8$; tělocvik (Tv) chlapci $7$, dívky $5$; výtvarná (Vv) chlapci $4$, dívky $2$.",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"15.1 V 9. ročníku je stejný počet dívek jako chlapců.",
         r"15.2 Český jazyk volilo více než $16\ \%$ všech žáků.",
         r"15.3 Počet chlapců, kteří volili matematiku, je o $75\ \%$ větší než počet děvčat, která volila matematiku."],
    solp=[r"Chlapců $7+2+5+7+4=25$, dívek $4+6+8+5+2=25$; celkem $50$ žáků.",
          r"15.1: $25=25$ — A.",
          r"15.2: Čj celkem $8$ z $50$, tj. přesně $16\ \%$, nikoli více — N.",
          r"15.3: M chlapci $7$, dívky $4$; $\frac{7-4}{4}=75\ \%$ — A."],
    ans=r"15.1: A; 15.2: N; 15.3: A",
    svg=fig(13, (100, 195, 545, 470)), fn=FN,
    alt="Sloupcový graf nejoblíbenějších předmětů (M, Čj, Aj, Tv, Vv) zvlášť pro chlapce a dívky.",
    cap="",
    codes=["zs2", "r9", "statistika", "procenta", "porozumeni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9B · úloha 16", pts=6, mins=6, diff="3",
    zad=[r"Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).",
         r"16.1 Lyžařský pobyt stál $7\,000$ Kč (doprava, ubytování, lístek na vlek). Doprava tvořila desetinu ceny, ubytování $60\ \%$. Kolik procent tvořila cena lístku na vlek?",
         r"16.2 Cena učebnice se snížila na $1\,500$ Kč z původních $2\,000$ Kč. Kolik procent činila sleva?",
         r"16.3 Dárek stál $40$ EUR, celkem bylo vyměněno $200$ EUR. Kolik procent z vyměněných EUR tvořila cena dárku?"],
    opts=[r"A) $15\ \%$", r"B) $20\ \%$", r"C) $25\ \%$", r"D) $30\ \%$", r"E) $40\ \%$", r"F) jiný výsledek"],
    solp=[r"16.1: $100\ \%-10\ \%-60\ \%=30\ \%$ — D.",
          r"16.2: $\frac{2\,000-1\,500}{2\,000}=25\ \%$ — C.",
          r"16.3: $\frac{40}{200}=20\ \%$ — B."],
    ans=r"16.1: D ($30\ \%$); 16.2: C ($25\ \%$); 16.3: B ($20\ \%$)",
    codes=["zs2", "r9", "procenta", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9B-2024")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
