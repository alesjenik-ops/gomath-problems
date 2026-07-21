# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9A 2023 (1. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9A_2023_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2023, 1. řádný termín (M9A)"
CCODE = "M9PAD23C0T01"
YR = 2023
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2023 M9A · úloha 1", pts=1, mins=2, diff="3",
    zad=[r"Celý film trvá $1$ hodinu. Doba, která ještě zbývá do konce filmu, je polovinou doby, která již uplynula od začátku filmu.",
         r"Vypočtěte, kolik minut zbývá do konce filmu."],
    solp=[r"Uplynulá doba $e$, zbývající $\frac{e}{2}$; $e+\frac{e}{2}=60\Rightarrow \frac{3}{2}e=60\Rightarrow e=40$.",
          r"Zbývá $\frac{40}{2}=20$ minut."],
    ans=r"$20$ minut",
    codes=["zs2", "r9", "aritmetika", "rovnice", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 2", pts=3, mins=5, diff="3",
    zad=[r"2.1 Vnitřní objem sudu je $15$krát větší než objem kbelíku, objem kbelíku je $5$krát větší než objem konvičky. Ze sudu plného vody jsme třetinu vody odebrali, takže v něm zbylo $60$ litrů. Vypočtěte v litrech objem konvičky.",
         r"2.2 Kvádr je možné beze zbytku rozřezat na $200$ krychlí, z nichž každá má objem $8\ \mathrm{dm}^3$. Vypočtěte, na kolik krychliček o objemu $1\ \mathrm{cm}^3$ lze tento kvádr beze zbytku rozřezat."],
    solp=[r"2.1: v sudu zbyly $\frac{2}{3}$ objemu $=60$ l, tedy sud $90$ l; kbelík $\frac{90}{15}=6$ l; konvička $\frac{6}{5}=1{,}2$ litru.",
          r"2.2: objem kvádru $200\cdot8=1\,600\ \mathrm{dm}^3=1\,600\,000\ \mathrm{cm}^3$, tj. $1\,600\,000$ krychliček."],
    ans=r"2.1: $1{,}2$ litru; 2.2: $1\,600\,000$ krychliček",
    codes=["zs2", "r9", "aritmetika", "stereometrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{5}{9}-\dfrac{5}{9}:5=$",
         r"3.2 \quad $\dfrac{4-7}{8}\cdot\dfrac{16}{21}=$",
         r"3.3 \quad $\dfrac{\frac{3}{5}:\left(\frac{2}{5}+\frac{1}{2}\right)}{\frac{7}{6}+\frac{7}{10}}=$"],
    solp=[r"3.1: $\frac{5}{9}-\frac{1}{9}=\frac{4}{9}$.",
          r"3.2: $-\frac{3}{8}\cdot\frac{16}{21}=-\frac{2}{7}$.",
          r"3.3: čitatel $\frac{3}{5}:\frac{9}{10}=\frac{2}{3}$; jmenovatel $\frac{7}{6}+\frac{7}{10}=\frac{28}{15}$; $\frac{2}{3}:\frac{28}{15}=\frac{5}{14}$."],
    ans=r"3.1: $\frac{4}{9}$; 3.2: $-\frac{2}{7}$; 3.3: $\frac{5}{14}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 4", pts=4, mins=5, diff="3",
    zad=[r"4.1 Upravte a rozložte na součin vytknutím: $2\cdot(x^2-x)+x=$",
         r"4.2 Umocněte a zjednodušte: $\left(\dfrac{2}{3}a-3\right)^2=$",
         r"4.3 Zjednodušte (bez závorek): $3n\cdot(2-n+2n)+(2n+1)\cdot(7-n)=$"],
    solp=[r"4.1: $2x^2-2x+x=2x^2-x=x\cdot(2x-1)$.",
          r"4.2: $\frac{4}{9}a^2-4a+9$.",
          r"4.3: $3n(2+n)+(2n+1)(7-n)=6n+3n^2+14n-2n^2+7-n=n^2+19n+7$."],
    ans=r"4.1: $x\cdot(2x-1)$; 4.2: $\frac{4}{9}a^2-4a+9$; 4.3: $n^2+19n+7$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnice.",
         r"5.1 \quad $0{,}5x+2\cdot(x+2{,}5)=2{,}5\cdot(x+3)$",
         r"5.2 \quad $\dfrac{y+10}{15}+\dfrac{2y}{5}=1-\dfrac{5-y}{3}$"],
    solp=[r"5.1: $0{,}5x+2x+5=2{,}5x+7{,}5\Rightarrow 2{,}5x+5=2{,}5x+7{,}5\Rightarrow 5=7{,}5$; rovnice nemá řešení.",
          r"5.2: vynásobením $15$: $(y+10)+6y=15-5(5-y)\Rightarrow 7y+10=5y-10\Rightarrow 2y=-20\Rightarrow y=-10$."],
    ans=r"5.1: rovnice nemá řešení; 5.2: $y=-10$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 6", pts=2, mins=4, diff="3",
    zad=[r"Pravoúhlý lichoběžník $ABCD$ se základnami $AB$, $CD$ má pravý úhel při vrcholu $C$. Z obrázku: $CD=10\ \mathrm{cm}$, $AB=6\ \mathrm{cm}$, boční strana $BC=8\ \mathrm{cm}$ (viz obrázek).",
         r"6.1 Vypočtěte v $\mathrm{cm}^2$ obsah trojúhelníku $ABD$.",
         r"6.2 Vypočtěte v $\mathrm{cm}^2$ obsah lichoběžníku $ABCD$."],
    solp=[r"Výška lichoběžníku je $BC=8\ \mathrm{cm}$.",
          r"6.1: trojúhelník $ABD$ má základnu $AB=6$ a výšku $8$; $S=\frac{6\cdot8}{2}=24\ \mathrm{cm}^2$.",
          r"6.2: $S=\frac{6+10}{2}\cdot8=64\ \mathrm{cm}^2$."],
    ans=r"6.1: $24\ \mathrm{cm}^2$; 6.2: $64\ \mathrm{cm}^2$",
    svg=fig(3, (300, 450, 595, 625)), fn=FN,
    alt="Pravoúhlý lichoběžník ABCD se základnami AB=6 cm, CD=10 cm a boční stranou BC=8 cm; pravý úhel při vrcholu C.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 7", pts=3, mins=5, diff="4",
    zad=[r"Pro žáky 8. a 9. tříd byly otevřeny tři kroužky (hudební, šachový, robotický); každý žák je nejvýše v jednom. V grafu jsou počty žáků (jeden údaj a čísla na svislé ose chybí). V hudebním je o $6$ žáků méně než v šachovém. Ve všech třech kroužcích dohromady je poměr počtu žáků 8. tříd ku počtu žáků 9. tříd $2:3$.",
         r"7.1 Určete, o kolik procent více je v hudebním kroužku žáků 8. tříd než žáků 9. tříd.",
         r"7.2 Určete, kolik žáků 9. tříd je v šachovém kroužku.",
         r"7.3 Určete, jaký je v robotickém kroužku poměr počtu žáků 8. tříd ku počtu žáků 9. tříd."],
    solp=[r"Z grafu a podmínek (hudební o $6$ méně než šachový; celkový poměr $2:3$) se dopočtou chybějící hodnoty.",
          r"7.1: v hudebním kroužku je žáků 8. tříd o $25\ \%$ více než žáků 9. tříd.",
          r"7.2: žáků 9. tříd v šachovém kroužku je $21$.",
          r"7.3: v robotickém kroužku je poměr $3:7$."],
    ans=r"7.1: o $25\ \%$; 7.2: $21$ žáků; 7.3: $3:7$",
    codes=["zs2", "r9", "statistika", "procenta", "argumentace", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 8", pts=4, mins=6, diff="4",
    zad=[r"Čtvercový pozemek má stejný obvod jako obdélníkový pozemek. Obdélníkový pozemek má jednu stranu o $25\ \%$ kratší než strana čtvercového pozemku a druhou stranu o $10\ \mathrm{m}$ delší než strana čtvercového pozemku. Délku strany čtvercového pozemku označíme $a$.",
         r"8.1 Vyjádřete výrazem s proměnnou $a$ délku kratší strany obdélníkového pozemku.",
         r"8.2 Vypočtěte v metrech délku $a$ strany čtvercového pozemku.",
         r"8.3 Vypočtěte, o kolik $\mathrm{m}^2$ se liší obsahy obdélníkového a čtvercového pozemku."],
    solp=[r"8.1: kratší strana obdélníku $=0{,}75a$ (o $25\ \%$ kratší).",
          r"8.2: stejný obvod: $4a=2\big(0{,}75a+(a+10)\big)\Rightarrow 4a=3{,}5a+20\Rightarrow a=40\ \mathrm{m}$.",
          r"8.3: čtverec $40^2=1\,600$; obdélník $0{,}75\cdot40\cdot(40+10)=30\cdot50=1\,500$; rozdíl $100\ \mathrm{m}^2$."],
    ans=r"8.1: $0{,}75a$; 8.2: $a=40\ \mathrm{m}$; 8.3: o $100\ \mathrm{m}^2$",
    codes=["zs2", "r9", "vyrazy", "rovnice", "geometrie", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 9", pts=2, mins=5, diff="4",
    zad=[r"V rovině leží body $A$, $C$, $M$. Body $A$, $C$ jsou vrcholy obdélníku $ABCD$, bod $M$ leží na úhlopříčce $BD$ (viz obrázek).",
         r"Sestrojte vrcholy $B$, $D$ obdélníku $ABCD$, označte je a obdélník narýsujte."],
    solp=[r"Úhlopříčka $AC$ má střed $S$; obě úhlopříčky obdélníku se půlí a jsou stejně dlouhé, takže $B$, $D$ leží na kružnici se středem $S$ a poloměrem $|SA|$.",
          r"Úhlopříčka $BD$ prochází středem $S$ a bodem $M$; její průsečíky s kružnicí $(S,|SA|)$ jsou vrcholy $B$ a $D$."],
    ans=r"Střed $S$ úhlopříčky $AC$; přímka $SM$ (úhlopříčka $BD$) protne kružnici $(S,|SA|)$ ve vrcholech $B$ a $D$.",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $A$, $P$ a kružnice $k$ se středem $S$. Bod $A$ je vrchol rovnoramenného trojúhelníku $ABC$, jehož základna leží na přímce $AP$; vrcholy $B$, $C$ leží na kružnici $k$ (viz obrázek).",
         r"Sestrojte vrcholy $B$, $C$ trojúhelníku $ABC$, označte je a trojúhelník narýsujte. Najděte všechna řešení."],
    solp=[r"Základna $BC$ leží na přímce $AP$? Nikoli — základna trojúhelníku leží na přímce procházející $A$; body $B$, $C$ jsou průsečíky této přímky s kružnicí $k$.",
          r"Trojúhelník je rovnoramenný (rameno $AB=AC$), takže $A$ leží na ose tětivy $BC$; odtud se sestrojí přímka $BC$ a její průsečíky s $k$."],
    ans=r"Body $B$, $C$ jsou průsečíky kružnice $k$ s přímkou (základnou) procházející $A$ tak, aby $AB=AC$ (rovnoramenný trojúhelník; více řešení).",
    svg=fig(6, (66, 88, 595, 410)), fn=FN,
    alt="Body A, P a kružnice k se středem S v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 11", pts=4, mins=5, diff="3",
    zad=[r"Na turistické mapě odpovídá každých $3{,}5\ \mathrm{cm}$ vzdálenosti $700\ \mathrm{m}$ ve skutečnosti. Délka vycházkové trasy je $6\ \mathrm{km}$, což je trojnásobek délky přímé trasy.",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"11.1 Trasa, která na mapě měří $49\ \mathrm{mm}$, je ve skutečnosti delší než $1\ \mathrm{km}$.",
         r"11.2 Na mapě je vycházková trasa o $20\ \mathrm{cm}$ delší než přímá trasa.",
         r"11.3 Měřítko turistické mapy je $1:200\,000$."],
    solp=[r"Měřítko: $3{,}5\ \mathrm{cm}$ na mapě $=700\ \mathrm{m}=70\,000\ \mathrm{cm}$, tedy $1:20\,000$.",
          r"11.1: $49\ \mathrm{mm}=4{,}9\ \mathrm{cm}$ je $\frac{4{,}9}{3{,}5}\cdot700=980\ \mathrm{m}<1\ \mathrm{km}$ — N.",
          r"11.2: vycházková $6\ \mathrm{km}$ je na mapě $30\ \mathrm{cm}$, přímá $2\ \mathrm{km}$ je $10\ \mathrm{cm}$; rozdíl $20\ \mathrm{cm}$ — A.",
          r"11.3: měřítko je $1:20\,000$, nikoli $1:200\,000$ — N."],
    ans=r"11.1: N; 11.2: A; 11.3: N",
    codes=["zs2", "r9", "pomer", "procenta", "argumentace", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Vnitřní prostor haly má tvar kvádru $ABCDEFGH$ s výškou $6\ \mathrm{m}$ a délkou $15\ \mathrm{m}$. Uvnitř je vyznačena uzavřená lomená čára $ACFHA$ (po podlaze, stropě a dvou stěnách). Úhlopříčka na podlaze $AC$ měří $17\ \mathrm{m}$ (viz obrázek).",
         r"Jaká je délka lomené čáry $ACFHA$?"],
    opts=[r"A) $46\ \mathrm{m}$", r"B) $50\ \mathrm{m}$", r"C) $54\ \mathrm{m}$", r"D) $68\ \mathrm{m}$", r"E) jiná délka"],
    solp=[r"Šířka haly: $AC^2=15^2+\text{š}^2\Rightarrow 17^2=225+\text{š}^2\Rightarrow \text{š}=8\ \mathrm{m}$.",
          r"$AC=17$, $CF=\sqrt{8^2+6^2}=10$, $FH=17$, $HA=\sqrt{8^2+6^2}=10$; délka $17+10+17+10=54\ \mathrm{m}$."],
    ans=r"C) $54\ \mathrm{m}$",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Obsah pláště rotačního válce je třikrát větší než obsah jedné podstavy. Poloměr podstavy je $10\ \mathrm{cm}$.",
         r"Jaký je povrch válce? (Zaokrouhleno na desítky $\mathrm{cm}^2$, $\pi\doteq3{,}14$.)"],
    opts=[r"A) menší než $930\ \mathrm{cm}^2$", r"B) $940\ \mathrm{cm}^2$", r"C) $1\,260\ \mathrm{cm}^2$", r"D) $1\,570\ \mathrm{cm}^2$", r"E) větší než $1\,580\ \mathrm{cm}^2$"],
    solp=[r"Plášť $=3\times$ podstava: $2\pi r v=3\pi r^2\Rightarrow v=\frac{3r}{2}=15\ \mathrm{cm}$.",
          r"Povrch $=2\pi r^2+3\pi r^2=5\pi r^2=5\pi\cdot100=500\pi\doteq1\,570\ \mathrm{cm}^2$."],
    ans=r"D) $1\,570\ \mathrm{cm}^2$",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 14", pts=2, mins=4, diff="4",
    zad=[r"V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné. V obrázku jsou vyznačeny úhly $4\alpha$, $4\alpha$, $2\alpha$ a hledaný úhel $\beta$ (viz obrázek).",
         r"Jaká je velikost úhlu $\beta$? (Velikosti neměřte, ale vypočtěte.)"],
    opts=[r"A) $100^\circ$", r"B) $108^\circ$", r"C) $116^\circ$", r"D) $120^\circ$", r"E) jiná velikost"],
    solp=[r"Z rovnoběžnosti dvou přímek a vztahů mezi vyznačenými úhly ($4\alpha$, $4\alpha$, $2\alpha$) se určí $\alpha$ a dopočte $\beta=108^\circ$."],
    ans=r"B) $108^\circ$",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 15", pts=6, mins=6, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 V roce 2020 firma vyrobila $250$ výrobků; v letech 2021 a 2022 vždy o $20\ \%$ více než v předchozím roce. Kolik výrobků vyrobila v roce 2022?",
         r"15.2 Roman ujel $400\ \mathrm{km}$, což bylo o čtvrtinu více, než ujela Jana. Kolik km ujela Jana?",
         r"15.3 Firma měla na konci krize o $40\ \%$ méně zaměstnanců než před krizí; po přijetí $42$ nových jich měla o $25\ \%$ více než na konci krize. Kolik zaměstnanců měla před krizí?"],
    opts=[r"A) $280$", r"B) $300$", r"C) $320$", r"D) $350$", r"E) $360$", r"F) jiný počet"],
    solp=[r"15.1: $250\cdot1{,}2\cdot1{,}2=360$ — E.",
          r"15.2: $\frac{400}{1{,}25}=320\ \mathrm{km}$ — C.",
          r"15.3: před krizí $P$, na konci $0{,}6P$; $0{,}6P+42=1{,}25\cdot0{,}6P\Rightarrow 42=0{,}15P\Rightarrow P=280$ — A."],
    ans=r"15.1: E ($360$); 15.2: C ($320$); 15.3: A ($280$)",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9A · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Prvním obrazcem je bílý rovnostranný trojúhelník. Každý další obrazec vznikne tak, že každý bílý trojúhelník rozdělíme na $4$ shodné rovnostranné trojúhelníky a vnitřní z nich obarvíme na šedo (viz obrázek).",
         r"16.1 Určete, kolik bílých trojúhelníků obsahuje pátý obrazec.",
         r"16.2 Šestý obrazec obsahuje $121$ šedých trojúhelníků. Určete, kolik šedých trojúhelníků obsahuje sedmý obrazec.",
         r"16.3 Počet šedých trojúhelníků v posledním a předposledním obrazci se liší o $6\,561$. Určete, kolik bílých trojúhelníků obsahuje poslední obrazec."],
    solp=[r"Počet bílých trojúhelníků v $n$-tém obrazci je $3^{n-1}$; každým krokem přibude tolik šedých, kolik bylo bílých v předchozím obrazci ($3^{n-2}$).",
          r"16.1: $3^4=81$ bílých trojúhelníků.",
          r"16.2: přibude $3^5=243$ šedých, tedy $121+243=364$ šedých trojúhelníků.",
          r"16.3: rozdíl je $3^{n-2}=6\,561=3^8\Rightarrow n=10$; bílých je $3^9=19\,683$."],
    ans=r"16.1: $81$ bílých trojúhelníků; 16.2: $364$ šedých trojúhelníků; 16.3: $19\,683$ bílých trojúhelníků",
    svg=fig(10, (66, 118, 500, 240)), fn=FN,
    alt="Posloupnost obrazců Sierpińského trojúhelníku (1., 2. a 3. obrazec) z bílých a šedých rovnostranných trojúhelníků.",
    cap="",
    codes=["zs2", "r9", "posloupnosti", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9A-2023")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
