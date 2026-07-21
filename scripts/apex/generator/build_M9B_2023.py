# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9B 2023 (2. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9B_2023_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2023, 2. řádný termín (M9B)"
CCODE = "M9PBD23C0T02"
YR = 2023
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2023 M9B · úloha 1", pts=1, mins=2, diff="3",
    zad=[r"Vypočtěte: $\sqrt{(-5)^2}-3^2=$"],
    solp=[r"$\sqrt{25}-9=5-9=-4$."],
    ans=r"$-4$",
    codes=["zs2", "r9", "mocniny-odmocniny", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 2", pts=2, mins=3, diff="3",
    zad=[r"Třídenní lyžařská permanentka je o $150\ \%$ dražší než jednodenní; jednodenní stojí $600$ korun.",
         r"2.1 Kolikrát více se zaplatí za třídenní permanentku než za jednodenní?",
         r"2.2 O kolik korun jsou $3$ jednodenní permanentky dražší než $1$ třídenní?"],
    solp=[r"Třídenní $=600\cdot(1+1{,}5)=600\cdot2{,}5=1\,500$ korun.",
          r"2.1: $2{,}5$krát více.",
          r"2.2: $3\cdot600-1\,500=1\,800-1\,500=300$ korun."],
    ans=r"2.1: $2{,}5$krát; 2.2: o $300$ korun",
    codes=["zs2", "r9", "procenta", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{1}{3}\cdot\dfrac{1}{2}-\dfrac{8}{9}=$",
         r"3.2 \quad $\left(2-\dfrac{5}{6}\right):\dfrac{5}{3}=$",
         r"3.3 \quad $\dfrac{\frac{2}{3}+\frac{2}{7}}{\left(\frac{9}{14}+\frac{3}{2}\right)\cdot2}=$"],
    solp=[r"3.1: $\frac{1}{6}-\frac{8}{9}=\frac{3}{18}-\frac{16}{18}=-\frac{13}{18}$.",
          r"3.2: $\frac{7}{6}:\frac{5}{3}=\frac{7}{6}\cdot\frac{3}{5}=\frac{7}{10}$.",
          r"3.3: čitatel $\frac{2}{3}+\frac{2}{7}=\frac{20}{21}$; jmenovatel $\left(\frac{9}{14}+\frac{21}{14}\right)\cdot2=\frac{30}{7}$; $\frac{20}{21}:\frac{30}{7}=\frac{2}{9}$."],
    ans=r"3.1: $-\frac{13}{18}$; 3.2: $\frac{7}{10}$; 3.3: $\frac{2}{9}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 4", pts=4, mins=5, diff="3",
    zad=[r"4.1 Upravte a rozložte na součin vytknutím: $x\cdot(y-3)+3\cdot(x-2y)=$",
         r"4.2 Určete výraz, kterým je třeba vynásobit výraz $3a-4$, abychom získali $9a^2-16$.",
         r"4.3 Zjednodušte (bez závorek): $(3n+2)^2-n\cdot(3n+4)+(2n-n)\cdot n=$"],
    solp=[r"4.1: $xy-3x+3x-6y=xy-6y=y\cdot(x-6)$.",
          r"4.2: $9a^2-16=(3a-4)(3a+4)$, tedy hledaný výraz je $3a+4$.",
          r"4.3: $(9n^2+12n+4)-(3n^2+4n)+n^2=7n^2+8n+4$."],
    ans=r"4.1: $y\cdot(x-6)$; 4.2: $3a+4$; 4.3: $7n^2+8n+4$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $2+0{,}5\cdot(x-3)=0{,}4\cdot(1{,}5x+2)$",
         r"5.2 \quad $\dfrac{3\cdot(2y-1)}{6}=\dfrac{3y+2}{8}+\dfrac{3}{4}\cdot\dfrac{y-1}{6}$"],
    solp=[r"5.1: $2+0{,}5x-1{,}5=0{,}6x+0{,}8\Rightarrow 0{,}5x+0{,}5=0{,}6x+0{,}8\Rightarrow -0{,}3=0{,}1x\Rightarrow x=-3$.",
          r"5.2: úpravou obou stran (společný jmenovatel) vychází $y=\frac{5}{4}$."],
    ans=r"5.1: $x=-3$; 5.2: $y=\frac{5}{4}$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 6", pts=4, mins=6, diff="4",
    zad=[r"V chatě jsou zásoby masa pro $12$člennou expedici přesně na $30$ dní (každý člen spotřebuje denně stejné množství).",
         r"6.1 Za kolik dní by $12$členná expedice spotřebovala pět šestin zásob?",
         r"6.2 Kolikačlenná expedice by všechny zásoby spotřebovala za $45$ dní?",
         r"6.3 Dvě expedice společně spotřebovaly vše: první pobývala $4$ dny, druhá měla dvakrát více členů a pobývala $8$ dní. Kolik členů měla první expedice?"],
    solp=[r"Celkem $12\cdot30=360$ členodní zásob.",
          r"6.1: $\frac{5}{6}\cdot30=25$ dní.",
          r"6.2: $\frac{360}{45}=8$členná expedice.",
          r"6.3: první $c$ členů: $c\cdot4+2c\cdot8=20c=360\Rightarrow c=18$ členů (druhá $36$)."],
    ans=r"6.1: za $25$ dní; 6.2: $8$členná; 6.3: $18$ členů",
    codes=["zs2", "r9", "aritmetika", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 7", pts=3, mins=5, diff="3",
    zad=[r"Cesta autobusem trvá Ondrovi dvakrát déle než rychlíkem; osobním vlakem o čtvrtinu déle než autobusem. Dobu cesty autobusem označíme $x$.",
         r"7.1 Vyjádřete výrazem, jak dlouho trvá cesta rychlíkem.",
         r"7.2 Vyjádřete výrazem, jak dlouho trvá cesta osobním vlakem.",
         r"7.3 Rychlíkem trvá cesta o $15$ minut méně než osobním vlakem. Kolik minut trvá cesta autobusem?"],
    solp=[r"7.1: rychlík $\frac{x}{2}$.",
          r"7.2: osobní vlak $\frac{5}{4}x$.",
          r"7.3: $\frac{5}{4}x-\frac{x}{2}=\frac{3}{4}x=15\Rightarrow x=20$ minut."],
    ans=r"7.1: $\frac{1}{2}x$; 7.2: $\frac{5}{4}x$; 7.3: $20$ minut",
    codes=["zs2", "r9", "vyrazy", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 8", pts=3, mins=5, diff="4",
    zad=[r"Dort tvaru rotačního válce leží na kruhovém tácu; svislým řezem byl rozdělen na dvě poloviny.",
         r"8.1 Tác má tvar kruhu o průměru $d$ a obsahu $\pi\cdot144\ \mathrm{cm}^2$. Vypočtěte v cm průměr $d$ tácu.",
         r"8.2 Plocha řezu dortu má obsah $200\ \mathrm{cm}^2$ a tvoří ji obdélník, který lze rozdělit na dva čtverce. Vypočtěte v $\mathrm{cm}^3$ objem celého dortu (zaokrouhlete na desítky)."],
    solp=[r"8.1: $\pi r^2=\pi\cdot144\Rightarrow r=12$, průměr $d=24\ \mathrm{cm}$.",
          r"8.2: řez je obdélník ze dvou čtverců o straně $s$: $2s^2=200\Rightarrow s=10$; průměr dortu $2s=20$, výška $s=10$; objem $\pi\cdot10^2\cdot10=1\,000\pi\doteq3\,140\ \mathrm{cm}^3$."],
    ans=r"8.1: $24\ \mathrm{cm}$; 8.2: $3\,140\ \mathrm{cm}^3$",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 9", pts=2, mins=5, diff="4",
    zad=[r"V rovině leží úsečka $AB$ a bod $S$. Úsečka $AB$ je základna rovnoramenného lichoběžníku $ABCD$; bod $S$ je střed ramene $AD$ (viz obrázek).",
         r"Sestrojte vrcholy $C$, $D$ lichoběžníku $ABCD$, označte je a lichoběžník narýsujte."],
    solp=[r"Rovnoramenný lichoběžník má osu souměrnosti kolmou na $AB$ v jeho středu. Vrchol $D$ leží na polopřímce $AS$ tak, že $S$ je střed $AD$, tedy $D$ je obraz $A$ ve středové souměrnosti podle $S$.",
          r"Vrchol $C$ je obraz $D$ v osové souměrnosti podle osy úsečky $AB$."],
    ans=r"Vrchol $D$ je obraz $A$ podle středu $S$; vrchol $C$ je obraz $D$ v osové souměrnosti podle osy $AB$ (rovnoramenný lichoběžník).",
    svg=fig(5, (66, 88, 595, 420)), fn=FN,
    alt="Úsečka AB a bod S v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $C$, $Q$ a kružnice $k$ se středem $S$, procházející bodem $C$. Bod $C$ je vrchol trojúhelníku $ABC$ s pravým úhlem při vrcholu $C$; vrcholy $A$, $B$ leží na kružnici $k$ a bodem $Q$ prochází jedna strana trojúhelníku (viz obrázek).",
         r"Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je a trojúhelník narýsujte. Najděte všechna řešení."],
    solp=[r"Pravý úhel u $C$ znamená, že přepona $AB$ je průměrem kružnice $k$ (Thaletova věta), tedy $AB$ prochází středem $S$.",
          r"Přímka $AB$ prochází body $S$ a $Q$; její průsečíky s kružnicí $k$ jsou vrcholy $A$, $B$ (dvě řešení podle označení)."],
    ans=r"Přepona $AB$ je průměr kružnice $k$ (Thaletova věta), leží na přímce $SQ$; $A$, $B$ jsou průsečíky přímky $SQ$ s $k$.",
    svg=fig(6, (66, 88, 595, 420)), fn=FN,
    alt="Body C, Q a kružnice k se středem S procházející bodem C.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 11", pts=4, mins=5, diff="3",
    zad=[r"Obdélník se stranami $8\ \mathrm{cm}$ a $3\ \mathrm{cm}$ se skládá ze čtyř shodných trojúhelníků; jejich přemístěním vznikl kosočtverec (viz obrázek).",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"11.1 Obsah kosočtverce je větší než obsah obdélníku.",
         r"11.2 Strana kosočtverce měří $5\ \mathrm{cm}$.",
         r"11.3 Výška kosočtverce měří $4{,}8\ \mathrm{cm}$."],
    solp=[r"Obsah obdélníku $=8\cdot3=24\ \mathrm{cm}^2$; kosočtverec vznikl přemístěním týchž trojúhelníků, obsah zůstává $24\ \mathrm{cm}^2$.",
          r"11.1: obsahy jsou stejné — N.",
          r"11.2: strana kosočtverce je přepona trojúhelníku s odvěsnami $4$ a $3$: $\sqrt{4^2+3^2}=5\ \mathrm{cm}$ — A.",
          r"11.3: výška $=\frac{24}{5}=4{,}8\ \mathrm{cm}$ — A."],
    ans=r"11.1: N; 11.2: A; 11.3: A",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"V rovině leží rovnoramenný trojúhelník $ABC$ se základnou $AB$. Bod $S$ je střed základny $AB$ a prochází jím rovnoběžka s přímkou $AC$; v obrázku jsou vyznačeny úhly $\varphi$ a $\omega$ (viz obrázek).",
         r"Jaký je součet $\varphi+\omega$? (Velikosti neměřte, ale vypočtěte.)"],
    opts=[r"A) $150^\circ$", r"B) $155^\circ$", r"C) $160^\circ$", r"D) $165^\circ$", r"E) jiná velikost"],
    solp=[r"Z rovnoramennosti trojúhelníku a rovnoběžnosti přímky vedené bodem $S$ s ramenem $AC$ se dopočtou úhly $\varphi$ a $\omega$; jejich součet neodpovídá žádné z hodnot A–D."],
    ans=r"E) jiná velikost",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Trojboký hranol leží na jedné boční stěně. Podstavu tvoří rovnoramenný trojúhelník se základnou $24\ \mathrm{cm}$ a obsahem $60\ \mathrm{cm}^2$. Výška $v$ na základnu tohoto trojúhelníku je stejná jako délka nejkratší hrany hranolu (viz obrázek).",
         r"Jaký je objem trojbokého hranolu?"],
    opts=[r"A) $150\ \mathrm{cm}^3$", r"B) $200\ \mathrm{cm}^3$", r"C) $300\ \mathrm{cm}^3$", r"D) $370\ \mathrm{cm}^3$", r"E) jiný objem"],
    solp=[r"Výška na základnu: $\frac{24\cdot v}{2}=60\Rightarrow v=5\ \mathrm{cm}$; nejkratší hrana (délka hranolu) je také $5\ \mathrm{cm}$.",
          r"Objem $=$ obsah podstavy $\times$ délka $=60\cdot5=300\ \mathrm{cm}^3$."],
    ans=r"C) $300\ \mathrm{cm}^3$",
    svg=fig(8, (300, 70, 595, 175)), fn=FN,
    alt="Trojboký hranol s podstavou tvaru rovnoramenného trojúhelníku (základna 24 cm) a vyznačenou výškou v.",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 14", pts=2, mins=4, diff="3",
    zad=[r"Košíkář prodal během prvních dvou dnů trhů všechny upletené pomlázky. První den prodal pětinu všech, druhý den o $180$ pomlázek více než první den.",
         r"Kolik pomlázek prodal košíkář první den?"],
    opts=[r"A) $60$ pomlázek", r"B) $45$ pomlázek", r"C) $36$ pomlázek", r"D) $30$ pomlázek", r"E) jiný počet pomlázek"],
    solp=[r"Nechť je všech $N$ pomlázek: první den $\frac{N}{5}$, druhý $\frac{N}{5}+180$; $\frac{N}{5}+\frac{N}{5}+180=N\Rightarrow \frac{3N}{5}=180\Rightarrow N=300$.",
          r"První den $\frac{300}{5}=60$ pomlázek."],
    ans=r"A) $60$ pomlázek",
    codes=["zs2", "r9", "zlomky", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 15", pts=6, mins=6, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Skautský oddíl má letos $60$ členů, což je o $20$ členů více než loni. O kolik procent má letos více členů než loni?",
         r"15.2 Jakub utratil tři pětiny kapesného; tři čtvrtiny této utracené částky použil na turistickou známku. Kolik procent kapesného utratil za známku?",
         r"15.3 První a druhý den festivalu se prodal stejný počet vstupenek; třetí den o třetinu více než druhý den. Kolik procent všech vstupenek se prodalo třetí den?"],
    opts=[r"A) méně než $40\ \%$", r"B) $40\ \%$", r"C) $45\ \%$", r"D) $50\ \%$", r"E) $55\ \%$", r"F) více než $55\ \%$"],
    solp=[r"15.1: $\frac{20}{40}=50\ \%$ — D.",
          r"15.2: $\frac{3}{4}\cdot\frac{3}{5}=\frac{9}{20}=45\ \%$ — C.",
          r"15.3: den $1=$ den $2=x$, den $3=\frac{4}{3}x$; podíl $\frac{\frac{4}{3}x}{\frac{10}{3}x}=\frac{4}{10}=40\ \%$ — B."],
    ans=r"15.1: D ($50\ \%$); 15.2: C ($45\ \%$); 15.3: B ($40\ \%$)",
    codes=["zs2", "r9", "procenta", "zlomky", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9B · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Vybarvováním polí čtvercové sítě vytváříme obrazce. Prvním obrazcem je jedno světle vybarvené pole. Každý další obrazec vytvoříme vybarvením všech prázdných polí, která mají s předchozím obrazcem společné pouze vrcholy; nová pole jsou u sudých obrazců tmavá a u lichých světlá. (Druhý obrazec $+4$ tmavá, třetí $+8$ světlá; třetí má $9$ světlých a $4$ tmavá pole.)",
         r"16.1 Vybarvením kolika dalších polí jsme z $8.$ obrazce vytvořili $9.$ obrazec?",
         r"16.2 O kolik se liší počet tmavých a světlých polí v $10.$ obrazci?",
         r"16.3 Kolik světlých polí může mít obrazec, který má $400$ tmavých polí? (Najděte všechna řešení.)"],
    solp=[r"Do $n$-tého obrazce ($n\ge2$) přibude $4(n-1)$ polí. Světlých polí je v $n$-tém obrazci (pro liché $n$) $n^2$, tmavých (pro sudé $n$) $n^2$.",
          r"16.1: $4\cdot8=32$ polí.",
          r"16.2: v $10.$ obrazci tmavých $100$, světlých $81$; rozdíl $19$.",
          r"16.3: $400=20^2$ tmavých má obrazec $20.$ (světlých $19^2=361$) i obrazec $21.$ (světlých $21^2=441$), tedy $361$ nebo $441$ světlých polí."],
    ans=r"16.1: $32$ polí; 16.2: o $19$; 16.3: $361$ nebo $441$ světlých polí",
    svg=fig(10, (66, 118, 470, 260)), fn=FN,
    alt="Posloupnost obrazců vytvářených vybarvováním polí čtvercové sítě (1., 2. a 3. obrazec) tmavými a světlými poli.",
    cap="",
    codes=["zs2", "r9", "posloupnosti", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9B-2023")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
